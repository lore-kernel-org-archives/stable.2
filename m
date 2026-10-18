Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16DB411FB3;
	Sun, 18 Oct 2026 19:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792352088; cv=none; b=ZtBVUVTRCeydwGWOuOXz67v8g+E4Ca51Gc+d8HnbQ8vdNnnmbWBqveeksqOrTJiGg4Lcd+13SX2rRN+F/Bf9vv8nr8JqX+2tzoBLvpwUFBmYiOhOXmZ6aaTVj/2GyMFzBovJnMSszlgHIA82NAL/DzL6TPgJi4xE8Exu7iq7cGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792352088; c=relaxed/simple;
	bh=joVsEekgxWY1deJp/UVdnIJj0mkrVRGDrmJ4u4rDTIU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJUigza8C9GCAmnX9qubeCaFwygLg9fhG4J4f8v8agZKGvGkU4NKXut4dLe6Ov/V0ktTNKE1eBeLEBG4rWBODo2Hs3dmmiTvy4WD2nmEnS9+rC2eenNaRGcfZzRXucuvlZWrof18pc2/ZjXc8Z15zHO4D3UiiH8Vxc4N0j88HgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDsxCyBB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDsxCyBB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7581F000C4;
	Sun, 18 Oct 2026 19:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792352087;
	bh=7hWgfUJX0ue4is68wn7v2s40Yl3GSfkyn05gclLtDvo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lDsxCyBBjbt+2ZdGlnG/DGkT00cwM5F1DDLBPQGRW11zP5CbiC2Zk4WG93c9qEtXx
	 3RhH1JLyGO1FoBZdWRgt3yE1yXn7019bCpBRl16HDMYYZwZoaqIFv8rYX1IIUCSP04
	 G+k46gpUumrlwThLogXXk1VofDTjnSvfAr9E6/QVntIuvg5fUtFG42OGFDngSvY95a
	 Q7banIO5DY7Qj7GacZgXdoF41gtWzINKbI6fhw9K9QuS7WaZUIH6Aouncu0fbMlqO1
	 c0/AcQfpXBcBmswTPTuzwaybI+jg80hLhMHxvytZ+fl+4YJN/BRk49rKB2T5+RkHtx
	 onOP9P89QPMng==
Date: Sun, 18 Oct 2026 20:34:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Christopher Hoover <ch@murgatroid.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, nuno.sa@analog.com, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: humidity: hid-sensor-humidity: Use
 per-instance callbacks
Message-ID: <20261018203439.26c4a98c@jic23-hlaptop>
In-Reply-To: <20261007184423.622445-4-ch@murgatroid.com>
References: <20261007072329.27806-1-ch@murgatroid.com>
	<20261007184423.622445-1-ch@murgatroid.com>
	<20261007184423.622445-4-ch@murgatroid.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Oct 2026 11:44:23 -0700
Christopher Hoover <ch@murgatroid.com> wrote:

> hid-sensor-humidity keeps a single static struct
> hid_sensor_hub_callbacks for all instances and overwrites its pdev in
> every probe, so with two humidity sensors, input reports for one are
> delivered with the other's platform device, and a NULL dereference
> follows once that device is removed.  The same bug was found in
> hid-sensor-temperature, which shares this code.
> 
> Keep the callbacks in struct hid_humidity_state, as the other HID
> sensor drivers (accel, gyro, als, ...) do.
> 
> Fixes: d7ed89d5aadf ("iio: hid: Add humidity sensor support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christopher Hoover <ch@murgatroid.com>
Hi Christopher,

Same suggestion as I made on patch 2 applies here.

Otherwise LGTM.  This one seems less likely to be a problem in
practice than the previous just because I can't imagine we have
devices out there with multiple humidity sensors! Still good to
fix in case they ever show up.

thanks,

Jonathan

> ---
>  drivers/iio/humidity/hid-sensor-humidity.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
> index 7cec81ff5685..95ee1d71c1a7 100644
> --- a/drivers/iio/humidity/hid-sensor-humidity.c
> +++ b/drivers/iio/humidity/hid-sensor-humidity.c
> @@ -14,6 +14,7 @@
>  
>  struct hid_humidity_state {
>  	struct hid_sensor_common common_attributes;
> +	struct hid_sensor_hub_callbacks callbacks;
>  	struct hid_sensor_hub_attribute_info humidity_attr;
>  	struct {
>  		s32 humidity_data;
> @@ -184,11 +185,6 @@ static int humidity_parse_report(struct platform_device *pdev,
>  	return ret;
>  }
>  
> -static struct hid_sensor_hub_callbacks humidity_callbacks = {
> -	.send_event = &humidity_proc_event,
> -	.capture_sample = &humidity_capture_sample,
> -};
> -
>  /* Function to initialize the processing for usage id */
>  static int hid_humidity_probe(struct platform_device *pdev)
>  {
> @@ -240,9 +236,11 @@ static int hid_humidity_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, indio_dev);
>  
> -	humidity_callbacks.pdev = pdev;
> +	humid_st->callbacks.send_event = humidity_proc_event;
> +	humid_st->callbacks.capture_sample = humidity_capture_sample;
> +	humid_st->callbacks.pdev = pdev;
>  	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY,
> -					   &humidity_callbacks);
> +					   &humid_st->callbacks);
>  	if (ret)
>  		goto error_remove_trigger;
>  

