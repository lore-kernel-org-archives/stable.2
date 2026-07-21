Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC86C233722;
	Tue, 21 Jul 2026 12:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784636499; cv=none; b=MFTmCg6+02zMfwaJO319YRnLSy+TZLg4z6D9CIoytoUkZjTqjbt6hA8cAXHSmMyMRl5T+eK4GknJaNKpyHwuxM51IZZJmPT5AeAuyGLNd1fM3BUraGwOc2/1JJ/MSRBpX6D0yd5TzHnJQzQSxXgE1/+vmi7Iw8JQ+qFGkKCBT3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784636499; c=relaxed/simple;
	bh=5hF65TvGm6ZeH7SjoI5rqNR55IYZMCG1MrXEHEI3guI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GFHT5fVBQnfatPN663ZeVvPxkTw/TfdJkrCk0hTVJIsQtYRTM9OOwYBFo2x/YHqFeYetPDRCO3QfZClBKU4Fn0CYbx/Vh8Bpw54sEF33/bORUgB9lKa3CdfblUwKqxgCTVOBiXPy9v8LaQJicHV44ik5ZIf7iJab4XeEujnZiJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoPemclr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoPemclr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAF21F000E9;
	Tue, 21 Jul 2026 12:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784636498;
	bh=STiiiD8sn5T8o6q/XAi7/ld9NRuppncTz2/Ib0ViIwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OoPemclrok3uHlvXc5kRpJZ2LLmvPVJLP08JB/5t3JRs2uzzWkhRBIWhzhAt7ifZC
	 UELAbHpQyMClzigUpPIWKoZ02aCw2mUObwx/JurmE1AXhUIF8pneJSCjRj0AisXwG6
	 BMb7T4hOLhHvQP36d9HGEhAw6TMS5jpzH4AI/iXk1FzGtXFF9dcFETQscNAOMn0gsy
	 OaEAXb/B+5l1PXoPc89IKyfAhx31xI8ibd+QJL62fZ9tNaVe45NEQlKLRxyIWxnUXL
	 SQ4XW10OmVCYdmK2Q5iJqtDn82PYMXmlqQNo9lE7ZmtiRlEdUHm4BpLXWnQmZarbcS
	 gTpQRqCjcuxeQ==
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Disallow SVA if page walk is not coherent
Date: Tue, 21 Jul 2026 13:21:26 +0100
Message-ID: <178463325256.217595.8082116174299726720.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260716053554.1642374-1-baolu.lu@linux.intel.com>
References: <20260716053554.1642374-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 16 Jul 2026 13:35:53 +0800, Lu Baolu wrote:
> Hardware implementations report Scalable-Mode Page-walk Coherency Support
> via the SMPWCS field in the extended capability register. If the hardware
> does not support page-walk coherency, a clflush is required every time
> the page table entries (which are walked by the IOMMU hardware) are
> updated.
> 
> In the SVA case, page tables are managed by the CPU mm core, not by the
> IOMMU driver. Because the IOMMU driver has no way of knowing whether the
> CPU page table management code has ensured coherency via clflush, the
> driver must deny SVA if the hardware does not support coherent paging.
> 
> [...]

Applied to iommu (fixes), thanks!

[1/1] iommu/vt-d: Disallow SVA if page walk is not coherent
      https://git.kernel.org/iommu/c/780dfed68862

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
