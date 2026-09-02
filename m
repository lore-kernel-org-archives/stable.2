Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E8A4A5C4A
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788362236; cv=pass; b=Dd4kvopUy5VNW8gEh+kOvLibwg5uCbmqNpLwtpfg3Wauf1FdA2bI8oX0KxZ3n3TfqPxGZjEDtgeFHoA/gyjYJe5SvNeSIISE3wC89qieI3vlQbFUvSzw/e8gW7KNKW0MsMU+rZwp5kZbbCgBS5NqcxRNgTTl57xYfYdYBCp7mvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788362236; c=relaxed/simple;
	bh=HCC/6KFEAMm4V1Cz9W4xpNmgiWKlwwdYoylYCLylISI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFTp+OIseHGg9ydYl/QKQQ7Hu6Nbwidw9rv6yDPTnBOxkNH5ElNgzVhmCgMc+OFbcM111++HOBrvts0CfwFbBzO9WoNsqNn8Gih3D1HzKptKCzN2r08YZGEl4O9uT+ovHrrSYavI8/pd6z+4L9G2cNAvoemlTEIC1sNuCaK2ynw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Km7FOWj9; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Km7FOWj9"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a5e329c0f2so1592271a12.3
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 08:17:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788362232; cv=none;
        d=google.com; s=arc-20260327;
        b=juMhS1cHN9vfd7zuhB/5+dbtcTmIi3UyeK1Y1LF14TKC7IrnDAys1zzc9afVRmj8D2
         ml39ghGRVmjHhXGdwpVqG3bGcWkjhZo+uU6ak5MgeysW4nYT2tBoUM7Rwu4EfGp3nn5I
         h23DvIFrjVLw0n/QwvgqkvVsrscjLjpgh85yvVlkQaY+lXPd1VeC+hozCrfN64AdGb4b
         mqAj5KzLE5jukC/ad8IKBYyJCF3hOPk003C18Y/idC7hhywu94N51k1YrmfrdlYPLqbs
         ZIzTxspbzzaenxPD/1v5aiJGGhY7k4wrt+S1rTd2KILq4XjV0JxJAQWRe1OF7zQCPO2m
         ARcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tTGWO4BQiMMCPhl0MvJ6+ZmQ9g+J0+MwZKIZjv1m17c=;
        fh=BDsPzfuI/61ZkFRJIhK5jqvyI7iuy7W3ncMvk2Pzzgg=;
        b=osaOJNH2Mn3O5t7QfoGsBUh9fnYV73Vf2Sg2P3mmn9wOjZuQFJTkPp2lqc18pQEJCW
         pAKaibvF2wplyWC2txksTAeH0nFvTVF0aLb8lzdm+ljaDdGRuSNZqt74Rrjh0uZE8gNp
         UnDD36BJ+mEdGGheeqVT3nyRhzBvkRhKzuVveiZSJOXsq806uH/t9a2whFUObSUBEeO9
         9c6nDlowCONhsiXQSfkIBjN5rEpVX/k7x9RRDTsugfNqMxTyUx9Rej1NODHzMCHsmnH8
         ezg2d/c4FljJYIFNCtqUFKQVoj3C/xnXd6fbv/mZUcluaW7fOFoY/Adha4rtr2s88cLx
         Wizg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788362232; x=1788967032; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tTGWO4BQiMMCPhl0MvJ6+ZmQ9g+J0+MwZKIZjv1m17c=;
        b=Km7FOWj9iAsHrAuGPOMSehIQI5cmQuu7+c7ILfW2qfx+TKzMDvXmUq9Oe+jb1gVuBz
         mucS4sJb0JPITC6cx2cCz9jkuEILDSwk0p363+l/+tm4uiYE7jMJPkJ8pxnvkkCUQ3Bn
         AahMq3iJjmvxtUBpFI7y/6T3xN1jwXyImZXyTtiO8JhQK9Zirj0K7YChb1c3iEG9LCWO
         LWJ34LwaGJLTAQXy88oaDCN40LQdZIuZqvO8DRrwXqd71ZJdbfLAE1OJwisWmBuin7ac
         z+4TxOANkLZvH41pgp0jJsmZIUW6ihg7F+uhVtUSPqXMoUqwazdZCgEfCBtPULb1hsoQ
         EeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788362232; x=1788967032;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tTGWO4BQiMMCPhl0MvJ6+ZmQ9g+J0+MwZKIZjv1m17c=;
        b=UcfjuB/E2meN/MMBdfVo7sos8rBqd+9IW4r+D5wnJXYa4rkfIEc/1ShdnkWq0ddJyE
         7davjvMKuppmrTL+2AtpRHbZIhwU8tVquU6b2Axt/eSaHdwh1Scak9l/cZ/LwjoiK2WN
         me0Y+yXQ9UcRRvmDMtD26KrZ9oHMaCg01fnPvLRdWOAfAm+MCnbXMsSL34opih14nbmJ
         On/l9BgD8/WEvjJ6b6B42b9N7FUETxGqSW0+C68D7jZskHZbOHFvvTKcYX1BLX7Lhb0j
         UClkYMiZZgly33ugh1bYtlge5YP/6pyb15Wp/GBmQPa8dLkvEUM/p5Kt0XuNoHzGyD0j
         IhkQ==
