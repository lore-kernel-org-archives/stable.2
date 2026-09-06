Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2B91EB1AA;
	Sun,  6 Sep 2026 18:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788718115; cv=none; b=a4KmxzdA4xj9etWNGmpMgMLNDi+CPbwKCk0PIyiDUqFyD9RNt7Jc6m7DcDyKqHAcFKjrXv9lwlHMvLIqjVldPw8Zu4zKpqFWychPcHpC621j5v58YLP3E1OYs7dfHDtG5YcANCOFKVX9gUBSyzZb+laGQFZbIvv1mdIvHIKcWGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788718115; c=relaxed/simple;
	bh=MfFqN7lzGoHcR1gPINCpzC8RRi4pm8ZsKsCXx5WR19I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hgvvlucHaUFJYaBYC2MX0h4wpb8OT0aAsYHAlW6SVsMiaA2Fxxrsg8/0SWjPfwwmZJroKQ7rOo+4YLlNyDU4Y7kLiU+7CCgNM8R+JocSVs4icCQQ5kEAHdcCO3GRyvxQr0l8busAteH+ggUPzV7qoETXDOM7YFiHG3/OpPK5KhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hV4Wmgkn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hV4Wmgkn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC5A1F00A3A;
	Sun,  6 Sep 2026 18:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788718114;
	bh=gSLK4hT/oaLo/dsLXdtO4EGo3FN7hnUJsF5wtt/+Ccs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hV4WmgknfYVpA7MZlh4jev7JDziURv94ERutfnB1B6Vp88SP+8y/f6AwPtmMGOmgy
	 4ty703QeK59qWPlxitGnf5kqwLtROXVkA/wHP/3cZSms+WKGN3LIwBmJZe94p/s53H
	 GcyOQfgP+oawkA4HsgQ/pNuUpYqrScLwPjO+zP1jHlwXmJoi7lGgi7y4+I4KAwEeW1
	 4oQzqJwCVJEigkKLRcFcr/a4XO3YbE2Fo24szXjOdeWxP5ggyEE6YdBKqkXybwX8IV
	 vN0V3OokW0WVATd8Cy7ruiSMkRtiW3mupXZzGXkQzzN0IP/UPfhJOD4vgRgdNcISGw
	 bEPEeEkLJgrgw==
Date: Sun, 6 Sep 2026 19:08:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix odr change not caught in
 certain cases
Message-ID: <20260906190828.7d62976c@jic23-huawei>
In-Reply-To: <20260903-iio-imu-inv-icm42600-fix-odr-change-never-caught-v1-1-029c5f1cbce2@tdk.com>
References: <20260903-iio-imu-inv-icm42600-fix-odr-change-never-caught-v1-1-029c5f1cbce2@tdk.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 03 Sep 2026 21:37:13 +0200
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> When using both accel and gyro with different frequencies, the ODR
> change flag in the FIFO header can be sometime in a packet with
> invalid data. Since we are ignoring these packets, we miss the ODR
> change and any further change are blocked until sensor is turned off.
> 
> Fix this by moving the packet data validity check after the ODR change
> flag check.
> 
> Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
