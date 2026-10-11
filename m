Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFF64457CA
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791727923; cv=pass; b=CyRzURIfBMbBI+FxvrmUw9jyAe+DPk7mMAeCXgg681qEDP5kgPqGpTwh9BIB4Ga3P8vhf5M/n2fIetlLAKYQj+pJPO+3v900pXKBi3vLdgUdg9AmTZ6H8rDf0WWaBCb2y97RXqSNsM0DJ7vwufpDxjSj7YwWJeRnHZ35rK1xovg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791727923; c=relaxed/simple;
	bh=wdRnVqUf1ZGud0eChWIXjEZO/K7UTTIev25EskoBKgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SklOun0BPnN3a8p7Pt28Dc2RSDQCseQf8blCLYyKGLPHO8m9KljjSNrdPPqdfX5bJnEBm8XsSvt680u7FDzf1vBJZCDsvMMz6RQT7OWldHxRd62bk5azmzPU43jY+T6XWn9+g3sBpTz244yXkhIQlsS0MJGxhSr1cEYZfpE9yZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azOeW3qa; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azOeW3qa"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3535aa147d8so59158eec.2
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 07:12:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791727921; cv=none;
        d=google.com; s=arc-20260327;
        b=TSx2Ky2FQTYJgTtSGbnOG+R/XYtTMEq9J6RxgETccdnXYsQgxgK+JSg60ZDvJkGMic
         fT2xYQhnXGIYnJnk/hOOpxm4J1tXHltkSsg4hXHrXXUCtwvh9TRWqHf+9vDb3kB+yp9m
         rIZJlnFoyndOLGAH+I0Li67ag0zQfqYkCJuAFApzgpzmMRhVb9iMWxz2ZoHld8s1Q+Fy
         Zd8DC0GzMBqkAVGGIb+9s19BKjaaJyjBSVB/gQOsHUjEX6J2bVB1VPFUddQ8lWkHHv69
         uVGMcNHYSaVQ+vcR5IHY91hIZu/xiv1r3aaZn1iIWScS24mAwiK8h3rvxi1+xc++JL87
         KYog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L2A8o9vYIEEGemnCCmWv7AJBvyLztV29qJFJ0TTixwU=;
        fh=Zem2hBRIKA+1TQL2qHofmXiM8fvVGm5/joVmwKBL1qw=;
        b=VlAIu3Fwv7wAEqh0ztIvyFN9yIOA8DeG4TxpAART+25IMJkND0/vCkvnWIFDEQGBY4
         d/wB3xuK0xLge5/ntihC4HKQRkSQ8qTr3gLVr/oeSEQZM35oUQLL/kL64OEYYmSwlAv+
         1VzdrEaJ08itdJfRDj6bKb6B57p6BUwCnt865RzkbvoJe3D3TzAmGgPzIQH0DJqNfvO0
         YHmFC96JiosrsH7xfiw1vWacMC9myQ8fdMwTqNbAB0JR4B9qgXeSLy6AsW+6J0vLiNLK
         V2q/XDmrhlwRbezmc5M8/YNevnQ8OEKIz8t83EjPiNSjyF3wgJYAzOAlzinfONX+oiRt
         sW7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791727921; x=1792332721; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L2A8o9vYIEEGemnCCmWv7AJBvyLztV29qJFJ0TTixwU=;
        b=azOeW3qaHzyDh6lWAb+OGQhnpQT2g44MkSKiXkKjAGQntZnEG0qjid8cbXnUrKuWjh
         wFJEFFLM3yg5d99Xgakf930W2r1psT/nldzM4tjP3Jq9pbZfr7KC1APPyXtllUgX8tMu
         2TUhLzD6/HhhNYA4VFxaTgQJ02LD7i7JSm4P/rOX/s0alTV4biiMPlVOl7Bd6CUkiv4/
         7mIxDKY8mRsdG2SFVvKQ0swnxxKJyF5rrNrwS7/MocEv52bP3uiDYXx8m87tW/p2U2d8
         ATd2Zs9XThvh3YbnjYm6qXiuWGHFthJHrWDfs7uTcN1pGij0jL9gmvib1e8qi6fy++Nj
         lT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791727921; x=1792332721;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L2A8o9vYIEEGemnCCmWv7AJBvyLztV29qJFJ0TTixwU=;
        b=gT3jUBMtlA+YolStVvLx7E7qg9ECmpF4OaoXQQaDcgKdqOZKHYOaBLjgnvl/OPyO+G
         U8BRWF4pn5C1R1Tx6J6ZocUikfw8fS2PZ0eBdqBewAIvCNfsrgOx6dssUHfhHYKqTo5p
         5yrNnBbOyzpnlB5Mwb3FWSMUjIMuoqqvGpl6tVc6Olnd/jhym3hakzGqvLb4cHxtO8IT
         iZHa4Lk3tDZVDPFGDtkSiYV0jf963mMSMVUmowIuM7hZAa+dvEm3u1Cbr7C5lMv9AWBy
         4SdQrP9WPamT9VCeP6z9vmMMTqHIhS9Uanvqh36ayuVzkO18uw+sIeiV7TWNe303Idbr
         GVmw==
