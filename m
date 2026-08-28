Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660053C0625
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 05:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787896790; cv=none; b=Bi+dGzNq9ZJjkVmCOfsV2TkSBzM2g/Rcu6juJE3YhgC6JdEMC2wr23yCv/v+YgkqmAg2cPa9Xq8WLT1IA0blpaHkYD+yX8icS7xVwCeVANNxdy+1W6OoeYpMjWmjbkp/59G/nGAoVexm1F8B1VMVgEe8p2r2SnSM6S56GZoDL90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787896790; c=relaxed/simple;
	bh=muxTdd2WeZxgjmHt2qcYHN2fbk6odcHQFyl+LpftQzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RQEoJ40LeyzNT0FpdIQwf05NyB7zihnEQByx4YzgNZ68VpoOgM/eiTM2kd8B38b4vHVRVQkhJ84BV8X+Fmwmw9BgIVcUhb/RA+igf0zIPhTDmEBiKjqMyCjajuprMVZZ1xryRNaQ9siAtp8KJPJDO14OwNXZi4FshoHePLDJuXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDVeLvx0; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDVeLvx0"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso1091781a91.2
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 22:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787896788; x=1788501588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GDl7OP4PCiA7ts1ANifq35vbIMUl1z7lISgn6jZCS6A=;
        b=HDVeLvx0tnj3/xjzDq3R9vFuMUE8rK9J+YQKQyVLMbAbwDCyb+BI59ONfZCLMTRp/L
         GsGDxcNd59SSk0DQojRNdh3EUCDLRpKonMJ2SOoPHfnvljKsnBBV693ogY8LodBTQf6e
         zZ9n4Fn6/uWEddzB4btLqNdafgzjSCqLG4ywDZJNhIWX+bzuH2RVkNk58Z/ANwhDOhWJ
         rzd1+ndsYg81Z+xlA+pKUxpOwtOK0SYdUJjT1BKX7QCZv5c+9jae5uNGFOyvKE9C7y6S
         BDfHgWgnbjg4hH3ruKwaejzOKwFq5ij4TP96H1R8E8fdEjPCxqgtF1mARUlihq0AJFk0
         7O7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787896788; x=1788501588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GDl7OP4PCiA7ts1ANifq35vbIMUl1z7lISgn6jZCS6A=;
        b=FZq8Bt/aYKTRMrVkj3LSzRZ0rM8mDxN/37nOsb6ntcIC7mNmbwrMgioJwnLgK1iYhQ
         raKjipxgKl3ths8ywK0La29zw8LD3gs3bav7RSwKwz5MtWgl+oLPl9BhZ1hio3XQU9SF
         3HwgM74TdBMLCnRRcGKLUlixIMpVj4xccQmVH0/8NMWNpiDluHewEnz2iWTSnICGKL9/
         PjmLeXVXIGQcpiAWnwegORthVBAwiEEYqE/l+5KCofqlTL4ZSswLrLcywUyEIDqlZGym
         MrimCzTPS8tV+VJYAZdqpGm83HaPRXoFHoNGMgobMrt/caTkwgUGE5wamRTH/2U9dd6F
         02sg==
X-Forwarded-Encrypted: i=1; AHgh+RrBaycK/6oO+5tgyXPaUDNE5LAiwCkooLfkrSlAsU85s7VDcxCP8rd007+DgLyTRkJLChl+/Z8=@vger.kernel.org
X-Gm-Message-State: AFuF++loFY2BpXXawwLZglVLnzde1lgmOrxZ1ZOF0eCaQIv54MAAn86i
	rNXuX2vbVKKaN0S0u6eJBR7s0S3sG1KQ4baBUuzx69pALlqDVIIDlxungcqZvA==
