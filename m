Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F093C3F4B;
	Wed,  5 Aug 2026 17:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785949509; cv=none; b=YcyfUeJxDikfDv72g1Wi49qzAaMAQHA283Gny00zv/vjqDxnHvNfVcuPqBnlbSgPdNR0Nnr+egl1DAHzay9pHyK9sMF3vGwghdKmC7PReN6zm/eQPS16tmbpZexPkYQAA2v2Bp895sbqKqasx9QUCGwbH5UyN8rloAXt/VBAgBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785949509; c=relaxed/simple;
	bh=QiEEDunoEbE34+oEHqUg7+IJfL2ep4DHrf6JxCZvHMU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wn0uiO1ukw9m2tnOLMcXMdYUIC2Z6woSsPSADsZZv+2ZK8NDHLfRHK2zzGReAstf0S/tHRdwq1KCp+ZV61mskqzvD16h57OEyEfwOdNhnsUxOd1OzAQFle+5OYdWe/J1VTrOCzQm6XG8jVJYFr75OIp52vDhcj4E7eCxlHCYivg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2xiLxcq; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C2xiLxcq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785949507; x=1817485507;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=QiEEDunoEbE34+oEHqUg7+IJfL2ep4DHrf6JxCZvHMU=;
  b=C2xiLxcqZMulR3CZ5UWx2tZOP2lZA5H/qZ27UtoeMd7b2wlAljANgo7H
   jvZl3ZIdXOD6C0EHP1ulSPVtQE7TKaUPoZq3rHfwZJDcnd8MA3krjl6Aw
   +Inainqw3SMzL3YSLV4rEMcX0TqLCkh5X5xxbm1UPnfnFfvFMVAZyM7d6
   YF26IDRsMnmm/KKag+dfUPR7bT7BaCAioadxm8HlSQNmGjzGIIu7SBgcV
   +oFJc4NaiygZg/1JmjLVQThcMaXfTW+WzYa+5t5ge9YWPRRiyGde5eUfG
   zMD1DBifIn2Jg25zhr+E7+zy/PqeHNKNRRWir+ULBiH+qk3O4AM0uk0t6
   A==;
X-CSE-ConnectionGUID: 9THtuLdVRnKX8x/jftTLnQ==
X-CSE-MsgGUID: 0sB3N6SGT5KbOwdbxC3I8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="90347763"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="90347763"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 10:05:06 -0700
X-CSE-ConnectionGUID: aoTNVkWBQ+6fxFA07S6Jsg==
X-CSE-MsgGUID: OTczlXtYRJOQtzF9crDfFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="263843068"
Received: from unknown (HELO spandruv-desk2.jf.intel.com) ([10.241.242.127])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 10:00:56 -0700
Message-ID: <519ed426adad9031dabe2270b27e1ef7374bcaa5.camel@linux.intel.com>
Subject: Re: [PATCH] HID: sensor-hub: fix out-of-bounds access in
 sensor_hub_get_feature()
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Shengzhuo Wei <me@cherr.cc>, Jiri Kosina <jikos@kernel.org>, Jonathan
 Cameron <jic23@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Bakabaka_9	 <baka9@bakabaka9.tech>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 05 Aug 2026 10:00:55 -0700
In-Reply-To: <20260806-hid-sensor-hub-oob-v1-1-f8e210e7eafe@cherr.cc>
References: <20260806-hid-sensor-hub-oob-v1-1-f8e210e7eafe@cherr.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-06 at 00:38 +0800, Shengzhuo Wei wrote:
> sensor_hub_get_feature() copies each field value with
> memcpy(..., report->field[...]->report_size / 8), a size taken only
> from the descriptor and bounded neither to the caller buffer nor to
> the
> field->value[] array.
>=20
> When report_size exceeds the remaining buffer (e.g. a 64-bit power-
> state
> field into a 4-byte int) the copy overflows the caller's stack on the
> first iteration; when report_size > 32 it also reads past field-
> >value[]
> (one __s32 per logical value) into slab, leaking bytes to userspace
> via
> callers that expose the buffer (hid-sensor-custom show_value over
> sysfs).
> Reachable from an untrusted USB or Bluetooth HID device with no local
> privileges.
>=20
> Bound the per-iteration copy to min(report_size/8,
> (report_count-i)*sizeof(__s32), buffer_size - buffer_index).
>=20

There was a patch posted "PATCH v2] HID: sensor-hub: Fix out-of-bounds
write in sensor_hub_get_feature"
and I did ACK. But checked it didn't have correct CC list.

"
Fixes: 5459ada2b3cd69 ("HID: sensor-hub: Fix packing of result buffer
for feature report")
Cc: stable@kernel.org
Assisted-by: OpenAI:GPT-5.5-Cyber
Signed-off-by: Xingrui Li <baka9@bakabaka9.tech>
"

Xingrui, Please resend to all in this list here.

Thanks,
Srinivas





> Fixes: 5459ada2b3cd ("HID: sensor-hub: Fix packing of result buffer
> for feature report")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shengzhuo Wei <me@cherr.cc>
> ---
> =C2=A0drivers/hid/hid-sensor-hub.c | 11 +++++++++--
> =C2=A01 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-
> hub.c
> index
> 34f710c465b80a0c46cc207e3d99a07c5767f291..978335db71b09617c87e879911b
> 8e75b6bfdebb8 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -270,11 +270,18 @@ int sensor_hub_get_feature(struct
> hid_sensor_hub_device *hsdev, u32 report_id,
> =C2=A0
> =C2=A0	val_ptr =3D (u8 *)report->field[field_index]->value;
> =C2=A0	for (i =3D 0; i < report->field[field_index]->report_count;
> ++i) {
> +		int copy =3D report->field[field_index]->report_size /
> 8;
> +		int src_remaining =3D (report->field[field_index]-
> >report_count - i) *
> +				=C2=A0=C2=A0=C2=A0 sizeof(__s32);
> +
> =C2=A0		if (buffer_index >=3D ret)
> =C2=A0			break;
> =C2=A0
> -		memcpy(&((u8 *)buffer)[buffer_index], val_ptr,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 report->field[field_index]->repor=
t_size / 8);
> +		if (copy > src_remaining)
> +			copy =3D src_remaining;
> +		if (copy > buffer_size - buffer_index)
> +			copy =3D buffer_size - buffer_index;
> +		memcpy(&((u8 *)buffer)[buffer_index], val_ptr,
> copy);
> =C2=A0		val_ptr +=3D sizeof(__s32);
> =C2=A0		buffer_index +=3D (report->field[field_index]-
> >report_size / 8);
> =C2=A0	}
>=20
> ---
> base-commit: bf0a94fb2b59542f9dd6fea4eec67336f1ccfa56
> change-id: 20260806-hid-sensor-hub-oob-f316fd015b76
>=20
> Best regards,
