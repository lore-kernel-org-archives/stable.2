Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793072074;
	b=XUHrGupopiIlzA+Rbka/itE4AUg+wwUX2/P6al7WyTW94wMSkHldaYmnZsdlNqZkxb61
	 AZoHDB09/Uex/Q0MO4/Wyp2J+93gEQL3+QrNnz35JeG6QCc5AcRKomGUCuo/FlFtbWdyt
	 vJplxUeHVmUDGcoQF6XPblEichA/RR4cZqzA9ZeQkclgwXqX2WbbSSGDpDTlBCBWPey1w
	 DvPh9m7aJmQi0Fek05Anr0dWdRruaOJE9rJthf2LDjdZwEgl0WhJ9Bzbo3BhQwjVh/jkd
	 IAz/SnqL008RGFHZqQvj3q2to+pG5LBSvZxTNA0ooEkVekFW34NcANPaR6Ai2ZIBJ5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793072074;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=JJLvmVV2iFndDkwChBmGVao/pICrf/b8G6/BBv8WQzs=;
	b=G3sjyZYGKU+zLhFgb57WII1d5YATg16rkXpHu93qmpd0DUOBZTkzGDIrWTU0kvM1ERIY
	 B31y2kXch7atcKHhSllFfXyacpAlFlIvISLS6hORdlg3WjaOBGAFHwQ1FrJAJouG57x0l
	 ckyEw+tVh9AA3xjycqewTDnFXQ/Et8ahZ9XHpb/GuTitqM3UYXS9Bonbi1LPAwcVkdVA7
	 ZSo+14EjMLKehciMzJ/v4aCcVQlSfYLV4QGyXY8ehZA7ZsT/hJAuF3rwcrtBNEF9CLP9c
	 0kaGtPxGC5EKkiFSy7h83Wvq85lH7VfXYZxXhrNLXMcrvd8M6S1WYu3iDoPjUdDhRtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=PrPhYdj4;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA42A606A31E
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 03:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA42A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=PrPhYdj4
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c434376dbebso93698366b.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 20:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793072071; x=1793676871; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JJLvmVV2iFndDkwChBmGVao/pICrf/b8G6/BBv8WQzs=;
        b=PrPhYdj4lsl6WY1eRcIYnVNPzLWRrynHcUVj9I5xsoprzRZAeOt6ayDDiUc/trGUDU
         zEEtUvahpwB3yfKrXVSGtn1hq0c5++9cTKlzb4K/mtZ/zEv0TH4Zg99KXDJ6dOs2oshB
         yFYwXMyC++79nRfPELlLKzOVJtcZEkNU0o3Xlqfv3VUoiVDmgy5KolN5DO/PO8U61iqf
         qbx+2TKjQL21JW1lRhafU6DB6bMJdJgrDtJvkKE8E1cIupVnc0ERW7WH6J78ESjGgh+m
         bOFvg+UcxByPQ0Z60FqDar+JfOxEjjKQlAudE0UvBAO84v60l1P9/uoWoeogBgdVcpi4
         WtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793072071; x=1793676871;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JJLvmVV2iFndDkwChBmGVao/pICrf/b8G6/BBv8WQzs=;
        b=cSs7aUuc9dghSKmGEI4G2u3qOsAS5BtFs9GzJwrBq/C2mwnVwpplW9cmDtIh3Obww6
         yK96jRxvd6ECznYiZD4FYY0956cN20ZB92RBqaM3G3z6ACNLw0SGCi7B2+ZlvVrc5zaP
         37YcJ7eK2J88b+BP6NaVBlDjAiEc7tj84I/mrVs2QHAu44A4rO2IhxidIN7It6ZHIh6e
         /+KVCiPodHt52PETOlkg/rb+aV/tmSBw3ZgM+/M6yR7gDbk5HZJLwzb9YRPBpHb7lfjV
         wtgUt26Sxk42AgTRNDdwD8Ne76ndbLTcg41L+h1I9Vw3VC9ni+vBUXbbwGquvO5HjfJ0
         zxjg==
X-Forwarded-Encrypted: i=1; AKwUvBz5MhoT/PInOoUd2S7YZF7pvNF6abgEzztOQL4//lJE0b21i0H7/IcmSZJWp0y/yelLfgqedTw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTG7SIOl7duJ7b705iQ/+UnRADMPjlJ+6B0auyu47gr44Ri+mX
	mMPueEBms0efcUXjXEUYaNXuzoqOdhAM1R3N3w5WcSxtwAwfRwSlxUjj/aWaGS0smqc=
