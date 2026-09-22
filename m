Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592D1383993
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 02:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790044710; cv=pass; b=YFql0KcJpY1eUAlyGOgABh9m8LHtof1fkD1eNtNt74Z0k2TcOynw9cMzeoaADnX6sAxk8cyGRkR9U9nZoCf3qLdbIA21Wndctr8ixdcARWMV+JqQAlR1kn5lNxqOZl9sOwHbZcrj5fIq1gp2ff0IKdmzN393HuOM0ciSbRcPTVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790044710; c=relaxed/simple;
	bh=WbSgfukLRhlbeKFLy822gliOp3+chBonUKVsDk9aHns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwCsT7RFGfJYmodgvTDaRFOeQZcgFAWk1Dul3VbF8lpXW0V9R37/Ac5RoULj64ZUK6dAmV3xN6RMdqHx6L00E6UBJlte5Npjy9mFVJBlFXxeOTMYxbg+qvrOTmwB2R0ZCGDG/trrVxgV7STu49jg4vtaqMv4kR5isyxVKEmHLtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q9Iiscu8; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9Iiscu8"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66fded6b087so3544692d50.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 19:38:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790044708; cv=none;
        d=google.com; s=arc-20260327;
        b=RIVnQWGvJ6B4kqFWaMahBr4DAQdUcfcwgZ3EdN2Y605uMZ/XjrvCLTbU4mfVrf+2r0
         dB2eYIlmgi1t7spHBLCa61yqcU30OIugJBX6FsjV3zd7cy/q8wo7r5KYFDfa4GgzS5QZ
         4PYB1uLinloNAFRnT41jMiIEw8IzMpmoX2XbORHpSR8gqxcLHUjihYNonRUZgRgOpT7S
         aGT5czBLl4zZGzqVo3c8x1plGVvjNo09SjVweCxkfUzzHF0GEI17MmP8htKWcmzuMTMF
         Vn+HJHAZ29EGTaNEKpG0mT2Bke9L50dify/ipp5o4fMUZZZj/hIXc6Kuwy1TUbBWqObG
         252Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=i+YOLUgl686GA9xLdxwBjrm4qOHndQYdgO5GBb0/IXw=;
        fh=B8lnrxOtIJBu0vAxo/mQ7gY7s1EBNvwRf5YMuZIDerI=;
        b=F/JwaMi0Fj+kj/HV1OnNChnEiPFFcwSs1XEwCLz/P6dgxi/RotLuEkemcXu/AIOFTG
         5/0c0iUWPz8dHO1Q7oJlJa7DXzZriSZhtN6aq+10dMMc8wnztw6m4FxF8yKb3CYISS03
         J11VwMPL+RidnINEG24GEQTrYdCltz0wjx61FAkSHoletS2tf4ZtjBAdww6dYPeQQohg
         4Pu5NMnVm5GVKvOlj+diB9D9yZRNnHUGJaLiQUQVK1Vkd0xO1IMlsIBWJtomleCMBSnt
         BtTj4i2EVR5TgqDOPaTPDvqG5c2l5UujIdCiE+sjjVX3pSGuYTCTeWZQoqk8xmfL0sOF
         nnSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790044708; x=1790649508; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i+YOLUgl686GA9xLdxwBjrm4qOHndQYdgO5GBb0/IXw=;
        b=q9Iiscu85T7PbDBOf3XfGOjjE2szbejlfeeomMtQaUoh2lIfTD3TVTUg1l1v+H6x0u
         2MeEF/D1hJRsIqmQXECa91jNsvywWHxrZAw6G7TJj9VqqDjtCjQdie9l934Ufg1Kaobz
         1o6pc/mZnFO0pQtmikPsOyYnbaZaIoZ5LbhFS+pJPxqq59339iMzgquyzFe0+X1S8Kwz
         rEhdGsf3r8RrcW1xgI4/YyHbG2HjOf8peeVIg4+0dBoFRnSPPZiWP2HrSSaldEeHxISa
         UUKtX5kW77tP49yXyYbeFgzLVlK1+KI8I3ddCD4k+i2OPkL41n9jouL9NtX6YvhR5U2Q
         oFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790044708; x=1790649508;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=i+YOLUgl686GA9xLdxwBjrm4qOHndQYdgO5GBb0/IXw=;
        b=o7bWfzQwXyBRRBG+4BcEsBCtmSsx1rm8/9sDlI8zYftLbAjqxUIv3UO8gT8r4Xz+uJ
         SvbR19no32ty5QEki9vlHscwwiKAxcGGfNKmEE931G++6HCWoutddO8Z1FOTU0kMVujn
         vVMlyGjDPfcRw9eH61GhzNluLBTzZehgSyzisSnvt+3DTwpo/n0ohTPXr/tCkTQgiOe3
         vw9u0MpbQnB9MuyPzCWOpCM7eMsoQ+U3ZC95cq0oxdszxXhoCfWPyTfFfLomtNd1VuG8
         UcHKJuD8rByWwZ2ccgEpAv6dnJjjUk5D4LejhT5I2jcZ2yM6SxMdTfmh3vRHfGIK3RhX
         hEKQ==
