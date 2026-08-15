Received: from out-2z4y-a133.jellyfish.systems (out-2z4y-a133.jellyfish.systems [198.54.127.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C7F1A5BAE
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 04:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786766631; cv=none; b=ncx8cazNfGfllWs0pTUzqFxm4yLUfKd2PgnvV+yUMR9CYF28Y1o9zumIVKLe15lincqagt6cX4ePKttznl8IV2ggVY71pciwIUCJSoNcHbGYdcmxz5Nx7cTSvUnus7T1cWPuuhQW9GYpW/0VwcbL1lVOVHcHEWizY1WcIh70Tyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786766631; c=relaxed/simple;
	bh=j2L20HA/mXZnb77nZmAi2TZ8QCYorDhYrYS/xT/HHcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KjpzO9c1k+DLNGPY7KQiyEXJZ0UVQSVyWNhu5SJgVmbtuHF/pH3RT109B2xIV1/HJ+4Z7oH1V+UlEylm3cT2IKzS3WRn4lGdQnf0Gq6DKg9sKeZHOdSKOvIL71V0HMTGFG9cuVc/0i9z7izFjLoK0+BMMUkGm/OQFO9gRITN+20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.127.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hMQSB4brgz8sWQ;
	Sat, 15 Aug 2026 04:03:22 +0000 (UTC)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Alex Elder <elder@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Luca Weiss <luca.weiss@fairphone.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	stable@vger.kernel.org
Subject: [PATCH net] net: ipa: fix stalled modem TX queue after runtime resume
Date: Sat, 15 Aug 2026 06:03:02 +0200
Message-ID: <20260815040302.653650-1-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: jorijnvdgraaf@catcrafts.net

ipa_start_xmit() unconditionally stops the TX queue before calling
pm_runtime_get(), relying on the wake scheduled by runtime resume
(ipa_modem_wake_queue_work()) to restart it once power is ACTIVE.
But that work is queued from within the runtime resume callback,
before the device's power state reaches RPM_ACTIVE, so it can run
while the device is still RPM_RESUMING.  The wake is then consumed
too early: the transmit it restarts stops the queue again,
pm_runtime_get() returns -EINPROGRESS without arranging any future
wake (deferred_resume exists only for RPM_SUSPENDING), and after the
resume completes nothing is left to wake the queue.  Transmit stalls
permanently: packets pile up in the qdisc behind the stopped queue,
the device runtime-suspends, and since the netdev registers no
ndo_tx_timeout the watchdog never fires.  Observed on SM7635
(Fairphone 6) as the cellular data path going permanently deaf
within hours, RX included, since nothing resumes the suspended
endpoints.

Close the window by making the wake work wait for the resume to
complete (pm_runtime_get_sync()) before waking the queue.  Every
queue stop is then guaranteed a later wake that happens while power
is ACTIVE; a transmit racing a new suspend/resume cycle re-schedules
the work.  If the device could not be resumed, wake the queue anyway
so pending packets are dropped by the transmit path rather than
stranded.

The STARTED power flag used to narrow this window: a wake running
before the transmit path's stop suppressed that stop, but only once,
as the flag was cleared by the first stop it absorbed.  Removing the
flag made a single transmit during an in-flight resume sufficient to
strand the queue, which is the form observed.

With an accelerated reproducer (autosuspend delay shortened to 5 ms,
~20 packets/s of TX), an unpatched kernel stalled three times in
230 s / 4380 packets; with this patch the same test ran 3601 s /
70298 packets without a stall.

Fixes: 688de12f080f ("net: ipa: kill the STARTED IPA power flag")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---

Runtime testing was done on a v7.1.2-based device kernel carrying
this same change, on a drivers/net/ipa/ipa_modem.c otherwise identical
to this tree's; the patch as posted was build-tested on net at the
base commit.

 drivers/net/ipa/ipa_modem.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ipa/ipa_modem.c b/drivers/net/ipa/ipa_modem.c
index 9b136f6b8b4a..d84c1dbd3b1a 100644
--- a/drivers/net/ipa/ipa_modem.c
+++ b/drivers/net/ipa/ipa_modem.c
@@ -266,13 +266,29 @@ void ipa_modem_suspend(struct net_device *netdev)
  * the modem.  We can't enable the queue directly in ipa_modem_resume()
  * because transmits restart the instant the queue is awakened; but the
  * device power state won't be ACTIVE until *after* ipa_modem_resume()
- * returns.
+ * returns.  A transmit restarted before that would stop the queue
+ * again and get -EINPROGRESS from pm_runtime_get(), and with this
+ * work having already run, nothing would ever wake the queue again.
+ * So wait for the resume to complete before waking the queue.
  */
 static void ipa_modem_wake_queue_work(struct work_struct *work)
 {
 	struct ipa_priv *priv = container_of(work, struct ipa_priv, work);
+	struct device *dev = priv->ipa->dev;
+	int ret;
+
+	ret = pm_runtime_get_sync(dev);
 
+	/* Wake the queue even if the device could not be resumed, so
+	 * that pending packets are dropped by the transmit path rather
+	 * than stranded behind a stopped queue.
+	 */
 	netif_wake_queue(priv->tx->netdev);
+
+	if (ret < 0)
+		pm_runtime_put_noidle(dev);
+	else
+		(void)pm_runtime_put_autosuspend(dev);
 }
 
 /** ipa_modem_resume() - resume callback for runtime_pm

base-commit: 24ef02f934eeb48830cff6b739abc3c62b1d107b
-- 
2.55.0

