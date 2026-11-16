Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794825765;
	b=M8dVm9bTXNOmQlvWWy3/CFAZbD7fyo6AAdwpU5QI523rI0+rOszx3tWhz6cXnaFq2F8b
	 kKIX5Eq/G/3L2hH27/VfAhIUtav3rwcvyivymibwR1H+A0W0IdmGD7afshXvi+jWGiT/n
	 PJG1V+9LZ6TVl+wVSsillpn73Jby3m1KzUZ55jOswPR6kRR4Q5lTXuSABj3N1U9+8MT6k
	 HpwsfneiPuD59e37JwZYYxJ71MYVKAkVmSm2vt8bssKtMKZiDZ8fbOQbuqywdisp6raDE
	 S9Zup0HcLQvj4YnUDN/sjlpSPpAhX5YZ2WkFw09zh9h7yyIDse2NvFtpc2XZN/N4AIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825765;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=dr9af4pJ/8zWS6vI+oqg5r0KIFPMXaVucU+qa3+/eLg=;
	b=Zjso3KfW2UuR6IF5hGB9ZqgTu6StlnrtsY3i+EDy2JaNCs/8jwG/fKAghmNGEfkrLzE7
	 AMpT58ROfaAp+tqKvJ7fzAUk7VganmjXJqXvdAgtVBQti6yATGvBXw0c5xDpF32Q+HxBF
	 CqJ6rs2tM3Gcz60bLQL85A1tAobFAV3qXXVnGf85cZyrNbfaTnLzeJBTCdaIuaNXXrJG8
	 j6aNNci7uO4j0YH+lYnPKJad8VnVhLlQvuXak36N1tgqKWsKQ6+GMJwJ7PK90H0TCIVDk
	 8aDqBViynJ3iZCCD66bMiPlx0GKXqc8ro2LnQWHdUXARWLQjIQLHDAh4bQIlQzm7rIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YenkOKLI;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297FE606A32A
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 297FE606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YenkOKLI
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb6c7b6dbdso12177875e9.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 02:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794825763; x=1795430563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dr9af4pJ/8zWS6vI+oqg5r0KIFPMXaVucU+qa3+/eLg=;
        b=YenkOKLIFDKLP3cCNEy4Hp/r6gDzM/GjbkhFzLf8CBUszKeCmVtYIbLtD3GBdQZ776
         1yvC13/hqndudAnYs+824ilyG3T2v1yOobdqSF5pNwVhkhdfU1jzU27mlwr1qmkOjnXn
         YCeQKTn4V/X9p3F749zjFS1aWwakQZBCmURI7c50hPNfcfk3Y6CyUlzJLSgBPpBiYv8R
         OjhIKQd+b6bhpieLNPqNpOEpyp70kjRHI2WCC5dcVblCnuOQgu0PRbIAz8sWR+N2OFnB
         Dyd7ORKRElowHiTewwCNqa8vLBn3cZKe/cGvAvfUzs4KOcvDPO2x7z58CywlFI3gXQ+M
         3zDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794825763; x=1795430563;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dr9af4pJ/8zWS6vI+oqg5r0KIFPMXaVucU+qa3+/eLg=;
        b=o7WZ7q5w5J1xIExX8HnuiTbjFusCuc+M5sSsIjqKEDjfOBDel4Nt6ZxyzBYjk6Uzb2
         FOiEljv3CHlAYRVZ0RHdXmlXc+2aqeGRGP+9XT6SDg1azB7t2GFGndNg9HOyiVGRvqyt
         o5ABoM+Qe6o+i6AGuFRr18dGDX6MeLzZXwXQvQEUwQES38NbxgKjCuyCR/HNuZ1U3umn
         vm2adYz7tq94wUADqYHPhjhEumiNW1Q8LzZojlpS8nLk89qZw+EegyNDrRQ2Jl0iQdkz
         LHlG7mr9nOkSPghJFpoFYivJcdBOrLS0+I8Ht4Kh7ig1v2/8zF1R9HrEhjWoIeOYJcMB
         IZrA==
X-Forwarded-Encrypted: i=1; AL+hErGsnuxV1fPx3qGZN24BN5SMixA74MyvxqBoXH/wfiEvcwdwYOSpyEbLvLVrB6eVY/0VH0pASB8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qK7m90fNojZTBRPo97SXoZGAIfuUUT3FcFKnfJ9C3NTWUDv/v
	PSJMOFxoG2naaL/xrXmPUjQE6U/pJ3JCfx9BhR22twgRfQ7NHZNqHl9+
