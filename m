Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2106339AD41
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568965; cv=none; b=Mjz1kxVOb4l2O8OaBrNreq/6FzBypqbR7pzFiBLchwYtZUUhPxesKjRI9uCb838Jx/2w9UDM7GcRpnfKmwEih1mt9fhyxNcRaXpzKoJDtD32jI8CFA9sz1zPFdaQ3xmbuO5hNNF7236vVmD8QZfL3IblQ+D6Tg2a+m9NCVxbgKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568965; c=relaxed/simple;
	bh=zm/zBwkHNErab8JWnpLLu0DFEz4US4SGIRRxPHMy6jI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SF7nUPc138Zma5snq66ccIxyIH73ApnvHCfoWEZhVPYDiDBQIny9h+Eu5Ao0m//YTMWyhqTR4Oxcj4fdtMr24NcNC5v3rf9xTu+uzFzHcDnl/i1akJalsq3KGEAga5Dt03d/zrHmSbqojXPkBVTEYdCU0zEj+Tb2w01ApFmK6Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WXLp1FTw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WXLp1FTw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79EF1F00893;
	Thu,  4 Jun 2026 10:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780568963;
	bh=f+lJ7yuazSQGicodtwdNDia6HKirnVipQn4qRF2qqA0=;
	h=Subject:To:Cc:From:Date;
	b=WXLp1FTwe/tF8Xo20Pvt2Y+CNhxNAYrxBsgPznar+nsi15A7ySssQH3o5qTDlkSVt
	 jChuG/ZWMXvNx/47vTah3ELfMrRKk8G4lLdi+qb2qZTsJmo9MQbXWcGV9vH9Kjs1nG
	 wc5zl0GhD4r0qFgl7It4fzSAY7nnbwakoWBTVr78=
Subject: FAILED: patch "[PATCH] ipv6: exthdrs: refresh nh after handling HAO option" failed to apply to 5.10-stable tree
To: zcliangcn@gmail.com,bird@lzu.edu.cn,idosch@nvidia.com,justin.iurman@gmail.com,kuba@kernel.org,n05ec@lzu.edu.cn,tr0jan@lzu.edu.cn,yuantan098@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:28:25 +0200
Message-ID: <2026060425-wolf-retrace-a632@gregkh>
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
git cherry-pick -x f7b52afe3592eae66e160586b45a3f2242972c63
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060425-wolf-retrace-a632@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f7b52afe3592eae66e160586b45a3f2242972c63 Mon Sep 17 00:00:00 2001
From: Zhengchuan Liang <zcliangcn@gmail.com>
Date: Fri, 22 May 2026 17:42:26 +0800
Subject: [PATCH] ipv6: exthdrs: refresh nh after handling HAO option

ip6_parse_tlv() caches skb_network_header(skb) in nh while walking
IPv6 TLVs.

ipv6_dest_hao() may call pskb_expand_head() for a cloned skb, which can
move the skb head and invalidate the cached network header pointer.
Refresh nh after ipv6_dest_hao() returns so any trailing padding or TLVs
are parsed from the current skb head.

This matches the existing pattern used in ip6_parse_tlv() after helpers
that can modify skb header storage.

Fixes: a831f5bbc89a ("[IPV6] MIP6: Add inbound interface of home address option.")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Co-developed-by: Luxing Yin <tr0jan@lzu.edu.cn>
Signed-off-by: Luxing Yin <tr0jan@lzu.edu.cn>
Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/7aba1debc2196189172499e5769802b026f8caf8.1779247873.git.zcliangcn@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index cf90f933ca1a..6d92c02d0e3d 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -201,6 +201,8 @@ static bool ip6_parse_tlv(bool hopbyhop,
 				case IPV6_TLV_HAO:
 					if (!ipv6_dest_hao(skb, off))
 						return false;
+
+					nh = skb_network_header(skb);
 					break;
 #endif
 				default:

