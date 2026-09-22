Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5929A377A88
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 02:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043084; cv=pass; b=YdZeLOXt4/p/5sxt/EUGTYXnDYTFBiJAWcgb/6jV6t8R/QsywE9aNvuBXTEf5CiBMofJ6ObI9wmvxwfTs8p6K002z5zPQW2yn4GkMzBXMASCExLE8d+CD+K300S0Jy9wcMD/qdF6dl6gHWyXRUNr6toztzu7VzZVHQsPsGywCkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043084; c=relaxed/simple;
	bh=bmBqFjZ2YsW3nVDkxnU7i6zxE3xTdElcLDPHvj/yg7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1ObOQRS3AnS61fZ7iClbdf+WnmviiCa/mY8fOJ2/gBd/Z6bCIxQj0CkVdkYrMMUR9HM1LBz3+BzZIQkdYxG9W9tVny8003ycW0jVNpXr4HCMNEGqJLEw4pjBX982f6x1VBcBPzNkANQrDDix+ftzJB5UlwEifDyc1uPxM2dueo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1ax1/fZ; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1ax1/fZ"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d43ac608dso30644297b3.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 19:11:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790043078; cv=none;
        d=google.com; s=arc-20260327;
        b=KPsSI8/V5LX7BpxVrTU25YkJik32365xTSdPd0afqz+QxJrbwyHN3EpjZgIrrJA+Rn
         k3MZNrEcPcvmA1uh+i7BEwAcGzxjiUr0zhdrUzs3bN0MevlDQ5gjbZkvJNFSJYrFXdYs
         USAzzhaFSz0LKejbt7QqV1bbg/IRCFdZi4G08wCu1brBTGcWgAuSpHgVqq8EJ1tM6bqo
         ys8OcymVW76e/KjzRyQNXkho5yXWBwV76PLpMa46Y2zU6DgRl2UdX0Tas2AZ2AWG9R41
         ILELe+G5O4TaEI2JBsrwqtvINp95O9BxjvCEKYAv6kXgolAX9GigdytTlPD3Ra+z2ua1
         EExw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bmBqFjZ2YsW3nVDkxnU7i6zxE3xTdElcLDPHvj/yg7Y=;
        fh=GeSjdmwC5hKlcchVthu+/Jdb/MufB3N+6Yun/xJ4rjk=;
        b=FE84HXTnb9SywDEwbcTlx8m2Gz+eqoACuDli+KcRH7JKQ5CmgHlXbDloOnu6XYQLdU
         ZwMqvYnhx2nmxq9+3LO38KgY0EduF2JddzTAVNul34XkZ0KRQ+7UI3RIY51up7FK9CSe
         JACn3HMl9ZiT5XBW8UuuUTN3ZpON/iZTY6tOt06WfCGSyZrFg/M6OWjpUOb+upUCxH+f
         JtirC5IZRxUR+IDsS4Qr42GmQELtDihhRZWARRdNtHADoUcx/oiDnbBQ2I2LHgLkqpXB
         cc7tTDqBg5SLkuIn0fMX+lI+FLlYjN2PWd9GeAitbCJZDzkLMm9q6cLHjsRIywwXL8fr
         q1Ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790043078; x=1790647878; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bmBqFjZ2YsW3nVDkxnU7i6zxE3xTdElcLDPHvj/yg7Y=;
        b=K1ax1/fZfV4OCyTMNvapxjujxSPw3taesQiHN8AUN+uXGqVvgad5cE0YT90zurhLvz
         dscDXMahuE+7zmFV2clfyXiBPph29vPFfxu3mGAZ3jXP7ci1j93xoaALpcNnMDSFwM3p
         Juhua/Y17EXi1M6fwfiP0jMlcW26C6afHhd79LE9s65mAQKeaetnOljHIYeeiWlKZpVn
         GeLone6CC88kfDC3hSyzyXnPCzLfdniXDjOhb5id3lGxiDR2N8YD7pCn9x8yiBQOo9nz
         BpLEesjopKqSEQ8nOwuqBaObj1UwcDwqiEP9DKScrSzHnh8kgKj07q630Il53vcW22Cx
         HATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790043078; x=1790647878;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bmBqFjZ2YsW3nVDkxnU7i6zxE3xTdElcLDPHvj/yg7Y=;
        b=yguobfCYrVfkLJxd/HTWnL16PfwkE0Ylt+rvNzO2Ifi1FSDsErW3wyQhifjgaEQ69e
         jvnofTSM2u4+sBWiBdu29H3ZwWwKk6N34mIHH5G9WK4W16pBfvfq6efzT2GMPp8xXLFt
         sRdWX55RRmfrjWkgpfkIhVPh/e/3XzUqQpIjySLBpzZ52XBfiZHrW3rB8pL+X285viSu
         vf/rChh/mzae6KO3WX4Lv++gLLztaktMHqxevRobfGZNB0UZnfB7f0k2wu67qsGbdutk
         F0SDHltUn00G31pvafnMCH7O4XUKzvU5L4aQFj2M9/RkvA8Tv0PK+/zwbHmke0Z0B6zv
         gOpg==
