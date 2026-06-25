Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C965375AAB
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 08:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782374788; cv=none; b=YcwWzpsgGkYsmnlnimCOv66lqbqqrDpUjg9NktL+Q6JpJAre454Po5YlZ8ATbeXl88zmFaruDuk0opyqjGiLgOi0icsHFssQAEBY1cRs4YKlp33J3e/+w+RyLgXMNX2vbl/f8ypZ9cxiWXEHvspdUAIciIEE2+3KC9m5N57o8WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782374788; c=relaxed/simple;
	bh=KpLJEsuPBG0Uw22ZXABHSCbqBzaYkFh4xxWwQt4c+Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuKr2i5Sb3DD5jEr9zWubXtWnilN9Tl+7O9mykZYBHsdj2b9N4IDYRq358qkJwJF/iy94VN9rMrg9Rqmw0wnjFPCEEonDVhkkUV1SRbcakwNOf9JC/kgCX97LNjbP5Ca9VHNsXTc4lYa5EDFjHtz1Vdulp4S10YkHZbAor/p7jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMXirtzd; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMXirtzd"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c07c246ad7bso276212766b.2
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 01:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782374785; x=1782979585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Zxo7YEDpTK4pGpTb+UxYvgaAHrfprADSVL2M5xU7uc=;
        b=OMXirtzda8djGQDAjfTS3U7THhSQF/dzxVfOrFHKDRYC4eaKkmsj5PFiNmb/PM5v7g
         JgWNHm+SCq4O6+OYMXZWZtKJCpTCCeg24KmANZGllH3Uf4C0zIMVV+EdTBEuNh96XeQR
         NmwkdU4VpRRYHp4S6sIrluybKDtOISvGfbbhsNqgdwXgIWnzRAClkHrOtX/06RSnSJ1P
         cjXTFprs/XtKYT+9by8HEA7VJW1IzxRKJIggfOJVYs3IZ9wd0ZkZct+5Te6cSYuJd4gv
         9Rkj5q4HG/+l1JkkHvomRz6btOvM5Kt0ijNHVZ2YLJaveDIieg2a/63i8Pn0oXC2Iz+k
         zhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782374785; x=1782979585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Zxo7YEDpTK4pGpTb+UxYvgaAHrfprADSVL2M5xU7uc=;
        b=MEGIPfcLr2DKoqluhIC0rXQ4XbISN1jvItanOSeoEYTkIpozNJMauAhF0/Zq30RC7H
         1J62bDWDwQ2dX+QjvXgeoFdJBAgq8eJvFffeFdawza7xRg++aFIhy2Po4K4giCMYhXYF
         x2BcCOGq8JqwG3PV9hncAzo6mw8+eHwhYKoTiOd7xl0VaEeeHLlu1AcURpfxwOrVctjr
         Ble3aUbC5MF5lyjudABqbD+i58MWcSht4opJb39kcbkvXLGzi2ViPtH/KtMm0PI3zTAT
         3YHH+kZwuOJq9IlzIMIme31/A1wzA7DWwBudE/g+PjzKXn09NBTgk1TqhnouwnAmh5yq
         OJxw==
X-Forwarded-Encrypted: i=1; AHgh+RoOEERlGNeac8sKxFA6eiWHtp/8pcb42Fssp1Cj+n8ZvuyPbptn9n0kwJLJQY+fcG53WMrim+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YysKR2F+Z36FimbiXqGwmZFKIgP/yaIjTylnALb46woTF+uvKJ3
	FLxq0l1Q/iDbL8BP2BTuci0TbgROqKlvmO9VO+1wwtqxURyQg6eoCSKk
X-Gm-Gg: AfdE7ckJWwC/kkMPd7n2C5RCbqTbEJWzoeuir/bLC6Wmn1IJxl9aiG3OzjUy9hK77L5
	AC1E5G+GBZ1RVB1w5If24VTbHp8aiUG7brwSIDTgeM/e32d7c/ZssVylEuTvbC4Rp+e0AQ0QaTX
	MR8JJDsZhjcg6UiITpHIZEiMHUPOK/sZZFJggnsUHJOAIEo8nvkBo0i0w1C+iKOIKeUl88p2G+S
	Yby5zjCIqKPGCLm+uhWLDPVQ2bwdrKrm3e15JL9eaSfTWDT5GeWckuq+VVegvS6XiZCzOv28G02
	ohjgya/4xBKnoxV2OxxXB8YGK5F9RhRKRtRWf9bHSvaAM39hG9gq5Grvct/vgCPhM5ylob4JY4u
	QX7sv3p3b1oCkZ0+gU+WZmFC030Q2L4y1+TWAvKtKFtihf9CnQfHDXd3VRLzsq2lFvv39JMNmBx
	TDn5onbf9D
