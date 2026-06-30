Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7EB358360
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844252; cv=none; b=lh+Pcs3UM21NOWtRCTr3LibvskWO+iEAXpqpjFe2H6+HwOteCZz9Iffw0n1LjL/FCDLUhvSga9a+siiK4q0TFPHVzW1k/v+1AVFWopqKu+zph0K5xnPZ2BZyE0vv++N46oc4DJxNbjqQfB/MFPDb1OlpO3XP5troP8x0BL0uKOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844252; c=relaxed/simple;
	bh=lcny+By7zybEfee72uKlhA8jZ6/K+CPLkKhviUZiqUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRH3uKe/vm4q0UU7bBNfVOkylfeT+pHKX7Ki6uhZzehl84loH25/g3e1PVSX3L8+Oas3tFyW8Ql+dVa79reTh6OXXkNOGgKp64JZJ+jMg+fjh3RfamqqKyjSm8IYGta5O0ICt1xpHYSXw0MAXVyxddcTohH2ls1+XsocQlGQ7To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y/tcZGKo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y/tcZGKo"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c81db32393so8975ad.0
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 11:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782844250; x=1783449050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UFLNZBPki14ArLq9AWdBh/KIv4fHhLMZ/fjJCcm8kA0=;
        b=Y/tcZGKoCtsfen3bajfdpgiPwaMHk0XQ1hzw6G+FDAa4F3IuJi0gr4gENAJg14CUP4
         2fRsWFoTOtCbCcG/fOEyhYQCXqOv0Bs1WzFch5O0rwhcmGJxYRYzJ/Dd81nOD+FtSOxg
         /e+ydkweo7WFiie2nErukmcvUP/MnWqQsSUJ/BZuilAadLTzvqcgu3g4MMw7+ZW6zvB1
         ky8WP/CcohoVnxdr+g/KOsgSx64ZjsQLsE9+z6nfPS5Zvb6PHxXoN2aT6cSPxWA7Oc9Y
         HEvXw46yk+I6AbzeZ0xjwbJNQ2F9Cil+qrqVwLScbEdJr9+Kii02HgwHeWzy0jO8oghL
         ZupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782844250; x=1783449050;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UFLNZBPki14ArLq9AWdBh/KIv4fHhLMZ/fjJCcm8kA0=;
        b=Sg8vb6jmxTKmKn/ozgou8HLzntkJnK9Aauf09Qi6B5aNfnpnGtcO+Puen58kFeId5b
         7wTesEULJ6h/JXqufoUmnCu4tTTxlww6eSgfebfuA3u2mQGzTHs1V0HEQtN6yCuAHGvQ
         46sf5SwECe9oYrIuyi7gx4eHFyPASFR8RNr6sKBSBwKFZTsbrQHQtWFRUjPTbx5okwFL
         sbCgngFR4b3DKj+bVp8HmPfULMJSo+VwzeZrP5gTKdLE/e0vWDM5AItliGoqMhyNnrAf
         g7Z7pYMuoQN/7LRFx3I3rcx+2hHI4ys7VNMHBnxJdn1YEn0kR3WDFuvpvrQaEzrFEb1u
         IClQ==
X-Forwarded-Encrypted: i=1; AHgh+RrSOt8Xawsm4//qwQpwgdDrTYNNVQVqv3f1xRe/8lUqXX1VIhvtW7vMA6zDbEuW8VuIEZzRWpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb8n26FfGYdRQsGQeXIjuTrMmxWNuWn6mEFNiBFRCKWKBVzcNo
	mWgHVzyr8SJ/nbHMXlZXFXx5tXOI3wwkNHBTTvFCL5mMBl/5fIUzrsOqRdJI/avP5w==
X-Gm-Gg: AfdE7clZ9DDVZjbaLMYYLs63l2ApcK9jtODKuSwAb8Ez79DV6RQY7F9poLPZS37N2cS
	RFuqiIEELOoBCt8Fc4m+6S4r0zENRsjq9wpp9ia2vPL9jp8bCzdpvstQx3sJ3xJWGBXilOijOWV
	T6uYwNEvYlNueUsE1Nm5K1AoMjwTK6oXt89Yo5VC7ekpGV9r09P2sRyZsiIJyQ+4Kv+bHyjYlDw
	aonDfe5I5UqBpfxg2kmaqF51pw86tfqKjwFEnVUt1IU5X1ST9+77rqFI9fBIljNVAWLWA7thb2N
	1bOF8UpdCrkbLPBplEPxFZ098/sYV8aM1jasUYNo5Xs9hhJyP0zadpHZOXLI2QfeH1ynsCZ9MXd
	1FEj23rGCFshd5Qjv3GXUDYybiIs51ezKTLqChhWbDnXTIFsOZl0CySlLcRyEBJqN0tjs3zeGic
	EaJCek97KYJsOtpLfA05X8isivYRV7z3bsh0PMY+NUJMCrOv4=
