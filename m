Received: from mail-ed2-f27.google.com (mail-ed2-f27.google.com [74.125.228.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77EB4AE131
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 22:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789596445; cv=none; b=aIfkVJAzB3Chp1XNWTmGJ2CtO3mDNuB70zSKh49+E30CfA9Ay//BLxLvc4bWws5qSeEBMxMRTjPfnbOpz0JrEKAKodDVoWMqjKy0G3PdbI9AjYrqijyEsrVjFO1SnDryD2eN1L/SczxqdmjC1QoW1I4yFLUpPJ8kSzyDftR21p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789596445; c=relaxed/simple;
	bh=lt3BikJB93Zkg8UHHA0fVUsHS8vy+oVkjtAS1xezz34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJ4HvWh9zYWjS8MJoVsfD4M7eT2DetFK3uPYamgORip1GYspwS/qG0Qb22fE+j5zNy572sBG7l2VwDfcIzQ9BJfLcKNazTI/o0h5IdZUlLZMn2qIhIrykxsbK1v8vLZ0P4Xr+ZgEtH1xThGnzDO9K4HZ0jK71d7YxQKDTLG5MaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GLgS4xk3; arc=none smtp.client-ip=74.125.228.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GLgS4xk3"
Received: by mail-ed2-f27.google.com with SMTP id 4fb4d7f45d1cf-6aa135d6e97so364249a12.2
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789596433; x=1790201233; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bRx2j1EfmgsLJaRhKgwq7WbmeY6pd50RmhdABMQZV3M=;
        b=GLgS4xk3XkW12Zm5GjPB8ifKd8UTHR2JfNHncScZlvGsMUJm4Uw19wFXBApD93N9yL
         ubjTU0klz2DgqJE4D8y2RScEfhqVaA96S3KRAOZ4KISxXxVVNcaCw4S0a8FesN5DzByM
         mag7oZYQJFnuwCbOnKeULDIhfl5SvO3kRNw4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789596433; x=1790201233;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bRx2j1EfmgsLJaRhKgwq7WbmeY6pd50RmhdABMQZV3M=;
        b=OyzeCe9qOO1v0bC56SNkmxhOjAc7EPI5Jp9cI8jePekZPOLMQ94+aAz50Ad6IygAC6
         +GvW9X1UYckcXmq5nugISEMZvXJpS/qElh8Ue6uhHsswFsXD4S2bU5Wl1AVoJfzsxc0S
         0KJROketO8b68Io9DWnrRDvnnV2PwjNgB0VvbWJpcOW0w6XUdrPprU4rfeOZ88n4f3tG
         lhvs3QXViTAE36ND8VLdTKdWrv2SzLn3IOOpXq7b2qwyeM/N0vFbNLX+CxtxOFb9NJv2
         L6QptrCuPuUeUx0rCM486xvR1/DVXwzzyy8LPOME7dECyPg4nkxSJsRGe5G3FM+dP6h1
         pyRw==
X-Forwarded-Encrypted: i=1; AKwUvBxd/76d0C1ixzatYj2EZGk/KMfzc5y+iP9YmNyJUzxEnboDzNpXWsFgnY0oz1FVN82iBQhr1jc=@vger.kernel.org
X-Gm-Message-State: AFuF++lmW1uuQD6piYCNqno26YfFUShh2wsvT5sHI5i/hUYHlBO+Vq1m
	lIgeKfwS1p1DLQUG2tGFRtMViardb7nelmNZfL3waZB9TBkIDMEfRAav2gX49wH1jd96aM9trmw
	uees=
X-Gm-Gg: AYBFou16S3iWf3JT+L5wqJbAX1n8pMztZUUQgdZoEDdvjqCKIf5SyjL5NCgCZgnKTri
	AnWF7C4BopEpEyFSDqGdlET0sQLvO2XSxq+Sw3tlHPI5fJnbV0nW73OaEL8FkPNyZOnnqaq2jx8
	2LJY5+16jocG/rRuE6lZsTqY0II8UMPDnKXOqlrSwwKsWV+uGSFK0UemJDTyiCr+0mgpA+aBIwZ
	fRo9UDr5DGIBhXxcQsoYQ1fBtkFKn6i6rPu0+n9RlBT9F23JhkbNAQll8blz8tmZK12wLvQYHLP
	Zk1XyFOqIXWxHZuVb2mR58JtHHtJGP/7cuYCQ6HPSflTg5JCv4Ld5w3pkQQqvV8JiR70RzwWeUH
	wiY/Cg1l/KvMoenb/kzBk+HyJtotkNjtabcINZPWrVUBk9ym+Yny/u3HBk+klW2doa+e0SEGd7b
	mSAcEr3UvA6H0NXBs+qRfVbMYn/C1QBc6kJO5kMJK7LvGcPEr6+7HViUaxfQliF9K+LqpProNHe
	nypOyYD0OhQKtOr8NDCsVxecXopXNU2dZ65oFk=
X-Received: by 2002:a05:6402:5d1:b0:6a6:32f5:90b4 with SMTP id 4fb4d7f45d1cf-6aa2245178emr7139228a12.22.1789596432801;
        Wed, 16 Sep 2026 15:07:12 -0700 (PDT)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com. [74.125.225.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa1d2727bfsm2245101a12.20.2026.09.16.15.07.09
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 15:07:11 -0700 (PDT)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so1276025e9.2
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:07:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByBM6Z1kgsx91TSJ0ruxF7MNZ7z8WZ9D6jMLuteWlO0AspFm1vyoBb4uGqignFWLT5fjAR0Fq8=@vger.kernel.org
X-Received: by 2002:a05:600c:3b0c:b0:49f:bc28:e8b1 with SMTP id
 5b1f17b1804b1-49fbc28e978mr56379705e9.14.1789596429113; Wed, 16 Sep 2026
 15:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916155730.2077434-1-vulab@iscas.ac.cn>
In-Reply-To: <20260916155730.2077434-1-vulab@iscas.ac.cn>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 16 Sep 2026 15:06:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WU7yOQWBW4SEMcHTwXxvNTMqO4P0DABaeQ6mBw7h=+Bw@mail.gmail.com>
X-Gm-Features: AcwNN1W4bKNukAgg1BwCpMhcUy96SsDz__HwTsvy2JJtukIrTrTDwRV8nOIqNGU
Message-ID: <CAD=FV=WU7yOQWBW4SEMcHTwXxvNTMqO4P0DABaeQ6mBw7h=+Bw@mail.gmail.com>
Subject: Re: [PATCH] i2c: of-prober: Fix device node reference leak in i2c_of_probe_simple_enable()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andriy.shevchenko@linux.intel.com, angelogioacchino.delregno@collabora.com, 
	devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, wenst@chromium.org, 
	wsa+renesas@sang-engineering.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 16, 2026 at 8:58=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> wr=
ote:
>
> of_get_compatible_child() returns the child node with an incremented
> reference which the caller must drop with of_node_put(). The error
> paths release it via the out_put_node label, but the success path
> returns without doing so, leaking the node reference.
>
> Release the node before returning success.
>
> Fixes: 897261149d25 ("i2c: of-prober: Add simple helpers for regulator su=
pport")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/i2c/i2c-core-of-prober.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/i2c/i2c-core-of-prober.c b/drivers/i2c/i2c-core-of-p=
rober.c
> index 6a82b03809d4..603de487ee2d 100644
> --- a/drivers/i2c/i2c-core-of-prober.c
> +++ b/drivers/i2c/i2c-core-of-prober.c
> @@ -354,6 +354,7 @@ int i2c_of_probe_simple_enable(struct device *dev, st=
ruct device_node *bus_node,
>         if (ret)
>                 goto out_disable_regulator;
>
> +       of_node_put(node);
>         return 0;

Sure, looks fine. I guess alternatively we could use
'__free(device_node)' for cleanup, but it doesn't seem critical to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
