Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9096338D401
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 19:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791573206; cv=pass; b=mtX40K9sZEd8VlxyGmW0xeogsA68uxzUBU5RJ07YFeR1DOkBkjhWktFwoR8rMkyQqFbSekXJhAWsbGMrUI+Y9irxbt8Ts9VbhSi7Y2iNymsNwNWjJRrij0H6CTKBldi/pIemr0bmA42HSbbR/ILVQXv7lV+7TnZgFs6Yz3TptE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791573206; c=relaxed/simple;
	bh=+m5RVY/Fd1R44a1Q2Ut7yuguyjSg/NovE0vzMnvGQ8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFz+/8iAfZjv5n2vOiq27OoxxDlRBFPp56Tqyn+WgCsbe6Y4qONgetGLqbMOKoNn+8yaRiPLSugChptcJcSiOOxnJpIzFFprWz845rBdorVfBUr9wjCY9ya9BduiuewByHHrGvMqAA6DGHT9JcKZ+HUbIKv0u6oJdzmdG9MDE5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnjd9uup; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnjd9uup"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8ab8d96d02aso35167b3.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 12:13:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791573203; cv=none;
        d=google.com; s=arc-20260327;
        b=Atfw9hvCm6Y80Ibd13xQzLFzMO7En+GIHj6Kl19CF4qU3VxeKCIgj4pS0jsQahGbP9
         vfXQcUhc+CBzFRNGkVlI26ihn5d30JeGNYUMrdlv3ZbzDcQjN5ltgwGSeBLGEIK8vdeD
         0XvGorkLpb/kthoY7XG6P5pUPqh0b02OBtirU3V0bjcHtpykdRhB4LE9aq76iNk6lIfT
         wfqVLQPzi9p4ovAQfOZPFeh3WNZJSScE3mxAVVp6zXiksmARvH6VEKNsot5cqRvMdqAz
         xpl0++Jlhvi/hY8HQAf0pgjSfOs54K/PaGIBmeKJbaDY2N0mIjBvxIWfQrtp7sg2KFIc
         8pjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+m5RVY/Fd1R44a1Q2Ut7yuguyjSg/NovE0vzMnvGQ8Y=;
        fh=fZGTRNhwpDmvhZDjcj2Q8K6ydFf8NaNYJvlevY2GbzU=;
        b=YVjQABs2ROyw6XZFp8eczXJCIrUvv8aAbhNmdU5yEuTc7M46Ys2BE94WlY1nTzAkHQ
         WLzSMRY93fd4cj7zUEC07J8MZ+HIot1VHlr/T1XGvf2km0jM5SbzwOSI90JvCGJnV+kg
         HKZpPAuKEdSzQkwRZ27DA/HE3w6nBPFcmpLJQmO9BOphMN23QkGqwzsjmGgCBXNeK7PV
         p1Ifmi73VzlnMZ4Br8aLuFPTz8sqWMxGz4tzRK4TSliv2yQ/eZL5sI9xOuvi37JZdqM8
         /rjEGOCpsAe+O+P8NptTa7Bg7ZP/bBy5Ve4bkVNWgyjTec9Zuc3XF1JOpxfBNr5soVH5
         YjGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791573203; x=1792178003; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+m5RVY/Fd1R44a1Q2Ut7yuguyjSg/NovE0vzMnvGQ8Y=;
        b=bnjd9uupd6ay4UsAAdEnM0jgI0XHrlwBWHHW/N6ncfADCJPMLifeTVQT0USU/J0EWw
         OtxvWd6zYHvMoEZz2EKvOoZnPrcgPR3EKoOFeiUMdbH5xdcnbKeXAMab2HlYIrsOG6Mm
         DWsmhMtVqd8CVsADGJELQcw/oUwdjSPsrLBjBdMshvdpTUvf4VjDoBMwG6dRC7iQInIo
         8ORfM+wRaCS7ty0NFAP2+hzgqpkdrsnKrnV1Cop73DuF/ZDOF3pq4HZVmiADXoJynUYz
         OwKvC+QOfy1kc7fIcAqgsboczezKMp2Ns5kEv4wqU+OoIiux0c4HxSNKTawumE2hM9hz
         omHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791573203; x=1792178003;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+m5RVY/Fd1R44a1Q2Ut7yuguyjSg/NovE0vzMnvGQ8Y=;
        b=IFAqzCx/niwnSsJ2+Yiy2ylVnhPOx0w+nlQsfZ/eHp1qw5ZxOrBlGbv1jpyF9ljyTK
         Mw9ZmFoiFv2FX+66zbLVw0egJU2fDKMxShoqaxRvYbi500ZkvUD+d5+lMuxG/c93ijIk
         Ogo+/cFzrMbu0DFOpItYsigiMasSmQ2EbhJO8GOcJRcTM+Q5IGP5S+2FkrLjZ90VB4je
         e7lpoF4YR6z6G0BOwIQ+v3nf02v67EdGFrbdcuxE+gy6xCVGWFPFVtVuD3qHiuZttsco
         /O0hTPFdo4FeVni/Hl7cUz7/Xoj4w4GiJ3j3xcLm4PIIp1dkQSYio+k95n30R4QKIrSK
         +DIg==