X-Gm-Gg: AYBFou23Ka4rIjsVKH1NUYZbndCKiLca5JB1addjWq4wx/SmXth2WqfjZd3MyU3NfDc
	Gy4VOqZrw1u+YiCm6kkCc0UxUbuit1UJhJqoiamLWPQO0/Zr1DQcasS8FS+GkhrgQiicBjzbcZ2
	9Js/RlyRh+A7qTRmbez5hrJp7ELdsFGPY6fo13L/Nh9zy4AaiSnsqBkSoEqrBZYKhkrbCN/YetN
	2cg1PLy9i8tZ0y0nwSanhMf168lo6hBLam3OMcoJ6W5pCVVG7K+Dzlnq8c4+LgNKJ/4EGlYgjKO
	ATzoYSBWZ/1adOEUy9JvGdB7BMDcLrNVDaIIcWNGF3e6hvG+FTNKl6uwunjLLUAxsc/wdQT14I7
	4RzN1BM7V2K1T7tvIlC6DrQvNoBDORVufLsBGRaZ3GznCFXCfqT13TPcVa9T8WGPXNREs/GjuNq
	PDxQYsDZ0VzG2uFVPLRrg9pkvTw/Gvr0xV7gNH1Z8/h8sqh/whYzxSx300warj3ns/jkTIrqL9M
	P2arC4/VA4E3MX01XJZwbGZ6De+YDaM31tPJH7PN/wHaw==
X-Received: by 2002:a17:907:9303:b0:c46:7de7:e41d with SMTP id a640c23a62f3a-c49a7417cabmr116191366b.18.1793072071043;
        Mon, 26 Oct 2026 20:34:31 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd52435asm380825966b.36.2026.10.26.20.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:34:29 -0700 (PDT)
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
Subject: Re: [PATCH 04/46] mm/memfd: make f_pos accesses atomic
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 stable@vger.kernel.org
In-Reply-To: <20261027-fixes_core-v1-4-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-4-6f74bec9a5bb@kernel.org>
Date: Mon, 26 Oct 2026 20:34:28 -0700
Message-Id: <179307206859.1171062.6841971971647864368.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> Commit 9c225f2655e3 ("vfs: atomic f_pos accesses as per POSIX") made
> read(), write() and lseek() on a shared open file description of a regular
> file serialize on ->f_pos_lock.  The flag that asks for it,
> FMODE_ATOMIC_POS, is set in do_dentry_open().  A memfd is a regular file
> too, but its struct file comes from alloc_file_pseudo() and never passes
> through do_dentry_open(), so it does not get the flag:
> 
... snip ...
> 
> Fixes: 9183df25fe7b ("shm: add memfd_create() syscall")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: minor description tweaks ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

This one arguably should have at least a trivial selftest.

Test attatched
-- >8 --
From: Gregory Price <gourry@gourry.net>
Subject: [PATCH] selftests/memfd: test shared file position atomicity

Without FMODE_ATOMIC_POS, concurrent reads or writes on a shared memfd
can use the same file position. Two writers can overwrite each other's
records:

    CPU 1                         CPU 2
    pos = file->f_pos
                                  pos = file->f_pos
    write a record at pos
                                  write a record at pos
    file->f_pos = pos + size
                                  file->f_pos = pos + size

Add separate shared-read and shared-write tests using the kselftest
harness. Check the final offset, file size and exactly-once record delivery
rather than requiring a particular interleaving.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 tools/testing/selftests/memfd/.gitignore  |   1 +
 tools/testing/selftests/memfd/Makefile    |   3 +-
 tools/testing/selftests/memfd/memfd_pos.c | 136 ++++++++++++++++++++++
 3 files changed, 139 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/memfd/memfd_pos.c

diff --git a/tools/testing/selftests/memfd/.gitignore b/tools/testing/selftests/memfd/.gitignore
index dd9a051f608e2..574ab97ebd982 100644
--- a/tools/testing/selftests/memfd/.gitignore
+++ b/tools/testing/selftests/memfd/.gitignore
@@ -2,4 +2,5 @@
 fuse_mnt
 fuse_test
 memfd_test
+memfd_pos
 memfd-test-file
diff --git a/tools/testing/selftests/memfd/Makefile b/tools/testing/selftests/memfd/Makefile
index 163b6f68631c4..67a95c34541cd 100644
--- a/tools/testing/selftests/memfd/Makefile
+++ b/tools/testing/selftests/memfd/Makefile
@@ -2,7 +2,7 @@
 CFLAGS += -D_FILE_OFFSET_BITS=64
 CFLAGS += $(KHDR_INCLUDES)
 
-TEST_GEN_PROGS := memfd_test
+TEST_GEN_PROGS := memfd_test memfd_pos
 TEST_PROGS := run_fuse_test.sh run_hugetlbfs_test.sh
 TEST_GEN_FILES := fuse_test fuse_mnt
 
@@ -22,6 +22,7 @@ include ../lib.mk
 
 $(OUTPUT)/fuse_mnt: LDLIBS += $(VAR_LDLIBS)
 
+$(OUTPUT)/memfd_pos: LDLIBS += -pthread
 $(OUTPUT)/memfd_test: memfd_test.c common.c
 $(OUTPUT)/fuse_test: fuse_test.c common.c
 
