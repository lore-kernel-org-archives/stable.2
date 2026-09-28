Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DFE4FDA64
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790630807; cv=pass; b=JTN5TSW58nrlwjTKhr5WubGZ5JhaGJDqqap4YLCf/KOGfyH6IFqkZkgztZ7Objp7BvXYNTO/DZleFPTus8fHL7qlON9AAGdbtYSANmhzXhrpODW6pWkBCx48pdx43VcdJAGoWTHepMqIGYunV3bymcTUmzikQjleRbb+FObXGTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790630807; c=relaxed/simple;
	bh=36c4/nh2QN5FJt39r4MZ1OBS2WNzMmtUQ1xAvY0uwq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDlv/02ONRLX7fPShB2u/Jq9UJdd05fXJaRJgPBgBtgDbwQuQK8ZQ0koGhcO0CtVN/dPcUd/C6Rt7agtUKShIzWJfwdKiSx9uQ4O4VkN8VtFVg/LV0oJ+O4FrMpvRpSXQDnTjQsCZE1NXdEU2L0FJkWSrp07AICBBa1b1GYo7yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BppG7JaO; arc=pass smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BppG7JaO"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ac62c88c7cso3618460a12.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 14:26:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790630797; cv=none;
        d=google.com; s=arc-20260327;
        b=i87+QWwsZMP8t0sTQ8xSCQHxdaL895rjYY78+KIxCQlO1ZIb1w9RFs/0FInJ6tl78r
         ZXsDRti/cZxniP6hgDhKr+Ilsm8zSd9Sd7RqQ5x4ucKMQwsQOcBUHc40vVziyTTVZUYL
         ZTA4zhSn0WgUTXTf4xA7KfH4AW3fp2f9srWBY4CPzjIiHfEQWSqWs/Fv8rfsEujGey2v
         xAFCITFg9u1ZYR0j3uhciG5coIeYBeOsdLdCeF8TikgQh3op40wWTG+mP3QA+gNxyiP5
         RpqT/KP++doePgRewgEno8+Vxn6cQr+u2z91i9VJNj06bbagdVMlV7LYoh3ZkHukn9XT
         71pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FF22kV1FIt0Dfmqc/IkjF4lzpEWQoZDSVBGIa/FDMM8=;
        fh=crCHsYj4+1/uiQyluESuZ5U6+CCY8Jq8YLFNJPQYeBk=;
        b=JkdO4iQc8xlp3uQacq8jK8xdWrzacigXkRCRXGHfIzYPHO5C+rRjYdhpslQO9TN3kF
         11bno3GwYfRcKHJFNoWrpjrAxTsZXW+40WoNVvb9bcPb4rgtaGHe7KSPNixlqilj1r9u
         3CiX22yOjXhAARAugntiTDYFcTgOHnc5iE23drUgUNkK4R00MV6jliIqjTTvjLnofy4t
         KXOpNF5+QF93OAc2bMfwqHHOOZYJ467t/HAD1vi4uw3NN14cPyI1lBEcTFVaOOKyTC5q
         VdNqBvMgBD0PZMYVpTkAk6Cr0tgPBM1VLaup0jgXbcpCxqI0olBPuH/fcmtjo7LGKQQ9
         xfTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790630797; x=1791235597; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FF22kV1FIt0Dfmqc/IkjF4lzpEWQoZDSVBGIa/FDMM8=;
        b=BppG7JaOIy3DBBzo2JOMVh1r7+oGxT4z1utaZDi3nqkqq0tUNZoZRBVDcuGvgzncMo
         h5TcVakx8Ygi9KwyRi4ZbLphuqPYI10H83PrBK0nsBk060Tv3Kh7bm8WXUOn7lDVS3Yf
         NYmVAsGKRRR79eIqrppwhJ0/9WiexWnkg/BzRVtqW30YiFroaBkmMbfSUwsBNKFcrje6
         8+EFtk2sIwUCdFYpFh7N0njOzxuopnYdSFOyoUiicb2R91j7+VTweBETIza3fN50gar6
         kDANSx/QW0UyI2tvM1fbFMO3mcoZs5p/mpv9Gi5G7zGyExg76jwKZbXy/QuR72tYYYME
         LVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790630797; x=1791235597;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FF22kV1FIt0Dfmqc/IkjF4lzpEWQoZDSVBGIa/FDMM8=;
        b=JczMxbV2HdvEhQIrOBf9dw6gMjhccp4Uss8roGwke/gQlKPqzM585GtPcbv+Dl03AT
         /NLNVZlpRf5J2bYP8CjR+mSDE7vhItmdH0SVsvtqd7q9Rp+17mwBPY4s6v8j6ipovhRe
         v3V0E1BDvZNtCN3lUZBn8l24s8MlEZ0PqNpjKwI9LuLNVYsMzqxE1RqpML7y/TnyiMNo
         PHGYFUWNg0h66vQ81l0vhbs4qMYHGA0PE3uQsr9/AZrmYhkst77E7vX7YaBNajfdx0nH
         s8yeppD+p9HRzpDN9Bj5D242l6jJC4vwXneyOOBHPRboHn9vktUxvwIfGOTO+uReXZBf
         XmyQ==
