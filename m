Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1A82459EA;
	Wed,  8 Jul 2026 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783533491; cv=none; b=d8CqI5ALLhFUqHtaIlKd+q14Ap4Ww5A0y6++ogDxADEwaMN3kD9J2nrvn8AWH7nGtwOuiM8QkFfwUNLxBgGjHY3KkZzVS4pK1OFT4BLY3Y6M46zwcTIAcPWFVu47M/TbwkgzsH2Um1EOfavYOt8iXUCDQJQHlgMqGrfBVOWVSy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783533491; c=relaxed/simple;
	bh=c3uFcMRjJwERNWtlFP49t0Wal7m+JJxOTcx+RGrtDLE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wtl+KQeVNDtY+sBeddp9X9NkKoqWj32d+dR9FEKPBs/tDorm6FGP5XyQOX0/k3NvFSu4/P4L8lqmOAsAbQB1bkVtEyWxOHyTL7e3+yhxhKQTl+BzvyV0sZgTm8R3H2NUq2v7WhJTzElT8ms+Thi6iTtJe8KxzS0r0vnYcovlNvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IyWZ1gTF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IyWZ1gTF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783533489; x=1815069489;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=c3uFcMRjJwERNWtlFP49t0Wal7m+JJxOTcx+RGrtDLE=;
  b=IyWZ1gTFfnxpv3aoypsuw7x5Xe1jNSvn4HAEiOGry88CsdIc1GNocYkC
   KSZ+W23Q35jytUuCxrj6kuz6lLoKwgQkBGCLkAt0z+GANkMcX7WlypqTv
   oyA51TSYYIXD7+bDbEffIFToXjdF1fzr1rl7Gfgd5k3U92qW6bfTADnBO
   16wcDTZ4rsZJuTwZyrQ985v8XzHGvgLG7ubpyEkDGb6tiQ1TbmnvFjyZB
   EcZwYgAQwZSkh2HFaVuFweHwZdZiDXibDzvvFTEbmA7kNkSzFjEmq8xjv
   UoDyFzNAX5GIhWk+FW16diKqGEgi7q8+r3cSec8XLL+7W4onYLNS677Kj
   A==;
X-CSE-ConnectionGUID: WMcU1LYoQQCxdsKnDWhRGg==
X-CSE-MsgGUID: GTA5zSJ3SqW3qDWr0rUHNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84322770"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84322770"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 10:58:08 -0700
X-CSE-ConnectionGUID: zNo/mCUWQh+yx9UBcP7gBw==
X-CSE-MsgGUID: T69FPF+qTdGXWCyuKxKDvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="258223335"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.111.97]) ([10.125.111.97])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 10:58:07 -0700
Message-ID: <d7f8d8f45d4fc849f5ad13472803df898e080caf.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/2] HID: sensor: custom: Fix use-after-free in
 enable_sensor
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Haoxiang Li <haoxiang_li2024@163.com>, jikos@kernel.org,
 jic23@kernel.org, 	bentiss@kernel.org
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sashiko AI Review <sashiko-bot@kernel.org>, 
	stable@vger.kernel.org
Date: Wed, 08 Jul 2026 10:58:06 -0700
In-Reply-To: <20260707071545.3087073-2-haoxiang_li2024@163.com>
References: <20260707071545.3087073-1-haoxiang_li2024@163.com>
	 <20260707071545.3087073-2-haoxiang_li2024@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-07-07 at 15:15 +0800, Haoxiang Li wrote:
> enable_sensor_store() can call set_power_report_state(), which
> dereferences sensor_inst->power_state and sensor_inst->report_state.
> These pointers refer to entries in sensor_inst->fields.
>=20
> Create the field attributes before exposing the enable_sensor sysfs
> attribute, so enable_sensor cannot be accessed before the state it
> depends on has been initialized.
>=20
> On remove, delete enable_sensor before freeing the field attributes,
> so a concurrent sysfs write cannot dereference freed memory through
> power_state or report_state.
>=20
> Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
> Link:
> https://sashiko.dev/#/patchset/20260623021950.1736413-1-haoxiang_li2024@1=
63.com?part=3D1
> Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor
> support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/hid/hid-sensor-custom.c | 17 +++++++++--------
> =C2=A01 file changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-
> sensor-custom.c
> index afffea894021..6b0da2e0e1c9 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -1005,26 +1005,26 @@ static int hid_sensor_custom_probe(struct
> platform_device *pdev)
> =C2=A0		return ret;
> =C2=A0	}
> =C2=A0
> -	ret =3D sysfs_create_group(&sensor_inst->pdev->dev.kobj,
> -				 &enable_sensor_attr_group);
> +	ret =3D hid_sensor_custom_add_attributes(sensor_inst);
> =C2=A0	if (ret)
> =C2=A0		goto err_remove_callback;
> =C2=A0
> -	ret =3D hid_sensor_custom_add_attributes(sensor_inst);
> +	ret =3D sysfs_create_group(&sensor_inst->pdev->dev.kobj,
> +				 &enable_sensor_attr_group);
> =C2=A0	if (ret)
> -		goto err_remove_group;
> +		goto err_remove_attributes;
> =C2=A0
> =C2=A0	ret =3D hid_sensor_custom_dev_if_add(sensor_inst);
> =C2=A0	if (ret)
> -		goto err_remove_attributes;
> +		goto err_remove_group;
> =C2=A0
> =C2=A0	return 0;
> =C2=A0
> -err_remove_attributes:
> -	hid_sensor_custom_remove_attributes(sensor_inst);
> =C2=A0err_remove_group:
> =C2=A0	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
> =C2=A0			=C2=A0=C2=A0 &enable_sensor_attr_group);
> +err_remove_attributes:
> +	hid_sensor_custom_remove_attributes(sensor_inst);
> =C2=A0err_remove_callback:
> =C2=A0	sensor_hub_remove_callback(hsdev, hsdev->usage);
> =C2=A0
> @@ -1042,9 +1042,10 @@ static void hid_sensor_custom_remove(struct
> platform_device *pdev)
> =C2=A0	}
> =C2=A0
> =C2=A0	hid_sensor_custom_dev_if_remove(sensor_inst);
> -	hid_sensor_custom_remove_attributes(sensor_inst);
> +	/* Remove enable_sensor first as it uses fields via
> power_state/report_state. */
> =C2=A0	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
> =C2=A0			=C2=A0=C2=A0 &enable_sensor_attr_group);
> +	hid_sensor_custom_remove_attributes(sensor_inst);
> =C2=A0	sensor_hub_remove_callback(hsdev, hsdev->usage);
> =C2=A0}
> =C2=A0
