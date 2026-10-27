Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793065882;
	b=mQdNbvz314UlWXE1oxw703Hn8lRXq1VTfVukpOeoaEd6InWUVWzVqEFOg2NrUbFABGbx
	 igmpRlHUQsqh/Csn75Ud8CYgEYMVdsPGpGC70eaYUDb84jZ/labwi7dDiPP6EJwQvgcRL
	 jwJhPajdjfXX4e6tD0UUXbhHp21nTm/o1rZTRl/pxVAMx1gm3vHh4GrGetrt8wxeSCXQW
	 sO4OpaQdOhDvU4FQQ37TD0Vj8mDrW2fyDdjirFuEeFnk/lSKZDRlsKVaWB+gB5jwPxbLg
	 zjwcIgdFZu15oleeu1vsWlRWZIBzfcVcyBHDP9TkHX934+LIbU2wChwoHMbA2kKVwCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793065882;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=d1iZzHy6VJpZLaEHda8KQ8NIwWwHu2a7fEsuQ1iAa94=;
	b=OGiAUiudkF2vKzgDaPtLwV2KeodlAAbTmchsrt8K7M+5rBq07wP9uPmlVywcQdrY5X3a
	 /bfIdFrtBCazpx1l6/3BLBKOxss4LF7Vz0fDS8kdDwUT8o9xkThfpJ1aV7LVaDAqsjera
	 V8Pv8mFjU9ekhQng1f4i3QQm5BNNdWMXjtU6Bhj7iu/cu5HHQcUxKshKddxuuyJBr1Wex
	 lqDLNg3c14VUy+di3QHtJJetUz+relpCzBhAvrluodgOtoF8/C3N4WYrsZ3w2aiHm+PKo
	 t9DzLO0P6mJxvgqTJu5Fmh1140J4sM1qMvFmwqa1aW9+tQMaf94XRWIM3J6Wp3NW+VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=t+GSFcmf;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F30606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 01:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10F30606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=t+GSFcmf
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93a40a9a01aso59220785a.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 18:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793065880; x=1793670680; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d1iZzHy6VJpZLaEHda8KQ8NIwWwHu2a7fEsuQ1iAa94=;
        b=t+GSFcmf8m5KIiKpf7s/e322B2VWIkxON8FI8tQaSaddrw1RC/paWoqtw/MVmCEL+l
         KWWY6Uh37aKVIUkFQ0y+JqjAOK34W9fUkfoG+KFFvOuk/znwikF6MPcenQASFo4D9g/F
         Q5irMfw/CZHaaRDD8Pg3KFNU4SuYuvRd/IlLSW+GD6sNF3vEbK7Sl6RC4ZOUfAP/saY6
         I0QpW9Q6rP/eRqoJHtgzEIiVjvhKUTutMoRPwFtRB6iMlZVIwsf4oktgz0MADcWMlHMl
         L0HQgyO++b5dq3QhzJ9SSF3O1Zi5gK+nENAlbKaH0/YU0mkufLmwtvSxEulIRRMuJa3d
         d+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793065880; x=1793670680;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d1iZzHy6VJpZLaEHda8KQ8NIwWwHu2a7fEsuQ1iAa94=;
        b=MpLVElgAlGP/PofoUJ56d/dqWHi9K8Y6EOnQxYHIYDOAe/XQdu05Zw30gIGq41tcAB
         eU4i9IieoNFk5Q+lPYeg4VoExtMzUROLROenuslJcqI1XKNJuXB6Wo1rXdO+Q4ESOiYQ
         CHyyWDfF4jb32ugRLtX47lU4amcfWxXEC2GgpR4kBAbppSAadnJzkKrgQk5cGm9TCaDk
         W13LdqroVtlg2pOpupEklC7fdkAzqy5HfO/TjVYZhNdenTUTpiYhGf+mE0nLn6z2twVj
         7IEtXj45TJoAI3O+8nEVly+FsdnVOcDm1iPhjrWjjlOJt1N1WNtxlcVemr2zc76dHs5V
         XPeg==
X-Forwarded-Encrypted: i=1; AKwUvBxgiaxBnwjPMXCzK5aIRbbHmDuOSREeCGExu6mGyAMM5U22EZcHDcgcXDumoAEd7QnvXG0f9/s=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9WoskEOOPG83fPF28CBHDJq11hFMmJ95o8umjRBt5psOs0Pho
	bvKHAOL/xdAdMU6l/NLpYp76EJUPm1Y5iar3YgGAQu3mBGQmWnfqK9VnZko4yZpIo/M=
