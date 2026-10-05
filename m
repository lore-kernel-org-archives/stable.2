Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393F7363C50
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 06:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182351; cv=pass; b=U09nE5VJ+36ahvB964O7B6XLEYozc52ksG63go7caWKVTZ5C/E4uFiQXcW+udP10ITqzTbYxxURPxAUUeZYj3LCoND8lanbyrVRMume/mJJ1T0dBAaNMj0gJJgpMGnBv1as6krhpeXycOJ/05FII/H3MyC8BjDthf6g3AIzuJd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182351; c=relaxed/simple;
	bh=c6c/s/pctr4hlsIP37l3x3OtmGRnTk6yxQpJpwTRc38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7eYDOiQgOhkrM0q6xOqUCqK3Ua91WHrHFxnKM0HsMjHUAPbJlEVapVICdyA9NGvPSgnlQaRT25YCgzkOKzenDOQhMRk6/38sZYdipIKgS8InLBJGZ/D+IzZ/TjLJesb2zfQCAseyz9VF56fDX0H7M+lHi+RTMvhDT6Wu6Pcw00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XN2kghPU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iPQGk78h; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XN2kghPU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPQGk78h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791182348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=taemSpvQjcZer5/jR7Uz6W6jqE478Le4hwIyaN3A7qY=;
	b=XN2kghPUL+vHvxDCvAY+/DWTfbBoAHuW8hsTTAfqHUJopBeERw5oZUD74oS0/To6UXWeMK
	2GDaJ+WAYZCPHsWgS7sXDD8dU1/BlC2Xgz30jEMrNtMt3Xb5q8RyD0NVArEI0mr7ClBOV/
	AuJs/Uk74OpZsKpiYH9FHWOtgX/P2dc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-o0TRvymOOm-x-jqYWl9a2A-1; Mon, 05 Oct 2026 02:39:06 -0400
X-MC-Unique: o0TRvymOOm-x-jqYWl9a2A-1
X-Mimecast-MFC-AGG-ID: o0TRvymOOm-x-jqYWl9a2A_1791182346
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-53513d2a70eso30363661cf.3
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 23:39:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791182346; cv=none;
        d=google.com; s=arc-20260327;
        b=W/xJvv/XmwPQxO5/E7jiKusM+vKhp2eeJHc8qkYuiIeLuPKrWUSW59ZB/W+4akJUFs
         SVI0PFKY3TaIftjqmscAk2wS1Jfe44T7j1hBK4WOFNgv/VhbumRJNgTOxV2rlcSaCX3D
         wnrK2rMdgIV5SqO8nq2LmRKl4pguSKYXQZhLumaPiWNFmH/uR2/wPwLXuFC6aTe8Hu0/
         DA6FJM0TCld3gvTuTCgSkJPEzAOmmC0ycNi4/z2XrT/8z7E+Ps3YWnY0B+Jkv1g2WUsD
         0WlqJZh/rgxHT85R1ILXxzHakQPDRwRMo7rs069zFWsAzv12NvFWc13ek/yCbN62lUb+
         hjug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=taemSpvQjcZer5/jR7Uz6W6jqE478Le4hwIyaN3A7qY=;
        fh=jo5FON/9r2ZC3iqABZhhFt+NXCf1IJDKBB8KhfZxieA=;
        b=jpRTnzQgQuMSYsjkmSEgk6LgFrdLUARSKlOww52FjUQJJYZroSWpqJN2yqEXtRO/pN
         BSRMsLVY0QUmz414z7yJEkSWcqiqLvGGDoeXWaeg4w9hYD2TgVh6WvchC6DU7JWaUHIX
         paF0Yg2vKC0YPYIw9awz58WEhirPtv0RpMtPr1pbx2r2lVXxO59IWijPdWw1fOAjORbn
         OkeDGpr38qO9i7IQhH2rkbQkzYgHI8CUZa65ASRpMdrivyvx+jICobgPgBcf2I4+gto4
         dHGOePRs5hnKOinGNo9Xzglz6uf0oMKqptfWcqSJ+PwSH5jB7AIEW3VcMKudjq4PE1M0
         4tAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791182346; x=1791787146; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=taemSpvQjcZer5/jR7Uz6W6jqE478Le4hwIyaN3A7qY=;
        b=iPQGk78hbfWP7Xklv1e/0D3wD3cJa9gI89czUs+o4AJzNzM8TNGnhMx+ozyIEGdE/j
         5p5LbWKcuKJlO/zokkfe0NOjwARk4WtrULKp1qsPeYkXkmFs4hLBrnj8dbDltb0r2OY9
         jf10+qgnCFafOqZzEx8Hfe52DCjoBwb65TfxnbbIwb4sSelkW8YAQ5wyMoZ8RpMxOuhu
         eyyZFJhio5XVKyr+birw7JGZwdENq6DZbFJi5SPcfNs31wuH0sV6/IAfNTEOxPpP7pA2
         0G23U5FRZ2vsz53WGZ8CTdcUP2PhvXditb9TZo9durGJWztYq0NUPHi9GlIPLpOYSn5i
         haxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791182346; x=1791787146;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=taemSpvQjcZer5/jR7Uz6W6jqE478Le4hwIyaN3A7qY=;
        b=gkj+IQLENGCcXUwHV/0JzXwvXyicNjYKsTVlQU+6xvVtpZB2kR3QbJfJywI+qA1PQZ
         fFbwj35puohgnpAAygWCBWPlkchiCTyH3FCaFAMOaWXF1agoVe+LOKbfR/TzBDcU7+RA
         hHE9UMHXFhWCJ7r9+TokZkRgv3dgiOLkVYlLMMAsFn1lEBrgYY65ojfL51iu20h3pr+Q
         QOUUP/URqmTBEC6Vmv1Xb/Imqgjc/mcAgc0W5RrVDfn32lQOEzwVTMsEZ/e8oZ32x/s9
         HWUwvCJpZl8gY3xCT33mQq624/lWl/Req+KoswXEtDWipNLZsluLW55O/SzQHpR0Mt+v
         dS4w==
