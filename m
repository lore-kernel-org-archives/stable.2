Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025E91F2B8D;
	Sat, 17 Oct 2026 23:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792280918; cv=none; b=s0r/FQ4EIAo1UqvcbDWNU0v1h71NEitGHBFysNpNSeytmp0vuaQqFEKJ4Xt8HqS9mX4bz5ErcClOiXN7CQgHTuX0eXWBbzEbsKfGyXw3bzDTRvaCk4QGhpIwxZooXrRHKl370si9B2s5C1pQ8dPuA1JMJrMIoBAwO+uJXEtVVqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792280918; c=relaxed/simple;
	bh=OegNwtBlbWJsRetO1hLmtFJT3AEq7b+QO5Fjrq15TuI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZ2V+fk6syuHVI0C1j+is1QuWYNrCqkzKVShEznH5HAkSZHcLuM2pCWpwQybqwzUzS9twvgTu+S/OsHfwuzQUNpWt7/G6h5HH5m4/5bQkO1CrZhfjhZkM0puZmACPHnbLu64WwZBit35wNwtLErhVEP9pyiY6uU4aN86hZN4qO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2SdRDhm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2SdRDhm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F06F1F000C4;
	Sat, 17 Oct 2026 23:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792280916;
	bh=9cKmaOvO8+w475otCgj53iP5B3332djS6gNZeB1RDvc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h2SdRDhmFrBQskd/cMi+CKUqB0cROvdkoWcIJrAfPvLDiG96/qdo5iLSwxsU3sXMZ
	 XLF4A/PP2QCgq7QocOMw0oEoloIq8x8AL1vShWaWeBxCDaZmiownK7o4VrvKUaUmtx
	 PORP87fP+orVp8V9FW9pkjfbapLVrkQxlRolW/NqP1PuplKnF6T4kPVWUQb/WFLhRb
	 v/QCtmhQQM+MSfUso9jIwzQLN7Dzrrimt1mUYuM7V0HJZZbnUk9jDIGdqfJKi4rczW
	 ENTlVUmL/WZx+vWBDfI84koX2kQcNthCp3HNFkFgoUcelYMYnOvgLVtl99hUBqD9BY
	 hJRT4FhQAbTsw==
Date: Sun, 18 Oct 2026 00:48:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Yu-Hsiang Tseng <asas1asas200@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: acpi: Accept comma separated values in ROTM
 strings
Message-ID: <20261018004833.65dc0048@jic23-hlaptop>
In-Reply-To: <as1JVWC8FiN704Uj@ashevche-desk.local>
References: <20261012074144.1060625-1-asas1asas200@gmail.com>
	<as1JVWC8FiN704Uj@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 23:55:49 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Oct 12, 2026 at 03:41:44PM +0800, Yu-Hsiang Tseng wrote:
> > The ROTM method of the MXC6655 accelerometer on the Higole F9B, an
> > Alder Lake-N handheld (AMI BIOS F9D_16G_P800217, DMI strings are all
> > "Default string"), separates the values with a comma and a space:
> > 
> > 	Method (ROTM, 0, NotSerialized)
> > 	{
> > 	    Name (SBUF, Package (0x03)
> > 	    {
> > 	        "-1, 0, 0",
> > 	        "0, 1, 0",
> > 	        "0, 0, 1"
> > 	    })
> > 	    Return (SBUF)
> > 	}
> > 
> > iio_read_acpi_mount_matrix() only accepts the space separated form used
> > in Microsoft's example ("0 1 0"). It rejects this matrix and mxc4005
> > falls back to the identity matrix:
> > 
> > 	mxc4005 i2c-MXC6655:00: Incorrect ACPI mount matrix string format
> > 	mxc4005 i2c-MXC6655:00: mounting matrix not found: using identity...
> > 
> > With the X axis not inverted, iio-sensor-proxy reports left-up when the
> > device is held right-up and vice versa, so the desktop turns the
> > picture upside down whenever the handheld is held in landscape.
> > 
> > It is not the only BIOS written this way. The BOSC0200 on the AYANEO
> > Air Plus uses commas in its ROMS method as well, with a space before
> > one of them, and its ROMK method has "1, 0,0":
> > 
> > 	Method (ROMS, 0, NotSerialized)
> > 	{
> > 	    Name (SBUF, Package (0x03)
> > 	    {
> > 	        "-1, 0, 0",
> > 	        "0, -1 , 0",
> > 	        "0, 0, -1"
> > 	    })
> > 	    Return (SBUF)
> > 	}
> > 
> > The kernel's sscanf() does not support '%*[', so there is no clean way
> > to take both separators in a single format string. That leaves either
> > a second sscanf() call with a comma format, or normalizing the
> > separator first. Do the latter: turn the commas into spaces before
> > parsing, so the existing "%d %d %d" format, which already takes any
> > amount of white space around the values, keeps working unchanged. The
> > strings live in the buffer acpi_evaluate_object() allocated for us, so
> > they can be modified in place.
> > 
> > With this change in_accel_mount_matrix on the Higole F9B reads
> > "-1, 0, 0; 0, 1, 0; 0, 0, 1" and, with no udev hwdb override, the
> > desktop rotates correctly in all four orientations. The AYANEO Air
> > Plus was not tested; systemd's hwdb has an entry for it, which
> > iio-sensor-proxy prefers over the kernel's matrix.  
> 
> Makes sense, and fix is neat.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Hmm. I debated dropping the stable tag, but meh, it's trivial and
makes stuff work that didn't before.

So applied to the fixes-togreg branch of iio.git keeping that tag.

I'll be rebasing that on rc1 once available before sending a pull
request.

Thanks,

Jonathan


