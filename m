Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574604FECCB
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 18:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788634481; cv=none; b=a84VjO54QjI+ZpyZrXUFPkpBbKcCShdsVmFYEbmwtIp7Yp78DwbMo4YBtl3ONuzv6ttDbl0DHwkSoXAZq7kbCGTmKFH6VQMIozUMy5goTgD9Ezt1zRcv84lbrpkQ4OaSHa5RQ5Q25PGdFbcep1Q0YiDlBc4xUBqSewV9sYoMkcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788634481; c=relaxed/simple;
	bh=KPJfbyNYAXvzZq8m4TBWqxbvwNJkc2YnMnWqXeFStFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BOty9Xd7dmUjSrPUlOhgDFlSVfVPP1SLcrx3bqZnlv2tXZgEsFI9Hyrf6skNx7+o+EiX1EOvLRJqlz4GZMNkLxC1o1vCDLRxG+nb9Sd5Jki27plBnkiXKNfD+BuEvLOwoB6QMi4GMvyB8hUk5UhRs1owe/2sgyybzZvDrmmZteM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ae4QIDpW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ae4QIDpW"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d9db539a54so17921015ad.0
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 11:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788634478; x=1789239278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xc1v+zjRGhQEiAXJQs4wYpDjz/6EzrVoXejIOIFfbFo=;
        b=ae4QIDpWm9Vv0g+669IPAdGoRccpKTJz2lNxaWhclPa/zn32NYP0F0xWQH98HSYQ7n
         uGf/tMUT/i5hTjf65KcJzDC4yUiWzbeKFyinez6u2g5IvFGI7De9odP3FSjuu27cS3PV
         mN1l4y7Lj1uTc/XUmu5wnNx7Jh37lsqpYgasaNKhTSc0zDq4ouI00297wqzNAJhEHHTR
         YHva84eYE037Cy9FVf0HjOD722d0yprc6Z3qqhzjR17dblOfRmh+aKQrUY4upsbLCmGq
         9Tnt2MbbTA2KIqAPQhl5EEFyaQvQdt8Jf3cJLwKp4rRko44qmqw9WQZiYXJtUsUdHu+U
         3A9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788634478; x=1789239278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xc1v+zjRGhQEiAXJQs4wYpDjz/6EzrVoXejIOIFfbFo=;
        b=R3TVZWXo8w5Gm9h6oRfAwLVDIjJeYmRBuRuTbFs/ILfn3ODYmzCQ+xeStCsmoxA0Py
         yn38rjfHEFE+qKjgZ/5IEzZIdTgDHuIHc/AEu2cFF0TxFvxvM8NSNSODacVl5aNwJt9/
         W5OvrRZj0BbyOZN6OYvpWc32meRGMa9JxSCH1ki2IVDYG9hM9LQ6ybcCvuoyqXPP7Zbg
         Ps7GZhCrpiTn+LKa/Vhj34Ly+9Vx967o28L0e9HLjTH89FZV9Q6XRgF7SHXMNegVLACC
         fmIz4FeH9EH3YaitjCBuo39FwF08iBIF/CI1o/swKZ7JyKPBDTD0RIQh5woagXdDuYnf
         WICw==
X-Forwarded-Encrypted: i=1; AKwUvBxPU8J7MpnGfui/GRrDwspbKsmWvQ3AXayWDmmLUZxsKyOKz56KIPqF5+cw5KpkgJGcNmBdh8A=@vger.kernel.org
X-Gm-Message-State: AFuF++lJiot5mvEAPrqe9WkA89ZAEGhKdzxtNjuGXqpIAa1dzloTYTFW
	sFZ8zas3GcTQYZ4yFoP5nQ4Xe0HwgSrRf37DkP33rlO3EOMPdgCDjYA=
