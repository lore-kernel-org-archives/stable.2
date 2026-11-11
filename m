Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794359261;
	b=103i9Xmzkc5auyO26MSEwwCyLPNySs1OKzvo3ezIjrbSI0vzQrQzE+FHr80qLA3ZoTJA
	 5qXodBeSoL3yYJEcJNmrQQsiTt81SAWaAPV2dQMvaZAcFRdIGQ1EzR4aeuW9z43P5aWSl
	 lY2wUCF+2j3aln4NkGiBK5FgLdtXX80Ngswclt9aa9l3iazOWgRda7drYJavCjBOhGS1x
	 7OUHSe2/c8DwpIX03QJ8rikHkYzYzNSmEIQEU68sZWGQp0Psqz0ExRTVUs4pimWap/5rD
	 191B1O1fMATq3QOS23c3iWtCdkcaoyUH9JHmkmEp1sGXujgxSUIIE1/U30iwqCJdAMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794359261;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=04KyxNNZgHFpZXhEah7voDBgF6r+Z1pEv0GNHSbrc3g=;
	b=AXZDpWLB9hpQHGqjdPwTOppYBziKiyPJfY+2XgMaTe5s8VaZE48/pmBmUEb/DPfTdh7g
	 QmX61GvA+Hg+KSm6jvkpVtqhIDMMfG0CYj77Y8cazTiVCyBvaVqpqWSYF1WBBH1dqf1FD
	 f/ntttjn6HxyC8cnk87yF95fWW2asRg2VLo4gZsH82DKrnEHLCS8CMvaguRIwNEwb2Od/
	 Tg3WCJfdU5lBC8WohtuCpIG//xJ59ZYwWcnc40bvuvhpMmlido2i4HA7/j90atDPKjLEq
	 eOx5PpdM5UVokLoL4UQidIHe32T52r7uFsxsR5Nqx7wTAD3dKTCHldPones8KkAy/9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fbULsrwq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FFB606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fbULsrwq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDD31F0089F;
	Wed, 11 Nov 2026 01:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794359260;
	bh=04KyxNNZgHFpZXhEah7voDBgF6r+Z1pEv0GNHSbrc3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fbULsrwqiFwkcOl+4+1m1kPZqcp+fh3GaYZ7n2k63DPDDiE2h5/Rcp0A2Gq4Aq4yn
	 A9nQquIY/A96pKZdFgD1QAnn5q1hJopvXJb4SflHcEL25g9IvsvtLbWU/ubgcnYupy
	 5otWS7nxE1RWYAzGdLF+WdsOx6Kmy2vLN+0ihqhjlOE6jetwQ1K3+4ritmcxFGUpLf
	 04/tKQfC7J/dTjTyWB7kkOlR8c+EoB9AzmwMGCo5qytWuLUHZiU4HaVGY+Ac7z1OrY
	 +QdC5/L60QV6R0oxlno4WF6hamJ+ggRPq3kf2WN7LG0eREwPRwAOCpGvccQK1hr6yn
	 RaLNtWP8afiqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] f2fs: fix to avoid potential reference count leak in do_garbage_collect()
Date: Tue, 10 Nov 2026 20:07:38 -0500
Message-ID: <20261111010730.348274-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050512-failed-7.3-894ca8b85666@kernel.org>
References: <20261107050512-failed-7.3-894ca8b85666@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 894ca8b856668a82426dbd0a0042b61541a1a9ec ]

In do_garbage_collect(), we have reserved reference counts on summary cache
of all segments, once gc_thread encounter freezing, we need to release all
reference counts.

Cc: stable@kernel.org
Cc: Daeho Jeong <daehojeong@google.com>
Fixes: 02d91398a602 ("f2fs: fix to freeze GC and discard threads quickly")
Signed-off-by: Chao Yu <chao@kernel.org>
Reviewed-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ sashal: Used folio_put_refs(sum_folio, 2) instead of two f2fs_put_cache() calls. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/gc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 0a00180c21dc2..26841503a187c 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1857,6 +1857,9 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 		if (block_end_segno > end_segno)
 			block_end_segno = end_segno;
 
+		if (unlikely(freezing(current)))
+			goto next_block;
+
 		if (is_cursec(sbi, GET_SEC_FROM_SEG(sbi, segno))) {
 			f2fs_err(sbi, "%s: segment %u is used by log",
 							__func__, segno);
@@ -1924,18 +1927,12 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 				sbi->next_victim_seg[gc_type] =
 					(cur_segno + 1 < sec_end_segno) ?
 					cur_segno + 1 : NULL_SEGNO;
-
-			if (unlikely(freezing(current))) {
-				folio_put_refs(sum_folio, 2);
-				goto stop;
-			}
 		}
 next_block:
 		folio_put_refs(sum_folio, 2);
 		segno = block_end_segno;
 	}
 
-stop:
 	if (submitted)
 		f2fs_submit_merged_write(sbi, data_type);
 
-- 
2.53.0