X-Gm-Gg: AYBFou1M/glMN71IO9A2RzMhSyGzqQRUSYxF2dVxuL/9GCm2DnOsWP2Q+am7yUQJ2yy
	Y3S6wdYV8vE9cQu/34CRgGAM79fqsTmuA+LbYDF1n4Vz/C9vS/JDneY4IuxBa/5U4mtpyH16cGT
	mmwyBCC3YvQoymgHEz4ntstIqk9zxk0CnRLDHoCfJIErtv/hPN0FigqyPPL7bDPaGeDX/uzKlgM
	FaqhIXpCdbnWinZgd7CcCtM9rLoYWZi9B8BYIRVHinRwSQ/1Uc2fvWqZEwdJGRl50YQD3s/4USS
	S0/GfdZC4nH9K4PuubLavYqzjwqLnhQ0YjTM+wJldOS+O9kfLkYodBCuSiOVbm9a2Tee16YH/6C
	JFbxY3SMEHAkjKazZTQiPe1UX0fPOofk9BdYmpKHBmAjtCpoFiXhw5vJPEp/x8qONosbSLRUGUD
	kKrFQOEgVo2jHB798AZavYsWHzCpm2Zu8rZUQCHphoecu9cD7v5+6vY2tYNe23DBbtBMbaFLE++
	hgwyX/7N4oGhv1ffytxJa7KHXc1lH/Nn7S7FRcluqFrMdS/fw4f7DtwcVRlxu/3N8/OgX7lblJQ
	3yYnUXl9kW5XPuVExKDun95XqcY=
X-Received: by 2002:a05:620a:450f:b0:93e:4c1b:a084 with SMTP id af79cd13be357-943f49f071bmr271661785a.7.1793065879789;
        Mon, 26 Oct 2026 18:51:19 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0a771c9sm845477185a.34.2026.10.26.18.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 18:51:18 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/4] mm: avoid losing atomic VMA flags
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Davidlohr Bueso <dave@stgolabs.net>, 
 SJ Park <sj@kernel.org>, Kees Cook <kees@kernel.org>, 
 Colin Cross <ccross@google.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261023-fix-vma-atomic-v1-0-8ff4fae1fc85@kernel.org>
References: <20261023-fix-vma-atomic-v1-0-8ff4fae1fc85@kernel.org>
Date: Mon, 26 Oct 2026 21:51:16 -0400
Message-Id: <179306587687.1925990.13855179558376532702.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-23 14:47 +0100, Lorenzo Stoakes (ARM) wrote:
> Since commit 2ab7f1bbafc9 ("mm/madvise: allow guard page install/remove
> under VMA lock"), VMA_MAYBE_GUARD_BIT can be set atomically under the VMA
> read lock.
> 
> However, a number of places wrongly assume the flags are stable under the
> read lock, which can cause stale atomic VMA flags to overwrite existing
> valid ones.
> 
> Additionally, one case in which VMA_SOFTDIRTY_BIT was overwritten is also
> addressed.
> 
> This series addresses each of these, while keeping the logic inline with
> existing conventions.
> 
> Each patch in this series is a hotfix.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

You too get to be the unwilling participant in my schlopptesting
experiment - but the good news is there's no issues and you win
tags and free self/unit tests.

Tested-by: Gregory Price (Meta) <gourry@gourry.net>

Might be worth taking the VMA unit test below.
Selftests... maybe the non-race uffd one.

Summary

- **Reproduced and validated.**
  Every bug the series describes reproduces on the base.
  After applying the patches, the reproducers fail to repro.

-- >8 --
From: Gregory Price (Meta) <gourry@gourry.net>
Subject: [PATCH] selftests/mm: guard-regions: test VM_MAYBE_GUARD is not lost under races

MADV_GUARD_INSTALL sets VM_MAYBE_GUARD atomically while holding only the
VMA read lock. mprotect(), madvise(), mlock(), VMA split and VMA merge
used to snapshot VMA flags under the mmap write lock before write-locking
the VMA and write them back afterwards, dropping a concurrently set
VM_MAYBE_GUARD. For a file-backed mapping that means fork() no longer
copies the page tables, so the child silently loses its guard markers.

Add a flag_race test which, for each of those operations, repeatedly
maps a fresh region and races a guard installation against the operation
from two threads, then asserts via smaps that the VMA covering the
guarded page still has the "gu" flag whenever the installation
succeeded.

Without "mm: avoid losing atomic VMA flags" this fails within a few
rounds for mprotect() (all three backings); with only patch 1 applied it
fails on the split case; with patches 1-3 it fails on the merge case;
with the whole series it passes 2000 rounds of each operation.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 tools/testing/selftests/mm/guard-regions.c | 158 +++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
index f7d53ea3c252..fe03354a1dca 100644
--- a/tools/testing/selftests/mm/guard-regions.c
+++ b/tools/testing/selftests/mm/guard-regions.c
@@ -9,8 +9,10 @@
 #include <linux/limits.h>
 #include <linux/userfaultfd.h>
 #include <linux/fs.h>
+#include <pthread.h>
 #include <setjmp.h>
 #include <signal.h>
+#include <stdatomic.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -2330,4 +2332,160 @@ TEST_F(guard_regions, smaps)
 	ASSERT_TRUE(check_vmflag_guard(ptr));
 }
 
