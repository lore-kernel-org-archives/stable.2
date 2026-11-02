Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793640079;
	b=eAA9zSD7gO0w7+YbiuFeic5YVti618u58GOHeSv6RZ5wYt757UbHc5SNOY/sParUxb5d
	 p3mcxeLH8BIbKsQIDKyBRo5EEOtEQnzpOzjp6dSS2fT5l2QWk3r3l/ccrlx3HIZgYgI9R
	 Dk368SSHheuHdS2GJcWuQMeoMHKFb+SWaLa/vxlV+JlPTWH75zPuLq/NiPtMAalNWDE9A
	 NvuhLzSw3mOyE6ekgjBJtW0m9s34MHudqrPOsC1eUx7/93QChog53PGneDMYFgV5smXck
	 xhafK/+4pdC/9eCeBjyj01W1K3v9dc49FMPMiJVCAhlGkGSUBsszFSk80k1hgh74jiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640079;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=RgFx2yB/Hk83xGx4rKbycFXzztA6pnGEYqpH3zOrJt4=;
	b=437ngVHSi0JNbZwC2h6jIpguvnE4Aj5ftmn0cAa5Na2Xa978A7+YwmQWoaH2Tti757dr
	 dyiRCz1NRVaPV80ICin+xCS/UMWca81sHJ2AU5SFTApqtR7B2ytkDEDuYCrqBvDa6+64q
	 GyBi7WHU5LcnceSET6YawVt8ca7NOLCF3RaMbefhtlvRaOg02K4fzwouIHL4OgJh23Vkl
	 O6bsBoYiZyo5FcX5jR0Y6c4F12CAS5bMOktI7fYTLHvuTvGDKtIcPZeOQwa67SvGp+J83
	 /QoUVrr7Q1gbb9DoOGNElndhqU+8aBM+d/JdcvKeFp3wm2xm5PrrLHJk/xfxJTBIjHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KgbRNkAH;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72E460A3827;
	Mon,  2 Nov 2026 17:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D72E460A3827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KgbRNkAH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793640079; x=1825176079;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=jEzzLxaG7Elthrsvf/EaYA9KeJdgkDS8dXEt3tMRxh8=;
  b=KgbRNkAH1RfkCr7a5RTH4bp0DuuzvIerNin6Vnv4semC2M45Gf29oUYW
   170CU7Ymvs9/ntqB2KVlQliY86SHg8WXV6kKjhFu89Qoz+y1Vk5GDPy1J
   yxP4cAvQMs1ayr0H36v3hGTCwckwboLdZ1YyHN2guEQAaoTz+SlQkBOyN
   +Y4KNpeQtqwVf9Hj9zVzcI1TA+fXlMD7LUHgtXzd9aX3sMl8IuRF6huRc
   /vk2IrhF6kC8fiNMbxE/rWFc2+q74ODT/wdpaIrr6B4EbxZRNvPOektYE
   5KNpM1RfNBv/eRsqXFj3rmkUib7f878WZnvb240Gh8o2NGXiTLLJE/aDl
   w==;
X-CSE-ConnectionGUID: Y3HBvE8kR0COrGyJupDM9A==
X-CSE-MsgGUID: r+oeGlH/RHCkCYED6Z/Ncw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2346732"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2346732"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 09:21:19 -0800
X-CSE-ConnectionGUID: HSHacl66S7OYsKw1yBQgOA==
X-CSE-MsgGUID: y3guCy38SnytuZLmYHeL1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6007577"
Received: from spandruv-desk2.jf.intel.com ([10.24.80.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 09:21:18 -0800
Message-ID: <29fc637d4056b9cc43cec3966570a278bf72b6c3.camel@linux.intel.com>
Subject: Re: [PATCH v3 3/3] iio: humidity: hid-sensor-humidity: Use
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
Date: Mon, 02 Nov 2026 09:21:18 -0800
In-Reply-To: <20261019023420.83976-4-ch@murgatroid.com>
References: <20261019023420.83976-1-ch@murgatroid.com>
	 <20261019023420.83976-4-ch@murgatroid.com>
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
> hid-sensor-humidity keeps a single static struct
> hid_sensor_hub_callbacks for all instances and overwrites its pdev in
> every probe, so with two humidity sensors, input reports for one are
> delivered with the other's platform device, and a NULL dereference
> follows once that device is removed.=C2=A0 The same bug was found in
> hid-sensor-temperature, which shares this code.
>=20
> Keep the callbacks in struct hid_humidity_state, as the other HID
> sensor drivers (accel, gyro, als, ...) do.
>=20
> Fixes: d7ed89d5aadf ("iio: hid: Add humidity sensor support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christopher Hoover <ch@murgatroid.com>
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/iio/humidity/hid-sensor-humidity.c | 14 +++++++-------
> =C2=A01 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iio/humidity/hid-sensor-humidity.c
> b/drivers/iio/humidity/hid-sensor-humidity.c
> index 7cec81ff5685..644c82719447 100644
> --- a/drivers/iio/humidity/hid-sensor-humidity.c
> +++ b/drivers/iio/humidity/hid-sensor-humidity.c
> @@ -14,6 +14,7 @@
> =C2=A0
> =C2=A0struct hid_humidity_state {
> =C2=A0	struct hid_sensor_common common_attributes;
> +	struct hid_sensor_hub_callbacks callbacks;
> =C2=A0	struct hid_sensor_hub_attribute_info humidity_attr;
> =C2=A0	struct {
> =C2=A0		s32 humidity_data;
> @@ -184,11 +185,6 @@ static int humidity_parse_report(struct
> platform_device *pdev,
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> -static struct hid_sensor_hub_callbacks humidity_callbacks =3D {
> -	.send_event =3D &humidity_proc_event,
> -	.capture_sample =3D &humidity_capture_sample,
> -};
> -
> =C2=A0/* Function to initialize the processing for usage id */
> =C2=A0static int hid_humidity_probe(struct platform_device *pdev)
> =C2=A0{
> @@ -240,9 +236,13 @@ static int hid_humidity_probe(struct
> platform_device *pdev)
> =C2=A0
> =C2=A0	platform_set_drvdata(pdev, indio_dev);
> =C2=A0
> -	humidity_callbacks.pdev =3D pdev;
> +	humid_st->callbacks =3D (struct hid_sensor_hub_callbacks) {
> +		.send_event =3D humidity_proc_event,
> +		.capture_sample =3D humidity_capture_sample,
> +		.pdev =3D pdev,
> +	};
> =C2=A0	ret =3D sensor_hub_register_callback(hsdev,
> HID_USAGE_SENSOR_HUMIDITY,
> -					=C2=A0=C2=A0 &humidity_callbacks);
> +					=C2=A0=C2=A0 &humid_st->callbacks);
> =C2=A0	if (ret)
> =C2=A0		goto error_remove_trigger;
> =C2=A0
