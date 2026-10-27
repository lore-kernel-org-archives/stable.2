Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109547;
	b=b9UIZzEaJsv9LFneLeNxvCIQKuLQBR9BEF5hw7WDrh3Sf/ZzvoO7PYXSdPr0wyPFJKfc
	 77PIgL+s3MU492kkWqaN0B4ZwtkgA0K52u2ppPnh0F/kxOih4VBE/ctmua4ti5cTY+syI
	 FUQx8XuypnaxMw6NGQIdHLYiGlCxr2QDCLv3NDuEKH8vIpkZlOkbcd4QBablzEwDoRcTG
	 o0zuqflycV+veL/lBbdZCJRExKIWku4fx6jg5TvDjwMwPdMjvKKG27lNRNV10oLjTvZTs
	 NSHLJWcU/gYuEU967WSgjp3Fw6wdCN/DQKuPheU5GLDyeKPJJfYZHYkgNaYSnHPjnsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109547;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=k81WR/qvDcIxasabpW38Pkoc1U6DpN2apgQSlcIEcSk=;
	b=GhYRElS7gD4sP6NxhPd0IAWiT5q1kg+IgtCsYqSu5J8XFMQrH8nJJEU6fao3IuFNw8y+
	 FrLhJpTX6Z+xg+9hbeZcsjFpIbfr0Vy2M4So2rD0gg1iKVo1Ix/3QgGr6y1fUPKkuUTNZ
	 Xp9qdkDGRLMHPI0MKjTR9IlJx9x1plxR2Ary62WdFb1rWG/GNpUWWvho6XHyDQDB5uwMy
	 Lr3vczKvNr53onURdeWHmQwK+/mK9NSxdVao8Ai9+EVKnc3IFBBPepoG6OpwWKA7ufjiZ
	 ZNCCakS4EcaPMWMbV49iormFVB0I14i/brV5zRg6fu5V7RcvIvzvR2erObUqLoi70OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eHrUB3jR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A305606A31A;
	Tue, 27 Oct 2026 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eHrUB3jR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4991F01828;
	Tue, 27 Oct 2026 13:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793109547;
	bh=k81WR/qvDcIxasabpW38Pkoc1U6DpN2apgQSlcIEcSk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=eHrUB3jRVGTT5gVd5LhwYjTDJh48kysHjX4M3oar92rSyGEuBUI06wp8/1WyJtRvu
	 MFVNxZiXKv2iMe78Aa+x82OYyF1ICYo6Qc59eGq9QH24bjDczxEyPR9rQYv8tIa8P+
	 1whqTApXHR/S/f4Njb2QikgChQOGQUYdKrifwa8mNYP6KMS/OrDn9NzawHSOEjx36E
	 w2VFvv7ojoUDS5H7JHfZ/H+/bn0sSbJkRYfVMhSQDmgfOHTS38ml++OzkxwhYu26VY
	 uw5thE/0fH52aDlFhf5UAz1g07/UZbcai0NnortUnR6DiY7y1GgcxBECPKc7wQ6L6P
	 muQ7yiZ6QDfxw==
Message-ID: <b47ec526-78b7-440f-a034-0a4d5137b549@kernel.org>
Date: Tue, 27 Oct 2026 14:58:59 +0100
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
Subject: Re: [PATCH v4] khugepaged: fix readahead lock inversion in
 collapse_file()
To: Pedro Falcato <pfalcato@suse.de>
Cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, liam@infradead.org,
 nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, usama.arif@linux.dev, kas@kernel.org, jack@suse.cz,
 djwong@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 hch@lst.de, ngocthang2710.1999@gmail.com,
 syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20261026152013.10511-1-lance.yang@linux.dev>
 <321017a4-58cb-4178-8ff2-055a9bbb28b6@kernel.org>
 <auCg6dXegweUB5m0@pedro-suse.tail5790ac.ts.net>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <auCg6dXegweUB5m0@pedro-suse.tail5790ac.ts.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/26 14:05, Pedro Falcato wrote:
> On Tue, Oct 27, 2026 at 12:06:05PM +0100, David Hildenbrand (Arm) wrote:
>> On 10/26/26 16:20, Lance Yang wrote:
>>> collapse_file() can call page_cache_sync_readahead() while still holding
>>> source folios locked. If truncate holds mapping->invalidate_lock
>>> exclusively and waits for one of those folios, readahead waits for
>>> invalidate_lock and neither side can make progress.
>>>
>>> We need to release those folio locks before starting readahead. On a page
>>> cache miss, roll back first, populate the collapse range, and retry once.
>>> Doing readahead after rollback avoids an extra pass when all folios are
>>> already present. If another miss occurs on retry, give up rather than keep
>>> retrying while truncate or reclaim removes folios.
>>
>> Makes sense. So we simply try readahead on all folios.
>>
>> Any reason we don't simply add a second loop after the first loop where we don't
>> take the folio locks and do the swapin/readahead dance, then a second loop where
>> we do all the other stuff?
> 
> I'm not sure I understand. You want to nest two loops? Or do you want a loop
> upfront? I don't think we want a loop upfont. That's slow and involves
> starting/waiting for IO. Fallback logic makes more sense IMO.

I'd have an earlier loop where we focus on filling holes, and grabbing folios
then in the second loop only from the pagecache + trylocking them.

That would make the second easier to the eye.

collapse_scan() file could just indicate if there are any holes and whether
looping makes sense at all. It already does a scan.

So you could just skip the loop when there is no reason to readahead at all.

This function is pretty horrible and the retry logic doesn't quite improve the
situation.

But no strong opinion for this fix as long as we clean it up properly later.

(looking forward to reworks)

-- 
Cheers,

David
