Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793639987;
	b=okq8JG1vZzJS5r9xgmsyAI2+Rwzslf1uyU5qvFP4seY+t4WSMQhvDNq4RvY55zFFFWT5
	 LVwSLZwEmzsfONm5Z0RkiPTz2YV91ovU01lLkDNor3wopJWnOPV7ZDwYBvhBZbnJO7mNX
	 /FpZpNDX2MQeAqkp/DuEhExyoYv6ZkJAHiHucCD2zC+OoZLKzhC1gcuFTEihfL0FB1f8N
	 fBfH/1W3y1AjlEBYeHn3YmfafLhxxfENfSXcs3x8qYc+8LuNwD1NBA1IZMQH0qc8RYdQx
	 dgKQqzf8hC3cWgz11IQzovEwBmx9np1EBXCvC96k6sOVJmzUs8+2Uf+pbF9cIFG7XEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793639987;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=DT5eWamxtrU19G5Gc7ioBYYTXLklgAXyVHvH2qTCEzA=;
	b=2RjX0oJrpOw0ieUp3a4qaimsZ/T+bRGjK89/NGkwoWDO+qDln9RBpPrdSW+RyGJcVttW
	 vpik7/Ffs0oTjdyqwXVCwbjwjj9PbCJy6/qRYu7vewZ0DeABKEBpSoyEvahlT0rvT0hMn
	 ITavVKuEHQZ5vgz04vQ22njb//q4JaFXSmJX63qkFfiOwAxRsDI28F/dMw5vzSgpwROO5
	 /wzj3CQsH+fSCJ0MLVUx78lZrlKpuV05vFpM/6KbVcJrPHJvTfXGt9R3vXwJyQqXw2h2W
	 SLnRqQ0DAgtozcUtNDUDYoC1ico3wnHLcZWbGJ3MNzfOmCu8fOo137Xs5Q4hSye5/6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VfKhLVsX;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C0A606B0FF;
	Mon,  2 Nov 2026 17:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40C0A606B0FF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VfKhLVsX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793639987; x=1825175987;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ninpGkQe1A3RJG31n9ZS8rQNZ+IaBpmi8PE11emBlIo=;
  b=VfKhLVsXDNOL5ansfv2gw0rXmc+A6I9GsPjrG8liKAdPrPt1Nb65qemp
   0EgoUcmqtXnhxD4UG8UaZeMbT6sTLEXWz0/nWjjReZ1ywmfBojfK0tUFr
   PZJ6Z0MOI9/tAkkmxurA0yWYoeQ3o3kiGw0d+I0JRZf4zpSte10fSmvd8
   yiNWRFmMozixwtevHj2lSLHcxh/zC76PHKnxJ/jxQ1A1zcFX6csw95Ya7
   I5s2eLQvL78BnVevNUa+shPDiFrtR9eP9J1tWzjE7wk2Oz4ph8NNtGWUJ
   0ZaE5oPx1Jp2u8nckaa3FxEor+RNb/aeJj8ktva/eCaMtYqg9USEMa0nL
   A==;
X-CSE-ConnectionGUID: UERHnDdjQaS8SnQU5XZ+6g==
X-CSE-MsgGUID: n4NsglR4S4S/RqobQbseOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2336248"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2336248"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 09:19:46 -0800
X-CSE-ConnectionGUID: YaD6DFZAQAKj65kb+ApbIQ==
X-CSE-MsgGUID: RXR9cYE3Qsi+fx0pNAsYTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="8018124"
Received: from spandruv-desk2.jf.intel.com ([10.24.80.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 09:19:45 -0800
Message-ID: <53e98aa200636737155c122d545afa1fffc9d1cb.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/3] HID: hid-sensor-hub: Synchronize callback
 removal with raw events
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Christopher Hoover <ch@murgatroid.com>, Jonathan Cameron
 <jic23@kernel.org>,  Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
 <bentiss@kernel.org>
Cc: Lixu Zhang <lixu.zhang@intel.com>, Joshua Crofts
 <joshua.crofts1@gmail.com>,  David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko	
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 02 Nov 2026 09:19:45 -0800
In-Reply-To: <20261019023420.83976-2-ch@murgatroid.com>
References: <20261019023420.83976-1-ch@murgatroid.com>
	 <20261019023420.83976-2-ch@murgatroid.com>
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
> sensor_hub_raw_event() holds pdata->lock while it looks a callback up
> in dyn_callback_list and calls its capture_sample() and send_event().
> sensor_hub_remove_callback() takes only dyn_callback_lock, so it can
> unlink a callback and return while another CPU is between the lookup
> and the call.=C2=A0 The sensor drivers remove their callback in .remove()
> and keep the struct hid_sensor_hub_callbacks in memory that devres
> frees right after, so a report racing an unbind can call through
> freed function pointers.
>=20
> Take pdata->lock in sensor_hub_remove_callback() too, outside
> dyn_callback_lock as in sensor_hub_raw_event(), so the removal waits
> for a report in flight.=C2=A0 pdata->lock is otherwise only taken in
> sensor_hub_raw_event(), and callbacks are removed from process
> context.
>=20
> Fixes: 401ca24fb34a ("HID: sensors: introduce sensor framework")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christopher Hoover <ch@murgatroid.com>
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/hid/hid-sensor-hub.c | 12 ++++++++++--
> =C2=A01 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-
> hub.c
> index 6470a290ebfc..7cf9f398592e 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -173,7 +173,14 @@ int sensor_hub_remove_callback(struct
> hid_sensor_hub_device *hsdev,
> =C2=A0	struct sensor_hub_data *pdata =3D hid_get_drvdata(hsdev-
> >hdev);
> =C2=A0	unsigned long flags;
> =C2=A0
> -	spin_lock_irqsave(&pdata->dyn_callback_lock, flags);
> +	/*
> +	 * sensor_hub_raw_event() holds pdata->lock while it looks
> up a
> +	 * callback and calls it.=C2=A0 Taking it here too means no
> report is
> +	 * still using the callback once it is unlinked, so its
> owner may
> +	 * free it as soon as this returns.
> +	 */
> +	spin_lock_irqsave(&pdata->lock, flags);
> +	spin_lock(&pdata->dyn_callback_lock);
> =C2=A0	list_for_each_entry(callback, &pdata->dyn_callback_list,
> list)
> =C2=A0		if (callback->usage_id =3D=3D usage_id &&
> =C2=A0						callback->hsdev =3D=3D
> hsdev) {
> @@ -181,7 +188,8 @@ int sensor_hub_remove_callback(struct
> hid_sensor_hub_device *hsdev,
> =C2=A0			kfree(callback);
> =C2=A0			break;
> =C2=A0		}
> -	spin_unlock_irqrestore(&pdata->dyn_callback_lock, flags);
> +	spin_unlock(&pdata->dyn_callback_lock);
> +	spin_unlock_irqrestore(&pdata->lock, flags);
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
