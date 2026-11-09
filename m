Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794220469;
	b=WhXogLoEi1YqRwJRaLFDCZl+iCM6tias8lo6uLxGvG46+SkowgGXLBdM9oNXOiNVGDXw
	 yZWww3smLm5DpwrlnMHk7hsJ78f7FUHz71Nj459sO+u/virEeCFU215ofd5RdyBekMX5D
	 yA5wIECCUWf0h71REJewOL7EHXfNTa7yuTLHkKyCiS3FNNw6kZ4xc9rZ7CmVVg5Znq79K
	 A7ZOpfEy3GecOjANJVH3gsPhtdQpY4nw3ezYu6JEniNRkGztB4zaNdlwkMkg9I3pRVgv2
	 o8a+wuHhtqRg/9TWOaPPBghmRzlIc7530Ul/u041FHQP6ZvulcbuMf9IJFAZAT9ay/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794220469;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer;
	bh=HcyC4gXLAdfeaP/Wt/S0vvlPaGMCmoRLGX/CIA6lY9Q=;
	b=jakWRfPvSlqs/KaIXp8g0+HFwd68QhW0gzEUqzaIcKiSK/UJYTZGAeRIrsZ6LA6qv8do
	 sPSHPlMY3JoZ1s1MlGcIlBVYLg1av3bR12JH0ngf3w+5EhgzvrTxQOdf6AlUvyy9i7CHZ
	 WhZiTU6Kk/x/x43gyYgj7CAudEiegSeqwITUS0uHVCJQK395ME1MkQNRK9ww8WA+331U4
	 83JG80W4FHr6/g7r6XzztUigTaSoouMLVbZjQX2TY4EdL9GI3ANZ76ke2R11CRgj4k81x
	 8wSSQq9RytGrjvl3hin1PCizMFVvaFj2CZ/Lwz12LiMzrKTdmxChrdrWgo2DhBAPYGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=95.215.58.30
Received: from mta1.migadu.com (out-30.mta1.migadu.com [95.215.58.30])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6320606A33B
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 10:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6320606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WSKRKNHs8TgH01lWznvz9ZL6seoezqmhP3XWrJeisK4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794220464; v=1; x=1794825264;
 b=PVJC/UwAIHH3G4mW91KyQrf9mbg4ryVduXLxAkM/ZzXH4axh9UXh9mRUCm7bgIq4kePsTTtI
 aKSnr4ktc4gZTYxW421oOygh6VDmaTrfelpF7JHlhyIQx5u5hzA+TstLotDnQZ20qjo2GMRHiL5
 ttASds2G4+wWVdB4MIcYEv7Y=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2c4cef387cfdf462;
	Mon, 09 Nov 2026 10:34:24 +0000
X-Mizu-Trace-ID: 2c4cef387cfdf462
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Subject: [PATCH v2 0/3] mm/filemap: read ahead for mmap readers that move
 backwards
Date: Mon, 09 Nov 2026 05:34:10 -0500
Message-Id: <20261109-bug-mm-mmap-readahead-descending-v2-0-abac52890a9c@linux.dev>
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
X-B4-Tracking: v=1; b=H4sIAKKh8WoC/5WNTQrCMBCFr1Jm7UiaSqyuvId0kZ9pOmDSkmhQS
 u9u7A2Ex4PvLb63QqbElOHarJCocOY5VpCHBuykoydkVxmkkKoVUqJ5eQyhRi+YSDs91UJH2VJ
 0HD1erDa9OovOGANVsyQa+b1f3IfKE+fnnD77Y2l/6x/y0qJA5URvulOv5ChvPmh+HO0cYNi27
 QtDyh2F0AAAAA==
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
 Vishal Moola <vishal.moola@gmail.com>, fujunjie <fujunjie1@qq.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

A reader that walks a file mapping towards lower offsets gets almost no
readahead from mmap faults when the mapping asks for it. glibc's
memmove() and memcpy() copy backwards when the destination lies above
the source, so this happens to loaders that copy large files out of a
mapping, such as LLM inference engines copying model weights out of a
safetensors mapping. Both MADV_HUGEPAGE and MADV_SEQUENTIAL read ahead
only towards higher offsets, so each fault of such a reader reads just
the part it is missing.