X-Gm-Message-State: AFuF++mnFWK7B+3mUddyFTDSgrDH+DKD4iRdf3XqIVotJvsHRNEToEVb
	YdfRbWaTX9Fp3p9Y9v6vNmc2K1dJwOQzllNjqpSHyfJpk3oQXUUbDusRylSd/0S8D8uFAdcMiVY
	0zJrt9R+jPVMAqZ6aOFSGqkvVE+Fy678=
X-Gm-Gg: AYBFou0KFlGQ3idgQAYxY4EFzU8eUgy91IjYpqrs9W6b7tfQwXIU0wtqCLvKhttZ9Lb
	Nwvc3cHHAxUKb3npZhmCG4yXb8hvEak2pVyxnRk+4f/qW0WmT6E51AMvb/e6lcTF0N5z1eMlWIj
	huYVA5HE14v1NVaa7eQrkPJhpEtdZBUHK4N2/C64aiQcVuJrdguXEERbR6GJDvjT8NC01VIhwum
	/1uPbQ24uk/sjl+PAJDoCL0s/NTwu8s9dzQ6y4sCAsDPqDNM+IQo1LCWhGtyInjVtC6fKPKaU/A
	avwY4nxpTSITmqW6TbspTqYgcIkZe82JB51BbsFuemau1JD9YfP7YOT5gg==
X-Received: by 2002:a05:690e:4548:20b0:670:fe0f:fe39 with SMTP id
 956f58d0204a3-6717fdfd203mr2973986d50.88.1790044708293; Mon, 21 Sep 2026
 19:38:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921075312.120983-1-lgs201920130244@gmail.com> <arFH0ridHWo3Z_w9@quoll>
In-Reply-To: <arFH0ridHWo3Z_w9@quoll>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 22 Sep 2026 10:38:15 +0800
X-Gm-Features: AcwNN1XWb8ExjcuFj63-aya245KYEcnQa1inFwfN-VmRqAKafLrlWEitnVlBJsg
Message-ID: <CANUHTR9tUL6Dif8MoJ92w0TQYx42zc6jksN8D5_0nHbRVE0aLg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: simatic-ipc: fix platform device leak on
 registration failure
To: krzk@kernel.org
Cc: stable@vger.kernel.org, 
	Benedikt Niedermayr <benedikt.niedermayr@siemens.com>, linux-kernel@vger.kernel.org, 
	Tobias Schaffner <tobias.schaffner@siemens.com>, platform-driver-x86@vger.kernel.org, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Hans de Goede <hansg@kernel.org>, Bao Cheng Su <baocheng.su@siemens.com>, 
	Henning Schild <henning.schild@siemens.com>
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thank you for your feedback.

On Mon, 21 Sept 2026 at 23:05, <krzk@kernel.org> wrote:
>
>
> On Mon, 21 Sep 2026 15:53:12 +0800, Guangshuo Li wrote:
> > register_platform_devices() creates multiple platform devices using
> > platform_device_register_data(), but returns directly when a later
> > platform device registration fails.
> >
> > If LED or watchdog platform device registration fails, previously
> > registered platform devices are left registered. Since module init
> > failure does not invoke the module exit cleanup path, these platform
> > devices remain allocated and their backing platform_object memory is
> > leaked.
> >
> > Unregister successfully created platform devices on registration failure
> > paths to restore the missing cleanup.
> >
> > The issue was identified by a static analysis tool I developed and
> > confirmed by manual review.
> >
> > Fixes: dd123e62bded ("platform/x86: simatic-ipc: add main driver for Siemens devices")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/platform/x86/siemens/simatic-ipc.c | 40 ++++++++++++++++++----
> >  1 file changed, 34 insertions(+), 6 deletions(-)
> >
>
>
> You sent multiple independent patches, to multiple independent
> subsystems. The amount of these patches clearly suggest this was
> AI generated and most likely not tested.
>
> More importantly, you sent all this work without properly organizing
> relevant patches into patchsets. This makes reviewing difficult
> and might cause multiple reviewers to address the same issue.
> Replying to the entire set is impossible and requires handling each
> patch independently, instead of applying or discarding the set.
> Maintainers also won't see the bigger picture of your work. Quite
> worrying.
>
> This is on the verge of hostile patch: bomb us with so many
> contributions, we won't be able to handle them in efficient manner,
> like responding ONCE to ask you to slow down.  Considering all this
> is untested and LLM generated, I have even more doubts whether this
> should be considered for review.
>
> Please read kernel documentation BEFORE posting more work. It will
> explain you how to identify subsystems, how to organize your work per
> subsystem, how to document usage of LLM and how what you should not
> do if this was posted in a good faith.
>
> Best regards,
> Krzysztof
>
>
>

I would like to clarify that these patches were manually reviewed and
audited by us; they were not simply generated and submitted by an LLM.
However, I understand why the recent submission pattern may have given
that impression. We sent too many patches in a short period of time,
and we also failed to respond to some discussions in a timely manner,
which made the situation look worse.

Many of the recent patches, especially the v2 revisions, are
corrections and improvements based on previous review feedback rather
than completely new untested changes. That said, we recognize that the
way we submitted them increased the burden on maintainers and
reviewers.

We apologize for the pressure this caused to the community. We will be
more careful about organizing patches by subsystem, preparing proper
patchsets, and following the kernel contribution guidelines before
sending future work.

Thank you again for pointing this out.

Best regards,
Guangshuo