X-Gm-Message-State: AFq9FYJas3/RTb81ikV/0Q5QSMjql0Lu0TzKsgcoL2n3Ikt6VYPM2FoN
	SsGmgt/QQ37GQ4Fs2UoqknWl6md3IU5jiMPqdc0HIiThLc0LA44J2a8EN4X8mJAR2ypWcp/7Ef+
	3sFrEFUQYwZVs29UxCkRLhL1M6wEK2hw=
X-Gm-Gg: AYBFou2oLA8O7Nn0tNq1GS1Ifl4BI2EiQubvIyabDBVCJKA6U7yRbMBnvJRamupKgsc
	dkqmCF0DZYlXKJOasp5Y3KghZzBd8Xhvru/4iWDrvRlXaIOg6x0IFd33uOhb6iBR2A1ectwmyWA
	dDEfNxxjBWKsYnp6j5QLrBB1QI/4ahiEqgnoWgKLXr4MOtQrvSG7WEuMUve3MpUReSfPcHKrEw2
	1phvREITUN8hE2VE3REI1jAevzz92CYTZe1ecpPl7z0e1JLzbNPVwh4Vgp3ErWd3Wa+cfCephDw
	tAppm31R6swlj6myWkZG2aihV4AVHTWpLarOEJOj05efOnX3BhRtAfW6Zo1T0869Kpc+NECSGSY
	pkPbCkh5mhfhelx+WzakJcDhHbIIV5J0PCZGQXxyEaX1jehm0X0C4ykmqI2Tssduqps9o0rX2hg
	==
X-Received: by 2002:a05:690c:1d:b0:8b0:8a9c:fac1 with SMTP id
 00721157ae682-8b08a9d034bmr1353337b3.21.1791573203443; Fri, 09 Oct 2026
 12:13:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009032616.432392-1-0xiviel@gmail.com> <74b15e57-1387-e37c-d343-eeba1de33ceb@amd.com>
In-Reply-To: <74b15e57-1387-e37c-d343-eeba1de33ceb@amd.com>
From: Eva Crystal <0xiviel@gmail.com>
Date: Sat, 10 Oct 2026 08:13:11 +1300
X-Gm-Features: AclHuK_cy9U-CWUp8mwYJvruBGY0UqEQuD2c3_YFDBhDH3-C0Ix51_bl-Ikk4B8
Message-ID: <CA+pz=kL0a0BpNf_ozK=MUntN8EjtAzb1Z_5MS4TLEV+sTLEtWA@mail.gmail.com>
Subject: Re: [PATCH 6.18.y] accel/amdxdna: Bound the sync_bo flush range to
 the BO size
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: stable@vger.kernel.org, Min Ma <mamin506@gmail.com>, 
	Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On 10/10/26, Lizhi Hou wrote:
> It needs to check if size is zero.

Thanks for the ack.

The zero-length guard from dc1475366424 is already on 6.18.y as
45962da5821d, shipped in 6.18.52, moved into
amdxdna_drm_sync_bo_ioctl() because amdxdna_flush_bo() does not exist
on this branch.

My check at drivers/accel/amdxdna/amdxdna_gem.c:947 runs before it,
and the clamped size cannot reach the drm_clflush_virt_range() at
drivers/accel/amdxdna/amdxdna_gem.c:966 as 0: with args->offset below
abo->mem.size, min(abo->mem.size, end) exceeds args->offset whenever
args->size is above 0, and an args->size of 0 already returns 0 at the
guard.

That is by code reading. The arms I measured on this branch all used
size 0x40, so I have no zero-size run.

A zero-length sync at an offset past the end returns -EINVAL from my
check, where upstream reports no error for AMDXDNA_BO_DEV, as my
commit message notes.

So no second patch is needed. v1 applies as is with your Acked-by, or
I will resend as v2 carrying the tag if stable prefers.

Eva Crystal (0xiviel)
XSource Security
https://xsourcesec.com
