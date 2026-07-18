Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC79275AFD
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 02:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784343280; cv=pass; b=ujn6JRA+GZDfGSh0plBv7fA4ukA07AJaMxMhL7KNI9wdZ8/lH54dSvTprGWxq8B+DGRRKUySWVfSz6Tw2qgPZJJJJ4T8v/J/etTW7JsL7f1PeB0AmZijfMkBzl4H8AcJic6WJYGjaO0pu9LA5Dhz1OOPJ3U5xK42kcT1did14Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784343280; c=relaxed/simple;
	bh=+fXmQ4fYM/C8Kf7eQ39kwb3zDj7n5IWktBlZL1t9nH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TauqvC312lOz37SQuq7Bf4WdCViaqhBSZ87cUBivelJiWa//VXEPUiFrt68Lwne6SPlR0sLWaVL9mNGZ1v2kY1s7fSekafSV7XE1zabN4B8sdmoZYhmIlvThfVOyVgxr3dmzdKtcorKpFBVSbZtCdUsKf3C6Clg69NEZ2s7Mi6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdPwoVK4; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdPwoVK4"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69e54d9c8c6so2625760a12.0
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 19:54:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784343277; cv=none;
        d=google.com; s=arc-20260327;
        b=Zy5rQfeqrs99fMKK4qc1XtgtIsxeACQtAFmLAI9PZV/NEp+qN9EXBcGs8OF8mgk+Yu
         BTzTaSuepmTdaAIfnD+ST/bT+VsPMXQxrbkCP5tJrKE4ukUxusosxzwA4Ht5WRu8OFXD
         INJ7+HSD55HMyY8fMTbk5IPZW8URKu5fK4Gmaosze/gwFZ/hmOa5xmfSDy5FjBXSFuHz
         h0KwrCsFwMYnPlMoX1GqEUQBwxI1gaDntABZYh2LY6bYdZh0Ancyh1V9xsw61a/nB7Dc
         LmkxF+3VSclIxm6IHCLmZvNJav1LUHeKmvvs6FqN8zFTqo9jpKyqJjNcek9AyO9a3Zey
         XC8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+fXmQ4fYM/C8Kf7eQ39kwb3zDj7n5IWktBlZL1t9nH4=;
        fh=ziI4Ygim6Nqoprh9W22bs+MdCBaSioxPT/vd/TLfvXA=;
        b=ZAZo6dCXDIlU1SF6Nq9EVCLVLlNsxOwFzvmyJeESRWmUn0QvpW/9NN24Xn3AeScKjr
         QjxPX5XMFhlab6uF1PDViVxLMyC1a95dsRN3Gsg+AEpDzM+qylRtpi7Progzj8CSN29y
         rrrrUaJEpq07EONYbxh94IVYnah9pdafJ7Z9TFUU7ybeqP7TCjF1nTNIHIbT5l4be79N
         AwemasQCysIIPScyx/EcWZzHOPe8y1QlmekwCeyaHYk5XHED41e2vXs+FfdlrvxTihps
         wNCnF72mc7pBTRBZuIRmkDjcHvHD9VGaoEEA8NUuuQfRwzy8cDKK8Id6SXDeZshJskJ3
         uChA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784343277; x=1784948077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+fXmQ4fYM/C8Kf7eQ39kwb3zDj7n5IWktBlZL1t9nH4=;
        b=LdPwoVK4r21xHQBhFYMh2wNZjtjS01olV0WUUvnW2RKI7whpHOAPuWtgbhMJ2HO7PN
         lpn/AhamjcilY82TXMdy6F20AhKFMtXGYb93KKTmkp2AAi+s6Q9mjy2F5WbZCbE37wSH
         BjkDrjbOJNY4uWQ3qPELEuCSF3CrnNvBwQvIBrNL+6/UudiYJL7fIAcCYwkK96kKbJ0O
         UV+scKgI36Y1kGLlVfrdalDjsRWm6WvChzPaZN7ztTEbAa7WXRUNAKXT0lP13xUeEPEM
         HCBG8OsrjLJpT8CoXhzkWbXNb3M7p0UCokPbr/WKTETiMdO2+HSKuiV8M1R74svU9qhH
         Bceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784343277; x=1784948077;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+fXmQ4fYM/C8Kf7eQ39kwb3zDj7n5IWktBlZL1t9nH4=;
        b=OFq9MPvwcz9xmyPxRsXYAH99sojkzsoG+IJwcPB4jqeYxnqxv8Q3qNx9/K8yHkGaG4
         GNceziHhhONL0mY6xtThT1lBro9S3usGM43xCd1/aIJHhqQAv1GSoZy72Qg2GlYF9jny
         hQYNN6k4uhwEUQCZoPFMo8qH07CEDDQe22z4sKSHsvV3EAN6Iy5HPhYKPWJUKj4T2iZn
         hTlzZRD452xWpYie5ih8HIWEumWmsdQsAd1KFoUOZc7RcvRgO4ET1flHPifReakl7Bq3
         AWFUa040Ida0lpk6WUXqtZka3P47ijwLZrpqGICYPq1i8Cirh5DTr+NDR4JzjPUk5dMQ
         FFBw==
