Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670CC359A9B
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789608798; cv=none; b=BU/n0G4i13XMHjLg2YAMqseXVjsrZYQi+hb/lIg4/NJMAmqm8lEtEiukx4cqtR+J0GyBRDV3jXooXWBl0XLA2eUitf79gA02fGyBuBL2AgWoT+HFJnvOVjagoT/NgmH94tNKg6lb9Efq9QCpa3dFCi1F0jpfGAgTCR0LqPlIJxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789608798; c=relaxed/simple;
	bh=vUtgJsCurtrzcqiWVtTP27OUuQrrm4TA7aKdU2zyeHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u174wGgLzrc9ANvi7y3RYETqKCQYOf+4qptcfR7NrvWIWqu1RI5J4srZiUECbKFmvZ/vI09OBHrR6SpVKM0Wo1Hf1HYR98ZcPPWlYRyKqwUh73IlVfTcflBy1q72/7m4MtlNcbaoccIL/qztFjsXmUm4focpbUD1Y3i/yoZOghU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMHg6i3A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMHg6i3A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737741F00899;
	Thu, 17 Sep 2026 01:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789608797;
	bh=wTBMXfedMDi3znPsg1CMNpoGkGlzeoUwVxEYgVletYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WMHg6i3A58Td0LliNQAVsbP10FASH8DDP4fe7NM12SDfvUCaoPqwka9sWtJ/7/PNs
	 ejC0vIaIuEECb0oS8chJMx22Uwde7M0LkwpLfxd6xwEpcNWxFjL2/elnpNfT7dSCxC
	 GYn0CpVVq1uYj6HXGywG0gyt/2JqK6scF3bk5diCvP4zYNenEyZPfplISsOn/z4USv
	 YS3HuJZLijeT0irQRZwnG/FDv5KC+oAQ2K5y497kemYnSW2DiG5wInyIsMgEyTYrWO
	 4qIw4XfAwr2zJ/cb9OUtfYZWRV3K5nlE98cgkmD0u4GFQB3+QkWfZ0WXs/qENRfH/Z
	 0SfIPF2SbUN4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	syzbot+92968395eedbdbd3617d@syzkaller.appspotmail.com,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/5] netfilter: cttimeout: fix slab-out-of-bounds read in cttimeout_net_exit
Date: Wed, 16 Sep 2026 21:33:11 -0400
Message-ID: <20260917013313.3594807-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917013313.3594807-1-sashal@kernel.org>
References: <2026091646-antonym-acid-ca2a@gregkh>
 <20260917013313.3594807-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

[ Upstream commit aeed55a08d0b2bf2e3986b110b04d2a5aca192a6 ]

syzbot reports:
BUG: KASAN: slab-out-of-bounds in __list_del_entry_valid+0xcc/0xf0 lib/list_debug.c:42
[..]
 list_del include/linux/list.h:148 [inline]
 cttimeout_net_exit+0x211/0x540 net/netfilter/nfnetlink_cttimeout.c:617

No reproducer so far. Looking at recent changes in this area
its clear that the free_head must not be at the end of the
structure because nf_ct_timeout structure has variable size.

Reported-by: <syzbot+92968395eedbdbd3617d@syzkaller.appspotmail.com>
Fixes: 78222bacfca9 ("netfilter: cttimeout: decouple unlink and free on netns destruction")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: fec9b1de0d02 ("netfilter: cttimeout: prevent UAF during module unload")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nfnetlink_cttimeout.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nfnetlink_cttimeout.c b/net/netfilter/nfnetlink_cttimeout.c
index e2baa56fde531..654ec445e7277 100644
--- a/net/netfilter/nfnetlink_cttimeout.c
+++ b/net/netfilter/nfnetlink_cttimeout.c
@@ -35,12 +35,13 @@ static unsigned int nfct_timeout_id __read_mostly;
 
 struct ctnl_timeout {
 	struct list_head	head;
+	struct list_head	free_head;
 	struct rcu_head		rcu_head;
 	refcount_t		refcnt;
 	char			name[CTNL_TIMEOUT_NAME_MAX];
-	struct nf_ct_timeout	timeout;
 
-	struct list_head	free_head;
+	/* must be at the end */
+	struct nf_ct_timeout	timeout;
 };
 
 struct nfct_timeout_pernet {
-- 
2.53.0

