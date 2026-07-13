Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4207B3E5ED7
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783938165; cv=none; b=JWKFgutyVjB7GhP8k3Hzbu9seVRNaJIs85bcWcMKXSztrzp8UmyzuUQ21NrRACETbidC3iO98q0JirF8lL6utp4wBLKfDGHuS1zT8QUCzxiQJ+KxpjYvHHRgAXEQ7iY21+32HHuMn7KmjxWwYM+Evo/7U+SFVe23A/WNmbP6jh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783938165; c=relaxed/simple;
	bh=9fvUIivmZtSZeqhsriqjOUYwnTIOxzDzZNMxJw1Icx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbMBUa8DVmi2JNJLMOY97hgH4mBwoU+GDIuJeEv0M1J10U6Wh8eqH/RyAidoLF0fJYIH41YrhT6afrcGljbrZaQKGhZ8FGxKKyoYej9caXHYMawu+wcF4pd00+mudNW5r8GFCyJRYU+GoNIlTYt76e4vAfWssvST0qL0HLL7Y8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hSjWmLei; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hSjWmLei"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso1929519f8f.3
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 03:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783938158; x=1784542958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BqAzbIa03EEwzYHiTtc0EGAOtlFJgcTmBpG0VFTldcE=;
        b=hSjWmLei+vEEXiGvSF6MKPQ5rztV4dZbdHQ5vuz6E2uZGStiMuyfsW55ofVcyABPHR
         Pymx7NlEe5BHrNQrHZQ9G4v9vZqJIBVAr6JwQBWp8c3O1efeUvLbzs2yL4vszBcBSt4P
         D5kCSK+iRJXz7hJk03DiB6nYvYic4KfIoRTapxI8ryUcO+LwCo6lIa236F8JcJuc9w8h
         R8p4MCKkOeaJUqDHOgyVu0Jj7iTrY/97joHgAR9dmYvDnXvzosfdRyFAmCiej9nM1ces
         SATv9fjzd+eojNGJgzupeA1LnB8hAMxRNNwZcnCtLAYezVSTVCSfQuqvaOzSmtebGs4F
         h3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783938158; x=1784542958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BqAzbIa03EEwzYHiTtc0EGAOtlFJgcTmBpG0VFTldcE=;
        b=kgTEIh7r/RBb0OdzNnRzwP0Ezgw+VWzf5sgtJvYsxwuC4bXIhQneJB8LdYIObHfuO3
         QmTAO1AVuT1fS9AeREQvFvkn4W14F0F9JLY8PnMTxYeYaQBz87EeY9G+6WOFFbZuC1MG
         J+jVGgq5YN6uPs2toNDmk1Ad/simJmqwq3Uz1fhinW7F19R4gK38/wJy+kHfZqmFGv4y
         xCrMBoGLZPyolMKU5VL6kb+hRzlGZWolQjQ2TP0IfS5p04idPa3dN54KgdCz07P6SQb4
         tvASF7BzgJNQST86VEB6NErb8bsyE4bnpNOHxZY1mwv/lwYEQ9VSPkBknUpWxgnO0P20
         VYOw==
X-Forwarded-Encrypted: i=1; AHgh+Ro9OLc9hJmv4KbBsaU9nbed0LN0N3zdAk6CKbj0e61vIaJfO/sdFbnXpzlg6qTYfmnmuJIWqtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBrom9jN/Chtt3MJUTj+yZu82D+o3DNlIjePKnNcliIaHRvyd7
	za02RnZ7r4HEDhqRkYl1L2Pwp/tgG8j4L8AN1RM0/CS3r7g2sOYKO+l3VoUF4sZ7GAE=