X-Gm-Message-State: AOJu0YxdHjP4QVk2lLKuGV7QaInrsoe2FY+7XzERWnIB6Pb2rxlXBaHm
	8ShMc32iz9KabSwgbl69Re17Krz6GTYmwLGIGPJUuST+kovrJUGbxe36jVB6/tPA2zWlWExvrxo
	4tCAN+bEljJCP4RKXCC95V9wLyvfHe7w=
X-Gm-Gg: AfdE7ckgNWZUMrdI5jw3ipE8lRYTvdkgCCk3RgjSsomLAS4fCX+XN5Q+AoS9y4pec+s
	XyuieRea1YLPcunno8VF6J2DgIaoGoFvqtXC0a/loIKinqWZC72ZeoVef3PfuEH8slqZUudj1fj
	T6xsctJahyjlDLvnKDyYoXo/zt2jSh+s/JsFY0tkTE4glMwVlLZy/KLF1KVjZho8ob4Lk9JlTq9
	5FohQQhhnDWwN5e/+0E3Goxr62KmLdGfep68R4jwHhPyJGTQQCc4nj/h6/M
X-Received: by 2002:a05:6402:50d1:b0:699:6d24:e298 with SMTP id
 4fb4d7f45d1cf-69e65228d68mr2144266a12.8.1784343277018; Fri, 17 Jul 2026
 19:54:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716073452.3246468-1-coshi036@gmail.com> <20260716232340.0004-stable-reply@kernel.org>
In-Reply-To: <20260716232340.0004-stable-reply@kernel.org>
From: Chao S <coshi036@gmail.com>
Date: Fri, 17 Jul 2026 22:54:25 -0400
X-Gm-Features: AUfX_mzzrnuEc2G7zOVpiKj8Lx_0pvDhqY13_Znnwo-AmE71xJjjJMiUKekMGDM
Message-ID: <CACd_6n0OJ=7itGD5_ooqFRmD+NwURddTE8Y=4pgWJvonapJs9g@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] block: skip sync_blockdev() on surprise removal in bdev_mark_dead()
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@kernel.org>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you!

Best,
Chao

On Thu, Jul 16, 2026 at 9:37=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> On Thu, Jul 16, 2026 at 03:34:52AM -0400, Chao Shi wrote:
> > bdev_mark_dead()'s @surprise =3D=3D true means the device is already go=
ne.
> > The filesystem callback fs_bdev_mark_dead() honours this and skips
> > sync_filesystem(), but the bare block device path (no ->mark_dead op)
> > lost its !surprise guard when the holder ->mark_dead callback was wired
> > up (see Fixes), and now calls sync_blockdev() unconditionally, which ca=
n
> > hang forever waiting on writeback that can no longer complete.
>
> Queued for 6.6, thanks.
>
> --
> Thanks,
> Sasha
