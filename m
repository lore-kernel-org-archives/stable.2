Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BC2352C52
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780940835; cv=pass; b=JY0nQKkEEnX93pmKw/QNs8SXXPy17IhDTpOl2VMSI0lKl3wDBP3BszVvtsemviuOfj67Z/mlAcFy1W1BkgptqhMR+B10htm4beuC6awuqNjmLPmSH1DZtRkEpPKk+vowzFIEvxH7w2i8oZxzvmOgHGpF/f2fHg7Thz9hy6WQZB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780940835; c=relaxed/simple;
	bh=qHOSN3CiBXYnjZS3fMmxWOq5WSeYJzuNKPvw/847FmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmGUqfhz8J2Kzyhxb1KD4vY9bHImg/x9uI2oo5qQ3Sk5IRmLiq12KTzkwvcKQ7b0Z5gWPlkzJYKr7rVHnsiJhYKdU4hB9CLaGdKRjlFUQpFJX3JFdnYCCE9gEnBQOodRtqLmrNuF1naR7o2QvhbYdbNYKSyGfDxuzVxpeI2040c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kKQQBAck; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kKQQBAck"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69170548d0eso2933994a12.2
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 10:47:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780940832; cv=none;
        d=google.com; s=arc-20240605;
        b=FB+wLjcYHt2N3VSfGkfoAWPiGp/WBi77lr/NvpyoQRbZ4Sqhfl238nocWK9LfZstUV
         e8bFI9RyVeufCmNttRQuGt6xpN6wCLW+fv1YBDRbAkyFBgAxFmTlchRnFKCeMSeKfnDe
         0N8f2jLp+HofVNZEbhyiIXnB924Kfhd8MsplZV4HFCllEbApOXCOipwBKTQygLcwAeou
         QA9aQmG1Px1uqNazqDPe/lcZ+j45z79ErVphwNiuiDRkc+Hc7EDAi2x1GSEVj88ILgd8
         +8qqTZFrpHGqu4zMqzBo1jn98UsqRnNVln+x0o3QkAIX6f6DoJOt4TTVNgBYA7+Wmngk
         2y/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eOXE8R0rs9hWTG1f22gZq63lJX1nC2oAn7YRODWgoMM=;
        fh=1MZufvQHaGiQfyx/jBJ5/ikAFwsl5KymjjMx4Z0V9Dw=;
        b=VMLcI3/NtC3fE07+PlD6vNiKetqPNnxTrjUaP4ZhgF4mS8jgx54DjiIRKN+7s2Jb2i
         ayy4TDWOecjlg2NWA61iTdv0ASCA7FlbBdvpcdD4PekuvwPe9TOuwAVkquA3bghu3feh
         vzH5Xchcj+wM1SqdsJFVw5ru95DjvWX3+rkQy/4R7j1bwJMFc6H1T5645iAzFEhe/fDq
         HJoEnW3SimttI/mQGvQ4bkl5YC5ZBrssDWvoGp3clVoJewSrzs3SiWpa0vBZ+//SiZF1
         R0ZglqqRD8uEqdDCRkdfCAgflekKUrtideOhbZkrLnwyc9iq7e+qWMhkh8eVkij7CDj6
         m55A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780940832; x=1781545632; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eOXE8R0rs9hWTG1f22gZq63lJX1nC2oAn7YRODWgoMM=;
        b=kKQQBAckVZfId/WGRPH7EqFTUEym6KmDN02Nn//YQKgx/vFnkEK2tiK7P37qxt8iMU
         6Qt0murv16JIpWjiq+3Qkd6sr9g+UX95IblxhPNr+omyE/e36k/iPXWnoG5ZVZCqRL9Y
         v6mWPU9bf0WSj3qBOM4pNWnwq3eR9VUKN49A3sZKHO5VvXHH3SGjA4xh/i8ovCX2A/AZ
         nI/D7wcJrk7tULzEuRbA0+pl5defrozQJuCmMVviHehEpx5mw0z342mN+H2FG0qUzhUp
         1BCbAe21d9t4epdcfRR9T7+PvSWAnQclRzHBbJbCji2h3+BUi+kxVFPGMQqKBcytC7xl
         nadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780940832; x=1781545632;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOXE8R0rs9hWTG1f22gZq63lJX1nC2oAn7YRODWgoMM=;
        b=L9nhhvY8+yDHvahjzjDlGTkZQj6Sx+zyFg/Z+SUw18GvOWPlGe5hBk37OJh/f9kdJv
         GehtuVXQP568SGAFZ3daH/KG22fP7LKgJ1anPY8RcnQzzg7OjxgYVDRd5hyqCFXZ56SX
         7FpAQI6NvYzffT9fHti0JeEpXZI2Y2YVR6Kpp+QYTxVLVZHjGg1LvE2lQrp01zfXG0PS
         csGmx9x8fAndvp1TQRPpOYT8aWjwV3reJD7X2WvZpe+T0q8eD6U28QVjXfiLYT42jgLZ
         JtOmkWGBr036twP70CuT3W4owC2k0U7qTqxMfQ4HztjRU9KpcZ3UpMK5O0ILaaSfIdBp
         AXOg==
