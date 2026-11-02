Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793640051;
	b=w/Vt8oJ2ikoGHSqNTcfdLcv8WS8KfiXnJzyzhFRcqoEkhZrAMNwusL5iRSqvXnXykWou
	 J78Wln3GQk5+r3zTq7QRC3omKFzVdIanqpyN0OFbykxijyh6q6N4FcVj6s870AS4N09GC
	 454pKfcCf09pWnr7rtqpnH6Ihh0IDG3pqEitSrUZYlX3RqYdGeNUIyaESddyPLumGYZ9V
	 mvJ20+seA9MMM7tseypWNXIpLmAiyTxb2JVaV0FXXECLhsulKSVJ+xwAUCstvqjwUJ7L4
	 XPYTphM4hb/Cc7e3bcHO/8a/Haa36iMvXoBlzwokHai12D1WRqeQYOz+asZquttr1Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640051;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=1aKXb+EuzBJyyRntQxoo6xwnn0KfT9e0rpZb4qHmGho=;
	b=OPRrbzANx8FsfoDDJEPX6bJ8IqqKzwUW4nIhJYjT1WEbz8Ts5DUBFqn5xPJ1klJQe8x+
	 URbz4Weub+2f5Rx1Qd6Zi/f5iMFoj1DJl4Urzs8pk1j7+PMSGcES9KiwFt6qIh2m/XJUa
	 5FrPQjtyQ4XXhYUw/xVzctK6wpAplfkuPblurm2NK+r2gdOJlRftKc/JZLyNm4+xoNTJB
	 +c0WGG+5NQxqy+EG3y+JfmR6BB2Eu0n3uuudXOX5+4xVEbLlTuNwDyG73HsFoFQ1WibF3
	 ZhBiCPKul3vExAT81pNUnvuAJG0Wocd1Ts3cCZmKESmsKIjTQiS9ePJdvdVk5KXDJ6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bKT1s6RC;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA79606BA59;
	Mon,  2 Nov 2026 17:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EA79606BA59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bKT1s6RC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793640052; x=1825176052;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=k/z/OKwLEw15Eu+WNcTtujJU+nBl0LAs7kKK4N/UUq4=;
  b=bKT1s6RCLHGSYs+EA3hK5x3cTwdlauntZA5IejcdNdHrvtP4XV2h7hD6
   iWDwVt0cuyHw0b/BdUbUHEPNgWMMUw5YGo5zJnuae852MOOCE+/hLMOcq
   pBunjUX1P+TQgBwvSTWL0bZC1zIayUqitntnO/vYFHune8lezKxZPym95
   nr9QOho4M1M+dkFYCAz2MafFhR4C8DzMqOccG9j7gBUZJWxPeEBg/+vH5
   /ocZLn+aoo29RyTYJjdExXRdNLoYXxDEgVP8lfPmQiqpOuWUT6cFjzNuv
   2ok6O7iixcCe/Ff1ZJM/ClEDcZjGKBNpk2GItdOf5abwKUUJrmctaZHk+
   g==;
