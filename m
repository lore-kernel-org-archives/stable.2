Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177362;
	b=Vi0uTMP31TQlBQYgnNbRvcVpHAMm5c9SD4Qtzqv7UmQQQUWYffyBwqCzIuNWBl8bXarI
	 zvp9RBRyohgX0jvB1pYNSrpkEyQ2wUKJbFqN0UgXU0Lymc764V5ycw0tttjkgYd8/jGzH
	 dZQnsn7OUoKulIo9o4vnYqbMB3q8LqChr09moI09UznuBbr8l+S9u30s7AchppHPdF/Hl
	 TqJ/GkzJO4NAGyEwDpz+YQ4eEx8Ppadu6wjrZ1IcHwT4qYCAur7x6hKovMFxjcqYkuca9
	 wtsRcraLsiq59503h40NsbFVPir6R8b71wjN10Vws12T49ejr4g7BGFOYBQ7tTDF0UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177362;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YTPXp+rfthb63UDmqgrgjjBHFcdZbohfcfTgb+voGVw=;
	b=Q3rjfU9B1C+J7ap1R+28jovmlxTrEvaMzcqkPBHFfxr8T5662fQgutXi0ORkVT2mB+FY
	 vutzowFbg3OGp9NxSdPyg9iXk60VbLUXjnmnouiRNQop0ckzn78aVAZdZwODIhT3B+qkH
	 1xFVMhl6QLhEwIJTw7PsYLoAzt3C2x6ypMOs3z2beLT81FVNDl/dXK/acLAqeQWOx8xbT
	 i0+evXpsttyQ0vUnEhIijsDT+WmzfrM1Gi0y1QJ5keFQhIh1UxgyBVU+ID9JZYd4um+gZ
	 2lrD6Vg3T1oPL2MnhYso3VtnkuCCo1V4rhg0OQqFdvLa4ZN77t7U+OQ0KVfrZfS+A7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="KmTq/tU2";
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF5D606D80B
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 22:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BF5D606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KmTq/tU2
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b571979178so455753a12.2
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 14:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794177360; x=1794782160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YTPXp+rfthb63UDmqgrgjjBHFcdZbohfcfTgb+voGVw=;
        b=KmTq/tU2byKqoGfA5Mu/teizX7wmKZmVmG0zXIJqaYIv82+6WSfzgcitUPk0ZP+fWl
         xaoMbh9h6RsO+eSsDtYNpE4O8jdqj+17O9UUVHgbqgnI19unpCIdXZXg/o8R/Wiy//dH
         c2nFnH9WX4o3urVTviABdOPGBLjGbpvoG+9tjlAcEl++Ozzsi7XBbp5rum2kj/XoDI7c
         PrnB6omsKvdr8kE3UOmemwFYzluI/NKCr7RtrVFNQfFqwt7sIxNUAWL/DiBB82mXBdCs
         TUyy/lLv9HSj7hm/teFcqEIY2T7Eb6N3M9PixI5kJrJQWU1pbN/YZ3N70NUn12MGp7eu
         kc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177360; x=1794782160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YTPXp+rfthb63UDmqgrgjjBHFcdZbohfcfTgb+voGVw=;
        b=kbGOUmmICnUipUD1YN3S9+ShuJ47Kk11IjoskzLTXyxN+hBDxZ6qK2MAzPCncrHize
         VmO24bz9VHZGC+E3wg3P3ZKqaqcJtMPH7u62BZhTTr+tXgTazStxZ3H5OvvpL9+bFGYy
         SYyMG7z4QxoK/PCsmRsmUcjbPj21/24vQVuVxVJFoXwExoYH/xeLC0CTGlFkUxuvVZT5
         FDjnjCULyqbWFud5cIn3wf5a+LqkXx03We5gQy94oILxwS2zUDtxfU7jUCDoXTzqsTyD
         oXtW7pE9aP/9qEaXzNcSE4DrWOjVB2XelcC5leIQEZ5wd9g7uxI2sn+MRBBXXjpLa4Oe
         Og4A==
X-Forwarded-Encrypted: i=1; AL+hErFkyRfeKCFLFGZY48xjN4rGjXquiuhgbYzhRP8FAaRNrDwtUg4mkoAp/SkXsLCrEDw1rqlwzKg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9BFhnKFMlYXfvO0ToDCAhnIBbzLNptoAV3ToJmknwP34T1XpFy
	Jdo9G3x2b9/9qq4pUEx/N45RMbPvT+OrJIIfyNw+TWTV+fMsAmU675eK
