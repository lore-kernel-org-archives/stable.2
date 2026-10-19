Received: from mta1.migadu.com (out-196.mta1.migadu.com [95.215.58.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E304CF490
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 02:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792375702; cv=none; b=Qn/UoAVigrECyahHxtKJiqMCJ6NGgLW0PxhHDayinKwX0YlrP53tAdjoJN3hxIafUqANZqo0LlmC/MXj852MQOnbowzzPqaobraWLaqmcQv7ux7JrCqQCi9pO4s7t2QCOyPyxwKA7Nh32zcsyqdHexHXWdB8S1kAwrEwctiUcoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792375702; c=relaxed/simple;
	bh=TGx+L/6tf3P9BlQx79oc67eTtWqhL3dBGQ6vFXfCt04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKqgSG8rxY0P2qXTVTJBjLx7eU8rnHzYaxaZvEk5547Bq17OgyvFTa2VHnCdyYoSjPlOJ/lsh1hK5SE7fhaCHGxMPKzFGHZly/Y39LgOwCbj6VMEIzU/nQFULAyyiJN6M+zR979x8tQduPcXa7kyeA975+ckHMiofUavq8tpdPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pLDQIBFL; arc=none smtp.client-ip=95.215.58.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pLDQIBFL"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=TGx+L/6tf3P9BlQx79oc67eTtWqhL3dBGQ6vFXfCt04=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792375696; v=1; x=1792980496;
 b=pLDQIBFLOfInEnDPpokkie/UA47oQoauG108QTVlqIktQGJX/n0lLXVZDZOWuKXtaxIxI9+e
 t7N7EyMYplvk2oLpYy6jiHX78FTPXwHt879aOOfRWf5MInsqfJa4L8qEadLpw+IAfh1psjwIs3y
 O71dUGLPE50XIzWLy1W08gMM=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0856886304343c3d;
	Mon, 19 Oct 2026 02:08:16 +0000
X-Mizu-Trace-ID: 0856886304343c3d
X-Migadu-Flow: FLOW_OUT
Message-ID: <e2ea8e4f-152a-4695-bc25-1712e385d8a2@linux.dev>
Date: Mon, 19 Oct 2026 10:07:55 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/ksm: keep soft-dirty and uffd-wp when merging a
 page
To: Samarth Narang <samarth.colleges@gmail.com>
Cc: Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>,
 Peter Xu <peterx@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20261019010934.697895-1-samarth.colleges@gmail.com>
Content-Language: en-US
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20261019010934.697895-1-samarth.colleges@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/10/19 09:09, Samarth Narang wrote:
> replace_page() maps the KSM page with a PTE built from scratch, so the
> soft-dirty and uffd bits of the PTE it replaces are lost. Due to this, a
> write before the merge no longer shows as soft-dirty, the next write to
> a uffd-wp page raises no write-protect fault, and because the page is
> mapped with the VMA's normal permissions, on a uffd-rwp VMA the next
> access raises no RWP fault.
> 
> Copy the soft-dirty and uffd bits from the original PTE to the new PTE,
> and restore PAGE_NONE for RWP VMAs, as try_to_map_unused_to_zeropage()
> does.
> 
> Fixes: 0f8975ec4db2 ("mm: soft-dirty bits for user memory changes tracking")
> Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
> Fixes: 2d427bb01639 ("mm/userfaultfd: add RWP fault delivery and expose UFFDIO_REGISTER_MODE_RWP")
> Cc: stable@vger.kernel.org
> Tested-by: Lance Yang <lance.yang@linux.dev>
> Assisted-by: LLM
> Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
> ---
> 
> Notes:
>      v1: https://lore.kernel.org/all/20261018122957.526467-1-samarth.colleges@gmail.com/
>      
>      Changes since v1 (thanks, Lance):
>      - Fixes: point the uffd-wp and RWP tags at the commits that make the
>        registration modes reachable (63b2d4174c4a, 2d427bb01639).
>      - Shorten the comment; the uffd bit carries RWP state too.
>      - Add Lance's Tested-by.

Generally, no need to rush the next version out, please. Let it soak for a
few days so folks have time to review properly, instead of making everyone
start over every time. Just saying :)

Cheers, Lance
