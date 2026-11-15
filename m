Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794737466;
	b=tZdaBoful5dFV5Xy504wKHC7lzxGLNT9TU1jIG/r3yjK8GfZTtv98otSuhBB9bTTQi7L
	 nEHqCsCOY8tLYI1PPiUSHa0T2ygACezXj68ZTlIfRe7a6j9eWLUcygdYBwaZkAKNmHKG9
	 7q33lLryfsHEw2rF90DMQILLE1IC2vhjUUZc9anIfhRE29EsSQoT0z4zWHkIKsXrtJACC
	 c+NQ0o1TraMffEceNt6nKhKEh9V8BC6MR7eqgRfcGwqiN6Q6hTCWcwKXRucNRi8/dc3es
	 Y77jkdJ/e9/OPUQAzibMMUpSesoMIcWX6P73e52tkVWyWnuINpglMEFGmz3UesyuPdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794737466;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:Cc:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=gjD82TcVZ081tMXoRHOa1ZjFF6MbR4Jb8GtJ+0I0i7o=;
	b=gB7TvFVu3YXjBR7J65qvgzn9gPeUhtj0LxtFJ92ZOFVhstqr7CcoFVV5G0qDEpYGV9OS
	 hMCoYZ4vEKGrjo7/I7NZ4beyRFutIEacrzwm/znEXDGOq1k9ihAxJLCcCpLpY8fuh+gx+
	 s+kYcC3/r6DV/Ak+bBlRy5USGyvHYGTo0+7I/PapNQv88GrtqLO06+ph1bXhFfAPQqQUO
	 9IQiX3V4sAUD92r27gFCAkKVI+fqd8GsxHqxtYDqUKg576r94P0G/gPdivGe37KPQK9OR
	 jgXN/Q+5e77L/uSXx3nrikv7/PU5NDQjCNZi7tc1leNvbtCXFA4a8HBJaiyFpLFv2eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CkPbNoUk;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E3A606A31E
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 10:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29E3A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CkPbNoUk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794737466; x=1826273466;
  h=message-id:date:mime-version:subject:to:references:cc:
   from:in-reply-to:content-transfer-encoding;
  bh=qP4i3ZW+UEpqjfC7VVz5GX0q1rTom9mYvGQGPRYMnbA=;
  b=CkPbNoUkFKEtD1CrObbtiVY+dcM6efd1uwrdAnaR2SZwG6J10BikoBdY
   0Fm3Fxt6JC0ggVkoxcJRWh2J6l47iJBVxxaGWpHm7TcVYOMk2+nbLeYhP
   8+6SoR79f26D89XqUrftoNeZ2ea7OFVTkwBcMG5Ra/TqEApSQ3SyqIBpd
   LTfrpijJZl4vXGEUnmUhLiOD3LDbQNgTCs83Cx3fhAqCy5s2fe7vnyApM
   DF0DhvS2cbS2Zj3ilRgZcofpPYFDdZqDRXD8vcssxzMCSWCKdig/DOpHs
   sB1bjpRTG1yHcvqbrxdT7xxTAkodcSCgfwLL3NtYFLkZJEUE3abT7Onbn
   w==;
X-CSE-ConnectionGUID: KrnoCGR4RbSYbM9DrLVNQw==
X-CSE-MsgGUID: kcQW2wPRT8yIXrOw037dNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11966"; a="3483318"
X-IronPort-AV: E=Sophos;i="6.27,214,1787036400"; 
   d="scan'208";a="3483318"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 02:11:05 -0800
X-CSE-ConnectionGUID: zcpRL1ChSjajhToZdqPYfw==
X-CSE-MsgGUID: XFFPDAWQRfWuL55ItEogAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,214,1787036400"; 
   d="scan'208";a="9139163"
Received: from mschuett-mobl1.ger.corp.intel.com (HELO [10.245.113.173]) ([10.245.113.173])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 02:11:03 -0800
Message-ID: <aeea0018-4242-4424-a29a-94fe77dc6e92@linux.intel.com>
Date: Sun, 15 Nov 2026 11:11:00 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/ivpu: Defer recovery until probe completes
To: Toast <swizzguy76@gmail.com>
References: <20261107174215.15818-1-swizzguy76@gmail.com>
 <20261110085003.3527014-1-karol.wachowski@linux.intel.com>
 <CAHBKUQYqAEuDHBDX-z6hvTY-GMOwqR9Skmtpn=UhaTK-JRx+1Q@mail.gmail.com>
Content-Language: en-US
Cc: dri-devel@lists.freedesktop.org,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 dawid.osuchowski@linux.intel.com, stable@vger.kernel.org
From: Karol Wachowski <karol.wachowski@linux.intel.com>
In-Reply-To: <CAHBKUQYqAEuDHBDX-z6hvTY-GMOwqR9Skmtpn=UhaTK-JRx+1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13-Nov-26 9:49, Toast wrote:
> Tested on Meteor Lake (Core Ultra 5 125H, vpu_37xx firmware 20260219)
> on top of v7.4-rc1:
> 
> - kexec from a 7.0 kernel and from 7.4 with the NPU runtime-suspended:
>    both runs hit ATS_ERR during probe, recovery_work was not queued,
>    probe failed once with -ETIMEDOUT, and there was no oops
> - FLR plus rebind brings the NPU back
> - debugfs force_recovery after a successful probe recovers the NPU
> 
> I couldn't hit an error IRQ after ivpu_boot() succeeds, so the deferred
> recovery in ivpu_pm_enable() isn't covered by this.
> 
> Tested-by: Daksh Sahni <swizzguy76@gmail.com>

Hi Daksh,

Thanks a lot for testing!

Just a heads-up: I already sent v3 a few days ago:
https://lore.kernel.org/all/20261110121534.3566028-1-karol.wachowski@linux.intel.com/

which includes a small adjustment in ivpu_pm_reset_complete() so 
autosuspend isn't lost after a reset (reported by Sashiko).

Because of this change, I haven't carried over your Tested-by tag 
automatically. If you happen to have a spare moment to give v3 a quick 
spin, that would be great, otherwise no worries I've already have your 
Reported-by tag.

Thanks,
Karol
