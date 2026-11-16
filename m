Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794852837;
	b=VW4cTZj6F/IRm8pNstOdqo4SKhGPu6H2fkoC/gjyLCT0eq6tgOv/h7kEYXHP5c+kGLZ3
	 /TiSnpGQOXOMwEaFoASs7X40uGOLvIxjtEw+Ij67kAOpPavzVnbrvjo9CWzql9pSvjsuU
	 LQdAjCSL5y70nblaST3/EkK2AHVpoI/8Cj4RgKyiVnF6riUiKufyjvkS/BwOmqtt1dWn4
	 Y3rwMNcIempBl+UtNMswL68bvL0amUlSQc6pEDH7dV/t4K/VQbjgC4NklrSUqwfcOn4PJ
	 HpIC72IMKZtPnOIS0wDlPfp7o7WIP+uaxr5HJb27YK/dWn/+Hfl8unjZH6j9T1Ld4ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794852837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=mB8RDKJrvT0rNRs0LLoWAJXFuxhaQ7Mxjj9sT6tzin0=;
	b=VyRGMEMkS2Qda3gRy/4bI72NPsP4EUxfshd4b9NWZelJD4vyk3PlchtoNjhf3+huEs6O
	 lBW6K6MQJ1bQ/dALuK1VXaldX0ILg5OsKVileNkkz4H7GAQ88f5QHqeeWN5JGkScXvZRz
	 px10VZ9XuUY//adqh/TwLTUOtCAHwNmU1SmRcsxCUHxAFzNeSmVz6HbqW9j0YB7lRHzCL
	 X7zlniu4Ba7Lc/9SXc5kyS3MX2deMpx3OB5vOXQz7PJe1tR031xhpZcQlYMilRRZoUc09
	 FuwClBRlz+4ZC4BCMghIJk8AscknTyUENc6eWBzLQrwDAejLtixVoVv5v8aMcvSl43g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="iyR0WA/1";
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4292606A322
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 18:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4292606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=iyR0WA/1
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-949657a20d7so208036185a.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794852836; x=1795457636; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mB8RDKJrvT0rNRs0LLoWAJXFuxhaQ7Mxjj9sT6tzin0=;
        b=iyR0WA/1J2BlEhzy60IVhukBVTzhcOU7Rg7pBqg8zKY2KYkndTVRoBdWsW36PD4CdR
         KvJC0yvp1VrfZTm6eOhoXmBP4y6bhl3u+A+S0AFfwqdHrSYnSPKpA4/aUOqq9/49kD/u
         0wxIngsIBGchZ1admpRe//tAEDOMh0d8k3SflDRRqN2UhFPR7rAgRPRwoDvbApXpRBxi
         siyk6NFZeV4PP/XbOWFSO1eG770BGON1oEPz4cDhn9UjznmSDimXpw9V1YEuH1FUhul+
         WJdnVnQnbmCABOewTL/kgOUHkN+WlHboyA7Ov8uUf7YlMdlLEdRxGAYGi9dYbMzPm4RX
         zp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794852836; x=1795457636;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mB8RDKJrvT0rNRs0LLoWAJXFuxhaQ7Mxjj9sT6tzin0=;
        b=q5ito25kPdHMRIcovSXm7DoDEMbAWt6MuJtvpGgfg9GNuhkCcrO1zD7ss8wjhYs4Dp
         koP0BsmwMbxOU4xPGyHQyOfik1x27NLTvgU7wjSBg99pCQAhGd+aTm1ljePfewxrO8sP
         iAnjutdsBedjeX4R/boIIzDl+V1FX5z5luL1UvX9y++5W2crx9OCR4FffoRFAfyGsu8o
         P4mucjoxQ+3WutQ6Z+SMVujU8qdBpfR/tJZyJgf1mgMpRMODLeIttMJGEymZHXEy3V18
         Zn3RK/KjkgLAJHm9L4V4T1Lc7qquCkWUJ38sAmobebtBOc0OlXS58kByytIdNx7RA5Gi
         8ZoA==
X-Forwarded-Encrypted: i=1; AL+hErEtz/MLL9c4zdZnBXUjpYOW9Vj1KwhPg5XgxgaqS8cMZ3i82mX0bsTaJ2YPONBHNCpBz5nSwlI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+uwPW4PhK7EoDF35CYi2JXeSY3z7vdA0v8S6ar/MxnSKOrOcrP
	FuJs1+8vks7kNVxxmnb48bJRXwUJ1t152ftgc5qTPT6zbuuSl7AY9gd9HUJWqL/qnuUGSbU10AP
	3Qlw1
