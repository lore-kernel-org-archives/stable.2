Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A35641441F
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789402088; cv=none; b=Q8B4Pfgb6TemKXpKbFtIcEvTaohaKB1UBBkUwzEeouNPsAllX5GjZmFT5pxuLYdQbc12Mf/VPkj8K3uLqbhnCH0APIHX8YNFRcLh9h93NXRQJHUXBYfiuXLn2dNHf2YFgJwyO320ZprlRpC61i/2G0aivFwAFX5Ld9qdyUWWrS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789402088; c=relaxed/simple;
	bh=4JpqBF0U8ok2c1bU1R2ZgN0dtcOkgvd6/IXu/350qDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UKEsfi0ECfyKjDQUPa6kWNV7KHGwVHAweS1F1K4Ph04wxfmHdI7EUmGY5zVooGKho3gxAlCVBttw3i5ijBn2uVhywmy6A2/IYaDUnvOQV+q08VGkmP1JCgah+aP7H8BO81QvhyH7xA/qAp4mc/yGgeg3zK6iro2T1hbWHBMhbLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=HDPwWLLp; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="HDPwWLLp"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6b1ae6f5fc7so1308817eaf.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 09:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789402085; x=1790006885; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hhBnpIqJR8cSwH8SLHGlHrOYOv2zJDR1Rl7Ewp9l8a8=;
        b=HDPwWLLpGuYZ2na7MhghRHTLBi1EVyb9huFu2Q1Bu9Uw54EfNn78S/40m8nMU8QlWL
         TAKnhn2aJrnzwCEXuSdO0mmPh9K5I5uFcGQ6tCYcXZEwoXD1Z5YDIgtet9agxZYOn7Sq
         4oTNossulTMss2sU1BqlSsfuQVGh/l55kbFoMzH6N8J2A6oekdgZqcCyCFijqfdQNFyF
         HKYIn89clAHd6tbE1n2mAaqCKiQmlYjp1z2KN418wtS6HBsSJmB+BLEgLIEo3YSqhIDp
         dSi5pRE/n0MCzJiUL2Q5DIGa9b6xSuyftQ7GtnrZBCm5+EM85U0ccGVB34leabNXf28i
         6/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789402085; x=1790006885;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hhBnpIqJR8cSwH8SLHGlHrOYOv2zJDR1Rl7Ewp9l8a8=;
        b=T7eJUD7MTDI8TVlcsWmrOF2dSVSllp+ZOkhqM4cdxnrKxAvXyWOYFPattN+nBEIOuw
         /Mgy2pK8z0NsT7btZ+Xy0/x8tcLDU7eBd7CqA83/Cw2Un7/14UHUoFjGnPksR6hrd7zc
         hRdRgT9CgiGrYlBNlXjT2zPdy4fK+mXFAkF5rXuH3ua3WKgiBItem8Nu6RowTdOI8xbQ
         ZQ6A/40gH0DEfKhI9prep7hmBxMfG175KIpHsle1y5eQdwQqT6zwRv+BVCotbK+ohkJs
         orQMWnkjlz/+2gCd5YFD+Tx71LYTYn1Gh1A3AvgooHLu50GKi1TxjUuEIubyMfPsQpNG
         u5vA==
X-Gm-Message-State: AFuF++kXOFAY8KVa0tHLZ6CE23VBXde/HDVKXu9UQsgrepCDaB8QuX9n
	66uPxOwEabZ7O1ZJ9NjZUhzkUHj+nqmIdo9zduo1ikv6m2o8tj4oyNhE8i4xnh4FrYA=
X-Gm-Gg: AYBFou33INUkcgIZft2+zGwJ69EtpyPJ+wfOiCMoXRDtkq1Ewupi69jnDH+LrH3283z
	GqmCxHBSdS6ISftwdaBqsk7isOrTGHvsrfzJIGyKhrZgdnQEWfDXRpsxCV0WxWXDoFnqLwS1SkR
	qQ7RnCxkk7TzGGthECheX5I6c0MmM05z5u8Te/qUogKgVn+TOBxWO8xOq4Yp4H7d0ItES8f624J
	3AhF9cdm/2n+MXzJHmgX2e8Fd4xrMGYADIUCgTHUW9j2FNjJqKq/D38g+dQLSCS0shiAn9jMBy7
	l7j975ugwS/jA2K345IGHT1n/WNwC8j+bpm2rTYwtrHUZWBTiMq6iOXl7O9nyrgHUZ0LcQV5RhL
	f5nDKtFkCjVeEStwt/zCI8UGj3+80pahkklNFiMtS0N8w2Oldzw/8RSGj+RxF9YfRg/jiu8a29a
	d1tm+v5V698Y1JRQ9vD0C0Re6cZRYcREFyoDH9xKE5Uu8asrTAPhOofIU9RNZByRBp72smZ/OXw
	M6qX3+IdqifpYP0jqYgECetoYxa4DySlKp/VRHlijWTX6wo5g==
X-Received: by 2002:a05:6820:1988:b0:6c1:fd93:5292 with SMTP id 006d021491bc7-6c541d3ff08mr3216204eaf.17.1789402084949;
        Mon, 14 Sep 2026 09:08:04 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:d8f9:ae1c:d229:aec1? ([2600:8803:e7e4:500:d8f9:ae1c:d229:aec1])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c342ec1ff5sm6543816eaf.14.2026.09.14.09.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 09:08:04 -0700 (PDT)
Message-ID: <feea59da-055e-4faf-999a-c275f42a99a6@baylibre.com>
Date: Mon, 14 Sep 2026 11:08:03 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: dummy: free software device on configfs release
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Kees Cook <kees@kernel.org>, Daniel Baluta <daniel.baluta@intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260914115404.1691763-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260914115404.1691763-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/14/26 6:54 AM, Guangshuo Li wrote:
> iio_dummy_probe() allocates struct iio_sw_device with kzalloc_obj().
> The error paths free it, but after successful registration the normal
> removal path only frees the contained IIO device, leaving the software
> device allocation behind.
> 
> The software device embeds a config_group. device_drop_group() calls
> iio_sw_device_destroy() and then drops the config_item reference with
> config_item_put(). Therefore, freeing the software device directly from
> iio_dummy_remove() would free the embedded config_item before that
> final put.
> 
> Configfs requires dynamically allocated config_items to provide a
> release callback which frees the containing object when the reference
> count reaches zero.
> 
> Add a release callback to iio_dummy_type and free the software device
> there.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 3d85fb6f8104 ("iio: dummy: Convert IIO dummy to configfs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/iio/dummy/iio_simple_dummy.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
> index 19fcdbbc11c6..7d2ff1d4a06e 100644
> --- a/drivers/iio/dummy/iio_simple_dummy.c
> +++ b/drivers/iio/dummy/iio_simple_dummy.c
> @@ -23,7 +23,19 @@
>  #include <linux/iio/sw_device.h>
>  #include "iio_simple_dummy.h"
>  
> +static void iio_dummy_release(struct config_item *item)
> +{
> +	struct iio_sw_device *swd = to_iio_sw_device(item);
> +
> +	kfree(swd);
> +}
> +
> +static const struct configfs_item_operations iio_dummy_item_ops = {
> +	.release = iio_dummy_release,
> +};
> +
>  static const struct config_item_type iio_dummy_type = {
> +	.ct_item_ops = &iio_dummy_item_ops,
>  	.ct_owner = THIS_MODULE,
>  };
>  

Should we switch the alloc to a devm_ function instead to keep it
simpler?