X-Gm-Gg: AYBFou39ef+tOMCOA/qT8/at8unYVOkZQHA+AJLP4wFemski89MqUcxGF3tEMrl0cu/
	L+Y6S2DdwPamtBk62AEEkC1t3LtoBmX76PBAT50galV39aPztiyABEZXQyzEYf6M8Pe6xjK0DLw
	SIeOIhIcpa+9eIhqpj+TFKsEnGTmwNCNP37y1wkwJXgVRfTiG7/g2+qFTQKSSvTpLA5rr6mLYDt
	2F+dIj/QwdFTbhSZa9Jg+0FPuiDwi5wdgLO4XIBRZWtBYT33q7JH5svep4Svht6CcUMPPrF5yaL
	FW6rOpLTpVeD8Gm0Md0NOAJkWykK2/PzrZIFQG9sxfuEbAV4miRWzAGY6NYiLTwMZLqjV1YHiTg
	nHVbunAegFX8wFBpt9YkyF2BIpLQPVK3vv9gQAaip6DPUZ+MijXZACKAYLnU8HdTVsojtO8KJJW
	WeCJcDEp0DGH7nJ+bVLc63AojBDS1yI1H7dNhEUOUCKOdkkUvQqe9boqaDeYptNEpz7okkLPsi7
	cVwuT+Z/0sqqHK5ZxK5i5tmn6MI9loqK7EpvaqTvQcTRc1O5SZMfUlMhUE1JtbMHlFn4b5syDKK
	CI5RqHjhCbTc8WT3ebQ1qR6sgqrR0kx3GOExawrlcjn7yCLOOazTs0++/XfrbEcxoJqGTUE=
X-Received: by 2002:a05:6402:4504:b0:6b5:4baf:ad96 with SMTP id 4fb4d7f45d1cf-6b7224194a7mr1543782a12.17.1794177359944;
        Sun, 08 Nov 2026 14:35:59 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ebc7b0sm859272a12.14.2026.11.08.14.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:35:59 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 3/9] sparc32: do not flush a NULL address in flush_dcache_folio
Date: Sun,  8 Nov 2026 23:34:13 +0100
Message-ID: <20261108223516.1125534-4-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108223516.1125534-1-linmag7@gmail.com>
References: <20261108223516.1125534-1-linmag7@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sparc_flush_folio_to_ram() is sparc32's flush_dcache_folio() and takes the
address to flush from folio_address(). For a highmem folio that is NULL,
so it flushes virtual address 0, and 0 + PAGE_SIZE and so on for a multi-
page folio.

On HyperSPARC, hypersparc_flush_page_to_ram() probes with
ASI_M_FLUSH_PROBE, finds nothing mapped at 0 and returns, so nothing is
flushed at all.

Returning early would be wrong: flush_dcache_folio() is also the barrier
taken before reading a folio userspace may have dirtied, as in
filemap_read() when the folio is writably mapped. Fall back to the whole-
cache operation, which reaches user aliases at any colour and on SMP is
cross-called to every cpu.

Do that only when the folio is mapped by userspace; otherwise the only
other mapping is the kmap_local slot, which arch_kmap_local_pre_unmap()
writes back on teardown. Without that test block_write_end() makes every
buffered write discard 512 KB of VAC, which cost 106 s against 56 s on a
64 MB dd.

With the mapping live and a reader on another cpu, 150 of 150 reads
returned stale data before and 0 of 150 after, every first mismatch on a
32-byte boundary, the VAC line size.

The separate HyperSPARC mapped-folio fix completes the lowmem and PKMAP
colour handling. The highmem fallback can be expensive for GUP: each
mapped folio may require whole-cache maintenance on all CPUs.

Fixes: 665f64029454 ("sparc32: implement the new page table range API")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/mm/init_32.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 7b53ee9f061f..9cf0065fc2d4 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -131,6 +131,16 @@ void sparc_flush_folio_to_ram(struct folio *folio)
 	unsigned long vaddr = (unsigned long)folio_address(folio);
 	unsigned int i, nr = folio_nr_pages(folio);
 
+	/*
+	 * No kernel address to aim at. Only a user alias can be incoherent
+	 * here; the kmap the kernel used is flushed when it is unmapped.
+	 */
+	if (!vaddr) {
+		if (folio_mapped(folio))
+			flush_cache_all();
+		return;
+	}
+
 	for (i = 0; i < nr; i++)
 		__flush_page_to_ram(vaddr + i * PAGE_SIZE);
 }
-- 
2.43.0

