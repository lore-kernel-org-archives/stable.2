Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D8E318EC4;
	Fri, 28 Aug 2026 02:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787882699; cv=none; b=kln+P0IjKgsnyYdrPafH3S0741nqWyzwJkO9rhXBLtse+ttPceVcy/sPmxdIz0qBobPz9s/YrysTTYU8hMHu2VXUYLTx7IUXXqXb1RDxVyQfnzLObJIzXR8AnK4e+41DTvvYOkK0Comsa20P1Jxf/SBKRWi8t09V5690pkzM2ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787882699; c=relaxed/simple;
	bh=a4oe8ZdC6UeisTQKpKxHPEeb0NPLaBZZLo0RDJzV0+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWuiTjbmT1bLehvR7PBheGPATIZ4VOG8vFfl+g7zRaiV07/if6GwGsGryMyPIF19lqljBrsARAjlHcydrPLt0zigXm96+RHB3FPAdCTJL5JGLWypHVCF5yfD1Yk0FbPc1hDX39PrQw3ffp+wLGjiiN3NsZQIFmS1CVxkYmEJmes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGIK5FTd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGIK5FTd"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5EB831F00A3A;
	Fri, 28 Aug 2026 02:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787882697;
	bh=a4oe8ZdC6UeisTQKpKxHPEeb0NPLaBZZLo0RDJzV0+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NGIK5FTd8b9G4QBKpMrX+tIHd1+dl6TaNmLKw7N2k83kPCb+izxGY9gA0a2lBhFYC
	 ATJhhKMLpZh+2OD55fTLHxsYux1eifRJBDCwvhgJo+z+PYkhP7Gv0/EFlROF/HB1b/
	 rBTO98q3gkI4IJ6Bhvbva4X/U+w39Cpu/Ydy6MUNDjX5a+PyL42cuO4+v/eGF2XOYn
	 ZTBGCd02eDCh97eXdA7ua3jb81EHAXSrWA9/5wRum7aiKSE2iBMyEV/cFADF0eNqNx
	 pu7ndDvUn0qCBPlcP3E2/HzOCyXF8+7ClBwb+x0GjVi9IPh3gOlKs/KUkWsm8U3+TU
	 LDF1gyzPBX57g==
Date: Fri, 28 Aug 2026 05:04:54 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: microfish <f13208471983@163.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tpm: crb: handle ACPI NVS memory region overlap
Message-ID: <apDseLwm7saXAdbd@kernel.org>
References: <20260827035511.49582-1-f13208471983@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827035511.49582-1-f13208471983@163.com>

On Thu, Aug 27, 2026 at 11:55:11AM +0800, microfish wrote:
> On certain Lenovo/AMD systems, the BIOS declares an ACPI NVS region
> that covers a large memory range (e.g. 0xccc40000-0xccd3efff) which
> includes the TPM CRB MMIO area (0xccd35000-0xccd38fff). The E820
> subsystem registers this NVS region with IORESOURCE_BUSY in the
> iomem_resource tree.

Cannot and will not move forward given undefined and open set of gear.

There was also a corrupted email address in the CC list (microfish at
kernel dot org).

BR, Jarkko