X-Forwarded-Encrypted: i=1; AFNElJ97DxvalycqPIPQ/i3Tdu3JO5XHyKU8qiDjDXMIZnroYytJkeSVOfnKvE7Xg+96kfNEXbHc67Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAoFvdZSks35kp63TrddawWzGzalltNkM03ZyAI/DIttm1mXD7
	6CfAdZzLqT6DP319/oLIDL0nDrsmFdPc6Hn5RTG6FHOaZW0zD6MWeflcMR6RQ7hg9+6/Iihj2Kp
	rcVEJBN63UJPyoJ7GP5MSPWEYjQJRT6c9swCWvWkaiw==
X-Gm-Gg: Acq92OEwuDulknyi6RJeBOWMWivuGgNRPvT2lzy0Ueaf7cXRk423DxsPgnvs2t734va
	f0RbLOdGQXpBtKk71PqpgbCtOTrfk5npWMZjrXQUwgl40vo3apH+fq75LcpWIrzXVLwUjNRx5fp
	knggk6omfy3rZV7l4cJu/OGsJQzm8v/situwG+JXyOUaSRytfUs6Jn2kaw/w5xWfI0ipkH5Pe7U
	C6eUSZfQm22RnKRj0Pxxbvit26tu1NtvcZHWTYIgANdlrn8olW4PkGGqfN6xNvpbU6ofujrNPJh
	TV5o52PB2+d++ixVdRNFUadGNas0xLhTugXnU1tcTsVjIsO66/x6
X-Received: by 2002:a05:6402:847:b0:68e:4c0:f5b1 with SMTP id
 4fb4d7f45d1cf-68fa4c00598mr6979387a12.2.1780940831827; Mon, 08 Jun 2026
 10:47:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602160829.560904-1-runyu.xiao@seu.edu.cn>
 <20260604035239.1711889-1-runyu.xiao@seu.edu.cn> <20260604035239.1711889-3-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260604035239.1711889-3-runyu.xiao@seu.edu.cn>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Mon, 8 Jun 2026 11:47:00 -0600
X-Gm-Features: AVVi8CfoZLiHBf9aDuZ4wDa8jT-va5Ux9POcpJ_j1yJw8B2FcWKwCD0yeZ72G4c
Message-ID: <CANLsYkwa9STAfcBxhgMVCEOWwmBVBx=fW+XwZrRUR07eeY6KjA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] rpmsg: core: use generic driver_override infrastructure
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
	driver-core@lists.linux.dev, linux@armlinux.org.uk, andersson@kernel.org, 
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, longli@microsoft.com, nipun.gupta@amd.com, 
	nikhil.agarwal@amd.com, linux-remoteproc@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jun 2026 at 21:52, Runyu Xiao <runyu.xiao@seu.edu.cn> wrote:
