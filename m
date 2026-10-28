Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793183013;
	b=ket9U/SstDNmrrW+Oh8DqH9KltZGCYZ0wHZO9KpnGNlFYXbosxipVgE75SsEiYwfyh+6
	 QS4UnKZZXIdIJbPbcEsMyUVuln1MWnLoKnMb20TE+xMl2JLB7W9wrVxbg6ZUTBr+chMNo
	 GcheFzTFMkGJC7jBm4QOS3BjN15IZD/sUp+p6qhxnpbi9EseDItGsPCFaiHF6CRp3VLwD
	 L30f2jCD4I0P5I7x6Og8BZKnq95+KMe3sWMsPOzdo86bjjhqXRRguoSn3H4PqouIPwkj1
	 1bRUNLD3UlO3iGRZvGl7RVJGDm1Sk7PypTPi3+uzLHnF0EFtS/baVzymUu5jc1aJOSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793183013;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=h7H5p3/8MmY2hRf2o1iZplE7/tq7UTMN+hAVuumZtQQ=;
	b=wXd5EA/Nl+cbPI2c49MCXafOHG8S+Yx7yrP5iCRTqTLHjRpjE/MDbYitXBd75UqsMMYD
	 A+WHhNiHPd+RNKR2CPFBPVVz+tx1tlaEwr41qfHcJHeJTYIqvk+oEgqhUB3p1fVvDqgP7
	 FAXDn8+VOSYg4p3PLounXhnnoq2mVZLfRjjm8xHqVXkVY6xCEVHUl8K8CqqtJbHrTEIud
	 nwiBJXrbnUnXl/h3vxzXJohY2yL6RjOA1Uc4DAaFKhBfuJQ9HQT3qzXlUcpb4xWyEfOGe
	 GsSv8rcD8cVb0rxE3eACai3Q1BbFNUUK3ZuV4Shhw+b7In70XcPUy0WiYjXFnnDZ//g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oXrx7cNs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED338606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 10:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED338606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oXrx7cNs
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e95bd1c14cso6257255ad.2
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 03:23:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793183012; cv=none;
        d=google.com; s=arc-20260327;
        b=rrgAKmokUYC1zLqoDvx8nqfn/Nifggf3EuWRMQfhpGoWFXFTs1q6gcBG8KXj6sB7SU
         pXEkDj0TbDXqNGZtdRk7Y6/pJSbZd530Jseobt4xoTzA14QoElO4hQgIe92iRLICS1MI
         w5jVzXhZUmQHx6UCw8Cv2BpVvmMU9u35g1MPkfyW1T1/cOpF3nVFMd/Wy9nuyMxtlXHd
         mDT4p8P9FahqT0sJo289iQSDk//LtphFq9jIahT7WN6IR/b0p1/PCowlk66oyItfx66v
         /FP7KX/3M8EFesNW59IltFmB4vsAyn2zFfWDt0zt/T7+lNVlg2tUzj/Lza8ZvzTvS8fu
         0qqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h7H5p3/8MmY2hRf2o1iZplE7/tq7UTMN+hAVuumZtQQ=;
        fh=/TwIUwOucYSHDJlBDWjVOS8zhul1+Ci0jUKc8vVAY9w=;
        b=a+52K5bA0vD7B8OicjZ6He7JaJIGxdvi3mGQahrHIg7pyxx6Tlx65BMXkIPGWrMOoZ
         c707I9F0iTfYojGmE0mJSVuG0Jk3ofNq9nvyVj7wE7kkNOMaOpkkEtebiB4yYtm6E/VU
         14EQ+c73tgayGG7CjZiW8bTdIbo7qH/RUn5J/AOP3u7/dNH5jEGTVNhjxthTBBXC9qGq
         b/QywqaE8/hQh7OwvA1Rm2Jbz2VAoXAllEVJJUhIeSrMXhSnp5TiMT+WjEKdmlCB0MmI
         XBeo6gNSaCL+tt0x/8r7wH/zCNfS6v9wkq6a1ahV3CPxPfjLTgCLtSN9Trm2AWeokAvC
         2IfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793183012; x=1793787812; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h7H5p3/8MmY2hRf2o1iZplE7/tq7UTMN+hAVuumZtQQ=;
        b=oXrx7cNsisFgzIbJAbxRsjycjR5P/FTNIwQcCoFXpEm8b5OuGsX1ZAeYcfy10xRWrA
         /IAdNzehwadoWFQ0ARxy6GH0VNgIMsMaeBzyjN6YfwViBH/OX5a8uBnb7C/6hPNiVTAj
         RiHflQbveoBiXlairYL4JdXjOew6ZDuJ7Ck/cFqNtLF8WJLG2tzxeTfqmQ5jRejXW4DB
         NsLSkFEJDfAXwwacbCW8VhzPraBIR/WembaCMhqhf/lzLSreGUCC128Y+T+nWXhyY6Jp
         WSdkpBSdiE1LsKoP0SW7l2j0ujp4qzT+meKsOxzgXUkSIlKg0OKt1Nf5wnawAGkPXOIh
         uixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793183012; x=1793787812;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h7H5p3/8MmY2hRf2o1iZplE7/tq7UTMN+hAVuumZtQQ=;
        b=uEGGpSk4P0djgu4xrBKHkNhlmM9tjdHqeFpE7hfvFY0ASmuJiPnwTG8TtO4VNNWdtU
         nDIFzJWvutk0QV5Ltvps0PaSt9NE+acIdL2N9wAI2R4X6HXnVegUH74naKvQkvXoA1NG
         BfmNheKnrAEebW/PwYxAxxP2qOv8Qt961/cqec58TYkeS15EDEKqSaaXJq5YtwaDIZMW
         pw3y02P9TDxdHTVQ4WazeghagEUu6asY6rJ8ze2uuzBXNG5AM0pCvs2FBr8jRtlYAUEv
         5iig8truuJm8gg378TyORTBUttNqWREAD+OOwEe/akcvzX7o+rakDhAQtRPz/9gDIqcl
         VnSQ==
