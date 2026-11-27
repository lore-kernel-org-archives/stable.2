Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795747802;
	b=CZ4mIn9esiGy65ObA9A4Z1Vpy17jKz92UZL2Q9Tkem+rK71dYTfuAkqGtUoj4lQpRPFH
	 pu0SdKvbLnhhf2BkRk7/wBdLvFYX73dKohCQuoBYtqww9Hb70JoccPj6lkKOCBkCVo/Vl
	 4mMWdqx5v4oaQRYNPqER04vR/wL2DH+DR2YQTw7GhdfzjZlj8CYTGwtMM1LEvK3j3KNqY
	 pRhnFbZ0dQzMV4udGn7fXJ4/M8EWXJK5n/eRHwAdBf9JHWhxYJE1/I9rIKVu/72EevGBH
	 YX724FjrxD4WXOMLE2nBYaMgwxIIBCzEh+kfVvqgcJuWcMXZ+yqXLECGDX2jMy2mytw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795747802;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=t+eUij82/QC/n+c9lQwrVzk3PSO0L0NTj3bs3PqbZcM=;
	b=eGqJD5UMoHkBU0cYSfOSp3Bw7Mt6v/KERIBK8+J698ui0lT318XaF8N8U1dI3Xnne+eR
	 hwLU0tIRAZG+0NMbK740dJ0dG+4wIuaGWJc4YooufWqX7KLJIiIJN5ByNZBcvKxISvu7S
	 yLuvd9oA0UuZf3mHLi9s+7nXe1t9JZucRBNN0uwFxHNckR2v8JymVMQFFXj+jxdyMVTsi
	 +0AZ5qYxJh6Y9M12pAguZ8MDR49BVI7Z4xFxIvWV97gVK8l+LKgFnTu6MT7yQnrNGs3hQ
	 r+j/5sake2nQ8OZiMrpBtrcrYHufRZ99e5xXChAj+F6QF3DARW8qKLsP5H31Vj4GSUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bB7Cp19Q;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28308606A31C;
	Fri, 27 Nov 2026 02:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28308606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bB7Cp19Q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=t+eUij82/QC/n+c9lQwrVzk3PSO0L0NTj3bs3PqbZcM=; b=bB7Cp19QQYGBmc2YEYKhqLVQoe
	AXQ9m420RBaP6JCLSVCoydmPkaabONkrdrM3aT0k7VeKiLa7j/SouUZhgtFavoQ6HXOCyD9Vbffsq
	ic7tRgSW4NfnW+yPyZMqqWXekuCC0WPwFI5maaSfHQGl1wuvkYBLiLAMrPBfuR6BraTImMukY29W9
	RUkHDEQiRgWg/+guSbWBwkhBG1qMhYOxnGgawp47iW6gVZ6tLg7a2V0jhdEeZSn8lTlee9jfeGc4A
	8Hmq9y21dQzOPbHQOLpD3/EiDAhrqTcjVVBU9DqAmjp8KWMZY12FFON84jdyD2nzq9iHzmrgRpygx
	eHtDjTMg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWm2D-0000000EnwC-1iaC;
	Fri, 27 Nov 2026 02:50:01 +0000
