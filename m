Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6934192FC
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 22:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788474318; cv=none; b=IHP6XJAvB+z4y5xJeTl1HGwoE8Jv8hgYXQYpu7R4ONpbyokPu+uIir3nr3iZbhqxctMppdfhsoNjRsfDGQz11+ynIIkg15H1R7QC8YQwzj0wU6OfcUdVeHLXgr0Jn0Jz2w+YbkJZ4KhDRlVJYPHwfHEB+FGlqnLghBanpowTubI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788474318; c=relaxed/simple;
	bh=aka4jFN9ejbU9+T6/LbnEiNNuqO2x6zmk+VvNxkzuTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oCJLVuMnnP1oO9YEes9xS/O5hrFragg+QcOSrzxRexzI3ccZ7uzu69bIVJM8UGASw4O65gLPrAN5ZvG9ZMDkdQ2SM17/yffvg9NuSnIvl+cmtXcH4gT68W8WMiqZVUxCJZ4LxjdvzsG+U7aqV6Mib1v6wn5vUE1351KNuDgr9/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r5L3JfLi; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5L3JfLi"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7eb6573bd52so318089a34.3
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 15:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788474315; x=1789079115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dtFnDKCreodGov5AKdOQxevoRQVqgWybZUxL28h1qP8=;
        b=r5L3JfLi9tdTFYFMQ4OU/aQhoVfLQeBecROA95JRmTCcrqGqxOayeP6cb6E+Q/Zm5i
         T7vZ0KkjXOSFnrvu9xbh2dTGgiC807/4kWyz1RSsqGrFBskw2IcTOYfVsc4UAHyBs4ne
         LEfFyzFE+2xUTFBPl4H/o56CyZtJdtfBQ4twpYhkcbzOGU0M4b3Av+EllB4mXHx9AvOG
         0yWc2r3XWrSNah2Ldu9xfZUcMEeQe0QXCOpmB216yEWU1/848odGi2PpRjIVLE/lPd+Z
         7oaeSj+v4Wz/DHuYpzxAWE4m/U1M0Exlo2hqA96Uw0f3di9VA5MZSO++ZUACVPv6WsOL
         NB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788474315; x=1789079115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dtFnDKCreodGov5AKdOQxevoRQVqgWybZUxL28h1qP8=;
        b=ZACnehGpMURE99fECg2L/qIfNYDIICLihiyu+gbmhv2J3QQe5GRJsYMMmkVUUJZIyH
         aW1xCbwf0PzZbT7FuErF7nyS4XvXgf9vqg+U7gIx5ifYjNgPkvKEJxJpcQbWmXv6k+yY
         KyU2Ens0+kK1ELRaZoUQOusww+n7PCTOy4+97Jg+UtVTVPnGk//1/wqn4M3tcjgHcthc
         tvnNOWP+pRWO6qcXzWZPjjqL3bsjiyyX6sYVUMcAISTnCAnOJRGuMQ1gpq7Q6mw9bo9o
         rNmIEurzlthUwxfrH0IDvlT2FGPjVEUf5sS8Nbak6yB0LZyXdpeP9GBl/Vi2ClN6bbf1
         AKLQ==
X-Forwarded-Encrypted: i=1; AKwUvBwhx8nE9zSY7IGemziYjb8rvigcsYwVPIlj4VMeFVb2sizt37NaWqytqz76RUqGvyjCNSUsi9U=@vger.kernel.org
X-Gm-Message-State: AFuF++nPDu+GQMVJtceZUEzlx2Yh1t0Zh+483ZTdRtGMhKyb1vtdNt6A
	21OtalsTJH9ETzsTe+ZIhidztxaOl53kEdqlGP18eMWfHwyGs9Ietm4=
X-Gm-Gg: AYBFou1Hz3ztc8v/1TL6H98v6/MmdujMfkJaHoYGqP/W5YDuFEDlzg2pZioUTSHYA5s
	+45DGKmAy2ohZKml7jbMlTrLocBWxsDZKBfjYMRgNaGYZ7VVc1UWBwTJ2aSCPilTGla6rCn+NKZ
	uK0d9IWB+rs5Nyq3wyssAS5v3efjpebQd558mEcwsmf9rb3KI/bpdevL/PbkPkwDhxtwWBaCp9O
	2UzeXRQ/pEYo/axKVXhvq8C0BJl7A11VEvw+76k/nigbsxiUUKodlRtbaVo0qXbD98iOtqVZLSn
	W7PuwlNXS/vjC/3JCZOffX5LbGjmu7GynGYa7z6NxoURrfuAacp52fD0ejnwIWa19S6zzwwddYr
	uBz9y38GMYXM85zRUwVkkgCtVmp6TGdcx9jmM2DJ80eHjRT+CPYnHpmEb7/zd9hcrjhcdzK0XTj
	hbZw/vHuS6NdzZR+psBJvJmhzOaWyQZA2Hy02rwWhCWOZgQfqRWTcglbu132SmNxxULbcFfIc+v
	e2UjTAS0253KAYT
X-Received: by 2002:a05:6830:6385:b0:7f4:daae:401d with SMTP id 46e09a7af769-7fa1e7d967cmr1737779a34.8.1788474315101;
        Thu, 03 Sep 2026 15:25:15 -0700 (PDT)
