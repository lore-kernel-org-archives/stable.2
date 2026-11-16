Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794850828;
	b=r+ZW2zGS1mG9xEObzTgTxC0jLD8oaJBc28eZBdP/+WpOLK34Vxz9NrN4TTLLtR9IFPQG
	 brx6nHehXynHd8oZ88VXn74d7kzlwLGyJhgwR7Vdi18JbPFqbTqwfERQSW6HHMagfafbv
	 OfcvSctW9ocu/yxeJsMM1ttT61ehN2YWe84TG36eDOwVpSdH9lV+8S7CkKKJ/irbzQFEe
	 w7PkGXiw3vhw+ltWuPCJWuZov6MQNtVy78YSidlhS89v80GwilwVsSRM+sjT6USIaBnj5
	 nfDATMZE7TCcghxnC/GpCsOFd3CS/c8fo1rnmfyCpvo/Vs37Uvu/ojjL6fwct+UMzwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794850828;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=YjLseNf2hnBu+sCpNnb8CVwZ4cVJDuEl0f+BAYdwnZg=;
	b=XO4cIY3h7kDusJHOauk8GCYrzSpD76W3qoRiYtXKyFB+sdoQmmLFHiEBFmcnnFFXaYT2
	 0RMPzX1I+eTJJCtNdoRTTfzcuOM+jqD3Kx0MnJUfjy95iG5IjB+ED9J/MHIBneDM7Z29/
	 rilbEQg03jNgdolj6ONb+5igD/MhATn2wTVZA+ELLAQW2l9CmGLHyp9S1AY/mq97OW+VC
	 i9404qclvdjtRtKEYCdW8lOBZbTeLQ/ocDWnIzOVTuK6Ir9vpqZHa7yMXIuxt2w1At4Tu
	 SrYhLMsWkMi8QTDf9ObMs52egXltsSWIvDL5eXXzYp2LmAEPG2DLkcc0TefIzu99b8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=NKmhI62o;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB926606A322
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 17:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB926606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=NKmhI62o
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91e8a05ec5aso57924616d6.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 09:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794850826; x=1795455626; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YjLseNf2hnBu+sCpNnb8CVwZ4cVJDuEl0f+BAYdwnZg=;
        b=NKmhI62oWAb/qvj/gB+l64VYwiQsWDILUIMQgSSTq/z2zZxK8trDs32EdNKvapU4kJ
         /k89W4cMt9/hEvQKAUWIRpsSwZgtairjn3wqNg2mTdgzJ5tEQjU0JkBDqhWuV5WVEtVN
         z0CUx16shpdXMDDnwWNsaOT79rIAUCCUbbeEgxYFdNkH+mOGvhBx6ERrC55RfLaOX4Fl
         BCTW7VXySTVKX2cRNDRgUS3KOXhsY2SOeVeJlPiC/jf3WudKnsQVU4JelHS6Lb3+fwfS
         M7x7YMuI8PktatMoWWn9kCbWyvkh9sNv2fRXZu2bhfTN9/gJxapJShdYOdTZC8yhMhDj
         ZXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794850826; x=1795455626;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YjLseNf2hnBu+sCpNnb8CVwZ4cVJDuEl0f+BAYdwnZg=;
        b=H6jaeYg4zPszr+8kgcg/vgwXAW1tN83LMjuISrlRVC6AXmbS9upJ3QOnaVsk2AelCG
         tD8A21CCVTD+V2MK4uuCJw1VUFTT/7QifxfpkPdxMocluSDavuhhovpZDBdztw3wcktO
         ZA1xZHGYiXig3Ay/uV2l7B655JUnNoPzjWdrfHWyHoqUR6kvdm+nk5zG7PW9SPJb1aY4
         hVZrWyUD4lVdFthLuitwIvkTzxt/hYbMYafvF64KBSNo7J3Hn+O8mE31aneOXIlZ5Qsi
         rtJyGdBFvtbx89Va8D9XIS74j4GXptJVy122NbjFIOHtBnkUonHjtjS8dc1JDN2yW32I
         upOQ==
X-Forwarded-Encrypted: i=1; AL+hErFbKSCLkt/Xm/jwI9we1F6O/N3YYGRIlEHfjKMeXR/ZfM5VZLeKAfBd85ZNjBR/8NqjOFvNtzQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z85Z+jKCMJzftC4DGFiLwXfF8sYMVACtnQ8dFff6cTVCHVnRxsk
	kZHmOilI/BmgKTG6sl/P6a6QA6y/vRz4NvjZbmieG2QEgizWoKtM4u5IamwnNU6h0FIHQIQFg1W
	2w7rz
