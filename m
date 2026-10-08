Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E52D3CC303
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 19:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487267; cv=none; b=HQOKJ0fUa8BQVon1trKgPSDYya9Ms05//Zrx26V2dd10X02CfvObHlxucGmJciKm0sKNhNCUpGLMsf5trjcf+OHzj/nPuNoKkayYEbEiZVNGmkl9pwhgrkkweGiR6zFKexg/LLApjYaFhpGFmOawBB7daiGmit+WZY1H4YY4tGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487267; c=relaxed/simple;
	bh=PuzqVFDxI+zatQGxN40slkwNhvv2rAFAYoTUv6unPf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzWCCdTKX7+2vIKDQC4/CZp7zR3YaLxQbwZbmrF/JcUA3jHsp0hXAZ/XxKuZtzdfUv5nb+edB3iPazRJqE7nrF8w4kVkUdsS65sfyjwWWDRL2OIpq4189QzSKYGKytju7XwYyBA0AR5tH3kTybfvwbVMfMVBhZGeWM3i42ZrzP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=HDmkrS/J; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="HDmkrS/J"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3514b90bb89so5216198eec.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 12:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791487265; x=1792092065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6KUKpLP6sK5JJfpFeLzNOR03I2+Ta+FFCS3acbpe0g0=;
        b=HDmkrS/JNeliWZYylj0h9bjp5EvSDzWvxV6QjzRtBprKXDj5wkkEOQFKjyEkFjBaz9
         t+FLwzSXeF1QUTUYljTl9FoAw+CNQC7Nn0zQAnp4mQmDA2vi92RubWLck8V6lunOZ8iV
         KlwxjeAbBi9Yb819W+QQSVEIjnoEbsFWIor6y7437yDVMQO1JSkXRzdNWjYLbkqZr4KE
         WH0WTGomqxardWuLMeUtZkOcqWSJQDQWAW1jMcd1OG3BgFA09CJcFIaqA9Ojr+IUC0Au
         Kvo7/QH6Kc7ijLdmi0cDLbUqCAp7yqTUYhIuxsGhDmr7Syn+kK262PCzuv4XB6MQ6/Fr
         OoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791487265; x=1792092065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6KUKpLP6sK5JJfpFeLzNOR03I2+Ta+FFCS3acbpe0g0=;
        b=Pp8bkJxyG2Frq7c9CzOQ0R5/z+wWlRcW+woXx732xiAFUGHasElmwfWK/LWS0c1XqD
         a/xwldJRJSOKVL0e481bliVcuEx5no5QD5stsl8BvnaqrAKYooeRAf+CJ0QZoxdb97Vk
         HdSU32YU/2EYVXmOqLSIKRVV1G45SI7+QL2KTdByTmViiI4JB9KAPk8DiJ4lgki2B/1e
         Ie83FmiL8f+mn2ijwmqjyC53BOr7tWIN1cE8ml3Fug0G5gpZJliX36QUiZeTPzwzE1Iw
         IAvW4GpZpfsPHqTu5mwy6FpnIIZdor5kSsa328QeWk3RTXhOE+p8nElwEL5jZu+gYNN7
         jShQ==
X-Gm-Message-State: AFq9FYKCl45nmGMfspSZwXBKMqtCQRVTBu17ijZQZAes7c2bU3ta/Il5
	VshNg93uCnktsDxU6j4do9oot+Y1kf0jY1MBHtcal3P5Fne0e1usuNr6c8hStkorFI02ZMWdo93
	gyUG+KGhDaw==
X-Gm-Gg: AYBFou0IMop1r6sbFYuBDnVgO0Eu22qKt68miEjiKHkX/E1LtSpfkJEYNhXgcy6QqJz
	gXzEzGSGOnepBkeHW/cA28EhyJ0kEzqXdQ/FhRq4zbors+cSULf4W6RRFIFrunbCOpjcFfkiCUJ
	TK0nfvGgegnhF5S/jrIL+5wCVkAysU4hmiCLJSZiEwNYD/xW5v4D4NseHT40wZrDNrs2AZ/5tHA
	fX+GK2Fkv3gWiPhNqglfKSRO317zVsMaZ6usjcY5PRpNhX6fpEebapiHeE/AFL86KwZ3dahpyat
	Bz3+Mt9Zar6yQxohMZfnAE1OhE6kuRFnjTsOhZ36Jqif86sfQTNqZd/dJVlJAVIKvm4DoAPM0Bv
	tjxVppcYXsMjUKgGc7E1eWyeq/PJowJW7Re/buG4uE5q8oE3bhPpf1512GG59tOGN2m4mtN4glF
	f1ThMVF9bFpjYZzvEzm+iJhRW6WQJ8X6iFYTegjaszUJsZB31quU83rFiWsEZ+oB4XzRhhpUZm0
	Clj9AASwSn1nczONyZfuDoFQ/ZzpREKWGJRP3hCxCDmgzBlNKvXYV0eCcaiMVhoaMePM2s=