+/*
+ * Operations which snapshot VMA flags under the mmap write lock but before
+ * write-locking the VMA, racing against MADV_GUARD_INSTALL which sets
+ * VM_MAYBE_GUARD atomically under the VMA read lock.
+ */
+enum guard_flag_race_op {
+	RACE_MPROTECT,	/* mprotect() whole VMA. */
+	RACE_MADVISE,	/* madvise(MADV_RANDOM) whole VMA. */
+	RACE_MLOCK,	/* mlock() whole VMA. */
+	RACE_SPLIT,	/* mprotect() 2nd page, guard 1st (split duplicates). */
+	RACE_MERGE,	/* mprotect() 2nd page so it merges with the 1st. */
+	NR_RACE_OPS,
+};
+
+struct guard_flag_race {
+	unsigned long page_size;
+	enum guard_flag_race_op op;
+	char *ptr;
+	char *guard_ptr;
+	int guard_ret;
+	unsigned int jitter_guard, jitter_op;
+	atomic_int round, guard_done, op_done, stop;
+};
+
+static void race_spin(unsigned int n)
+{
+	for (volatile unsigned int i = 0; i < n; i++)
+		;
+}
+
+static int race_wait(struct guard_flag_race *race, int seen)
+{
+	int curr;
+
+	while ((curr = atomic_load(&race->round)) == seen)
+		if (atomic_load(&race->stop))
+			return -1;
+	return curr;
+}
+
+static void *race_guard_thread(void *arg)
+{
+	struct guard_flag_race *race = arg;
+	int seen = 0;
+
+	while ((seen = race_wait(race, seen)) >= 0) {
+		race_spin(race->jitter_guard);
+		race->guard_ret = madvise(race->guard_ptr, race->page_size,
+					  MADV_GUARD_INSTALL);
+		atomic_store(&race->guard_done, seen);
+	}
+	return NULL;
+}
+
+static void *race_op_thread(void *arg)
+{
+	struct guard_flag_race *race = arg;
+	const unsigned long page_size = race->page_size;
+	int seen = 0;
+
+	while ((seen = race_wait(race, seen)) >= 0) {
+		race_spin(race->jitter_op);
+		switch (race->op) {
+		case RACE_MPROTECT:
+			mprotect(race->ptr, 2 * page_size, PROT_READ);
+			break;
+		case RACE_MADVISE:
+			madvise(race->ptr, 2 * page_size, MADV_RANDOM);
+			break;
+		case RACE_MLOCK:
+			mlock(race->ptr, 2 * page_size);
+			break;
+		case RACE_SPLIT:
+		case RACE_MERGE:
+			mprotect(&race->ptr[page_size], page_size, PROT_READ);
+			break;
+		default:
+			break;
+		}
+		atomic_store(&race->op_done, seen);
+	}
+	return NULL;
+}
+
+/*
+ * Assert that VM_MAYBE_GUARD is never lost when guard regions are installed
+ * concurrently with operations that update VMA flags, split or merge VMAs.
+ *
+ * Losing it means fork() may not copy the page tables of a file-backed
+ * mapping, silently dropping the guard markers in the child.
+ */
+TEST_F(guard_regions, flag_race)
+{
+	const unsigned long page_size = self->page_size;
+	struct guard_flag_race race = { .page_size = page_size };
+	pthread_t guard_thread, op_thread;
+	struct procmap_fd procmap;
+	int round = 0;
+
+	srand(getpid());
+	ASSERT_EQ(open_self_procmap(&procmap), 0);
+	ASSERT_EQ(pthread_create(&guard_thread, NULL, race_guard_thread, &race), 0);
+	ASSERT_EQ(pthread_create(&op_thread, NULL, race_op_thread, &race), 0);
+
+	for (race.op = 0; race.op < NR_RACE_OPS; race.op++) {
+		int i;
+
+		for (i = 0; i < 2000; i++) {
+			char *ptr;
+
+			ptr = mmap_(self, variant, NULL, 2 * page_size,
+				    PROT_READ | PROT_WRITE, 0, 0);
+			ASSERT_NE(ptr, MAP_FAILED);
+			/*
+			 * Populate so anonymous mappings have an anon_vma and
+			 * can be guarded under the VMA lock.
+			 */
+			ptr[0] = 'x';
+			ptr[page_size] = 'x';
+
+			race.ptr = ptr;
+			race.guard_ptr = &ptr[page_size];
+			if (race.op == RACE_SPLIT) {
+				race.guard_ptr = ptr;
+			} else if (race.op == RACE_MERGE) {
+				/* Make 1st page RO so 2nd merges into it. */
+				ASSERT_EQ(mprotect(ptr, page_size, PROT_READ), 0);
+			}
+			race.jitter_guard = rand() % 2000;
+			race.jitter_op = rand() % 2000;
+
+			atomic_store(&race.round, ++round);
+			while (atomic_load(&race.guard_done) != round ||
+			       atomic_load(&race.op_done) != round)
+				;
+
+			/* smaps is keyed by VMA start, so look it up. */
+			ASSERT_TRUE(find_vma_procmap(&procmap, race.guard_ptr));
+			if (race.guard_ret == 0 &&
+			    !check_vmflag_guard((void *)procmap.query.vma_start)) {
+				TH_LOG("VM_MAYBE_GUARD lost, op %d round %d",
+				       race.op, i);
+				atomic_store(&race.stop, 1);
+				ASSERT_TRUE(false);
+			}
+
+			ASSERT_EQ(munmap(ptr, 2 * page_size), 0);
+		}
+	}
+
+	atomic_store(&race.stop, 1);
+	pthread_join(guard_thread, NULL);
+	pthread_join(op_thread, NULL);
+	ASSERT_EQ(close_procmap(&procmap), 0);
+}
+
 TEST_HARNESS_MAIN