X-Gm-Gg: AZFdTZd3YHovrSzCj7ak7wQG9J/nyKDWJpEtlxSkS65y146zBQorr39ho9RcHxFZy28
	j1RQVnhSZqf48SelZtoAKV0LOWGYLH3E46WBZcYWq3zu/MgYioNhub58gG2Bl87daEg02yXh3k4
	lXqZyfKVuCsPsSYDoh5B+dL2NpAdgXMMRNcwszysO6mzsqqZEXVUlhRBBSzq1StFc/NrH8k1m0S
	4fP0WnRUKchsUvhwah24TKHDGiEL7yzUkJiMe4r28YHnOHpA6H7Jel30Y/ODLq3+xoRZ8TACYcO
	MVId/E99upWon12ggOrntYMjQwamxrXFoU2et7eqkXOeMl/T495/P4tNpuRVc6Odj5E1zxLgdJi
	4XsduF3LWgzRPgMuh+gzen2WofBdg6qxOPSUecEjS024ede4pNOgUt4BqfQ0idGbGgv0mEHxCbr
	L0b0HwhFitQpZjw4dMl/t233jLuYC5p6VK0ZcWWSdfJwmZXqAlymaN9tPjf/YSXahr8hS2TuG+2
	UAWYOkLXOGsz/i5EyWPoITfopYWtvG3K7bN4ssgXQXnIM7LTOsYnJErCbDGhzlTF7Sur2hWIvKU
	ZOWey3zfnFXHo1UJdSD8Dadv2daYESQvvHMl9BPO3npcAdIgReEpIrS7ktlxhdeaSBFOOKN3x42
	nJUuiuc4=
X-Received: by 2002:a05:6214:2246:b0:914:53ca:99e0 with SMTP id 6a1803df08f44-91f241102aemr180003636d6.11.1794850826464;
        Mon, 16 Nov 2026 09:40:26 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d7b607sm91534216d6.26.2026.11.16.09.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 09:40:26 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] mm/memory: remove racy huge PMD assertion from
 walk_to_pmd()
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Alex Williamson <alex@shazbot.org>, 
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Wei Liu <wei.liu@kernel.org>, 
 Roman Kisel <romank@linux.microsoft.com>, 
 Saurabh Sengar <ssengar@linux.microsoft.com>, 
 Naman Jain <namjain@linux.microsoft.com>, 
 Michael Kelley <mhklinux@outlook.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Eliav Farber <farbere@amazon.com>, 
 stable@vger.kernel.org
In-Reply-To: <20261115-huge-pfnmap-fault-races-v1-1-537605643f6f@kernel.org>
References: <20261115-huge-pfnmap-fault-races-v1-0-537605643f6f@kernel.org>
 <20261115-huge-pfnmap-fault-races-v1-1-537605643f6f@kernel.org>
Date: Mon, 16 Nov 2026 12:40:25 -0500
Message-Id: <179485082513.482102.6134237207669235151.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-15 20:58 +0000, Lorenzo Stoakes (ARM) wrote:
> From: Eliav Farber <farbere@amazon.com>
> 
> walk_to_pmd() asserts that the PMD entry it returns is not huge, but does
> so without holding the PMD lock, so the assertion is only valid if nothing
> can concurrently install a huge PMD entry in the range.
> 
> This is not the case for a VMA whose driver implements both ->fault and
> ->huge_fault and which invokes vmf_insert_pfn() from the former.
> 
> The existence of prctl(PR_SET_THP_DISABLE) is problematic here, as it only
> takes the mmap write lock and faults taken under the VMA lock are
> unaffected by this.
> 
> This can result in two concurrent threads faulting the same thing
> disagreeing as to whether to attempt a huge fault and thus ->fault and
> ->huge_fault running at the same time and triggering this assertion.
> 
> So just remove the assert.
> 
> Target the commit which introduced the first driver able to do this for the
> fix - vfio-pci. DAX also mixes fault orders within a VMA, but serialises
> them using its own mapping entry lock.
> 
> Link: https://lore.kernel.org/all/20261112051440.16140-2-farbere@amazon.com/
> Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> [ ljs: rewrote commit message ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reproduced by racing faults different mappings against THP-policy
changes. Change looks reasonable.

Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

