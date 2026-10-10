Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49111D7E5C
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 23:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791675144; cv=pass; b=PXIlgVwxk9yr6nGPZW3GVEre9AtpWzlZ7pP809wVfO67P4abNGmPqHgHLDylo59eJqxHZBqVQi4bkBP/lqpTGt6JbJQ6rS11BJRpklIYbsR6qFnYCIrvh1smVhSclawYyybu+HAp97LTHf/U3IPxrWNVhG7cVxiIqwnWaW3N19A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791675144; c=relaxed/simple;
	bh=qflQkqQeHmD36iK16xGfjqsB6XTM4Xa1UP5Z+sLs1ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMXahuPAwJZNJbF2RU1X1q6ovz5AxGBGEembFI0CzCAFUo3z/uHovDvBGd3XBpOXUNTOTBNwFSWgJSBRP8ZTonEaCIe9N4V2RG/ZUsXwOLwnpmGtA55knzrTwh1JCYW2g0VS0407wkx2xrlsFThW5sRl1hucE0xk35/t7Bs2mwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVgMzDrp; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVgMzDrp"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3a9787a14ecso6379351fa.2
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 16:32:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791675142; cv=none;
        d=google.com; s=arc-20260327;
        b=rYAwnEGRUwVub5Nc7tdl3ubxSLO38eAgZSMaHObA1mHPeUun36eDElQ0+luxyn/Yp7
         npJkx15uhC5eFJi7ZgTVbvXCZfHm61laU8CrXM+sxaqIlYktX3bI3ELTVJg9dkMc7DY8
         de6UXSgJiQvyEtw8JcSD7Cqvd7N3KHOJ5kKBKB8zTuO75rm9UpLoePEZg5OTqD2Spdyi
         kzMwBrf+gsUsUoJ3l6Za/26JBdvsaaRgzWvCFUHqNxw9klHyqvEyjJHEb55mQFJaD3B7
         OupPjOODAMvva9MJlwOqzQ0Oz1zIFMQSqnYo9eQYGxoWOMBGVaJQ/gyUZYy27hkbEFI3
         Q8Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qflQkqQeHmD36iK16xGfjqsB6XTM4Xa1UP5Z+sLs1ts=;
        fh=4UR88XSp8bjzZGNHLlTJmHHorQJdBCydJKah+6wBDWM=;
        b=FjF3zCgElmNg9f6s1cILcE2311IQIFbmtV+95LkQAd3CC1WWXQVGzX9PUimkCL8KWZ
         T4lnjE6fkVrGioebUzNXfUPIRs16QQG6a6gHEl6yPPELGyzM5FCONtdFIlbfVbw2bETj
         3vmJrFAthPygwkXhikhDNVpXcwit7nUJu8VSILp3BDyLzPyk6vLOrCqYgbvZfS7YnGtE
         xmwWr3sTRR4vSBKZ4FDwzUb+u5ruqWGxIQ0y3iDkgKwf2SKtwIjKj8w5jtEf/T8wmOhe
         BLscBWJVBscexxEUtM6E8FxDrIwe5mnytTfC8E9AOM+BL4XoK8X+zjsY2hQUEgHEwZR8
         iUBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791675142; x=1792279942; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qflQkqQeHmD36iK16xGfjqsB6XTM4Xa1UP5Z+sLs1ts=;
        b=FVgMzDrpb/7b8OlWamopi1tfTxES9h3p6GIL81i3K8DEJOc99rMtRP/LO0d6gXigN0
         VE6Pw2m31J/VhNRNxvAsGqYQU84K1VO+UV1F2lQb1J+VCDMTvgva+ZA0Xl5wN3nxkySg
         AZmw7kFvwTqMuC3X2y+eow2fIs51MG/rLRJnlG4uCEZ/rFVgSdt7hP2U0Mhj0OA75anj
         uGN1u5TEgIanXfIY/ahZl0K7+AnpcMjl58fRWU1rkdGmHqRYAxa3Zve1mJU3APOYf3ix
         E2dCxZ40l/v+cZ9mcEA8jV9PT0W6oibwLWOeGIrC5ZLjA3cWjQCh/6YYdWNLCRZ+SQJb
         wASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791675142; x=1792279942;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qflQkqQeHmD36iK16xGfjqsB6XTM4Xa1UP5Z+sLs1ts=;
        b=P9jbK5ZXljR0Hg8ud38d1ugy0q1cQXyOD/J335z7/PUrMLA73eqwlJCHPVHtFVrxTh
         jXBWxduVriZGh8LZFr5AccHIVThNgZKa/sd+OfE4e24Grq8ZrgG9nHmh/GWiBUJRzgex
         cDpYuo+MnDq82uU2MtnZkNeFyexDIus/TmTmoGBZP0VCLi71d4dmWRPgCBOfJchuOdSD
         CxbgCA3Sk+P4r4rk5s66Y6rhOAEZG1AHicvZh0y3zA9bVK2sXt2WC8KL6ni1uuKYSOsk
         Ny84+ZtHT5oAeLqS29wfTTu/PqTSMv+feP7XrBGqTmLJ8etlSZ2XXK3NxYEl0+U3yc5n
         S9jw==
