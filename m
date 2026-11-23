Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464530;
	b=a+xg0RzPceVYuV5dGoXbQUTASyr/ySZAhkANuKI2R0tOCYQk1Mx2Be/TyzSpampdUFyd
	 PBE58A/2k8JbgMXnCmi2y7UNLflEfciTZMQqRo5hkG+vEAEBU5cNlIeXcHnAVoc1S10nW
	 tF85WkrqKGoCVyF3NAASo0PgSfwdVyt8wajRMzvH80oSkSjo3s0vPvrfce44NKzoHptwp
	 Fe+fQAelvM0Oh9o3X0MEsgIo8OnpsXCliHoIqg89NVPs9AVpmFppnZ9GmMW7bFuYYtqeu
	 1Q1R4/1jVFtlcyqQw22hBPwcyNCiilMsvjhUV2tFtE8SYQ6ZjglYpEbqzd4nDHbAG+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464530;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=tpiAyS2NSTTYCcz+tAuV6mj0ApkVi4kroTS8S8VTkpU=;
	b=iH4WG9tzk0Me4lgO/41pQ5F9Vom369ISpW9nbToRHrbH3vUJXJkz/h3SFPkZvl7CX1el
	 N/YLaUREH6BMiUoIH2G38mGTmOhqqCDijoSTwVcTwPamfd/dxcw5ADhlFax26fJJtBAa0
	 TMEOueUcIKmdkLHuTHdrDAttx8NfIarFSNpQtKeBFAV/hEoE3YoUUkbZHAO150/O1rvC5
	 oCL/zoyULU15iEWNfr8+QbvflazP4hq3t1lAUhkPlaQAAscGMdYB4BoAA1WzaXMnMy5tO
	 OIzbU8CGA/ibzIlnXA+nfNCY7TMocLoS06hF+Rietpuko+3fHLI5WzKnP3fhvzh8kJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="N72/HYHb";
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07FA606A31E;
	Mon, 23 Nov 2026 20:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A07FA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N72/HYHb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795464529; x=1827000529;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=n/9Q7z9XOP+kvIJJRG45nmnHwoIg2/j3yx7h4OK2u30=;
  b=N72/HYHbvL6VC3nNGr7fG8V/t5VeWIXhAqARCHb6nepJx+nufZrSLhPX
   nPCArsQS6paB6HeieLgR4azeT5kXmqljS4lxB2zF6l8qpOwtTSy4RvYVt
   6KfkX1zTPy3dyHh5vUnveRDl77uDkTLlaGlQXbESP0p6NzEobSmIE61ro
   mNNbkP992QFTMdqj0LggURTa39SvOMQL/8PDMH83gJ+G4SAgpLw4cGTt0
   xFtXqJwGmGOJGX1PHKCM99SATB5qaZSC6yaiy9AyVP5+3QR4lvPdHAJji
   hkwyyD7WxYGJnbPNqhCH2Jz12wGYazNqRi2Q0jeEgJyr70HJOzIkSYZ+O
   g==;
