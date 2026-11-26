Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795724602;
	b=h1zjJzxaay5wCRCQj47E/ZTLs+TMGDdC7vC9s7Q9wp2eOSvs6NMYhl0i7GGwcqMSoqpg
	 cfyBqMjBlqvmi/MKVGLqKwdbcAOM+uC1OlGdd1j4mxoKR0ZbRhKemkTvXZ7/blUf4AwWE
	 mhLgVmj3obqBcXkLPlR3ylT/WhjjMCsIX88OYYW1hj43dToDzgA8mlhCNRiFTjSVDsMT8
	 IFunfDL03CQg99FpuYYWp1QOwdOgvyJs8TApN0eFlc9f8xhNVgWjOLmxmytS/FDRnJcix
	 sm0xC/h9vZ0f542yZ9YI5l7jCAorV4D0JQGjP8dG0K1SBazb0vTzX+D+P/Q2BhHhJyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795724602;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=nwNmT3+N2K6C+WQBtWD0mcJtZx8RSgDfIN1Kq5hD7g4=;
	b=cJmNbfVlibS9tT3nLR3qPZ30Hg6jJhZw0ysrz9ypPB2Lcuqk/gGTVtSlaVMYFWOfX0zD
	 xsTJWGhlypYPXykcSuofJFRH78YMp1PzRSJXN+PbWwJy2mlFT19RV477XWLASQo7gKP1l
	 rw34XIxgkQc3O6Lz5Rr2Cc+DhN4OgWnEf6xh2w9NZVQ2O834ROgHEDB6Y2Kas9R2dWb7R
	 Hu/xqvlRi1b5g+54NUNqpWCU4VEU/JPrJBYjL+Wa0f9AtdP1V3NSwE+zeJ61DgZ7sgx5l
	 Bipx+f1Xxp20ktVWWNpnoM31PoP6EhuDY1MzGfrkiUustuEG+8dR/r1S9tttAJaL3Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ywB1p9iP;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7209C606A329
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 20:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7209C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ywB1p9iP
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-490d59c3f0aso3402217f8f.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 12:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795724601; x=1796329401; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nwNmT3+N2K6C+WQBtWD0mcJtZx8RSgDfIN1Kq5hD7g4=;
        b=ywB1p9iPdGEmqVZlkXKOggU5r1cO44C0Wi0MdMKxLdnecPUPgaerI5xVKkpNtv7nnO
         4DM2RT2c4FO2eYnhgZvBT6hJfJ9XWZQqXyaHhuSYwvNo/2g+sZDEsrJpu2DkMlFGC1nP
         B4tYXQApvotMYA4u/iKyWF2HTeYCDeYuzVgM7LQo9y+5qrFykHDB9/RRzS2IAajn5W7F
         DlFcBX1D9ptI0E3SJCVe7esdLI5zV8ekdGIKqmPuyO5hwLAPyBVDqSxCzbh1+qojhimM
         +srEKo82XpEU3CEFwh1cP67/yK4kPYhznK3LHYXTF9VZxBaa3FIck8oGpj7BxlBEWlkA
         5R9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795724601; x=1796329401;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nwNmT3+N2K6C+WQBtWD0mcJtZx8RSgDfIN1Kq5hD7g4=;
        b=knfTDLX1VzSXnsZLCWNP/Xy5ID38GtOigs3VCHLE/jkn+/NIOPKz9Yquc8iolcWfsm
         PIRWE5YwBe7WbWKtRuSws4A3to06qP77XwtMiFzm9FOK1F1BDiBugctWD2P+tu9RAED5
         CiLg6jtDgiQCFvFh/5mYrBACfKF8TYm8RC9gbcTJ9eaJh1E+ltresYFGbGM2BrJLa1pH
         D3McEjF/r6DRBfEyGIy8t5Nafx3hg63VKN/BzqhUVbitohYUMGjDLMpAQvWTfdM+zxV+
         8wpiXFXsHkYBoYuH2wjTFbcfopeo6MWHMdt4+efDOxM3Rl2hxeHTizKMqyJ+fkNfdj7G
         hYVg==
X-Forwarded-Encrypted: i=1; AL+hErG9hQyCW6bK3bcQksdiE2JU/AiPfVlW7aNCFF5T+5V693/0DNYtnrqcvZz2tnvkwq3qUit94pM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Df5aGghLPg7gHOhuWvb2pca9dBIuPJxFPw4ZjJ4GnrlfK2YuM
	Bico7fWmYw+5YtPDnkMej7tTTQS/Y4vXnHbKLSRXZy2lENgSZzcydgt7