X-Gm-Gg: AYBFou3Ahe9LKLzehHZ1vViOgFTqtKZ6LXHFFKp/Dp6bPTRZtuOt5mSz9un9b6yqorO
	QBFKxwPvp1/7aihjW0XbU7t8lrbHwVTImCw57ltApXqYB5nnRvm/gSF53bzMLysYEYdtKXggrEp
	KWwhtZtlVicF0nwbWhqWl+Qohf94GNHKcd6avvFqv1vJJjQAyf0hTnpgNFelUHNm2o2Im4x8k8S
	b6XaTgHCY08QNNrTxBsRRDieJwnM8bl7iepqaQg06mrqsJDXL1iXyNOPe1O/IJ9buv20HGCj1KZ
	9CsUDdRWrv5H8i8tvu3AFb89/nEnavmo6lR6XsYQr6VJ7VNNIRkdze097IsCRwxauJhoVMUGuov
	kCKiqR4OSkD42w9u10uqRwaqw3it34NHDmSwoHqEeYy3btI/eoDEGymdfaMzUIIhYI8eLpLjA9g
	wD20rZ6rxjFYzbTvD4MBF5U4d7dL4JKPmcfQOjn+I8JeSSanTfo2XKcKIcBbYzx+uoCzmD5WW4Y
	hlvqtrqycGErSbG8FPtHMk2YeFHaiKWaEQekiea32gOsKfVr0ENdbWwCRKGSTvH/8vWvI9mfPHe
	YaHSuEEolDF0p/ZI2zwOnGRpSDt2NQs6c6FDYcSoyh+v9rvDjL8p9urN0XKUVd8yW9K7J5HI+mn
	SVard5qg=
X-Received: by 2002:a05:620a:6c8b:b0:947:7f5e:2b63 with SMTP id af79cd13be357-9494bad303dmr1772432685a.34.1794852835505;
        Mon, 16 Nov 2026 10:13:55 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d70918sm90840106d6.22.2026.11.16.10.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:13:55 -0800 (PST)
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
Subject: Re: [PATCH 2/3] mm/memory: do not report OOM if insert_pfn() races
 a huge fault
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
 stable@vger.kernel.org, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261115-huge-pfnmap-fault-races-v1-2-537605643f6f@kernel.org>
References: <20261115-huge-pfnmap-fault-races-v1-0-537605643f6f@kernel.org>
 <20261115-huge-pfnmap-fault-races-v1-2-537605643f6f@kernel.org>
Date: Mon, 16 Nov 2026 13:13:53 -0500
Message-Id: <179485283354.482102.2633605640287961592.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-15 20:58 +0000, Lorenzo Stoakes (ARM) wrote:
> From: Eliav Farber <farbere@amazon.com>
> 
> A driver that implements both ->fault and ->huge_fault must anticipate
> concurrent use of both.
> 
> This can happen, for example, if a user calls prctl(PR_SET_THP_DISABLE)
> concurrent with faulting, as that only holds the mmap write lock and thus
> does not exclude faulting threads stabilised by VMA lock.
> 
> This is not currently safely handled by insert_pfn(), however, which
> obtains its PTE entry via get_locked_pte(), and treats a NULL return value
> as an allocation failure, returning VM_FAULT_OOM.
> 
> The issue is that get_locked_pte() also returns NULL if the PMD entry is
> not a page table which can happen if a concurrent huge fault installs a
> huge PMD entry between __handle_mm_fault() observing the PMD entry to be
> empty and insert_pfn() being invoked.
> 
> This can result in VM_FAULT_OOM being reported incorrectly.
> 
> Address this by proactively checking whether a page table allocation
> actually failed, and returning VM_FAULT_NOPAGE if the NULL indicates that
> we were raced instead.
> 
> The same assumption is made in insert_page(), however only DAX implements
> ->huge_fault and can reach it, and it serialises faults of different orders
> with its own mapping entry lock, so it does not require a change.
> 
> Target the commit introducing the first driver able to do this.
> 
> Link: https://lore.kernel.org/all/20261112051440.16140-3-farbere@amazon.com/
> Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
> Cc: stable@vger.kernel.org
> Suggested-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> [ ljs: rewrote commit message, trimmed comment ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Tested with the same test from patch 1, observed the leaked OOM faults
and this patch resolves it.

Makes me wonder whether patch 1 and 2 should just be a single patch to
avoid bad backports.

Either way:

Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

