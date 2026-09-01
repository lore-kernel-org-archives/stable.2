Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AEA2C3251;
	Tue,  1 Sep 2026 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282953; cv=none; b=Zw5tFjAf3gh/GIotcst9LLIFTX0qasfRPTmKuWwW9ORSghhd9OmYEOo1RiadB9wYb9ow1B/ywEfmLYiJTNBxs+wuyvK7Xwo9nV8OY3Ro2CnxhRV7kFc0VJWf7ln5DoazWYogwZuLBgxdP8fc3h2hvHi9Fe6UvY8EyieqP14FHaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282953; c=relaxed/simple;
	bh=CiWW68rJYLvT9WDyIcblA7fuOvr7vxRcLuhK+Wd6Bp4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fybRaLQOFWCmX/C3pX+btz9xe0jA3kbVejZSlCA0F2UEMD6F2P5NrVEJmmO9xxojmaPWZoOGx7tACPMe5IazRjDuWEXsIn7PxJ4bhAAR9A8MnXyzkmF0pxpsedYWsEj9hjVcu1Zr6Us/MfEJf4xDVXki8lBVpgtDZmxw6HrgCcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOxvcA0z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOxvcA0z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB771F000E9;
	Tue,  1 Sep 2026 17:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282952;
	bh=pv2dlBCPWCZAKqLtkQsDT9z0FmdKk63Ru0QlS/7LwR4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=XOxvcA0zp3q4z1R5WIUxGCJG9cMSTDUcNL4KTbTrGblH3Hv6jumiOIgLarzCYpHX4
	 upQlhvLirebk3g/p/o2IbMRkR89/pSStmu/X7NZEvbSDoKe0IrPO+IyweYihYZMOiN
	 azJPh/E1Dw2c0DrDVSb+qVtN4eGrGVGNhOF8vvLZ6gk8/2u2sQDQDb9DieNWPgEFOe
	 YHdoy1LDmPCEyKyXReu5ME8r0wA4eJKKWR91MeKzq6lRXrUre/B2PjoLKy62bHMAb9
	 Jg832V/oX0BqgG1pmNRgOfz2Ya3L0YUAJ6Xhi/oOa3M72Ju+t3Uo9SGJZpVrXR3jQD
	 IBcRnaNF976Zw==
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>, Boris Faure <boris@fau.re>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260820212220.226912-1-boris@fau.re>
References: <20260820212220.226912-1-boris@fau.re>
Subject: Re: [PATCH] soundwire: intel: initialise quirk_mask before reading
 it
Message-Id: <178828295003.1399388.6382673763123837067.b4-ty@kernel.org>
Date: Tue, 01 Sep 2026 22:45:50 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 20 Aug 2026 21:22:57 +0000, Boris Faure wrote:
> sdw_master_read_intel_prop() declares quirk_mask without an initialiser
> and ignores the return value of fwnode_property_read_u32(). When a BIOS
> does not describe "intel-quirk-mask" for a link, the property read leaves
> the variable untouched and stack garbage decides whether
> SDW_INTEL_QUIRK_MASK_BUS_DISABLE is honoured, so the link may be marked
> hw_disabled at random.
> 
> [...]

Applied, thanks!

[1/1] soundwire: intel: initialise quirk_mask before reading it
      commit: ee8a8cfe4e8d3c67456e554c988017c252710a25

Best regards,
-- 
~Vinod


