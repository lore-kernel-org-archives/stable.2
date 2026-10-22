Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792677644;
	b=xe2mu/Vcad5tw/rs+mByavxBxj3KGZyNMu6EReOEE3w8WUJ9GJnrT5jPvpq7rn2udsxD
	 Y02ZknFEZIXz3WbLM7pPURCtL7A1oo533tOVZmaAH8Rb903femcMM1SwizULRWsmQrMh3
	 4wEzCIebB9mcIKfW6QN/EXHQHbieSzAj1RSCNelbFPJ+77IKDSPYnamtR0kkiaD/bnkmU
	 eN54hMJtPA1uC/li3OBChe9A/5DQq40bPS79uG5974mcYaA5Q3+Gffchs1f77bcAK+R4d
	 2qThgPoSSwS41jG0F2DgjO5oL99muHNHpcKnlKD/PsVeMPSdITGvvrRKcGl6xRxY7eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792677644;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer;
	bh=EKNYHk3eWPsXkBiRzkLXkiQdodIeDBzq5DpPM2/u1GQ=;
	b=xcI4UskMwmb4vw/IDs2PcWOm+/zAGClcqkgKmQvna1z3mDJaPvtIh+0oA9tSpFQfybft
	 5B020smmPhsujF4NSEUwE5fHE0T9dNkdljDe2paVNWUkJ5zzskfTJNKXWwM7jdjHBlFs8
	 gIKQe61uFu86uvEjIhKUrJn24Mik+QQyFLPwUOsgu6VjthKzlSljqZz9pOSucka6aFYiX
	 uEzEjjh/zr6Kca2SH/tIs3gZyOI01kqGPP3P64s7wLZZafgdMPk7QhkR6qwnkK88cNhrF
	 iUh8mkDwpU+gFBkYX6Z8iCs3X3EUP6qvKPsjW80tSg241gWp7AWqr+nm741AFaYA/Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gp0PLd4D;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35484606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35484606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gp0PLd4D
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35ef6b49813so2478072eec.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 07:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792677643; x=1793282443; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EKNYHk3eWPsXkBiRzkLXkiQdodIeDBzq5DpPM2/u1GQ=;
        b=gp0PLd4DQyu4xvDq93UKdG9FtDFFiBE+bk3VrUIFEsaOmL663x4h5zCIK8MqC9HVIK
         yUICd1BVlGJLSq6RZYm2RNvupdEVvWQxCa5zHcfxvLTDcIrUpipIbeJOak3RKae+5cJV
         hvdhx6hecuyJN0r1nPxTQSdKHx63coT9761wiPaG7ETQz4MjDSX7r2xp32LXEzHN6v+a
         B2S6GgyJ3TywYMYOoai64vKFnDOLqzEGnd3Ha8BspQeia4Iv6wDZYC9i7UQ2Fehqiu4b
         bfJ/oEeVf6YkX67wAUbUgBufuTsanBVHFud1kdGVlRn7SIbMWRwvEqjQE4XwsUYskTWJ
         WSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792677643; x=1793282443;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EKNYHk3eWPsXkBiRzkLXkiQdodIeDBzq5DpPM2/u1GQ=;
        b=KtU7HJxOJEHUudy/V/tAzevYcwxdpuakRa45rn5YqQB/TV3zXRDzezCIPBTBgfoE/g
         ZdHoOCDwmRhKNERjM71YrGS1l7dqKF/2zd7GxCWAnzZ3AHWcRrLJnO9em/o284HknvsW
         Kv/h8gsZtWjRXyrspSJXs8Ahbc5/oLk2my+XS0qXSh2QNJY4BK4hZAkfbQ6gRv5vrjcg
         YbsYI8cF1HNyDTOcm9CewvThYDzh3odL5suAeeeHVp8aYWN68ofuiQRjqY7w8fgKFnBS
         rcocIC2aK3UDw6S7wS67MV74BP5JfxH+qWl7e2GrqhG0UGnWdv/WF1wP+Ub0d3F3z1JI
         XHFg==
X-Forwarded-Encrypted: i=1; AKwUvBxzwGaOUSsP7Y6XSSJ0Mf4f8vfGeNA4tzXWuYuH7QsM6ao1Tks57ADnE+hBbhDGEtvDqbhAb3c=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhtxdCFhx5Lt90KKGP3vr//ebJEVyV5SFite3CZBBnYr7kodJS
	o+Pzaw9btH5UHrwavMtncRgYrb7AUnUB7cvlTH4bw6OKn2Zd8IyaduG8
