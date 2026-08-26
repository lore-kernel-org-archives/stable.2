Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DD23932E6
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787732109; cv=pass; b=N72UuNw+WPkzD5l6zePI6l7LuP77hg06vtq/12tUIysUW2j37vE+8xbnE98ERGoxKjsdA+B4lD8ZCVln+TU9jybQNxSPvHFZSsaJaUZFttBusjoLr3agLNMCQAtyTgsDys7YrPt1zVm2CdEKklkhTOc0l+AV2AKzORmEIUhd+bM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787732109; c=relaxed/simple;
	bh=J+6xXHiRfdSp6lX3gT2enC0bPRKFuLA/vpd3A/BvOkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwRO/MMnCV0xBGO/dapsvDHkJhFd3duaG/jlkWEaAeZyBWknhEwZcdrxf8Xp41uDjoFuH4PMRD5xrueYYFE2zT8b02uIsIn3/Xj8gJOjJr5pVKtLrwt98fc/6dcmKbT8wnLRjtN1nDflNqbz6uaOyQ8/vTTeZUpA0Ep0zubMzkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l37JN7HK; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l37JN7HK"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-81f64e8dfbcso9667257b3.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:15:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787732107; cv=none;
        d=google.com; s=arc-20260327;
        b=gsxidzliVjreMn8kaE0kROStgS7eJeaYgtcA0vA/nlVSbkCs5m+esuGkHLMlN3ifzr
         EubcbjGqJqdDaKRmJiT2hwWAgS69tKC9rFiOMQR+hL1hn/LRa5FbZa4Z5PwmabkPd90e
         0/I8oXB6Xb4H6F32WUobtv2sp0HTaKNs7sgFO6vrBddjS1AVS91SMh2J59BaxRA7rVy/
         a4TyON3Fkf3d6vrVAU1jS94DLsOECQ7FGRvkGuMb4LwKSbCjL3RayqJ9d6JKuplbxxaD
         VekzFsNxSqWdy/l0UI9W1TtmTKK4As4TuOJTu0NFqfoMtIu9HlC3iKfn4UKkwMOvut1k
         8XEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=J+6xXHiRfdSp6lX3gT2enC0bPRKFuLA/vpd3A/BvOkk=;
        fh=YtbRMiDWECcJNiqd5qOcxRH2v1O5X6EiB99yWL9LA58=;
        b=OXDxnzws8DMzt1ugFxsfcgCg84EKCyPdJONn81f/jPAj0lV614y7AL1nONHKdzbq/4
         TP6gjbYY6RzZiOsNK1zVXrmE/BsylEmILCJGnwspcRaZk5CYZ4lZ+HbNojZlfCDnm3f6
         QpUeg2x1yfY3ogzZ3Gx/ZqYNznFf6mLqy1jv8Er0DLsToOcPbs1qPTXir40YWi1yVtmy
         /zcXyy6eyZZK/TCQyZoBZSnyum4tGOjotv1ShI5v6K2fGCRbbJh/qHjLTxRUtFTdivac
         OTjJZF6C6Ar4r/er7JEPFUhf9csCqvslRKMIX3ylakjOmAJuVoAzEe7PkTkt+M/Bva9u
         JJrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787732107; x=1788336907; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J+6xXHiRfdSp6lX3gT2enC0bPRKFuLA/vpd3A/BvOkk=;
        b=l37JN7HKqsL0jz5C62YuWOoBr1w7teWTsW2D3/Y3Rroxp7CFI3w0udcv1OgM4pmrpp
         P7oMQz61l5BcUVxBytHBNbhrnq+ea/n65Y01LzQqjy9GiiPIY5eVbQs1y5p5TtyZ6xgm
         dk0UOstpumGechd0+VdjyxCxGOF4SuQFR3W7vR78lM05cS+gPY0+PF0F7cP1dMBMMImw
         dEC/9hgBfEGk5lVNSKjepFRjV1EXxTrULS13ekkD8y2rUDjz9CJvwJqNsHTQqE4/xVT3
         cj/+qm1lG/1SNnrp3f1S0UXnp0v9yws9dK5vuMHL/bzR+oAx7CKU5f3KBIAE0zEc0pLf
         bzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787732107; x=1788336907;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J+6xXHiRfdSp6lX3gT2enC0bPRKFuLA/vpd3A/BvOkk=;
        b=fhtr+8lXlL4zV9ArBhdDmgfIhUKRmZeY2oegCVWEZB+7BuhSRcYloRCrkpJiqV2pDG
         x0M9x8YCFCdWJ73oEoiFFNi+7lGOYzK0Dz3EBN16+ptWZ6Ii/VHiUsFPMqPrL8v8L4jy
         u8wuH8nVTNLxChhafS9mIhEZlS0JnU/rz4ll0La0suzozAvczDj0ZSvoylNrEYY3cqCu
         TcDJO2EtLMmsCnNk865SSuYPNStFTm+3S9njCRHU38+G6w/nMGRtEj4avs8eaz4/yK4p
         QLtACi2Tx+xvNbf5XwOePh2MDeKsjVDD4JM1xf7Wo/Ib1+QNTR76oYl4g6yoEsbNjeNe
         PXaA==
