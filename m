Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4748419046E
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259337; cv=pass; b=nCOO9zdIgSszZoiOP07IVO59ScpqKGv3kHPYI81BouuAOqZF3YcBlYXVp0ymln4+JTxthXLvsqXbqj1nnS/4uVNpvxQ75mGTK9PWAeuHYGwjdvybXB06L8/PULYk3b6oeDfIOcsWyCfyfkrDlRUr3XKbDmhp2+QLp4S8m3/WhYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259337; c=relaxed/simple;
	bh=fwqbiIvV2P3fJebB0UiNrrEc0OEvVKiw/rH/H2+mMoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WehXGEkcgs6HeWPEvc3QMyG7KcKPo25UUKflFWDQ8IoLh0Hvnx5jNPgE3jXjL2NHJrn3gz1Oo0mle7Lc+YKQWxYMHz2ve/tNT7PexgEnp+/AU7EkgnGvugi6kTl3D0uISqD9rYjSBzN8imJoAg5u9awP1A1SSy2WpiIfTzabmMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3K3d5kP; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3K3d5kP"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab201ebso2214941d50.3
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 07:15:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790259334; cv=none;
        d=google.com; s=arc-20260327;
        b=bDtb4MsMuaECiz8Vfzu9uhKZeDJolfGEBC5gVhUd0+aZvw6gqm5IDtIrEtnUySbA/H
         4qlUm6YDdMQ7F2GuWlghQWm9cm8F9vK5oT7ZU7JAwODeRoaQpu6oyAUqimdiG81l38S1
         TL9gRJ/FXnb64dmWBWaBoeSXs/9h37u2HRmHiayvE3ytxqHRWJip/TXx7y+pnMrwTsLe
         gw3jLo4zI2CbHu31Czo53qWnryZJzZZfvyETUFzGc445mPFqzLIhBnfU+U89I8D4RTQ4
         G46GWEmQGvVLdV2BpHl2BVJbFAYwdXHLNVhHvxt4Td0+T1rVGHtMN8MVYa/U72Slbjp+
         tzbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VqwT+zeVYyyeJDz/W7VPDo/dJJgtgXoVFAXAXD+e99Q=;
        fh=EA/c3cj7i2pQs/O6Z39xbf7j3kGpNikCPApRkblqH/4=;
        b=TtKKEnQ4kZS2UcxOiUSy7iFE2tGk1zaLBW2Teyd5hoR/QDqHU2i0wl8A1/WGxsGqhK
         mxJVhtTrMmEUyisOYAHW5CmX+jiC4e6mphPd8sxVCMIZHgWIwMa7fS5yelsOaYviGzY4
         NTgspVcf6yU3qMwSEnWI3gW6B6wRR7oiiIoL0Pycwuob0RABPBycvn7budb9AfZqYPe2
         MmcP7s5Qr76zyz5XLW0iBE0ZbniRHpYKMb97iyJfKeUCfex7Q9BuPTOZ/0J46LewBz6R
         fiYcTedd3RVavnLIw5IOLITiCTVMk/Py7SSI5Gn2qlEpqPtAMcpBLtT0Siir+gPsSQjL
         tNQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790259334; x=1790864134; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VqwT+zeVYyyeJDz/W7VPDo/dJJgtgXoVFAXAXD+e99Q=;
        b=F3K3d5kPbEPHFwpEn6i8mTBzmoXMyGURRHUcDU8wjEdayPe7V1Utuisa3T8ae7Nv8N
         SZYxwe3zrR1iZmh71CUYjjbU8+HwmygCoeTjiqSidlwnWCZLb4h5bQv5mL9rv2dJ6+7S
         vnLtJwuBD2wQoH8LjlRo9+Wle8OMwnBkh/p1xfjAa2vLwA5ep8mShx4r62ByqsDyFStl
         ZZ735AynwZyVglkXjr55LyEJrd0Mg0AGReTg9AxlEQRk1EfPv6n7WbscetSgNx61jIHo
         CaitIcmt7eOqvAhhtsy3kBe+JIQCEYbQg/yJJ89aJkKfgbNp/glXOV4FyozaaLXJSl4u
         I+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790259334; x=1790864134;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VqwT+zeVYyyeJDz/W7VPDo/dJJgtgXoVFAXAXD+e99Q=;
        b=LXD9LGBPPUnBpykSGIGMGMSCUr6AtO1+4WKIpJ//WPLmxBLCXnaa8je8ufDboCZmna
         xbzARYYOJQQi/Ypv/kNFYWAsjgoTeSdY8sp/293C0mKXQiLGgwGG8nswmyp0esMQ1KdE
         tDrxEhOBYbJ0Wqd+knoIL2zD1GN2OEIB1DE0ZV8QL0dtyrGI6CZmkCuCXqhga05fUCTW
         IaSL5J1riKD8E6RainAKxl7YIhThkKtr3zU4n5mi33P5KZktavqDv7GbdafRKakRbHWO
         YgH5LMBTU+FZe6N3s5hMAUCg7AlmnHquYQP0KkjQ8E1YNsE3U/qUJvlQRbyrd/sXrQ2a
         469w==
