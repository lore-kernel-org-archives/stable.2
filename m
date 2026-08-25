Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800C03E63BD
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652921; cv=none; b=Shymyj8LQiSqlhzacja3G1RCYvHhzLonyN1UujzDGsBXcVu3LuaPnAsCidwCY4zoT+NyMFKkFJzhcncAPsVcbc2XN0x7nSjH09vPl1Cu9xCMRan/yW55jubKBkiUpnaI800NcPzHBgP82Fl7RKQgBpnz2McCIWYuetnF5OrvPpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652921; c=relaxed/simple;
	bh=tvZn/DMGKqbYfXmiEXnBW9Jf8jg1KanjiDCL69cMdX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMzu89kOS61txHczXzf+LVgO2HeD35S1AnINVO29cGvMm3Z9MqfHetNtJ9sstFZAYWNwh6ztOXA0jwO3zvVq2qjXHTbXA8YlexZMPIrBAf7fGHqHel0FZo2hzTbpIsZ+Kt+2jWYnh/5dDE1aRZ4JIWVLm+0eynTtCqAHJu+kGoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HN1COI2f; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HN1COI2f"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc149372c14so3333958a12.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787652920; x=1788257720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t/2kEnaWyYQdlZqHnH4m5uiHvxgG16cMzCUkrsocMZc=;
        b=HN1COI2fUevhDRatIMcA+EelMC+p5KlZVqE18Vj4wQsyVMsq3a+LolXiMqa1+shIF3
         PFYOt2jvH1H258f9EEDfzDCnGeK+6Bt2OWJBQjcueVAojyllKCa+hdTRU3L5etuDcedU
         NPtDmDR5VcXydX2o9YW7P0lWuiyO1HoQc0069IGKCPYO1N28ILspCyTdiHhqUNABYqZb
         f2QCPNz5LOas7RrLoIb2BUFdlrm+efbt2SviCMAvVfNociPX8K7RlSoecplwYSfdR7pA
         yPeN2wVVLQOq0JId7rpXelpl8qh9rFb21MMxQ+WG+PFbxd3A1PcHWuAUBKswGIeeEQ1P
         gzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787652920; x=1788257720;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t/2kEnaWyYQdlZqHnH4m5uiHvxgG16cMzCUkrsocMZc=;
        b=GJALbCt/WMYuexS1GfkEqx7GkH7tEQuo/mGjhJ/uMtUcSKlh00CAOQ6abWut690v/n
         48F9IqwKEYdpOf3gm8onNnwxZptHk9qzn0qAQRAQomnlROMlyN/zBcYysYH5af8Vt0nP
         6iGkeK5cobA+SVXiwh8aZZYXwjR0UvgLhY0iO+LcJ43Dc525lm8Uo8ph1ApX2kvs6tKk
         NrK7zCzjawx9pZthQvgU5rMjIPTfj+Lm1Tn05iaH7IiU/L1D4eQ6uF8DewkBlf9g8+O8
         dajq8wLfmhzAK5+HBa0p5nYSVR39rE/q64NiOWkGFc3WuMzowt+xPhWD+4BpRXmk49eH
         L4JA==
X-Forwarded-Encrypted: i=1; AHgh+RrsZJvSjIjVLWB2m2ra3Hh/IsZCOvcORuUIIC2zahBfl2l3GKkwb6wHdBuv5w2kclneczcrn3k=@vger.kernel.org
X-Gm-Message-State: AFuF++lQg2mzFWvO/PcCqmr5bHgcTA2//aTO+jfNCcy5fEEGQ9ajZOYq
	9/Nqyy6PNZiXBp5Nn7jXIPCAlF02liWkTlxfD5PugvECboaXlpVTQ/oG