X-CSE-ConnectionGUID: lbLdM/0oS92m6Nqci/lWEw==
X-CSE-MsgGUID: jIYtAIgoQoW6V6aJNfeQwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2346677"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2346677"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 09:20:51 -0800
X-CSE-ConnectionGUID: xAT7ntNbQgyDx3mE1OeNnA==
X-CSE-MsgGUID: 5Egeo+XtSIqlSoM5UqYIew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6007501"
Received: from spandruv-desk2.jf.intel.com ([10.24.80.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 09:20:50 -0800
Message-ID: <5481cb8e125b76562ee6831cf3e87a09219def02.camel@linux.intel.com>
Subject: Re: [PATCH v3 2/3] iio: temperature: hid-sensor-temperature: Use
 per-instance callbacks
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Christopher Hoover <ch@murgatroid.com>, Jonathan Cameron
 <jic23@kernel.org>,  Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
 <bentiss@kernel.org>
Cc: Lixu Zhang <lixu.zhang@intel.com>, Joshua Crofts
 <joshua.crofts1@gmail.com>,  David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko	
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 02 Nov 2026 09:20:50 -0800
In-Reply-To: <20261019023420.83976-3-ch@murgatroid.com>
References: <20261019023420.83976-1-ch@murgatroid.com>
	 <20261019023420.83976-3-ch@murgatroid.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sun, 2026-10-18 at 19:34 -0700, Christopher Hoover wrote:
> hid-sensor-temperature keeps a single static struct
> hid_sensor_hub_callbacks for all instances and overwrites its pdev in
> every probe.=C2=A0 With two temperature sensors, input reports for one ar=
e
> delivered with the other's platform device; once that device is
> removed, platform_get_drvdata() returns NULL and
> temperature_capture_sample() dereferences it:
>=20
> =C2=A0 BUG: kernel NULL pointer dereference, address: 00000000000003a8
> =C2=A0 RIP: 0010:temperature_capture_sample+0xd/0x50
> [hid_sensor_temperature]
>=20
> The oops happens in sensor_hub_raw_event() with the hub's spinlock
> held, so the hub's removal then hangs.=C2=A0 It reproduces with two uhid
> devices that each declare a temperature sensor, one destroyed while
> the other still sends input reports.
>=20
> Keep the callbacks in struct temperature_state, as the other HID
> sensor drivers (accel, gyro, als, ...) do.
>=20
> Fixes: 59d0f2da3569 ("iio: hid: Add temperature sensor support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christopher Hoover <ch@murgatroid.com>
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/iio/temperature/hid-sensor-temperature.c | 14 +++++++------=
-
> =C2=A01 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iio/temperature/hid-sensor-temperature.c
> b/drivers/iio/temperature/hid-sensor-temperature.c
> index 5e3262e461f4..4bc9d42a0301 100644
> --- a/drivers/iio/temperature/hid-sensor-temperature.c
> +++ b/drivers/iio/temperature/hid-sensor-temperature.c
> @@ -14,6 +14,7 @@
> =C2=A0
> =C2=A0struct temperature_state {
> =C2=A0	struct hid_sensor_common common_attributes;
> +	struct hid_sensor_hub_callbacks callbacks;
> =C2=A0	struct hid_sensor_hub_attribute_info temperature_attr;
> =C2=A0	struct {
> =C2=A0		s32 temperature_data;
> @@ -181,11 +182,6 @@ static int temperature_parse_report(struct
> platform_device *pdev,
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> -static struct hid_sensor_hub_callbacks temperature_callbacks =3D {
> -	.send_event =3D &temperature_proc_event,
> -	.capture_sample =3D &temperature_capture_sample,
> -};
> -
> =C2=A0/* Function to initialize the processing for usage id */
> =C2=A0static int hid_temperature_probe(struct platform_device *pdev)
> =C2=A0{
> @@ -237,9 +233,13 @@ static int hid_temperature_probe(struct
> platform_device *pdev)
> =C2=A0
> =C2=A0	platform_set_drvdata(pdev, indio_dev);
> =C2=A0
> -	temperature_callbacks.pdev =3D pdev;
> +	temp_st->callbacks =3D (struct hid_sensor_hub_callbacks) {
> +		.send_event =3D temperature_proc_event,
> +		.capture_sample =3D temperature_capture_sample,
> +		.pdev =3D pdev,
> +	};
> =C2=A0	ret =3D sensor_hub_register_callback(hsdev,
> HID_USAGE_SENSOR_TEMPERATURE,
> -					=C2=A0=C2=A0 &temperature_callbacks);
> +					=C2=A0=C2=A0 &temp_st->callbacks);
> =C2=A0	if (ret)
> =C2=A0		goto error_remove_trigger;
> =C2=A0