X-Forwarded-Encrypted: i=1; AKwUvBxoUDPccoAjLUDZlNqDhlU1OS8WXbFmbwydYcDda9nP39WoC9nzxlo8CfpjAArHfvJHpL9bAEI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJOgSy082M85ITJfy8wMX90SCaP6bDBjYIX476uWbOPl1LM43Ly
	yKd9Mpuvb2ujO1XkQgnYPMMr8I1ANf4fbWUXULaOCkR83zQySiiBJduFk2p89a0viV5F/jkTVLw
	GdhckKkv+aATrmJshPQfOSZHWhz6c7ew=
X-Gm-Gg: AYBFou0dTjmfUQTR6m9eD1ugkL+TBbQ4tbhHzWauAGoz52a0a4cSRXUKe39+zDe6t5q
	qcONAyxLeKg4Cdj+GnDwOFtIS0XvHTP2gJV5+WLojHoSrTnlKcOWXUlesiU9/hvNAtIg5SXbgwL
	1ikI7tAGnaZo5WCBap7+dVl+7nVvA1WCF/p5aPjLyNqspN1ESTp58feeD2ndfNnNiLoXRJLTUB4
	c6ptgsLHVu5xKWe8Y6O3/07FpBk1dxv8D8/coRoswCsNaoVDm1ekHFOXB7s9SYDNWX4Sc1qADh6
	ks49hXDmTOhwAKPIeXRzDKXFL1OxBYA3tX3Bxf1Z2g6RjsujeQF9c9aHZAJyonvpueGg8I1r2xM
	L87D7xI+IYJFSo7aGjfoOwaRi8FCRY8J9Q5M=
