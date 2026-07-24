Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7812535201B
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905319; cv=none; b=Bqg0r7IKpnTenAhfUOFrs2+n8vrrGEVZ2T9KnT1XnCVkgul9zUHV26GvkNQz+UwhBTU28r9rYSyXD1t2hEmHJEmm61pimyt35+t5Ii+amG8dPl80f5S7uyC4EKnAuZIeEZXFT5Mh/oHsDJ8E8Bs9u6uzwlK4tRXVQiR5stvja4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905319; c=relaxed/simple;
	bh=owV374+QFQEr3Tj7J5Y6lUqvZGJXWkkZSeOnSyhrYTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjwxr/9w/DSfOi1ui98eWvZdqzQM6YzPy6C47LfX+kPp6f4A9s26rzBuroaENET0DJu10erZ3h7//7IfglGxwgIKfq/BVLeJDfjW1KQdyMC4NOhZ0E1XbfBq6NdtuVX0/BTSAKTJOIJHtmYagqmkwsgggwq52KKQxbSiQMJdn4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G7yjscQg; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G7yjscQg"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5c2c0e261aeso143758e0c.0
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784905317; x=1785510117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RIgmCj66tNw1clv6mHU3c/fxIczuL5eauaO+8CdlWEQ=;
        b=G7yjscQg8h2uOP+mdY+iWSEmvU3NKnHQKeFkjKVo6g3NRXqohlyOQHsPk/CcazO6Zc
         /Fa8cmN/XO3XSWpV7zcTtqmBGXr/eBSbNaW9bHmuVGqr+NotFmW7jyBeScre8VMDba66
         3YVMu/sKG6AtsK263SljReMYlPLeHxN1rCxT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905317; x=1785510117;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RIgmCj66tNw1clv6mHU3c/fxIczuL5eauaO+8CdlWEQ=;
        b=JTVoiTYEELjZoIH+IEStalM4peqJH8J4z3KnmtcMA/rOAnB/Kw+vEh42aDbQ/zqB9c
         7sDwMzEPM9+TNZ9sEvcl99yIaZYuuRwSNKWti8pxsK3mlnfNjUjrUFX2Fnnu/8h7nOK4
         1WfCH0LAxX9Nlay3uX05xD0IEr76JSFge9dDqkx7ItjBLu3si7iks2VqICokrwXd9kPS
         aBxa3WFzUhZuEIfgKtLfCx6ztAyaM+tRclv666SOqlL8rYGgpBRnWWeO+j0mqQsKrW0X
         TSlyOpfR+8ojBbgJX7XKXZ0FEhwFOMMEfJ6qrDh0OLMNN5Mf5ODC12Eaunz9fBy6kLeA
         0Omw==
X-Forwarded-Encrypted: i=1; AHgh+RpoCrrzwzGuqwedu3qzblebJRzupMQZU4/xLPvpggl6sy1A9d4O2xjcnXdc8FXBRUsqPcrU6OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQzWJnKrsZ8OKdkL5TNwfLble78e2aWmAMNLk7lI/J7ZvVjGI6
	/kFJvoMV7xAlS+w9pnrguPjpjBl0wqKCz8g+X2gMqFE73jlST5MqyNE1zucqzDGlGvVZXYi6AOm
	y3u8=
X-Gm-Gg: AR+sD10/T9GxBH6xkK88a6SK9ZInC7pLgcCjXb0wrezsUHWjsNrINxyAeglPOVmXbbN
	f9yiL1fgXMiGx4IzcWu3a9l1yh/UtoqIdUjL1N4GuNADsRdSdAATs87GYIzTA+y6L47weM32c97
	cXKPgLnXSLC+j9xlW6g0AIdfXEoe6Ie6/da7OwI8urs6PYRMhlku26E1vY16EzFa9jHGp7UvAWA
	B4wByqQCSCaaWp55EWK15Z4Q+gt8GJAQTLCOHufLdY6HAM8KiKZbYaFeK03nA0QTHSvRBdomLIh
	IEpo4Rz6ViTn29K+TpM3Ba+9UJT+2TbhoeaZYizNoUcu98hKDHgKyZJrHcGoFDV+E+1mAq1m5qb
	ekr24gxgh6n3hq6+tiuIK4biTn4HPFBsNKLN9v2HM3NQB+eQHElT2Aao50sw+OZCR3nEzA7Ut8t
	3td7MaRKtJyHLgZr+ApS/jpD4WCtXTGhdzmFSbibMy
X-Received: by 2002:a05:6122:3a12:b0:5bd:9dbd:60bb with SMTP id 71dfb90a1353d-5c2da17126amr3474335e0c.9.1784905317289;
        Fri, 24 Jul 2026 08:01:57 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c2c6ad814asm8853020e0c.17.2026.07.24.08.01.53
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 08:01:55 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-96944741eaeso172331241.1
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:01:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqWta7IFI33fKdeI3S5etEyBXr8/PgGO5FxTUZRR/0QGx4/NtzpfS2IuJjbTXMziaR0aspG6rk=@vger.kernel.org
X-Received: by 2002:a05:6122:458b:b0:5bf:b500:c4fa with SMTP id
 71dfb90a1353d-5c2d9fad6d9mr3426249e0c.2.1784905311020; Fri, 24 Jul 2026
 08:01:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717143119.1815106-1-johan@kernel.org> <20260717143119.1815106-2-johan@kernel.org>
 <CAD=FV=X33HQcz3atmFzor2oLJzxzcRBJsnsSu_ewErduSxy0gQ@mail.gmail.com> <al3Sa-l3Hq9fxZJp@hovoldconsulting.com>
In-Reply-To: <al3Sa-l3Hq9fxZJp@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 24 Jul 2026 08:01:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V11GAw211Lz5cuUQ7B5GQQSGvxORPeBAMz7dsCd+2CDg@mail.gmail.com>
X-Gm-Features: AUfX_mz8FsFYort56Yg4BUHp4NJjirUzx8eymnJU0jTrPekxP4TnKisnoQZfF3k
Message-ID: <CAD=FV=V11GAw211Lz5cuUQ7B5GQQSGvxORPeBAMz7dsCd+2CDg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/panel-edp: fix i2c adapter leak on probe failure
To: Johan Hovold <johan@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 20, 2026 at 12:46=E2=80=AFAM Johan Hovold <johan@kernel.org> wr=
ote:
>
> On Fri, Jul 17, 2026 at 10:03:42AM -0700, Doug Anderson wrote:
>
> > > @@ -878,6 +885,11 @@ static int panel_edp_probe(struct device *dev, c=
onst struct panel_desc *desc,
> > >
> > >                 if (!panel->ddc)
> > >                         return -EPROBE_DEFER;
> > > +
> > > +               err =3D devm_add_action_or_reset(dev, panel_edp_put_a=
dapter,
> > > +                                              panel->ddc);
> > > +               if (err)
> > > +                       return err;
> >
> > Yeah, devm makes this so much nicer. Thanks for fixing!
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >
> > I'll plan to apply this, probably to drm-misc-next next week. Unless
> > someone objects, I won't land it -fixes because it's such a corner
> > case.
>
> Sounds good. Thanks.

Pushed to drm-misc-next:

[1/2] drm/panel-edp: fix i2c adapter leak on probe failure
      commit: e2a9e291275a74e309a21cbb1def6296a72d6aed