diff --git a/tools/testing/selftests/memfd/memfd_pos.c b/tools/testing/selftests/memfd/memfd_pos.c
new file mode 100644
index 0000000000000..5f3749d13f561
--- /dev/null
+++ b/tools/testing/selftests/memfd/memfd_pos.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <pthread.h>
+#include <stdatomic.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include "../kselftest_harness.h"
+
+#define THREADS 4
+#define RECORDS 16384
+#define TOTAL (THREADS * RECORDS)
+
+struct worker {
+	int fd;
+	unsigned int id;
+	bool reading;
+	pthread_barrier_t *barrier;
+	atomic_uint *seen;
+	int error;
+};
+
+static void *transfer(void *arg)
+{
+	struct worker *w = arg;
+	unsigned int i;
+
+	pthread_barrier_wait(w->barrier);
+	for (i = 0; i < RECORDS; i++) {
+		uint32_t value = w->id * RECORDS + i;
+		ssize_t n;
+
+		do {
+			n = w->reading ? read(w->fd, &value, sizeof(value)) :
+				write(w->fd, &value, sizeof(value));
+		} while (n < 0 && errno == EINTR);
+		if (n != sizeof(value) || value >= TOTAL) {
+			w->error = 1;
+			break;
+		}
+		if (w->reading)
+			atomic_fetch_add(&w->seen[value], 1);
+	}
+	return NULL;
+}
+
+FIXTURE(memfd_pos) {
+	int fd;
+	atomic_uint *seen;
+};
+
+FIXTURE_SETUP(memfd_pos)
+{
+	self->fd = memfd_create("position", MFD_CLOEXEC);
+	if (self->fd < 0 && errno == ENOSYS)
+		SKIP(return, "memfd_create unavailable");
+	ASSERT_GE(self->fd, 0);
+	self->seen = calloc(TOTAL, sizeof(*self->seen));
+	ASSERT_NE(self->seen, NULL);
+	for (unsigned int i = 0; i < TOTAL; i++)
+		atomic_init(&self->seen[i], 0);
+}
+
+FIXTURE_TEARDOWN(memfd_pos)
+{
+	close(self->fd);
+	free(self->seen);
+}
+
+static int run_workers(int fd, bool reading, atomic_uint *seen)
+{
+	pthread_barrier_t barrier;
+	pthread_t threads[THREADS];
+	struct worker workers[THREADS];
+	int ret = 0;
+	unsigned int i;
+
+	if (pthread_barrier_init(&barrier, NULL, THREADS))
+		return 1;
+	for (i = 0; i < THREADS; i++) {
+		workers[i] = (struct worker) {
+			.fd = fd, .id = i, .reading = reading,
+			.barrier = &barrier, .seen = seen,
+		};
+		/* The harness isolates this test in a child; abort on setup failure. */
+		if (pthread_create(&threads[i], NULL, transfer, &workers[i]))
+			abort();
+	}
+	for (i = 0; i < THREADS; i++) {
+		if (pthread_join(threads[i], NULL) || workers[i].error)
+			ret = 1;
+	}
+	pthread_barrier_destroy(&barrier);
+	return ret;
+}
+
+/* Concurrent writes sharing an open file description must not overlap. */
+TEST_F(memfd_pos, shared_write)
+{
+	struct stat st;
+	uint32_t value;
+	unsigned int i;
+
+	ASSERT_EQ(run_workers(self->fd, false, self->seen), 0);
+	ASSERT_EQ(fstat(self->fd, &st), 0);
+	ASSERT_EQ(st.st_size, (off_t)(TOTAL * sizeof(value)));
+	ASSERT_EQ(lseek(self->fd, 0, SEEK_CUR), st.st_size);
+	ASSERT_EQ(lseek(self->fd, 0, SEEK_SET), 0);
+	for (i = 0; i < TOTAL; i++) {
+		ASSERT_EQ(read(self->fd, &value, sizeof(value)), sizeof(value));
+		ASSERT_LT(value, TOTAL);
+		atomic_fetch_add(&self->seen[value], 1);
+	}
+	for (i = 0; i < TOTAL; i++)
+		ASSERT_EQ(atomic_load(&self->seen[i]), 1);
+}
+
+/* Concurrent reads must consume every record exactly once. */
+TEST_F(memfd_pos, shared_read)
+{
+	uint32_t i;
+
+	for (i = 0; i < TOTAL; i++)
+		ASSERT_EQ(write(self->fd, &i, sizeof(i)), sizeof(i));
+	ASSERT_EQ(lseek(self->fd, 0, SEEK_SET), 0);
+	ASSERT_EQ(run_workers(self->fd, true, self->seen), 0);
+	ASSERT_EQ(lseek(self->fd, 0, SEEK_CUR), (off_t)(TOTAL * sizeof(i)));
+	for (i = 0; i < TOTAL; i++)
+		ASSERT_EQ(atomic_load(&self->seen[i]), 1);
+}
+
+TEST_HARNESS_MAIN

-- 
Gregory Price <gourry@gourry.net>
