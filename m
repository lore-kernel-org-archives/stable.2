Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59A83DDDBE;
	Thu, 17 Sep 2026 19:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673465; cv=none; b=Dn5qjA/vz9STM8dzq8SXffyDpYXisFNnyV9Rmd6NTsyMzp0891HIQ6IkxQEYmtTFavwY2/TdSIQTxLqqJPN1ohmUK9eosMLL2T0ckKynSPbdr60bRvYDEYxF3Ji37X2P57thZdtZLrHf2vmjzqh/SF+9K5A9HCA4uzCMuLtGZAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673465; c=relaxed/simple;
	bh=Gb0RN/m9mh8iOtufEqLHMLjTufZb8KtDn+YQ8GIuUTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pri3jMkmAqjp4WBDVupG3u+ipBUhUMrg8+w1JAVVqnf0tE1x4zl/+P5rZms2m/BBRUYck9jtCcJlkroOh9O2nL3hbx8Hho8dwRtwJjF/NmeLTLWIuLOmC18F/nFNp35tSeCgO8V7+qnh/hM4pTGP7SpFiA61Y+We7Em8yaDoauI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DOpOdo2r; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DOpOdo2r"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9480D1476;
	Thu, 17 Sep 2026 12:30:57 -0700 (PDT)
Received: from thinkpad-e142931.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DE343F7B4;
	Thu, 17 Sep 2026 12:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789673461; bh=Gb0RN/m9mh8iOtufEqLHMLjTufZb8KtDn+YQ8GIuUTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DOpOdo2rdUM5LYOSxm6J7IaJIKhEZ39OXU03jJgsqEUxPwKUDmAcEuY43y3Pa9F1D
	 Nj62v8/4YZzJsxHMU3UFrahkHCYzXsy1Glpryt++e5loKPZZfEcC2TrjqqOarBhmfg
	 zgMT9N4uoMYppi4jtARUjBxC//1zanKKuJzBTCXo=
Date: Thu, 17 Sep 2026 20:30:49 +0100
From: Wei-Lin Chang <weilin.chang@arm.com>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Ene <sebastianene@google.com>, Itaru Kitayama <itaru.kitayama@fujitsu.com>, 
	Sashiko AI <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] KVM: arm64: ptdump: Check the page tables aren't
 freed when accessing
Message-ID: <ezplrvcw7buhd75v5rezvkhbgdfldxklqavdpnxl2fad5thswe@kctrvkjzr6cs>
References: <20260916230337.4162485-1-weilin.chang@arm.com>
 <20260916230337.4162485-2-weilin.chang@arm.com>
 <aqugxlnqegPzMpB-@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqugxlnqegPzMpB-@google.com>

On Thu, Sep 17, 2026 at 09:11:50AM +0100, Vincent Donnefort wrote:
> On Thu, Sep 17, 2026 at 12:03:36AM +0100, Wei-Lin Chang wrote:
> > An open debugfs file keeps the KVM structure alive, but does not prevent
> > mmu notifier release from freeing the stage-2 page tables when the VMM’s
> > address space is torn down. Therefore page tables belonging to the mmus
> > could have been freed when a thread opens or reads the ptdump files.
> > Take the mmu_lock and check mmu->pgt is still alive before accessing the
> > page tables.
> 
> As Sashiko said, the read_lock is probably enough, including the existing one in
> kvm_ptdump_guest_show()
> 
> With that change:
> 
> Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
> Tested-by: Vincent Donnefort <vdonnefort@google.com>

Thanks for the review and testing!

I agree taking read_lock is enough for most of these, but changing
kvm_ptdump_guest_show() to read_lock could result in a dump showing
weird output e.g. 0-sized ranges. This happens when the dump reads a
block, and a parallel fault turns that block into a table, and the dump
descends into the table later.

This is debugfs afterall so I think it isn't a dealbreaker, but it adds
another purpose to this patch. Maybe we can change
kvm_ptdump_guest_show() into taking a read_lock when someone reports a
scalability problem when dumping the page tables.

I'll stick to changing the other ones into taking the read_lock now.

For future reference: KVM_PGTABLE_WALK_SHARED is required if we want to
change kvm_ptdump_guest_show() into taking a read_lock.

Thanks,
Wei-Lin Chang

> 