X-Forwarded-Encrypted: i=1; AKwUvBzrxWYixQ9zaJV++w0GUoQZpeCXe1ZQQqv4hDFlyQ1BbFGbnUlbG3W3vj1zorzQdfrfXhawXE8=@vger.kernel.org
X-Gm-Message-State: AFuF++knq7AzJ8zTNQjIvsi3NVf3quIdqI0vURbPpxdW3E8Kp7eUddnN
	yqhCLORLKspAt5KZJZarN+0yjhyZsA+a0Rzo7e1JwYv5Y9lltLRNa2jjXbgAhmlpdFLZSMTlM/P
	0J8jkG4usfLfihxW0v/Xk1g701bAfDPQ=
X-Gm-Gg: AYBFou09nse2VJUljY8GK16g936x9jSAkh5MdeELyBNWQ8S9pEUkt/iznuQ6xjZeztJ
	oqA8pzMsv5htM3rPbFYpMFIp98Zjz5VwFJcWpSfWTxChAhpoLI5ILv+cXL+xx7fKToeiMOs+rXq
	qKtXGnqLODRGbWQTY6cnmEGlvC/p8OhEVQkHjolQT1DxWFe3B/kT3wqoflB8BDycztWhvqDHv64
	bZIraQh8PX4LZYqCbTgpkhkfADxvwkV4GBEIV6zKrhK+7uvoveZkZGI6i3AiNA0LoS638gmUemj
	SlBuL4qIS5BVCqmSBBkuvGLapeRDLxdGdCiDsDdsaucGzqAVXSTNFqa2q2LFKMXEtMGCphcWtM0
	BeQ==
X-Received: by 2002:a05:6402:3216:b0:6a4:ae1:333a with SMTP id
 4fb4d7f45d1cf-6a682799fb3mr4537168a12.12.1788362232011; Wed, 02 Sep 2026
 08:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901185600.2725678-1-2000jedi@gmail.com> <2026090219-democracy-chip-87fd@gregkh>
In-Reply-To: <2026090219-democracy-chip-87fd@gregkh>
From: Yudi Yang <2000jedi@gmail.com>
Date: Wed, 2 Sep 2026 10:17:00 -0500
X-Gm-Features: AcwNN1VqxlHP_AWnjy_mt0418fNXAxgUYvArTOP4_3ID-w8R8wzD-318rfyEZwc
Message-ID: <CAN3V2YU0a7Mj_Sdv5VLLO6AOCbTYXJZkRwfKKyZtB-yPb5COOw@mail.gmail.com>
Subject: Re: [PATCH] staging: greybus: audio_codec: fix stack overflow in
 stream name parsing
To: Greg KH <gregkh@linuxfoundation.org>
Cc: vaibhav.sr@gmail.com, mgreer@animalcreek.com, johan@kernel.org, 
	elder@kernel.org, greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I found this with an internal program-analysis tool that I cannot disclose
yet, then manually verified the finding. intf_name and dir are 32-byte
arrays, while the unbounded %s conversions allow tokens from w->sname
longer than 31 characters to overflow them. Using %31s limits each
conversion to 31 characters.

I do not have Greybus hardware, so testing was limited to building the
affected object and running checkpatch.pl

Yudi

On Wed, Sep 2, 2026 at 12:55=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Sep 01, 2026 at 01:56:00PM -0500, Yudi Yang wrote:
> > intf_name and dir are 32-byte buffers. Parsing a module-provided AIF
> > stream name with unbounded %s conversions can cause buffer-overwrites.
> > Limit each conversion to 31 characters.
> >
> > Fixes: 60e7327d54b2 ("greybus: audio: Find data connection based on id"=
)
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yudi Yang <2000jedi@gmail.com>
> > ---
> >  drivers/staging/greybus/audio_codec.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> How was this found and tested?
>
> thanks,
>
> greg k-h
