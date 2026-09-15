Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F11346E54;
	Tue, 15 Sep 2026 22:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789511147; cv=none; b=d5wnB37V6P7/yZy3lXmlclzF+bwy9pOS+eLw6X5fRVtaU2wqrtUmRazvkkuELDxNrBQGDOrJm9r0eJ7Tej9I38X7BOKyB4sXnW7NeDet/iybgkrnd5+58YzqcuLAQoUW7gLDAitkm54Vb6zjrcj64SINpR7tH6ij0TSCEbdYiss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789511147; c=relaxed/simple;
	bh=qMMq4AGHkIj+I10WwWqI3FQuAWnG4vnD++yiDnBMwvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MFXwowK32e9tU4fop9FvxdxS1tcFBjehsiePlABWY+Jnmx2Hdm4W1UPfFHxLZrsrZDH3IHuxE7BOQ+7dQVCCTkyZFulCQRCN7yy7SSYGRPBtBlnCKARktwo5Wqk79hUi+1aXfkqIFAK7Q2ztJBFHVWT5NBNl5qILxktktP7qLcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MERX6Eyv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MERX6Eyv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F731F0089C;
	Tue, 15 Sep 2026 22:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789511145;
	bh=UJHW2zr6j28wgdd6ygTO/gZ4sHjNUcda5NUyoTuBQYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MERX6EyvDfpB0PHv1/QcMnPYWf2eUGtcXzm448nfqp/QF82ovFpFp7Mh4MYe5QgQF
	 5UUnashJUXeRsg52cTwkivpfVlej8DXRGjjxz0x/5Q0WRtNBmp2znjvp0jMr4GdFXt
	 JA3MssY1tvM34B3JKfV/QsdQFgPvLmehW8BEXW3oXnhH7N89ni8QmFEsF2WtSjNBXf
	 im3gEt4tU1uXSmhQRyrnfHpU7IxPnvMCEo1mUlIGITdY2uzvtUePnbyAJ/UE0Th5GR
	 UvbuxOIgydC6WXK06waLaRT2NN0VFwjBmX00+7CYtk01O6CnuzRU8bV5fk0z0xCp5N
	 3qXuVLff5ksjg==
From: Oliver Upton <oupton@kernel.org>
To: Marc Zyngier <maz@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>
Cc: Oliver Upton <oupton@kernel.org>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Keir Fraser <keirf@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Quentin Perret <qperret@google.com>,
	Hiroyuki Katsura <hk590@cam.ac.uk>,
	stable@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] KVM: arm64: Fix host access to the EL2 stacks
Date: Tue, 15 Sep 2026 15:25:33 -0700
Message-ID: <178951103697.10790.359285321366515778.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260908110713.1540304-1-fuad.tabba@linux.dev>
References: <20260908110713.1540304-1-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 08 Sep 2026 12:07:09 +0100, Fuad Tabba wrote:
> The per-CPU EL2 stacks are initialised as host-owned after pKVM init.
> fix_host_ownership() walks only the linear-map alias of each memblock
> region, and the stacks, mapped in the private VA range for their guard
> pages, have none.
> 
> Patch 1 is the fix, and it needs none of the other three. Patch 4 adds
> the check that would have caught it and would catch similar instances
> in the future: once the transfer is done, walk the private VA range and
> fail init unless every valid leaf is hyp-owned, or is hyp text mapped
> without write access.
> 
> [...]

Applied to fixes, thanks!

[1/4] KVM: arm64: Transfer the hyp stack pages out of the host stage-2
      https://git.kernel.org/kvmarm/kvmarm/c/3a8c562892b9
[2/4] KVM: arm64: Match hyp text by physical address in fix_host_ownership()
      https://git.kernel.org/kvmarm/kvmarm/c/5a8b505ede13
[3/4] KVM: arm64: Move the private VA allocation cursor to __io_map_next
      https://git.kernel.org/kvmarm/kvmarm/c/224584140114
[4/4] KVM: arm64: Check every private mapping is hyp-owned at pKVM init
      https://git.kernel.org/kvmarm/kvmarm/c/cfe80c3837f9

--
Best,
Oliver
