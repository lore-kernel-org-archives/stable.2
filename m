Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793491101;
	b=EzfeJjAiiiCmvPNFkGwSHZo9cihCwzZM0vmQDBz9Z2wAPqQgqPQ7KQcZ4nL7eY3vjcA2
	 nPzIVWHVTt1n3klz9LbLdav8WLHSJbGAuEfQT0uP7vnjwypFvr5eOMJ66emlysebPngyI
	 GZgBxp1q2slPEd0DVQTt/yrXxLTfwcqjclI2NbnuoUjrIGcfCf+NCa4LzsWRpreo2Bznb
	 oM4znYhwe4Of7XtUkoRPIokhbTUHcSCPXgqDklY9nGsYRMW8iblPbqS3LNaWUJWJulhCm
	 HDfJpZ6TEn8EwYf7nGa9CeMhRIIDtpIwprRneASbcXbiX8DmsFXjjn7qyYYW9g/zqIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793491101;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6V0NiExjKiMGJ5h/1WwCW23VisWqxFUm51w7ztl/rtw=;
	b=f1Fu5ckbutAMohD33pQt5+MtsRlwP+v5MwWA9FYVLuYQLXncRjK45tT32SwHLegviP8B
	 5XY532mGHzJCtoFpliZJ8mRtCBUhJXe/7dOf5vdocOT2GStaw3X6lg2ZZgOi2l4cR1EyX
	 WHvXVoGEhyfpFZMchQungIFg4UaHO7j2QBgcVNmO0b6QxcG+7q43upCyGio+5uvG84z5N
	 FewQmvWNhtOLy/wkbExND9EGF9whrgZwckfqw7ilFzxKaHn2KrpZEKS5ESR1dg/D2igFA
	 58qLIh8CBDxudLV+DlBkI3mqDrfB4c+78zH/MyFjCyltMYfet3I9qbIyQS4h1UNAW0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cVnD0I/9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08C5606A31A;
	Sat, 31 Oct 2026 23:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cVnD0I/9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50E11F000C1;
	Sat, 31 Oct 2026 23:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793491100;
	bh=6V0NiExjKiMGJ5h/1WwCW23VisWqxFUm51w7ztl/rtw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cVnD0I/925gFCOJnVBwIxkZZegH1NRZRU1VUlRVXvS37S8KkDDShwleVoT+PlUwcj
	 LsyCOGO2YsjHP3pZwxLlQFHmt3Iecy605KhGnarPeNvdwfezWKHIq622wCKlmb0RtO
	 cApZpSoZLOQM0CTiTd9SlSS78sclPU34sZnG8TJhFreAzUwwY8n3JCO7MZ7PmeMgUK
	 4eq7A6+HHo1uUmX6U3Zl9fZ4wKpYhlNantSso2zNMALQhHud3S4KH1HktQ1luVbU+n
	 BlkP4UpKQV2/3TL/GLa1kCXEHajYtyHH7Rol1IEK4F3PjE17UCQzkcTb4WnmuLxD2/
	 TnLd1R5eWQEYA==
Date: Sat, 31 Oct 2026 23:58:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: Kevin Tsai <ktsai@capellamicro.com>, Lars-Peter Clausen
 <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, Nuno Sa
 <nuno.sa@analog.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Hans de
 Goede <hdegoede@redhat.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Tristan Madani
 <tristan@talencesecurity.com>
Subject: Re: [PATCH v3 2/2] iio: imu: inv_mpu6050: validate ACPI object
 types in asus_acpi_get_sensor_info()
Message-ID: <20261031235815.4805cf65@jic23-hlaptop>
In-Reply-To: <20261029110829.1086835-3-tristmd@gmail.com>
References: <20261029110829.1086835-1-tristmd@gmail.com>
	<20261029110829.1086835-3-tristmd@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Oct 2026 11:08:29 +0000
Tristan Madani <tristmd@gmail.com> wrote:

> From: Tristan Madani <tristan@talencesecurity.com>
> 
> asus_acpi_get_sensor_info() iterates through a nested ACPI package
> structure without checking types at either level.  The outer object
> returned by acpi_evaluate_object() and each inner element must be
> validated as ACPI_TYPE_PACKAGE before accessing their package.count
> and package.elements members.
> 
> Use acpi_evaluate_object_typed() to validate the outer object type
> at evaluation time.  Add a type check for each inner element before
> accessing its package contents.  Also replace kfree() with
> ACPI_FREE() for the ACPI-allocated buffer.
> 
> Fixes: a35c5d1aa96a ("iio: imu: inv_mpu6050: Create mux clients for ACPI")
> Cc: stable@vger.kernel.org
As with the previous.  Hardening against buggy firmware isn't
a fix. It is however nice to have so with those tags dropped
I've applied this to the testing branch of iio.git

Thanks,

Jonathan
