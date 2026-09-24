Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E91481664
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266376; cv=none; b=o++VXT2ebv/Bl6ZInn3Rob5RaX1deO18DTcQAR2QMUpq0V4Dn8bq2edlO/UtsA+Tpl9GehXAI5PtRvhZkwpN6myMom/EX2EtPESltxiZAg9AObT61qiJ1MnD8j/92cU2rugN2mjLn/O23ZSq5Kh1oRwiSvsxN67eJPMUpQplzjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266376; c=relaxed/simple;
	bh=kDYLFZJPxTJMzn8FmYfHN54E/Y+7dtsIoP5THCuRkNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/KY9bnn3G41PatUEx1gtYte2cdKptiLFX5kjlOqXFJiKWnzEOd/HMd5LUusFVKcubSiDe+AO7KMJqmcgxCm3jxiLeyon1oOHa4qQI3vQiZoMuuemPkM/MOm20/xf9Icnqoexab4fX5VhcBGlcnceNg+fNA9cF45Wcp8TRHqYKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/uvwxpu; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/uvwxpu"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469f20513so57693b3a.0
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 09:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790266368; x=1790871168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xGGTqz2aZKsHPcNK1Wt2KAGCnTv0BbXSbSraW+Q8OuY=;
        b=Z/uvwxpuIfJjm2CSjfE6ZbDS5iYLaIOXXTK6BV0B59uqXXxi5OChTUQKNFXx2Ccm/k
         yr+jw5NPY7pNmiQDlZPiO0j5K9LZvgRipmKiN4afra+XGc5TLVvsr528ODvtTtOujAmv
         EJ8Cz0e+tTunBVV0wi0fC4woUsGwN4luOATpKUVh+pzdObEuSEO3/nPr8E+X/UC/9Iwt
         uRPOfNFv/XxELWRzTpGZQTAwyftaZ+lWMTb0Em2KwWokatuKp1nUG7YXSjtyVOZKYEdY
         tKgmv5C6DDov2DNCxdnWTrR97dEsdUFkkQapX31XZTELSr01BrgpYzUbA7vpbJAkcdkN
         s3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790266368; x=1790871168;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xGGTqz2aZKsHPcNK1Wt2KAGCnTv0BbXSbSraW+Q8OuY=;
        b=IXEmdfFtzsvTmZwjMniAYalklygbWY1UWiZdc/b5e7WJYwdsFq85SyJZ14Of5tTNnh
         xgxqVp7Td9tcfTq0TtzpzTOoXx6cFxtFWubxzbyqvbLnSuPzZ+okoN2afYuTvmU8T/dB
         8EZyW3xL7h79negy8EGjWk6iiUL7BBiUTidkn5UkTD4Q/VFU5yKK+C6H19selF01a4hS
         Zp79IwesYMPVXbZFfSEjd2ac6nMFTX/1cvQGI/mYvV7zZ8PQ1sxD1rsIYSrJ3MpChk7l
         GWiDMHsXuoKzQNqXFvDBSUXaFZAbVoWKHD9P2w9WGcUtS41LJMiI8LL+fqV6mqHo1Qnh
         65lw==
X-Forwarded-Encrypted: i=1; AKwUvBz0s3xPITFfmL8hkRTxtGhGOCgrZur+076gA11hPDj1lPr6l7UItxyEPuXMjR8iG40snO4aBAY=@vger.kernel.org
X-Gm-Message-State: AFuF++nZ6X7VQIVfbqSZWx6aTwJJbRcTyIca6KtlvDripx5FNTmQI0IF
	54+mGrHIOjlGCkEslJhMQbdaizGNRd2XZZcwF3CVLwqcgq6WhVwoKnsj