Received: from localhost-live.home.local ([209.73.104.88])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f6793f5fsm1417581a34.8.2026.09.03.15.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 15:25:14 -0700 (PDT)
From: Adam Harshbarger <handyhandyman.adam@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: I Hsin Cheng <richard120310@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH] lib/plist: fix plist_requeue() corrupting order in the last bucket
Date: Thu,  3 Sep 2026 17:24:56 -0500
Message-ID: <20260903222456.1881786-1-handyhandyman.adam@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

plist_requeue() is meant to move a node to the end of its own priority
run.  When the node heads the *last* priority bucket it is instead placed
at the head of the whole list, leaving the plist unsorted:

  built:      A(prio 0) B(prio 1) C(prio 1)
  requeue(B): B(prio 1) A(prio 0) C(prio 1)
  expected:   A(prio 0) C(prio 1) B(prio 1)

prio_list is a *headless* circular ring of the nodes that lead each
priority bucket.  The shortcut added by commit 95d4b3450ebe ("lib/plist.c:
add shortcut for plist_requeue()") takes

	iter = list_entry(iter->prio_list.next, struct plist_node,
			  prio_list);
	node_next = &iter->node_list;

which from the last bucket wraps round to the *first* bucket, so
node_next ends up pointing at the head of the list rather than at its
end.  The plist_for_each_continue() loop immediately below it computes
the correct answer (&head->node_list) for that case.

With any bucket after it the shortcut is correct, which is why this went
unnoticed: the benchmark in that commit measured elapsed time and never
checked the resulting order.

Keep the shortcut -- it is a real win -- but exclude the case where
iter's bucket is the last one, which is exactly when its ring successor
is the first bucket again.

Reachable from mm/swapfile.c, which rotates swap_avail_heads[] with
plist_requeue().  It takes three or more swap devices: at least two
distinct priorities, so that a later bucket exists for the ring to wrap
round from, and two or more devices sharing the lowest priority, so that
plist_requeue() does not return early.  One device per priority returns
early at the node->prio != iter->prio test.  A single priority is also
safe, but for a different reason worth stating: with one bucket no node
is ever linked onto prio_list at all -- plist_add() skips it for the
first node and for every node whose predecessor shares its priority --
so list_empty(&iter->prio_list) holds and the shortcut is never entered.

Tested by driving three implementations -- the pre-95d4b3450ebe code,
current mainline, and this patch -- through 1,084,492 identical random
add/del/requeue operations over 24 nodes and 1..5 distinct priorities,
comparing the resulting node_list node for node after every operation:

  variant             differs from pre-95d4b3450ebe  left list unsorted
  pre-95d4b3450ebe    -- (reference)                                  0
  mainline                                  289,297             276,660
  this patch                                      0                   0

Fixes: 95d4b3450ebe ("lib/plist.c: add shortcut for plist_requeue()")
Cc: stable@vger.kernel.org # v6.15+
Assisted-by: Claude:claude-opus-5
Signed-off-by: Adam Harshbarger <handyhandyman.adam@gmail.com>
---
The bug was found and this fix was written with the assistance of a large
language model, per Documentation/process/coding-assistants.rst.  The
Signed-off-by is mine and the DCO certification is mine.

What was and was not done, per that document's step 8:

  Verified: the bug reproduces against lib/plist.c taken from torvalds/master
  at the time of writing.  Three variants -- the pre-95d4b3450ebe code,
  current mainline, and this patch -- were driven through 1,084,492 identical
  random add/del/requeue operations over 24 nodes and 1..5 distinct
  priorities, comparing node_list node for node after every operation.  The
  patched variant matches the pre-shortcut reference exactly and never leaves
  the list unsorted.  checkpatch.pl --strict reports 0 errors, 0 warnings,
  0 checks.

  NOT done: this was verified in userspace only.  The patch has not been
  compiled into a kernel and has not been booted, and no swap configuration
  was exercised on real hardware -- the reachability argument via
  mm/swapfile.c is from reading the code, not from observing a stall.  If you
  would like the userspace reproducer it is available on request; it fetches
  lib/plist.c from your tree at run time and vendors nothing.

  An alternative patch reverting 95d4b3450ebe outright is available if you
  would prefer that for stable.

 lib/plist.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/plist.c b/lib/plist.c
index a5bef38..b027353 100644
--- a/lib/plist.c
+++ b/lib/plist.c
@@ -174,8 +174,15 @@ void plist_requeue(struct plist_node *node, struct plist_head *head)
 	/*
 	 * After plist_del(), iter is the replacement of the node.  If the node
 	 * was on prio_list, take shortcut to find node_next instead of looping.
+	 *
+	 * prio_list is a headless ring, so from the LAST bucket ->next wraps
+	 * round to the first one; in that case node_next is the list head.
 	 */
 	if (!list_empty(&iter->prio_list)) {
+		struct plist_node *first = plist_first(head);
+
+		if (iter->prio_list.next == &first->prio_list)
+			goto queue;
 		iter = list_entry(iter->prio_list.next, struct plist_node,
 				  prio_list);
 		node_next = &iter->node_list;
