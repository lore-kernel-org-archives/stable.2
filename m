Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273826;
	b=eRIQ2zT5qtq+wKUjdf3oVYGakq+beXeKdGmNpaGgcNnFlyXNKHQDdKhkk3ytTxg08Jb8
	 2EvEVBCoLmgbdXX5QH40amkgMsYPSMHXNhQlD8Qo9Lt/4UsC/j65a7Jf+yE5XMPxLNunb
	 8Sbo42ZEg5F1LLkxAQ80YyFU4sCoulkDKu+879oXRChJ3XJGnQP2InDKHCe61hFn0Yyzl
	 FsN5dyJqdDMt6VUH2UL2XNYe6GoOY53Xd/fTGgPhauqmSz/kBvaGA005MrFsSnJtjZNn/
	 sQev2YI8pf2aZ+8ReMq96PjW0RVzopQTl3MltVOUUKi/ucnfO7IY8GqrdxixUo2vTpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273826;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=L4YhaAqcCkfKFwLUsG4ioMkSLfrIm2JslyKcHQgIfls=;
	b=odtq5NaegMFGkx6lv6j2RaacvMiG6pig3V9R/xeioYd5zVKuJ6NvWhfqdy3EhZNa6gb9
	 eO5KpZTWh9IILxv3dfENdXMLH+MALCf8t2iXKz6q9fZynT7/DEST9w8Vcz1ceK5VMhCdR
	 N9sbPhdgiKTY+yb0C1jD5UFAuHTJxf7vu8RxdluXxfH15jiVqRuEhSLzHGdrHZIoY6QnX
	 piQ9B3XbZ/stzQk63E4y7B/ndAlgpDew9wE5YE2xX//dp0jcMDsTwlVmT4/J5VxKf8ije
	 Gi1UtZHdc4jWq4jA9dILgZ4g7TawPOZ9QWi57nH9yB17KSgwpan8A9YfG3oS/DbFi2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RsWxJ/18";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D4D606A336
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RsWxJ/18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D9C1F0089F;
	Tue, 10 Nov 2026 01:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273825;
	bh=L4YhaAqcCkfKFwLUsG4ioMkSLfrIm2JslyKcHQgIfls=;
	h=From:To:Cc:Subject:Date;
	b=RsWxJ/18ajgXBgtAs7/g/lEs3rWGkiIPbo6Ii5fG2J4SaJ6rKqYe+2tmulODwMHIi
	 k7nLjBN80kiYi1E4VmpCfO5I1aWX9D6EMh2NGIg/S2IlxBgSCfJfgPRg0scC/s74Mh
	 Ja8/7gjh7+BE1TghnjKOn7h5e80d5Q3krZ21SpmfSl0khqwarqQUpwgqeAqN4AJVf+
	 ejLlbCxwBahEVeRtaXJPhrz5/TaUNJNQ6n0ycTD01NArDoU7ToGj3RnVI9hGxTCJQd
	 AIUeKIl8GxQcRPtHBHl41uENDUou8ExQPvZq3+GVbPdTAycvGbqefvl1qjm6EBo4M7
	 t/wQSCFYRKNTg==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	josef@toxicpanda.com,
	ljs@kernel.org,
	xu.xin@linux.dev,
	usama.anjum@arm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/madvise: fix data loss from MADV_FREE on a KSM page" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:23:44 -0500
Message-ID: <20261109202343-failed-5.15-22d043c1da48@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 22d043c1da48d6c7274f9dd900714b6d58b7b9c6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202343-failed-5.15-22d043c1da48@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 22d043c1da48d6c7274f9dd900714b6d58b7b9c6 Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:40:03 +0100
Subject: [PATCH] mm/madvise: fix data loss from MADV_FREE on a KSM page

MADV_FREE can clear the dirty flag of a singly mapped KSM folio. The
folio remains in the stable tree and can gain new mappings without being
dirtied again. Once marked lazyfree, reclaim can discard data that those
mappings still need.

KSM always marks a folio dirty when converting it to a KSM folio in
try_to_merge_one_page(). Marking a folio lazyfree clears PG_swapbacked
but leaves PG_dirty unchanged. Preserving PG_dirty makes reclaim restore
PG_swapbacked instead of discarding the folio. This also protects folios
that were already lazyfree when KSM converted them.

Skip KSM folios before clearing their dirty flag, checking under the
folio lock to serialize with KSM conversion.

Fixes: 854e9ed09ded ("mm: support madvise(MADV_FREE)")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Xu Xin <xu.xin@linux.dev>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-34-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/madvise.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 75b409e97dbf2..a16e3cb256b7b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -756,6 +756,15 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		if (folio_test_swapcache(folio) || folio_test_dirty(folio)) {
 			if (!folio_trylock(folio))
 				continue;
+			/*
+			 * KSM folios can gain new mappings at any time, so we must
+			 * not clear their dirty flag.
+			 */
+			if (folio_test_ksm(folio)) {
+				folio_unlock(folio);
+				continue;
+			}
+
 			/*
 			 * If we have a large folio at this point, we know it is
 			 * fully mapped so if its mapcount is the same as its
-- 
2.53.0




