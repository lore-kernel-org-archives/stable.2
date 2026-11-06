Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974755;
	b=3Y5YTe93SuUvUgWi3JMmIDYMtVQwPFeWaajXyPbWJZkAfROEbnNz553fXjHfgMi5alI6
	 7TZPGS9MOgoDCzNE2sar/1ZNzFqMuq+11CVCo4RcxJy3rqmgKecSdsMZ8gzmU7e9tnyrt
	 pn//gm90kt1wwiFd/y7L+RTeg68qSlUc7SUCCbZknDTfg6ha0i2BYm2DWf4Cb8Ofqur3n
	 jN/hR1C6wQdD5R6L3Ns2upSwEwAOOHKWBr9M/4m7fQ8Fd8glrLXFQ20DlnMLCuK1etpg+
	 w8cAb7+Tn7MqBSaeO5k/HbwrRH7JxfYPQ9H88PoiZZaHx5CacovAYqFWl8eVBl6VSsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974755;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Mj147cNESXGoHXlvAzbxpGpmr95p6iDfBMnRQY2C7B8=;
	b=Sib/xe1KDZ5C7UEWTOrHNY+f4Qlrf99zlEeJrl/5l2JOQqZmF0JTjIuMnjt+ey4+a3cP
	 7dGcfqD/2giSaQ4oHZGe8md7zEGCVHFNTcSAApBbJbIW/R3Cd9o4P1Ic8cxktfP5CroBT
	 jW+Yb9LVLQ3mB1GO/5GdQDXk6DrXnlvrUMjX2M4R+1pAt1ybAkuPIGzN14qrqdiWj9yXr
	 14JwKYFKNQlmgkYn1LDsjtUJ5BIpha60T5+SdYgfsr5ps9c5j3sKNakQUgY3Kbkz/1WQ3
	 CqDd6KA+MiNfa0CIVjW7+zvkg+xIh1hMGT/e4pWw3gnqTx8o7NjjlfuYM4X31Tjh45Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=glNjLAFW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DA7606A326;
	Fri,  6 Nov 2026 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=glNjLAFW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BCE1F0089F;
	Fri,  6 Nov 2026 14:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793974755;
	bh=Mj147cNESXGoHXlvAzbxpGpmr95p6iDfBMnRQY2C7B8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=glNjLAFW1fuGqbZDoB5SwTXJ1klRGdu4dM85avTojgRKe6Nvf+K9w/+QcqV01wJyz
	 nsds+R8YBm9rxSjVpTuMb6gCEO1/qbeh6mEok02DtM14EcX+d/OJIL0T3t+hNhBR83
	 SVDFpU/E9Xe8cejTsae7oMzZht/QMiVKCsnWNuBkiVd6baNt5XXgRd1Up5ZIRZ1YUz
	 11qGRvlzaQWoH1rxR0FlUd5W528hrqReet7m2LPNbU1DMCUl97jInKhlA68OgopVJK
	 zUR/ZHWrpWx1Hc5A2gJ3FP3BrYyaxlGAvyLFJsyXOhm4UDTHVtwBfJXMMfDDFOAy1T
	 3mbwikECpbBUA==
Message-ID: <41b4de46-4f25-46bf-8b34-02577c38ef8f@kernel.org>
Date: Fri, 6 Nov 2026 15:19:08 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/khugepaged: don't map folios that are not uptodate in
 MADV_COLLAPSE
To: Pedro Falcato <pfalcato@suse.de>
Cc: Kiryl Shutsemau <kas@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins
 <hughd@google.com>, "Liam R. Howlett" <liam@infradead.org>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Chris Mason <mason@kernel.org>,
 stable@vger.kernel.org
References: <20261105-set_huge_pmd_uptodate-v1-1-a78d8a1b7117@kernel.org>
 <au3C8lNElGg4LnR1@thinkstation>
 <254c6f0a-9353-4806-a5ab-a071cd59c64f@kernel.org>
 <au3bJel0YnSeowCq@pedro-suse.lan>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <au3bJel0YnSeowCq@pedro-suse.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/26 15:06, Pedro Falcato wrote:
> On Fri, Nov 06, 2026 at 01:29:31PM +0100, David Hildenbrand (Arm) wrote:
>> On 11/6/26 13:09, Kiryl Shutsemau wrote:
>>>
>>> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>>>
>>> Separately from this fix: nothing on the mapping side catches this.
>>> Every caller checks uptodate on its own (next_uptodate_folio(),
>>> filemap_fault(), shmem_get_folio()), and khugepaged was the one that
>>> went straight from filemap_lock_folio() to do_set_pmd().
>>>
>>> Should do_set_pmd() and set_pte_range() assert it? Something like
>>>
>>>         VM_WARN_ON_ONCE_FOLIO(folio->mapping && !folio_test_anon(folio) &&
>>>                               !folio_test_uptodate(folio), folio);
>>
>> I think so. But looking at these hard-to-trigger but in the end very nasty
>> problems, should we actually reject the operation and do a pr_warn_once() or
>> something?
>>
> 
> Yes. FWIW, this is something that's been going through my mind. Our page table
> manipulation APIs (and usage) are way too fragile and allow you to do the
> most insane things without ever realizing it (e.g you can clear a pte, set
> over a PTE, get-and-clear and discard the result, and do all of the above with
> no locks held, set a pte for a folio that's not uptodate, set a pte for a folio
> for which you don't have the lock, etc).
> 
> Some basic assertions (even if there's no easy way to back down from those)
> would be nice, or ideally yes a rejection.
> 
> I would just add that these very much should be VM_WARN_ON_ONCE instead of
> pr_warn_once(). pr_warn_once() will (AIUI) not be caught by fuzzers, at least
> not as easily.

Good point on the fuzzers.

-- 
Cheers,

David