X-Received: by 2002:a05:7300:3091:b0:351:bb8f:5408 with SMTP id 5a478bee46e88-351bb8f5564mr4227855eec.32.1791487254475;
        Thu, 08 Oct 2026 12:20:54 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bc88:5ec1:4f8a:5b23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca329d9sm104325eec.5.2026.10.08.12.20.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 12:20:53 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Max Kellermann <max.kellermann@ionos.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.com>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y 2/2] jbd2: bound shrinker scans by examined checkpoint buffers
Date: Thu,  8 Oct 2026 15:20:46 -0400
Message-ID: <20261008192048.98833-3-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008192048.98833-1-artem@trailofbits.com>
References: <20261008192048.98833-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Max Kellermann <max.kellermann@ionos.com>

[ Upstream commit 15cb16496446b94e67f7abcb049b8e2c75cd3d02 ]

The jbd2 shrinker currently accounts only checkpoint buffers that it
successfully releases against nr_to_scan.  Busy buffers therefore do not
consume the scan budget.

If a checkpoint transaction contains mostly busy buffers, the shrinker
can scan its entire checkpoint list while holding journal->j_list_lock.
Large checkpoint lists can result in excessive lock hold times and leave
other CPUs spinning on j_list_lock, causing soft lockups or RCU stalls.

Pass nr_to_scan into journal_shrink_one_cp_list() and decrement it for
every buffer examined, including busy buffers.  Pass NULL from checkpoint
cleanup paths so their existing full-list behavior is preserved.

This restores the scan-budget semantics that existed before
journal_shrink_one_cp_list() was changed to always scan a complete
checkpoint list.

[ Backport to 6.6.y: use this tree's older shrink_type enumerator names;
  the scan-budget accounting and caller changes are otherwise unchanged. ]

Fixes: b98dba273a0e ("jbd2: remove journal_clean_one_cp_list()")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20260713102229.1598812-3-max.kellermann@ionos.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
This is patch 2 of 2 in the ordered 6.6.y backport series.
This change addresses CVE-2026-89567. Both jbd2 shrinkers decrement the
scan budget only for buffers actually freed, so busy checkpoint lists can
hold j_list_lock unboundedly; counting examined buffers restores shrinker
semantics.
This needed a target-specific adjustment; I called it out in the bracketed
backport note above.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.

 fs/jbd2/checkpoint.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index e8a7186eb8c3..0462101f683c 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -360,15 +360,16 @@ enum shrink_type {SHRINK_DESTROY, SHRINK_BUSY_STOP, SHRINK_BUSY_SKIP};
 /*
  * journal_shrink_one_cp_list
  *
- * Find all the written-back checkpoint buffers in the given list
- * and try to release them. If the whole transaction is released, set
- * the 'released' parameter. Return the number of released checkpointed
- * buffers.
+ * Find written-back checkpoint buffers in the given list and try to release
+ * them. If 'nr_to_scan' is set, scan at most that many buffers. If the whole
+ * transaction is released, set the 'released' parameter. Return the number of
+ * released checkpointed buffers.
  *
  * Called with j_list_lock held.
  */
 static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
 						enum shrink_type type,
+						unsigned long *nr_to_scan,
 						bool *released)
 {
 	struct journal_head *last_jh;
@@ -377,13 +378,15 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
 	int ret;
 
 	*released = false;
-	if (!jh)
+	if (!jh || (nr_to_scan && !*nr_to_scan))
 		return 0;
 
 	last_jh = jh->b_cpprev;
 	do {
 		jh = next_jh;
 		next_jh = jh->b_cpnext;
+		if (nr_to_scan)
+			(*nr_to_scan)--;
 
 		if (type == SHRINK_DESTROY) {
 			ret = __jbd2_journal_remove_checkpoint(jh);
@@ -405,7 +408,7 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
 next:
 		if (need_resched())
 			break;
-	} while (jh != last_jh);
+	} while (jh != last_jh && (!nr_to_scan || *nr_to_scan));
 
 	return nr_freed;
 }
@@ -427,7 +430,6 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 	tid_t first_tid = 0, last_tid = 0, next_tid = 0;
 	tid_t tid = 0;
 	unsigned long nr_freed = 0;
-	unsigned long freed;
 	bool first_set = false;
 
 again:
@@ -460,10 +462,9 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 		next_transaction = transaction->t_cpnext;
 		tid = transaction->t_tid;
 
-		freed = journal_shrink_one_cp_list(transaction->t_checkpoint_list,
-						   SHRINK_BUSY_SKIP, &released);
-		nr_freed += freed;
-		(*nr_to_scan) -= min(*nr_to_scan, freed);
+		nr_freed += journal_shrink_one_cp_list(transaction->t_checkpoint_list,
+						       SHRINK_BUSY_SKIP,
+						       nr_to_scan, &released);
 		if (*nr_to_scan == 0)
 			break;
 		if (need_resched() || spin_needbreak(&journal->j_list_lock))
@@ -515,7 +516,7 @@ void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy)
 		transaction = next_transaction;
 		next_transaction = transaction->t_cpnext;
 		journal_shrink_one_cp_list(transaction->t_checkpoint_list,
-					   type, &released);
+					   type, NULL, &released);
 		/*
 		 * This function only frees up some memory if possible so we
 		 * dont have an obligation to finish processing. Bail out if
-- 
2.39.5