X-Forwarded-Encrypted: i=1; AHgh+Rry3coy0OKve7uQNyjQMM4Y4cudIqyHMC33wi4Y7BA+dd4gpqMhrCAa121De8L7F3+eK2xyPgs=@vger.kernel.org
X-Gm-Message-State: AFuF++nA8R46uoT6czmrK9Di5nby2kVvPlsRIKmp/+qQ1LU47XapcFz5
	JQ6AWGLgI3l1ATRjrj1csKOKTsTD6JkedwZJVdpRQ6zu9kiiDxpYj0Mm9PAoFoixBcnt4EfUFXb
	anflKCLbXdKkqVf2yJeb0v/oI4EHU+Jg=
X-Gm-Gg: AR+sD11YAP4odH5tY69pjUWv5CO9xasWTs3cqgFzCmdLuSIYI+3aEoJu6PB/RgE9aOk
	rrCO/uib96ol9GCMrTJtTeDpTURD/Hsd5UMdWf1noUHrjTP+vGr633E0ZKRO8Umm9GHBAsWd1o3
	4ZYOkjs1jEGffMJ+nAeVH5Dd6t5pVTAKTV/yJ0j9KLYFeDzBaYmulTex3Sj6v+3prjbUnFJGuaE
	ftHlYG691WK2oFtb1DEYZ+6srTAKjIWSvkjg3gp6KJm4b4ghIle1qQSxz8OI3pIhqQ2Ky5xn/a0
	fLb350F/InSprGj8PTyrDc/pR6gVE785+NS7QhufwDxSz6vV2nggZyNlEg==
X-Received: by 2002:a05:690e:454b:10b0:66d:273e:117a with SMTP id
 956f58d0204a3-66d273e1bf5mr798137d50.39.1787732106713; Wed, 26 Aug 2026
 01:15:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808115228.2798481-1-lgs201920130244@gmail.com> <e0a9f6dd-f32d-4ca9-b907-51d8893ecbe9@kernel.org>
In-Reply-To: <e0a9f6dd-f32d-4ca9-b907-51d8893ecbe9@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:14:54 +0800
X-Gm-Features: AcwNN1XvjLCGn-p4IXW7KpCPSyocF03h16h7C3wgzdyHtcsVEfehoAO06tMV-5o
Message-ID: <CANUHTR88n4vtE1_nvaAf2Fpp9u8szu72o+z3O4hefP0C5LySCg@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: xilinx: zynqmp_dma: fix autosuspend cleanup
 during teardown
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, Abin Joseph <abin.joseph@amd.com>, 
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Kees Cook <kees@kernel.org>, Kedareswara rao Appana <appana.durga.rao@xilinx.com>, dmaengine@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, 20 Aug 2026 at 22:03, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 08/08/2026 13:52, Guangshuo Li wrote:
> > zynqmp_dma_probe() calls pm_runtime_use_autosuspend(), but its failure
> > paths and zynqmp_dma_remove() do not call the matching
> > pm_runtime_dont_use_autosuspend().
> >
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > during teardown, this reference is not dropped and usage_count remains
> > unbalanced.
> >
> > The documentation for pm_runtime_use_autosuspend() also notes that it
> > is important to undo it with pm_runtime_dont_use_autosuspend() at
> > driver exit time, unless runtime PM was initially enabled with
> > devm_pm_runtime_enable().
> >
> > Add the missing pm_runtime_dont_use_autosuspend() calls to the probe
> > failure and remove paths.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: 64c6f7da8c2c ("dmaengine: zynqmp_dma: Add runtime pm support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>
> You sent vast amount of patches, all separate, making it very difficult
> to track and respond in efficient way. Do not do that.
>
> Group your work per subsystem.
>
> You were asked to clarify and respond to incorrect fixes statement. I do
> not see how you clarified and responded at all.
>
> Best regards,
> Krzysztof

Sorry about that. I should have replied to the earlier review comments
explicitly, and I also should not have sent so many separate patches.

I will group future patches by subsystem and make sure to respond
clearly to review feedback before resending.

Thanks for pointing this out.

Best regards,
Guangshuo
