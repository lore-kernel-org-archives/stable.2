Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336FB2F9D98;
	Wed,  5 Aug 2026 01:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785892425; cv=none; b=URVrwvWgRBjMuZMYCY3l8kN823nmVW8vu9wIka3+7/0erXs2n0FwwMpkXmhvP5OnBk8jaEqrVpndDr5AFEIBG9mRejl32oXFY5u2g/TcI9alIoan7FEobcd74BjGQMauAxNHSn6X/d9Io90U2XqNzj14tKNKZycttasEKGGm+kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785892425; c=relaxed/simple;
	bh=YPRwq/Nx3I64uR5ZkZgJIaEHUe6c3iR9LNZcAfLmbvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNb6JWNT6f9j4nmndf4Ha0iMEbYRFDlgDczCIUgMepdXwPIO4/SOBPAAEbC2OKcafVrIVfEyA1mD5k+VRt3mHpB1iawVbC1IBnbfNd8ZB2fNy509uKfYTT/ADMKP4Mw8KCRE6lxCx2QwlWGaDUYyCijGKtIpVdsGcRhjidTWTZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAVkB/oJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAVkB/oJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4821F00A3F;
	Wed,  5 Aug 2026 01:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785892424;
	bh=VWKOw73oYdEnTVak6G7xtXtNMQiYQ77k1pN8UjSVCVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DAVkB/oJsQ7DvhwqdSX99nd4EB8QB9vvWgnYxYMorV3qY3vmo7QqlScUB2g92e7RA
	 a2ASQ4Z75SseHQnqnLsZpVa7AaRpiiDqa7hUUIoE1PWRPBjI+KBm32n1kMbiBlPfab
	 gdI8C51WC9kYhYh+VL/sm99bm6Hr5BXPPY8mdJb+R1beQvxxy58Z/SSBdtSXA7fsAB
	 xm0qZyEN1hTS6uIWSxWEGadJuE/KytPCCVbije9RFBSAe2qLR1TxutzEhS+Mo/IKjt
	 GIyKdbsuqkOfmp/eZSPJPQGDa6qbCUMcRU+am8EgiHl12A4PT4werMNotcaJjuvWGg
	 aPQjY5CurDD7Q==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	baolu.lu@linux.intel.com
Cc: Sasha Levin <sashal@kernel.org>,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jgg@ziepe.ca,
	akpm@linux-foundation.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	albinwyang@tencent.com,
	albin_yang@163.com
Subject: Re: [PATCH 6.6] iommu/sva: move x86 disable check before allocation
Date: Tue,  4 Aug 2026 21:13:30 -0400
Message-ID: <20260805011007.stable-0008@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803114039.319953-1-albin_yang@163.com>
References: <20260803114039.319953-1-albin_yang@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 03, 2026 at 07:40:39PM +0800, Wei Yang wrote:
> Backport of commit 72f98ef9a4be ("iommu: disable SVA when CONFIG_X86 is
> set") placed the IS_ENABLED(CONFIG_X86) early-return in
> iommu_sva_bind_device() after iommu_sva_alloc_pasid() and kzalloc(handle),
> while upstream puts it at the function start.
>
> On x86 this leaks the kzalloc'd struct iommu_sva (early return skips
> kfree) and a globally allocated PASID (mm->pasid wrongly set, never
> unbound). Move the check before any allocation/side effect.

An ack from one of the maintainers would be appreciated on this.

-- 
Thanks,
Sasha
