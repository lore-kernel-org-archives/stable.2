Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526666;
	b=lnrvRWGJvg5A36rXp9r5zMDXA2Jo3w9iYPnfTBQgsBTEy1QHxy2AiqYA4n64tmq5l1AF
	 QkcmajjrmJd13cG3zFZBkWIF7Xk+AvaubbTeZYhUSPk0UjTCfYi4oTJxCuXduErG4g7Lz
	 m8bbVNY2VWZKP6DuZQZO5Ut4idNULBwR7GP7IDIhoBZX/yFeipA84q6jzaVQC1SdX0fMq
	 ijB3XQTqgUfB/fMGMJkMGr6eofhAUA+c8KGRHnXUs6aSlJBRe/vbZYEmRgGLEy/oOLidC
	 U544X70T7ZDnPqsGH2mSP0t/58Rvm8kjpGMl2uh5YDwdkLwy0TPP5KNeIFwiL+E9bIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=j2lGOfpuqWA9c5CeS3NsQ/3TJJfRuyj6wTBADsS42iU=;
	b=lyTDsABIdiJhbNXSwtRziRgQ0oLfqzHUxaC+necXplVj297Zv8/MlEjJt5sX7VExFldf
	 O+VapcSMkoj59OxXSX2pv+YlggJNrHLqPpz8hf2fQJ2u1ijRPR7uRqDG0ZyMcVHa8ej4B
	 nE9OXqWtD75ZRs264Vbnw8nPoNnx8bmBIeK1+elQzDgQgCN3mJR9DOwPx3C7Wmk4dI5PD
	 GUdjna2sVViCPWekn3ZBWXVbFZQHZWXn2dgwOC8gfU91OHa/CaMEMjnrHLukvc+njdcON
	 wOOc1LmVYLis82g+Msxpwf+KidWKIRay95M6DKDtakxm7x34x1RTN0r9EzPUvQ8irCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="e2qVYdC/";
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C82606A322
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 13:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2C82606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e2qVYdC/
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb85e07aadso54918125e9.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 05:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795526664; x=1796131464; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j2lGOfpuqWA9c5CeS3NsQ/3TJJfRuyj6wTBADsS42iU=;
        b=e2qVYdC/mXdjFACrZz+884sYdtZuVnERtWgcQhcsucfmOtRPjnYpcroO1cl9kYtRrz
         Ipz+u4I+zinaMDaKG9o+E5noYTt992UI3Ana8d998e3XOlokRkou7fZ4YKzI+NvFFgvJ
         ASYWizXvFH2Lu0l3xKj/mpyg9xKlN/tOvjqKNh/0CBlOpFU4EgIKn9guL186RrGdMWwn
         HDkLXY1jUcMNWSZDxI+xwV1UQ022sX1aX3eigoLqFxqR67l/iUKRPgVZNsap7uuOrrVa
         4vN8Gw8pKQMm+mEP/GB4J3/mlMyYNCZehrYM+9PNIwihO8Abe6FaR/dLZbGVXccuFaLd
         yL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795526664; x=1796131464;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j2lGOfpuqWA9c5CeS3NsQ/3TJJfRuyj6wTBADsS42iU=;
        b=gLpTMySRw1FfyF6NlB2MrQIIxfb+2oZzmfIdbTVwhRplmzGDlMgqbhwE75rPXYNV0Z
         O5NExU2HE/UTw3QLlJNjhbvGclYf6cshk85Tgj+RDJoVipvsJZgPfeCQVJkTN18TK9HI
         Lqn8VUIR8zEKTEdfJaECIpe8owQHZtsQuFlm3SgECMRMWNkfFJVTIqQflYz+UVMqPQ4r
         v9gt7bc/ztxfHjfTLXEtqm6JJE9rHTCrnFGOKqgUmMhHSR4tnr1CWbGCMNxYtTkD/Fzd
         4SLMSM24vZme6hytuP60+aW5MxEavWv+Ib/keEZ5/a/SWjiuG3jw/T7aK320P85c+vlS
         c5qg==
X-Forwarded-Encrypted: i=1; AL+hErHwLPSut/l/9wTEt2TzRBuTd0eoJEyUQl2iQEthI4cjO3nFOtU3c18r7Z9sDydLJI+xqnPw/To=@vger.kernel.org
X-Gm-Message-State: APuU4Z+pkCtr9KROXQeJdrAaLkzF9BFjIWX/I0vjU0HzBzcX31NhUCjm
	HYt3VWqrnAue7Nsuyx3V0W6tI5lVFYKhjBpqGZFcTbJKfSgOwFbMzhnK
