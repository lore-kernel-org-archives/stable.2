Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C72D8834;
	Mon,  5 Oct 2026 03:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791171652; cv=none; b=hHHCCsCtVs6rsar9IfbdKSRJIJqgPLy1eftvB2R5Y58T4vD1yqbwgz/yN9SldcURwyaAmehMPU57JQneX0h2ZMMWY/fezV7cwaI768j8H21bccbXSGIwVNSBZHLM/5s47sF8jXf3xXFkM4UFLpgrASXDpcE8Kd+arwUYhr3H/XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791171652; c=relaxed/simple;
	bh=SiC5mWtHUS0Oi+9nry2VvKHmeOD0RjBoskX0u9Dl1ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Af8L3IyMzAZAYo6GhQDw5ZhSYxN+LFPG1ZzB86plgM50ysJeh9vxgdDoePTsP13QDEoOcYRaqxd3H5HW9G/jNLAQcVy12mvVA1DbgOVfDxfYhIuPTnxjpPUGbu/6RvXKqAAW8GbOQFoACENk3/rBDLLLspmdY6bmj83bBq3Cd04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njUIpVed; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njUIpVed"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17731F000FF;
	Mon,  5 Oct 2026 03:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791171650;
	bh=ppmVR0hseoTnPTTQ4WpaTp1gw66+0BB0990p78SHIFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=njUIpVedW23l2LqYkI3duRPuzXic46aaDxLK9vJKOBjdQWkOCa0QQ1z1G7AQ+8YSa
	 Yw2iryNNEYQXzlPXdSZtxX6BvZbiZYuwQdi8FEa61oG8RQo14YXIQ7HlfH6kMOM6RC
	 fqNNkJX8vECPRUEexHBELEz/JVOZFWP62dVQIEFqHhEc4D541AXx7uM5HOHQ8Bjzvk
	 r0ZqAvVufNj3dVrd48YBz9zI8hnCpXsoEPSQkmFU5nNvepBwLeveBrnXZNkjDEwSw0
	 irPpfSwLOZtmDTR5Kd9GrEj4Q9Kt3zyv0ZSdK8DoRRsJTqgsGFfR0yWLdK64S0b/eW
	 6zrI+KwLo9ngA==
Date: Mon, 5 Oct 2026 03:40:46 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Sergey Tiraspolsky <stiraspo@gmail.com>
Cc: Benson Leung <bleung@chromium.org>,
	=?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	Jameson Thies <jthies@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, james.a.fairweather@gmail.com
Subject: Re: [PATCH] platform/chrome: cros_usbpd_notify: Don't use a non-EC
 parent's drvdata
Message-ID: <asMcPkMDjO-Uip8L@google.com>
References: <20261003204623.18124-1-stiraspo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003204623.18124-1-stiraspo@gmail.com>

On Sat, Oct 03, 2026 at 01:46:23PM -0700, Sergey Tiraspolsky wrote:
> Notes:
>     Tested on a 2017 Google Pixelbook (Eve), where GOOG0003 is a child of
>     PNP0C09, on 7.2.5 (Arch-based distro kernel; none of its patches touch
>     drivers/platform/chrome or drivers/acpi/ec.c), building this change as
>     an out-of-tree module:
>     
>      - without the patch: four oopses with the trace above in the logs, one
>        3 seconds after resume, and lid-close suspends that never resumed
>      - with the patch: the probe prints "Couldn't get Chrome EC device
>        pointer." again; a charger unplug/replug produced 9 USB PD
>        notifications, all taking the "EC device inaccessible; sending 0
>        event status" path; suspend with a charger unplug/replug while asleep
>        resumed normally; no oopses
>     
>     Not tested: a device where GOOG0003 is a child of GOOG0004 (that path
>     only moves into the if branch here, its logic is unchanged).

Hi Sergey,

Thanks for looking into this.

Coincidentally, James Fairweather ran into the same issue on a Nami
Chromebook and submitted a patch shortly after yours [1].

The patch [1] addresses the same crash, but also fixes an existing firmware
node reference leak by calling fwnode_handle_put() on the handle returned by
fwnode_get_parent().

Because of the additional leak fix, I plan to proceed with James's patch.
To ensure your earlier report and testing on Eve are properly credited, I'll
add your "Reported-by" tag when applying the patch.

If you have a chance to test James's patch on your Pixelbook (Eve) and reply
with a Tested-by tag to [1], that would be greatly appreciated.

[1] https://lore.kernel.org/all/20261003222855.23707-1-james.a.fairweather@gmail.com/
