Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596635;
	b=fVtRqYUSag9K5aWd4MivS+j1VrWFxsolDssB/f8P1p6RMFxb6yzYdDNcaL9EChOOQURT
	 LyrVPZ2E6nQdw0+R6gaje9P5PXDlRl6RISfskTAyviH6sa0MaMfGi1VSoEmohZR5uJhR9
	 sYQ6ZlFFGvAMK3L1YNm61zo210s92K09rMnOtCRCp5jT0CMjZ76TZE3ge0WnYBURik2CX
	 X5HYhxa6jRtfxMzkdSNqJZYeF/8U4+3hq862dPdlUn9uAcoz659b6Na7I8Hon/DToOe2o
	 QvvP+5S302knnxgs7AMonM+wSXz6UYTd+2t17iwe5PvwFLIDQ09MN9s6M3IHRHxP2vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596635;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=56MPax3KOQ0C8ykCYuiLg9crm/Fipm3MDVNbdm4iMeo=;
	b=um+PZCpjnC2q6BXg2RDwJmz0IVfP7ZSWN1+P4gZk6JBkOP6JfxyM91dlFvFVQuhek7WH
	 iVPCZr2T02Ojf/bgPycSx+ccUyf7SSPcXy4m5vKIQM8v3zYZklKfuRz5WtRQRvGiIu+77
	 oDqBPtgWf0MmphSBdJuWXVNwFLAjrdiDA1vdbiNhJG10LSNom8nXYsf03ILYHVzRGgxqE
	 LvSXfz0PlAqe/9ZZpvmdn9VkwfoorVEx/dT3A61KNtzFgbmK2U/R6MOXwMiZea/ZDBXxJ
	 LjaAKwU5LeOV9qguqCRHC9RDDdJ55UhuOTObpLYMeQe2f20Qq7Y842ocvtSYjJwDu5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=RJE0STvY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFB8606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=RJE0STvY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52DC1F000C0;
	Wed, 25 Nov 2026 08:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795596634;
	bh=56MPax3KOQ0C8ykCYuiLg9crm/Fipm3MDVNbdm4iMeo=;
	h=Subject:To:Cc:From:Date;
	b=RJE0STvYSBmGWKt6JodY01TcVkd8SyXAFvhcEQQnabaEVG9VRu/xmKfhdYpEe08vH
	 C4DDSCE7oYltp5aO2R4S9HAfBOK0DLsHl5bKTlm1mD+Q9deT5KVPIcZ4+ykxJtelWx
	 eJNnnc1sg+l2irul9Nvm5pGNW0tNnx6aZ9XG6K3M=
Subject: FAILED: patch "[PATCH] xsk: defer software checksum until the skb is complete" failed to apply to 6.12-stable tree
To: testwrzwrz@gmail.com,kerneljasonxing@gmail.com,maciej.fijalkowski@intel.com,pabeni@redhat.com,sdf@fomichev.me
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 09:47:11 +0100
Message-ID: <2026112511-clergyman-gulf-c3af@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f2eddafbfcc004098425fee7c5664adbe29152d7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112511-clergyman-gulf-c3af@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f2eddafbfcc004098425fee7c5664adbe29152d7 Mon Sep 17 00:00:00 2001
From: Rongzheng Wang <testwrzwrz@gmail.com>
Date: Wed, 4 Nov 2026 11:48:08 +0800
Subject: [PATCH] xsk: defer software checksum until the skb is complete

When XDP_UMEM_TX_SW_CSUM is used with multi-buffer TX, xsk_skb_metadata()
calls skb_checksum_help() while only the first descriptor has been added to
the skb. The checksum therefore covers just the first fragment, and
skb_checksum_help() sets ip_summed to CHECKSUM_NONE, so the remaining
fragments are never included in the checksum.

Move the software checksum calculation to the point where the last
descriptor has been added to the skb.

On a checksum failure the packet is now dropped instead of being returned
to the application for a retry. This path is not reachable with the
existing metadata validation, but the behavior change is intentional.

Fixes: 11614723af26 ("xsk: Add option to calculate TX checksum in SW")
Cc: stable@vger.kernel.org
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>
Link: https://patch.msgid.link/20261104034809.24545-2-testwrzwrz@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 28b3075eef85..f22f9a2cdbbe 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1012,14 +1012,6 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 		skb->csum_start = hr + csum_start;
 		skb->csum_offset = csum_offset;
 		skb->ip_summed = CHECKSUM_PARTIAL;
-
-		if (unlikely(pool->tx_sw_csum)) {
-			int err;
-
-			err = skb_checksum_help(skb);
-			if (err)
-				return err;
-		}
 	}
 
 	if (flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
@@ -1031,6 +1023,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 	return 0;
 }
 
+static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *pool)
+{
+	if (unlikely(pool->tx_sw_csum &&
+		     skb->ip_summed == CHECKSUM_PARTIAL))
+		return skb_checksum_help(skb);
+
+	return 0;
+}
+
 static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 					      struct xdp_desc *desc)
 {
@@ -1278,6 +1279,12 @@ static int __xsk_generic_xmit(struct sock *sk)
 			continue;
 		}
 
+		err = xsk_skb_sw_csum(skb, xs->pool);
+		if (unlikely(err)) {
+			xsk_drop_skb(skb);
+			goto out;
+		}
+
 		err = __dev_direct_xmit(skb, xs->queue_id);
 		if  (err == NETDEV_TX_BUSY) {
 			/* Tell user-space to retry the send */

