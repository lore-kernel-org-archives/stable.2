Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4B721CC71
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 02:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783304907; cv=none; b=uFTQf8I2H5Q+qD0cXeiLQdRySRtTV2wIA2q/aA8F7twHtm8CD9upgMMR/wq5SeaHirEZkj9dK/Kj9ec0h9RNqlvRVrBSVIL8NpaYKW3rsUh/PZ+JPS4opotd3eNp5AVinyxNxA6TcwktoXH8p/BS3y7Nk5zg2KmzzMIwQwlDDTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783304907; c=relaxed/simple;
	bh=kjhLb3PXh72JfKBYIdSV2SYIMji2TIS2Z59tvU93wKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJkzsBfObIY5F7QftAPt7z/c1ZWSTY4uoQdqzQM/IYZf67AEuLmcl/qXYUOWZqXhou1EYxbYVFaxbB/MnSfZaeQYU4Eev1jhWH/WfewRzvdKnzYI58krQz3R3m3H07wGNNKS8XGj+D/y2o23XfOt62nBM8Qj5y4S6gWzibQyqWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oa4Kml3U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oa4Kml3U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF64D1F000E9;
	Mon,  6 Jul 2026 02:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783304906;
	bh=mbFR/3dmO8LQW1DuAZW7gYmt1vMcgFd03b7I0tWZwHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oa4Kml3UBroIVh0qyT8z+CFBYI9UNMLpfpoTPDoXi1Kes/HqCwVfSIN2ZAtE/WhS8
	 l7/T0Ss0bGjCV1wY5F/f7shG8xcG9oJVNcfedQ+Wu3P0plmcMzKSTvfH6ILjnFEDf3
	 31zm+IIMF3s1cKNYSjoYQd0bZcac9xamL/UbDg4Ki3GUrDufjOMGR2oCMEIHpg9zWN
	 FENFe/EzTJ4bDC/OUtpYKGDiF84NGjFx4g5wzHJ5/Brbg52eSER555/hHFbUY7Bylr
	 TObiSlx/qqMjxPDEAuxfqdCM/okqSS3hkxlpfn2+IhaeMZTP+ARk4xXqLHF29A4p0E
	 8xtbCKgxErN6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] hdlc_ppp: sync per-proto timers before freeing hdlc state
Date: Sun,  5 Jul 2026 22:28:22 -0400
Message-ID: <20260706022823.2081953-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070211-snowdrift-vehicular-c382@gregkh>
References: <2026070211-snowdrift-vehicular-c382@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit c78a4e41ab5ead6193ad8a2dd92e8906bae659fa ]

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
Link: https://patch.msgid.link/20260617020518.116319-1-fanwu01@zju.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ replaced timer_shutdown_sync() with del_timer_sync() since timer_shutdown_sync() is not available in 5.10 ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wan/hdlc_ppp.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wan/hdlc_ppp.c b/drivers/net/wan/hdlc_ppp.c
index 261b53fc8e04cb..6c38ab15cf582a 100644
--- a/drivers/net/wan/hdlc_ppp.c
+++ b/drivers/net/wan/hdlc_ppp.c
@@ -624,7 +624,6 @@ static void ppp_start(struct net_device *dev)
 	for (i = 0; i < IDX_COUNT; i++) {
 		struct proto *proto = &ppp->protos[i];
 		proto->dev = dev;
-		timer_setup(&proto->timer, ppp_timer, 0);
 		proto->state = CLOSED;
 	}
 	ppp->protos[IDX_LCP].pid = PID_LCP;
@@ -644,6 +643,15 @@ static void ppp_close(struct net_device *dev)
 	ppp_tx_flush();
 }
 
+static void ppp_timer_release(struct net_device *dev)
+{
+	struct ppp *ppp = get_ppp(dev);
+	int i;
+
+	for (i = 0; i < IDX_COUNT; i++)
+		del_timer_sync(&ppp->protos[i].timer);
+}
+
 static struct hdlc_proto proto = {
 	.start		= ppp_start,
 	.stop		= ppp_stop,
@@ -652,6 +660,7 @@ static struct hdlc_proto proto = {
 	.ioctl		= ppp_ioctl,
 	.netif_rx	= ppp_rx,
 	.module		= THIS_MODULE,
+	.detach		= ppp_timer_release,
 };
 
 static const struct header_ops ppp_header_ops = {
@@ -662,7 +671,7 @@ static int ppp_ioctl(struct net_device *dev, struct ifreq *ifr)
 {
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	struct ppp *ppp;
-	int result;
+	int i, result;
 
 	switch (ifr->ifr_settings.type) {
 	case IF_GET_PROTO:
@@ -689,6 +698,8 @@ static int ppp_ioctl(struct net_device *dev, struct ifreq *ifr)
 			return result;
 
 		ppp = get_ppp(dev);
+		for (i = 0; i < IDX_COUNT; i++)
+			timer_setup(&ppp->protos[i].timer, ppp_timer, 0);
 		spin_lock_init(&ppp->lock);
 		ppp->req_timeout = 2;
 		ppp->cr_retries = 10;
-- 
2.53.0

