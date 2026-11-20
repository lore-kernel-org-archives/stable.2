Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170124;
	b=aQP5FNsAg06sterXp159eJe+9lg7DwqnJfDUIdZ502LeikjKCQpp8OwcF0KJ9abnT632
	 P2/BohlG5PIFYQa4iy8nRsyHW6XNFROKdike6tpo+pg9BhCO/oD7RV5xBFSX3uzYLD/8Q
	 mLhNIYsZHTF6YfncAGpXNQOxwQZRhbQ/QWt0vsQ9IndOcRtoZn3wsNkj1YTOFL7l09ETU
	 WwDR8ed670YlWAX1LBpNX/cd1bbkcJyCRYxGMY+MavW6+50fydwewopbnYHUiKyqjKulx
	 yUPwPfJOyX2CM+Zm8PeBRTnPogJN7U6ytArE+EoChQFctmMAJc4qamWft6FEVbVnN1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170124;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:
	 Organization:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=PPJHRqsQlNvWxxedFYveMwrS2/TpdJXsNJHjKYC4tUo=;
	b=wEaMoe5q6ggQHk9eMB0I3q+xv2EnueJgm98/h1jU5vVkF8GK6DxZv9aP0gTn2X402V/p
	 kKreb+DWMHCYoc2LiAs27gIkSbnljpI7uznJxYdwE7khu2V0e4+fJNeREcLXigeRdqLrZ
	 0KjZ2wgnHi1p8vqOEmc8XqQPreFioO4U/JHBNpAbh1MTBSEDhF+z/Uuwyj9JYWJqqFZ0x
	 LEC7a4duXesLgCjYT6Oh7eRoJZhvNG+mhNPKUpFvsZ2tPv16i0dZzO1Q7+6vvA+rBYulS
	 +2u/TRg47uvEG1ZGvJS6S1mW+89HsqLKDFw9Y++FB5EZwre1/hWQvXKMxDMwmD0yC4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="ONN3J/9H";
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0521F606A330;
	Fri, 20 Nov 2026 10:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0521F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ONN3J/9H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795170125; x=1826706125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IcbP5yeXtCXrloyB0OiSCOhsyIq1/E9gXNAnqXffbDs=;
  b=ONN3J/9Hw+SJTYz0DYmGJcoD9/czYv7mEbHsySwrLtUWJFTNzkynsk6p
   G0QP/Cw/zkq0Ri0tBUv5H04zKhwI62NIaHmqdd+yRPqKU9pJXs9b6nSsj
   BaUO9uIriYJ2rhJeTz4y/FXYK5TNJu8aufVi9nCV+vuaNbEnTFO0YV/b+
   6ZimRAiOEGpuP0MDT7N41VrJ8K8vTogMYa8G+ZoJlNODbPpWeRz6+2i2M
   LGNhr20x+MZgh3K5NhnaqQWDyQSOsj53JEpgMBX1f67uQxM2V3aj7P0B8
   Ol2njluwuxHE+no46bd7c+K/T4/dNcpKazF1RKfWRLB0Ry4LoY/L1g+a4
   A==;
X-CSE-ConnectionGUID: ZUP5W57XSzeoox8OY/HT5w==
X-CSE-MsgGUID: k0GxggKpSH+rf1rKK4N2PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3892869"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3892869"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 02:22:04 -0800
X-CSE-ConnectionGUID: 8wKiVcJaT9qyZbRkw20/hA==
X-CSE-MsgGUID: 3Sw4DkFAR6C68z471hi4ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="10743133"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.253])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 02:22:01 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 267DE121B79;
	Fri, 20 Nov 2026 12:22:00 +0200 (EET)
Date: Fri, 20 Nov 2026 12:22:00 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Bingbu Cao <bingbu.cao@intel.com>, Tianshu Qiu <tian.shu.qiu@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, Hongju Wang <hongju.wang@intel.com>,
	Hans Verkuil <hverkuil@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] media: ipu6: return -EBUSY from busy video S_FMT
