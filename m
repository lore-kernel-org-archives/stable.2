Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC6E423E8A;
	Thu, 13 Aug 2026 06:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603790; cv=none; b=VMVDBfGeR6MvgseBU2FIu21i7O1KjqE+9x1gpXMySjvf5UgTPVeIQZ7vTD8XsxomiPydKAs8QLK/qO0LTUBJZRVF0NlBkArnNgSCTlZkPh0Zi46PUdPd20V0NKGx/3Jp1+VwhulrXJxutBT6+FA+1i0T8pE2jqoUPErZhr3FzLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603790; c=relaxed/simple;
	bh=s+TwnIZkvD9w7KY/LtXNCYvHEcoUUDwXNwbpWlfeL8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uSUd5bSSawtN0LrBekqo1rzlMUfBsXSzyzNIifHXLrdU2wwEpjtcXu3FtVx9bAqdDgVA7ObENknpu2G0jY7zh5ZdIB/05002BqLuYEsQ9YYwKqwsIhEAq/UzitWL6wYBpC1CHh67GA5RjeI8eGz0d8l5eHNR/aR8r+vkDc3X42k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9H7tZPi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9H7tZPi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCC31F000E9;
	Thu, 13 Aug 2026 06:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786603788;
	bh=XWVAjD/nEro8uDxMyMVRO2dkiMc7OmlFiyXh9ZGt0bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c9H7tZPiIv0XaZ8VTyCmhTfvlP1RT+sRhN81bJHLdSAG9KOKzvLwGoxf+1QXEjgnO
	 iTcKdbyv18HY54kMRIQAt/xItLyLB9RMdG3o5kcuICQktLnUGyvb/3ui5wLMKXhOk6
	 9ukfE3eA8eoQpD5zHPQNU0kNYwA9ACRvvcgNrgJv5g4WUf4vGwv4/3hR9X9uDDcrt/
	 TD4C63VNVaxP8O+a6NboreQrl4pgvUOCKr5tbjhbvRXWhMxEzme33X38NowY4LT5D5
	 T06K8sY3mIaKA61fpBhqm55GltviFjV/+n7jzNEt7KatlclBLGLtog1PsEzsIw3+Jm
	 fXR7kEDriE7Ww==
From: Oliver Upton <oupton@kernel.org>
To: Marc Zyngier <maz@kernel.org>,
	kvmarm@lists.linux.dev,
	Fuad Tabba <fuad.tabba@linux.dev>
Cc: Oliver Upton <oupton@kernel.org>,
	stable@vger.kernel.org,
	Sascha Bischoff <Sascha.Bischoff@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Fuad Tabba <tabba@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] KVM: arm64: vgic: Reset in_kernel on private IRQ allocation failure
Date: Wed, 12 Aug 2026 23:49:41 -0700
Message-ID: <178660378179.666424.9983630355464884379.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260802150845.3485757-1-fuad.tabba@linux.dev>
References: <20260802150845.3485757-1-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 02 Aug 2026 16:08:45 +0100, Fuad Tabba wrote:
> kvm_vgic_create() sets vgic.in_kernel before allocating the per-vCPU
> private IRQs, but the allocation-failure path resets only vgic_model and
> leaves in_kernel set. As irqchip_in_kernel() is !!in_kernel, the VM is
> left with an in-kernel irqchip but no model, and the -EEXIST guard at the
> top of kvm_vgic_create() rejects every retry, so userspace cannot recover
> from a transient -ENOMEM.
> 
> [...]

Applied to next, thanks!

[1/1] KVM: arm64: vgic: Reset in_kernel on private IRQ allocation failure
      https://git.kernel.org/kvmarm/kvmarm/c/43347154e7ab

--
Best,
Oliver