X-Received: by 2002:a17:902:ccc8:b0:2c1:ee6e:be1d with SMTP id d9443c01a7336-2ca68c40b96mr331005ad.27.1782844249825;
        Tue, 30 Jun 2026 11:30:49 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a00029d3sm2576588b3a.20.2026.06.30.11.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:30:48 -0700 (PDT)
Date: Tue, 30 Jun 2026 18:30:41 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	kees@kernel.org, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jamien@nvidia.com
Subject: Re: [PATCH rc v7 0/7] iommu/arm-smmu-v3: Fix device crash on kdump
 kernel
Message-ID: <akQLURkLA-bZ9dAk@google.com>
References: <cover.1782799827.git.nicolinc@nvidia.com>
 <akPB6l-fuJUcg4a2@google.com>
 <akPX_N0P2EcI_jbV@google.com>
 <akPhuF9pAWaBXzpi@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akPhuF9pAWaBXzpi@google.com>

On Tue, Jun 30, 2026 at 03:33:12PM +0000, Mostafa Saleh wrote:
> On Tue, Jun 30, 2026 at 02:51:40PM +0000, Pranjal Shrivastava wrote:
> > On Tue, Jun 30, 2026 at 01:17:30PM +0000, Mostafa Saleh wrote:
> > > On Mon, Jun 29, 2026 at 11:15:33PM -0700, Nicolin Chen wrote:
> > > > When transitioning to a kdump kernel, the primary kernel might have crashed
> > > > while endpoint devices were actively bus-mastering DMA. Currently, the SMMU
> > > > driver aggressively resets the hardware during probe by clearing CR0_SMMUEN
> > > > and setting the Global Bypass Attribute (GBPA) to ABORT.
> > > > 
> > > > In a kdump scenario, this aggressive reset is highly destructive:
> > > > a) If GBPA is set to ABORT, in-flight DMA will be aborted, generating fatal
> > > >    PCIe AER or SErrors that may panic the kdump kernel
> > > 
> > > Can you please clarify more on those errors, what conditions will
> > > trigger that?
> > > For example, patch 4 disables the EVTQ to avoid events as there might
> > > be a lot, why are they not fatal also?
> > > 
> > > > b) If GBPA is set to BYPASS, in-flight DMA targeting some IOVAs will bypass
> > > >    the SMMU and corrupt the physical memory at those 1:1 mapped IOVAs.
> > > > 
> > > > To safely absorb in-flight DMA, the kdump kernel must leave SMMUEN=1 intact
> > > > and avoid modifying STRTAB_BASE. This allows HW to continue translating in-
> > > > flight DMA using the crashed kernel's page tables until the endpoint device
> > > > drivers probe and quiesce their respective hardware.
> > > > 
> > > > However, the ARM SMMUv3 architecture specification states that updating the
> > > > SMMU_STRTAB_BASE register while SMMUEN == 1 is UNPREDICTABLE or ignored.
> > > > 
> > > > This leaves a kdump kernel no choice but to adopt the stream table from the
> > > > crashed kernel.
> > > 
> > > In many cases the patches assume that the CDs/STE might be corrupted,
> > > but still attempt to retrieve them with some validation
> > > (log2size/split...)
> > > However, the base address might be broken, TLBs state is unknown...
> > > 
> > > IMO, although that might improve the status quo, there are still
> > > heuristics, in addition to noticeable complexity to transition the
> > > stream tables. I wonder if FW can deal with AER in that case before
> > > booting the kdump kernel.
> > 
> > I guess we're reading the base address from the HW register itself so
> > that should be fine? CDs are in-memory so that's why they could be
> > corrupted?
> 
> For example patch#1 verifies log2size and split and both are read
> from HW registers. Same for the base address or other addresses as
> the page tables, they  might be corrupted due to a buggy driver.
> My point is that, it is really hard to assume that the previous state
> of registers/STE/page-tables were valid or even consistent, when the
> kernel crashed and did not transition the state gracefully.
> 
> > 
> > About the TLB state, I'm not sure what might pollute it, since this is a
> > kexec, I don't expect any non-kernel entity to gain program control
> > before the kdump kernel.. Hence, IMO, we can't configure FW to deal with
> > AER here..
> 
> Similarly for TLBs, the kernel might have panicked in the middle of an
> unmap or free domain. (not to mention what that means for RPM where
> a device reset with unknown TLBs?
> 
> Why can't the FW deal with it?

The FW can't handle it because between a kexec from main kernel -> kdump
there's no FW-based handoff hence wee can't setup a handler in FW..

> As I mentioned above in the previous
> reply I am not sure I understand what situation leads into this, when
> does a device trigger SError to the system vs when not which is observed
> as an event in that case.
> 

Ack. I see what you mean now.. How does a DMA fault raise an SError? 

I'm guessing the HW (PCIe RC) is wired in a way to raise an SError on an
error? But I agree that sounds pretty unusual, why should a DMA abort
panic the CPU? Is the DMA happening between a platform device & PCIe EP?
Even if that's true, why would it raise an SError? (No CPU was involved)
Unless, we have a fabric that raises an Serror on a SLVERR or something

Thanks,
Praan
