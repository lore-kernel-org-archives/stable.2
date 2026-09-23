Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AA24F7CA0
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790175792; cv=pass; b=VQgyVhkiw6alX0pwvTswSQJrBrGqwlaLUo9GV57e0OucwtyYePt2e96IYZ9OUH+X+eA/HeJlSYd9dsO6qNFBY2UyTpBfJFKzblY9dex5yhXAqF1mASkXLW/HqQQGByV/68ccb+Oy3RjtUejg3AHmtuvd0t+dTnCxwpJIqxcZHWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790175792; c=relaxed/simple;
	bh=VFFiy6i7m4Wf/VzuM6iynbm/hGQ5/lbbEMnpZ0Pnm8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+mETwYOlOcVVE1WxBXD34C0iw7GRMCy+UfLGlmgFkvOm6YJ/fgNtCdlyoop4Bw8vwo8BFgTupGIKRKtobRGvo9oJJeOnJzAZIGaXzd7/bGDNnZsSQpcRH5Jkjdo1b+q/NdRwbRDRBspaSzCg3pUIcBbhTYduj5MPLL7wRlGba0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxAAcclj; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxAAcclj"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-85d4ddd179eso13847557b3.3
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 08:03:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790175788; cv=none;
        d=google.com; s=arc-20260327;
        b=f4IhJ6+qYeK1LXjXDzJDhUNCxp1Fdy+RFwkKDDJm/XZtWMmdtLAz9z3jTRjFk3jrwg
         Y3a1TbJDxX/uSG1wPHWCtfs1x3MDL+McP25yMBZAzA5VywEB+MNnOmdK1XtAoTS+62lT
         EXttWLnLUBpZg/dEkjyfoG0IlYc07P4tQuyLZmw5JNG3Jf5nnr0N0jNAXVpU9CijE2pQ
         XTl1D6x1qgQWJwVPJmdim7spOxbyI3JYCZPmTuaa5AELO4fCWdE3yzD6WWczku51Au7p
         yT/Cl77oXIzna7Qm9oGkPnGGiWDOm893WYwVyI8h6Y/oKxt17NsiM7dZ7s7iwQ/3JDpl
         9GBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CqJL8NRcEhCu62ajFpIWbPm1dT9gXwOhcdUPy9nZD7Q=;
        fh=NCMU51xlDEeR1CiRrvtnq6t7fmzzNSl+EhiJc6YQr6s=;
        b=d0Rw3vHjKVFGZz4QVI57JaZrbhgQhqJd4l/Pw1hakWrzSGyM2VQ7csr+PtnZFXgQvo
         gfz09+JFfmb1WXi3MJtiWfIHTSHnXY5Rd6dUDbPMA2nqyiPt768/3oF3CM6BIQJmi/Ph
         J3/k0bpUkBLzx+26rW+It9XIhUZWrUbnZ6o8zRGxpBTjn7acYZFQZI4QI6AcwRZGOiA1
         exRDVS36Z+b2waF5dMZhysCR2U6V7u4ZWWScCFJvVvDoDI4/et8IO5bh2224agnBhKPD
         QKwCZCdbFwuvN6fj6A7eotya/2UFsuNJlvVdHl4FCe1mFoZLB7AFFTTt21xneQrD892R
         5XEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790175788; x=1790780588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CqJL8NRcEhCu62ajFpIWbPm1dT9gXwOhcdUPy9nZD7Q=;
        b=gxAAccljm/dzygN8M5Tz2lkdDl8h0J+Rwx5bOM6KXAUbSmFEsgpuoyz0QXiGAyih97
         OtDaxqDm5Rxc9/PULh/3CXQ+fTe+ONV80wpj3x01Zt+jQu4U3yMNEVKh/5oJS9bdLWxN
         LkZSknXdGVbpQ4ht0zjxlH/+ZNIIdUBJNs89j5QCroXr/EkY4305FCcVK4/OCwg/QxpF
         qlTqGQjSn31vjG37ncbwQec0nFCqSYOGItBreutZiiOXss99WyymvDxlevgsui+/7ko2
         tkhKSSJfd63INMVZAYRO9Sv0MRCTqOMjyyiI4oXkaEL7hsyh7sAXlfe2diOk9pLBNk9G
         9MKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790175788; x=1790780588;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CqJL8NRcEhCu62ajFpIWbPm1dT9gXwOhcdUPy9nZD7Q=;
        b=1LFm1UEfyD27qfWzJ08F5/JIf1zml7GX9nT6Oxov5jUqIdJ4oMhOaDgAwgVPbT+nEO
         8J7SFF+7NIJil01PP2yh2YCKhotmMopfYEqy1B5lZDru+N1yaV5fjHW2I2iChhO/fJgi
         I4OlxdeBPq9UWXfRKir7EC+RREJruec/YLfCw9NYtvuEqrsss6oQBIgdq54uQc0c8Ktf
         F/KyYyHcpp323SGWxxw+ZAsavuo9gkMrzB75JQpYFJNX2N95wyDnbRsEwE45+5bdhDED
         8jphDDLdRcHTrXUQNAT2PTvOw2guLS1oMlOVX8eRD/978I8dVBk+G9jt0UDfior8oEqt
         TB9Q==