-- >8 --
From: Gregory Price (Meta) <gourry@gourry.net>
Subject: [PATCH] selftests/mm: soft-dirty: check VM_SOFTDIRTY survives an anon name merge

test_merge() checks that VM_SOFTDIRTY is propagated when a soft-dirty
clean VMA is merged into a soft-dirty one via mremap() and mprotect(),
but not via a change of anonymous VMA name.

That path was broken: madvise_update_vma() overwrote the merged VMA's
flags with the stale flags of the renamed VMA, dropping VM_SOFTDIRTY from
the VMA it merged with. This is fixed by "mm/madvise: preserve
VMA_SOFTDIRTY_BIT when changing anonymous names".

Add a case which names VMA 1, clears soft-dirty, places a differently
named (and therefore soft-dirty, unmerged) VMA 2 adjacent to it, then
renames VMA 1 so that it merges into VMA 2, and asserts both pages are
still reported soft-dirty. Skip it if PR_SET_VMA_ANON_NAME is not
supported.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 tools/testing/selftests/mm/soft-dirty.c | 76 ++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
index 7f649b673355..9f4660b19e1a 100644
--- a/tools/testing/selftests/mm/soft-dirty.c
+++ b/tools/testing/selftests/mm/soft-dirty.c
@@ -6,6 +6,7 @@
 #include <stdint.h>
 #include <malloc.h>
 #include <sys/mman.h>
+#include <sys/prctl.h>
 
 #include "kselftest.h"
 #include "vm_util.h"
@@ -13,6 +14,17 @@
 #define PAGEMAP_FILE_PATH "/proc/self/pagemap"
 #define TEST_ITERATIONS 10000
 
+#ifndef PR_SET_VMA
+#define PR_SET_VMA		0x53564d41
+#define PR_SET_VMA_ANON_NAME	0
+#endif
+
+static int set_anon_name(char *addr, size_t len, const char *name)
+{
+	return prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, (unsigned long)addr,
+		     len, (unsigned long)name);
+}
+
 static void test_simple(int pagemap_fd, int pagesize)
 {
 	int i;
@@ -308,6 +320,68 @@ static void test_merge(int pagemap_fd, int pagesize)
 			 __func__);
 
 	munmap(map, 2 * pagesize);
