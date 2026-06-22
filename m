Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DCB3546C9
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 12:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782132761; cv=none; b=nxrXXdHOXjyTPSiHrFgzurimnTWOGYTz559rg2IO0VjFeb/jh0QB+kSeD17G47WPne/8ZhAc2VxnJSufzWVo6x23W/WUqzsqxQcaC+km3f+O8tercEwdJlMb7IeIXnIopNAIRez5JxHnr2pBkg9X6O1Po4jgkafYYkZj5n3HHnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782132761; c=relaxed/simple;
	bh=MBz+h47MmTD70ZaqGtUgz/W/wnaBNDcGNSbdyOAgvGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntppV05JJb6JzWgbv/CAjdy6mBHEbYRMMI+nluG/6nfU4RLL1jZZIcr5Po0/gjip8FzfDuzfq35IdgH0p/+w8p+QPAAA2WzmV39fGpjNXuA+CxM1Xckrd352AX1A8kgH8un9mlDk+KlZsYhRW+kpcoDJoL4yCnexr+xYK+BNrk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULbo00M0; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULbo00M0"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c029505b389so907815666b.1
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 05:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782132758; x=1782737558; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TkQhP0uWUVoXEcgVjZA91Kv5N2KnxefpO2wbntWaF0=;
        b=ULbo00M0y70sujRnudTfMn+YxkfzM6OVON5tNBoVS7+aBcgTdRGVojhLWoTTE1C5au
         C/A/CrYpr7Cy48qcX740gy7GEpyoIreBYKfDynLFqs7sL9YnuiDbw5bRvtYGl+tLUKcr
         1pTeEmWxyKRxqQc3OgzVfcxy8/KXwl8bVyM3/Y2N5i4n8MdVrZNV16nxEHGUDChr0udB
         FbXna+vTp6lXpCqQTYoJ8l4QMcLSDOFymw+8rucnmmnudqR3YFrXg0XYJ6rIfeMkNrT9
         dbsRrtum2bq+uFjp1Choa2TSFAh5FCkF4CEZALLMz4rsgR2Y46wnvm508y6oAZij30Ua
         oLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782132758; x=1782737558;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6TkQhP0uWUVoXEcgVjZA91Kv5N2KnxefpO2wbntWaF0=;
        b=TsiFed/4/BoGfh7qq8n/TscrQpDDaALfXDw8QN1VU8rH5zkenImQDuJiiEPgpeI0Iv
         SXOzJA0fVY6crQwdVdPYYywcIbXyACaa73mUC+375dctwJVoH6u8LtG0HxbbHOmnk8Iu
         mUlOqqnhT4a2tuMclzTYrqV7KdI6NC+0hkHMCfPtfBRRC0N0p5cEK51hbcsF9Fm4LN6V
         IkbqeLE/KVezPC/suPVPO7wKIDAqdlTF0EFSrrlcmt0ttUeCx/3guLXpi9EmY5RYBAz7
         XvIr6wcdeG7vJ93RadZVncFFGmYw5BI0g1JuXgKJDvaWtDhFDgR6VCc4v1rJOB1lDnpL
         QUyg==
X-Forwarded-Encrypted: i=1; AFNElJ+E/vY0fLetx5FimlZxLQ5sWWQyqiTOFu9GRCaCTRHo1xrlVkkOTOR62zHZGgZBcxC7vHv196k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0qzBOm1Ru4ZFS8vLFuwXKEHKuTC+FtP99EXfrQxVhhrjyGItG
	wjxmOZB72Gsh21lTnyr9Lowi4itZUKd9CT/AD+fEiaYTPDCkKaDR+m/k
X-Gm-Gg: AfdE7cmu98b+Lsucd0Qc85+F3XaHEcUQu5JsInDfs5w30pLWlN8InXUEalnn8uT3AwU
	r7RwDUGDsl8mYy4tBALx312H1+ibU8o0bf0GzLajst8CaQLgEFDw9mpyepBC8TeZRp+1fl5Z7/W
	pPn0xYC5ZRZixV0JQuXSdUYtVmjlyXbLuJckcJJOtb4XuhVqqp01kpDobtQaJPHEU/IDTJEd/3F
	VaXy7FB07F6cvFVatBMxw3Y4GJdP64Q19f3Os3q6xNrRJnro5YY9FDKUm26B8JqXwCcFMWoBU6b
	xgvABdfXOFDkl1EjXEDSDTIxqQON1myZFlNg3dVcDnnnRJlk2bGJNuSjThz1zcBPXhnc9kHbN8Z
	A38nug5QA5Fj+VaR/BS0vUDx64s8G5nbis4XxculKISMIQQfz/xOrzkm9XDPUsL3cedZtbYkjD8
	DDE228biNlHSE=
X-Received: by 2002:a17:907:940e:b0:c08:580e:899a with SMTP id a640c23a62f3a-c09b7b99854mr653419266b.10.1782132758077;
        Mon, 22 Jun 2026 05:52:38 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e49a9fbsm354825066b.12.2026.06.22.05.52.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jun 2026 05:52:37 -0700 (PDT)
Date: Mon, 22 Jun 2026 12:52:36 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>,
	akpm@linux-foundation.org, riel@surriel.com, liam@infradead.org,
	vbabka@kernel.org, harry@kernel.org, jannh@google.com,
	balbirs@nvidia.com, ziy@nvidia.com, sj@kernel.org,
	linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [Patch v2] mm/page_vma_mapped: revalidate and do proper check
 before return device-private pmd
Message-ID: <20260622125236.c7uqapdqn4bybvvp@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260616063436.20455-1-richard.weiyang@gmail.com>
 <ajUXNjRMraKb6k2n@lucifer>
 <5e7f7fe5-221a-4fca-aa76-297ae19eb80d@kernel.org>
 <20260620021353.nn7xp2ldqachq7gp@master>
 <35b8dea6-3f0e-4e95-bbcc-bb778e567d20@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35b8dea6-3f0e-4e95-bbcc-bb778e567d20@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Jun 22, 2026 at 01:33:28PM +0200, David Hildenbrand (Arm) wrote:
>> 
>>>
>>> I can then follow up with a proper cleanup.
>>>
>> 
>> I would like to do a followup cleanup for this, may I have this chance?
>
>Let's fix it first and then decide how to proceed with this code here. I get the
>feeling that some more of this code might deserve a cleanup.
>

Sure, I will prepare the fix first.

-- 
Wei Yang
Help you, Help me
