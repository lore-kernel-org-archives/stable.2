Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793282353;
	b=ZQEmSne6nTwifXPe68UMP9wTxA2xk3qPvsz5RXycSor8j+ILQRPRx/L0yLhC2widwb+F
	 mA+sXhCDnzsyp4k7lWDW+jR3+ikYLN+zjRkU2JVwOBwZUViYb21bX5yEBkTBYX1Vt9A3k
	 J6xfEN9qPsqYKx/1FNZFXODr8XvvKPQNQR7UFsaejwXVqY3hfohZNI/kznygEg5BFQ8Ma
	 qLZT7P2CvVKICY2Ny0ndl6iV/VsOds7I2OagfDbkClcjMzAwbWCl0MQjW4UuJV1vbKZCE
	 3Sy8FgoXgLEIkY8Wwa1At5YZNdS1kzGao10eOIACPrMuT7fWphUNqUy9N9DSukbN7Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793282353;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=uMHXUOFE7AZZDX+LsX6dXeRhGFEiwL4Q1GknxPdY3Lk=;
	b=IGhmYWV6U3pM+qNLSCXoITj9MUf3DbmVzGtoYyJntAtsWecG1mozFiaU2RHO79NxI9Ic
	 BVX+fMpAoXxoKCKnzKEncm/3q3hQyTnKraD/vuOTysLXCYdGecBRu5QALwM5+/5QwCImF
	 ua98r6bq6clBZZuPBucjnbi1BScsiwoQRM4G1jWMQv4CE/DNhw2f6B61qJHn1IgZm2n0o
	 oadGnGGTNrTiBypu/po2Q58bI00siAT2njSMxaPAAbIElkb6fpw5X1YdDAwSe6sYsF6ck
	 ppYXkUC46ND5BIPO1O/D0dAxJmjpeRBjX0BhHoCtPc47427SUtltFp+2cH/MjYNvhWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O4kuHfCw;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852AD606A31A;
	Thu, 29 Oct 2026 13:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 852AD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O4kuHfCw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793282353; x=1824818353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6y2zegGNR4BIjDGrQ4yACT78u9RtDlzbO8PSVZOswc8=;
  b=O4kuHfCwDvlgac2o+0ut3PGOaowvaFp7HdaeRBoTAhhkyahK+rhxgnGH
   4SV7QkKEzB62Q6KXEKyxlEHGJ6Mvecb2VufP9UtyRa6vdKc9yNxF3cvRd
   3zjq9x7dQPyqlnhmIvtJCd/nB6aOTg8pcdnzFIHD/6UZasLJeEN1uLMAn
   6ZJM7m1H2WtUeZ0m/VLTStaf5RIrhkpFpiZ/9FO7YHKnFaxQKSj76RKkv
   FjFV+CP+PxFoVdO8jbQpiPnW8P4TuCnemLvp9lqBkSM/z6dNPaCo+MNvt
   YiQwpWQGfV+lqeYyR0KscK0GyuhuPcf+2cqnWNLpEi5XrJCKbbHv+sOiF
   g==;
X-CSE-ConnectionGUID: 7fvV+HqRSvS1VS+uZySmWA==
X-CSE-MsgGUID: 62snd5jeQlKakbvIWCNgjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1938066"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1938066"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 06:59:12 -0700
X-CSE-ConnectionGUID: G42LKDdkS2ezAcmcJfP6Hg==
X-CSE-MsgGUID: DBMiwUJ8R8qCvmWT+sAADw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5115670"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 06:59:09 -0700
Date: Thu, 29 Oct 2026 15:59:06 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Antoine Pichot <antoine.pichot@gmail.com>
Cc: linux-media@vger.kernel.org, sakari.ailus@linux.intel.com,
	mchehab@kernel.org, hansg@kernel.org, dan.scally@ideasonboard.com,
	djrscally@gmail.com, dmanresa@gmail.com,
	dave.stevenson@raspberrypi.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 3/9] media: i2c: ov7251: Report the pixel array rate
 for both link frequencies
Message-ID: <auNRKsUghekdXM_q@ashevche-desk.local>
References: <20261028112154.855185-1-antoine.pichot@gmail.com>
 <20261028112154.855185-4-antoine.pichot@gmail.com>
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
In-Reply-To: <20261028112154.855185-4-antoine.pichot@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 28, 2026 at 08:21:48PM +0900, Antoine Pichot wrote:
> pixel_rates[] gives V4L2_CID_PIXEL_RATE 48 MHz for the 240 MHz link and
> 63.84 MHz for the 319.2 MHz link, which is the CSI-2 bus rate of each
> link (one lane, 10 bits per pixel). The control is the pixel array rate,
> and Documentation/driver-api/media/tx-rx.rst says the bus rate "is not
> the same thing as the pixel rate on the camera sensor's pixel array
> which is indicated by the V4L2_CID_PIXEL_RATE control".
> 
> The pixel array runs from PLL2's 48 MHz system clock at both link
> frequencies: the PLL2 registers are the same in both tables, and the
> measured frame rate is 48000000 / (928 x VTS) with either link. On a
> Surface Book 2 at 319.2 MHz, VTS 1724 gives 30.0 fps; 63.84 MHz would
> give 39.9 fps. A Surface Pro 7+ measures 30.01, 60.16 and 90.45 fps at
> VTS 1724, 860 and 572, the same 48 MHz. Dave Stevenson saw the same on
> a Raspberry Pi with a 24 MHz clock, where libcamera asked for 100 fps
> and got 75, the ratio of the two rates.
> 
> Report 48 MHz for both link frequencies and drop the table.

...

> Fixes: ed9566ce1946 ("media: i2c: Add support for new frequencies to ov7251")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/linux-media/CAPY8ntBFJJPg3y46gC=bNq_55QifC7mKmeq8+pAEDVN42fGUXw@mail.gmail.com/

Same comment about Link tag.

...

> +/* PLL2 sys_clk: the pixel array clock at both link frequencies */
> +#define OV7251_PIXEL_CLOCK 48000000

Perhaps

#define OV7251_PIXEL_CLOCK_Hz (48 * HZ_PER_MHZ)

(will require units.h to be included)?

-- 
With Best Regards,
Andy Shevchenko


