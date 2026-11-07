Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048927;
	b=u5OHA3xYmDXVpGjd7mFrtNtWkGqO4JgClszvuQ7rtLFVtTTGVBFhPPPk3434ss9uq29b
	 d8tx1e4IS42C5utdyqGlXB7FSQsSJ4fNvaCzAWgXBnWGHu4NaAoqa2zvJRnMlQqUDaOSO
	 SomKkOKEx1Qa/t3T3rSkP29c8yBIwoG5D7dcK3oktkUSAuYbLyv+CbpAstnIb09UB3hK/
	 x27YXouwqeI4m9enMrid7GXnP+xDhCKY8Qzi6bOvlGeHFQCM5sVutwQjswHWpMVcj0Ek8
	 8NfjK6xEDfn7f1/N6SHRrcuNd3EZyku3kKWA3obzLUUjVYX8EsaRhMSguQ52f2oHqUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048927;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=s5Qo9NMTkje0WLmJzGBekhqJgOH0B26kgX6Qt1bTNcM=;
	b=NcjbrUEGexOuQlv5VlAXUifoJI4ESXBuEvGL7T/Y4BsUckIfW6nWMeQfOERlHHJQS/oR
	 4VrQOLDE1Tc7DuCZCdxGtPFEIZUmLWVrxkOy+jW4iE7VcD8udx3weLNZAqamSunV/LDEQ
	 hY9JvfGtMsH1rXssb5mDEHGR19/1sgi9i5TGjhLhgs7XSq2o3w+nEkyacpWRFBBvRNdVd
	 lBFZZliiWduhYThkouAVbSQght/fUUkKXwLe74+q6oh/NIso8ZH9ttmRnoLYWi81+3DIL
	 5qQu9wHz+KrSCD19mbnb8kJPIpAjUoGXb17sHVEboIkiWGpH6XNtDzQwMd4fG9f9LzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z8Oo+UNV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9895606A331
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z8Oo+UNV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651931F0089F;
	Sat,  7 Nov 2026 10:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048926;
	bh=s5Qo9NMTkje0WLmJzGBekhqJgOH0B26kgX6Qt1bTNcM=;
	h=From:To:Cc:Subject:Date;
	b=Z8Oo+UNVsDiRjVfZ5WvEtpmQ+E+6hPdVIsyiNOB3YuFyY4XN9Dw0kfN58vbrzVG3h
	 xnzEkjGWFa5zRDwhz9aQjfo711YfDo/z/Q5Iw4Crt6FEIUkjD0j+97HgNAF4FkIehO
	 iZhfAPOopJLPInpqzhNBbzMDNmilalCFSEbjXir7vNqNxRSRIamTHjiNl3oeooHRXn
	 TnWrxNHM+HUOgEgEzQYee73kmUkKHjwDBLLQTDvf/rc4vKIlgggm/gJ4rtv7rgSz7O
	 1Z20x+nR1YZPrlF2yJkgBbPIxP+KvbvgiYo+kdyCgtdge3Us6bsJPhW2Jp1Q9ZsddR
	 dSyZEY81dqFmw==
From: Sasha Levin <sashal@kernel.org>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: fix to fetch ino via ino_of_node() under cache lock" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:55:25 -0500
Message-ID: <20261107055525-failed-6.1-cd6d8b189139@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x cd6d8b1891395b681f2060916a4b83880b765698
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055525-failed-6.1-cd6d8b189139@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From cd6d8b1891395b681f2060916a4b83880b765698 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Mon, 26 Oct 2026 08:23:49 +0800
Subject: [PATCH] f2fs: fix to fetch ino via ino_of_node() under cache lock

In f2fs_writeback_node_caches(), it's better to fetch ino via ino_of_node()
under cache lock, otherwise, node cache content may become stale after cache
is unlocked due to racing w/ truncation.

Commit 493b9dc8b52c ("f2fs: cache: use node cache") fixes similar issue in
f2fs_flush_inline_data() introduced in commit 34c061ad85a2 ("f2fs: Avoid double
lock for cp_rwsem during checkpoint").

Cc: stable@kernel.org
Fixes: 2049d4fcb057 ("f2fs: avoid multiple node page writes due to inline_data")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 424e95ca58789..44f94000d452c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2195,9 +2195,11 @@ int f2fs_writeback_node_caches(struct f2fs_sb_info *sbi, long nr_to_write,
 
 			/* flush inline_data */
 			if (f2fs_cache_test_inline(entry)) {
+				nid_t ino = ino_of_node(sbi, entry);
+
 				f2fs_cache_clear_inline(entry);
 				f2fs_unlock_cache(entry);
-				flush_inline_data(sbi, ino_of_node(sbi, entry));
+				flush_inline_data(sbi, ino);
 				goto lock_node;
 			}
 
-- 
2.53.0




