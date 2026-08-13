Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD624322F1;
	Thu, 13 Aug 2026 06:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603790; cv=none; b=eolmgEtb03m/3T7lpW2Hjcs/E1hqvbO1iZERhUAPDv2a7sy8u+HDfRZyl/ZskGKGRUy3b36S+wDOO/k/qPYqEoyCJzpvDgFPgpWRt3suE46c43UBgAw6mXsJqFd16yGcewNURk57htHe1BIWgBfodla27bRvjEENBDDbxgUu/fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603790; c=relaxed/simple;
	bh=r2QEdIFACWL4iniQ0fN4tRgkbG1j8BEp3uWQpcQgcQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=otgqbXZI/c1ZaZjZnQCjareuzcLfEYB2/HbteL/5ZO+ooyJ75gmiwzKHAFCS/sCcmYM9PjgfI7uYbGuGqovKc2iP02/5+JzUwmb6E0XbY58MzLaHsQE9Bytt3czv4XDUL0GBhyt7fDUs8OARMVwRGddjZVj+jl2ZTEqWZWmy4MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqZCADmt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqZCADmt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B591F00ACA;
	Thu, 13 Aug 2026 06:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786603789;
	bh=IguZ5Oag0covDIAikAUhxM1m701WZwel7fdytL4nLjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IqZCADmtaZEws8oz6nZP8szNmcqesy1n85piLDIEHAVoWLtH7YgUKTfqOKU/fjnAX
	 UYoKz/afxUxTDB1retLFMC7x2b9GSYgunmvK7OmehYcaPgImTZ0btpINJ2nsaGrsFT
	 BeZhogncnUxqsUXSDU3HLD03/zpoUhil/UoGw6WCKh+ANjFr4RcnHEXUh8C0EcwAUW
	 ABl/4/AWwx/7/mhPQBgZ05GFTA/+rokAdZhfP363Cb2vSBlEx9DSZK5d3TKIvTCCSE
	 RqeWYtJhEmMcsXoqvcAkB/YSDa1rVGaET4SctD0N8DpaWknUxPMBmxkWMh1PDwYvOV
	 Wj+XBQ62Oobhg==
From: Oliver Upton <oupton@kernel.org>
To: maz@kernel.org,
	fuad.tabba@linux.dev,
	joey.gouly@arm.com,
	seiden@linux.ibm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	jic23@kernel.org,
	Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc: Oliver Upton <oupton@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: vgic: Fix detection of MI on no pending LR
Date: Wed, 12 Aug 2026 23:49:42 -0700
Message-ID: <178660378191.666424.10998670140107835415.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260810102923.2426475-2-kajetan.puchalski@arm.com>
References: <20260810102923.2426475-2-kajetan.puchalski@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 10 Aug 2026 11:29:24 +0100, Kajetan Puchalski wrote:
> As per the ARM GICv3 spec, the maintenance interrupt identified by
> ICH_MISR_EL2.NP is asserted when it is enabled and no List register is
> in pending state. This is further described in the document as "no List
> registers with the State field set to 0b01 (pending)". By checking only
> the pending bit of the LR (bit 62), KVM currently asserts the MI when
> there are no LRs in "pending" or "pending and active" states.
> Fix the detection logic to consider only the "pending" state.
> 
> [...]

Applied to next, thanks!

[1/1] KVM: arm64: vgic: Fix detection of MI on no pending LR
      https://git.kernel.org/kvmarm/kvmarm/c/a342faadc5ac

--
Best,
Oliver
