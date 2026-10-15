Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C665519904
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060861; cv=pass; b=YmJxba3Ako6M9t1ICzTYGGUw1N34LnU6TU6znvpQLufjqaZb4zO+wVMY3KthgWD+j32hFtgYaZgsQBjZUl5L2vXdh3nnWoB7FP/Kr0avuROFgkFzMH78+aANUxrjHAsh21RT8pbPhiNBF1Cdw3Gt2Xw2u2FJ3oqdHA/8+58fR2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060861; c=relaxed/simple;
	bh=GK7c7qoHtQuqEPaLuDtj2LTHMuxiL75fJf9jcPF0ouQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oxuAkvQqJIErLad6g8GueCXma8IhvriAShqgAdP8RlnuVlKmh9ldb1GHfAU8AMDgIhxOC4lEla8A++VIQDzalyg24yPJmbT8YNJQKohK3YfxIU7y2VZ6vjRtyqMlEGHZKNkvzt8IBzM5emV14LPYmqt3/MARP/0EWaeQWZLjqyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqfpUHkR; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqfpUHkR"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93e6f83f0bbso466937685a.2
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 03:40:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792060856; cv=none;
        d=google.com; s=arc-20260327;
        b=pYv02g37BZv+ADCOtogM9XYYuODQmO0HMJ7suFUYnG5Ivnnu6F+z9oMoSGbvk085Lu
         hd9Hp8PTZOm4cv0fE0+uMyiwaHUJtC1ZigXkJCC+IE3lgTN7NemFvwu8NsfojFVLbDfk
         N6q/TzL9DnJNBFx909SJfZUBK+PZkouegEdDKX8ZG5UXbxbJVLwgj+Bc2uRq3nEpkaVf
         rNDzw1kEA/KKnoEqhyNBaBy+3QIuLIu85Pvm+aa9j/qXi2b33IFjWQqkdjO9gHiieYGg
         2kkMaZysXeRX8DUmlBUJxFIghCWi3XJzwtUz37/GQVMWN+2HhkwYuSwZdcQuvB8X+Lya
         n77w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GK7c7qoHtQuqEPaLuDtj2LTHMuxiL75fJf9jcPF0ouQ=;
        fh=/FR81YOsIcXf/yUqoXrcGrK8Nt2lXnWJ+UX09ZXwj/E=;
        b=NIexhX1gy3X9r/GY6GKUqNKNjjehkZk0U21T6QruWFpqSsPf/fcXtHVk3HTTyWISEf
         VNUKkiTWn7KdOY/6GdCn2D8g5nHFwiAs1PnehXKobGbbGHdYVY7ztZTUHgn2H1qxhQUI
         q6dA9U6L4+tVBZ69NXxn9s8a+lbofI0ku3FKMSy7kL/RgMO4AhyyymXnmi+yfLsWd9Br
         /12uC1mrSytO6WvcBmfdhePhVixHORum+79SaOZzeInDrsq8zLJ/j+OZ6GoG+IVFf/Cm
         wEerdIyhLZiaY0Wf1yGDnu91t+7VfCNOIidoQY40FlFC45UfhXo8SRI3OzdjjYhrBz/G
         e76Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792060856; x=1792665656; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GK7c7qoHtQuqEPaLuDtj2LTHMuxiL75fJf9jcPF0ouQ=;
        b=eqfpUHkRQ7qRwTNh95n+xJ6X85PnYm8jyjqce+i/61u7J2eh4mE7IcwgCnkRkWRa0i
         ty/z3VliTAfOX7kOev3zWEmrCNTCIEGDLO2bSMksmnUOgoyQ9dBwikiBfjLLUm79k7at
         Y2ALdycVhCAMOGzSbzgPDwubOaHzcC1k8ovoqPvkkVlBErLjh0K6DxITkd7FH9ok6Uyo
         YOk3EVOdWTKTWd635wGaT3APppl/lMkJsEnV+0SQXQlm3tweeJS/S2FW0i2nDsg9PeY0
         V3h/SQAf4neA966SgByqTmC7x6MT1m13Bd+855HKw3XgbC9Ur50BKusXi0MGYwVZBMbu
         85eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792060856; x=1792665656;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GK7c7qoHtQuqEPaLuDtj2LTHMuxiL75fJf9jcPF0ouQ=;
        b=OGw3rf8nI4hqx/mHVvf91LIBK6+boniFtbNiPvZ/Iqw1+LDgBG8N380L0h/k6NnwDC
         di1ni8WLtY2Hy6mm+b70HP48hA6Xyk04I4D9mydhpFJ+reEgSZJnHh90iJf+SFLDQfWo
         x04lLt+CU+Sk8vukfUREecAPZN5LeGEJBEl0Q87NHoI76QUgpApvNkBZvb81CKiOdcOb
         uQP1red4/RyuGZSAVOxY6eWDBpHSoV1o2/Dzwv/jqmCAILtPiwbVyTg7muvLO8srPyxl
         pajse/DT4piw6pBTZ0DK3NkIH4V69e4xfHaO7f6T002Wea/cHon7naxRrsKN7MnfaUt+
         XrUA==
