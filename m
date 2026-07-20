Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227CF433BA8
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560107; cv=none; b=mQRtuKLblN8TwsQu+Z+liYoI/OPU4omZuhBtPzhMdcZPNBRyEjF6kzbUSZwklvtkwoj7D00xvCLmr3imanqTA/OeRZEk9/9tZWTgQ8xkYlZqY6jrK2hLRbOMQAJDK0v2ZNxBK49WK3Zz/vY/bpMmdJ01HKv+9a1sp8zCNdeknGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560107; c=relaxed/simple;
	bh=9IQSxCovijK7T2AXCxMPOg2aTBihToFgLkFFyFy3Cwg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=peLjS3bCGACRCk41+PmPa44k5T4IW0rov3dX8Or04P9t0uE0uDNvPrAfY1SFLEhmdX15beHoVR0c76A5xpEe41Acf/NRYwJlbBVXtAWgRlmipD0TTGR5lUBwmDo1i29D9SBFvlOht25nn2Oz/xHhbchYsU0zVkaSs9LMOV1wlD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vRZuqfoh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vRZuqfoh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8711F000E9;
	Mon, 20 Jul 2026 15:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784560104;
	bh=H8cDQ69ibVF+8Wm45oLQeg5MSKmEkJHUgDq6bKTjExA=;
	h=Subject:To:Cc:From:Date;
	b=vRZuqfohKwUbOT2HH6JYG/r/JTHDxORnMBBKnB/v4AY0VOa8Cyl/iIvG6kbKQqnL5
	 MifcqD/xfjX7Ps7Zuwm455DMINzZB2lT9KbWuiSwnEVtJnXd/Lwl2eBNT7QPA7d72U
	 myFgHb4hE4Enpkj1V4kR3IPms1ST+0zOTPbkW3oY=
Subject: FAILED: patch "[PATCH] xfrm: nat_keepalive: avoid double free on send error" failed to apply to 6.12-stable tree
To: qianyuluo3@gmail.com,bird@lzu.edu.cn,eyal.birger@gmail.com,n05ec@lzu.edu.cn,steffen.klassert@secunet.com,yuantan098@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:08:15 +0200
Message-ID: <2026072015-entail-cartload-088d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 226f4a490d1a938fc838d8f8c46a4eca864c0d78
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072015-entail-cartload-088d@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 226f4a490d1a938fc838d8f8c46a4eca864c0d78 Mon Sep 17 00:00:00 2001
From: Qianyu Luo <qianyuluo3@gmail.com>
Date: Thu, 25 Jun 2026 13:55:08 +0800
Subject: [PATCH] xfrm: nat_keepalive: avoid double free on send error

nat_keepalive_send() frees the keepalive skb whenever the IPv4 or IPv6
send helper reports an error.

That cleanup is only correct before the skb is handed to the output
path. Once ip_build_and_send_pkt() or ip6_xmit() takes ownership, the
networking stack may already have consumed the skb before returning an
error, so freeing it again is unsafe.

Handle the pre-handoff failure cases inside nat_keepalive_send_ipv4()
and nat_keepalive_send_ipv6(), where the caller still owns the skb, and
keep nat_keepalive_send() responsible only for family dispatch and the
unsupported-family cleanup path.

Fixes: f531d13bdfe3 ("xfrm: support sending NAT keepalives in ESP in UDP states")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Qianyu Luo <qianyuluo3@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Reviewed-by: Eyal Birger <eyal.birger@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>

diff --git a/net/xfrm/xfrm_nat_keepalive.c b/net/xfrm/xfrm_nat_keepalive.c
index 458931062a04..eb1b6f67739e 100644
--- a/net/xfrm/xfrm_nat_keepalive.c
+++ b/net/xfrm/xfrm_nat_keepalive.c
@@ -55,8 +55,10 @@ static int nat_keepalive_send_ipv4(struct sk_buff *skb,
 			   ka->encap_sport, sock_net_uid(net, NULL));
 
 	rt = ip_route_output_key(net, &fl4);
-	if (IS_ERR(rt))
+	if (IS_ERR(rt)) {
+		kfree_skb(skb);
 		return PTR_ERR(rt);
+	}
 
 	skb_dst_set(skb, &rt->dst);
 
@@ -101,6 +103,7 @@ static int nat_keepalive_send_ipv6(struct sk_buff *skb,
 	dst = ip6_dst_lookup_flow(net, sk, &fl6, NULL);
 	if (IS_ERR(dst)) {
 		local_unlock_nested_bh(&nat_keepalive_sk_ipv6.bh_lock);
+		kfree_skb(skb);
 		return PTR_ERR(dst);
 	}
 
@@ -118,7 +121,6 @@ static void nat_keepalive_send(struct nat_keepalive *ka)
 					sizeof(struct ipv6hdr)) +
 				    sizeof(struct udphdr);
 	const u8 nat_ka_payload = 0xFF;
-	int err = -EAFNOSUPPORT;
 	struct sk_buff *skb;
 	struct udphdr *uh;
 
@@ -140,16 +142,17 @@ static void nat_keepalive_send(struct nat_keepalive *ka)
 
 	switch (ka->family) {
 	case AF_INET:
-		err = nat_keepalive_send_ipv4(skb, ka);
+		nat_keepalive_send_ipv4(skb, ka);
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
-		err = nat_keepalive_send_ipv6(skb, ka, uh);
+		nat_keepalive_send_ipv6(skb, ka, uh);
 		break;
 #endif
-	}
-	if (err)
+	default:
 		kfree_skb(skb);
+		break;
+	}
 }
 
 struct nat_keepalive_work_ctx {

