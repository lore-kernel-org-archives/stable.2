Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794183874;
	b=z/VXxc99UpzWoaM73JNokE7p8ne923uKAqaejzDEUTY3OpkxHLHHdQzVPKYyWZTeEaAe
	 a/dY8nfZREKIZdFGl+m0xKNFLIN+icdVKLKkyxa6X7hZIAhLUT703Gk3iFvo//KG08aTj
	 Au0kJ+b5vz+puEhE3ZFbKNQ04sU0TXkRKpCJ1NMRRpMsHFl20tiJFuk0LbdBF4ikyJU1Z
	 jB+xwJmk2cddqbaZoKolV6kZof3dqpG/REkpqPPPch7A8CtGSMRCiaY+LQ6rkxJZ6z7TR
	 bSlBgLn/O2opT+xKXQB+ITOtbbxHX4AFScTViAh/EOPm8sX8kDqsDh/YE2yjWf3LY9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794183874;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=MSrsGOd6epxr5Av5d0/wv507jZgM6FYHT2dSap7aFHQ=;
	b=ndEY0GYlVqzSXwmKyCNmPtg21isjxeLYyJFFwfFUIOE2ZNW4jdcZkDzYhUwR/QdtEhgN
	 qjNottZvE7UU8UHyqGvJh7bgT7LVJe47EyO8l3FdzJuHvb/7qoI0yYNNimTA8TmrjS+xP
	 MsdxN1MjqlyNEjQeCINdiPFNr16/i1HYg3BB7wHiW2QsxKbGC6zjSjbnhAtCsf/EFEjeo
	 CJrhUvMsPoRz2J0gZNKmjMtuaKAZqU/TFdxRV8KquSZ5wNBq4S8dNxDRJL/jvNrgxnxig
	 t4rXkNCR+Co2Bo4WN6P/+9f3TBt75HrjrGE7YNKlLDDu1rLN0jxak6eYnlyM6kp0Z0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=bI3kP+HT;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9185A606A31C;
	Mon,  9 Nov 2026 00:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9185A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=bI3kP+HT
Received: from killaraus.ideasonboard.com (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D8AEC2F8;
	Mon,  9 Nov 2026 01:22:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794183730;
	bh=/MlpY1rBdT2Z4meYa4LYkH8ChsrsxlDfWGXDlmOD3QA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bI3kP+HTPBAr8vgoQE3CgFxzz1h+8NaqeLw6e5wXK45Z1MKBbQmDGhzoCaFluslTO
	 QiomdqqvbkaF3lbzkIpIxJzf0XKDmDwf98Y7w3FuHFbUfs8Iy5VgkPtkXe21z9y5Ka
	 lL9XOaiB3c8uSXm6Rfg0ZCA+SiyJCZDtW8xPjqeE=
Date: Mon, 9 Nov 2026 02:24:29 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: b.danias@tutamail.com
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Serin Yeh <serin.yeh@intel.com>, Robert Foss <rfoss@kernel.org>,
	Hans de Goede <hansg@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 3/3] media: i2c: ov8856: Power off the sensor during
 system suspend
Message-ID: <20261109002429.GD806758@killaraus.ideasonboard.com>
References: <20261104-ov8856-pm-fixes-v1-0-1958b730ce66@tutamail.com>
 <20261104-ov8856-pm-fixes-v1-3-1958b730ce66@tutamail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104-ov8856-pm-fixes-v1-3-1958b730ce66@tutamail.com>

On Wed, Nov 04, 2026 at 11:42:49AM +0200, Babis Danias via B4 Relay wrote:
> From: Babis Danias <b.danias@tutamail.com>
> 
> On a Dell Latitude 7320 Detachable, the rear OV8856 stays powered for
> the whole of s2idle once the dw9714 VCM driver is bound, even with the
> camera idle. Tracing a 20 second suspend shows the sensor's clock and
> regulators enabled about 0.5 s after "PM: suspend entry", and disabled
> only just before "PM: suspend exit". Without the VCM driver bound, they
> stay off.
> 
> ipu-bridge links the VCM to the sensor with a runtime PM device link,
> which makes the sensor a supplier of the VCM. The dw9714 driver has
> system sleep callbacks, so the VCM can't use direct-complete, and
> dpm_clear_superiors_direct_complete() then clears direct_complete for
> the sensor as well. The sensor goes through the full system suspend
> path, where acpi_subsys_suspend() runtime-resumes it before calling the
> driver's suspend callback. But ov8856 has had no system sleep callbacks
> since commit 19ae6ba57f88 ("media: i2c: ov8856: Drop system suspend and
> resume handlers"), so nothing powers the sensor off again.
> 
> This matters since commit 609a71568664 ("media: i2c: ov8856 : remove
> ACPI node bypass mechanism") made the runtime PM callbacks control the
> sensor's power on ACPI systems.
> 
> Use DEFINE_RUNTIME_DEV_PM_OPS(), so that pm_runtime_force_suspend()
> powers the sensor off during system suspend, and
> pm_runtime_force_resume() powers it on again only if it was in use. With
> this, the sensor is off for the whole suspend. It is still powered up
> for a few milliseconds at suspend entry, by acpi_subsys_suspend().
> 
> The problem was found, and this patch written, with the help of an AI
> coding assistant (Claude Opus 5.5). See the cover letter for details.

No. I'm really tired of the combination of bad PM APIs and cargo-cult in
drivers/media/i2c/. I don't want to see dozens of LLM slop series for
sensor drivers.

> Fixes: 609a71568664 ("media: i2c: ov8856 : remove ACPI node bypass mechanism")
> Cc: stable@vger.kernel.org
> Signed-off-by: Babis Danias <b.danias@tutamail.com>
> ---
>  drivers/media/i2c/ov8856.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
> index f9bcdd412..848e981ff 100644
> --- a/drivers/media/i2c/ov8856.c
> +++ b/drivers/media/i2c/ov8856.c
> @@ -2462,9 +2462,8 @@ static int ov8856_probe(struct i2c_client *client)
>  	return ret;
>  }
>  
> -static const struct dev_pm_ops ov8856_pm_ops = {
> -	SET_RUNTIME_PM_OPS(ov8856_power_off, ov8856_power_on, NULL)
> -};
> +static DEFINE_RUNTIME_DEV_PM_OPS(ov8856_pm_ops, ov8856_power_off,
> +				 ov8856_power_on, NULL);
>  
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id ov8856_acpi_ids[] = {
> @@ -2484,7 +2483,7 @@ MODULE_DEVICE_TABLE(of, ov8856_of_match);
>  static struct i2c_driver ov8856_i2c_driver = {
>  	.driver = {
>  		.name = "ov8856",
> -		.pm = &ov8856_pm_ops,
> +		.pm = pm_ptr(&ov8856_pm_ops),
>  		.acpi_match_table = ACPI_PTR(ov8856_acpi_ids),
>  		.of_match_table = ov8856_of_match,
>  	},

-- 
Regards,

Laurent Pinchart