>
> RPMSG still keeps driver_override in bus-private storage.
>
> That private pointer can be updated from the sysfs driver_override
> attribute, and also from rpmsg_register_device_override(). Both paths
> replace the pointer and can free the old value.
>
> However, driver_match_device() can call rpmsg_dev_match() from
> __driver_attach() without holding the device lock, and rpmsg_dev_match()
> still dereferences that private pointer directly.
>
> This leaves the match path racing with concurrent driver_override
> updates, with the usual risk of comparing against freed memory.
>
> Switch rpmsg to the driver-core driver_override infrastructure. This
> removes the private storage, uses device_match_driver_override() for the
> locked read in rpmsg_dev_match(), and converts
> rpmsg_register_device_override() to device_set_driver_override() so the
> in-kernel override path uses the same core-managed storage. With that
> storage now owned by struct device, drop the remaining rpmsg transport
> release-path frees of rpdev->driver_override as well.
>
> Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kernel.org/
> Fixes: 39e47767ec9b ("rpmsg: Add driver_override device attribute for rpmsg_device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
> drivers/rpmsg/qcom_glink_native.c |  2 --
> drivers/rpmsg/rpmsg_core.c        | 41 ++++++--------------------------------
> drivers/rpmsg/virtio_rpmsg_bus.c  |  1 -
> include/linux/rpmsg.h             |  4 ----

For the bottom 3:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  4 files changed, 6 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index e7f7831d37f8..11d3007db5cd 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -358,33 +358,6 @@ rpmsg_show_attr(src, src, "0x%x\n");
>  rpmsg_show_attr(dst, dst, "0x%x\n");
>  rpmsg_show_attr(announce, announce ? "true" : "false", "%s\n");
>
> -static ssize_t driver_override_store(struct device *dev,
> -                                    struct device_attribute *attr,
> -                                    const char *buf, size_t count)
> -{
> -       struct rpmsg_device *rpdev = to_rpmsg_device(dev);
> -       int ret;
> -
> -       ret = driver_set_override(dev, &rpdev->driver_override, buf, count);
> -       if (ret)
> -               return ret;
> -
> -       return count;
> -}
> -
> -static ssize_t driver_override_show(struct device *dev,
> -                                   struct device_attribute *attr, char *buf)
> -{
> -       struct rpmsg_device *rpdev = to_rpmsg_device(dev);
> -       ssize_t len;
> -
> -       device_lock(dev);
> -       len = sysfs_emit(buf, "%s\n", rpdev->driver_override);
> -       device_unlock(dev);
> -       return len;
> -}
> -static DEVICE_ATTR_RW(driver_override);
> -
>  static ssize_t modalias_show(struct device *dev,
>                              struct device_attribute *attr, char *buf)
>  {
> @@ -405,7 +378,6 @@ static struct attribute *rpmsg_dev_attrs[] = {
>         &dev_attr_dst.attr,
>         &dev_attr_src.attr,
>         &dev_attr_announce.attr,
> -       &dev_attr_driver_override.attr,
>         NULL,
>  };
>  ATTRIBUTE_GROUPS(rpmsg_dev);
> @@ -424,9 +396,11 @@ static int rpmsg_dev_match(struct device *dev, const struct device_driver *drv)
>         const struct rpmsg_driver *rpdrv = to_rpmsg_driver(drv);
>         const struct rpmsg_device_id *ids = rpdrv->id_table;
>         unsigned int i;
> +       int ret;
>
> -       if (rpdev->driver_override)
> -               return !strcmp(rpdev->driver_override, drv->name);
> +       ret = device_match_driver_override(dev, drv);
> +       if (ret >= 0)
> +               return ret;
>
>         if (ids)
>                 for (i = 0; ids[i].name[0]; i++)
> @@ -533,6 +507,7 @@ static void rpmsg_dev_remove(struct device *dev)
>
>  static const struct bus_type rpmsg_bus = {
>         .name           = "rpmsg",
> +       .driver_override = true,
>         .match          = rpmsg_dev_match,
>         .dev_groups     = rpmsg_dev_groups,
>         .uevent         = rpmsg_uevent,
> @@ -560,9 +535,7 @@ int rpmsg_register_device_override(struct rpmsg_device *rpdev,
>
>         device_initialize(dev);
>         if (driver_override) {
> -               ret = driver_set_override(dev, &rpdev->driver_override,
> -                                         driver_override,
> -                                         strlen(driver_override));
> +               ret = device_set_driver_override(dev, driver_override);
>                 if (ret) {
>                         dev_err(dev, "device_set_override failed: %d\n", ret);
>                         put_device(dev);
> @@ -573,8 +546,6 @@ int rpmsg_register_device_override(struct rpmsg_device *rpdev,
>         ret = device_add(dev);
>         if (ret) {
>                 dev_err(dev, "device_add failed: %d\n", ret);
> -               kfree(rpdev->driver_override);
> -               rpdev->driver_override = NULL;
>                 put_device(dev);
>         }
>
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index 401a4ece0c97..d9d4468e4cbd 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -1626,7 +1626,6 @@ static void qcom_glink_rpdev_release(struct device *dev)
>  {
>         struct rpmsg_device *rpdev = to_rpmsg_device(dev);
>
> -       kfree(rpdev->driver_override);
>         kfree(rpdev);
>  }
>
> @@ -1862,7 +1861,6 @@ static void qcom_glink_device_release(struct device *dev)
>
>         /* Release qcom_glink_alloc_channel() reference */
>         kref_put(&channel->refcount, qcom_glink_channel_release);
> -       kfree(rpdev->driver_override);
>         kfree(rpdev);
>  }
>
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 5ae15111fb4f..1b8bb05924af 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -374,7 +374,6 @@ static void virtio_rpmsg_release_device(struct device *dev)
>         struct rpmsg_device *rpdev = to_rpmsg_device(dev);
>         struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
>
> -       kfree(rpdev->driver_override);
>         kfree(vch);
>  }
>
> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
> index 83266ce14642..2e40eb54155e 100644
> --- a/include/linux/rpmsg.h
> +++ b/include/linux/rpmsg.h
> @@ -41,9 +41,6 @@ struct rpmsg_channel_info {
>   * rpmsg_device - device that belong to the rpmsg bus
>   * @dev: the device struct
>   * @id: device id (used to match between rpmsg drivers and devices)
> - * @driver_override: driver name to force a match; do not set directly,
> - *                   because core frees it; use driver_set_override() to
> - *                   set or clear it.
>   * @src: local address
>   * @dst: destination address
>   * @ept: the rpmsg endpoint of this channel
> @@ -53,7 +50,6 @@ struct rpmsg_channel_info {
>  struct rpmsg_device {
>         struct device dev;
>         struct rpmsg_device_id id;
> -       const char *driver_override;
>         u32 src;
>         u32 dst;
>         struct rpmsg_endpoint *ept;
> --
> 2.34.1