X-Forwarded-Encrypted: i=1; AKwUvBzEdq0++wQ6L/ZI0F13GbEkhUlgPoRGpGdLuwHEg/2KW5PO5OBEdeS41GoVIghOxKAEPxvFqXI=@vger.kernel.org
X-Gm-Message-State: AFuF++nE+s9ZWnDZAmg2+esc+WFUnza+7I5pyYV0v5yKs8RxhJ9dZM3D
	9sLVi2OSPvQ9PRQc04nHcjQLem86EPYFT6QWQx5BX8Um2WjLQFOqPJ7hLP7F3EdUWxm5BGDyTs3
	Lm/3V2VqrR1n/nD6gHvMjWuySvrLoKvg=
X-Gm-Gg: AYBFou3qqHk4BiwKkHobBbCkKGRZd19Kyk5DbIgQrggy6eK70iIXR9tHWOk6P6o/ODF
	yVHc/GqY5B3OZbgggNk6jUtof+B+6y09899l7yd8p/Nh6cjIA/fQEg/mmkCRZxQlJZ4WlbyI22p
	5h5MLyPhFtudRZlNpEAcy0CIIVi7gwIWYa90CuizbO4ArvZvPd+heyXQ7JriueYczNhIxooR9dd
	19rQSTtBQYZHDjlxcRf2p7AV0KpscWlVjtbnENsRDVyWDYBSgeFYNewNQk7C6RhlFguF4SI2dRv
	s1s4Fmy1GZKwprMXrmCzJbJ1l4PsI5tgGRCYxJhBuBFyDsevCmwYuiIY1SLrYsEs54Ua0erNGQ7
	0aUWk6aAR9L4dTXgyW1fTX/SzdN+Bc5afNa4a/ZDjZo8svHea5xqg5/vHvq4AO9+VjDrpU7q9v9
	pHy5nMp/KyMoKrDgDKEXCBh2ki/v4nu+U8aqYAX0k3
X-Received: by 2002:a05:6938:a085:20b0:c2d:c6e7:9e9f with SMTP id
 a640c23a62f3a-c2dc6e81bddmr310910566b.27.1790630796755; Mon, 28 Sep 2026
 14:26:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928200318.63383-1-meatuni001@gmail.com> <20260928200318.63383-2-meatuni001@gmail.com>
In-Reply-To: <20260928200318.63383-2-meatuni001@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 29 Sep 2026 00:26:00 +0300
X-Gm-Features: AclHuK9aoydHFby8LX8BqY0ekVNNZF7gZBjCzIJJrmWtMkMRg0jStsZZ0Ski8IY
Message-ID: <CAHp75Vd0NF_5nusyoV=25umqUKiNGynCJU1tercwMZ57c_BfRQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] platform/x86: hp-bioscfg: fix OOB reads in hp_get_string_from_buffer()
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: Jorge Lopez <jorge.lopez2@hp.com>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 11:03=E2=80=AFPM Muhammad Bilal <meatuni001@gmail.c=
om> wrote:
>
> The escape-prescan loop uses 'size' as both loop bound and
> accumulator, so each match extends the bound and reads past src[]:
>
>   for (i =3D 0; i < size; i++)
>       if (src[i] =3D=3D '\\' || ...) size++;
>
> Snapshot the real char count into orig_size and loop against that.
>
> Also fix two adjacent issues: the bounds check omits the 2-byte
> length prefix already consumed, and utf16s_to_utf8s() receives the
> byte count (src_size) instead of the u16-unit count (orig_size).
>
> Tested on HP EliteBook 840 G2 (Fedora 44, Linux 7.2.7).

...

>  int hp_get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, =
u32 dst_

>         u16 *src =3D (u16 *)*buffer;
>         u16 src_size;

>

While at it, drop this blank line.

> +       u16 orig_size;
>         u16 size;
>         int i;
>         int conv_dst_size;

--
With Best Regards,
Andy Shevchenko