X-Forwarded-Encrypted: i=1; AKwUvByG0RRwtXe1PxDhaoT+vWTAKBFTDcGa+YRGPqzPurwNQWrSIfAnVk25tyBt/5/plcO8pqRCTew=@vger.kernel.org
X-Gm-Message-State: AFq9FYIVWdc148x42sU6o1+llv9aTvT7x/Qzqd1XuliMhdeLuvszCwXw
	mO0roX0OM6yjIW0WXebT3vUx2gOaJljhE0tnUg6uEt/IT6BTg5ash50TzhRGx0LDoQI9u4gr6jO
	5zxNo1VRQ3X5FUKvbwEQU/9sM8W36mt4=
X-Gm-Gg: AYBFou1yqRuTPk2D97ePPcZUSn111Aoa0vSAWis84GskHWhZ3GPpqXOcanKFUfZGlsL
	6UlBWUK2KFv55eQsjVcVJKWBf5DvuY3FLr2n+w/m7/fJFLlgjxm4KMKaOyVlc/+Ar3lFRDB8Zd/
	7qCzQGGZquG0rBo8XtAGtGIb618UYCi8xoepIDkYcOvw1yN8K4V0z01M3JTpuPFlvTlPuVi7iEM
	ZVQAsT/lqkqCCd4ao5mmVOScUdiX5G3jSAaJovhsaDEnYyuVK/hI2ej4niY3X9GtgSHtHD4wHP7
	4uO4aC64V4nhydfapSF2T3GDZune3aLqjUQfzHDVcANVj2Pal8WX1Tws5HAo+hLnh73kiqs7H1a
	Toht8j2CadGqnbR1vpSsOT4+HxkM09PsQkKmdlNHQddto+BDIfNwlpU9aMpPt4e2/m7ifmiPAxE
	QEtRfMmoU/WaCUhTvYWShdDxaBK73sAbYwD0/tYmtKF6TUWye0j50=
X-Received: by 2002:a05:7301:4d0b:b0:33e:6714:3945 with SMTP id
 5a478bee46e88-3537e0129e3mr15526523eec.2.1791727921035; Sun, 11 Oct 2026
 07:12:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009140946.008206689@linuxfoundation.org> <20261011111313.27648-1-ojeda@kernel.org>
 <2026101124-rethink-craftily-cb25@gregkh>
In-Reply-To: <2026101124-rethink-craftily-cb25@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 11 Oct 2026 16:11:48 +0200
X-Gm-Features: AclHuK9vMOPoMYcJzpYtaZWxlpIrwxbTqInUNqo073P_f5dJet-f3k_x1nsh7uA
Message-ID: <CANiq72ndhLush3bugar1YGPnsein8min1k3_NucBxzFwCWe9Ug@mail.gmail.com>
Subject: Re: [PATCH 7.2 000/428] 7.2.10-rc1 review
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, achill@achill.org, akpm@linux-foundation.org, 
	broonie@kernel.org, conor@kernel.org, f.fainelli@gmail.com, 
	hargar@microsoft.com, jonathanh@nvidia.com, linux-kernel@vger.kernel.org, 
	linux@roeck-us.net, lkft-triage@lists.linaro.org, patches@kernelci.org, 
	patches@lists.linux.dev, pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, 
	sr@sladewatkins.com, stable@vger.kernel.org, sudipm.mukherjee@gmail.com, 
	torvalds@linux-foundation.org, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>, 
	Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 3:10=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> Seems to be broken by "rust_binder: reschedule node refcount update on
> thread exit" as removing that fixes the builds which I did.  Any
> objection to that?

Yeah, it is that one.

In case it helps, I am re-running my CI with the extra parameter
manually removed in those two calls (instead of dropping that commit),
to see if the rest builds and runs fine after that issue, and it looks
OK in all the builds that completed so far.

Cheers,
Miguel
