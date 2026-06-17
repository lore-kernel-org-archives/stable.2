Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9601F2E7363;
	Wed, 17 Jun 2026 02:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781662006; cv=none; b=ttu9KJPchb7xvKiMF1dDW38DQ1R0c/qj91ErRpui3BBuMAN4+aOFc9Wrz/8UbSOnDVjcvIn1yLeDwZy1PgmbkkrYhZNlvGpFXMbST0/TtIrD1uHZVxrTFtX+xa3zU4JbherBziDJR4AxIN2eyiaZHxT+hjddROq1P5fcfNoQEZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781662006; c=relaxed/simple;
	bh=XR5rX7AEi3dE4D9yTc4XpsrNZTxVw02lWpYNIY3tlm4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u9+cF4z8sg1ZuEIUC9OETtqqCZd3Z/AwN01qYxZN9CpLCiV2KiyoTPTFJD+yenW8IxNYorOfkusoS/bVxCpHMRZJnH2duzgpjWq3Q6PMaZ4pTfT0cUVE7XnBsJPGvP2ZhDcHEQ3lkiR0W0L1EWRh1kHRI62B1Bw3Vq3BRS4To0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDH7QElATJqbfO1Ag--.47260S3;
	Wed, 17 Jun 2026 10:06:30 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgC36jEkATJqD1WaAQ--.62560S2;
	Wed, 17 Jun 2026 10:06:28 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: Krzysztof Halasa <khc@pm.waw.pl>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH net] net/wan/hdlc_ppp: sync per-proto timers before freeing hdlc state
Date: Wed, 17 Jun 2026 02:05:18 +0000
Message-Id: <20260617020518.116319-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgC36jEkATJqD1WaAQ--.62560S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?HLlfpwXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZyhOBsypYEs13K1iRN4yz/iJreJjTS4EGE3UMt20y+GDsI+
	pdyaw3B8CRgE8f1vi2ap9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxZrW8Zry8KFWDJr1fKr1ruFX_yoWrXw4kpF
	W7X3WfAFZYg392qw43Jw4kWFyfArn7t3y7Gw1fGanYvFnxGFyF9FyUtFW2kF4fAFWvkr12
	vr109w45Z39YywcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxU7gAwDUUUU

Each PPP control protocol (LCP/IPCP/IPV6CP) embedded in struct ppp
registers a timer via timer_setup(). That struct ppp is the
hdlc->state allocation, which detach_hdlc_protocol() frees with kfree()
in both teardown paths: unregister_hdlc_device() and the re-attach inside
attach_hdlc_protocol().

The ppp proto never registered a .detach callback, so
detach_hdlc_protocol() performs no timer synchronization before the
kfree(). The only cancel, timer_delete(&proto->timer) in ppp_cp_event(),
is partial (it does not wait for a running callback) and only runs on the
->CLOSED transition; ppp_stop()/ppp_close() do not sync either. A
ppp_timer callback already executing (blocked on ppp->lock) survives the
kfree and then dereferences proto->state / ppp->lock in freed memory,
leading to a use-after-free.

Fix this by adding a .detach helper that calls timer_shutdown_sync() on
every per-proto timer. detach_hdlc_protocol() invokes proto->detach(dev)
before kfree(hdlc->state), so timer_shutdown_sync()
now runs on both free paths.
timer_shutdown_sync() is used instead of timer_delete_sync() because the
keepalive path re-arms the timer through add_timer()/mod_timer() and
shutdown blocks any re-activation during teardown.

Initialize the per-protocol timers in ppp_ioctl() when the protocol is
attached, and remove the now-redundant timer_setup() from ppp_start(), so
that the timers are initialized exactly once at attach time and
ppp_timer_release() never operates on uninitialized timer_list
structures. attach_hdlc_protocol() uses kmalloc() (not kzalloc), so
struct ppp's protos[i].timer is uninitialized garbage until the first
timer_setup(); without this init-at-attach, attaching the PPP protocol
without ever bringing the device up would leave timer_shutdown_sync()
operating on uninitialized memory in .detach. Moving the init out of
ppp_start() (which only runs on NETDEV_UP) into the attach path makes the
initialization unconditional and avoids initializing the same timer_list
twice.

This bug was found by static analysis.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/net/wan/hdlc_ppp.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wan/hdlc_ppp.c b/drivers/net/wan/hdlc_ppp.c
index 159295c4bd6d820ca51bb768a70437b541cb3f1e..302ed27944e7c8586a04f70ea639f2da0f7dcbb9 100644
--- a/drivers/net/wan/hdlc_ppp.c
+++ b/drivers/net/wan/hdlc_ppp.c
@@ -619,7 +619,6 @@ static void ppp_start(struct net_device *dev)
 		struct proto *proto = &ppp->protos[i];

 		proto->dev = dev;
-		timer_setup(&proto->timer, ppp_timer, 0);
 		proto->state = CLOSED;
 	}
 	ppp->protos[IDX_LCP].pid = PID_LCP;
@@ -639,6 +638,15 @@ static void ppp_close(struct net_device *dev)
 	ppp_tx_flush();
 }

+static void ppp_timer_release(struct net_device *dev)
+{
+	struct ppp *ppp = get_ppp(dev);
+	int i;
+
+	for (i = 0; i < IDX_COUNT; i++)
+		timer_shutdown_sync(&ppp->protos[i].timer);
+}
+
 static struct hdlc_proto proto = {
 	.start		= ppp_start,
 	.stop		= ppp_stop,
@@ -647,6 +655,7 @@ static struct hdlc_proto proto = {
 	.ioctl		= ppp_ioctl,
 	.netif_rx	= ppp_rx,
 	.module		= THIS_MODULE,
+	.detach		= ppp_timer_release,
 };

 static const struct header_ops ppp_header_ops = {
@@ -657,7 +666,7 @@ static int ppp_ioctl(struct net_device *dev, struct if_settings *ifs)
 {
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	struct ppp *ppp;
-	int result;
+	int i, result;

 	switch (ifs->type) {
 	case IF_GET_PROTO:
@@ -685,6 +694,8 @@ static int ppp_ioctl(struct net_device *dev, struct if_settings *ifs)
 			return result;

 		ppp = get_ppp(dev);
+		for (i = 0; i < IDX_COUNT; i++)
+			timer_setup(&ppp->protos[i].timer, ppp_timer, 0);
 		spin_lock_init(&ppp->lock);
 		ppp->req_timeout = 2;
 		ppp->cr_retries = 10;
--
2.39.2