X-Forwarded-Encrypted: i=1; AKwUvBwtsG2oPeH6UtYJYnwOEHwMyRnvi/DOK2MguspRntdar/oz5z7C5kUovhVegCxlhn5Nbw0fu5A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCp8YxOi17DVVqzZUIDouSaRfp87kGhTQ4c+unxy0Nh8Auyc2a
	NuPShOPrCegKRSJvjw+WP+f0UHiXba9Qwofj9QVLEHNIP/jt+npTsdjEGIORe5rz51NoG7c78iG
	c+2jbwnxGn0vgoVojF6QbK3JyC5gQ6Zcnt8ruH/wkTUTo
X-Gm-Gg: AYBFou3iQnVYhSwseB60ovbXBQrGFQu4NMiezDq1ZMs6WP9CkuUqrCERr9PLBEcutOa
	gTzhMIvurdMuox5b1Sa5i8v8FoiQzCifhgaOdGdhetbr37+6EXYhg6ENK9sCW4s+aVRJMZJR6Ii
	Sdf1EFTKDjUbOfNE9wOpk5j8uAo7S1Pb6DY6fs/0A3BrmmzWZ2dcBB9B+MIMAkNq3fyFLHQTMVA
	XtRv5ropyfOAqQP48hGM48ZkNoo2tJmbISSH2Ju/TayVffs/pfmqZlXvVBPyGtLWQYgxhywzwhF
	lP97SF9BeCz13haguaJmAD+3GsfvFDw/+YpEwL1qEKXyEZigYOo3YC7lyw==
X-Received: by 2002:a05:690e:bc9:b0:671:3e72:de4 with SMTP id
 956f58d0204a3-672ed2a5798mr1189306d50.50.1790259334119; Thu, 24 Sep 2026
 07:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920055519.3778269-1-lgs201920130244@gmail.com> <CAKfKVtGZH8OaXp0WtJSD7AAQb8BSWg=xo+x9jj1sbjSxjEanGg@mail.gmail.com>
In-Reply-To: <CAKfKVtGZH8OaXp0WtJSD7AAQb8BSWg=xo+x9jj1sbjSxjEanGg@mail.gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 24 Sep 2026 22:15:23 +0800
X-Gm-Features: AclHuK-fZqbWgXfBotsQgsWCdm5fHoCRS2vmaG_pyD4sYaLoKbt6W1Kj9w7yy-s
Message-ID: <CANUHTR_yAgnZN05PBLae3DSk3xo0haLRRgHyKxswSYDE2tHgFQ@mail.gmail.com>
Subject: Re: [PATCH] EDAC/versalnet: fix memory leak on device registration failure
To: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Borislav Petkov <bp@alien8.de>, 
	Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shubhrajyoti,

Thanks for pointing that out.

