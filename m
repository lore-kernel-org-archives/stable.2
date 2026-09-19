Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B5A1A6835;
	Sat, 19 Sep 2026 04:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789791119; cv=none; b=s36cXME7l3DOek7G0jd1TOUaQyVnJzbmnV0uAaCpoIEHlUiu+bW+FJG301xKnJobtu6PwKGKhn/SvINa6RBp3fJs3oI5gGtiLOuNutrE+1pVj35evr/ojdWGwp4OLyjfNnBCy/oBSXkVBtjnFcqLnY7ZF7Z+6hTOCzHLz89rlAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789791119; c=relaxed/simple;
	bh=RjTWz4LAIN4EHUgEKsf39ko8jdsdlJmzQX4ba8aLM/0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=XNueUDIaY8yr4NnngmdyI3uWG9q0//xmXl0XlPt6mmwSM2AwTbAtQb6cjgVGR/Nww2mxlP7JjUbmpfkGUOnLYOUs1NoT9OYF700qYYUbUUDPaCb15uxgifcvaJOIugGxqHx/Q0wSCvpTAx7/FA9uMMzoT+5Q6nBWgfMV0N0ZRiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=XCL6zRRC; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XCL6zRRC"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hmwzs3FwLzKn9X;
	Sat, 19 Sep 2026 06:11:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1789791113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HLbR/+UEx2bhf0/HsuB/ZyBuo0TWZ9TVU+4TmozdlKI=;
	b=XCL6zRRC/i7TSKQeNfWOco8GC2nbzfLA/kX7ig2hXnz38yMVtYpcgaYVLEk62J6+/bB8d1
	E5M7vR/0I9emlbQehrS4o4Z0XfP+IlMhiROJi02s/GPsAFno1xZDurdrpjgJHOC2+POKwe
	TLqPHDaPYUogZkFi1mh8DxNAoGeOXe5zw2q8XsyYmP/AYEpBhTTFw6IwgsRlrrHpn3PdVX
	p2JaICiQMLFjdBT7GCJfMB2u32c/M+1FatIukxR0bB7sLi5HSDWa3pZGfoUuJ5HqOf/g9B
	pP31xcmMyRo4FMexQ7c/M0aSWalBRmQrNoIgRkNQA8KdTQWiyO07B2Kn2lHHkA==
Date: Fri, 18 Sep 2026 21:11:50 -0700 (PDT)
From: vdso@mailbox.org
To: Naman Jain <namjain@linux.microsoft.com>
Cc: glx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	decui@microsoft.com, yunhong.jiang@linux.intel.com,
	ricardo.neri-calderon@linux.intel.com, rahul.tanwar@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	stable@vger.kernel.org
Message-ID: <15750262.186413.1789791110042@app.mailbox.org>
In-Reply-To: <210aa40c-88e1-4d88-ba6b-9224b05b0820@linux.microsoft.com>
References: <20260831082528.1623843-1-namjain@linux.microsoft.com>
 <aqTInOmsyr8AiciA@xps-8930>
 <210aa40c-88e1-4d88-ba6b-9224b05b0820@linux.microsoft.com>
Subject: Re: [PATCH] x86/init: Initialize wall clock in get_rtc_noop()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-MBO-RS-META: w37tqeymr6wn4d5uq7nsxgcsmsr5a85w
X-MBO-RS-ID: a755947659e7d29af1e


> On 09/14/2026 4:31 AM PDT Naman Jain <namjain@linux.microsoft.com> wrote:
> 
>  
> On 9/12/2026 9:05 AM, Roman Kisel wrote:
> > On Mon, Aug 31, 2026 at 08:25:28AM +0000, Naman Jain wrote:

[...]

> >> +void get_rtc_noop(struct timespec64 *now) { *now = (struct timespec64){0}; }
> > 
> > Hi Naman,
> > 
> > Could be
> > 
> > *now = (struct timespec64){};
> > 
> > to save a byte :)
> 
> hi Roman,
> Thanks for reviewing.
> 
> Tianyu pointed out offline that this is handled in yet another way in 
> jailhouse code:
> 
> arch/x86/kernel/jailhouse.c
> static void jailhouse_get_wallclock(struct timespec64 *now)
> {
>        memset(now, 0, sizeof(now));
> }

Appreciate sharing! Makes sense to me, looks way more explicit. Most
importantly imo, the memset isn't actually producing a call here so
the clock no-op stays cheap when choosing `memset` over ` = {}`.

One can see that the kernel build compiles ` = {0}`, ` = {}` into

pxor ...
movups ...

on x64 in the above. I made sure the memset "call" is relaxed/optimized
away into the same sequence `pxor ...; movups ...`.

> 
> Regards,
> Naman
> 
> > 
> > LGTM.
> > Reviewed-by: Roman Kisel <vdso@mailbox.org>
> > 
> >>   
> >>   static __initconst const struct of_device_id of_cmos_match[] = {
> >>   	{ .compatible = "motorola,mc146818" },
> >> -- 
> >> 2.43.0
> >>
