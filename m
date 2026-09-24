Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9DF468C22;
	Thu, 24 Sep 2026 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245880; cv=none; b=D9oJyBedhAy+G1WHshS1O2L9/v/GirPi712o3w0QuHO3ijgP3EeR9RzMnddtgFK6ErbXRHkqx6nEEJz4HgWm8ODIkoAMiSLp4dCxmdEDS5WeMeHRDJFiZpESZU/ISBsYl87hDjpw7W4LUhzcuO2nPRRHScGVwu4O1MCJNcVpwIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245880; c=relaxed/simple;
	bh=t5CUCNXBwrVlk9w4SRDJZtegrMXEc+rgxxpchlBDCUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/Y/4agWMvsxQr7RgMU/Q7kgweNwCF9RQcopA3l6LXpjGVYq2ZPIXjS/aLH3dC5Uca58lLxh3kVPgtsDCJhUyUgXB29sa6llcN4FL4Ei0oOQ/bjUct9J7Yi6ItGpqWWhftY88nG3H180BYdD1RFMzXB6Z8TAD3pQhSG1EJTv/hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEoo3VWI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEoo3VWI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422371F00893;
	Thu, 24 Sep 2026 10:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790245878;
	bh=7KXEtpc2eZOzFLNgU6BIxcnmmI4v3hM2iwSC1MNAdVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NEoo3VWIyOplC/opylAofAG/oV3i0WzEkZSaGQ2AcrpyotAPEZJSL6jgesPeUk4OQ
	 BHcfkL190UQNx6Gkp6yEdEZ0kzrzafpyWv/mDKtvap5QPb5CiCG1RmsTNiEjp1GYCk
	 DPt3fLD33JB6R8a9DQ7k7CnoEoAHlX+/lLYfH1Y8ExCnZuDrk/WLUtqsBMmzWYN//8
	 P4ywCrVZxZm1hDcLmlpJtsHB93/U0a2Xx3qH6aBWLvpF4pXvmDNysHcbEl3hyoiJ2M
	 dblzkb4QsMo8zsEOW0S3rk/2HuWCDyPmW5+gPG0bPOR7et3NjUjqq99+RsJ9HxI/70
	 59e0epli+M9fg==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Andrea Parri <parri.andrea@gmail.com>
Cc: mark.rutland@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dev Jain <dev.jain@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: Fix the break-before-make flush range for erratum 2645198
Date: Thu, 24 Sep 2026 11:31:06 +0100
Message-ID: <179023970437.1597741.12909890449648716020.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260923143636.89480-1-parri.andrea@gmail.com>
References: <20260923143636.89480-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 23 Sep 2026 16:36:32 +0200, Andrea Parri wrote:
> modify_prot_start_ptes() performs the break-before-make TLB invalidation
> required by erratum 2645198 with __flush_tlb_range(), whose third
> argument is the end address of the range.  It passes nr * PAGE_SIZE
> instead of addr + nr * PAGE_SIZE, so __do_flush_tlb_range() computes the
> page count as (nr * PAGE_SIZE - addr) >> PAGE_SHIFT.
> 
> For addr > nr * PAGE_SIZE that subtraction underflows, the page count
> exceeds the batching limit and the flush degenerates to flush_tlb_mm(),
> so a single-page mprotect broadcasts an ASID-wide invalidation and a
> full-range mmu notifier call.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: mm: Fix the break-before-make flush range for erratum 2645198
      https://git.kernel.org/arm64/c/1fef81669147

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
