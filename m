Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9978549A3B0
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 10:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639602; cv=none; b=uFcPMlSO9LoXuTLcnSWGmOnIB70nTwDB+ZP+IQ8aD+XVzEJX0XXIGQJ17G8j3c7PoNrzmJmMj534vUHlIF9JO87R1OPvHmfp6iHwjqq0H81m+oah4oFaBntuWjncEwblhC7x/Aq7906b+OM586pNapSdx1aLWOXHYffT5WE7liE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639602; c=relaxed/simple;
	bh=6tr+Q6toQNKo7n0NHt6sw7S8Zbm7OyIWdwXnmQeajuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JK1rVV1PsVq6QQSeEV2mpkomb7XU77JMP6noH4Qe7iKm7W7dNMDJ+Lg6V3twipPocYI6iOwBe+Gr4UfuQRmsV5xm6trb7kobKJkNUd7LINN4WJphJOhChpmabDZ63G/CjwCPe/y15NE/5rZCrVEjVTuL9awiHZ/BEcW+0PgaE6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zG1ageGf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zG1ageGf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8B81F000FF;
	Thu, 17 Sep 2026 10:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789639596;
	bh=R+CpJe8Yo3DS+XL586zooLyM6/0nwpiX48Peb8JQauw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=zG1ageGfSUm70ZP+5+15mZuJAr9NJMb1eeO1Lw3DJsUVyhEWyxi35ncgLAdnguRGQ
	 Zjk/xS4EIGYMiBIXPg76qtE/DoLgb0Z/evVE+b/IRX7R3RoRVbGboLKejOPkPky46G
	 z0YC7OqakL6aFUSY4j1XzYHoJMCdw7vwpclCfRgQ=
Date: Thu, 17 Sep 2026 11:01:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Rainer Fiebig <jrf@mailbox.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: 6.18.51, bisected: standby/hibernate problems; rtc_cmos
 error-message during boot
Message-ID: <2026091739-ellipse-relish-5af9@gregkh>
References: <8f2a6bee-9357-57e8-22ee-fd04637494a5@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f2a6bee-9357-57e8-22ee-fd04637494a5@mailbox.org>

On Mon, Sep 14, 2026 at 12:34:53AM +0200, Rainer Fiebig wrote:
> With 6.18.51 standby and hibernate can no longer be effected via
> keyboard-shortcuts on an AMD 5700G system.  In addition, automatic
> hybrid-hibernate doesn't work anymore.
> 
> During system-start this message comes up, here from sys.log:
> 
> Sep 13 23:20:40 LUX kernel: [    0.533984] rtc_cmos PNP0B00:00: error
> -ENXIO: IRQ index 0 not found
> 
> Bisecting between 6.18.50/51 produced this:
> 
> ec2d81115485de3f604f86edc4d9119a213a59bf is the first bad commit
> commit ec2d81115485de3f604f86edc4d9119a213a59bf
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Date:   Tue Sep 8 08:20:01 2026 -0400
> 
>     ACPI: x86: cmos_rtc: Create a CMOS RTC platform device
> 
>     [ Upstream commit 1ae2f435350ec05224a39995c3a680aa6fdae5a5 ]
> 
>     Make the CMOS RTC ACPI scan handler create a platform device that
> will be used subsequently by rtc-cmos for driver binding on x86 systems
> with ACPI and update add_rtc_cmos() to skip registering a fallback
> platform device for the CMOS RTC when the above one has been registered.
> 
>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>     Acked-by: Dave Hansen <dave.hansen@linux.intel.com> # x86
>     Link: https://patch.msgid.link/1962427.tdWV9SEqCh@rafael.j.wysocki
>     Stable-dep-of: a3df8bbe0a70 ("ACPI: TAD: Add locking around AML
> evaluations")
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
>  arch/x86/kernel/rtc.c       | 4 ++++
>  drivers/acpi/x86/cmos_rtc.c | 8 ++++++++
>  include/linux/acpi.h        | 4 ++++
>  3 files changed, 16 insertions(+)
> 
> 
> Let me know if you need more info about the system's hardware.  Thanks.

Please always cc: the authors involved in the patch...