X-Forwarded-Encrypted: i=1; AKwUvByS9Rr6uvZBVHewwWoE2Xt08R8OyXlIoix74JDeoL7XLm6TISmIaviFkjW/eCR49zDuWBgkLX0=@vger.kernel.org
X-Gm-Message-State: AFuF++l3sS1nL6EB7icuEoocZlK9wg6NcEeZTgyYqQg/egBfVBCvV6pJ
	uOV1J0x87XQcYMT375/msnF2QNts15sYLEKYZs+76Hj6+dq9QDdBKMshgvsoGpSFQo3zYfYkjOS
	SCRzgMJ7I36fKcE55oNtugjGeB7ljSKY=
X-Gm-Gg: AYBFou0/pGup7+MPmI4Ya3qST0vY9jr2o1XLIkF/w0FHpy5G6YCC9hKfpPA/83Kdnvk
	Swy4GVlMNuapjfpIui6fYqJKupV/lojtIedyQdGdTe01tJLy/LibDmC4QWXEB8bAGWY/J+c+OW3
	NIZZIn3PoXdMZmC5Ful/TDbTPD+ROg6AvVzLXxvdj6ZXyJc+d2EIl3Zr4Wm3gk3fLt9N5EkK2zn
	CA6aj43NB66Ji3myCrqIq5g5g6jdddSheGf+YEVIQnKJg3W+eQpnPafwnUaL+bHGK/pYuGqhGhH
	e9QR2Ue+hyQ2TJ8dfEdaliXYRX/ye6m/UZcfQnSjE/jFZWKusJdqT6P7
X-Received: by 2002:a05:690c:6d81:b0:89a:63da:cbe6 with SMTP id
 00721157ae682-8a45bc845c2mr20714107b3.44.1790175787877; Wed, 23 Sep 2026
 08:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920055519.3778269-1-lgs201920130244@gmail.com>
In-Reply-To: <20260920055519.3778269-1-lgs201920130244@gmail.com>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Wed, 23 Sep 2026 20:32:56 +0530
X-Gm-Features: AcwNN1XS281TkGjU9vWolr0hcpYOQfQwJrTGBAS6vDHuzDaOItqT-Qc8-tIEa4I
Message-ID: <CAKfKVtGZH8OaXp0WtJSD7AAQb8BSWg=xo+x9jj1sbjSxjEanGg@mail.gmail.com>
Subject: Re: [PATCH] EDAC/versalnet: fix memory leak on device registration failure
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Borislav Petkov <bp@alien8.de>, 
	Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 11:25=E2=80=AFAM Guangshuo Li <lgs201920130244@gmai=
l.com> wrote:
>
> init_one_mc() allocates dev with kzalloc() and registers it with
> device_register(). If device_register() fails, the device has already
> been initialized and holds its initial device reference.
>
> The current error path eventually frees dev directly with kfree().
> This bypasses the device release path and can leak driver-core
> resources associated with the initialized device. The existing
> versal_edac_release() callback is responsible for freeing dev once the
> device reference reaches zero.
>
> Call put_device() when device_register() fails so the initialized
> device reference is dropped and versal_edac_release() performs the
> proper cleanup. Return after freeing mci to avoid falling through to
> the direct kfree() path, which remains necessary for failures that
> occur before device_register() is called.
>
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>
> Fixes: d5fe2fec6c40 ("EDAC: Add a driver for the AMD Versal NET DDR contr=
oller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/edac/versalnet_edac.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.=
c
> index 3a06b41c1d84..db3bf5a1345b 100644
> --- a/drivers/edac/versalnet_edac.c
> +++ b/drivers/edac/versalnet_edac.c
> @@ -829,8 +829,10 @@ static int init_one_mc(struct mc_priv *priv, struct =
platform_device *pdev, int i
>         dev->release =3D versal_edac_release;
>
>         rc =3D device_register(dev);
> -       if (rc)
> +       if (rc) {
> +               put_device(dev);
>                 goto err_mc_free;
> +       }

There was a comment earlier from sashiko
 failure path calls put_device() with dev->init_name still pointing at a st=
ack
buffer before device_add() copies it. That's unsafe in
principle (dev_name() would follow init_name)
>
>         mci->pdev =3D dev;
>         mc_init(mci, dev);
> @@ -852,9 +854,9 @@ static int init_one_mc(struct mc_priv *priv, struct p=
latform_device *pdev, int i
>         device_unregister(mci->pdev);
>  err_mc_free:
>         edac_mc_free(mci);
> +       return rc;
>  err_dev_free:
>         kfree(dev);
> -
>         return rc;
>  }
>
> --
> 2.43.0
>
>
