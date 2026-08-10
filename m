Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671B93B7B9D;
	Mon, 10 Aug 2026 10:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357761; cv=none; b=ODVllZLowZ6tsAhkzY+0HV1F5z7hlgcq3eyP6w6Ofb2mh3yd5kcbqMZeC/j6KY4XXBAT0fw635ATCEpYwT7YRGncCr8C86kFht+9+KSpALkLZ4icWqXd/NtDEqrDMWxMLyPrTsy62/gzjxqL2ORqY/rN4mFX6qyD1qOQAfsuVHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357761; c=relaxed/simple;
	bh=ZGYZG6uK03QhJLmCfvKV4w7Vwd4H4WQZh1TvT+dbNIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gwx4IuLecFt9t8y3IQMPVo2ezSOgsimZpFPWoQeZsoUJu6Ynexk8yDoSy9ESatVd9UNoWjr08X/vOWNRnDj3HO7pu6a6W0iKT2Socpx+Yk1j3AuwxBGiTKImMZpzZ7P/R/fd1hbj9iSLb+o1XZksNQfR4+4RTIV4+lu3wxviBCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAXFjQl+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAXFjQl+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB121F000E9;
	Mon, 10 Aug 2026 10:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786357760;
	bh=ZGYZG6uK03QhJLmCfvKV4w7Vwd4H4WQZh1TvT+dbNIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OAXFjQl+tUBZcHW+2PrgwbhovzhllTVUGIhiNAaUIO0wpDYz0Bv7tolJBz3NhavX6
	 wreLKtVjIQJBUheiQNTqYeGo2U4gR1Wf3D/faUiNtW9xRNS3fph5aSKqYUzPVXlhQy
	 mX4MF+cC5DEB4VviEeYZI8b9S6lZdTKV3xBN302GPWErseJGMyJvjBsTRhKRUMq6bl
	 3plmEg2Xl0NwFIxnSOGQ1mJ1xZ2tBHxo7mSuvY2ZoL35k9IaVdvIaum+cEezlWj9nx
	 tR+S2eqyoQO1qIA0fuheMoJChgjJO6rgnDf8yCRpPU/Wel3O/wkv1hrJlivF9zMKke
	 FfiFL+oG5MqaQ==
Date: Mon, 10 Aug 2026 11:29:15 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Junjie Cao <junjie.cao@intel.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org, Pengyu Luo <mitltlatltl@gmail.com>,
	stable@vger.kernel.org, Junjie Cao <junjie.cao@linux.dev>
Subject: Re: [PATCH v3 1/3] backlight: aw99706: Fix DT property names to
 match binding
Message-ID: <anmn-xaMAS6ZuT0x@aspen.lan>
References: <20260804030255.1934470-1-junjie.cao@intel.com>
 <20260804030255.1934470-2-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804030255.1934470-2-junjie.cao@intel.com>

On Tue, Aug 04, 2026 at 11:02:53AM +0800, Junjie Cao wrote:
> From: Junjie Cao <junjie.cao@linux.dev>
>
> The driver reads four tuning properties without the unit suffixes that
> the binding mandates: "awinic,sw-freq" instead of "awinic,sw-freq-hz",
> "awinic,sw-ilmt" instead of "awinic,sw-ilmt-microamp", "awinic,iled-max"
> instead of "awinic,iled-max-microamp", and "awinic,uvlo-thres" instead
> of "awinic,uvlo-thres-microvolt".
>
> As a result, device_property_read_u32() never finds these properties in
> a binding-conformant device tree and silently falls back to the compiled-in
> defaults for switching frequency, switching current limit, max LED current,
> and UVLO threshold.
>
> Fix by aligning the property name strings in aw99706_dt_props[] with the
> binding. No value/range changes are needed since both sides already use
> the same units and enumerations.
>
> Fixes: 147b38a5ad06 ("backlight: aw99706: Add support for Awinic AW99706 backlight")
> Cc: stable@vger.kernel.org
> Signed-off-by: Junjie Cao <junjie.cao@linux.dev>

There don't seem to be any usage of these properties in-tree so I think
it is probably OK to change the driver behaviour without fallbacks for
DTs with version skew!

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