X-Gm-Gg: AYBFou32ROh9nFuJZYvpdFgfNsOK/XHnG1Elnj9U8wlyFBl7Z9YC/2hLI4bSls05mGa
	GAxpwtSFwWMQpjzk4GAUBMlX2baqLJbmd6JeFWVNUKnaGjvgUftYowxHHBx7ZBmB0TV1stOEdpw
	qZ4+gfRvbD7+BD4zexGfEXnVOnBn/fsaXQczXNf3XQXXcemCtAsZ4Ex8KHwNs0JOFia1DC7U9gQ
	M2TXyWz+6pvy5Jwzicpx8fWcpXUoAnEN16nK/ZxQiRkFT517R/+K8fK0BnMo+HlB2iuO2dnfKUk
	ssFvmUd7hS2sjopRKDNQqSKN/OffEokouGwqSRi4nxBMpUj7LfyDmILO7+X/9rNBk6ylac5QuBO
	3cfTRfer1NqaasE6x13pRg+70nwAZ05pG51B5rHX15hNQ38YA7bQ0jGNiRweZCHcLctZ/R9wnU5
	fRez0oiGGrLKX3UonGgBL07j730I9fdOz7cgSQqfRcHFza+ECGICJ9AJsbhOelhGSiZas502J0Z
	7/H3HsT7VoSHQ==
X-Received: by 2002:a17:902:f546:b0:2d3:7c58:b0e1 with SMTP id d9443c01a7336-2db1212aa5bmr210215015ad.0.1788634478070;
        Sat, 05 Sep 2026 11:54:38 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([211.230.25.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db25ea9bdfsm14337015ad.75.2026.09.05.11.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 11:54:36 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Chanho Park <chanho61.park@samsung.com>,
	Bumyong Lee <bumyong.lee@samsung.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: Re: [PATCH] swiotlb: use the adjusted address for the highmem page lookup
Date: Sun,  6 Sep 2026 03:54:31 +0900
Message-ID: <20260905185431.177766-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN6PR02MB41579A137BC1D48AFE93E27FD4B42@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260905084210.148255-1-donggeunyoo.kernel@gmail.com> <SN6PR02MB41579A137BC1D48AFE93E27FD4B42@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Sep 05, 2026 at 03:45:41PM +0000, Michael Kelley wrote:
> I don't understand this paragraph, but that may be because I'm not that
> familiar with highmem. Are all the slots making up a particular swiotlb
> mapping either highmem or lowmem? If a mixture is possible, then a
> partial sync could start somewhere in a lowmem page and cross over
> into a highmem page, which would break.

The slots are always lowmem: the pool comes from memblock_alloc_low() and
swiotlb holds one kernel address for it in mem->vaddr. PageHighMem() here
asks about the pages behind orig_addr, so the question is whether one
mapping's original buffer can span both. It can. ZONE_NORMAL ends at
max_low_pfn and ZONE_HIGHMEM starts there, and while the page allocator
will not hand out a run across that line, pages_are_mergeable() and
bvec_try_merge_page() merge on physical adjacency alone.

Your case is real, and this patch does not fix it. On a 32-bit ARM guest
(multi_v7_defconfig plus ARM_LPAE and HIGHMEM, 2G, swiotlb=force) with
lowmem ending at pfn 0x70000 and high_memory at f0000000:

  orig=6ffffe00 len=1024 last=700001ff
    mainline    PageHighMem(pfn_to_page(PFN_DOWN(orig))) = 0
    this patch  PhysHighMem(orig)                        = 0
    phys_to_virt(last) = f00001ff, past high_memory

  dma_map_page(pfn 0x6ffff, off 3584, len 1024, TO_DEVICE)
  Unable to handle kernel paging request at virtual address f0000000
  Internal error: Oops: 206 [#1] SMP ARM
  PC is at mmiocpy+0x4c/0x334
   dma_map_page_attrs from ...

The same oops with and without this patch, and no partial sync is needed
for it: the bounce at map time does it.

is_highmem() is monotonic in the pfn, since ZONE_HIGHMEM and a
ZONE_MOVABLE carved out of it are the highest zones, so testing the last
byte alone covers your case and this one, at the cost of the single test
already there. On top of this patch:

	-	if (PhysHighMem(orig_addr)) {
	+	if (PhysHighMem(orig_addr + size - 1)) {

The loop copies through kmap_local_page(), which is fine for a lowmem
page, so entering it for a range that only ends in highmem is correct.
That guest survives the map above with it.

The second one predates 5f89468e2f06, so I will send it separately.