X-Gm-Gg: AfdE7cmEmS1oz4/kwnWEYoCkcm+6fC7zD4zhHxaQB1rjr9Dsx4S6+NavxCe1/EMQty4
	4oq1fXLpGDZBy+EDyChBMuc4u3adFtRM/JlY0HnjdiNPMDpfyLk15jJRTcQQP0oBI8YDs0x6phv
	RBFYiHufMh3Hh3WC82Ut41ToCy3cYbx+WpvP4+ngjzgXy7JN1ZMaR4Mb/knu+pvkBZudSlfdYsK
	ljnq3HEXHigf3mgltUhEgAnr5cmQhQ8dHO0Daq5rKIHnJB8hgcgpGGIu5OQGgPYwmS2VRf99XvN
	OzTnPVyYbYnXPhn8LhQSHKDqsw9fGkjheHD68e4ORoERPCtAo9+9NAmk8s5zkvR1tGmQGEE3+YS
	UWiV92DFV3N6ehJvxnDZR2XQDUG7HLRWs3/fDuYz2peUSfjqW52lNN3yT0UPr0srTZfEsZINeR3
	R+E0iQBkEXYmN+9FJj58tDfZsTNRjqSTbOhLVMtHsFJI+t50tQCSi0qr2+EE86+t9K9klx/mUND
	1oT7KyrarpNO5KV
X-Received: by 2002:a05:6000:460f:b0:475:f0f0:9ef1 with SMTP id ffacd0b85a97d-47f2dd0d580mr8735399f8f.54.1783938157596;
        Mon, 13 Jul 2026 03:22:37 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f484700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f48:4700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa09608d4sm84858344f8f.25.2026.07.13.03.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 03:22:36 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: tytso@mit.edu,
	jack@suse.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] jbd2: bound shrinker scans by examined checkpoint buffers
Date: Mon, 13 Jul 2026 12:22:29 +0200
Message-ID: <20260713102229.1598812-3-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713102229.1598812-1-max.kellermann@ionos.com>
References: <20260713102229.1598812-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Fixes: b98dba273a0e ("jbd2: remove journal_clean_one_cp_list()")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/jbd2/checkpoint.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 5266017565ac..513273712010 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -358,15 +358,16 @@ int jbd2_cleanup_journal_tail(journal_t *journal)
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
 						enum jbd2_shrink_type type,
+						unsigned long *nr_to_scan,
 						bool *released)
 {
 	struct journal_head *last_jh;
@@ -375,13 +376,15 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
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
 
 		if (type == JBD2_SHRINK_DESTROY) {
 			ret = __jbd2_journal_remove_checkpoint(jh);
@@ -403,7 +406,7 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
 next:
 		if (need_resched())
 			break;
-	} while (jh != last_jh);
+	} while (jh != last_jh && (!nr_to_scan || *nr_to_scan));
 
 	return nr_freed;
 }
@@ -425,7 +428,6 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 	tid_t first_tid = 0, last_tid = 0, next_tid = 0;
 	tid_t tid = 0;
 	unsigned long nr_freed = 0;
-	unsigned long freed;
 	bool first_set = false;
 
 again:
@@ -458,10 +460,9 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 		next_transaction = transaction->t_cpnext;
 		tid = transaction->t_tid;
 
-		freed = journal_shrink_one_cp_list(transaction->t_checkpoint_list,
-						   JBD2_SHRINK_BUSY_SKIP, &released);
-		nr_freed += freed;
-		(*nr_to_scan) -= min(*nr_to_scan, freed);
+		nr_freed += journal_shrink_one_cp_list(transaction->t_checkpoint_list,
+						       JBD2_SHRINK_BUSY_SKIP,
+						       nr_to_scan, &released);
 		if (*nr_to_scan == 0)
 			break;
 		if (need_resched() || spin_needbreak(&journal->j_list_lock))
@@ -517,7 +518,7 @@ void __jbd2_journal_clean_checkpoint_list(journal_t *journal,
 		transaction = next_transaction;
 		next_transaction = transaction->t_cpnext;
 		journal_shrink_one_cp_list(transaction->t_checkpoint_list,
-					   type, &released);
+					   type, NULL, &released);
 		/*
 		 * This function only frees up some memory if possible so we
 		 * dont have an obligation to finish processing. Bail out if
-- 
2.47.3

