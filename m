Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55B14AA56A;
	Tue, 15 Sep 2026 22:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789511149; cv=none; b=HTL8a062lHBkIGIR51QHijdwFRhWK7iY6A4+qNB40muLl1J1qhTkiQ3HRMl/22ZSlkuXIhp9gj2TJgIUpIwGZOqM7u71v6vQ5fqQ1ys1y+K0qx2bPtecy9wNFOE+P3uo6AlnyQAjmyyis8k7207SgHuC0rqKqdumBw93SBxWlGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789511149; c=relaxed/simple;
	bh=TTnmonPOE4UROMIdFJmHx5qPJETKaZ3YwNRO3fT6aNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hmia6Z8IM3dsAsjFE73TnsEHpRmug6wE73vXsRW9pd7UF/eq/u73xEV6CTgy0nT+HaZCm4gymPlOqFNwkIr4CmSsvG2+71hTN2tzfT3mxIr9vkQLhUM36+/grSAVU64raTq00fcSgncx5M2PA6sLURhw+7vrSaC6Hwmmy31spFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTbZMRmB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTbZMRmB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655511F008A1;
	Tue, 15 Sep 2026 22:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789511147;
	bh=+w/qcLrX2rTuwmLcVOn6au3NRLwXERMUbyiNARdv0Dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JTbZMRmBrSnpUtOvIGLKkvcMuM0cdSivcl60DxSsSfRu/1YmKDiIVi/sz9KpzC5LM
	 PzbYPlOlnxkk63Ar/caJgqbq6GCbOuR/7kmayLo070MWg3daAQx2sAw2UUkZfLUuTW
	 GB8aV8eQNugWJjfaf4jEcCzUHnXVENtalMkLv/k0szhC/M84buizlzI6G0958+s/se
	 yeb0xhiFJW/zxLgl3qk1Ff7QJmu4P6Uin9rw2l+fpkJJgTDtrQ2kT5BvYZDG4VzlUI
	 r3Cv69JJDiBxAvKmVBX/f8oXRRwZYQyjHLSOr81vh4Iwti5/TCdATao+kzdkoa6hJL
	 sM5b3x1Wt9uuw==
From: Oliver Upton <oupton@kernel.org>
To: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Christoffer Dall <christoffer.dall@arm.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Yao Yuan <yaoyuan@linux.alibaba.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 0/2] KVM: arm64: Fix spurious warn, null ptr deref on S2 teardown race
Date: Tue, 15 Sep 2026 15:25:38 -0700
Message-ID: <178951103702.10790.13969077149562964690.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901-kvm-arm-nested-virt-fix-v3-0-b154676f7e4c@kernel.org>
References: <20260901-kvm-arm-nested-virt-fix-v3-0-b154676f7e4c@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 01 Sep 2026 18:28:58 +0100, Lorenzo Stoakes (ARM) wrote:
> When GFNs are invalidated in L0 an MMU notifier triggers
> kvm_unmap_gfn_range() which tears down all of the stage 2 shadow page
> tables for nested guests via kvm_nested_s2_unmap().
> 
> To avoid lockup, the kvm->mmu_lock is dropped while doing this and the task
> rescheduled once for each block of physical address space (32 MiB for 16
> KiB page size), with the lock being reacquired once the task is scheduled
> again.
> 
> [...]

Applied to fixes, thanks!

[1/2] KVM: arm64: Fix spurious warning for benign stage 2 teardown race
      https://git.kernel.org/kvmarm/kvmarm/c/38b70fc453c3
[2/2] KVM: arm64: nv: Fix null ptr deref on nested wp/unmap, teardown race
      https://git.kernel.org/kvmarm/kvmarm/c/4c74e233cded

--
Best,
Oliver