X-Gm-Gg: AYBFou1dspzUwIbJm5iYziCG7IHsApRaqomIjDKIQ5kcTelVpKLheeatAnODO+xPCGW
	PSeTihtt+xYK2AYF19lF/fmzq0d2Xgohykh3MX1Y8xiiNvCxaQ1eMxatWAbbwGPS80VGF/JR3aH
	eyUC4XEvXCSi9jtO7K36wKw7y6gEHjkaqai7kTowA8RjMqcFEKKDczUtOfK6YcRhXYncNMZmbaZ
	co7BncYnLTUQYcGhybOuYtFm0tFU+V8r+9NTTntifwPD+PaYObPkmkYClsak+l4qmSq2lGVO0/p
	px2vruT4FGP1nHYsiq9MFzlBmWzmqs5u3l0sbpkhsfvfQ8c4v99TFSnvr4SkRvVYxBr4OtxNv+c
	9ryTHmvk3ujxGFiy4Rixkvm61IrnO2VhV50Myg3pH7FlHjo0/TZiHaXrfvn3/dWnqe4pbynxJHa
	wf/1+qZkGUYVn8TuqB+gzmVIhJRqkY8O0aeUJFaaUBrZP/eNnXtcsbfVKHnWmxzMkJjJiLDmrxV
	7T552jTbhvjWCcXyEuJSCU=
X-Received: by 2002:a05:6a00:4b4e:b0:879:30ac:c161 with SMTP id d2e1a72fcca58-87e9c63a4edmr2723587b3a.49.1790266367643;
        Thu, 24 Sep 2026 09:12:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1e1f5db6sm3312081b3a.54.2026.09.24.09.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:12:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 24 Sep 2026 09:12:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jiale Yao <yaojiale02@163.com>
Cc: Aleksa Savic <savicaleksa83@gmail.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (gigabyte_waterforce) reject short input reports
Message-ID: <5b8b6c95-693a-4472-93c4-c54d22280b79@roeck-us.net>
References: <20260924151133.1233860-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924151133.1233860-1-yaojiale02@163.com>

On Thu, Sep 24, 2026 at 11:11:32PM +0800, Jiale Yao wrote:
> The HID driver raw_event callback runs before HID core validates the
> received report length.  waterforce_raw_event() reads the command bytes
> and then accesses fixed offsets for firmware or status data without any
> length checks.  A truncated report can therefore cause out-of-bounds reads
> and update hwmon state with data beyond the received report.
> 
> Require both command bytes before identifying a report, then check the
> minimum length needed by the firmware and status paths before accessing
> their payloads.  Commit 47669bec44fe ("HID: asus: refactor the two
> workqueues and init sequence") added equivalent raw-event length
> validation to hid-asus.
> 
> Fixes: 42ac68e3d4ba ("hwmon: Add driver for Gigabyte AORUS Waterforce AIO coolers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  drivers/hwmon/gigabyte_waterforce.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/hwmon/gigabyte_waterforce.c b/drivers/hwmon/gigabyte_waterforce.c
> index 4eea05f8b569..9499cb274cbd 100644
> --- a/drivers/hwmon/gigabyte_waterforce.c
> +++ b/drivers/hwmon/gigabyte_waterforce.c
> @@ -257,8 +257,14 @@ static int waterforce_raw_event(struct hid_device *hdev, struct hid_report *repo
>  {
>  	struct waterforce_data *priv = hid_get_drvdata(hdev);
>  
> +	if (size < sizeof(get_status_cmd))
> +		return 0;
> +

The return length must be > FIRMWARE_VER_START_OFFSET_2 in all situations,
so a single check against FIRMWARE_VER_START_OFFSET_2 would be sufficient here.

Guenter

>  	if (data[0] == get_firmware_ver_cmd[0] && data[1] == get_firmware_ver_cmd[1]) {
>  		/* Received a firmware version report */
> +		if (size <= FIRMWARE_VER_START_OFFSET_2)
> +			return 0;
> +
>  		priv->firmware_version =
>  		    data[FIRMWARE_VER_START_OFFSET_1] * 10 + data[FIRMWARE_VER_START_OFFSET_2];
>  
> @@ -269,6 +275,8 @@ static int waterforce_raw_event(struct hid_device *hdev, struct hid_report *repo
>  
>  	if (data[0] != get_status_cmd[0] || data[1] != get_status_cmd[1])
>  		return 0;
> +	if (size <= WATERFORCE_TEMP_SENSOR)
> +		return 0;
>  
>  	priv->temp_input[0] = data[WATERFORCE_TEMP_SENSOR] * 1000;
>  	priv->speed_input[0] = get_unaligned_le16(data + WATERFORCE_FAN_SPEED);
> -- 
> 2.34.1
> 