X-Forwarded-Encrypted: i=1; AKwUvBxDC59qFxQPzvN+iGw/cjpTa493OQ6pXRAw/ZTdb2XfW1Id4xf66HeCiC/rTeGOaF31fxMs45A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPVAt2uTrjhhG1UXT3WSeaoKzTBI63PAzTxcV0p6rHLFIlhK3i
	t10wUL3B58GUmi0E/ao+T9EqHQDgsh8I/6V9l1UKpq+gQpDI+vjKbFlbdMV35TDSIn4kuxgkNI0
	jMFXUXV7/0t3imsZqmPFjtH6e/jza/Ps=
X-Gm-Gg: AYBFou3oecC/Nv7FO0t3YDxhJgFpNTBKOf9gOsa7aiQgYgbcy2ubDi6g9ewnUj1R32g
	iO7o8V5+gjn8Dlab2kDfEUBBtRqxEYfRqy9Bsd3DN0dRSDbvkl2Z+CzMG8Pije5Y50cshtbwUyA
	fy5amtvBoU93aga7wi67Kve7Gp2YHLXGE7Ty735/yPeNuAFRH5BJxr+j8XPMGkKS+oNUqcFh5aI
	JbM6R1kOmUf/9REKsex6pH2vH1GyhfpnlZ1mJKyBU9TI0tlsWz2r/aW4D67ZdCiWIGnMyPO6lKM
	+xWRvzdgRsZdQpCKJURVFLvyaqGS9mYH0de/yQ5vH1ppT/YNIM5dkOX0UA1Ce3Z6wu+/C4r2ZXS
	MPJyr+Oh+uWjhimztf9WmlGut04f77B4s9IB34I8/d/LhFxgqKlJlpwJSKw+gZZ8XmfVp0qQJXh
	ZbiWoAUg==
X-Received: by 2002:a2e:b8cb:0:b0:3a9:c04d:40c3 with SMTP id
 38308e7fff4ca-3a9c4ebaa9amr12809291fa.1.1791675141422; Sat, 10 Oct 2026
 16:32:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010142533.974797-1-linmag7@gmail.com> <20261010142533.974797-2-linmag7@gmail.com>
In-Reply-To: <20261010142533.974797-2-linmag7@gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 10 Oct 2026 19:32:09 -0400
X-Gm-Features: AclHuK-Ff4Cr98p_CB6t_k-bkb71SKuGnXuo7evvdddqXdUWufYMH0X2srMk7xI
Message-ID: <CAEdQ38GtjhbEipnuTbo1EmzNNAE9=6p3T6MfTnMq-6okmE9-tQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] alpha: load the MMU context when switch_mm()
 switches the current task
To: Magnus Lindholm <linmag7@gmail.com>
Cc: richard.henderson@linaro.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, Oct 10, 2026 at 04:24:27PM +0200, Magnus Lindholm wrote:
> do_shoot_lazy_tlb(), which switches to init_mm from an IPI. None explicitly
> loads the context, so the task can carry on running
> under whatever was loaded before while current->mm says otherwise.

Two small things if you touch this changelog again when applying,
neither worth a v6.

The second line above is short.

"while current->mm says otherwise" only describes kthread_use_mm(). The
other two callers change active_mm and leave current->mm NULL.

> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
> Tested-by: Matt Turner <mattst88@gmail.com>
> Reviewed-by: Matt Turner <mattst88@gmail.com>

Your Signed-off-by is last on patches 2-8 and first here.
