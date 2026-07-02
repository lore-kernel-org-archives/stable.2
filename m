Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4A3417345
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003803; cv=none; b=J1RME5P5MTz3sMHWkmXXhKwDr5cV+nwCKcdLMQF+tCIOsVTov413KrTY57Awm+/iDJRIlTIQSu9925TTNjC3y2WVlBXI4+zYZ7utbJkHNLTVHbsrgZMboCm6jIQuapqCZ0bglvEYrite2dOsP12HISxAp0JBpHKVARMdxDD4LIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003803; c=relaxed/simple;
	bh=k9p0huLwuprFqnWk3xb6COZlBGnpqkiutJrGUy+TQrs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LbHMfl1qoxG8+YuWqSSwhdJMubs4A6L+plPZTHQPp+SuxbP0Yb8jXW8i2XEcJu/WEQnfK9UWeNfX6aQZUWchnYdlgUJua/XsfQ9O3ez2+Q0Tk/oY8hIcR3pGsN9ZsCC9sQWJ1WAEZnHOUQN+FjBJPgZ2sPgL3LB8i2HFf5qoN4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zHbh0c9q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zHbh0c9q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9951F00A3D;
	Thu,  2 Jul 2026 14:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783003801;
	bh=7FMnaeDnHWdRMkYDXmS+/RLZz/7eZGS9DV7RgAcczmI=;
	h=Subject:To:Cc:From:Date;
	b=zHbh0c9qgj8OyhBy7Td2LD1PTabAcybO4kJ2oXix2JhgUR1iETS8OJbtWE6MFS9gu
	 DpMl6O4V4NBcQpsS70FCscvR2kh5rNvrCMQMkCoGheqqfqrBw9ArU+ZStm7pYMxE7K
	 6Zu9E5sqZ+ZQhDyMWFlia3bAUuzskQg03GpVQLC8=
Subject: FAILED: patch "[PATCH] hdlc_ppp: sync per-proto timers before freeing hdlc state" failed to apply to 5.10-stable tree
To: fanwu01@zju.edu.cn,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 16:50:11 +0200
Message-ID: <2026070211-snowdrift-vehicular-c382@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c78a4e41ab5ead6193ad8a2dd92e8906bae659fa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070211-snowdrift-vehicular-c382@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c78a4e41ab5ead6193ad8a2dd92e8906bae659fa Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Wed, 17 Jun 2026 02:05:18 +0000
Subject: [PATCH] hdlc_ppp: sync per-proto timers before freeing hdlc state

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

diff --git a/drivers/net/wan/hdlc_ppp.c b/drivers/net/wan/hdlc_ppp.c
index 159295c4bd6d..302ed27944e7 100644
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

