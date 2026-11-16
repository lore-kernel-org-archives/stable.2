Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822432;
	b=n90cDIqS2J+1eXFot/YC4VqUqUobESzWZ0RXi/YIr7xkcmFgrsI4V2bGpL42oNcP3NtS
	 ne+fbiJI48xQJpQrtPjqDrKLpupXdsDy9i281p4AlAM5FqZ/VG0jjjazKY05PiNsnlI6L
	 2OBHWqkM/o9oPjbeF8ZlWIALJ0sFUEC0Fp0MX1RFNIzuoWjVYZ83vomxkTDgQ48AnkUtr
	 sULL6zJxaXbDL+/xm3+mwCFoWJxXx3SDJfs1iQy8RxjWXwYCBKFPbPeSoC1Fk+3NxIbG5
	 w4MhrpoYmGchEqkLqVhVprCaXdYKez8aJEJWAZpcf04Avlj+0P6oRyI+TV/ccBQEkHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822432;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:
	 Organization:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=2hCw0HfXzgsJrvrdvNR1avGGnl1bLaFhXU7I6fhVLlk=;
	b=ycLRAD72rpWWMaUv4/xxRdjXG8l60smNhVat2/p0U/BkO8y91ueQHEtpfOG+O7Tnh6oa
	 6tZ06Q3f0uhIMvyvHewNCQF1W+iU4FAXGr+g+RSgSGqNRhvSLNaovobTKhfec+mevRsSt
	 0aUuxBxfBEdmDua8kY1C5IlcuglTjfmCYbK6D5D1sfcl9uL02ugItpnU+qKRJCpm6X5UB
	 kp6R22EAz89n+pEwgjUijR3BHMxXY921HaAgRmN+ONM/28kllKnCrEP7cKkmT369Gpw8s
	 ht3lVTRDIP9x/AGNWCZ9vKyeUDcKpMPuXy8xlGQH8+a0QRwvhqyNvFdHe76LT16NBZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KEgnCGgu;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF95606A32F;
	Mon, 16 Nov 2026 09:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DF95606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KEgnCGgu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794822432; x=1826358432;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yBaVqlPLhm2b7IcfoxaduU8wWVJRVxWQ5qIOXtjzCrI=;
  b=KEgnCGguwXBPHwqHkxkv5SpZkuOPY0Jg8lr9b7w9c/srd4oPUQHNhL31
   oEtBv+HWPE7gc78ZKnOxW8OkduQunhDzSbeuP2Jzro2lSsMYwCztK1QS/
   jnpEkJUtOxSFDKkrS5/UcoTGl5O+FvJwZJ0zvQ+MP2bjO2i6T2RhvsdzL
   yPqWe9CsDHwBjku0SEP2L5FjFuVFjTT88aDCO3rI8kttii5Njxe3/wtd5
   1AVyoz2KGbS3LzqGmT5sohP/NFS7d/4RvuIbgRIq8FT2y6vgNVFFcz62k
   wL6Y6CiMqklDrHxCFk9/vIep+0iwdTsaRn8Ww9FDR7+3g7mz27MWOT7tm
   g==;
X-CSE-ConnectionGUID: 5aOODXrTSx+A5nZXJnGD8g==
X-CSE-MsgGUID: AMwZhRBoT12xrhi5J1HxEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3446317"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3446317"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 01:47:11 -0800
X-CSE-ConnectionGUID: DBQfNFA6RzegQclU0c3CWg==
X-CSE-MsgGUID: wQg5UuoQT3WnBG5++TtTVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="11288697"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.87])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 01:47:08 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id B419E121B5D;
	Mon, 16 Nov 2026 11:47:12 +0200 (EET)
Date: Mon, 16 Nov 2026 11:47:12 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "D. Manresa" <dmanresa@gmail.com>
Cc: Jakob Berg Jespersen <dev@berg.pm>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	=?iso-8859-1?Q?K=E9vin_L'h=F4pital?= <kevin.lhopital@bootlin.com>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Fernando Rimoli <fernandorimoli11@gmail.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] media: i2c: ov5693: fix horizontal flip polarity
 and Bayer phase
Message-ID: <avrRIDjxtSPAU33o@kekkonen.localdomain>
References: <20260729-sp7plus-ov-flips-v2-0-91884b81a8f5@berg.pm>
 <20260729-sp7plus-ov-flips-v2-2-91884b81a8f5@berg.pm>
 <20260828231805.29790-1-dmanresa@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828231805.29790-1-dmanresa@gmail.com>

Hi Jakob,

On Sat, Aug 29, 2026 at 01:18:05AM +0200, D. Manresa wrote:
> On Wed, 29 Jul 2026, Jakob Berg Jespersen wrote:
> > The sensor's native readout is horizontally mirrored and the FORMAT2
> > FLIP_HORZ bits (reg 0x3821) un-mirror it; the init table sets them by
> > default (0x3821 = 0x1e). The driver sets those bits for V4L2_CID_HFLIP=1,
> > so the control is inverted: HFLIP=1 yields the un-mirrored image and
> > HFLIP=0 the mirrored one. Invert the polarity so HFLIP=0 yields the
> > unflipped image.

Can you send v2? After the V4L2 CCI conversion the patch no longer applies.

-- 
Regards,

Sakari Ailus