X-Forwarded-Encrypted: i=1; AKwUvBw19r0HyoaqE2wnnEWeA+qzCTeHbwSazdBBW2cR7NptBUs9UrHUcWNxGylCskoIANJm00ddPxI=@vger.kernel.org
X-Gm-Message-State: AFq9FYL5zh4IlGOGy8Ic1FsFe2kBorGygJtfuK4XVFI+fDWDh7bHAjoo
	gjLxd7y10aPCWEKoDX+aB+YtnWhQWPmiyMPXBNSdthjJOkaqlTP7On+r+SPeVygSEQNEoZhfnSR
	PJ3yQXLbCuZ89rpoQfU+YIZ2g36Ig+Kbyi8z/ul8=
X-Gm-Gg: AYBFou0R0AitqgnU44Sw/oNrcv3uO3Boc8AXsaymremWISduyJhGP6fF51vebVJsmO6
	l1/MpoXVh1vM5Tq0+oDuddBD2HuBqnVB7LKpyb4IZ9lWjCGBciGI9yuKOAYVdDLxzyFUZ3ShF1D
	KKkn4GI4LoS8ZKIVNWFPXZwnVs81BCFFyMgrCfIdsCBh+chTpMgBIixJSdDlJkfmd/trAbmFECW
	TQVPSbvn4GkLWBK9x49vy+amCtNvCwwhTIAkyqFRR9u9y1oNDMhAYMpmDXGsyItj0ZPudpRg5vs
	bhKZKdfsVLVY+iiv3zLbpdrnD6Qtb1Jc37hnO9utiB44E9Fx7bDCt5pb3JDzZFG+PReMfIVqY1G
	UuKXvzenqd4d1WO3qKwwPqUKdH85Kr8Zxhe1qgXu7u6Capg==
X-Received: by 2002:a05:620a:44c1:b0:93e:6e59:ad16 with SMTP id
 af79cd13be357-93ebd1dfd74mr3037179085a.29.1792060856144; Thu, 15 Oct 2026
 03:40:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928081450.19340-1-dilddream31@gmail.com> <CAGC3ukQ7gX97E7pG0Oy8H0cnmQzoA1038io+VhrBogPB3y9dDQ@mail.gmail.com>
In-Reply-To: <CAGC3ukQ7gX97E7pG0Oy8H0cnmQzoA1038io+VhrBogPB3y9dDQ@mail.gmail.com>
From: =?UTF-8?B?6rmA67KU7ISd?= <dilddream31@gmail.com>
Date: Thu, 15 Oct 2026 19:40:44 +0900
X-Gm-Features: AclHuK9ftaX0YjG2NCtLvWvZyiH7eh52x9bAW5dRWFx1APAiB6cYmVIL6REePPY
Message-ID: <CAGC3ukSVk=N4ttd3hwnXXXppHchwroJmySPAFP65Vt+uP0COOw@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau: Clear fence channel in no-signaling path
To: nouveau@lists.freedesktop.org
Cc: lyude@redhat.com, dakr@kernel.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle Ping.

There has been some related discussion here:
https://lore.kernel.org/r/1690ea65-a1e0-4a34-bde1-bdd26e31c6c4@u-bordeaux.f=
r

The patch has also been independently tested, with no reproduction of
the issue reported so far.

Apologies if you received this twice. My previous message was rejected
by the mailing list due to HTML formatting.


Thanks.


2026=EB=85=84 10=EC=9B=94 15=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 6:10, =
=EA=B9=80=EB=B2=94=EC=84=9D <dilddream31@gmail.com>=EB=8B=98=EC=9D=B4 =EC=
=9E=91=EC=84=B1:
>
> Gentle Ping.
>
> There has been some related discussion here:
> https://lore.kernel.org/r/1690ea65-a1e0-4a34-bde1-bdd26e31c6c4@u-bordeaux=
.fr
>
> The patch has also been independently tested, with no reproduction of the=
 issue reported so far.
>
>
> Thanks.
