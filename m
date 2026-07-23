Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A383448BA6
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784818803; cv=none; b=FJ7XA5+1C8ZosoBOwr75TVdtt/wt6ynq09D6CFsRI5wkWyhoMMf1DHgN/V/u6IorAUlPGEgkAgPahKkHIQQjMBFGg1PmmfA7JbBiDzDsLbXgoTxMi9uirHq3JBPII3TK4NCtFjPKJe7A8PNR7zfyxXgtHtPuQCMker0mKr4cksg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784818803; c=relaxed/simple;
	bh=j+cCeWzoIWZkDBL7CAUpF/JLKA2pJheN1nIjJ6Byv2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQUqcG4sCboCNk3ST+3lEKMDE4x2UbfnNEeW6bmp8jju1cTOSo1HY4UAQp8iwzm6Vpo669Y9dVbfstWemlKPLuRSJcSkrvz4mGkm/M5G7DfS8yJ4on5vVpohZDQPDdD76FAyPKecbTaM2/pSHvHi1FcWSXPNzzDD7Q8JeO+hdbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtoIprg6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtoIprg6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7193C1F000E9;
	Thu, 23 Jul 2026 15:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784818802;
	bh=2PtvBDQbPX0jDdHjMTF1I17PgEnbC8Jh2ypfaygGknk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gtoIprg6IZidAUNELEwqlHVkpAzARcV2DKHsytmhmYQBwqBQp1F2rDaXxCUGIgnPA
	 Q+GvG25UG3JJEsBPrlEiM//k7rBiSy9b82FR6nmV5r93IudIfYY97k9FXxnOD7KNOw
	 iFtMjioIGyMI1Q7rS0Sy6NjL2QLN+YPQvpkEqL7kIn4EGBD45ql33lRsJjypuS0cNj
	 8Z3U4nhq/DO7vhTC6xV1l4UY/nR2x2un9vgK7BWteUT0g8Ir/GZ+ugK6zic4HoMy7z
	 CSwlObvsQnORkvUSRRJQXG5y+URf/BTt34IO9Al6sBeHETi2NxzP+lUxR6O6+KfdTK
	 2FmNlVw57rOgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] netfilter: nf_conntrack_sip: remove net variable shadowing
Date: Thu, 23 Jul 2026 10:59:58 -0400
Message-ID: <20260723145959.3283624-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072003-plow-waving-5926@gregkh>
References: <2026072003-plow-waving-5926@gregkh>
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

