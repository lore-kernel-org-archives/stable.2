Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027D94A8FD1
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531161; cv=none; b=TW9nLl9WBYFGXsBy6RqzBO9uUkHHCQ2PVxd8W+Qo2G+I2HQa6OuX0eQgH6uHEGIQfeNASUyA2gJR4qPZq5PrBwgMjJWxWLpm1HbaNcDL+Wlc7kRvJ1qwN3wNgT/SI2qelIKGCUQTX/aFMk4mdyUvt9BLxaCNTETSHaH+wf0TAqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531161; c=relaxed/simple;
	bh=4JtxpubpIDaW26gj2nXAkR98P56puzbSWWN3SnVTBxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4naU1fF8VJn5r67A3YZsZHv78YxPEPPpJiQ0gdKBj4C/vWu4+DZ/TnWp7xPG0ygh2uMpSM0pmlDjbOye6BWfZ0Tuez0sQOPzg7p2qCjk3u8+h3XB5eZbq9vWrv00B/6pB/WObqYsQxV7YUuBchCfyx58neXbpEfLCIip6YD1k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d31w5z5c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d31w5z5c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBA01F00A3E;
	Fri,  4 Sep 2026 14:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788531159;
	bh=zcjCcuIKUd86S2z3nxmxiL62uFu/aU1fTg0bXNPuSeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d31w5z5ct3fWg/PByY3D6NVBoWQAl/Q10s75PUEP1ErLrk785jNvNMnZOvfCZ8/oW
	 f9yvk23JwG4p/iOR4rYn0un55EBFkLSVttgoRYmwrDQCStytuZQlkVmi7U3MHnBaDY
	 Dg33myaRTTE5rPMY7bvFq7iST0zjLrlilR+6umoQ+hhNrtQ3Tx96duPMnua9Lx/VlR
	 WN9ASCEelvxze/ixcuLBH2K1IWvrRVi5Rtciu/GsblvYHNeGGoefHLDHqwfZ2MlA8e
	 UPH5zL6w4f41u9Lypx9OmAFeRgpr6ntbWjUyPuteCuXETK2VPVc6Ll7ssgzt4IXzjX
	 wwCaXO18aY+iA==
From: Sasha Levin <sashal@kernel.org>
To: kernelci-results@groups.io
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	KernelCI bot <bot@kernelci.org>
Subject: Re: [REGRESSION] stable-rc/linux-5.10.y: (build)implicit declaration of function 'put_unaligned_le16' [-Werror=impl...
Date: Fri,  4 Sep 2026 10:12:33 -0400
Message-ID: <20260904133600.rc-reply-0002-pci-sysfs-unaligned@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <178850515502.887.10241922684330722879@kernelci.org>
References: <178850515502.887.10241922684330722879@kernelci.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> New build issue found on stable-rc/linux-5.10.y:
>
> implicit declaration of function 'put_unaligned_le16'
> [-Werror=implicit-function-declaration] in drivers/pci/pci-sysfs.o
> (drivers/pci/pci-sysfs.c)

Thanks! This is the same issue as the 6.12.y, 6.1.y and 5.15.y
reports from this run.

Both patches are now dropped from the 5.10, 5.15, 6.1, 6.6 and 6.12
queues. Thanks for the report.

-- 
Thanks,
Sasha