X-CSE-ConnectionGUID: RShL3OY9T0qdoLhloVjUqA==
X-CSE-MsgGUID: TIqVwWUdQmaiu6Yz87Qchg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4314174"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4314174"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 12:08:48 -0800
X-CSE-ConnectionGUID: Y1lF6AiURPqWHbe1Hy/guA==
X-CSE-MsgGUID: wD/0ghWTTFaSseXLZv5nMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11497572"
Received: from spandruv-mobl5.amr.corp.intel.com (HELO [10.124.220.148]) ([10.124.220.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 12:08:47 -0800
Message-ID: <e384a97e66159f10045ec6caf244b475e09c8337.camel@linux.intel.com>
Subject: Re: [PATCH 04/10] HID: sensor-hub: Serialise synchronous read
 teardown under data->lock
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Lee Jones <lee@kernel.org>, Jiri Kosina <jikos@kernel.org>, Jonathan
 Cameron <jic23@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Zhang
 Lixu	 <lixu.zhang@intel.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, 	linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Date: Mon, 23 Nov 2026 12:08:44 -0800
In-Reply-To: <20261123155138.2907049-5-lee@kernel.org>
References: <20261123155138.2907049-1-lee@kernel.org>
	 <20261123155138.2907049-5-lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-23 at 15:50 +0000, Lee Jones wrote:
> sensor_hub_input_attr_read_values() and
> sensor_hub_input_attr_get_raw_value() set hsdev->pending.status under
> data->lock, sleep in wait_for_completion_interruptible_timeout(), and
> then clear hsdev->pending.status and consume or free
> hsdev->pending.raw_data without acquiring data->lock.=C2=A0 When a wait i=
s
> interrupted by a signal or times out while sensor_hub_raw_event()
> holds
> the same spinlock, sensor_hub_raw_event() can memcpy() into the
> caller's popped stack buffer in sensor_hub_input_attr_read_values()
> or
> race with kfree() and leak kmemdup() allocations in
> sensor_hub_input_attr_get_raw_value().
>=20
> Hold data->lock when clearing hsdev->pending.status and detaching
> hsdev->pending.raw_data in both helpers, and free any prior
> hsdev->pending.raw_data before kmemdup() in sensor_hub_raw_event().
>=20
> Fixes: 401ca24fb34a ("HID: sensors: introduce sensor framework")
> Fixes: f784fcea4506 ("HID: sensor-hub: Add
> sensor_hub_input_attr_read_values() for multi-byte reads")
> Closes:
> https://sashiko.dev/#/bug/linux-5bd5ea7c-72f9-4f22-ae1d-00915390f085
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> =C2=A0drivers/hid/hid-sensor-hub.c | 28 +++++++++++++++++++++-------
> =C2=A01 file changed, 21 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-
> hub.c
> index 81c8e723f9ba..ea846e0bb301 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -306,6 +306,9 @@ int sensor_hub_input_attr_read_values(struct
> hid_sensor_hub_device *hsdev,
> =C2=A0	long cycles;
> =C2=A0	int ret;
> =C2=A0
> +	if (flag =3D=3D SENSOR_HUB_SYNC && (!buffer || !buffer_size))
> +		return -EINVAL;
> +
> =C2=A0	report =3D sensor_hub_report(report_id, hsdev->hdev,
> HID_INPUT_REPORT);
> =C2=A0	if (!report)
> =C2=A0		return -EINVAL;
> @@ -335,7 +338,10 @@ int sensor_hub_input_attr_read_values(struct
> hid_sensor_hub_device *hsdev,
> =C2=A0		else if (cycles < 0)
> =C2=A0			ret =3D cycles;
> =C2=A0
> +		spin_lock_irqsave(&data->lock, flags);
> =C2=A0		hsdev->pending.status =3D false;
> +		hsdev->pending.raw_data =3D NULL;
> +		spin_unlock_irqrestore(&data->lock, flags);
> =C2=A0	}
> =C2=A0	mutex_unlock(hsdev->mutex_ptr);
> =C2=A0
> @@ -375,29 +381,36 @@ int sensor_hub_input_attr_get_raw_value(struct
> hid_sensor_hub_device *hsdev,
> =C2=A0	hid_hw_request(hsdev->hdev, report, HID_REQ_GET_REPORT);
> =C2=A0	mutex_unlock(&data->mutex);
> =C2=A0	if (flag =3D=3D SENSOR_HUB_SYNC) {
> +		u8 *raw_data;
> +
> =C2=A0		wait_for_completion_interruptible_timeout(
> =C2=A0						&hsdev-
> >pending.ready, HZ*5);
> -		switch (hsdev->pending.raw_size) {
> +		spin_lock_irqsave(&data->lock, flags);
> +		raw_data =3D hsdev->pending.raw_data;
> +		switch (raw_data ? hsdev->pending.raw_size : 0) {
> =C2=A0		case 1:
> =C2=A0			if (is_signed)
> -				ret_val =3D *(s8 *)hsdev-
> >pending.raw_data;
> +				ret_val =3D *(s8 *)raw_data;
> =C2=A0			else
> -				ret_val =3D *(u8 *)hsdev-
> >pending.raw_data;
> +				ret_val =3D *(u8 *)raw_data;
> =C2=A0			break;
> =C2=A0		case 2:
> =C2=A0			if (is_signed)
> -				ret_val =3D *(s16 *)hsdev-
> >pending.raw_data;
> +				ret_val =3D *(s16 *)raw_data;
> =C2=A0			else
> -				ret_val =3D *(u16 *)hsdev-
> >pending.raw_data;
> +				ret_val =3D *(u16 *)raw_data;
> =C2=A0			break;
> =C2=A0		case 4:
> -			ret_val =3D *(u32 *)hsdev->pending.raw_data;
> +			ret_val =3D *(u32 *)raw_data;
> =C2=A0			break;
> =C2=A0		default:
> =C2=A0			ret_val =3D 0;
> =C2=A0		}
> -		kfree(hsdev->pending.raw_data);
> +		hsdev->pending.raw_data =3D NULL;
> +		hsdev->pending.raw_size =3D 0;
> =C2=A0		hsdev->pending.status =3D false;
> +		spin_unlock_irqrestore(&data->lock, flags);
> +		kfree(raw_data);
> =C2=A0	}
> =C2=A0	mutex_unlock(hsdev->mutex_ptr);
> =C2=A0
> @@ -590,6 +603,7 @@ static int sensor_hub_raw_event(struct hid_device
> *hdev,
> =C2=A0					}
> =C2=A0				}
> =C2=A0			} else {
> +				kfree(hsdev->pending.raw_data);

With this patch the waiter clears pending.status under data->lock on
timeout/signal, so sensor_hub_raw_event() can no longer kmemdup() after
the waiter has given up. I don't think the kfree() in
sensor_hub_raw_event() is needed for the race described in the commit
message.

The only case it covers is a spurious second matching report arriving
after complete() but before the waiter takes the lock. That is a
separate, pre-existing leak. Rather than freeing in the event path, I
think  clearing pending.status in sensor_hub_raw_event() when
completing the request, so only the first matching report is consumed
and raw_data is allocated at most once:

			} else {
				hsdev->pending.raw_data =3D kmemdup(ptr,
sz, GFP_ATOMIC);
				...
			--->	hsdev->pending.status =3D false;=20
				complete(&hsdev->pending.ready);
			}


BTW

The pre-existing callback removal race reported by Sashiko is already
addressed by commit abe10ad9c5fd ("HID: sensor-hub: Synchronize
callback removal with raw events") in linux-next (hid tree).=20

Thanks,
Srinivas


> =C2=A0				hsdev->pending.raw_data =3D
> kmemdup(ptr, sz, GFP_ATOMIC);
> =C2=A0				if (hsdev->pending.raw_data)
> =C2=A0					hsdev->pending.raw_size =3D
> sz;
