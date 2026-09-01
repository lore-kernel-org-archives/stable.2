Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7923C4119F0
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788277812; cv=none; b=efDoJ+okgMa5RcLDDnoOhLFwtcFFG0OEJcD+jlaF7rj+ptfqoVyI76nJ/QGfmgwLw2V6M1FiYHfjTeMldV9i8iRWFuVYnmK2K+1+ETDtZ9hHEzrin381XarFeq7Sz/xKtB7ue+7bfzS1c/akMxOLOCPghDHFKROSLOWbi+uDwbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788277812; c=relaxed/simple;
	bh=ajyzEffsSBkOYLQIR3aRKBK1NS8kHj7P6PrDglE8xvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JENCwie9SYD4TB8SvUVLFLQxWYSs2+MX0SDxdYRPLoE/PsnAm/pAxNujzaeoIyxRTwLifXF23/r2dZYekeBvRzGku4WA+luHf16qEFPEXMp5q7wit6v0X1Uem1WoHTE8X1gDjFHddkwqruCeKv1vw8mSC+1l/x47EYatfVmd3Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+Ver7Lv; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+Ver7Lv"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-853f8c34ba4so6673b3a.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 08:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788277811; x=1788882611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gzaoCwMvhgrc258eCGx9+hCu2m0m8ZaOD9+JsPMrJD4=;
        b=O+Ver7LvAAalfLRKwzmexoL+t2ENXM8l9dNhVN+cGPN60oVqcqwqhh9ahQfnru1VS0
         CAL5EMN4UV/78D9e4ixNeekvmCMFDqU8yCJV619iQb2nMeS66wZf+MMc5SYw+zMdlkUq
         b/mU3BhmbSPAZqH1jLWJy93FbbnErVrQ6BltVRyVSxmzS+Zayzy1iL+hoxm9pI/sWMGg
         CWMSxkNjjMHBy5spybeUkl0FwpcTYWB3DaWzh29JNX8ck6rx84hIVET2jPCuvxehCVoE
         U78yjuMGP3NrNmlbowE3YKrXZaMI/6m9qmDgqoPFWvP6ItAZCB/7DbwPbAUnSfSV4iui
         x4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788277811; x=1788882611;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gzaoCwMvhgrc258eCGx9+hCu2m0m8ZaOD9+JsPMrJD4=;
        b=RmgsWB0oJ6N/O1XxyP6lQF46pKG35sj7paGMcK1pIAgckZSwa9tpTvI6FwOBK0oXWY
         wL7QshWqZ6OOwySAM4gVF9h/j1y9GJ8ibb1CGl0weymcBc//KZO7oCba/9xp2KgAw5B6
         EbBpyvbO5wZa9sAgDeMm7uiHp2ZE3LDwUEFx9P7f0zX4srrmVVOJlRPMiviJmlUSpq4T
         MucejMq44phBNt3qHKWEju1npfLM1d/a60NgUsiRGRNgy67ZkwqbkFPdZbAK1R0MhXOe
         OQDEiPZpyC6W2noL0UQ70jD8ZS2h/0i99fNbJDVlQxxxSfWgbMo272oblAu/bkhTAWDJ
         SQkg==
X-Forwarded-Encrypted: i=1; AHgh+Rr3FWHfM4/ZCre4QGjOOCa9v27/vQZCG+OdSrbMdUEL2j6d7+FI36bzh41no6m03xbjyiZOZfg=@vger.kernel.org
X-Gm-Message-State: AFuF++kUYZO0CMpC061BzwqMYEePZjoA4m2pmvgpHYqepfoDBr40tGRs
	oY6R9kKrwbOXTaOhBdRsPbEAqD1V5eIN3pTIVIMmKr4abuumtyZ2/IFv
X-Gm-Gg: AR+sD132JePFFcP+HPn31mUhSaax2LI54J24Ld3t8RAc4ovYfOrS0FSvx4XORAseFNS
	n/0Hc0bvj1n5HooxM6vAiQejDgtKDXwSM1XVWaroUWIzgtPpLtIngtXfYVfQwiemApukPgqh30q
	jpwYir3PxA7l+CI4shZfnjrfaSpDI8/ehDfjMQTFh4JJywjpAxvRt2hy0Gr1ea1p/ymgFHWHFJK
	QclM8NwxqUsoPRjj0RJ8s5X8Ontr1oS1e3/F8KGpG9X0AOIrBGOYS+AS/058aMKOJH+UFVLDsBD
	XbCKAoxhZ2mKOkGzmcFhNqCqZPTP9JANvJJJSIdYlhifyU5hXtT8XeoL606xJfkGYRDnRbvErbG
	iKpNK6pu+JAuvgvLT1LiJEThLQMlMdWJgtzYfv7aAg2japofejsnjHZQcaVBfZZoLXfSXGMRHrW
	jIPf8DtfWqO+f18KDVoFBC2R5Ke+va9mWlCZB8yLxQs2IQWYELbKTPKmaznWNTCd9Csg7Al1ISV
	Nk+udxTN4b7O1aDzZnkUkB3N5MHDQ==
X-Received: by 2002:a05:6a00:f0c:b0:852:5f99:1866 with SMTP id d2e1a72fcca58-8562514cfb6mr56762417b3a.0.1788277810606;
        Tue, 01 Sep 2026 08:50:10 -0700 (PDT)
Received: from localhost ([2409:40c4:10ef:9c41:92dd:ad43:5cf5:f6a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85dc0e01472sm105067b3a.55.2026.09.01.08.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:50:09 -0700 (PDT)
Date: Tue, 1 Sep 2026 21:20:01 +0530
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michal Pecio <michal.pecio@gmail.com>, Mathieu Fluhr <mathieu.fluhr@gmail.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Thorsten Leemhuis <regressions@leemhuis.info>, 
	regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] xhci: drop 120ms U3 LFPS wake retry wait from
 runtime resume
Message-ID: <apbrp8EaJoIfEg5X@eggarch>
References: <20260831190349.29590-1-lovekeshsolanki00@gmail.com>
 <20260831190349.29590-2-lovekeshsolanki00@gmail.com>
 <a6a8526f-4b6f-46f7-9d02-05bfe3efcd48@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6a8526f-4b6f-46f7-9d02-05bfe3efcd48@linux.intel.com>

On Tue, Sep 01, 2026 at 03:53:47PM +0300, Mathias Nyman wrote:
> I looked into this again and remember now why we didn't remove the msleep(120)
> earlier.
> 
> If we want the hub driver to keep us awake to detect delayed port activity,
> then we need to wake the (root) hub driver in xhci resume.
> 
> That means always calling usb_hcd_resume_root_hub() in runtime resume cases where
> resume is caused by usb device remote wake. (xHCI PME# in PCI case), even if there
> isn't any port activity yet.
Got it, thanks for the explanation.

> We don't currently check if runtime resume is caused by xHC PME# wake in the xhci-pci
> driver. Not sure if there's a driver api for it.
> Instead we in resume sleep for 120ms if there exists connected and suspended USB3
> devices without port activity, and then check again.
> 
> This msleep(120) is unnecessary if runtime resume was caused by userspace instead
> of usb device initiated wake (seen as PME for PCI hosts)
So the better implementation will cross into the PCI side, are there any
plans to implement that? Or any interest in it at all that you know of?

> Probably best to just take Patch 1/1 and look at this xhci resume part separately.
Do I need to resend the 1/2 Patch independently now that this one is
dropped? Or it'll be taken as is..? I'm still figuring the process out.

Thanks,
Lovekesh