X-Gm-Gg: AZFdTZctfNceG0TMwdSGVIGv4DSg+B13hn0EEx1XCYQedN7VdiQ/2iYGceFudn+ZEZu
	zQIWAOKgZXg3gfe3HjwKNKIJ1lAJendN4OisXAMgzJY7chpgSSqUp93V2fMcb+Ztp3U8sP6gr+o
	fCBsEIYz7Nqb2ftEFcWNgZ0QJVtmowHaDiqSJHesi3wkCXNsG8pPFUJdJoU7PEWYcxoGLXsxDiK
	kk5Qm7CUk+LCPkhU5jMvcbJsXeA0YKGgczEGhBxX+b3zIcIrO03GHYRHo9uFwinLAUg9ku5MUh/
	o7vHwuFEicefdd11j9OjyqpJCZXhUR4qyEQjtVk9Aro+PeyGhO5okmUyP3Aaj/WDjzLj5PHjGd3
	ulm1zJs4oxYfD0zIhsz0mUDg1WqdhjFFgZuLwtJMMLFWJTQ7zcALC59kCCJQK9i75qgebPbhBIf
	X1xlBhVxo1KsRAFJFi5kP6B0XW/gPnSiY4KuT+mWIHvgjB5OuHlnoySKDfm8p+2ouH34wi5EOCP
	z0cTG75vby5cec1+1bCjyNI1OAIfLcVTHLSEEP0cfY83aRsjYupdmfApnlkA0tu1qGcubL2DooL
	xS8Wz6NiMNy7exi0SnBgW5wcpcEd2jYhXvPSFGxjjnqrOQ==
X-Received: by 2002:a05:600c:64c6:b0:4a3:598e:e7a8 with SMTP id 5b1f17b1804b1-4bb887c2c98mr274938815e9.4.1795526663725;
        Tue, 24 Nov 2026 05:24:23 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f281sm26298695f8f.22.2026.11.24.05.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 05:24:23 -0800 (PST)
Message-ID: <7465de57-8d97-4952-9daf-d95bdb4b7e78@gmail.com>
Date: Tue, 24 Nov 2026 14:24:20 +0100
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
Subject: Re: [PATCH v2 0/2] mm: fix deadlock on the folio lock when migrating
 and splitting folios
To: "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 William Kucharski <william.kucharski@oracle.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Johannes Weiner <hannes@cmpxchg.org>, "Lorenzo Stoakes (ARM)"
 <ljs@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
 Chris Mason <mason@kernel.org>, Chris Down <chris@chrisdown.name>
References: <20261124-migrate_reclaim_deadlock-v2-0-03cc147e1e36@kernel.org>
 <66e5f9e3-17d4-4635-8919-c67ed562f9f0@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <66e5f9e3-17d4-4635-8919-c67ed562f9f0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/26 10:47 AM, David Hildenbrand (Arm) wrote:
> On 11/24/26 08:56, David Hildenbrand (Arm) wrote:
>> Whenever we allocate memory with __GFP_FS while holding folio locks, we
>> can deadlock on the folio lock when triggering direct reclaim or
>> compaction.
>>
>> For example, evicting inodes with a populated page cache takes folio
>> locks, and if we happen to need one of the folio locks we already hold,
>> we'll deadlock.
>>
>> FUSE makes this example easier to trigger, because it evicts inodes on
>> the last reference. A similar deadlock with FUSE was recently fixed in
>> FUSE [1].
>>
>> Let's handle folio splitting by simply running in NOFS context. We only
>> perform small allocations, so it doesn't really make a difference.
>> Interestingly, this also fixes one of a handful of possible memcg v1
>> deadlocks.
>>
>> For page migration, change the code to allocate destination folios
>> without holding folio locks, which is in any case the right thing to do
>> to reduce folio lock holding times.
>>
>> Some of this might also be fixable using Jan's work on deferred inode
>> reclaim [2]. However, that is not stable material, and not allocating
>> folios while holding other folio locks is an improvement on its own.
>>
>> Unprivileged users can trigger this deadlock with FUSE and
>> mbind()/migrate_pages(); however, it requires multiple NUMA nodes and
>> quite some luck.
>>
>> I reproduced the original deadlocks with FUSE and made sure they can no
>> longer be triggered with these fixes. Further, I ran the usual migration
>> and folio splitting selftests.
> 
> @Jose, could you find and fix other cases where we allocate under the folio lock
> with __GFP_FS (and direct reclaim enabled?).
> 
> I think at least do_set_pmd() might have a problem when allocating a page table
> through pte_alloc_one(). And I'm sure there's more.
> 

sure, I'll look into it :)

-- 
cheers,
jose a. p-a
