Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD3F3C73DE
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625273; cv=none; b=T+XYek+IFctsqZYtJbsMbfH/OZSlBPlEFYFoHxjuPTLL2a9nQt3fNUggh2MzU+NfiOWA6F6XvqJ/LpM8RTilV8U9c5hxGuYEI1EtnubBGqLCZd8jK8uf+z/wMjllsiIkHMRqJ0zZL8kTWH/1OflTdOqq5vaTgqnESBu13RBSFCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625273; c=relaxed/simple;
	bh=4oJl2fqjCLN8iXUI+/KPTB8NZAOKgkN03MKd3ZevFzs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eWlEhj6/q3CvIKmyAc91Lf7frEQbnhzwkJ1VRpqTZLtEGXBaB7VnGfnNaXc+FHE73RUjQ2cekYjZxjEW2cCkaPDKSadPm91F+Af0E+c8c0ylJw90JvjQ2EZGdbd5CHk/NmT8DEjk+YPRSz14DmA8K+ubVFAjYKTP2u0rBvPWoGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YsYh+X4r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YsYh+X4r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517A61F000E9;
	Tue, 21 Jul 2026 09:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784625271;
	bh=FNWlDOfk9WzThLpKsBzmnShjjVFe+cthXVhwa8gCTFQ=;
	h=Subject:To:Cc:From:Date;
	b=YsYh+X4rANcSbx1owPUONs4wWSiYODlojMnyYDNJYZXtfkrY2wd1NC/3NsqxBGQKj
	 iuMdoLCHcMhqZ9anx8NerfV++OEazEN0TwkGeKjTS4VoMjQ/az2TU7KfPOarwH8d3r
	 EtM5PnSaSRLCghJOkch6HBc20WXbchz0xrdOK3S0=
Subject: FAILED: patch "[PATCH] macsec: don't read an unset MAC header in macsec_encrypt()" failed to apply to 5.15-stable tree
To: 4ncienth@gmail.com,pabeni@redhat.com,sd@queasysnail.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 11:14:22 +0200
Message-ID: <2026072122-whinny-gravel-daab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f5089008f90c0a7c5520dff3934e0af00adf322d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072122-whinny-gravel-daab@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f5089008f90c0a7c5520dff3934e0af00adf322d Mon Sep 17 00:00:00 2001
From: Daehyeon Ko <4ncienth@gmail.com>
Date: Fri, 3 Jul 2026 17:36:33 +0900
Subject: [PATCH] macsec: don't read an unset MAC header in macsec_encrypt()

macsec_encrypt() reads the Ethernet header via eth_hdr(skb)
(skb->head + skb->mac_header) to memmove() the 12 source/destination MAC
bytes forward and make room for the SecTAG.

On the AF_PACKET SOCK_RAW + PACKET_QDISC_BYPASS transmit path the skb
reaches the macsec ndo_start_xmit() with the MAC header unset, so
eth_hdr(skb) resolves to skb->head + (u16)~0 and the read is out of
bounds: a 12-byte heap over-read that is also emitted on the wire as the
frame's outer source/destination MAC. KASAN reports a slab-out-of-bounds
read in macsec_start_xmit() on 6.0; on current mainline a CONFIG_DEBUG_NET
build flags it as an unset mac header in skb_mac_header().

On the TX path the L2 header is at skb->data, so use skb_eth_hdr(), added
by commit 96cc4b69581d ("macvlan: do not assume mac_header is set in
macvlan_broadcast()") for exactly this purpose.

Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Cc: stable@vger.kernel.org
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://patch.msgid.link/20260703083634.2035145-1-4ncienth@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index fb009120a924..dd89282f0179 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -646,7 +646,7 @@ static struct sk_buff *macsec_encrypt(struct sk_buff *skb,
 	}
 
 	unprotected_len = skb->len;
-	eth = eth_hdr(skb);
+	eth = skb_eth_hdr(skb);
 	sci_present = macsec_send_sci(secy);
 	hh = skb_push(skb, macsec_extra_len(sci_present));
 	memmove(hh, eth, 2 * ETH_ALEN);

