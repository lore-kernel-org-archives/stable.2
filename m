Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040BD22F767
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 02:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786070768; cv=none; b=llhZjkkHtiqnL+kZgNngX3xGinCoRdQX1OrcZ4WlrP4+VTOUxtEZKITA23ixCYXPOA5WuTuCyeHv3PqN+PLoSKBS0bCSH5J9ZrCFMeyfvpqldmgH5Ba5kOYaomG/+7XGk6fw8Eol2OtQPmxiFqMBlIKx8s5t+pBJJNUXA3+xRpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786070768; c=relaxed/simple;
	bh=E+A10ZgAwOIZaanu4gdLK500K83DKg11qbbqlN/20P4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=bbQtqEcEXacYKhzaPxDsveGuDzauhyEihR8Otn3/Pw9Cdar9WmfIsu+MDuTacoTTD9472fZ+48uRawBPY7Hvp5viCDJmEIFvpI1MqUd9xNQ/ckNUrGcY4XhIb7sSgE96zzxvhvStDj0aCufVdQw3JIzYL2ZxLKHfPOlOOMSU6l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APFiuaEC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APFiuaEC"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2caea3f742bso39919555ad.0
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 19:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786070766; x=1786675566; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cGAigAv9qTLUUJepoIiK8+xQUGcQy/mbHbtZRpAl3rg=;
        b=APFiuaECgWsaN7Q0O5CYyMPXqqC6kCqhwbhubg12G88KbDf1BwZnPBZNrcp4Ryqcez
         /d2td9pbi9rxO5c1qSdKhJcdmvSjKLEVTXKGBoeNhs/OCfV1ZvkCfgox5+UyJBuZ9pM3
         XIA5BpAWJ9k2a2MOvK3wvo8hXSmD7zO8jpxg46XU0cOM3wGb0p3hxdPJT1mZ9Sz0qsCV
         2MeqK7LQ+4ILUjYIm1WQi5/V3HxhuFBUX1E8uTLdt+w0sJ3gGilyxgqpJKCnUmtNghh0
         OysPadK96I8K8SFKdksFH6a/N+tJAh6v2ANl5KRPsIJcmVeayERtlC4IOcdivxcHawdT
         00+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786070766; x=1786675566;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cGAigAv9qTLUUJepoIiK8+xQUGcQy/mbHbtZRpAl3rg=;
        b=YajpaNB0TdaFsykyRmOooejH8kI4YWZxchVVCPQPmAxFg3XiScesiN2EkaUdj4H059
         yheEwteTEJW05tZ2rXWLuVBYJBZkCwkSM18tFC9KZXWpB0y5sk6VMMoOZqA/JBqsLh1D
         XjMCeAx5vB3YI/lECrOvwhN0lxPZMkFRAQZ2CE5Ee60pRobawQaFdaxOi45qBZ1tOQJA
         Cq+iw4f6dPYG7N6PedyGCMXqRmkA9IFWPzG1+mhRtaZZUuRbo/iYUsYep8LJmhoc61te
         X2ytNLZMxpih/25kanPeevxPYshbEllAALh5AglxwIVnvq315HVzaDWzhdpuk3zdgr1I
         ziVg==
X-Forwarded-Encrypted: i=1; AHgh+RojEErAOpvxsfzuk2kWte8ImPHkDj0p9IFPUrJE65pbenMGKqbPaNWiI6/AE1CSw7pHbu/FMKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlJggKqJSL109ZTUIcMG8jL8N0Z2hkeahGC2IS6FQs9bKbOJG/
	Z+fx3I8Owrood8ErLiLcXUWZ5/zrMMnkCiITr9h/AiRk28ls3LxMeqTX
X-Gm-Gg: AR+sD10W0wbOb+WUNB/h1Apg+zl5+RwV+0gwMieji0Mn05VNXbQrU1GqMQF8h6XF9QZ
	yNDP8RIYcWAOroAyar0WiELbfx50REJ+IcEXoBPHAOY53Yz5xewpv6BERfAQh92ak0DEyu+jbFt
	Bqez8DfAezLAa1qW73oaYl3Dy4spUSC+L5AOhudbcdCWbvoLq2yfvnDy4Qqm8XxMs6Hxiyh2U98
	rhA4gXfzQULrr9P5pqNJ1kIBNGyxJhvDFwFZgIFKZpy8UF27uTX6m5xP76ccCtDJySaLxvWyrVU
	yF8pLZ/lzyr0FFlbxAgafCHR6oeVRJo33poPLeBQsz5LVCOQI5Twv03ligQawm5dleybn0pQeFi
	6Nl5C9WR5HRyEtcK7gx6zjrmBL3gOVBFrRUZjXzZX0huL1XzV862rzD51AVnlVYiceQ7CPOHSep
	B0S44xiXiRZFObxy8+yucQTlC6yD95NTBehZcsYdCJ9CKfn/cCAvAjpDLp8PSD
