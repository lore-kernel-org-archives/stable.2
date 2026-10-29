Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793289559;
	b=LqK+PuyC1RmAFf5QwxOsQ8xX2eeMeb81zRLaDd8dIChrpGxXsfQn1a8E0oP8cR7+fTeG
	 aibkWJtLMbmQ2ghQdut43wMGjVTg74etNZQBpve+quYZb3YzaBx91ZdyworxOa6gSfGBC
	 0dRxQXrvyYpWi04Kvs9VmMPgo+53fr/phLOvufxqKQB1rpoCgmoINWagSnn09yBpou8oU
	 DuJVTYONBAp1YrKul8RR6fdSHJEyP0lgvjebtTw9P0/1CDk+vF/6SijK2zUyVD7cuC7kW
	 KIUFA7KafsdilWi+ofYMgy3vpKyO0EjbYg8IZ0f7Oz1Lrt3svbfSvcQqGiKEGNKvG7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793289559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References;
	bh=2Iavpt0xD5+NOsPxR52uOxmq8ZYkCHkAdBvsyZeTFxk=;
	b=UF3QnPn9BX30iVmJFWgycpnvplUrkr1rWwMj/VTuxE9YnRYbKLp9z9thZCf+kNdFyLbR
	 eTJZv7V/tZQCG+G5Drwe+NxdozWmEm6NunNkzBjLGCxYjG3A1pWuEq/eB9UjZddjZRLbO
	 bv/NzFLgiTLCKnPAX0EpXMkuEWNj4LaJ0YBx2KcimFsi7Cpdmqug0oOMxXhSFmCKt7YJt
	 FoDAb4jzeL93lgEOKwThir50N9H+qSQZcE2c2fqLi8AZe6LnGm08rB3+71rgj7MmUUnV/
	 AdYuDZ2lgDY93UEqq4F1awy4tGtMjasmx0q14BHbLzav1xWMmIwqtn4n3ZjXSgFysZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tWycgmes;
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8F3606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 15:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB8F3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tWycgmes
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6f5a0893610so1844729eaf.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 08:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793289558; x=1793894358; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2Iavpt0xD5+NOsPxR52uOxmq8ZYkCHkAdBvsyZeTFxk=;
        b=tWycgmesusU8qNEKvjEpEbmDA7XiuXZ/MCK0Vzr8kAHFSXP7g4RCSAzBMh6G+yOkNv
         2yNnSqeLKkA3bP5+kigG/LC1gRwZtcIMZHKpoaB+06sreUZZZGAvEs2QgDUTCT8lLRy6
         JQv0RHmO8UkBIFSA/eUqtTNZW0Ivq+LKBSj4P4zDBJRGHW+cxc8hr7nu19HaMh4NB0Qn
         gxbhd37n5U5iMGXVuYZ+L8R5C9QnBeAunC/VM1UZ6p5V6YYPo5wM8KHjqz1/Ktf99eLT
         vHMTJn0aHmEtAM80BzzxPeSoEb33tq6Z7BOHLxGsVm2qrldhXqmYbkvfV36uua/i9VPI
         IlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793289558; x=1793894358;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Iavpt0xD5+NOsPxR52uOxmq8ZYkCHkAdBvsyZeTFxk=;
        b=awTdUndHdZyZ8KyP+ba0z6V5Ect46pwbrh6RRyWrbv/9fmKpGo+82wshoA+b/ep3sc
         sl4hATOZmi6mRKkzyrpvVGCyC0eckFtq7IoOpYpEMF+s1dq3XiKVhNBQb5zkmdqamN1g
         elbk9863m++tkDVuzU40/Z1HkicGnx4NNwQpO/+qLUpjimqST+9K5XKBkk8JiCJ0/gDU
         +b+qnftwtE3nJgIOztD+/ynzCQRMjrFF8KMVxI1Dg9xvWjhT78whi18bmeMzQAQeICgX
         aKzpws+QlkbMe5FU+eQ6MLSGy6ShxWdVlr7+VKxPVDmASsycUDsOTN9BaZQVZR3hqBbC
         eEyQ==
X-Forwarded-Encrypted: i=1; AKwUvBww7q21X1BW7tblAbDwLMHr36BhQmNEkGysKt/ez0Jzbd2U7U1gEvJ/X2jiyAaJ02+rMe6i7DI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2yTbqm2UqH++j1uhyqxZvWXfPQy5obZcVAwARvkzLP54kY/tT
	qbLL4UrMlXhlQF6KslkaSzsnEHBGeK+uUn0IOEBjRl1RSLFGkZ/vqkzz
