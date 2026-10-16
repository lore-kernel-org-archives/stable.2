Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE543148D2;
	Fri, 16 Oct 2026 10:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144886; cv=none; b=vBeax+bvQpBbeVVBKBOOzcmW2fGYUrh3JQlcDlYHHTse0Vz6mVZJa5Ir5w7pPo40u6b7lzK4RvZ0DeoRa3Y0bJnxJ/fiI/YG5PuMl3M8ZICkERNlXCJTrZb57EVAxx+L2ZLcnTy5ZSSLAlhNqB85k29wW9Pjsij4Ha2vS1b/7vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144886; c=relaxed/simple;
	bh=gkvpNoGRm7LzeGLrdVQF3lghi9vl2+UJDE3TrXHQE6c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=METH5CKvrSpuAJnkoXEFo3Kd8Q1yZ2u+re/bwEOl2tnCqPMsT1ibgKTPGwAEVJa79IhdnSRCHzKQMwzra4DV/U+RKw/9p6+9iangS8d4Iv9BDdivReAYSupPknQapSJZ448IB47V0mQ8GqUDKgCTyZVgMl1TcvQVfEiCrmwAlAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2McqTjH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2McqTjH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABBC1F000C4;
	Fri, 16 Oct 2026 10:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792144885;
	bh=YH1J1euDRnwMKyDDOdpff6sULzlOsh4aRucKu7xPZ7Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=E2McqTjHj3SjUs9kEQBQxZx7D0XTPeb7zrsSKR7gdkf4/viYF0lO5u1TfUHzz3jcx
	 tDcqN2m4d7TaX+ZmOoLSNbaEWxibbgxrK1wC+bbx4YTgQxlAHOPbU0ajnhGjEMyXh1
	 xjb4iBKARRLiJ+HNjazGy1mYeZsQ/5M1XxjgUs76vlNV0zyfwTuCx1b1N0UGTAnssr
	 sMeFTIqW0/2Uaj7Jhdc25fxARVl1ljZBUUm0gvEPUJWU0pbpNWBNmue7F2Gfyflxk5
	 zM5OO92UylyZnc0EaMvDajPHcLYq5TlpySDUwvVVBuPmsmNvict1iQTTXXzRWbA0D7
	 Dvz57n8pyYHhA==
Date: Fri, 16 Oct 2026 12:01:22 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
cc: =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    Bastien Nocera <hadess@hadess.net>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: cancel reset_hi_res_work on probe
 failure
In-Reply-To: <20260913134044.1562697-1-lgs201920130244@gmail.com>
Message-ID: <11qo16p4-8902-s6s1-233n-571949pss19s@xreary.bet>
References: <20260913134044.1562697-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 13 Sep 2026, Guangshuo Li wrote:

> hidpp_probe() initializes reset_hi_res_work before starting the device.
> Once device I/O is started, incoming HID++ events may schedule this work.
> 
> If a later probe step fails, the error path stops the hardware and
> cancels hidpp->work, but leaves reset_hi_res_work pending. Since hidpp
> is devm allocated, it may be freed after probe returns while the work
> is still queued, potentially resulting in a use-after-free when the
> work handler runs.
> 
> Cancel reset_hi_res_work in the probe error path, matching the cleanup
> performed by hidpp_remove().
> 
> This issue was found by manual code inspection.
> 
> Fixes: ed80cc4667ac ("HID: logitech-hidpp: Add HIDPP_QUIRK_RESET_HI_RES_SCROLL")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 1504de32b1c8..6a21b281a1df 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -4834,6 +4834,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  hid_hw_start_fail:
>  	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
>  	cancel_work_sync(&hidpp->work);
> +	cancel_work_sync(&hidpp->reset_hi_res_work);
>  	mutex_destroy(&hidpp->send_mutex);
>  	return ret;

Already fixed via 0be03caba6c002 in hid.git, thanks.

-- 
Jiri Kosina
SUSE Labs