X-Forwarded-Encrypted: i=1; AKwUvBy0hoEahtgTx/zRuUrzTaITdzeiXH7cuREmWqMc5X/sFyJOcniW+NLPGlgRnSGQEMW+xm5O2gs=@vger.kernel.org
X-Gm-Message-State: AFuF++l8zb5a2Zkf5uy1+CAT0xpX3PTXzREbrQjZQyF6KzusjL2KMLOv
	6Rb2n1mmFtdWQ8zR2n3av/nJ1x+sGfY4m92PGPSGnPl7Jm8ojAZ3WFuu39fYl9P6ZO4uqsEFT0o
	A8DROZW+hXaxRfbMSzAGmml4XIPeOA2A=
X-Gm-Gg: AYBFou0QEwKzN47M8WsQOfNRiCTCKgYXDWdzAyS8iEtberjaNOFhlk+jJjeRg/0gv6X
	w6Z09gC3RK0siiwb+itQMPK57B8b73R1dP3lh1ehHniGIfbRSgTEuzD1rn10NOic5Do6iJ0rHC1
	2sf4hXjj1ElX6NTCumA3tbmNs6XF82VNbkp/bGzV/bqb8Hebz61QlnzrdipHwFJYYbxWB9z92aq
	+Q9xfATvUF1etpfEZgXG6OdduVZOvm4aO+WydETzXBXZ7vPJvu4DfKf+VdctaVKKtHmA8TSFa+p
	25CSq7ZXJxfMik01UGBPZ1Go4CNuYGM9L9aPoJrCuMU2Vs1+RTDXJKsIdw==
X-Received: by 2002:a05:690e:d44:b0:66e:45d0:4140 with SMTP id
 956f58d0204a3-6717fcaa9e8mr4072276d50.26.1790043078247; Mon, 21 Sep 2026
 19:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921111424.378477-1-lgs201920130244@gmail.com> <57b3420f-da3c-4b75-8835-7a541d29191a@kernel.org>
In-Reply-To: <57b3420f-da3c-4b75-8835-7a541d29191a@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 22 Sep 2026 10:11:05 +0800
X-Gm-Features: AcwNN1UrKAXOC-3PnGzPBk35Upntm96U1CzspV8YHHZ-BQx5ZIFNE0thHryYQb4
Message-ID: <CANUHTR-JpoYtYJ8QEEN0rGQ5Bib17NH=BmK8AeYbzYAhLH+hgA@mail.gmail.com>
Subject: Re: [PATCH v2] dmaengine: fsl-dpaa2-qdma: fix ppriv memory leaks
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Kees Cook <kees@kernel.org>, 
	Peng Ma <peng.ma@nxp.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thank you for your feedback.

On Tue, 22 Sept 2026 at 06:05, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 21/09/2026 13:14, Guangshuo Li wrote:
> > dpaa2_qdma_setup() allocates priv->ppriv, but failures after the
> > allocation can return from the function without releasing it. The
> > existing probe cleanup for priv->ppriv is only reached when a later
> > initialization step fails.
> >
> > The normal remove path does not release priv->ppriv either, causing the
> > allocation to be leaked when the driver is unbound.
> >
> > Since dpaa2_qdma_setup() is only called from probe, allocate priv->ppriv
> > with devm_kcalloc(). This automatically releases the memory on probe
> > failure and driver removal. Remove the now redundant manual cleanup from
> > the probe error path.
> >
>
> AI slop for OpenClaw agent ignoring previous comments. Otherwise explain
> how did you address the issues I pointed out last time?
>
> Best regards,
> Krzysztof

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
