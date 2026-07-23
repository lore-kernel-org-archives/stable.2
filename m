Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC1933D6D2
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816346; cv=none; b=awqTRBWzkF5tEUD2RSjTo0FcP5yyJ0GOzrqZIwRvKkF6x3gkP56HMyY+pfPLke2RbmmxMJ+k6xDO3oLXn662O6X6BAkSIR3xV3NDlCT8ZY4PH9Pi8CoiupdGnl+noydMo6cTebCgpjleUvM0WKEEZQpFmRY8s9l5B0PswuGCNqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816346; c=relaxed/simple;
	bh=ENjkiDjLMntp8L0voYy2OjFR59oEq+6cakT6IH1jWHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FnAkza57wJtTuudGl5UgwdD8qfVLPOJhsBhCCertpF8aj43hVf0BMUrAeavCequHj3mzrlZc44G9k/RNp9gnv8W4zPQhbLA2Ugrz54Ul3jw6OQovyJ3zDC/0hrKlfWePA5N/y+dEn19Ax92qkw7mMXD5e323wbBNI9CVwMWG428=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VD2g/d4h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VD2g/d4h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3671F00A3E;
	Thu, 23 Jul 2026 14:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784816343;
	bh=BLmNMeKWs9Qt1DgJi0/RUghAnKZNNYssu6xMyi0QDO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VD2g/d4hXqSROlAwD+uZaBrJBDmCw2KdXMYm7vCBuyeQdNRMNq0NBAG/vLNe/OvuN
	 tdPuXJQnmnhwBpEb1g55zgkuL+TrTOAnm/ki21je4rsrlYmyf/vsnONQC4ZSUgmRJ6
	 FbjnoyjoTEysVqzKA+dAQQ/BCjNwLJgDRXODZeXk1Q13anRGLubKYdm9p2UBzUaGz+
	 n44gsW13wZ2HshfVZUC8FBk7Vt2Q0/6QIZX6Y6hCQQlrdW0hxSv6xzw+Aa/+CQUmwz
	 Medyq+Fs8CCZhHoTQwpXOOJem3cN2DFf9DnhrnGZCYr2XttFU4s7ZU0scZqZryJNcN
	 qP24egUJ6sUug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] netfilter: nf_conntrack_sip: validate skb_dst() before accessing it
Date: Thu, 23 Jul 2026 10:18:40 -0400
Message-ID: <20260723141840.3216559-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723141840.3216559-1-sashal@kernel.org>
References: <2026072002-sedative-yam-0618@gregkh>
 <20260723141840.3216559-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit e5e24a365a5e024efef63cc49abb345fbd4852c5 ]

tc ingress and openvswitch do not guarantee routing information to be
available. These subsystems use the conntrack helper infrastructure, and
the SIP helper relies on the skb_dst() to be present if
sip_external_media is set to 1 (which is disabled by default as a module
parameter).

This effectively disables the sip_external_media toggle for these
subsystems without resulting in a crash.

Fixes: cae3a2627520 ("openvswitch: Allow attaching helpers to ct action")
Fixes: b57dc7c13ea9 ("net/sched: Introduce action ct")
Cc: stable@vger.kernel.org
Reported-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_sip.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
index 58fce6242f89cb..147043f19521bc 100644
--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -947,7 +947,6 @@ static int set_expected_rtp_rtcp(struct sk_buff *skb, unsigned int protoff,
 			return NF_ACCEPT;
 		saddr = &ct->tuplehash[!dir].tuple.src.u3;
 	} else if (sip_external_media) {
-		struct net_device *dev = skb_dst(skb)->dev;
 		struct dst_entry *dst = NULL;
 		struct flowi fl;
 
@@ -969,7 +968,11 @@ static int set_expected_rtp_rtcp(struct sk_buff *skb, unsigned int protoff,
 		 * through the same interface as the signalling peer.
 		 */
 		if (dst) {
-			bool external_media = (dst->dev == dev);
+			const struct dst_entry *this_dst = skb_dst(skb);
+			bool external_media = false;
+
+			if (this_dst && dst->dev == this_dst->dev)
+				external_media = true;
 
 			dst_release(dst);
 			if (external_media)
-- 
2.53.0

