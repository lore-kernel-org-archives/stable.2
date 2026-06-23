Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDA43CE4B6;
	Tue, 23 Jun 2026 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204636; cv=none; b=lkXUcifhSIFkaTU+VasON0rAk20hzGXLRqhFIVpoyTPx1RWHnSK2Asf4BcoU9XRPai3JWiH1bdXaXwfhK9SiHejZXHLYAklrMvcINp7JmCvdpAknWZJvk62NLfBPWBurVBHJt/6s0oY1H1YnWDwW7Xgq9G/Y3+CKHj5BjdJxQAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204636; c=relaxed/simple;
	bh=SIr2vDvs0AWleStmL6oPmKjHddGSAR4/MrYLpb8EbdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t9e/j+8skKXFgbsxRVK4NGd5VHtZ4v5K4QpW6DHTebIyGlYNty30WoQiojGRmDQbi5jAa0S++HhAu6i+4Konx7jPIGIeLH1/Metd8d0AYe17PWcIIDFQ6517IF/jkl3rWOhQxz84pIqVzY/vP0ZnVTFxDuPKHFIEy0vRrR1HpOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJwUnbGs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJwUnbGs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B971F000E9;
	Tue, 23 Jun 2026 08:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782204632;
	bh=cby/NkFpouS46q4pLc0mukueRXBfbwYvij9ZnBXdZJk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FJwUnbGshGsmEZiPKt4L8heL1ZngMD58ykqyg2wIhG0ALmRms2f04kxqt1LgYGbm5
	 pMcNTezmDe5DrjxGHtavu8hto4nfKjhij2KJPKea0NRsvuJVz4hLhDoLLyzE/xIIlg
	 Tc4gA/Vg/2UqmmeRmlECN38ogyXdWHgetWxCPfsivyuitYaBHAlcOD/2RMBteow12I
	 xgeSEtOdklphyfCLW/OIVCcc53i48V/tTP6QAsu1icCsCflmaFc4iq2BY1fU5leFLk
	 DSFYRLTr/uJ+KfEgaY8JfYpe1p5GL2jEv77uHuk8s04d/9blmUnfvW4/TIEP/fdv9P
	 0CU/Css1gbhHQ==
Message-ID: <2d51a6ab-2d1e-4fa1-9d06-24de1ed9badf@kernel.org>
Date: Tue, 23 Jun 2026 09:50:19 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: as102: drop device reference on probe failure
To: Jiawen Liu <1298662399@qq.com>, mchehab@kernel.org
Cc: hverkuil+cisco@kernel.org, kees@kernel.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <tmWO8aa9slCLa1R6aBLH7HXyONblpSZfVKYyTaxSL7PYmxsEXUkEpSfd7qvoeuPHxof-wx3-QqD1PoqkUddhOQ==@protonmail.internalid>
 <tencent_F35CBD76D113E494EEA8930320DCEF7B6506@qq.com>
From: Bryan O'Donoghue <bod@kernel.org>
Content-Language: en-US
Autocrypt: addr=bod@kernel.org; keydata=
 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
In-Reply-To: <tencent_F35CBD76D113E494EEA8930320DCEF7B6506@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/06/2026 05:39, Jiawen Liu wrote:
> as102_usb_probe() initializes the kref and takes a USB device reference
> before registering the USB minor.
> 
> The change named in the Fixes tag avoided freeing as102_dev directly
> after usb_register_dev() succeeds, because userspace can open the minor
> before a later probe failure and hold an extra kref until release.
> 
> However, the stream-allocation and DVB-registration failure paths now
> deregister the USB minor and return without dropping the probe path
> initial kref. That leaves the USB device reference held by as102_dev
> leaked.
> 
> Drop the initial reference with kref_put() after usb_deregister_dev(). If
> no userspace file is open, as102_usb_release() releases the USB device
> and frees as102_dev immediately. If a file is open, the final free is
> deferred until the last file release drops the remaining kref.
> 
> Fixes: 8bd29dbe03fc ("media: as102: fix to not free memory after the device is registered in as102_usb_probe()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiawen Liu <1298662399@qq.com>
> ---
>   drivers/media/usb/as102/as102_usb_drv.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/usb/as102/as102_usb_drv.c b/drivers/media/usb/as102/as102_usb_drv.c
> index a11024451ceb..ad6c5837f1d7 100644
> --- a/drivers/media/usb/as102/as102_usb_drv.c
> +++ b/drivers/media/usb/as102/as102_usb_drv.c
> @@ -405,6 +405,7 @@ static int as102_usb_probe(struct usb_interface *intf,
>   failed_stream:
>   	usb_set_intfdata(intf, NULL);
>   	usb_deregister_dev(intf, &as102_usb_class_driver);
> +	kref_put(&as102_dev->kref, as102_usb_release);
>   	return ret;
>   failed:
>   	usb_put_dev(as102_dev->bus_adap.usb_dev);
> 
> base-commit: 9e7e6633458362db72427b48effad8d759131c35
> --
> 2.34.1
> 

Your kref_put() is correct but, the jump labels should be collapsed down 
to a single return.

diff --git a/drivers/media/usb/as102/as102_usb_drv.c 
b/drivers/media/usb/as102/as102_usb_drv.c
index a11024451cebd..2e6c9b50ee5ff 100644
--- a/drivers/media/usb/as102/as102_usb_drv.c
+++ b/drivers/media/usb/as102/as102_usb_drv.c
@@ -403,13 +403,10 @@ static int as102_usb_probe(struct usb_interface *intf,
  failed_dvb:
         as102_free_usb_stream_buffer(as102_dev);
  failed_stream:
-       usb_set_intfdata(intf, NULL);
         usb_deregister_dev(intf, &as102_usb_class_driver);
-       return ret;
  failed:
-       usb_put_dev(as102_dev->bus_adap.usb_dev);
         usb_set_intfdata(intf, NULL);
-       kfree(as102_dev);
+       kref_put(&as102_dev->kref, as102_usb_release);
         return ret;
  }

---
bod
