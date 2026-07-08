Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF3747F2E1;
	Wed,  8 Jul 2026 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783533513; cv=none; b=Kxv2aiWVx0UFDDf5s67BukCQvX+hcIERIHOA/fbgtFRptT2CZE4Jxvst3Yecwkoeg31MS0RBjh/j3r6lE1fnudP04ZROHZiUlFM1+fpBBqa/OdvSq/rhMRYlcnNp9DtpnZv9jjN50nUtlyb7TPM/77l1njkdpvwUgcK0bZOw+Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783533513; c=relaxed/simple;
	bh=vHCvyggaVGP/UrSeuuouhmlV8J6mtVFiyBdN7FWC2DM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QqxTjVyJPjKr26qdprYqyXG4D2eNDIuYLjB6BVXnQLcqxdlWJvFTNHq/ViKL7mxxi50GpHCqDIF3tKJiDTa03ZYSxy2GeldsxMtZvQxiPsn93OaZsH9B5mpZ6vf8IZP298g4uNhAKUapt/033lO1elUV1L3iJaVXzThbWuTZeRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X2cx492P; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X2cx492P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783533513; x=1815069513;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=vHCvyggaVGP/UrSeuuouhmlV8J6mtVFiyBdN7FWC2DM=;
  b=X2cx492PFMwfUdbZEgmVtisK5Rhr4bCsETicoU99z363RVwBavgDSI2t
   HBzC2x8U/9ET9oSyVrPh2B0PC4cv3qFOH+k3A8qshlHSD9KCFa+uY9Grg
   SJywGZt6MnMv7nBgtARwqnX+Sylm/H6fbtDBFoFytFqimLXCxssT5fYgk
   gZT319xcGpfVFSv2U20jXtDjYSorGM0hWOjcBFtJUuMj0ml2R77OWj9nR
   2+nfH3LkuQpUj7haa/+Pke72nAdlw0mF1BDioERag3mgfZHZr+vVqLfqX
   3MaXIj/pZhkILVaWN6QyesfzbzrUT6W10tspF+3/UWYNw67INAOjmeaK7
   g==;
X-CSE-ConnectionGUID: 87QMfulwR7ez8bKqbxB2Wg==
X-CSE-MsgGUID: vWlDeE8lTgOrFlCzJBuXKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84322819"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84322819"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 10:58:32 -0700
X-CSE-ConnectionGUID: pkLC4B36SJC05LijJsRhWQ==
X-CSE-MsgGUID: GSasUqeuQ9axFcZZiXeitg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="258223479"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.111.97]) ([10.125.111.97])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 10:58:31 -0700
Message-ID: <ec235cb20601651d7073949fdb913c96fb742ead.camel@linux.intel.com>
Subject: Re: [PATCH v3 2/2] HID: sensor: custom: Fix field sysfs group
 cleanup on failure
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Haoxiang Li <haoxiang_li2024@163.com>, jikos@kernel.org,
 jic23@kernel.org, 	bentiss@kernel.org
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 08 Jul 2026 10:58:30 -0700
In-Reply-To: <20260707071545.3087073-3-haoxiang_li2024@163.com>
References: <20260707071545.3087073-1-haoxiang_li2024@163.com>
	 <20260707071545.3087073-3-haoxiang_li2024@163.com>
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
> hid_sensor_custom_add_attributes() creates one sysfs group for each
> custom sensor field. If sysfs_create_group() fails after some groups
> have already been created, the function returns the error without
> removing the previously created groups.
>=20
> Add a local unwind path to remove the groups that were already
> created.
> With enable_sensor exposed only after the field attributes are ready,
> this path can free sensor_inst->fields without leaving enable_sensor
> able to access pointers into that array.
>=20
> Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor
> support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/hid/hid-sensor-custom.c | 9 ++++++++-
> =C2=A01 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-
> sensor-custom.c
> index 6b0da2e0e1c9..c2b425afd951 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -609,7 +609,7 @@ static int
> hid_sensor_custom_add_attributes(struct hid_sensor_custom
> =C2=A0					 &sensor_inst->fields[i].
> =C2=A0				=09
> hid_custom_attribute_group);
> =C2=A0		if (ret)
> -			break;
> +			goto err_remove_groups;
> =C2=A0
> =C2=A0		/* For power or report field store indexes */
> =C2=A0		if (sensor_inst->fields[i].attribute.attrib_id =3D=3D
> @@ -621,6 +621,13 @@ static int
> hid_sensor_custom_add_attributes(struct hid_sensor_custom
> =C2=A0	}
> =C2=A0
> =C2=A0	return ret;
> +
> +err_remove_groups:
> +	while (--i >=3D 0)
> +		sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
> +				=C2=A0=C2=A0 &sensor_inst-
> >fields[i].hid_custom_attribute_group);
> +	kfree(sensor_inst->fields);
> +	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0static void hid_sensor_custom_remove_attributes(struct
> hid_sensor_custom *