X-Gm-Gg: AZFdTZd2XZMG+X84bIJ3hirzwU7E9Cl8d9m0MisTcqy6xJKrziPI10zszbk0ayOvIg0
	P5FqDeKMG6khRIJDvy15KPxEq2BMMh5deR3P8SV8iZO1loBL0hSvS+JBqw7Uy4I684qqSLs6MRp
	TbCQ1uTik1y8fOUxEXMrQuc/cM24YpFHyTIGf3FlSQOom+PoNKe4UKPagoMGF/6LyKy1Z8M7Gvp
	9WSxogrCDs3lBaqIRtJAWiS92sVj7A011CCnHSmTzPpoIF1i2K49nplAuZobsQGD4PilY1H2hzr
	bD/NZRJ/eWDA64xFVgGlKPNYCCHJfZ6WVCSVnwEZHxCuN6Tq+TYSsuhALFag4zr1wN+cqSYew8l
	LKiZmWTKgGe1BeupM7bonz+qwFVrxg6BwavxyUxGQU+Ht19qH5OrVwqzEmw9xas2imu183A6UrW
	OKzlXYCIYWcITi0gj/hDpNkh80jL4m1h6T1IMANoXrm8kiqkyfFye9966hue+if+Zwhlzhlb8yk
	1cwV/rHBDTOuFH/vu9PsEic5LqS8XGEOtMDBarWz3c7e8FFH9bt7SsCUrwyUxw+HvML9kaL02TY
	vJNmTW2tfEuwL2iC0eP2nQoik7Yyjfq68Nt+WBkdOO8skQ==
X-Received: by 2002:a05:6000:2586:b0:4b7:760c:70db with SMTP id ffacd0b85a97d-4b7760c713cmr19227429f8f.4.1795724600577;
        Thu, 26 Nov 2026 12:23:20 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bb989eesm43021525f8f.50.2026.11.26.12.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 12:23:20 -0800 (PST)
Message-ID: <c5bc383d-fd32-455a-b946-e5f232c7fdf3@gmail.com>
Date: Thu, 26 Nov 2026 21:23:18 +0100
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
Subject: Re: [PATCH 1/4] mm/khugepaged: allocate page tables before locking
 the folio
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Zach O'Keefe <zokeefe@google.com>, Lorenzo Stoakes <ljs@kernel.org>,
 Dev Jain <dev.jain@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Hugh Dickins <hughd@google.com>, Kiryl Shutsemau <kas@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Rik van Riel <riel@surriel.com>,
 Song Liu <songliubraving@fb.com>
Cc: "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
References: <20261125100058.15200-1-azpijr@gmail.com>
 <20261125100058.15200-2-azpijr@gmail.com>
 <042ab922-4707-4c96-80a2-83a0378646d1@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <042ab922-4707-4c96-80a2-83a0378646d1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/26 5:24 PM, David Hildenbrand (Arm) wrote:
> On 11/25/26 10:59, Jose A. Perez de Azpillaga wrote:
>> try_collapse_pte_mapped_thp() calls set_huge_pmd() with the folio
>> locked. set_huge_pmd() allocates the missing p4d/pud/pmd tables there,
>> and on ppc64 with the hash MMU do_set_pmd() also allocates the page
>> table to deposit.
>>
>> Allocating with __GFP_FS while holding a folio lock can deadlock in
>> reclaim. For example, memcg reclaim on cgroup v1 waits for writeback
>> that may be waiting for the folio lock we hold.
>>
>> Allocate these page tables before locking the folio. The mmap lock
>> keeps the upper levels around, and an unused deposit table is freed
>> after unlocking the folio.
>>
>> Fixes: 34488399fa08 ("mm/madvise: add file and shmem support to MADV_COLLAPSE")
>> Fixes: f8a01513f574 ("mm/khugepaged: do not fail collapse_pte_mapped_thp() on SCAN_PMD_NULL")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
>> ---
>>  mm/khugepaged.c | 79 +++++++++++++++++++++++++++++++++++--------------
>>  1 file changed, 56 insertions(+), 23 deletions(-)
>>
> 
> That's a lot of churn for a corner case (powerpc with hash MMU).
> 
> What about simply running in NOFS context when allcoating that page table?
> 
> Apparently pte_alloc_one() doesn't consume GFP flags ... but we could add NOFS
> around the allocation.
> 
> Any reason you went for this more complicated solution?
> 

no reason, it was just the solution I came up with. I'll rework it with
NOFS then, it's a lot less churn.

-- 
cheers,
jose a. p-a
