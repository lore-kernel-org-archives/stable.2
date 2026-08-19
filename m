Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3944432EC;
	Wed, 19 Aug 2026 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787132047; cv=none; b=UX7BYpDIW2Ul92X/eMVhD8qd/JlkRpUXleww90ck+0PbqG2h+GinmrQfhPZE227C4NZqxmKyiXyDKIXF1Cep9jL0Y5E/czo46th/xrR7VMrBka2cyb6B+KMHOwkKO2+vkDESy/bqGCFBAHApKrYVTCcJo3iNWN5bgf7cL1Xzcl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787132047; c=relaxed/simple;
	bh=jKQNWWD/Gc/w9bX1GG77bZu53GuStYaq9fdegksXIYk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hJe7PHmy8ldbYBYB8pHi5NQNbwekJT0LuSpzmoq5dzsJQqQkZPUgNatEzAiB1RBLg1ui3Vxj1K/eJ+ouV+5kVZR1UExREU/NVZ0kdZN+oE6xNzqdTDz55OaDk0zU209Foo40zcYUvhRbj26DTf0YDBLUdDhSYv0msYbS9BRklYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T7XWlBSc; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T7XWlBSc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787132044; x=1818668044;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=jKQNWWD/Gc/w9bX1GG77bZu53GuStYaq9fdegksXIYk=;
  b=T7XWlBScIFZDY0CZtlrvhPo4g6ypLeGSjMnYuNET2j3pXkuORE/ypE6Z
   vOzWgxFBZbTjyZIzbN6uwu1LjOhLkaqIA4MFw0MLMtrenn8yfs2GwnrBh
   FTe7xEpOJTIfoXvBja7siCN4aX+LRe3cAhEENhsx+0Kt5ts2en8hWcGXR
   XjaF8i2TBF/Vwe6+pWk4djF1tXTuCO2Ui/p2Tx2o54WYEBTgchtjKQzuX
   /2HSyYB4pnc8led18VP/muqSRsQ6zRwSF0zTDQzYjG0GX3sqeCn96HGHl
   r11l+9o7IDVcmzdU+Tw2y8FBVS0YgfLmig2ayd4VGeQUVvt5Pw2mUGj0p
   A==;
X-CSE-ConnectionGUID: n3CC0L7hQg6rL3SRNIqG/Q==
X-CSE-MsgGUID: sSVhRRLuR9uJ8LlnCYAS4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="91513944"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="91513944"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 02:34:04 -0700
X-CSE-ConnectionGUID: Z6To4bweTKWz8fzQb15eCg==
X-CSE-MsgGUID: 6/5px2TlSr+/sa5+menGaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="289002082"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.152])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 02:33:58 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: =?utf-8?Q?Chang_Jiong=28=E5=B8=B8=E7=82=AF=29?= <xspeed1989@gmail.com>,
 intel-gfx@lists.freedesktop.org
Cc: =?utf-8?Q?Chang_Jiong=28=E5=B8=B8=E7=82=AF=29?= <xspeed1989@gmail.com>,
 stable@vger.kernel.org,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Ville
 =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, =?utf-8?Q?Micha?=
 =?utf-8?Q?=C5=82?= Grzelak
 <michal.grzelak@intel.com>, "open list:INTEL DRM DISPLAY FOR XE AND I915
 DRIVERS" <intel-xe@lists.freedesktop.org>, "open list:DRM DRIVERS"
 <dri-devel@lists.freedesktop.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/i915/cdclk: Don't force cd2x pipe select on Xe3
 in bxt_sanitize_cdclk()
In-Reply-To: <c4dead5d0527e305f44ddb943f95e9967ec1911f@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <tencent_6CC00E822A788776C8F6E2D6B24C5FE4A909@qq.com>
 <20260816062344.796615-1-xspeed1989@gmail.com>
 <c4dead5d0527e305f44ddb943f95e9967ec1911f@intel.com>
Date: Wed, 19 Aug 2026 12:33:56 +0300
Message-ID: <c779c8e8fc78c68aea12c2022b2d8c64541ca173@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Aug 2026, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Sun, 16 Aug 2026, Chang Jiong(=E5=B8=B8=E7=82=AF) <xspeed1989@gmail.co=
m> wrote:
>> Since commit 2ee8dbd880b1 ("drm/i915/cdclk: Fix up CDCLK_FREQ_DECIMAL
>> without a full PLL re-enable") bxt_sanitize_cdclk() normalizes the
>> CD2X pipe select field of the CDCLK_CTL readback to PIPE_NONE before
>> comparing against the expected value.
>>
>> However bxt_cdclk_ctl() does not include the CD2X pipe select field
>> at all on DISPLAY_VER() >=3D 30, so on Xe3 (PTL) the normalized
>> readback (pipe field forced to the PIPE_NONE encoding, 0b111) can
>> never match the expected value (pipe field 0). The comparison now
>> fails on every boot and we always take the full CDCLK PLL
>> disable+re-enable path with the BIOS framebuffer actively scanning
>> out - exactly what this code was trying to avoid. On a Panther Lake
>> laptop (Arc B390, 8086:b080, eDP 3120x2080@120) this causes
>> "CPU pipe A FIFO underrun" during probe and persistent full-screen
>> scanout corruption for the first KMS client (the SDDM greeter);
>> the corruption lasts until the next full modeset.
>>
>> Only normalize the CD2X pipe select field on platforms where
>> bxt_cdclk_ctl() actually programs it, mirroring its DISPLAY_VER()
>> check.
>>
>> Fixes: 2ee8dbd880b1 ("drm/i915/cdclk: Fix up CDCLK_FREQ_DECIMAL without =
a full PLL re-enable")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Chang Jiong(=E5=B8=B8=E7=82=AF) <xspeed1989@gmail.com>
>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8550
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8569
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8901
>
> The first one has a patch from Ville that is identical to this one.
>
> I'll try to kick CI to get this tested before merging.

Okay, the patch is against some stable kernel, not against the current
development tree. Please rebase on top of the drm-tip branch of the
drm-tip repository.

Thanks,
Jani.



>
>> ---
>> v2: No code changes. Resent with From matching Signed-off-by
>>     (v1 was sent from 304750714@qq.com, which is not on the
>>     Intel CI allowlist).
>>
>>  drivers/gpu/drm/i915/display/intel_cdclk.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.c b/drivers/gpu/dr=
m/i915/display/intel_cdclk.c
>> index 7bc9b956554b..0438f5ac78c0 100644
>> --- a/drivers/gpu/drm/i915/display/intel_cdclk.c
>> +++ b/drivers/gpu/drm/i915/display/intel_cdclk.c
>> @@ -2366,8 +2366,10 @@ static void bxt_sanitize_cdclk(struct intel_displ=
ay *display)
>>  	 * dividers both syncing to an active pipe, or asynchronously
>>  	 * (PIPE_NONE).
>>  	 */
>> -	cdctl &=3D ~bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
>> -	cdctl |=3D bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
>> +	if (DISPLAY_VER(display) < 30) {
>> +		cdctl &=3D ~bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
>> +		cdctl |=3D bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
>> +	}
>>=20=20
>>  	if (cdctl !=3D expected) {
>>  		if (DISPLAY_VER(display) < 20) {

--=20
Jani Nikula, Intel