X-Gm-Message-State: AFuF++llnvsS4IpvBEq4ktg49WJVu3r6QNkPYs9HCvKvX5InKrWDZGIG
	nJZWR08P7Ea5jmARh/djT2D/q9iESctRjwm2bxAOujbq+aSq93HfG9zE23Mhh9NOBGDw/AjSq+G
	QZ2mVCUngObKV3IirQO6qLMxiLe82Pl8VJX1QWPZS46etsR3uvjb/WJNBF1sMPWOIQXPbZnPE+X
	TtFmtnOuYYPgH5ESbuP/Rt/2igzqpLnhUwhqLiiULma2k=
X-Gm-Gg: AYBFou2bmnxQT3HGP7SL0m535kZc7JMl/p3tw2PKpPbFLTQGgYeBTExcN0hi62cjEE/
	i2565KRk9XAXgm0wQf8IBNoqwJbAYO0q2c1NfmZDTs8IbH7Mfixy/RoNarHQamQU8pnwo4BUCgb
	47EgIv1Cd+259ka4dS5GLLf6iurUgQX+4lui3akjb7xQGpSmXPTONJxgevL50=
X-Received: by 2002:ac8:7fcc:0:b0:533:3f82:3b80 with SMTP id d75a77b69052e-53511e92086mr105892021cf.39.1791182346036;
        Sun, 04 Oct 2026 23:39:06 -0700 (PDT)
X-Received: by 2002:ac8:7fcc:0:b0:533:3f82:3b80 with SMTP id
 d75a77b69052e-53511e92086mr105891801cf.39.1791182345584; Sun, 04 Oct 2026
 23:39:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005063703.1404522-1-sashal@kernel.org>
In-Reply-To: <20261005063703.1404522-1-sashal@kernel.org>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Mon, 5 Oct 2026 08:38:53 +0200
X-Gm-Features: AclHuK9cGMdynwC9MoDwAesimcriDes-TkyQ4HDJzEm_NlMqwDICmIK00881roc
Message-ID: <CAFL455mC4cyq1TZsB9PXCZQQCWRjxcDTZvFKdoARCMU1e-+UrQ@mail.gmail.com>
Subject: Re: Patch "nvme: do not reset controllers in NVME_CTRL_NEW state" has
 been added to the 6.6-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sasha,

Please remove this patch from the stable trees.

A regression has been reported and this patch must be reverted.
https://lore.kernel.org/linux-nvme/a8975c9a-b0c8-41cf-90e4-a770666e975a@cyb=
erchaos.dev/T/#mff8a81bd072a044c77e85070e754532d969155b2

Thanks.

po 5. 10. 2026 v 8:37 odes=C3=ADlatel Sasha Levin <sashal@kernel.org> napsa=
l:
>
> This is a note to let you know that I've just added the patch titled
>
>     nvme: do not reset controllers in NVME_CTRL_NEW state
>
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      nvme-do-not-reset-controllers-in-nvme_ctrl_new-state.patch
> and it can be found in the queue-6.6 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>
>
> commit 03198f12b3bd565406a3549fe54e2eac163ff506
> Author: Maurizio Lombardi <mlombard@redhat.com>
> Date:   Tue Sep 15 11:58:27 2026 +0200
>
>     nvme: do not reset controllers in NVME_CTRL_NEW state
>
>     [ Upstream commit c20bba234f3e1dcd81f7a2ec21ea7bf01a4cf35f ]
>
>     During NVMe controller creation, the controller is exposed to sysfs v=
ia
>     nvme_add_ctrl() while it is still in the NVME_CTRL_NEW state.
>     This creates a narrow race window where a userspace process can write=
 to
>     the reset_controller sysfs node before the initialization thread
>     transitions the state to NVME_CTRL_CONNECTING.
>
>     If a reset is triggered during this window, the state machine allows =
the
>     transition from NVME_CTRL_NEW to NVME_CTRL_RESETTING, and the reset w=
ork
>     is queued. However, the original creation thread continues its execut=
ion,
>     subsequently moving the state to NVME_CTRL_CONNECTING and finally to
>     NVME_CTRL_LIVE.
>
>     When the delayed reset work finally executes, it attempts to tear dow=
n
>     the controller and transition the state to NVME_CTRL_CONNECTING. Beca=
use
>     the state is now NVME_CTRL_LIVE, this transition fails, triggering a
>     WARN_ON in the reset work.
>
>     Fix this by removing NVME_CTRL_NEW from the allowed prior states for
>     the NVME_CTRL_RESETTING transition.
>
>     Fixes: 8bfc3b4c6f9d ("nvmet: switch loopback target state to connecti=
ng when resetting")
>     Reported-by: syzbot+4a1d521d19d6321f5aad@syzkaller.appspotmail.com
>     Reviewed-by: Daniel Wagner <dwagner@suse.de>
>     Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
>     Signed-off-by: Keith Busch <kbusch@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index c34ecb2c96562..76d781aaf31fc 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -512,7 +512,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>                 break;
>         case NVME_CTRL_RESETTING:
>                 switch (old_state) {
> -               case NVME_CTRL_NEW:
>                 case NVME_CTRL_LIVE:
>                         changed =3D true;
>                         fallthrough;
>

