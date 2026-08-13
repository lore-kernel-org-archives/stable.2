Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAC941C2E0;
	Thu, 13 Aug 2026 06:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603792; cv=none; b=OM90146K0w4Ce8otPI1gNj5opx2zUJD0gROtxoGA1B/jUHo6O3EKtfpodcB9/Q6O3BIJKdmU19B1/tpJoY1aEqbRLQTQ9pIH/dxbRwLTycTcFDEFrvvi1L5/gXTPWDfSCFbuKTdKtCXtTEoLRt/T31t6RUpVvPYoardX4kkehBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603792; c=relaxed/simple;
	bh=wwtWBQZ73l9bGBQNlF9GokwK8g7tSIE9RomNFOUYSBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cesT8/UtCFQ4g9yYaMwgD3ij761nrUcSN7Meiw2rPNcWjgEAoYYYovZb0hQsYV/zIURj84rHNFWCokR5SfqBizduZD5XaHSQOmLHv1C1Kjvey9TWFtqUstlxVm2sdxq244sMd23BdzoHqa4zSoqySCXWDHZcKt5DToGc5d9iK78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neGyp4u+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neGyp4u+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C8B1F00ADF;
	Thu, 13 Aug 2026 06:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786603790;
	bh=bi8JANOgLxs5xInmNcIsw1Pu2PyS3DSLV+30DqMtpsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=neGyp4u+YLVE4HABA9HaV4tNSyG2JxRxbut8qrRY20DW9eBQz5vxqsBOzWmyGfmMz
	 SD2A/qbTej9LcHnNZVax9hBxTCdKDKB/QzlLLZ6I2eSiI7Mv/K0ZvKPFTN+h0E7/CS
	 EOGv2YUomqXCHoI/kPew4ywApT2SkL+ti5P6QAN3kVsv3jxGumybD/lKjtR8csTbmH
	 a8xh/mdYhEvGI9+boYeMSNhYdVQ51iS2zQrdfy7LWz9YYMdpu0/7+gKf/oUIUEgZOU
	 fvVHDDlKqCbNF7VnCG/opckNDmPpxaCR8Z0Z5cL4xR845oJraPqc5AuJbk2CiFwUn2
	 jPi4n8saUsJBw==
From: Oliver Upton <oupton@kernel.org>
To: kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Correctly cap TLBI Range to the architural limit
Date: Wed, 12 Aug 2026 23:49:45 -0700
Message-ID: <178660378192.666424.18260188450907943902.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260810170616.746100-1-maz@kernel.org>
References: <20260810170616.746100-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 10 Aug 2026 18:06:16 +0100, Marc Zyngier wrote:
> TLB Invalidation by Range has a fairly powerful way of encoding pretty
> large ranges in a small number of bits. This range can be based on an
> arbitrary VA, which means it is pretty easy for a guest to generate an
> overflow should the hypervisor be naive enough to add the range to the
> base...
> 
> Make sure the range is capped to the limit dictated by the address bit
> that determines the VA range. For an IPA invalidation, this is further
> corrected down the line to ignore the upper range.
> 
> [...]

Applied to next, thanks!

[1/1] KVM: arm64: Correctly cap TLBI Range to the architural limit
      https://git.kernel.org/kvmarm/kvmarm/c/69a598288195

--
Best,
Oliver