X-Gm-Gg: AYBFou3jzTeJYyccm3iGpUe8YQO2epOl6s7CNbxs5utB2F57nV5rpcdcl/uxkfC3z0E
	RvAeTYrX1UGAPDcN2Y15oRIp5ykqRfYenswwzJcs7/6LfcV14AVXBFq+NJlQlkyTYBV213Z+08J
	nbkg/WsQgSELr76GYZE4j1G4iJ/Rcwx4Cdz8tkRqbZaC3mOt/eMvmB35lIEaXL3noqJFFVDNZna
	8iJiVkWZVT553GKVVfcdN1+sov2ih5KiTujc5v394roxowZt0zPXTK+FGPYWlhPyh1UkvaPGPdN
	2w4kUGI26S2hMLdSYpbn5hOFeRc+xud4h2je8SwkA3TDmGmKyt5AfZVql3+iMy9M5wFtPo3Uow0
	F8bkWIBdRDWGMbmIaW3BAhvihqnk8MaW0WDGuBPs1KypacjOfuIUwTOzkhKrMnH73bp1fW18GkH
	NjhYdeK820H3naYr/B16poKplfNNb2PzVTKUPF12cibRq11MHLhQm+gCQgar4u1tr6Ez7hi5/q4
	EtNkHy1a9TNXZePnIold09htUEezZLmZnJUrYLA5FKiF3WUGvM=
X-Received: by 2002:a05:7300:e9cf:10b0:365:b147:b458 with SMTP id 5a478bee46e88-3674b52acb8mr7969106eec.3.1792677642657;
        Thu, 22 Oct 2026 07:00:42 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3673e15353csm29420342eec.2.2026.10.22.07.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 07:00:42 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH 0/2] mm/filemap: read ahead for mmap readers that move
 backwards
Date: Thu, 22 Oct 2026 22:00:35 +0800
Message-Id: <20261022-bug-mm-mmap-readahead-descending-v1-0-6d08b34862f2@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAMX2moC/x2NQQqDMBBFryKzdiBGsNqrFBczyTTOwlQSKoLk7
 h0Kjw9v898NVYpKhWd3Q5FTq36yydB3EDbKSVCjOXjnp8F5j/xNuO8GHViEIm02GKUGyVFzwiU
 Qz9PDjcwMdnMUeev1T7zW1n5JGIsAcgAAAA==
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
 Vishal Moola <vishal.moola@gmail.com>, fujunjie <fujunjie1@qq.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <odys.yuan@gmail.com>, stable@vger.kernel.org
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

Patch 1 fixes that regression: on a descending VM_HUGEPAGE fault it
also reads the folio below, and it counts a PMD mapping of the faulting
address as a hit, as a PTE mapping is. Patch 2 reads the window that
ends at the fault on a descending VM_SEQ_READ fault.

Reading one byte from each page of a 2 GiB file, last page first, with
a cold page cache, read_ahead_kb 8192, in a 32 vCPU VM:

                      7be4bc52fd9e    patched
  MADV_HUGEPAGE          36.76 s      0.41 s
  MADV_SEQUENTIAL        50.28 s      0.76 s

The same walk takes 0.53 s with MADV_HUGEPAGE just before
0b9c0aeba938.

Forward walks take the same time. Megabytes read and major faults for
other access patterns over a 16 GiB file:

                                  7be4bc52fd9e         patched
  1% random, MADV_NORMAL         1002 MB, 39619      1004 MB, 39619
  1% random, MADV_HUGEPAGE       1583 MB, 38762      1603 MB, 38758
  1% stride 64 pages            10496 MB, 4          10496 MB, 4
  5% random in 2 GiB memcg,
    MADV_HUGEPAGE                2203 MB, 187413     2221 MB, 187399

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

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
Qiliang Yuan (2):
      mm/filemap: read ahead downwards on descending VM_HUGEPAGE faults
      mm/filemap: extend VM_SEQ_READ readahead below descending faults

 mm/filemap.c | 115 +++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 85 insertions(+), 30 deletions(-)
---
base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
change-id: 20261022-bug-mm-mmap-readahead-descending-9cab86703bbb

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