Message-ID: <e201bf76-fda3-4fd0-95af-8d8f0f2a74f9@infradead.org>
Date: Thu, 26 Nov 2026 18:50:00 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] HID: Merge duplicated documentation for Lenovo Legion
To: Ricardo Ribalda <ribalda@chromium.org>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>, Jiri Kosina <jikos@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261126-lenovo-go-v2-1-99db2904513e@chromium.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261126-lenovo-go-v2-1-99db2904513e@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/26/26 6:36 AM, Ricardo Ribalda wrote:
> Lenovo Legion Go and Lenovo Legion Go S share some definitions. Merge them in
> sysfs-driver-hid-lenovo-go to avoid this warning:
> 
> WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode is defined 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:364; ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:234
> [WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index is defined 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:373; ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:243
> [WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled is defined 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:636; ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:252
> [WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index is defined 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:645; ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:261
> 
> Cc: stable@vger.kernel.org
> Fixes: 168c91839139 ("HID: Add documentation for Lenovo Legion Go drivers")
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

LGTM. Thanks.
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> Changes in v2:
> - Revert unrelated "built in" -> "built-in" typo change in os_mode description (Mark Pearson)
> - Pick up Reviewed-by from Mark Pearson
> - Add Jonathan Corbet and linux-doc@vger.kernel.org to Cc (Mark Pearson)
> - Link to v1: https://lore.kernel.org/r/20260831-lenovo-go-v1-1-e9526e88ee09@chromium.org
> ---
>  .../ABI/testing/sysfs-driver-hid-lenovo-go         |  9 +++---
>  .../ABI/testing/sysfs-driver-hid-lenovo-go-s       | 35 ----------------------
>  2 files changed, 5 insertions(+), 39 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
> index c8221373ef76..07f3ea054383 100644
> --- a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
> +++ b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
> @@ -365,10 +365,11 @@ What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-
>  Date:		April 2026
>  Contact:	linux-input@vger.kernel.org
>  Description:	This controls the behavior of built in chord combinations.
> +		For the Legion Go S, this controls the touchpad's operating mode.
>  
>  		Values are windows or linux.
>  
> -		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
> +		Applies to Lenovo Legion Go, Go 2, and Go S line of handheld devices.
>  
>  What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index
>  Date:		April 2026
> @@ -377,7 +378,7 @@ Description:	This displays the available options for the os_mode attribute.
>  
>  		Values are windows or linux.
>  
> -		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
> +		Applies to Lenovo Legion Go, Go 2, and Go S line of handheld devices.
>  
>  What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/product_version
>  Date:		April 2026
> @@ -640,7 +641,7 @@ Description:	This controls enabling or disabling the touchpad.
>  
>  		Values are true, false.
>  
> -		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
> +		Applies to Lenovo Legion Go, Go 2, and Go S line of handheld devices.
>  
>  What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index
>  Date:		April 2026
> @@ -649,7 +650,7 @@ Description:	This displays the available options for the touchpad/enabled attrib
>  
>  		Values are true, false.
>  
> -		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
> +		Applies to Lenovo Legion Go, Go 2, and Go S line of handheld devices.
>  
>  What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/vibration_enabled
>  Date:		April 2026
> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
> index 4d317074bb7e..218164cfe544 100644
> --- a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
> +++ b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
> @@ -231,41 +231,6 @@ Description:	This displays the available options for the mouse/step attribute.
>  
>  		Applies to Lenovo Legion Go S line of handheld devices.
>  
> -What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode
> -Date:		April 2026
> -Contact:	linux-input@vger.kernel.org
> -Description:	This controls which value is used for the touchpads operating mode.
> -
> -		Values are windows or linux.
> -
> -		Applies to Lenovo Legion Go S line of handheld devices.
> -
> -What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index
> -Date:		April 2026
> -Contact:	linux-input@vger.kernel.org
> -Description:	This displays the available options for the os_mode attribute.
> -
> -		Values are windows or linux.
> -
> -		Applies to Lenovo Legion Go S line of handheld devices.
> -
> -What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled
> -Date:		April 2026
> -Contact:	linux-input@vger.kernel.org
> -Description:	This controls enabling or disabling the built-in touchpad.
> -
> -		Values are true or false.
> -
> -		Applies to Lenovo Legion Go S line of handheld devices.
> -
> -What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index
> -Date:		April 2026
> -Contact:	linux-input@vger.kernel.org
> -Description:	This displays the available options for the touchpad/enabled attribute.
> -
> -		Values are true or false.
> -
> -		Applies to Lenovo Legion Go S line of handheld devices.
>  
>  What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/linux_mode
>  Date:		April 2026
> 
> ---
> base-commit: 25faec9ce61c01fb45abf812a222c5b43c3cd5c5
> change-id: 20260831-lenovo-go-7b4ec4bf0cd5
> 
> Best regards,

-- 
~Randy
