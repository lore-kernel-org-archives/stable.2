Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792632122;
	b=3FBMVXnEedK/LjZSNvvMOgRsQ+D3pHrVveupr4qIk7u5JY8Vefvh6ZiDnzqSE3/HSUS2
	 g5CSaJZD1PvXlvJwu6+PPyZsc7KSixJ0dbOM/g9L3WZpV5/PNlcLCYaFeyVQZgN4Rg6a1
	 86aEzhx/wWogLH92AR0dyt3bg9V0gDew3mAbKiBUbiXHlCMmBOfou8YC4oKgeB6Mf2ZUl
	 BrerkTfpUiVybj+EqYFMLrk4bbIb9NsfLNTdt3zhhwtGY/P5VmMco69StTn7J3jnan1uB
	 wUl4kc2bKshGmFHcAeyqayAsMiEmFKWdbeW2023jQWsXH/dLnDl2LdpjdwjprylHdGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792632122;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=6h6npeneL+mFSvsMfCVYXMehVP94L7ywxVJ3HZasHdQ=;
	b=sSX2ajFB3dsUBT/Ey5GoSdlNjnKuVtB2vVOttH5SCI9Y9sdhWaJlEhWwuyd2UTT9qPWk
	 wGVjgwTel2RCqzjXgeQVVcmLOTvQW0XTkBWV24MFCNLwZH+IQVQTSDVt8negkoD/IoKWD
	 0Zq+5SHhg09y8EMGSpyb72gAlzaJXFGnuAy4T3h/mQ8cNZUJNeKtFsardOoiIu8d3mQRa
	 UQRp0S+BoQTNTosiLrhxejt4E/PS+Yw6PHOT1dCpObwLtL8Y6F8vWTR7Z9CWwIMKi4MiZ
	 jLZJwSUV78gLdnDDlqCzNrnk8DMakN/Ean/pMTEvqFIYSHCwtGSLoJDRynuh9LfIP5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nOtikx07;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946B5606A319;
	Thu, 22 Oct 2026 01:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 946B5606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nOtikx07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792632122; x=1824168122;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=BNzoYnazXyJ6JJrwYdvEPd+oYROiHViwlnUhOUWCJjE=;
  b=nOtikx07vKID6hafQLQqBzdJllDAh85g8xWAImdUTyKnboFPd2T6KPkn
   pqI1M+WZY1CowKCsV3ZtBXx2HJ8WATzJS3ZPbztYjD2BIsQ4flWKzsMK/
   h0YdNAH6qZKbujyQLkgrNnstHLjTwmxg1IQYgAs6sVU2o3OojYzTY+EDy
   rozEKaF/5Wk3FKbpbbwSgv+lAYEtQDsvI0rya9UQUJh5YFdVAPl7slGx0
   jVhMsIYEdcI8nw+PV9RAkb2s1xlDZg+amGjrUy+vXYkkC4oXqY7zG0d8J
   YGXLHgzq6c1wgYVIIRgWEURb/0Sj9UylkGlYFzzDta7Jm3i9UxRFUB6Gq
   w==;
X-CSE-ConnectionGUID: RKp5QISKSHWeU4/RCYyNXg==
X-CSE-MsgGUID: hZUSjlOQS5mRSYV7BCVSHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1405253"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1405253"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 18:22:01 -0700
X-CSE-ConnectionGUID: KJbXWNUaT+65FE9FZ59IiA==
X-CSE-MsgGUID: q8RP0IbgSRGmp0sXmpq6MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3115640"
Received: from spandruv-mobl5.amr.corp.intel.com (HELO [10.247.175.100]) ([10.247.175.100])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 18:21:57 -0700
Message-ID: <4470c427937d26035d81b99ee7d06e2a602ee4d7.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/3] HID: hid-sensor-hub: Synchronize callback
 removal with raw events
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Christopher Hoover <ch@murgatroid.com>, Jonathan Cameron
 <jic23@kernel.org>,  Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
 <bentiss@kernel.org>
Cc: Lixu Zhang <lixu.zhang@intel.com>, Joshua Crofts
 <joshua.crofts1@gmail.com>,  David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko	
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 21 Oct 2026 18:21:45 -0700
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

Two spaces before "The".

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

The patch looks fine. Is this issue actually reproduced or it was found
by some AI tools?

Thanks,
Srinivas

> =C2=A0	return 0;
> =C2=A0}
