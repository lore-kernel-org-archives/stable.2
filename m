Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401343EEAE7
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784818804; cv=none; b=MDd3wwTQCppeoQEGmU4nEkypRmkDI4Pi1riWsoJXcq9MgKn8uxI6bt1rz8xqdlllbE3UQkdqGdeZ7AhfSOtyDIJhOcg1365PZC/Q1PAKv9tHLDaoZ8ciFXxqDQSx922jI4zhu29xqii4v/gvLDkgTTL/tiRs/R5Cdw+zxdYRah8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784818804; c=relaxed/simple;
	bh=ah02gPMpj+EIZYGfxgjH0v/2l8YJEnbFSEjLmAUYWZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epdIJgEl7GjgBxyfqUuD4mu8/ZlxIP4uv2oQ8v3wMLp6HJLg/hYSJZdoeR60WE4e/NVq6RmdPTVcDuyQGFS+gj7Ah3ltxBJP23bqEpb/cDqAgZgsUXKA8fWwZZPBt1CUz7kKT50Os/xETovciB09YeBFv5gCbWoebMDlvxqcEAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MA9mRfHM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MA9mRfHM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618981F00A3D;
	Thu, 23 Jul 2026 15:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784818803;
	bh=YDhHTlWZlmsypHWW+5TRTo5P2BltCIo0x35fzKtO9Ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MA9mRfHMmD65gqlD51xI19K33LBZduPDTicmbiXWE482t0M7cQPk+mLKGCYgPGENj
	 DDVDVDfsUkqn2qoqYpQ0J4XdtvTTYIyITGfEtDycQFWrvSFJeIBL3r6SU2bwUuwZ8X
	 ojwWRpC4NfGX0Kgai12EjxoIsF7n50/yCMhjX8zZrTK9lVqZCP89jvwmuLDWvlQAaK
	 RTu/dEmwnDKZtyNy/BlVVvqB1eQA003lqjY+ajEc0GrX6JdvJ/4FMfeU6SsC7EMb3O
	 9P7FAX1ABCbY99OAHPunuI26avQ+6A/Tjvm+lrISElrwHULT25RHksvunKrxSfzwt2
	 ZycazPC/R6Mog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] netfilter: nf_conntrack_sip: validate skb_dst() before accessing it
Date: Thu, 23 Jul 2026 10:59:59 -0400
Message-ID: <20260723145959.3283624-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723145959.3283624-1-sashal@kernel.org>
References: <2026072003-plow-waving-5926@gregkh>
 <20260723145959.3283624-1-sashal@kernel.org>
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
index 911e35e3b71be0..bd91b8b47f4b75 100644
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