+
+	/*
+	 * Finally, establish a named VMA and clear VM_SOFTDIRTY:
+	 *
+	 *      "a"
+	 *       -
+	 * |---|---|---|---|---|
+	 * |   | 1 |   |   |   |
+	 * |---|---|---|---|---|
+	 */
+	map = mmap(&reserved[pagesize], pagesize, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	if (map == MAP_FAILED)
+		ksft_exit_fail_msg("mmap failed\n");
+	if (set_anon_name(map, pagesize, "a")) {
+		ksft_test_result_skip("Test %s-anon soft-dirty after anon name merge 1st pg\n",
+				      __func__);
+		ksft_test_result_skip("Test %s-anon soft-dirty after anon name merge 2nd pg\n",
+				      __func__);
+		munmap(map, pagesize);
+		return;
+	}
+	clear_softdirty();
+
+	/*
+	 * ...and place a differently named VMA immediately adjacent:
+	 *
+	 *      "a" "b"
+	 *       -  S/D
+	 * |---|---|---|---|---|
+	 * |   | 1 | 2 |   |   |
+	 * |---|---|---|---|---|
+	 */
+	map2 = mmap(&reserved[2 * pagesize], pagesize, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	if (map2 == MAP_FAILED)
+		ksft_exit_fail_msg("mmap failed\n");
+	if (set_anon_name(map2, pagesize, "b"))
+		ksft_exit_fail_msg("prctl(PR_SET_VMA_ANON_NAME) failed\n");
+
+	/*
+	 * Now rename VMA 1 so it's compatible with 2 and therefore merges. The
+	 * anon name path must not overwrite the merged VMA's flags with VMA 1's
+	 * stale ones, which lack VM_SOFTDIRTY:
+	 *
+	 *       merge
+	 *        S/D
+	 * |---|-------|---|---|
+	 * |   |   1   |   |   |
+	 * |---|-------|---|---|
+	 */
+	if (set_anon_name(map, pagesize, "b"))
+		ksft_exit_fail_msg("prctl(PR_SET_VMA_ANON_NAME) failed\n");
+
+	ksft_test_result(pagemap_is_softdirty(pagemap_fd, map) == 1,
+			 "Test %s-anon soft-dirty after anon name merge 1st pg\n",
+			 __func__);
+	ksft_test_result(pagemap_is_softdirty(pagemap_fd, map2) == 1,
+			 "Test %s-anon soft-dirty after anon name merge 2nd pg\n",
+			 __func__);
+
+	munmap(map, 2 * pagesize);
 }
 
 static void test_mprotect_anon(int pagemap_fd, int pagesize)
@@ -330,7 +404,7 @@ int main(int argc, char **argv)
 	if (!softdirty_supported())
 		ksft_exit_skip("soft-dirty is not support\n");
 
-	ksft_set_plan(19);
+	ksft_set_plan(21);
 	pagemap_fd = open(PAGEMAP_FILE_PATH, O_RDONLY);
 	if (pagemap_fd < 0)
 		ksft_exit_fail_msg("Failed to open %s\n", PAGEMAP_FILE_PATH);

-- >8 --
From: Gregory Price (Meta) <gourry@gourry.net>
Subject: [PATCH] tools/testing/vma: test merge retains sticky flags set after vmg snapshot

Callers of vma_merge_existing_range() populate vmg->vma_flags from the
middle VMA before it is write-locked. VMA_MAYBE_GUARD_BIT can be set
atomically on middle after that point (MADV_GUARD_INSTALL under the VMA
read lock), so a merge which takes middle's sticky flags from
vmg->vma_flags rather than from middle itself loses it. That is the case
fixed by "mm/vma: avoid losing atomic VMA flags when setting sticky VMA
flags".

The existing merge_existing test always uses the same flags for middle
and for vmg, so it cannot observe this. Add a test which sets
VMA_MAYBE_GUARD_BIT on middle only, leaving it clear in vmg->vma_flags,
prev and next, and asserts that the merged VMA retains it for each merge
shape: merge right (partial and full span), merge left (partial and full
span) and merge both.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 tools/testing/vma/tests/merge.c | 92 +++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/tools/testing/vma/tests/merge.c b/tools/testing/vma/tests/merge.c
index b26f1a66a170..3ebd4ca50904 100644
--- a/tools/testing/vma/tests/merge.c
+++ b/tools/testing/vma/tests/merge.c
@@ -1096,6 +1096,97 @@ static bool test_merge_existing(void)
 	return true;
 }
 