X-Received: by 2002:a17:902:da86:b0:2e9:5b4e:b8a7 with SMTP id
 d9443c01a7336-2eb005d279cmr16426375ad.51.1793183012215; Wed, 28 Oct 2026
 03:23:32 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028-btrfs-fitrim-freezer-v1-1-0ad1d58aa94d@zliang.me>
 <CAO0HQ0UE5BtevPHHfV9mQo5HoqzxzDDjAkj9e=pD_0AaXmSYFQ@mail.gmail.com>
 <65fd2260-78e1-4521-9df1-b042788ae7bc@suse.com> <CAO0HQ0W3rALzPX59mVONjDtK1otyS8bo6_hGG6og3qwyLepmnA@mail.gmail.com>
 <84d8eb19-4264-49a5-b9b0-733c4e971433@suse.com>
In-Reply-To: <84d8eb19-4264-49a5-b9b0-733c4e971433@suse.com>
From: Luca Stefani <luca.stefani.ge1@gmail.com>
Date: Wed, 28 Oct 2026 11:23:20 +0100
X-Gm-Features: AclHuK-TMMY98rKDlXfL_veOnxxf99WHKRVy94H0MfYOd5RXWKEpFis_Hy3-fi0
Message-ID: <CAO0HQ0VTd-5Pu_4MmNfcOCjd4G20K4L2=qtkOBfAjYaOj0ZD0g@mail.gmail.com>
Subject: Re: [PATCH] btrfs: do not leak -ERESTARTSYS from FITRIM to userspace
To: Qu Wenruo <wqu@suse.com>
Cc: zhiwei.liang@zliang.me, David Sterba <dsterba@suse.com>, 
	Chris Mason <mason@kernel.org>, Filipe Manana <fdmanana@suse.com>, Robbie Ko <robbieko@synology.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Oct 2026 at 10:42, Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2026/10/28 19:50, Luca Stefani =E5=86=99=E9=81=93:
> > On Wed, 28 Oct 2026 at 09:57, Qu Wenruo <wqu@suse.com> wrote:
> [...]
> >>> I don't know what the intention of btrfs: handle user interrupt
> >>> properly in btrfs_trim_fs()
> >>> was, maybe we should just swallow the ERESTARTSYS case in those scena=
rios.
> >>
> >> I agree on that btrfs is the exception, we should follow ext4/xfs, not
> >> rely on some tricky signal handling behavior for suspension.
> > When I updated btrfs_trim_interrupted I used the same "checks" as
> > seen in ext4 so at least on that part it's identical.
> >
> > What differs is our error handling: we set/handle -ERESTARTSYS, ext4 do=
es not.
> > ext4_try_to_trim_range only ever succeeds by returning the count of
> > trimmed bytes
> > even if it checks for trim interruptions.
> >
> > I think if we remove ret =3D -ERESTARTSYS; from the
> > btrfs_trim_interrupted branches
> > we'd align the behavior (plus reverting the previous change as that's
> > now useless)
>
> I think that's would work for most call sites, but there are some call
> sites that we may want to know if it's interrupted.
>
> E.g. btrfs_issue_discard() is very deep inside all trim calls, if we
> drop the return value without any other extra way to notify the caller,
> it will incorrectly return 0, which is definitely not a good idea.
>
> A safer solution would be keep the existing ERESTARTSYS, but change it
> to return 0 for now.
That would work, I think.
But that would only solve the userspace problem, as checking for
freezing(current) might be wrong in those points, which was pointed
out in this change.
Maybe the "old" btrfs_trim_interrupted users should go back to
fatal_signal_pending(current) only while the free discarding phase
keep it.

This looks similar to what some places in ext4 do, but I'm no expert.
>
> But if you have a better solution and can completely remove ERESTARTSYS,
> I can't be more happier.
I wish I could help, but as long as it's a targeted change I'd be
happy to help, but I don't know enough about the fs :)
>
> Thanks,
> Qu
