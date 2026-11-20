Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182692;
	b=pKCws4QEpW3j9XyEXaw7rrlsxtEeC+vEK7DbKYjPF0J/la3WauyDlD5HlbS/p0iMiqpy
	 8MsXPIm7QqQvu48HAK2FN+3D8SiY5OnmyDoVcGchqJvI0XyJkHaL1Mq14Hig0NIJ7GMDU
	 B8lNyobtuMBGdsy2m3AaJyBZ/0h+4ftV3bFQWSShy/QYbGcAorgVRlYfZd5y2D4eMZ3tE
	 T8JFLwo0aWayGtOJdlcgzcMR3wHgGVS7i2EB/kKP59rLangTPdWHKVOf2NKKL+sBwoVDq
	 X0wiDLlOixP5sRZKspnOTIrz9BwRYX1wx6x6A4CMYfjftbAT5h9eYx2OqKd2Eqghzvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182692;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=eSZZxG0LEV34oz1xCRBBHzOv3LcZn+FGQVxEYGfrIKY=;
	b=ZejJm7JVcdqDDAeKO7Ir8qnbRzl/P7p7jR0SUkb3sYQMJAxTPLNwKxgQDXGn7zsFcB7e
	 j7qdboiTa3vuRtpJdIYfHR1ODyAuqVuk3hwNedUsD6baqLgftXt5ekesmQ+drcPSoMp8q
	 U7b/ilhQp9ZI13pVrWgiYvkVHmqSogzwykamDH50B/ArFrZiN779d4mayd8UlIhG+e6ZG
	 Xagu03azukzRKSOE/VOzVtL4z0bEpOqayIHiOs6dR8bSd9yAEf9biZZBqwutzl2BcRei/
	 ym8ip6jX64/76q08J+oPCRCsjTVfjpdmb1xJ2tBEo18yYh4sXPWuDsVLhKz5cTIneNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J4pjZCQg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DD4606A320;
	Fri, 20 Nov 2026 13:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J4pjZCQg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE821F000C4;
	Fri, 20 Nov 2026 13:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795182692;
	bh=eSZZxG0LEV34oz1xCRBBHzOv3LcZn+FGQVxEYGfrIKY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=J4pjZCQga8EDHhusCKr01iE6qWnQ79Z0QJxlf+q5/FNbFh+Ap9fMrN4tnFrpNyU2J
	 W/TujJqC+cfqH5o3Ya9HEpCmvqCrJn2w99LSwSGt2CrTvBNH6uBZ8sdCpwQz/Tx5Ck
	 UHDoqc6BniR0SELdJ4mUj+CWyh5jmqL589Aqg9a9LWjVYcjjV1O/Gygh3EejMlc7+x
	 Xl69pDWcY6eFsoXp2hM5fnC887fqyg6L90eD8RKvJNoHeL0GPNgw0Na6LmVvCQUGPR
	 w7VBxDApBnp597v7575lZFhMBSj8LM1dL5DA+TnD3mCcTCVZViSAtuipWnLXaqfkaY
	 4ynVs3AY2hpZA==
Date: Fri, 20 Nov 2026 14:51:29 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Gideon Heinz <gideonheinz02@gmail.com>, 
    =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
    Edwin Velds <e.velds@gmail.com>, 
    Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
    Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 04/14] HID: logitech-hidpp: disable works before
 stopping transport
In-Reply-To: <20261120-hid-logitech-hidpp-v3-4-cfe2caa1d0eb@gmail.com>
Message-ID: <r078ror3-9q6q-s581-35r4-63pnp1p93s85@xreary.bet>
References: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com> <20261120-hid-logitech-hidpp-v3-4-cfe2caa1d0eb@gmail.com>
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

On Fri, 20 Nov 2026, Dmitry Torokhov wrote:

> Device removal and the probe error unwind path cancel the connect-event
> and hi-res-reset work items only after closing and stopping the HID
> transport, leaving in-flight work handlers able to issue HID++ transfers
> or register power-supply and input devices while transport teardown is
> underway. Moving cancel_work_sync() ahead of transport shutdown is not
> sufficient because incoming reports remain active until the transport
> stops and can re-schedule the work items before hid_hw_stop() completes.
> 
> Disable both work items synchronously before closing or stopping the
> HID transport on device removal and on the post-I/O probe failure path,
> and drop the unreachable cancellations from early transport start and
> open failure paths where incoming packets have not been enabled yet.
> 
> On device removal where HID core enters with device I/O stopped and
> driver_input_lock held, temporarily re-enable device I/O to flush
> pending work handlers and disconnect input devices before stopping the
> transport. Clear HID_CLAIMED_INPUT and hidpp->input upfront so incoming
> reports can still wake synchronous commands without dispatching events
> to the disconnecting input device.
> 
> Fixes: 7bfd2927adca ("HID: hid-logitech-hidpp: Add basic support for Logitech G920")
> Fixes: ed80cc4667ac ("HID: logitech-hidpp: Add HIDPP_QUIRK_RESET_HI_RES_SCROLL")
> Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index d5f53b35ac6f..0e1a9fd98faf 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -4805,13 +4805,13 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	return ret;
>  
>  hid_hw_init_fail:
> +	disable_work_sync(&hidpp->work);
> +	disable_work_sync(&hidpp->reset_hi_res_work);
>  	hid_hw_close(hdev);
>  hid_hw_open_fail:
>  	hid_hw_stop(hdev);
>  hid_hw_start_fail:
>  	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
> -	cancel_work_sync(&hidpp->work);
> -	cancel_work_sync(&hidpp->reset_hi_res_work);
>  	mutex_destroy(&hidpp->send_mutex);
>  	return ret;
>  }
> @@ -4819,15 +4819,26 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  static void hidpp_remove(struct hid_device *hdev)
>  {
>  	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
> +	bool claimed_input;
>  
>  	if (!hidpp)
>  		return hid_hw_stop(hdev);
>  
>  	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
>  
> +	claimed_input = hdev->claimed & HID_CLAIMED_INPUT;
> +	hdev->claimed &= ~HID_CLAIMED_INPUT;
> +	if (claimed_input)
> +		hidpp->input = NULL;
> +
> +	hid_device_io_start(hdev);
> +	disable_work_sync(&hidpp->work);
> +	disable_work_sync(&hidpp->reset_hi_res_work);
> +	if (claimed_input)
> +		hidinput_disconnect(hdev);

This fails to build, because hidinput_disconnect is defined in hid-core 
and there is no declaration for it in logitech code.

I'll drop this series for now, please fix it and resubmit a version that 
compiles :))

Thanks!

-- 
Jiri Kosina
SUSE Labs

