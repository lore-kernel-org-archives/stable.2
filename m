Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176858;
	b=zKhqeqeQOwZ4RqUZ9BG5DUtx9nYMH6/WYgMe6cWryR8NeraozNGD+2ICNT2IeFEY8Nz3
	 91RoFGly0j7YJYMSv/plLjeQeZRzfE2iKOu+uODquFMQ2q67zAVlwjhKhKEtnekHIbZAL
	 yVc1mIXao+OkGi7u9BNiRmxhB3Xw4hbCVkEwWAOeGKBkM++I8rfWAh0pKu/7iqvc3QRav
	 HGyI6wqUHMINosmx5zS3I+8Cbq2jdSs+foVWPygbC59VsA9cZZ6+O686EP0Gp36iou6Y4
	 Hd2zp/4EDwNhyXxukZXIDE4106ytjTTQFOguqNkjjVW2TGKSJdIvpVZLlILb+6TsPtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176858;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=CSLYtYNsDaTun26wMNmzm2IdVDSojM0ADRUtYrpSQyw=;
	b=OwvdTLu2skR7+OoK8SSIeEDJx4lsDFDgEPdFJW6G+1hZ84X+J5es7NKvVgFxDfwt7w3x
	 F11hj7tJA1vIPy9d9KysjlDYyOr60AgOz/iG4TC/AUJlcaFppOs3SSMZeSHBtM+GZwcPW
	 42AQ4kF7onLpXboyJ6GnJ3jLnFJ77S8P08MUo20qPY6T1lsM7bvrVTGcRROSd92pkCIMb
	 9R8ChChs6zeSbEw6Ho7mKZCcFk0ULgmmSVhONXHly5nwe7DF2AS8QOLfLf+3Q0s8RVga/
	 AJC97gaeBkc+aIh+suVFR3KTu2l41rosAy6j7GSwslKY/DdIIER+dxNI6S/y6mxipnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aCczXQAA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B562B606A325;
	Fri, 20 Nov 2026 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aCczXQAA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2ED1F000C4;
	Fri, 20 Nov 2026 12:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795176858;
	bh=CSLYtYNsDaTun26wMNmzm2IdVDSojM0ADRUtYrpSQyw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=aCczXQAAeUEGw5x3rSvzxoCj4xi36YfHt/HwaGB+GWCDSWmlu0DFsmvAsmzonfUEO
	 CbyusFuKAQmrF9eeq7LPik/irzIVLEi81+BPmirtsnRS+tFU1ArKya5IF9EXyY3+Yv
	 wf5RK7KLzwLCG3NnvK4HlMbSbddWWFl8FWbj94HUWD5uC6JWsZWm8d33GKLst6Tdvx
	 We0EWvJ4s+3hVc31Pk0A+YJL94VMhjUvYW90XynoEREcR+L12Nqlv1Pfi2+C+wy6dL
	 4jXNOvvyJW1Q4wbxq5AUB/o5z5VVnROrv3824jiepNuONIktRZDU3+ODzVTA8fnaak
	 gCyfoxYQsrkog==
Date: Fri, 20 Nov 2026 13:14:15 +0100 (CET)
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
Subject: Re: [PATCH v3 00/14] HID: logitech-hidpp: G920 force-feedback and
 battery fixes
In-Reply-To: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
Message-ID: <34ppp9o3-o9s3-4521-04s8-3s44436rq153@xreary.bet>
References: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
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

> Per Jiri Kosina's request, the v2 series has been split into this
> 14-patch bug-fix series targeting v7.4 and a separate 18-patch rework
> and cleanup series targeting v7.5. The open-evdev-across-unbind
> force-feedback teardown use-after-free (v2 patch 22/33) is now handled
> in input core ("Input: destroy force-feedback device on input
> unregistration") and has been dropped.
> 
> This series starts from Gideon Heinz's report of Logitech G920
> force-feedback initialization timing out in v7.3 and addresses several
> pre-existing bugs and lifetime races in hid-logitech-hidpp.
> 
> The force-feedback and teardown fixes temporarily enable device I/O
> around g920_get_config() in hidpp_input_configured(), switch
> hidpp_ff_queue_work() to GFP_ATOMIC since callbacks run under the input
> event spinlock, drain the G920 FF workqueue before closing the HID
> transport on input close, synchronously disable driver work items and
> disconnect input devices with device I/O enabled before stopping the
> transport on removal and probe failure, avoid storing an ERR_PTR in
> battery->ps on registration failure, avoid NULL pointer subtraction in
> the HID++ 1.0 consumer keys report fixup, and fix an off-by-one in G920
> slot tracking that made the 63rd user effect in slot 64 unusable and
> leaked it across reopen.
> 
> The transport and battery fixes update hidpp_send_message_sync() to stop
> retrying timeouts and transport errors, initialize response buffers
> before publishing send_receive_buf to eliminate races with concurrent or
> spurious packets, fix HID++ 1.0 battery mileage event parsing and state
> updates, properly propagate negative errors in ADC measurement (0x1f20)
> queries, mark devices online on unified battery (0x1004) events while
> gating 0x1000/0x1004 dispatch, fix K750 solar battery feature lookup and
> reconnect handling, and expose and correctly map the charge_type
> property for the battery voltage (0x1001) feature.
> 
> Note that device removal teardown still has limitations due to how HID
> core's hid_device_io_start() and hid_device_io_stop() (via
> driver_input_lock) gate both driver raw command/response I/O and
> subdriver event forwarding, disabling I/O before .remove() and
> hid_disconnect(). For instance, HIDPP_QUIRK_DELAYED_INIT devm-managed
> input devices are still unregistered after hid_hw_stop(), and
> hidpp_connect_event() publishes hidpp->input before input registration
> completes. Resolving these teardown edge cases cleanly will require
> follow-up work in HID core and driver input registration.
> 
> Thanks.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> Changes in v3:
> - Split out the 14 bug fixes into this series for v7.4 per Jiri Kosina,
>   moving the 18 rework and cleanup patches into a separate series for
>   v7.5 and dropping v2 patch 22/33 in favor of input core teardown.
> - Collected Tested-by tags from Gideon Heinz on all unchanged patches in
>   this series (omitted from patches 12 and 14 which were updated after
>   v2 testing).
> - Gated event dispatch in hidpp_raw_hidpp_event() on
>   HIDPP_CAPABILITY_UNIFIED_BATTERY so 0x1000 and 0x1004 events are
>   routed to their respective handlers instead of cross-corrupting
>   battery state.
> - In hidpp20_battery_map_status_voltage(), set charge_type to unknown
>   when status is unknown, to none when discharging, full, or not
>   charging, and to standard, fast, or trickle only when charging.
> - Reset charge_type to unknown on wireless disconnect in
>   hidpp_connect_event().
> - Link to v2: https://patch.msgid.link/20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com

Applied to hid.git#for-7.4/upstream-fixes.

Thanks,

-- 
Jiri Kosina
SUSE Labs

