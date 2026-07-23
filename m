Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0E048B367
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817275; cv=none; b=jzJQ5GkDMIdVPYbW1jJHCNi/voQ1RcUraF3MaITcIqPfDZWGasl72AyP3dxvrkwNuL9UiXHTkp/e42ak326EhLdv+aUOE7WnYJYe/IGSf5RWVLRXYVAeYFlW6GdCuXfjwt39QYW/rGumFa8ha1tPYHrzcKM2NUl4LdMQp3Wc4zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817275; c=relaxed/simple;
	bh=j+cCeWzoIWZkDBL7CAUpF/JLKA2pJheN1nIjJ6Byv2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxjZy6H3gFx8K8xOFBUyGq/wDocStjLy00T8I3Y/vriDRYVcvce97FWQXxuo0S9AhRE6gNPSZxibNpciwbmMMkRG+PonRDl7jZH62Xa6MCaygnX3g1ZAX33Q3SxxYCghN5Stt9TgWNQcAc+ik+jNCN6WGX/WmowsOGNecE3L7MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSWzZ3La; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSWzZ3La"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201CB1F000E9;
	Thu, 23 Jul 2026 14:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784817272;
	bh=2PtvBDQbPX0jDdHjMTF1I17PgEnbC8Jh2ypfaygGknk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LSWzZ3LaS12q9VmdUu5fVZGukvYGPVSB/jFA7tn47ZrHG/nNTJJ++2KqJ4TSBnfUg
	 vPTBoZJO1S8DgtRGZ2wUx4tSmcslZK/2LKrorS+GAllJtiToggAatmZlYUkUbrG0dI
	 hAYyX/Z8DTaLICxAmG1J5/xvuOL/TdN3B1mynbZfj2Vnn2yzIIZA2flKBrZ0rrgq56
	 rULyihv/YMk77ygcKu1RY5ZF5xoO/odnP3Fsl8Pb+g7bQNh/UV/pcr7MRdknl6nAma
	 VTyiJmccGJ4zsF5ZqJRSNmZZz4l3aQRROhEgbp4L350Nf0p605osRNVWbwxzeWAqqX
	 a9GYrpd79Q+MA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] netfilter: nf_conntrack_sip: remove net variable shadowing
Date: Thu, 23 Jul 2026 10:34:29 -0400
Message-ID: <20260723143430.3226511-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072002-habitat-confirm-9500@gregkh>
References: <2026072002-habitat-confirm-9500@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 7970d6aaf710db166de98c5356a260089896fae5 ]

net is already set, derived from nf_conn.
I don't see how the device could be living in a different netns
than the conntrack entry.

Remove the extra variable and re-use existing one.

Signed-off-by: Florian Westphal <fw@strlen.de>
Stable-dep-of: e5e24a365a5e ("netfilter: nf_conntrack_sip: validate skb_dst() before accessing it")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_sip.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
index ec31611b7a290b..911e35e3b71be0 100644
--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -948,9 +948,8 @@ static int set_expected_rtp_rtcp(struct sk_buff *skb, unsigned int protoff,
 		saddr = &ct->tuplehash[!dir].tuple.src.u3;
 	} else if (sip_external_media) {
 		struct net_device *dev = skb_dst(skb)->dev;
-		struct net *net = dev_net(dev);
-		struct flowi fl;
 		struct dst_entry *dst = NULL;
+		struct flowi fl;
 
 		memset(&fl, 0, sizeof(fl));
 
-- 
2.53.0

