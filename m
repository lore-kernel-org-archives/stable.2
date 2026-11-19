Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119514;
	b=vWFul2G/98aj84ubHuIksGWtwbl2k0qfSoYSMrgtCLUMu6zH7ykJEdoEwW8oGz/0eU7B
	 3BN6+B7Z2J7h1qsyg6f0gWWXbdS8pBpx3HDMVPGKelE8OIAaXl3y430qpIhsMVc1cuup5
	 xI1N9OMaR5XZMoHM0SRXoa87WRIQe5dcUvtFX+F6SHep1QvpwlWStgkUICUUv47VllNWy
	 GVZPLgY1c8S6R7qsi2IC+arLrhC106w3xA4x+Kk+kftP+7FauM0934CLa6/o29zj3xod6
	 7CGRltHBx4RiH8Uw+7nSDJN0Njgz4EoGDVLKx+sYhmFRjfRNwfPojDJC2pa7sa3QrsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119514;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=WsFo3wefZy5sZb3V1OtkeK/IBejPoKx3Va0UMDmDaIE=;
	b=Zdq7Ipb/wosA/Rx0msYYxDPYYjIc4WlSXHEvRVo/zE4g7x2YyL/cVqEGSvLjqmqFeiSp
	 HxctBaHKKdK5vHC/D3ZjDi+V8QtPIneOFY0Fuaso39AxmOXtUZ/6izTfx1cS0x3Oudp4B
	 Osgxx+hUAWq2aB4IVEJmf+RjEgcIbdtz9r76nkf1ubr0S4J8UvW6WGZ3FrmrtkSPXs1fT
	 YKdDCexz0Zb2xjGHW48m0f33K8IiLAJMFvciTiFrguHA6xcHrB5B6ZVtEsm5RmZBBnzAV
	 +Lp6/CWJTtkuZ57qNAuP76IF3mgUxOCoSZdAo0MjIITkI5/PyfLu92uIIBUAl9FeMJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fxgA/bz0";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22509606A9D3;
	Thu, 19 Nov 2026 20:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fxgA/bz0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245B21F000C0;
	Thu, 19 Nov 2026 20:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795119513;
	bh=WsFo3wefZy5sZb3V1OtkeK/IBejPoKx3Va0UMDmDaIE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=fxgA/bz0UTq7S1auc58uiFhasu0jXjsCwO5lx6aatok8Hc9NkcLlJk0XwvgkpcCdi
	 pxYiszvx6YN6jhoci4uVo+Dwe2MjJUkvL6RL/hg4TG9XClRWwhnFs41pR1SlE0WRfj
	 NyNMypoPmLzvWv/NQcWj72dtsd6d4dzbl6xe9nHdf3DrxKwQ6mH1shLIaRfUWtu/ug
	 P8lPj8pRbvsP0Yt5PmtXR1KBQk9KDSLy9G9bMD4IK5mx3F8+IrCCryEIeRAkmzO2Sk
	 Ui+NV00JE6tlNW/hzrQP2wJZoFCw3tW55dSRbAO2D6//Bgkju/9545Oq3JNaNsIqrk
	 NZAA5qKIDXLwQ==
Date: Thu, 19 Nov 2026 21:18:31 +0100 (CET)
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
Subject: Re: [PATCH v2 00/33] HID: logitech-hidpp: G920 force-feedback fixes,
 rework, and cleanups
In-Reply-To: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
Message-ID: <p6p98p0s-5p97-q584-14sn-ns404p6s3orn@xreary.bet>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
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

On Tue, 10 Nov 2026, Dmitry Torokhov wrote:

> This series starts from Gideon Heinz's report of Logitech G920
> force-feedback initialization timing out in v7.3 and addresses several
> additional pre-existing bugs, lifetime races, and cleanup opportunities
> found while auditing hid-logitech-hidpp.
> 
> The first 14 patches carry Fixes and stable tags. They fix the v7.3
> G920 force-feedback initialization timeout by temporarily enabling
> device I/O around g920_get_config() in hidpp_input_configured(), switch
> hidpp_ff_queue_work() to GFP_ATOMIC since playback, gain, and autocenter
> callbacks run under the input event spinlock, drain the G920 FF
> workqueue before closing the HID transport on input close so queued
> commands still receive their USB interrupt IN replies, synchronously
> disable driver work items and disconnect input devices with device I/O
> enabled before stopping the transport on removal and probe failure,
> avoid storing an ERR_PTR in battery->ps on registration failure, avoid
> NULL pointer subtraction in the HID++ 1.0 consumer keys report fixup,
> and fix an off-by-one in G920 slot tracking that made the 63rd user
> effect in hardware slot 64 unusable and leaked it across reopen.
> 
> Additionally in the bug fix section, hidpp_send_message_sync() is
> updated to stop retrying non-busy errors (timeouts and transport
> failures) so failed commands fail promptly without 15-second stalls,
> and response buffers are initialized before publishing send_receive_buf
> to eliminate races with concurrent or spurious packets. Battery fixes
> correct HID++ 1.0 battery mileage event parsing to read capacity from
> the correct report byte and update state, properly propagate negative
> transport and timeout errors in ADC measurement (0x1f20) queries, mark
> devices online when receiving unified battery (0x1004) events, fix K750
> solar battery feature lookup and reconnect handling, and expose the
> charge_type property for the battery voltage (0x1001) feature.
> 
> The next section prepares transport handling and reworks G920 force
> feedback for next. Connect-event work is kept disabled in probe until
> hid_connect() completes successfully. Transport error codes are
> preserved in __hidpp_send_report(), and hidpp_send_message_sync()
> is switched to return standard negative error codes on failure.
> G920 capability discovery moves back into hidpp_probe() while device
> I/O is active (keeping force feedback optional on failure and
> excluding generic USB PID force feedback), device-level wheel settings
> are separated from the input FF queue lifetime, the G920 range sysfs
> attribute moves to driver dev_groups, and FF workqueue teardown moves
> into ff->stop so open evdev handles across USB disconnect or unbind
> no longer cause use-after-free.
> 
> Furthermore, G920 range store, effect upload, and effect erase are
> converted to execute synchronously with proper transport lifetime
> handling, avoiding asynchronous command queueing and work flushing
> during device close and teardown. Effect slot lookup is streamlined by
> indexing slot arrays directly by effect ID instead of performing linear
> scans.
> 
> The final section modernizes the driver. Multi-byte packet fields are
> switched to unaligned accessors, the device serial is stored as a byte
> array, and resource management is updated to use guard(mutex),
> __free(kfree), alloc_ordered_workqueue(), devm_mutex_init(), and
> devm_device_add_group(). Lastly, unused kfifo fields and helpers
> are removed.
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

Wow, what an endeavor. Thanks for looking into all this.

I've finally got to processing it. I've applied 1-14 to 
for-7.4/upstream-fixes and the rest on top of it to for-7.5/logitech.

Thanks,

-- 
Jiri Kosina
SUSE Labs