Message-ID: <awAfSOgA1thKEAWt@kekkonen.localdomain>
References: <20260513222534.2787169-1-michael.bommarito@gmail.com>
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
In-Reply-To: <20260513222534.2787169-1-michael.bommarito@gmail.com>

Hi Michael,

On Wed, May 13, 2026 at 06:25:34PM -0400, Michael Bommarito wrote:
> ipu6_isys_vidioc_try_fmt_vid_cap() rejects video format changes once
> the vb2 queue is busy, but ipu6_isys_vidioc_s_fmt_vid_cap() ignores
> that return value and still commits the user supplied format to
> av->pix_fmt:
> 
> 	ipu6_isys_vidioc_try_fmt_vid_cap(file, fh, f);
> 	av->pix_fmt = f->fmt.pix;
> 
> That lets userspace allocate and queue buffers under one capture
> geometry, then change av->pix_fmt before STREAMON.  The queued vb2
> buffers keep their original plane sizes and payloads, while the IPU6
> stream setup later derives firmware output width, height and stride
> from the mutated av->pix_fmt.
> 
> On a Dell Precision 5490 with a Meteor Lake IPU (8086:7d19), Ubuntu
> 26.04's 7.0.0-14-generic kernel, and an ov01a10 sensor path through
> IVSC to /dev/video32, the following sequence reproduced the bad state:
> 
>   1. set /dev/video32 to 640x480 BG10
>   2. REQBUFS and QBUF two mmap buffers
>   3. call VIDIOC_S_FMT again with 1280x800 BG10
> 
> The second S_FMT returned success and G_FMT reported 1280x800, while
> QUERYBUF still reported the old 615680 byte queued buffer lengths.
> A subsequent STREAMON on the same live sensor route wedged the host
> display/system hard enough to require a power cycle.  No KASAN,
> IOMMU, oops or persistent crash record was captured, so this should
> be treated as a local availability failure rather than a demonstrated
> privilege escalation primitive.
> 
> Return the try-format error before committing av->pix_fmt.  This
> matches the metadata S_FMT path, which already checks vb2_is_busy()
> before assigning av->meta_fmt, and preserves the intended "no format
> changes while buffers exist" invariant.
> 
> Tested on the same machine: with the patched modules loaded the busy
> S_FMT sequence above now returns -EBUSY and av->pix_fmt is left alone,
> while v4l2-compliance -d /dev/video0 still reports 48/48 pass.  The
> existing compliance suite does not exercise S_FMT after REQBUFS, so
> adding a busy-queue case there would catch future regressions of this
> shape.

Can you sanitise this a little? The commit message is exceedingly long
compared to what the patch does.

> 
> Fixes: d3bd039cd2a0 ("media: intel/ipu6: support line-based metadata capture support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> Assisted-by: Codex:gpt-5-5-xhigh
> ---
>  drivers/media/pci/intel/ipu6/ipu6-isys-video.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/pci/intel/ipu6/ipu6-isys-video.c b/drivers/media/pci/intel/ipu6/ipu6-isys-video.c
> index 3ac48d2076da..88fceab6ed86 100644
> --- a/drivers/media/pci/intel/ipu6/ipu6-isys-video.c
> +++ b/drivers/media/pci/intel/ipu6/ipu6-isys-video.c
> @@ -323,8 +323,12 @@ static int ipu6_isys_vidioc_s_fmt_vid_cap(struct file *file, void *fh,
>  {
>  	struct ipu6_isys_video *av = video_drvdata(file);
> +	int ret;
>  
> -	ipu6_isys_vidioc_try_fmt_vid_cap(file, fh, f);
> +	ret = ipu6_isys_vidioc_try_fmt_vid_cap(file, fh, f);

TRY_FMT should succeed while streaming so can you align this with how it
works for meta capture?

> +	if (ret)
> +		return ret;
> +
>  	av->pix_fmt = f->fmt.pix;
>  
>  	return 0;
>  }

-- 
Regards,

Sakari Ailus
