Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910B251123E
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 17:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542623; cv=none; b=cByia1MxrmXk3fQpSVwohkHdtZLhAi6YsqpI0wxbmEiEJ12JOkCWhQUH10SJFm2Pcd8MRVyiwGBC2KXEilbDYplPRaRb/ZHYWHxEDntC9LDFABjZ90twikhLNoHKUGDylYXBA+7thvyrlmE8M9Qsz8IqdSNQXwzEyQvUlubx6e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542623; c=relaxed/simple;
	bh=sBU/dq8j6OpZIbc8vJehTBctYKrSKBiXMQ4wHeWZqkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FcQi+fpwV7dzy9cusTw/ZYgAvBXSnru3Gk0juhYhSkacskLk7SxeDKb3kFaTDbBs1Tl+5mXRL0Ym1oBQgEPFhr7pkQWn23lqOZVHrzWxuSsJNkEEHZ+icmuDrfpmhvKADL3oUBssG7Z8ZhontQpISGdtrA5TBYigzDC7ejCEdMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r7nKs1ch; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7nKs1ch"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4b5b727be96so1023757b6e.3
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 10:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788542617; x=1789147417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YCVI76HnM719qm2pNvwAM4j/ewQptWjm8pfKFuUJMF4=;
        b=r7nKs1chDzKWfnW3116XbNsCLzaP1g1i8WljDTgdttVlV5jc2RCbmDR1gD3BWvVQiF
         q5KnzSiBh+B35qbdNdbFDoMyHYpILhb4uImdtrbFBXwxyCrWmunjkqcnNFiaNgrbbnKl
         PvTTuHaxpx2mXBff67cE65gLdfUXsPcaqHu2oOtzvN0PddRbwKvsnDAVeHYrVgTCbVha
         0kUZb4EHbkkZcPaJp2zcD9PVE34yQBPMsiNdg5Snw5QDdTrcSfvaujcNXthMxuL+Wvrd
         bWHRr9gKQpARvOBqgpSBqG2uiJsjCBuNkO37OVSCp4I937sBwC92RIy7c1U4xPymgH8Q
         CAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788542617; x=1789147417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YCVI76HnM719qm2pNvwAM4j/ewQptWjm8pfKFuUJMF4=;
        b=sRi3dxkEw1U29l5T4lZahyvioXFwMiN+6vqDyhGPWeMhvAc6e5jb5Dk2pQAyxzlx34
         NSAyq5oqhGdYA0uVNa5d8xaqX7y4VrS9VqtDTZI4u8GDXEoOLdGy1lMijp/HUXWmZspI
         LV7aSF1cBGnk4gMhMYQW2lG7tOfI9RpLQP/Btp5KCLpypHqTUhmTq3b3/c0/oi4RjVb0
         olpiV8aUUujIdcllc0GiWYa39KwbH1I2jtvuzwXGyHMqWcYa4T8QtSIE0govofSr0bji
         Rc1mCpRGYFOC6M75juOSWR7Q18pG/pVBy/RfJMiJIyI5W3Imx+gOyrMgKBghzf2rmnm1
         HHdg==
X-Forwarded-Encrypted: i=1; AKwUvBxqAReOin+Y1fwM9fd+SF0/PqRWU7bb+F0Am/eLBX5ucWBwWhQm6GboE+ZPYgSM75z3KkBKzKs=@vger.kernel.org
X-Gm-Message-State: AFuF++kXq6blVPv/JhU6gwXgnnh2t7w09C9dKsdhY0yxhmkytAnlgBsq
	kyDm/OPEiEYdqHjX4fYb4th8LtiVEq0ZN9ifm9Wvq8yIlQm2/DhTk1E/
X-Gm-Gg: AYBFou0HpKWmg1qbl86N3+eEMSZ1hUEhzZ9yA9fA5OZ3jkOCRUWp5VWOl/koavPvD5Z
	4sXCvXkOAhLGchwi4VcIn+jdEz9JhN7SSyZJVQ3PYcSk0GeWqICc5uFYku2J7VUWhUDmJrc4uxA
	F9JFs9UXZM3klfzN+OWMuFgrUaXWxdFMmC1t4UCHZ9CLpu4mhnFjCKM/1CkN38ofpaPB0HIMExQ
	mhiOo6cXt/iMdIrqtJoJo8yH5OuBX2b17L5al6HUEfnfdXe26C46rcSxQ1j1OiJPV8+S6874sNe
	wqM3trJRpl7Lwijc9tfC8R0ysMKVklJfT8K7uiQYMEszfMZIYiV9XvdkjB1EVcSsvbFeLfcZ2xb
	5RIOFQsSPBW0E1BS/D84N7YaCDYSSbXR4/cixGoKHWxlkCUruuWiJh6+UKYQSK2k0hsRohBUp3p
	0eSGbNaMK4SCOgSDlQaKdDB1NNalGzaOn0GFqIqGJ8rG7sN0/SxL5QSAhMcfiz6rZFTiPAw2QaZ
	xAgz8cQDizT81h3yVg=
X-Received: by 2002:a05:6820:1c87:b0:6b6:d4c1:be22 with SMTP id 006d021491bc7-6b6fb0ddb89mr5397329eaf.13.1788542616324;
        Fri, 04 Sep 2026 10:23:36 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:24::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b6dc6aca49sm3331420eaf.6.2026.09.04.10.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 10:23:36 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Cc: Alex Shi <alexs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Hongxiang Lou <louhongxiang@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Michal Hocko <mhocko@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Shuah Khan <skhan@linuxfoundation.org>,
	jthoughton@google.com,
	fvdl@google.com,
	rientjes@google.com,
	vannapurve@google.com,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Wupeng Ma <mawupeng1@huawei.com>,
	Yanteng Si <si.yanteng@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Ackerley Tng <ackerleytng@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: hugetlb: Drop refcount before freeing on memcg charge failure
Date: Fri,  4 Sep 2026 10:23:33 -0700
Message-ID: <20260904172334.322019-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902-hugetlb-alloc-folio-memcg-charge-error-handling-v1-2-e3e8942c141b@google.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 02 Sep 2026 01:22:57 -0700 Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org> wrote:

> From: Ackerley Tng <ackerleytng@google.com>
> 
> When mem_cgroup_charge_hugetlb(folio, gfp) returns -ENOMEM, the folio has
> its refcount set to 1 via folio_ref_unfreeze(folio, 1).
> 
> The error path calls free_huge_folio(folio) directly, which expects a
> refcount of 0. Hence, VM_BUG_ON_FOLIO(folio_ref_count(folio), folio) is
> triggered.
> 
> Even with CONFIG_DEBUG_VM disabled, returning a folio with refcount 1 to
> the freelist can corrupt allocator state later.
> 
> Use folio_put(folio) instead of free_huge_folio(folio) to properly drop the
> reference before freeing it.

LGTM, thank you Ackerley!

Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

> Fixes: 991135774c0e0 ("memcg/hugetlb: introduce mem_cgroup_charge_hugetlb")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Reviewed-by: Muchun Song <muchun.song@linux.dev>
> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 01b57f6d3b804..97c06f227ef8a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2889,7 +2889,7 @@ struct folio *hugetlb_alloc_folio(struct hstate *h,
>  	lruvec_stat_mod_folio(folio, NR_HUGETLB, nr_pages);
>  
>  	if (ret == -ENOMEM) {
> -		free_huge_folio(folio);
> +		folio_put(folio);
>  		/*
>  		 * Skip uncharging hugetlb_cgroup since the charges
>  		 * were committed to the folio and freeing the folio
> 
> -- 
> 2.55.0.970.g62bdec98f9-goog