X-Gm-Gg: AYBFou1CgH3Sin1HzTlO8dNYrP+ZWD12qXT1mk8Hvy7tzPKDdZKkNkplvPeR+CmSdXu
	UJCSV8kiOwUE06z1jcs4+xv+kc1n85cVIz3CeZ9GmnBbf9RQLCMqecuK9CIv6dS98Qq4tmDrqjW
	yP0AOBPDI3QSdC4UCYiExn2d43zK0DYt/0NKN7+m2jfuQ0LOMG+PKSauA4LTiMuCVxK9QGNznFt
	2jTCH3V+mbIXk56AG08swQw6goq3J/ftd7F436YcTk/5l54EcSmGgPY/T8GpN0tfnHNXq4fxheM
	J8VksYRPF7EbfIfPF4GPDsLpiFQm/YzZ8XUI8e5cVJTKJUT/1ERbQaPjSHXOS/t9vMqKIhJOscT
	lzPsxgPyTAbmoFUL7CQcgLIS7iQntjfKtCHphySLBNR32SSDCO6dE2l+uN5uhg+bC+If+F2Eaci
	dEtck64mq7oBdxFjIodyasdaak+NSL5uu+XWGdtSCQxnjGmON4MBOzwf8xmLmQwnJxa4FXA6/yc
	WzmeRRAnneBnzlBGSvS7vYJgehUa6aAj7nKwHzdsQAls6jN57giE9mNOIMJkL9UIlB/3pLEMNR5
	0X3iXZGeRLlgFkMn6XclF9fLVT0=
X-Received: by 2002:a05:6820:1629:b0:709:529a:478f with SMTP id 006d021491bc7-713ef240bb2mr3244491eaf.60.1793289557756;
        Thu, 29 Oct 2026 08:59:17 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d33f57805sm182778a34.6.2026.10.29.08.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 08:59:16 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Muchun Song <songmuchun@bytedance.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Pavithra <pavrampu@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH] powerpc/mm: fix uninitialized ZONE_DEVICE struct pages with PMDs
In-Reply-To: <20261029063601.1961415-1-songmuchun@bytedance.com>
Date: Thu, 29 Oct 2026 21:15:10 +0530
Message-ID: <h5i4wlx5.ritesh.list@gmail.com>
References: <20261029063601.1961415-1-songmuchun@bytedance.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

Muchun Song <songmuchun@bytedance.com> writes:

Thanks Muchun,

> PowerPC radix vmemmap population can reuse an existing PMD mapping while
> populating a device DAX range whose section is marked as HVO-enabled. The
> reused mapping is an ordinary vmemmap mapping: the redundant tail struct
> pages are not remapped to the shared tail page.
>
> Leaving the section marked as HVO-enabled makes later ZONE_DEVICE
> initialization treat the range as optimized and initialize only the struct
> pages that would be backed by a real HVO mapping. The remaining tail struct
> pages can then be left uninitialized even though they are still used as
> metadata for the device DAX compound page.
>
> This first triggers a zone mismatch warning in __init_single_page(), then
> faults while initializing the pageblock flags:
>
>   WARNING: mm/mm_init.c:600 at __init_single_page+0xd0/0xf4
>   Call Trace:
>     memmap_init_zone_device+0x164/0x430
>     memremap_pages+0x43c/0x93c
>     devm_memremap_pages+0x3c/0xa4
>     dev_dax_probe+0x264/0x3d0
>     dax_bus_probe+0x140/0x1c8
>
>   BUG: Kernel NULL pointer dereference on read at 0x00001400
>     __set_pfnblock_flags_mask.constprop.0+0x34/0x160
>     memmap_init_zone_device+0x358/0x430
>
> On kernels without these initialization-time diagnostics, the
> uninitialized metadata remains latent. When userspace later maps and
> accesses the affected device DAX range, the kernel operates on those struct
> pages and panics at that point instead of during device initialization.
>
> The Fixes target predates the section-based vmemmap optimization
> infrastructure, so older kernels do not have section state that can be
> marked non-HVO. Backports to such kernels need to handle the PMD-reuse case
> in powerpc radix code directly, for example by initializing the tail struct
> pages that core ZONE_DEVICE initialization would otherwise skip.
>

Actually that would be totally new code right? It won't be a straight
forward backport, correct? ... 

> Mark the section as non-HVO when reusing an existing PMD mapping, so the
> section's HVO state matches the actual vmemmap layout and all required
> struct pages are initialized.
>
> Fixes: f2b79c0d7968 ("powerpc/book3s64/radix: add support for vmemmap optimization for radix")
> Cc: stable@vger.kernel.org

... then should we mark Cc: stable here with the above mentioned fixes
tag? Because this patch cannot be backported as is to older kernels -
for the reasons you mentioned above.

> Reported-by: Pavithra <pavrampu@linux.ibm.com>
> Closes: https://lore.kernel.org/r/97f85592bb78a273be8519e6897e7f9b9bd31469.1793070429.git.ritesh.list@gmail.com
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  arch/powerpc/mm/book3s64/radix_pgtable.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>

I think, this patch should go via mm tree, due to all the dependencies
coming from there, right?

-ritesh