+struct stale_sticky_shape {
+	const char *name;
+	bool has_prev, has_next;
+	unsigned long start, end;
+	bool expect_prev;
+};
+
+/*
+ * Callers of vma_merge_existing_range() (e.g. mprotect, madvise, mlock) take a
+ * snapshot of middle's flags into vmg->vma_flags before middle is write-locked.
+ * Atomic VMA flags (currently VMA_MAYBE_GUARD_BIT) can still be set on middle
+ * after that snapshot, under the VMA read lock (MADV_GUARD_INSTALL), so the
+ * merge must take middle's sticky flags from middle once it is write-locked,
+ * not from the stale vmg->vma_flags, or the merged VMA loses them.
+ *
+ * Simulate that race by setting VMA_MAYBE_GUARD_BIT on middle only, so that
+ * neither vmg->vma_flags nor prev/next have it, and assert that the merged
+ * VMA retains it for each merge shape.
+ */
+static bool test_merge_existing_stale_sticky(void)
+{
+	const vma_flags_t vma_flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
+			VMA_MAYREAD_BIT, VMA_MAYWRITE_BIT);
+	static const struct stale_sticky_shape shapes[] = {
+		/*
+		 * 0123456789
+		 *    VVVVNNN
+		 */
+		{ "merge right partial", false, true, 0x4000, 0x7000, false },
+		{ "merge right full",    false, true, 0x3000, 0x7000, false },
+		/*
+		 * 0123456789
+		 * PPPVVVV
+		 */
+		{ "merge left partial",  true, false, 0x3000, 0x6000, true },
+		{ "merge left full",     true, false, 0x3000, 0x7000, true },
+		/*
+		 * 0123456789
+		 * PPPVVVVNNN
+		 */
+		{ "merge both",          true, true,  0x3000, 0x7000, true },
+	};
+	struct mm_struct mm = {};
+	VMA_ITERATOR(vmi, &mm, 0);
+	struct vma_merge_struct vmg = {
+		.mm = &mm,
+		.vmi = &vmi,
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(shapes); i++) {
+		struct vm_area_struct *vma_prev = NULL, *vma_next = NULL;
+		struct vm_area_struct *vma, *merged, *expected;
+		vma_flags_t middle_flags = vma_flags;
+
+		if (shapes[i].has_prev)
+			vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0,
+						      vma_flags);
+		/* Set after the caller's snapshot, as if by MADV_GUARD_INSTALL. */
+		vma_flags_set(&middle_flags, VMA_MAYBE_GUARD_BIT);
+		vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, middle_flags);
+		if (shapes[i].has_next)
+			vma_next = alloc_and_link_vma(&mm, 0x7000, 0xa000, 7,
+						      vma_flags);
+
+		/* The stale snapshot: no VMA_MAYBE_GUARD_BIT. */
+		vmg_set_range(&vmg, shapes[i].start, shapes[i].end,
+			      shapes[i].start >> PAGE_SHIFT, vma_flags);
+		vmg.middle = vma;
+		/* Offset into middle means prev is middle. */
+		vmg.prev = shapes[i].start > vma->vm_start ? vma : vma_prev;
+
+		expected = shapes[i].expect_prev ? vma_prev : vma_next;
+		merged = merge_existing(&vmg);
+		if (merged != expected || vmg.state != VMA_MERGE_SUCCESS) {
+			fprintf(stderr, "%s: merge did not occur as expected\n",
+				shapes[i].name);
+			return false;
+		}
+		if (!vma_test(merged, VMA_MAYBE_GUARD_BIT)) {
+			fprintf(stderr, "%s: VMA_MAYBE_GUARD_BIT lost on merge\n",
+				shapes[i].name);
+			return false;
+		}
+
+		cleanup_mm(&mm, &vmi);
+	}
+
+	return true;
+}
+
 static bool test_anon_vma_non_mergeable(void)
 {
 	vma_flags_t vma_flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
@@ -1501,6 +1592,7 @@ static void run_merge_tests(int *num_tests, int *num_fail)
 	TEST(vma_merge_with_close);
 	TEST(vma_merge_new_with_close);
 	TEST(merge_existing);
+	TEST(merge_existing_stale_sticky);
 	TEST(anon_vma_non_mergeable);
 	TEST(dup_anon_vma);
 	TEST(vmi_prealloc_fail);

-- 
~Gregory

