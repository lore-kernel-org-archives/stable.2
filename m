Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793360532;
	b=PSCkc2DEyYFnuTgGDoX+5AhsHJLf7zbjdSM0unuSvrwNNzgJRocU3p754TfR/O3+/kUL
	 DVTmR6oPTL+5q1SkDxldVkwMJNmu4PuTu4xG1qZOSLrM5hpJOgkG4GzU4/pTYdYlr4ioF
	 DhdNZR0RKbIlkZtaw62WXmvcvSgF8KS+Ms2bhSatP8czRgQ1eI+9lPGJa2CYhC/GssRFv
	 SzHVM+7o2uqdcr3XuSz+iywc10IQ1pwE/EGnLInrmBrtdP0PUPa/vXRiuhknbidWzt4DY
	 TYiOWJLhLDzUbAUul8P3o7/Kj81qLqD6korn2hynA6UsjoF1r4TcbQGrrjvy7Bwn6+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360532;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding;
	bh=r6oWs9NRS8dj5BRdE3SOboRlekQH4GrocVOda0uMj/o=;
	b=DyAopwT2a2wmaDxH5uTJTQ5jUQ/LqnQSwfyrucD2e5zYcOeHpRal0YlzOw7uYLkTl5hL
	 xR3iTV3J9R2EpfwC6UWQWids5BUVAMJwoa8cF1SuSNrrJn43eyo8N7F4z3OFLh3dl0tf2
	 mbK/Clf5+O6YEoLnmAaqSDhEgYKgp9LnA8Zw9iqjNtGzV++DPFW98aRMIe88B620OQAdt
	 8LeLvV0R9fPXr2RhrTeph7lENgIX+CiihPV0Bh6/fyK7zNj98eHjtMCoY1cCTjEt4uMJ3
	 A/QHsa6o+25cE8ja6fXIJer8hoYyo1Gxwd7tpDmAC/ca//tKgOKK+VxN16K/s88iIrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XIVYestp;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018CB606A31C;
	Fri, 30 Oct 2026 11:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 018CB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XIVYestp
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 203521596;
	Fri, 30 Oct 2026 04:42:07 -0700 (PDT)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B86A03F7B4;
	Fri, 30 Oct 2026 04:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793360530; bh=TryfSyMJmpjHJWemiNgo4MBnrsZct6ejB9ZK29wCuRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XIVYestpCiqkWkpRrm7MMoeveYoA5FIQIuL/wKTNRlmW9R/fz0++XawOSAjqlO8Xy
	 6Oe7eykXf0SSQhKGDWSu4I/x7OTqVZ4S1lauXoLjNrGaFP13bMuZg8DoxKgM6Lw1gH
	 Zhlv37cZ4yULbIomkP4C4YA8e8Zu7yMJb2FV7GWw=
From: Leonardo Bras <leo.bras@arm.com>
To: Wei-Lin Chang <weilin.chang@arm.com>
Cc: Leonardo Bras <leo.bras@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Gavin Shan <gshan@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] KVM: arm64: Fix dirty logging detection in ring-only mode
Date: Fri, 30 Oct 2026 11:42:03 +0000
Message-ID: <auSCioOj63P47PMV@LeoBrasDK>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029175238.3214788-2-weilin.chang@arm.com>
References: <20261029175238.3214788-1-weilin.chang@arm.com> <20261029175238.3214788-2-weilin.chang@arm.com>
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
Content-Transfer-Encoding: 8bit

On Thu, Oct 29, 2026 at 05:52:37PM +0000, Wei-Lin Chang wrote:
> When checking whether a memslot has dirty logging enabled, the
> KVM_MEM_LOG_DIRTY_PAGES flag is the source of truth. Previously in
> memslot_is_logging() we were testing the dirty bitmap only and did not
> consider dirty ring.
> 
> With the ring and no bitmap, a logged memslot can still get block
> mappings, so guest writes to most of a block are never logged and a
> migration can copy stale memory.
> 
> Fix this by using kvm_slot_dirty_track_enabled() instead which checks
> KVM_MEM_LOG_DIRTY_PAGES, within memslot_is_logging().
> 
> Fixes: 9cb1096f8590 ("KVM: arm64: Enable ring-based dirty memory tracking")
> Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
> Tested-by: Fuad Tabba <fuad.tabba@linux.dev>
> Signed-off-by: Wei-Lin Chang <weilin.chang@arm.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/kvm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 705f6d84770e..c7df646af79f 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -176,7 +176,7 @@ static int kvm_mmu_split_huge_pages(struct kvm *kvm, phys_addr_t addr,
>  
>  static bool memslot_is_logging(struct kvm_memory_slot *memslot)
>  {
> -	return memslot->dirty_bitmap && !(memslot->flags & KVM_MEM_READONLY);
> +	return kvm_slot_dirty_track_enabled(memslot) && !(memslot->flags & KVM_MEM_READONLY);
>  }
>  
>  static int pkvm_flush_remote_tlbs(struct kvm *kvm)
> -- 
> 2.43.0
> 

Reviewed-by: Leonardo Bras <leo.bras@arm.com>

Awesome, thanks for taking the suggestion!
Leo