X-Gm-Gg: AYBFou2S9lEY11eh+gAcTf8jjYTAMtX971wy/z7BzzGNIa4/9C3VcgN1ksikMDtn+SV
	fPRprBVUi4NKQmmz3y4lVuA6NVOLSLvXNvvjHohFx6dEa5lCOEW3KrIQeD45fqe2aCRYRpihPGR
	3nXG9/Mbnm9UkrSdBC0ucf0vs7EhHd1sp19HpIrQroKLcXS7qYhh/PizJzf20R8Jb/LqQ55oGXI
	T90QOskgQ0UE6DZ51JQ6aeM3pvIWkwEbzKe1LkC3/r2OjVauxb8kt5/ocRzTpEj6SZPbSpr76Fv
	mno2qD2DJpS2ofm4DagVQM52CgXC7Uhqc8gDMOlwfAxp61M2fnGghKi1sb4m0320HCNtVDt2E+R
	V8k17IObf0THB9fq0MZOP/NjhU+QhgVg0npC+7cKhp+pU9oLVtXSmKpgk8YCK8hAUYtdU+eaHEO
	2/H7XbTkIWUJ49iZ2IAPgYk8JQBS0UIwIPvpWjx59zJ5bF7n5KLQYcUgu03IKlDkKwVUH+mAS8t
	ZOhcS6CzwyrJHp3smjPXlaBO6bb85liq0hNubxr5azL/X09X3hnqVOG9Fod0yfWLHOZrFwayPxN
	+3xGXuqCdPSz0BiaHKpeidBG
X-Received: by 2002:a05:600c:468d:b0:4bb:741d:ea0 with SMTP id 5b1f17b1804b1-4bb741d103amr31960235e9.17.1794825763460;
        Mon, 16 Nov 2026 02:42:43 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f77fc47sm21618424f8f.22.2026.11.16.02.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 02:42:43 -0800 (PST)
Message-ID: <9277a849-0cf1-4a49-922a-f35aa36f1dc1@gmail.com>
Date: Mon, 16 Nov 2026 11:42:41 +0100
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
Subject: Re: [PATCH 3/3] mm/huge_memory: only compare PFNs of huge entries on
 huge fault insert
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
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
 Michael Kelley <mhklinux@outlook.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Eliav Farber <farbere@amazon.com>, stable@vger.kernel.org
References: <20261115-huge-pfnmap-fault-races-v1-0-537605643f6f@kernel.org>
 <20261115-huge-pfnmap-fault-races-v1-3-537605643f6f@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261115-huge-pfnmap-fault-races-v1-3-537605643f6f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/15/26 9:58 PM, Lorenzo Stoakes (ARM) wrote:
> A driver that implements both ->fault and ->huge_fault must anticipate
> concurrent use of both.
> 
> This can happen, for example, if a user calls prctl(PR_SET_THP_DISABLE)
> concurrent with faulting, as that only holds the mmap write lock and thus
> does not exclude faulting threads stabilised by VMA lock.
> 
> insert_pmd() and insert_pud() have issues with this as they both assume
> that, if the page table entry being populated is not empty, it must a
> present huge entry.
> 
> This is problematic as if it is a write fault, it compares its PFN against
> the one being inserted, warning if they differ, on the assumption that the
> entry is a huge leaf.
> 
> Since the entry may be a page table, this is invalid and can result in
> spurious warnings.
> 
> Equally, the entry might be non-present. Nothing can install such an entry
> in the VMAs that reach this code today, but there is no reason to rely upon
> that.
> 
> Therefore only examine the PFN if the entry is both present and huge, and
> otherwise simply return VM_FAULT_NOPAGE so the fault is retried and handled
> at the appropriate level.
> 
> This is what already happens for a read fault, for which the existing entry
> is not examined at all.
> 
> Target the commit which introduced the first driver which both mixes fault
> orders and passes the write flag for the fix (since this commit, both
> drm_gem_shmem and panthor are prey to this issue).
> 
> Reported-by: Eliav Farber <farbere@amazon.com>
> Closes: https://lore.kernel.org/all/20261112051440.16140-4-farbere@amazon.com/
> Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
