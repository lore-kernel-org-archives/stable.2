Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071789;
	b=wrylSYIm5T8+CVQUxNiCUgaHqcjDspg2vtLcy4aaNycbE05gEbxEa/Xt/q0U3X9aFoVo
	 PC6LFxGdNhBmXSdmlm77+o92zTILTTD7QFhnhyb6O+2SG74dq/cBKSFxbCfVrOiap5N0D
	 ZgU5Y4glWLQUzrKEbjy6FtePmTcS9X7fjZgwR5AaH1AoDxiaXpI6DRG8ImzPzOlKZdPcE
	 JKRLXQlXzkeCH3ycW/H5oqGBZb3/958bzkvHtV3MUi5cB55TrQ9PN7yoF+2ar3Y3wedd+
	 M3c2XUGLbL0ak2mELXYiVk45lBKoYwvuuE2BsJjU0szmC0/VtzQEnxo939ME6o9BvRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071789;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SLQrysRtojRVCkoj2Wpy2cpXj05kr7eHKjA5uK2krN0=;
	b=n4yQFiZlZnjWaD8VEw4kTMFRmOsfjhCBbsp0YciocxeYwtviassQV1+FFfMz1QcPMK9V
	 vP24hJNVIW2b8aX31SFhWAUOdOcPCs32+m4fX8puBiA3mE/SU8LYupadGoky6lkmwyER2
	 9YGrsdUYm6eC5tspzXLYf9IK+P3nUwEOQs9+tX7JNQTrlbfal0ySVaGVa0nABJtcaU9fX
	 QllUuA9H6Dg3xKdJObJmQyUINlLP/e4kOwvklJHoEdncShfGIYNd2pbMEPvWZA+j0vOBe
	 7BV+t6gkhXi67LVpvyJJEY7zk1bkzqCOJrh+UMep60FL+Tny4KpiejiB+9ZEh55mcbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a5gEbz0j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB5A606A326;
	Sat,  7 Nov 2026 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a5gEbz0j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBA41F0089F;
	Sat,  7 Nov 2026 17:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794071788;
	bh=SLQrysRtojRVCkoj2Wpy2cpXj05kr7eHKjA5uK2krN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a5gEbz0j8dVKXdOoXU/YTycv8LQSGb69Wwrj/+MpFeKUEgZ3L3vpRrjMFI2zfPv8M
	 rBRcDXw7TJXpl+0nH2vgeenR595dU6DbW0Hj9bVEvt5Z5MeGroUdZMSCMsrTlGjdfd
	 a6gM6TrM4xunBHI35KTevz5nEpkJBnhhkO0PTZNfiD04SRHzo7iCZ62DzAyLhXJuJb
	 BjgLSCCSU0ZwhOrKvNtBm8Kauj16MY+mBm/BrYPL52sAR1EA8O50mN8JQRyYERvfHU
	 C3PrNw/2SWIGt+77ctam7Yw0FTqwLWENhkeLyvLQfERDUa9F/LvjztWYlKwlaGR9gw
	 pTi0/e8JmAVHg==
Date: Sat, 7 Nov 2026 18:16:22 +0100
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
	Lance Yang <lance.yang@linux.dev>,
	James Houghton <jthoughton@google.com>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Yili Zhang <zhangyili01@baidu.com>,
	Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 01/13] mm: hugetlb_vmemmap: fix OOM during head page
 allocation
Message-ID: <au9c5jNwv2nhJdzD@localhost.localdomain>
References: <20261107022756.77731-1-songmuchun@bytedance.com>
 <20261107022756.77731-2-songmuchun@bytedance.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107022756.77731-2-songmuchun@bytedance.com>

On Sat, Nov 07, 2026 at 10:27:44AM +0800, Muchun Song wrote:
> From: Yili Zhang <zhangyili01@baidu.com>
> 
> The head page used during HugeTLB vmemmap optimization is allocated with
> a bare GFP_KERNEL mask. When boot-time hugepage allocation drains free
> memory, parallel optimization workers can enter OOM handling before
> userspace exists, leaving the kernel with no killable process and causing
> a panic.
> 
> hugetlb_pages_alloc_boot_node() invokes HVO on the folios accumulated so
> far when available memory reaches zero, allowing the released vmemmap pages
> to support further hugepage allocations. If allocating the HVO head page
> returns -ENOMEM, the bulk HVO path frees any vmemmap pages it has already
> accumulated and retries, while callers can continue with an unoptimized
> folio if the retry still fails. Therefore, neither an allocation warning
> nor OOM handling helps this best-effort allocation. Use GFP_KERNEL |
> __GFP_NOWARN | __GFP_RETRY_MAYFAIL to allow reclaim retries while avoiding
> both.
> 
> Fixes: c0b495b91a47 ("mm/hugetlb: refactor code around vmemmap_walk")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yili Zhang <zhangyili01@baidu.com>
> Co-developed-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs
