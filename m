Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F553859D3;
	Mon,  5 Oct 2026 23:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791242841; cv=none; b=s8U2+ve4b+3cfePlPrspnFk/RUm5zgAEZRfS/cLvcsT7qIG5nugGFi3SK2FlIc4CJymq2WBfGXsNyYj0ezIaM2Yda08qlq/fFc6C5sFsbDNeWzYXTr8/5X9WcpaYwMNbtRDl1wuWixHe4o3nhBRqSNvqYPv0XuAQuS6hekPx2K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791242841; c=relaxed/simple;
	bh=5JGnocJYw30HbGm83ZIUd63l0uZkU7FSISeu12sc8iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pG9KJR3FAhW9eQ010ICb6R+fcP4pGe7bIXGUUnVWWfZSIhrpymbAbvpSE3m9GcgvXxiIniQl7nTCIQ1i4LfFceOdij6aKr9ak8egpyRSiXQgr1tbBh4mQIUcTjIPWJFkz89/tQbYuGV2O4d5x7C+uzy+DsVLSwLVyxpivWmb2Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiAtA938; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiAtA938"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56601F000FF;
	Mon,  5 Oct 2026 23:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791242839;
	bh=WBg20LLYaRPC5p8DnVDECrTO6jgh2E+qFuXSSu1+OPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=JiAtA9389pKiNZ/CFNdNGZg9ElYghY3oQCZaMIdG7HN1kBL+JCey9eKAJbuxAXkIM
	 D5TNRQ4bL6Bc9bnSaYT00Cfla7K2k95ur+YyPKYhXOrs8tln3u2NGmWfVONYo4RHuA
	 qHVr2g17PYxa6ZWaP9e+qSo/9dmJtJbGYTdh9Zxr6aCBMMeoRh1rpyeQ7WWRosLAcS
	 7Eu3PUUZnf741EfbF54G9O4QMgoCfFfDDVqE9anoy3l8VUI6apGYzzyZeUNmVDlDHU
	 BtrFFsqJyrf5OlmlUUFODHWzMCreON7H3qXeHYXEsz20oOvlTg6PM0C9WJtIDkOTwO
	 lFKUUaO+Kl8yA==
Date: Mon, 5 Oct 2026 18:27:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Priyank Rathod <rathodpriyank@google.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 0/3] PCI/AER: Fix ghes_estatus_pool memory leaks in
 error handling
Message-ID: <20261005232718.GA644801@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260928-b4-fix-aer-memleaks-v5-0-ba6b94c9c9a6@google.com>

On Mon, Sep 28, 2026 at 05:40:11PM +0000, Priyank Rathod wrote:
> When firmware reports PCIe Advanced Error Reporting (AER) events via ACPI
> APEI GHES (ghes_handle_aer()), it allocates a snapshot buffer from
> ghes_estatus_pool to store the aer_capability_regs registers before
> enqueuing the error record into aer_recover_ring.
> 
> aer_recover_queue() returns void, so ghes_handle_aer() cannot release that
> buffer itself; ownership is handed to the AER code, which until now freed
> it only on the fully successful path. If the record cannot be enqueued, or
> if a dequeued record cannot be mapped to a pci_dev, the allocation is
> silently leaked. Under a sustained error storm this exhausts
> ghes_estatus_pool, which then breaks GHES hardware error reporting
> system-wide.
> 
> This series fixes both leak paths and documents the ownership rule:
> 
> Patch 1: aer_recover_queue() when kfifo_in_spinlocked() fails because
>          aer_recover_ring (capacity 16) is full. The rejected entry is
>          freed immediately via ghes_estatus_pool_region_free().
> 
> Patch 2: aer_recover_work_func() when a dequeued entry cannot be mapped to
>          an active PCI device (pdev is NULL). The loop is restructured so
>          ghes_estatus_pool_region_free() runs unconditionally for every
>          dequeued item.
> 
> Patch 3: Add a kernel-doc comment stating that aer_recover_queue() takes
>          ownership of @aer_regs, which must be allocated from
>          ghes_estatus_pool. This is documentation only, so unlike
>          patches 1 and 2 it has no Fixes: or Cc: stable tag.
> 
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>

Applied to pci/aer for v7.4, thanks!

> ---
> Changes in v5:
> - Add patch 3, a kernel-doc comment on aer_recover_queue() stating that
>   it takes ownership of @aer_regs, which must come from ghes_estatus_pool
>   (suggested by Kuppuswamy Sathyanarayanan). It is a separate patch so
>   that the two fixes stay minimal for stable backports, and because the
>   comment is only accurate once patch 2 is applied.
> - Add Kuppuswamy's Reviewed-by to patches 1 and 2. Their code is
>   unchanged from v4.
> - Still applies cleanly to pci/next (94e8d4e94266), before or after
>   Lukas' "Error reporting for AER-incapable devices" series:
>   https://lore.kernel.org/r/cover.1790531238.git.lukas@wunner.de
> - Cc Kuppuswamy Sathyanarayanan, Jonathan Cameron, Ilpo Järvinen and
>   Dave Jiang, plus Shiju Jose and Rafael J. Wysocki as the author and
>   committer of the commit in Fixes:.
> - Link to v4: https://lore.kernel.org/r/20260918-b4-fix-aer-memleaks-v4-0-f0a2c21ed1d1@google.com
> 
> Changes in v4:
> - Rebased onto v7.3-rc3+ (f259f446f519); applies cleanly to pci/next as
>   well. No conflicts with the Advisory Non-Fatal Error support that landed
>   in the meantime.
> - Added missing Fixes: e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption
>   when error status data has multiple sections") and Cc: stable to both
>   patches; that commit (v6.7-rc1) introduced the ghes_estatus_pool
>   allocation whose ownership these paths drop.
> - Patch 1: use braces on both arms of the if/else and fix the continuation
>   alignment (checkpatch --strict).
> - Both patches now build warning-free with W=1 and CONFIG_ACPI_APEI_PCIEAER=y
>   (earlier revisions were only build-tested with APEI disabled, which
>   compiles neither of the modified functions).
> - Explained in both commit messages why the caller cannot free the buffer,
>   and when the missing-pci_dev path is reachable.
> - Cc: Lukas Wunner, who has been active in this code.
> - Link to v3: https://lore.kernel.org/r/20260803-b4-fix-aer-memleaks-v3-1-e87159611933@google.com
> 
> Changes in v3:
> - Resent to fix threading of the series.
> - Link to v2: https://lore.kernel.org/r/20260803-b4-fix-aer-memleaks-v2-1-fd199b0171fd@google.com
> 
> Changes in v2:
> - Refactored aer_recover_work_func() to ensure ghes_estatus_pool_region_free()
>   is called unconditionally for every dequeued record.
> - Added Patch 1 to fix related memory leak in aer_recover_queue() on kfifo
>   buffer overflow.
> - Link to v1: https://lore.kernel.org/r/20260803183853.432459-2-rathodpriyank@google.com
> 
> ---
> Priyank Rathod (3):
>       PCI/AER: Fix memory leak in aer_recover_queue() on kfifo buffer overflow
>       PCI/AER: Fix memory leak in aer_recover_work_func() when pci_dev is missing
>       PCI/AER: Document that aer_recover_queue() takes ownership of aer_regs
> 
>  drivers/pci/pcie/aer.c | 48 +++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 35 insertions(+), 13 deletions(-)
> ---
> base-commit: f259f446f5198d98e13756d2cd531812a0ad3064
> change-id: 20260803-b4-fix-aer-memleaks-524a1bd5e888
> 
> Best regards,
> -- 
> Priyank Rathod <rathodpriyank@google.com>
> 