X-Gm-Gg: AR+sD12UPHIFmg2RJrfpOZdrsrZZsE+NddcwqRfP2yQBOGe88U2ktgqGa4fLIT8Zciw
	W4unjusQuyA0XBJ1kn1CzsEhVbYBuHVnIhvMmBh0SjWhqHEzRUDqdCafFwnGy7ojkQ/6SqfSPaQ
	cKjc6KRo49V0pumg0CB0pXmiljOwOPHq/GmXRQlMCS32w+97qg7amvL1tOcpjipWMzhLmDXbPJ8
	ELAXk+Jnp804gFxfxFb+XjPT2h/Bz+aAYa1kpe/riSxqVXxS92u4Xu0p02WXgstLKJhWe9jmOT4
	KS7fFfajIvGqM9yNw9pm2+sKAn6IiJabcIPfw1n0dHmJyptciVVD8VizxUw4Jj0G6T2VaVsslmK
	78XOscliZUrMIsv+3HIIMh3nrQVNajSBYHVQIZC9WX/WG6wHf/uR2hYoNjMhE7v8yRif5paEx/f
	3jN/0knNRSdeSmmpaceCpXnZUHGbFiV649Z5IXFZb1CGY2IWYZmbXYG0MqP33CSXHM/7wrgbrsr
	5M=
X-Received: by 2002:a17:90a:d884:b0:381:e74f:8a6a with SMTP id 98e67ed59e1d1-396d10248camr9814071a91.16.1787896787656;
        Thu, 27 Aug 2026 22:59:47 -0700 (PDT)
Received: from localhost.localdomain ([240e:b8f:1df9:a600:c693:b19f:ada0:748])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0ea808csm5826241a91.2.2026.08.27.22.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 22:59:46 -0700 (PDT)
From: Vernon Yang <vernon2gm@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org
Cc: nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	zokeefe@google.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	Vernon Yang <yanglincheng@kylinos.cn>
Subject: [PATCH v4 0/3] mm: khugepaged: fix tracepoint UAF
Date: Fri, 28 Aug 2026 13:59:23 +0800
Message-ID: <20260828055926.346744-1-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vernon Yang <yanglincheng@kylinos.cn>

The khugepaged tracepoints take a folio pointer and call folio_pfn(),
but by then the folio may no longer be valid: freed after folio_put(),
folio_unlock() or pte_unmap_unlock(), or not a folio at all but an
xarray-encoded swap entry. On classic SPARSEMEM, dereferencing it oopses
khugepaged as soon as the trace event is enabled; on other memory models
it merely prints a bogus pfn.

Pass the pfn to the tracepoints directly, captured while the folio is
still pinned, closing the use-after-free windows in
mm_khugepaged_scan_file(), mm_khugepaged_scan_pmd() and
mm_khugepaged_collapse_file().

This series is based on mm-new.

V3 -> V4:
- Only trace the PFN if it really was problematic.
- Calling the respective trace_xxx() functions separately on success and
  failure.
- Set new_pfn once after successful alloc_charge_folio().

V2 -> V3:
- Place folio_pfn() inside the xas_for_each() loop in PATCH#1.
- Already defaulted the pfn value to -1, to simple it in PATCH#2.

V1 -> V2:
- Instead of passing the folio, just pass the pfn directly.
- Using the folio_pfn() before dropping the reference or the page table
  lock.

V3 : https://lore.kernel.org/linux-mm/20260824092935.73892-1-vernon2gm@gmail.com/
V2 : https://lore.kernel.org/linux-mm/20260815051924.194810-1-vernon2gm@gmail.com/
V1 : https://lore.kernel.org/linux-mm/20260811133655.267739-1-vernon2gm@gmail.com/

Vernon Yang (3):
  mm: khugepaged: fix swap entry value to folio_pfn()
  mm: khugepaged: fix folio is used after pte_unmap_unlock()
  mm: khugepaged: fix folio is used after folio_put/unlock()

 include/trace/events/huge_memory.h | 18 ++++++++---------
 mm/khugepaged.c                    | 32 +++++++++++++++++++++++++-----
 2 files changed, 36 insertions(+), 14 deletions(-)


base-commit: 1a46b1e97bde62afa7d925bb0dcd9f9748a1d7c3
--
2.53.0

