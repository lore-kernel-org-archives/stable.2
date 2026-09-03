Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083ED4F55B2;
	Thu,  3 Sep 2026 19:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463583; cv=none; b=LfYxNS9cnV4usP7B6NSS4dYqu6kLl5zq5nvyu98UBPH/ZwJx00x7m2XbhbNnH8o9BSV4X4DnrN2nFzebtRSOHQhBEXl3Jv0VXm6dDoOvXeRzs7ALwyCBrtD/MxzRsCS5XKh9/oYe25PZhAzPZ6gurLrLuHczJIL4cK8fqKCZkbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463583; c=relaxed/simple;
	bh=lD2RsRY9rXCI10YrLYKJnzSLwzrR+W32yJXpv0AEvMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/7iLbjxtoRIc6yJWr9K9k5RoOAwtbHDAREIVRaidhHgsjIGPlX5HPDDvFp1QNIeBqEfbM2WG6xrsZtzxnyUT592je/3PinzLyIpnx11VgVQFgIklLVSXE8ms+fAkM2pSC7/ZLr6rt41HHpAihfrOwgbd6Gs/PPwvYQQkjZi4z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UfobrVgn; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UfobrVgn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788463575; x=1819999575;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lD2RsRY9rXCI10YrLYKJnzSLwzrR+W32yJXpv0AEvMA=;
  b=UfobrVgnr4I7zKXywz396ameSE/etI9r/Fq2ULjM/N0SC8WxbxUYTUV+
   MNDeK0istHarvYpKHzF2Uy28r8YWbUTaqz1H4/yN6PsRBxFjw5sBDK8QO
   LMCEmVbeLCSpVVMZ4PRK456QhEBZNvPie6SS+QNIjt7caVsz0RAIR30m2
   2gDL+Zxq4BpVKjJumJ9A8OI6RCDhVIpG5uxvlj7Il4zqMPWAtWtwmidfv
   zHfwfaSTHOGNQp5Qwg2SzkkMP/EcCM/LxCMPfeXSVlyPrN8xwONwTJZnY
   lJ3GQ/boirESNVj/5CeYR7xvWnPtVvlXrhNiOpd+djMdGtJpd6/hZw1t3
   w==;
X-CSE-ConnectionGUID: tuqhaPe1QhSf/5cvAXAD4Q==
X-CSE-MsgGUID: hnsb+v2ORTG7AgwajE3iVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92828298"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="92828298"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 12:26:07 -0700
X-CSE-ConnectionGUID: GsUAz88HQX2GkpjnX3e7ow==
X-CSE-MsgGUID: DBnmtXTISPSBDAHxq/j/Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="273969149"
Received: from alekseim-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.184])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 12:26:06 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 870E8121BCF;
	Thu, 03 Sep 2026 22:26:03 +0300 (EEST)
Date: Thu, 3 Sep 2026 22:26:03 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Pierre Pinon <pierre@pinon1.fr>
Cc: Miguel Vadillo <miguel.vadillo@intel.com>, linux-media@vger.kernel.org,
	Bingbu Cao <bingbu.cao@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: i2c: cvs: register subdev nodes when the remote
 sensor binds
Message-ID: <apnJyxxoHz3TTZur@kekkonen.localdomain>
References: <20260903125014.612053-1-pierre@pinon1.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903125014.612053-1-pierre@pinon1.fr>

Hi Pierre,

On Thu, Sep 03, 2026 at 02:50:13PM +0200, Pierre Pinon wrote:
> The CVS bridge picks up the remote sensor through a v4l2 subdev notifier
> of its own, but nothing in that path creates the sensor's device node.
> The IPU7 ISYS driver calls v4l2_device_register_subdev_nodes() from its
> own .bound -- which runs for the CVS subdev itself, before the sensor
> behind it is bound -- and from .complete. The sensor's node therefore
> depends entirely on .complete being reached.
> 
> That does not happen when another sensor on the same notifier has no
> driver. On a Panther Lake laptop ipu-bridge instantiates two camera
> endpoints, OVTI08F4 (ov08x40) and HIMX1092; there is no driver for the
> latter, so it stays in the notifier's waiting list forever:

Thanks for the patch.

Antti sent a patch to address the same issue a moment earlier and that has
been now merged (commit 7456b40bc992a3fc34b587545716729923d507b9).

-- 
Kind regards,

Sakari Ailus
