Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86E335C687;
	Fri, 14 Aug 2026 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711797; cv=none; b=FwvQIxwi2p1KFq7YEZ2HEh44FRhNbiq5kKFFxCKhm60m1CvpqjaupdKH1Ns8/WjJW24pW5DkwwncNfNgP1Eiq8vyOlit3iYOb6GfWLbb8Q1YFsHLPW3HtpYBBVS8WSInMbC1gJnP0xQXSjpPSj7o2mogRRNBtNPOwJrcg5nNCcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711797; c=relaxed/simple;
	bh=xgnyFVM48BJQmfstIgNW+DFiWQ+sxSdZGjP8flViMH0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HHuAB48cKp0CHxSzI48IbdrRkqdEBmbddw7rKxLea74RWRL3tCHg9ZZyrgwy3secCbVE3TsE5uqWeAwfzhZIVGoRSGzQQmhKLnCxEfxVbfIZxnBsX2VPF6Jr4ti3CaxsTP382RqLhJ7S60zhnbYBD9MY8WtAw8Zyqx2Nb2yx324=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRDfzshg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRDfzshg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17C91F00A3A;
	Fri, 14 Aug 2026 12:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786711791;
	bh=km+u9J7sJRcZsJ2wjyW2/278JLQPTswm3POT24nALSw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=PRDfzshgsNO1kymJ5OSeQ7RhESGEGfILgOr5EAtXRhnFzf5RUvAeIznOh7973/Dux
	 0QTtGMDJtELoX1pM5yJ7aQWemOUMyC0j0jlwo9pZez0x6lWYRxyOxbH7L+NMiBVqff
	 KSvB55EJ8jaxUuOP8cdAuFyWKHYNC6ejU3IU8OWmgwpPNnZVBwNS8veN+2eAqVgwIl
	 DgfkinJpfcS7IoL8bd8jWHbAbafNAacNAXstdCIU9C3ypPWtrRCo6vlQQ+uZd0Tq7c
	 44Qds53TvLdB7lzEJJRxpEbAxVUAR89aO3SVK8t1jmWHhW9nbQGkCckMV+jlnytbCm
	 UVXfYvd00RXSA==
Date: Fri, 14 Aug 2026 14:49:48 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Baul Lee <baul.lee@xbow.com>
cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    =?ISO-8859-2?Q?Tomasz_Paku=B3a?= <tomasz.pakula.oficjalny@gmail.com>, 
    Oleg Makarenko <oleg@makarenk.ooo>, 
    Benjamin Tissoires <bentiss@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] HID: universal-pidff: stop the device when force-feedback
 init fails
In-Reply-To: <20260729142432.16184-1-baul.lee@xbow.com>
Message-ID: <p7s8s54n-s272-o580-18o7-93p5110o5oq6@xreary.bet>
References: <20260729142432.16184-1-baul.lee@xbow.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 29 Jul 2026, Baul Lee wrote:

> universal_pidff_probe() starts the device with hid_hw_start() and then, if
> force-feedback initialisation fails, returns the error through a label that
> only does "return error".  The device is left started.
> 
> The HID core does not unwind on the driver's behalf.  __hid_device_probe()
> releases the devres group, closes the report and clears hdev->driver:
> 
> 	if (ret) {
> 		devres_release_group(&hdev->dev, hdev->devres_group_id);
> 		hid_close_report(hdev);
> 		hdev->driver = NULL;
> 	}
> 
> The hidraw character device that hid_hw_start() registered through
> hid_connect() is allocated with kzalloc() and added with cdev_device_add(),
> so it is not devres-managed and survives that.  With hdev->driver NULL,
> hid_device_remove() skips hid_hw_stop() as well, because it only unwinds
> while a driver is still attached.  The registration therefore outlives the
> device on both paths.
> 
> Opening the surviving /dev/hidrawX writes into freed memory.  KASAN reports
> a use-after-free write from hidraw_open() -> hid_hw_open() -> the
> transport's open callback, which takes a spinlock inside the freed object.
> A descriptor that carries a PID usage page and no input reports is enough:
> hidraw claims the device so hid_hw_start() succeeds, while hid->inputs
> stays empty so force-feedback init fails.  The other failure returns in
> hid_pidff_init_with_quirks() - no output reports, an allocation failure,
> pidff_init_fields(), pidff_check_autocenter(), an unusable effect count,
> input_ff_create() - all reach the same label.
> 
> Stop the device on that path.  hid-dr.c and hid-emsff.c, which start the
> device with the same HID_CONNECT_DEFAULT & ~HID_CONNECT_FF mask, already do
> this.  The two earlier gotos must keep returning without hid_hw_stop(),
> since neither has a started device, so give the path that fails after the
> start its own label.
> 
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
> 
> Fixes: f06bf8d94fff ("HID: Add hid-universal-pidff driver and supported device ids")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>
> ---
>  drivers/hid/hid-universal-pidff.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-universal-pidff.c b/drivers/hid/hid-universal-pidff.c
> index 549dac555d40..60180467a0bf 100644
> --- a/drivers/hid/hid-universal-pidff.c
> +++ b/drivers/hid/hid-universal-pidff.c
> @@ -104,12 +104,14 @@ static int universal_pidff_probe(struct hid_device *hdev,
>  	error = init_function(hdev, id->driver_data);
>  	if (error) {
>  		hid_warn(hdev, "Error initialising force feedback\n");
> -		goto err;
> +		goto err_stop;
>  	}
>  
>  	hid_info(hdev, "Universal pidff driver loaded successfully!");
>  
>  	return 0;
> +err_stop:
> +	hid_hw_stop(hdev);
>  err:
>  	return error;
>  }

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