X-Received: by 2002:a17:902:c952:b0:2ca:619f:9733 with SMTP id d9443c01a7336-2d0ca9620bfmr211897085ad.17.1786070766256;
        Thu, 06 Aug 2026 19:46:06 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bebde2e6sm1462086eec.21.2026.08.06.19.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 19:46:05 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gaurav Batra <gbatra@linux.ibm.com>, maddy@linux.ibm.com
Cc: sbhat@linux.ibm.com, vaibhav@linux.ibm.com, harshpb@linux.ibm.com, npiggin@gmail.com, Gaurav Batra <gbatra@linux.ibm.com>, stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org 
Subject: Re: [PATCH v2] powerpc/pseries/iommu: switch to Default DMA window during kdump
In-Reply-To: <20260803224029.60538-1-gbatra@linux.ibm.com>
Date: Fri, 07 Aug 2026 08:08:32 +0530
Message-ID: <jyq2lknr.ritesh.list@gmail.com>
References: <20260803224029.60538-1-gbatra@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Gaurav Batra <gbatra@linux.ibm.com> writes:

> In PowerPC (pseries) a non-virtualized adapter will have 2 DMA windows -
> 2GB default and a larger Dynamic DMA Window (DDW). DDW is large enough to
> map total RAM to a device.
>
> During normal functioning of OS, since RAM is pre-mapped, 2GB default
> window is not used. The only scenario it might get used is when buffers in
> pmemory are mapped to the device for DMA.
>
> As of today, during kdump, during early device discovery, pci_dma_find()
> finds that the device has 2 DMA windows. It selects to use DDW. This is a
> kdump path and DMA window is needed for IO to the device.
>
> Although commit 09a3c1e46142 ("powerpc/pseries/iommu: IOMMU table is not
> initialized for kdump over SR-IOV") fixed an issue during kdump with SR-IOV
> case, but this also made the kdump prefer DDW over the default DMA window
> when both are present (dedicated adapter case). Since the DDW is fully
> mapped by the previous kernel, iommu_table_clear() can free only
> KDUMP_MIN_TCE_ENTRIES (2048) TCEs for use by kdump kernel.
>
> This is not enough when the dump device is NVMe over Fibre Channel.
> Because nvme-fc driver DMA-maps the cmds and resp IUs of every
> pre-allocated request and each such mapping consumes roughly:
>
>     32 (IO queues, one per cpus = nr_cpus) *
>     64 (queue_depth, blk-mq kdump limit) *
>     2 (cmd+resp) = 4096
>
> This is already double of what we have without counting admin queues and
> lpfc driver's own allocations / mapping requirement. Hence this results
> into iommu_alloc failures like -
>
> lpfc 0153:70:00.0: iommu_alloc failed,
> tbl 0000000034ebcf5e vaddr 00000000d814df0b npages 1
> lpfc 0153:70:00.0: FCP Op failed - cmdiu dma mapping failed.
> lpfc 0153:70:00.0: iommu_alloc failed,
> tbl 0000000034ebcf5e vaddr 000000009779e4d2 npages 1
> lpfc 0153:70:00.0: FCP Op failed - cmdiu dma mapping failed.
>
> iommu_map_phys+0x1c4/0x1f0 (unreliable)
> dma_iommu_map_phys+0x54/0xa0
> dma_map_phys+0x3f8/0x590
> __nvme_fc_init_request+0x110/0x300 [nvme_fc]
> nvme_fc_init_request+0x60/0xb8 [nvme_fc]
> blk_mq_alloc_map_and_rqs+0x388/0x510
> blk_mq_alloc_tag_set+0x2a4/0x5f0
> nvme_alloc_io_tag_set+0xe0/0x1e0 [nvme_core]
> nvme_fc_connect_ctrl_work+0x85c/0xdac [nvme_fc]
> process_one_work+0x1e4/0x5a0
> worker_thread+0x1ec/0x3e0
>
> Increasing the number of free TCE entries in iommu_table_clear() will
> increase the probability of hitting EEH since there could still be some
> active IOs from the previous life of the kernel.
>
> Hence this patch partially reverts the previous fixes commit and
> switches the kdump's default back to 2GB default DMA window instead of
> DDW window. This window will mostly be empty. Or, could be slightly used
> if buffers in pmemory were mapped for IO.

BTW w/o this fix the only TCE window that kdump & kexec uses is DDW
which won't work for 32-bit capable DMA devices correct? So I think this
should also fix the kexec & kdump case where we have a 32-bit DMA device
- which otherwise will fail to function after kexec with the following
error:

"Warning: IOMMU offset too big for device mask"
"mask: 0xffffffff, table offset: 0x800000000000000"

Thoughts?

>
> Fixes: 09a3c1e46142 ("powerpc/pseries/iommu: IOMMU table is not initialized for kdump over SR-IOV")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gaurav Batra <gbatra@linux.ibm.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

