Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.96
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793933631;
	b=nr2EJNaZnorjcoQdnnWaAs4PVWjXcFalI6sR++My++P6ukfaN4uG8Nu41c452GJvs89H
	 qM+QyoV6WLV7l52wkR4YUgro81PTMwJva82gxqf8YTTG8V+lniHxtALLCY59A7yp8ZLAR
	 H3YZthyhMkO+/t0tidIf91zMhDLH4XAMvBbkD0AvsPuxU+wu9yNZOtwi0zCr2VPlrmZNB
	 LHqpV3gXBaHmxQBhzkNlxiohaUKjQ70ys2/lSC4esa5NO5eZQ3O0JJHoJzN4oPlDxkdnP
	 M35fDu+BcLyAyYwlWm+qD5F1XHU+gyIbIgsrMC5UpQp3qSb1KnsQbugGxKg+QyEREKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793933631;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=p/0b0eFgGy6/51XErR0gRmBAyxz+HU1vOEdRkX/jYa4=;
	b=ASHqsb5C3PI0Jz1W9OF4PlTq6o13EsOubgdRIsTLsaRipy0VTwD3smKYj3sJqLW6gKWy
	 8pO/ATfXTuoPcRQs5L4HBPF/Nm3c/7LZlnzbdyBtuOzFFsXc+ZzlWdy2M7gNV4hsKDBY9
	 6OChheuVV3oFiYsGjD09HLRSpO0yo51mkjTKfi23Xxt1o7ddDCZS4AW17Vg3V7KXqeQU/
	 Hwb2zwZ3g8bxSKKuZIVgqRdKuPqvfn2lvFAo8JCxepqbMm2yu5p3xEErBEkv6FRWvbQiH
	 aKavr2PwcoLTnrjxx36/BeHaS3B8id4Vw29YXGqnJrnjydas2vQjKYHSoaFB5KLj3CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=M9D9cqel;
	arc=none smtp.remote-ip=95.215.58.96
Received: from mta1.migadu.com (out-96.mta1.migadu.com [95.215.58.96])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9CE606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D9CE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=M9D9cqel
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=p/0b0eFgGy6/51XErR0gRmBAyxz+HU1vOEdRkX/jYa4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793933628; v=1; x=1794538428;
 b=M9D9cqelqkYY1RFavnCPTWKYqchdbFaEOL/NPoxfxpdqWxDnWVBcD80nohsqwasPMXtUS0V8
 4cMUG+IQm5nUilGuUux+Uh8CUg/YuwC0IAI9PTv0wC4puA6XnGTTSSXghUB61WjQMSVj/iqfvqA
 A/9cBch4N/fOzgxDDXZ+ipR4=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ea04818497cd00a3;
	Fri, 06 Nov 2026 02:53:48 +0000
X-Mizu-Trace-ID: ea04818497cd00a3
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	hughd@google.com,
	liam@infradead.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	zokeefe@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	mason@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: don't map folios that are not uptodate in MADV_COLLAPSE
Date: Fri,  6 Nov 2026 10:53:42 +0800
Message-ID: <20261106025342.18229-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261105-set_huge_pmd_uptodate-v1-1-a78d8a1b7117@kernel.org>
References: <20261105-set_huge_pmd_uptodate-v1-1-a78d8a1b7117@kernel.org>
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


On Thu, Nov 05, 2026 at 07:16:44PM +0100, David Hildenbrand (Arm) wrote:
>madvise(MADV_COLLAPSE) can map PMD-sized pagecache folios that are not
>uptodate. For example, shmem fallocate() can put such folios into the
>page cache.
>
>collapse_file() already refuses to proceed with folios that are not
>uptodate. Let's just do the same in try_collapse_pte_mapped_thp() and skip
>such folios, leaving handling to the page faults.
>
>Note that collapse_file() effectively clears shmem folios through
>shmem_get_folio(); let's keep this fix simple and simply let the page
>fault path deal with that.
>
>Fixes: 34488399fa08 ("mm/madvise: add file and shmem support to MADV_COLLAPSE")
>Reported-by: Chris Mason <mason@kernel.org>
>Cc: stable@vger.kernel.org
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Nice work1

Reviewed-by: Lance Yang <lance.yang@linux.dev>