X-Received: by 2002:a17:907:f496:b0:c04:93d7:3c12 with SMTP id a640c23a62f3a-c1205ef27ffmr86238466b.25.1782374784710;
        Thu, 25 Jun 2026 01:06:24 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbe05b6dsm124688066b.37.2026.06.25.01.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 01:06:23 -0700 (PDT)
Date: Thu, 25 Jun 2026 11:06:20 +0300
From: Dan Carpenter <error27@gmail.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, yangyingliang@huawei.com,
	mst@redhat.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: virtio_bt: fix cleanup paths
Message-ID: <ajzhfEu761GXHlqQ@stanley.mountain>
References: <20260625020159.3446736-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625020159.3446736-1-haoxiang_li2024@163.com>

On Thu, Jun 25, 2026 at 10:01:59AM +0800, Haoxiang Li wrote:
> virtbt_probe() registers the HCI device before opening the virtio
> Bluetooth device. If virtbt_open_vdev() fails, the error path frees
> the HCI device without unregistering it first. The probe error paths
> also leak the virtio_bluetooth structure after it has been allocated.
> 
> Rework the probe error handling into an unwind ladder so each failure
> path releases the resources acquired earlier. Also close the virtio
> device before unregistering the HCI device in virtbt_remove(), matching
> the cleanup order used by the probe failure path.
> 
> Fixes: afd2daa26c7a ("Bluetooth: Add support for virtio transport driver")
> Fixes: dc65b4b0f90a ("Bluetooth: virtio_bt: fix device removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
> Changes in v2:
>  - Rework virtbt_probe() error paths into an unwind ladder.
>  - Free vbt on probe failures.
>  - Reset the virtio device and unregister the HCI device before freeing it
>    when virtbt_open_vdev() fails.
>  - Close the virtio device before unregistering the HCI device in remove().
> 
>    Thanks Dan for the suggestions. The blog is very helpful.
> ---
>  drivers/bluetooth/virtio_bt.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
> index 140ab55c9fc5..4ca9b76f6410 100644
> --- a/drivers/bluetooth/virtio_bt.c
> +++ b/drivers/bluetooth/virtio_bt.c
> @@ -311,12 +311,12 @@ static int virtbt_probe(struct virtio_device *vdev)
>  
>  	err = virtio_find_vqs(vdev, VIRTBT_NUM_VQS, vbt->vqs, vqs_info, NULL);
>  	if (err)
> -		return err;
> +		goto err_free_vbt;
>  
>  	hdev = hci_alloc_dev();
>  	if (!hdev) {
>  		err = -ENOMEM;
> -		goto failed;
> +		goto err_del_vqs;
>  	}
>  
>  	vbt->hdev = hdev;
> @@ -383,23 +383,28 @@ static int virtbt_probe(struct virtio_device *vdev)
>  	if (virtio_has_feature(vdev, VIRTIO_BT_F_AOSP_EXT))
>  		hci_set_aosp_capable(hdev);
>  
> -	if (hci_register_dev(hdev) < 0) {
> -		hci_free_dev(hdev);
> +	err = hci_register_dev(hdev);
> +	if (err < 0) {
>  		err = -EBUSY;
> -		goto failed;
> +		goto err_free_hdev;
>  	}
>  
>  	virtio_device_ready(vdev);
>  	err = virtbt_open_vdev(vbt);
>  	if (err)
> -		goto open_failed;
> +		goto err_reset_vdev;
>  
>  	return 0;
>  
> -open_failed:
> +err_reset_vdev:
> +	virtio_reset_device(vdev);

I'm not sure that this reset is necessary.  I suspect that it isn't,
but I don't know for sure.  In a situation like this, I'd probably
err on the side of only fixing things which I know and leaving the
rest as a leak or whatever.

Otherwise it looks correct to me.

regards,
dan carpenter

