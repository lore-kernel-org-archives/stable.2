Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118454;
	b=eIh4iamy57BHgTrmF8K3AEcCmFhi2FO820IN7Cb+arIlQFRPxjoeCN71fdur3g2rVorl
	 pjvXeg7btyVEzkJTabafje9rRgE9vEt0Yx2zXY+DSXfNVBIdUnx8LwPH62H5595K+HJBF
	 yaOZrSSevrDH6qMRGogKdpiRxQ4A5u64Ij/W8QaCBT2egS880EZzUJ4T+5TNNuBKXOK70
	 N6WadM7KTWV1w/iAows2HaIGPrsZYU8HbaHCz64DhCdDs11jJHip/fXdlNDOdN38US7dZ
	 pt1EGjrEV5mdZ8JXGfwxi9gG1N1XNDq7Un1CSmARHutgaQ3QiC8RB9XUenmBFMYADUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118454;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=053CHdAKqwJZRsLxQRremhTNFtX9kjO+yPnByzmsEH8=;
	b=Jy3SmkKoAQDgcMPSceK8jU9BccDtxzDbE26M1VkbZWp6f/wYJpcnOM3ZaWT1Q7LW8fWC
	 d2P5zN7UlJnGBZmZTa9fJUNX/vIJUiyPd7P0Ya7FEPBlZYNBfKBGddDbOpyD2OUWYGVNx
	 0O35zXv+5Yzq2i+V17gu00MFA9MFvYRYUDIcuHqLdJDVi+IXqr/9p7WKP45ztzGlDc1h/
	 TpuNFbwe//vdXfpoR6RamuiakxeanAtx9d1OwaNMCGLH/wObyx4dt0sTQS+gdaYTqYQYK
	 zp5FCFT5ddSVjXtSWPrBWnW7KnuqcYSwpNl65D1Ncnf8ns0TLTu9+t1kMIK5GH4OpJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NkjEe7DI;
	arc=none smtp.remote-ip=91.218.175.224
Received: from mta0.migadu.com (out-224.mta0.migadu.com [91.218.175.224])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A17606A32E
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 16:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3A17606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NkjEe7DI
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vbqDc9e1bh4rE/TeVdLNHpxTFUG8xmq2PmfYrb9R1Ew=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793118445; v=1; x=1793723245;
 b=NkjEe7DIf3imgt7jdO1mWQWHmDHTh9JVE0fJUceCcmzVBZytAufx9uCGrI6G866A/S82GrP2
 yNNu+Yac68LwZImsVfHLia4+6dQIHS3WGu3MpzzE/sRIGAh4XAvcnJVbC143xv+6J1GrkGEQFMr
 5GlsygNU7/17O45eqdXvlMm0=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 009e9fd5f7d68db1;
	Tue, 27 Oct 2026 16:27:25 +0000
X-Mizu-Trace-ID: 009e9fd5f7d68db1
X-Migadu-Flow: FLOW_OUT
Message-ID: <137d6cc0-413d-465e-8476-a6fa14b5c2fe@linux.dev>
Date: Wed, 28 Oct 2026 00:27:15 +0800
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
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Pedro Falcato <pfalcato@suse.de>
Cc: akpm@linux-foundation.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 liam@infradead.org, nico.pache@linux.dev, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, usama.arif@linux.dev, kas@kernel.org,
 jack@suse.cz, djwong@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, hch@lst.de, ngocthang2710.1999@gmail.com,
 syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20261026152013.10511-1-lance.yang@linux.dev>
 <321017a4-58cb-4178-8ff2-055a9bbb28b6@kernel.org>
 <auCg6dXegweUB5m0@pedro-suse.tail5790ac.ts.net>
 <b47ec526-78b7-440f-a034-0a4d5137b549@kernel.org>
Content-Language: en-US
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <b47ec526-78b7-440f-a034-0a4d5137b549@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/10/27 21:58, David Hildenbrand (Arm) wrote:
> On 10/27/26 14:05, Pedro Falcato wrote:
>> On Tue, Oct 27, 2026 at 12:06:05PM +0100, David Hildenbrand (Arm) wrote:
>>> On 10/26/26 16:20, Lance Yang wrote:
>>>> collapse_file() can call page_cache_sync_readahead() while still holding
>>>> source folios locked. If truncate holds mapping->invalidate_lock
>>>> exclusively and waits for one of those folios, readahead waits for
>>>> invalidate_lock and neither side can make progress.
>>>>
>>>> We need to release those folio locks before starting readahead. On a page
>>>> cache miss, roll back first, populate the collapse range, and retry once.
>>>> Doing readahead after rollback avoids an extra pass when all folios are
>>>> already present. If another miss occurs on retry, give up rather than keep
>>>> retrying while truncate or reclaim removes folios.
>>>
>>> Makes sense. So we simply try readahead on all folios.
>>>
>>> Any reason we don't simply add a second loop after the first loop where we don't
>>> take the folio locks and do the swapin/readahead dance, then a second loop where
>>> we do all the other stuff?
>>
>> I'm not sure I understand. You want to nest two loops? Or do you want a loop
>> upfront? I don't think we want a loop upfont. That's slow and involves
>> starting/waiting for IO. Fallback logic makes more sense IMO.
> 
> I'd have an earlier loop where we focus on filling holes, and grabbing folios
> then in the second loop only from the pagecache + trylocking them.
> 
> That would make the second easier to the eye.
> 
> collapse_scan() file could just indicate if there are any holes and whether
> looping makes sense at all. It already does a scan.
> 
> So you could just skip the loop when there is no reason to readahead at all.
> 
> This function is pretty horrible and the retry logic doesn't quite improve the
> situation.
> 
> But no strong opinion for this fix as long as we clean it up properly later.
> 
> (looking forward to reworks)

IIUC, we're good with the fix, so let's keep v4 as is and leave the cleanup
for the rework :)

Cheers, Lance