On Wed, 23 Sept 2026 at 23:03, Shubhrajyoti Datta
<shubhrajyoti.datta@gmail.com> wrote:
>
> On Sun, Sep 20, 2026 at 11:25=E2=80=AFAM Guangshuo Li <lgs201920130244@gm=
ail.com> wrote:
> >
> > init_one_mc() allocates dev with kzalloc() and registers it with
> > device_register(). If device_register() fails, the device has already
> > been initialized and holds its initial device reference.
> >
> > The current error path eventually frees dev directly with kfree().
> > This bypasses the device release path and can leak driver-core
> > resources associated with the initialized device. The existing
> > versal_edac_release() callback is responsible for freeing dev once the
> > device reference reaches zero.
> >
> > Call put_device() when device_register() fails so the initialized
> > device reference is dropped and versal_edac_release() performs the
> > proper cleanup. Return after freeing mci to avoid falling through to
> > the direct kfree() path, which remains necessary for failures that
> > occur before device_register() is called.
> >
> > The issue was identified by a static analysis tool I developed and
> > confirmed by manual review.
> >
> > Fixes: d5fe2fec6c40 ("EDAC: Add a driver for the AMD Versal NET DDR con=
troller")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/edac/versalnet_edac.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_eda=
c.c
> > index 3a06b41c1d84..db3bf5a1345b 100644
> > --- a/drivers/edac/versalnet_edac.c
> > +++ b/drivers/edac/versalnet_edac.c
> > @@ -829,8 +829,10 @@ static int init_one_mc(struct mc_priv *priv, struc=
t platform_device *pdev, int i
> >         dev->release =3D versal_edac_release;
> >
> >         rc =3D device_register(dev);
> > -       if (rc)
> > +       if (rc) {
> > +               put_device(dev);
> >                 goto err_mc_free;
> > +       }
>
> There was a comment earlier from sashiko
>  failure path calls put_device() with dev->init_name still pointing at a =
stack
> buffer before device_add() copies it. That's unsafe in
> principle (dev_name() would follow init_name)
> >
> >         mci->pdev =3D dev;
> >         mc_init(mci, dev);
> > @@ -852,9 +854,9 @@ static int init_one_mc(struct mc_priv *priv, struct=
 platform_device *pdev, int i
> >         device_unregister(mci->pdev);
> >  err_mc_free:
> >         edac_mc_free(mci);
> > +       return rc;
> >  err_dev_free:
> >         kfree(dev);
> > -
> >         return rc;
> >  }
> >
> > --
> > 2.43.0
> >
> >

Would splitting device_register() into device_initialize(), dev_set_name(),
and device_add() be a reasonable way to handle this? For example:

diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
--- a/drivers/edac/versalnet_edac.c
+++ b/drivers/edac/versalnet_edac.c
@@ -64,7 +64,6 @@
 #define XDDR5_BUS_WIDTH_64 0
 #define XDDR5_BUS_WIDTH_32 1
 #define XDDR5_BUS_WIDTH_16 2
-#define MC_NAME_LEN 32

 static int init_one_mc(struct mc_priv *priv, struct platform_device
*pdev, int i)
 {
@@ -730,7 +729,6 @@ static int init_one_mc(struct mc_priv *priv,
struct platform_device *pdev, int i)
  u32 num_chans, rank, dwidth, config;
  struct edac_mc_layer layers[2];
  struct mem_ctl_info *mci;
- char name[MC_NAME_LEN];
  struct device *dev;
  enum dev_type dt;
  int rc;
@@ -773,13 +771,17 @@ static int init_one_mc(struct mc_priv *priv,
struct platform_device *pdev, int i)
  goto err_dev_free;
  }

- sprintf(name, "versal-net-ddrmc5-edac-%d", i);
-
- dev->init_name =3D name;
+ device_initialize(dev);
  dev->release =3D versal_edac_release;

- rc =3D device_register(dev);
+ rc =3D dev_set_name(dev, "versal-net-ddrmc5-edac-%d", i);
+ if (rc)
+ goto err_mc_free;
+
+ rc =3D device_add(dev);
  if (rc)
  goto err_mc_free;

@@ -800,10 +802,13 @@ static int init_one_mc(struct mc_priv *priv,
struct platform_device *pdev, int i)

 err_unreg:
  device_unregister(mci->pdev);
+ edac_mc_free(mci);
+ return rc;
 err_mc_free:
  edac_mc_free(mci);
+ put_device(dev);
+ return rc;
 err_dev_free:
  kfree(dev);

  return rc;
 }

This avoids keeping dev->init_name pointing at stack storage and uses
put_device() only after the device has been initialized. Would this look
reasonable to you? If this looks good to you, I=E2=80=99ll send v2 with thi=
s approach.

Thanks,
Guangshuo