MADV_SEQUENTIAL was slow for this before 7.2 as well. MADV_HUGEPAGE
became much slower in 7.2: since commit 0b9c0aeba938 ("mm/filemap:
count only the faulting address as a mmap hit"), the PTEs mapped around
a fault no longer count as hits and PMD mappings never did, so a
backward reader's mmap_miss passes MMAP_LOTSAMISS after about a hundred
folios and readahead stops. Each page after that is read on its own.

Patch 1 moves the mmap hit check of filemap_map_pages() into helpers.
Patch 2 fixes the regression: on a descending VM_HUGEPAGE fault it also
reads the folio below, and it counts a PMD mapping of the faulting
address as a hit, as a PTE mapping is. Patch 3 reads the window that
ends at the fault on a descending VM_SEQ_READ fault.

Reading one byte from each page of a 2 GiB file, last page first, with
a cold page cache, read_ahead_kb 8192, in a 32 vCPU VM:

                       v7.4-rc2      patched
  MADV_HUGEPAGE          42.23 s      0.58 s
  MADV_SEQUENTIAL        52.42 s      0.96 s

The same walk took 0.53 s with MADV_HUGEPAGE just before
0b9c0aeba938.

Forward walks take the same time, and a fault on an uncached 2 MiB hole
between two cached ranges of a MADV_HUGEPAGE mapping is still mapped
with a PMD, 300 out of 300 times with and without the series. Megabytes
read and major faults for other access patterns over a 16 GiB file:

                                    v7.4-rc2           patched
  1% random, MADV_NORMAL         1002 MB, 39617      1013 MB, 39617
  1% random, MADV_HUGEPAGE       1584 MB, 38760      1587 MB, 38756
  1% stride 64 pages            10503 MB, 2          10496 MB, 2
  5% random in 2 GiB memcg,
    MADV_HUGEPAGE                2205 MB, 187416     2225 MB, 187402

The walk above, run as "revwalk FILE" for MADV_HUGEPAGE and "revwalk FILE
seq" for MADV_SEQUENTIAL, is below. I can turn it into a selftest if that
is wanted.

  /* revwalk FILE [seq]: read each page of FILE, last page first */
  #include <fcntl.h>
  #include <stdio.h>
  #include <string.h>
  #include <sys/mman.h>
  #include <sys/resource.h>
  #include <sys/stat.h>
  #include <unistd.h>

  int main(int argc, char **argv)
  {
  	long ps = sysconf(_SC_PAGESIZE);
  	int fd = open(argv[1], O_RDONLY);
  	struct rusage ru;
  	struct stat st;
  	size_t i;
  	char *p;

  	fstat(fd, &st);
  	posix_fadvise(fd, 0, 0, POSIX_FADV_DONTNEED);
  	p = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
  	madvise(p, st.st_size, argc > 2 && !strcmp(argv[2], "seq") ?
  		MADV_SEQUENTIAL : MADV_HUGEPAGE);
  	for (i = st.st_size / ps; i > 0; i--)
  		(void)*(volatile char *)(p + (i - 1) * ps);
  	getrusage(RUSAGE_SELF, &ru);
  	printf("major faults: %ld\n", ru.ru_majflt);
  	return 0;
  }

Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
V1 -> V2:
- Split the mmap hit helpers out of the fix into patch 1
- Patch 2: take a fault as descending only when the folio below it is
  not cached either, so a hole between two cached ranges is still read
  as one large folio (Sashiko review)
- Rebase onto v7.4-rc2 and remeasure
- Send from my linux.dev address

v1: https://lore.kernel.org/r/20261022-bug-mm-mmap-readahead-descending-v1-0-6d08b34862f2@gmail.com

---
Qiliang Yuan (3):
      mm/filemap: move the mmap hit check of filemap_map_pages() into helpers
      mm/filemap: read ahead downwards on descending VM_HUGEPAGE faults
      mm/filemap: extend VM_SEQ_READ readahead below descending faults

 mm/filemap.c | 119 ++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 89 insertions(+), 30 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261022-bug-mm-mmap-readahead-descending-9cab86703bbb

Best regards,
-- 
Qiliang Yuan <qiliang.yuan@linux.dev>