X-Gm-Gg: AR+sD11P3rXSfRjQjCfhjF5xRcSCa+2A5Z6WD5867w/ISMWx5lz+ORPvbxxELQD6D2F
	ce7i/FxvcS7Y0p/yL+7TUexbj22I0rzx7kM1e3z42VidUJT4HmBJywA7bQ3pQNYfMyP0oqaHa1v
	bZGZPZOrhTfeuXL2bJMJsY3KcJELvad/VeQRkx7yj8v5Lf+cw7wJQHR7xdi5siF5GxOivNTr10E
	RKX4x86gi8xhvxjyJsEHeG0gRhu7oLLFXLd2CQGnhgu0qQy5wtIyyHeV2jhDNjwFwrAaiq9OT+X
	CDGcTAIIpZAO0C0d8pk5UkfJA/ArTPT0GEPIQbVKfEwU/j5pqHrZwrWA3DCV9eiQ9DCa3Sz+rxg
	tPYOTF5SDemjbWwqnJlPfWWjj6WVcDcVSf9+Q0GlnKk6mSVIcZ9vSYOw230ZF25EPX7JUeegcLY
	BfiWmEG1JCrV0Yc3ixHKISpy69LDYMk/wGt2BEBLjrtKMugP2TSuTzSHMzUFurRBeJUvfq12RVm
	GOlueZ2/f+zCbS1nb1qYGfHn0sQ5fcW
X-Received: by 2002:a17:90b:53c7:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-396464a15f2mr11505556a91.11.1787652919563;
        Tue, 25 Aug 2026 03:15:19 -0700 (PDT)
Received: from localhost ([2409:40c4:101c:e5a9:a28f:e499:1b07:43b3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d2d1esm36749172eec.17.2026.08.25.03.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:15:18 -0700 (PDT)
Date: Tue, 25 Aug 2026 15:45:15 +0530
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Mathieu Fluhr <mathieu.fluhr@gmail.com>, 
	Michal Pecio <michal.pecio@gmail.com>, Thorsten Leemhuis <regressions@leemhuis.info>, 
	Mathias Nyman <mathias.nyman@linux.intel.com>, linux-usb@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, Forest <forestix@gaga.casa>, 
	Slavik Dev <developer.slavik@gmail.com>
Subject: Re: [REGRESSION] 6.12.36+: usb: hub: post-resume delayed work
 triggers > uncorrected MCE / data fabric sync flood on Threadripper 7970X >
 (bisected to aec11e5f9c45)
Message-ID: <ao1qAlO8t9N3kfbZ@eggarch>
References: <CAPyJwA_D9qw0T72f8zwM1yKjP+To=maVANbcdsWM7yRmbBxYvw@mail.gmail.com>
 <CAPyJwA9R=p8_uxyYODb00g_nUq26SRsWHBGgAAJnR0YMTRRo4A@mail.gmail.com>
 <CAPyJwA9P48LDcOr7u_iT1WPFBCHxh9w6cxFvyi5GS3syM6crbQ@mail.gmail.com>
 <07435e6b-ee30-4c85-8c8b-0ce3a4ead1d9@leemhuis.info>
 <aosGtkE_diwVJJtB@eggarch>
 <20260823174059.46fec036.michal.pecio@gmail.com>
 <aoser8dLytrwqBC2@eggarch>
 <CAPyJwA8m_Xd2oyV1i9k+-6f7A-j0FiC97yXL=Ci8ZAErs5W4vA@mail.gmail.com>
 <226b2f34-fa25-4ca6-8afb-0b3dc942715c@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <226b2f34-fa25-4ca6-8afb-0b3dc942715c@amd.com>

On Mon, Aug 24, 2026 at 05:09:02PM -0500, Mario Limonciello wrote:
> The behavior that is described here sounds like a platform firmware bug to
> me.  Are you on the latest BIOS available from your OEM?
> 
> Can you please confirm:
> 
> 1. Your CPU model number/codename
> 2. Your OEM (from /sys/class/dmi/id)
> 3. OEM BIOS version (from /sys/class/dmi/id)
> 4. AGESA version (see commit bc91133e260c8113c1119073c03b93c12aa41738 if the
> OEM didn't tear it out.  Otherwise look in BIOS menus)?
Though the issue's only reproducible in kernels including commmit
8f5b7e2bec1c36, which their bisection showed too.

Could the trigger not be the 200ms SS hold?

Regards,
Lovekesh
