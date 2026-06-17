Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAC5388374;
	Wed, 17 Jun 2026 10:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690583; cv=none; b=W9357bzpxO62RITdLXY5WiQ69Hg9TObBv0bKPQrBEsqQW7hIR7jqBQjqD7FS40LpuKjdUc9JV4LGw39jN9SknyKCN0AMVHJ5xAtSrmkK51U0Sp86xHvI8AmzKy0YL/g/bGioSKNj5GJtgyPn7LiNdRlRPyNWAq77XT4uZxYptZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690583; c=relaxed/simple;
	bh=ADT1HTaUENYBvVMSSkOSh6M3ht4EbVqx/pv3emwAuw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdPx4NhdIO38H9tFf23Zylc9TBpTzZC7RvC33zfKKT0YlIbcVYb4mqPziw6hZsH0sI8omrwGJQGJ+jGXEKujMqaESWAzo0/Zw5+0EHtB7ZAPENtJbO20lX/78V1V45OK4f3PC0oS/Jc76TqpLKBo82MAXCDjc1/zq9asLiifYYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AddNqM8C; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AddNqM8C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781690582; x=1813226582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ADT1HTaUENYBvVMSSkOSh6M3ht4EbVqx/pv3emwAuw8=;
  b=AddNqM8C9K+oKR+5vfS2NfCq5+FWoFj5WdeR/aG72aHkWixNDHroTY2l
   ScPuIjEBa/bucAQ/suMmZeeYyTJLeSC+RzNdI9zm5eUEDupQNhrAbFx18
   YLpKOcd39ib4ndFkY3pogBbQzh8LnUQwNOhw/JnWvvY1ftmbN3gxUn1RG
   3rkpp/vhH8LX5RLEg9Ocd2NiImNn+SwoEqj3iAyXwjuwKWDU+8Hi4+ED5
   mYjQPrR5Co+MjLYMLRIfiFgbyCC21kds7mWGlWqx+l8h+TJWZV2MMnVaP
   muxViv/D7Si0aZ93E6Lk24gFmme2D1/cHkNUyVcscgQ9G4MJKEp2appcL
   Q==;
X-CSE-ConnectionGUID: Bc9n01ruRWKVMT3wbgHm8Q==
X-CSE-MsgGUID: K/7RkrteSnqNrIncLBYwrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="92830362"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="92830362"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 03:03:01 -0700
X-CSE-ConnectionGUID: bZbkiVwWRMOty6xxyFJ5Rw==
X-CSE-MsgGUID: /4h9CwtxROmFk31G+h49uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="241663123"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.69])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 03:02:56 -0700
Date: Wed, 17 Jun 2026 13:02:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Herman van Hazendonk <github.com@herrie.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Denis Ciocca <denis.ciocca@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Denis Ciocca <denis.ciocca@st.com>,
	Linus Walleij <linusw@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	devicetree@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: common: st_sensors: honour channel
 endianness in read_axis_data
Message-ID: <ajJwzsIMxX3Ew1x_@ashevche-desk.local>
References: <20260616-submit-iio-lsm303dlh-magn-fixes-v2-0-063edcf74e60@herrie.org>
 <20260616-submit-iio-lsm303dlh-magn-fixes-v2-1-063edcf74e60@herrie.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260616-submit-iio-lsm303dlh-magn-fixes-v2-1-063edcf74e60@herrie.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 03:02:04PM +0200, Herman van Hazendonk wrote:
> st_sensors_read_axis_data() unconditionally decoded multi-byte
> results with get_unaligned_le16() / get_unaligned_le24() regardless
> of the channel's declared scan_type.endianness.
> 
> For every ST sensor that has used this helper since it was introduced
> this happened to be fine because the ST IMU/accel/gyro/pressure
> families publish their data registers as little-endian and the
> channel specs in those drivers declare IIO_LE accordingly.
> 
> The LSM303DLH magnetometer however publishes its X/Y/Z output as a
> pair of big-endian bytes (the H register sits at the lower address,
> 0x03/0x05/0x07, and the L register immediately after), and its
> channel specs in st_magn_core.c correctly declare IIO_BE -- but
> read_axis_data() ignored that and decoded as little-endian, swapping
> the high and low bytes of every magnetometer sample. The LSM303DLHC
> and LSM303DLM share the same st_magn_16bit_channels (IIO_BE) and
> were therefore byte-swapped by the same bug; users of those parts
> will see different in_magn_*_raw values after this fix lands.
> 
> The bug is most visible on a stationary chip: in earth's field the
> true X reading is small and the high byte sits at 0x00, so swapping
> the bytes pins sysfs X at exactly the low byte's pattern (e.g. 0x00F0
> = 240). Y and Z still appear "to vary" because their magnitudes are
> larger and the noise in the low byte produces big swings in the
> swapped high byte:
> 
>   before (LSM303DLH flat, sysfs in_magn_*_raw):
>       X=240 (stuck), Y= 12032..23296, Z=-16128..-9728
> 
>   after (direct i2c-dev big-endian decode, same chip same orientation):
>       X≈-4096, Y≈210, Z≈80     (sensible values reflecting earth's
>                                 ambient field at low gauss range)
> 
> Fix read_axis_data() to dispatch on ch->scan_type.endianness and
> call get_unaligned_be16() / get_unaligned_be24() when the channel
> declares IIO_BE. Existing IIO_LE consumers (st_accel, st_gyro,
> st_pressure, st_lsm6dsx and others) are unaffected because their
> channel specs already declare IIO_LE and the LE path is unchanged.
> 
> While restructuring the branches, replace the previously implicit
> silent-success-with-uninitialised-*data fall-through for
> byte_for_channel outside 1..3 with an explicit return -EINVAL. No
> in-tree ST sensor publishes such a channel, but the new behaviour
> is strictly safer than handing userspace garbage.

Sounds like inevitable change in ABI, but worth doing it.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


