Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380181;
	b=NAEnvAL+x6nMIwU5dyR7dqDDnbtFTWAG3H4Skxd+F+Ca7shA5J3JO0GAxCT7QgxVWSFC
	 /GSOPYBS93z0u71MI/0Z2GMRJfwYYxDigpLwRSR26lvg/fYiSPO6Rgt4bDMsEllrjo93m
	 5YUx+u5kU2TbKheCW+oB2Ae+ELn344Qy3uu+nulAeGyUCLsF6Vqj0crx7umCn+1vPifKk
	 Ymp6iOMVhGm45ioKBEgLOO/z+JeZuVlYo6fs+Ememc/WjlFSd7G3RszxlTjl29vR1RAGR
	 ZgcFZwlG+dgcoNc3AgcdIOM61p8+yYuDCsFtynDffExHriFLZBF9KDZ0AHBS9/wQ2MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=sRt8SVJz/Vt9vpxkGcSvU6+JuP4VVZwcJ5DXfG5Bwk8=;
	b=B29wyEZARHufDfqZMcc9j+HRSMCyU9EJOw2rj9KnPpXjv8BydgFMIiBEMpx7QvIs70/W
	 yz0UxrbIsdc8kx7RHXYhbYOEplmF7yIt+ilh+krGFyAGbQwOr71Fl3SM8uwIwnaaiGBEi
	 tJheTwiByzsNu8ShPBBgc0mPKMV/NXOzGAghNyIbJdbK0vAaHq6XDmnGbpAndm6guMKwt
	 nDr9UK43VxeeLY98lLXyQB15fMkLo4Udu52MFoAtzJNycMGBsDzOOBMSLfcEWVl4y6WFN
	 ZDQ/5QmYy2IHRV6cTTB5ZzFJT2vwXXwLKY+PB1gXbzXe3hHNuy3LI+unue6kocEFw5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vG+6Iv0i;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58626606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58626606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vG+6Iv0i
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-37000e7234bso661532eec.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380179; x=1794984979; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sRt8SVJz/Vt9vpxkGcSvU6+JuP4VVZwcJ5DXfG5Bwk8=;
        b=vG+6Iv0iVI2/fjDyZP49QfGvIb8ptaYFYOp+zSC0gewxIPWg0BM5R1LLE/pB71IdQF
         RNRWmng+gkMrYJ1O0gRkKqBGYZ1xBKHFZIRRWjapcuohTr3hNprA3jyoDKIy3uD+PRct
         iY2cIr6PjWnL7m/jgGbPbh3C0DAf+vthIwnrvEFOaIHcqwHtIH/41++kmCYdcRrbGTx0
         SXfRZG1Bb2ro5HMH54KMbg8NifIoq7snB/AirSRRaIVWnWCUfmosgteJNL2klHSKinW7
         LnD2T9W+QCoJmvzxHqdJcTCV/P8zq1arQfo9qSRbzHl40aaaA3emjHjvGF884oXLXFpN
         TMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380179; x=1794984979;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sRt8SVJz/Vt9vpxkGcSvU6+JuP4VVZwcJ5DXfG5Bwk8=;
        b=1gcgKAp5pDZaAKUCfoc6CoqbowdeYCwB2WaqVexK9bhV2qOQn37GAQ6y+ourlpwPqz
         fWerQ8MWDhv8BGf/Zju8tGK6T8HR3LOpbiW8iT7RpChietXq93n2ykHiT5HkTK8+eNBx
         IaE43C/l8E+3488WNROtpI8MMhHh0KgjvNVgcbXP59Fx24rQztEUUuXK54X3YkXuQvxQ
         tAcDzPpR4MA/yr7aUEQxlbbEiifXKJmRIyz74c6kVq0dLJdl+WiSC+i9fGlZ4Iz1sZXI
         B3rQ01+j0wd7f7L3pHCNxjIa9OhnuoIn9jiDe7KapoFRn2ibRCHjfV6ryZi5UwtdHXDm
         tCxQ==
X-Forwarded-Encrypted: i=1; AL+hErGMhqcU6QK1gv6kiml4xNstHnxxaQgzoFZIHkJfiR7xXc/czSR5/JGU/NkITim+Ak8KyVc+Zsc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+V90bflaPGlElYAntSZBK1J330e/hVm15xqzxA1rpdVAqSjSF2
	50e/4zxrHIlvCG+RcXXF/gYQ+rBkfXPaPmAA+D8C6CbVDbkzDLX0YkPAY40IWw==
X-Gm-Gg: AYBFou2+bEmzfOhdFPD+QIHzmHkioiAmc+pNCp9jNrui+2j1+wyi4w7H0IjrUSDzSqq
	VIhs9bQMarRIR6Un5FCWde31VmL3zlYOzxJMpqfa6wBh7T6XvrPPWVBMyp6TKgNBXgR67C1QiLr
	ZF9SaOFEDFtRfRFnA5/hmyeetLA8J16D9nDuJcf4EmhVUKVtLR7oXbJK5gM/P8Jh5drCn1I559k
	i+29loiC6yM02Xx3s0P13tBLqG2/hK/pP37xR3q2gFNHy+jpjlmc5LazS5+q06UungUlkKYDiay
	F8ufWUV4G19ujVRm3AEPfcH8W3Dip9NU7Cs76gpE23F9hTkbs66N3dvWsH1siouhLrsCE7+/zdb
	+jPzYcZjLqWQw6k4fHInrRT53S5Yd7qkeIO0IslyGRBG1yQ2TA0oLx27IKJhKTStmUI1Pd98J7H
	GY9hcTiiJ9m5KzzdmEQ9RUTw3hwd/E8oCcY2HQD+6Uhb1ncxS61/5X/k20ZH8ue5mdoYzU4H9g2
	XXeb/Pp/lmN4MxkbWZYobXuOEuWshu/ugepSfRffTW+3lTwp8itqDXClwrxnZqizQu4vmkvfxl8
	kyRfUPfXUcVw1YTvuBTlt8EEIasbLfD/2bzkfpRorlHDi0SpZKx+n6LC+KRKO4qghleYdb/Q5AI
	1j0H4gJNUpGA1DwjiX/Y=
X-Received: by 2002:a05:701b:4187:10b0:1ac:9da7:e881 with SMTP id a92af1059eb24-1b3c034a47amr1556236c88.36.1794380179189;
        Tue, 10 Nov 2026 22:56:19 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:18 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 00/33] HID: logitech-hidpp: G920 force-feedback fixes,
 rework, and cleanups
Date: Tue, 10 Nov 2026 22:47:58 -0800
Message-Id: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ4P9GoC/y2NQQ6DIBREr2L+uhhAQ2lX3qNxoYjyWxUD1NQY7
 16w3UzykjczO3jtUHu4Zzs4vaJHO0fglwyUaeZBE+wiA6dcMMYoMdiR0Q4YtDIJloUIKcu2b0V
 TlBJicXG6x885+qh/7N/tU6uQlpJh0AfrtvN1Zcn7H9AbTVnkXMqrKARhpJswuC2Pvn0Zu1bD1
 OCYKztBfRzHFz5HYXDBAAAA
X-Change-ID: 20261110-hid-logitech-hidpp-6884bfb6a348
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

This series starts from Gideon Heinz's report of Logitech G920
force-feedback initialization timing out in v7.3 and addresses several
additional pre-existing bugs, lifetime races, and cleanup opportunities
found while auditing hid-logitech-hidpp.

The first 14 patches carry Fixes and stable tags. They fix the v7.3
G920 force-feedback initialization timeout by temporarily enabling
device I/O around g920_get_config() in hidpp_input_configured(), switch
hidpp_ff_queue_work() to GFP_ATOMIC since playback, gain, and autocenter
callbacks run under the input event spinlock, drain the G920 FF
workqueue before closing the HID transport on input close so queued
commands still receive their USB interrupt IN replies, synchronously
disable driver work items and disconnect input devices with device I/O
enabled before stopping the transport on removal and probe failure,
avoid storing an ERR_PTR in battery->ps on registration failure, avoid
NULL pointer subtraction in the HID++ 1.0 consumer keys report fixup,
and fix an off-by-one in G920 slot tracking that made the 63rd user
effect in hardware slot 64 unusable and leaked it across reopen.

Additionally in the bug fix section, hidpp_send_message_sync() is
updated to stop retrying non-busy errors (timeouts and transport
failures) so failed commands fail promptly without 15-second stalls,
and response buffers are initialized before publishing send_receive_buf
to eliminate races with concurrent or spurious packets. Battery fixes
correct HID++ 1.0 battery mileage event parsing to read capacity from
the correct report byte and update state, properly propagate negative
transport and timeout errors in ADC measurement (0x1f20) queries, mark
devices online when receiving unified battery (0x1004) events, fix K750
solar battery feature lookup and reconnect handling, and expose the
charge_type property for the battery voltage (0x1001) feature.

The next section prepares transport handling and reworks G920 force
feedback for next. Connect-event work is kept disabled in probe until
hid_connect() completes successfully. Transport error codes are
preserved in __hidpp_send_report(), and hidpp_send_message_sync()
is switched to return standard negative error codes on failure.
G920 capability discovery moves back into hidpp_probe() while device
I/O is active (keeping force feedback optional on failure and
excluding generic USB PID force feedback), device-level wheel settings
are separated from the input FF queue lifetime, the G920 range sysfs
attribute moves to driver dev_groups, and FF workqueue teardown moves
into ff->stop so open evdev handles across USB disconnect or unbind
no longer cause use-after-free.

Furthermore, G920 range store, effect upload, and effect erase are
converted to execute synchronously with proper transport lifetime
handling, avoiding asynchronous command queueing and work flushing
during device close and teardown. Effect slot lookup is streamlined by
indexing slot arrays directly by effect ID instead of performing linear
scans.

The final section modernizes the driver. Multi-byte packet fields are
switched to unaligned accessors, the device serial is stored as a byte
array, and resource management is updated to use guard(mutex),
__free(kfree), alloc_ordered_workqueue(), devm_mutex_init(), and
devm_device_add_group(). Lastly, unused kfifo fields and helpers
are removed.

Note that device removal teardown still has limitations due to how HID
core's hid_device_io_start() and hid_device_io_stop() (via
driver_input_lock) gate both driver raw command/response I/O and
subdriver event forwarding, disabling I/O before .remove() and
hid_disconnect(). For instance, HIDPP_QUIRK_DELAYED_INIT devm-managed
input devices are still unregistered after hid_hw_stop(), and
hidpp_connect_event() publishes hidpp->input before input registration
completes. Resolving these teardown edge cases cleanly will require
follow-up work in HID core and driver input registration.

Thanks.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Changes in v2:
- Rebased the series on top of linux-next.
- Collected Tested-by tags from Gideon Heinz for 17 v1 patches (omitted
  from patch 4 where hidpp_remove() was significantly altered).
- Reorganized the series to place all 14 stable bug fixes upfront,
  followed by next refactorings and modernizations.
- Updated hidpp_remove() to enable device I/O while draining work
  items and disconnecting hidinput so in-flight transfers and
  force-feedback teardown can receive device replies (noting that
  complete resolution of delayed-init and transport teardown ordering
  requires follow-up work in HID core).
- Stopped retrying non-busy errors (timeouts and negative transport
  failures) in hidpp_send_message_sync().
- Initialized response buffers before publishing send_receive_buf to
  prevent stale response reads on concurrent or spurious events.
- Fixed HID++ 1.0 battery mileage event parsing to read capacity from
  the correct report byte and update battery state.
- Handled negative transport and timeout errors properly in ADC
  measurement (0x1f20) queries.
- Marked devices online when receiving unified battery (0x1004) events.
- Fixed K750 solar battery feature lookup and reconnect handling.
- Exposed charge_type property for battery voltage (0x1001) feature.
- Kept connect work disabled during probe until hid_connect() succeeds.
- Switched hidpp_send_message_sync() to translate RAP and FAP protocol
  error codes into negative Linux error codes (-EBUSY, -EIO, -EPROTO)
  instead of returning positive protocol values, and preserved transport
  error codes in __hidpp_send_report().
- Converted G920 range store, effect upload, and effect erase to
  synchronous execution with slot indexing by effect ID.
- Added G920 force-feedback helper cleanups, removed unused kfifo and
  struct wtp_data fields, and cleaned up minor helpers.
- Link to v1: https://patch.msgid.link/20261109061103.2887636-1-dmitry.torokhov@gmail.com

---
Dmitry Torokhov (33):
      HID: logitech-hidpp: fix G920 force-feedback initialization timeout
      HID: logitech-hidpp: use GFP_ATOMIC in hidpp_ff_queue_work()
      HID: logitech-hidpp: drain G920 FF workqueue before closing transport
      HID: logitech-hidpp: disable works before stopping transport
      HID: logitech-hidpp: do not store ERR_PTR in battery->ps
      HID: logitech-hidpp: avoid NULL subtraction in consumer key report fixup
      HID: logitech-hidpp: fix off-by-one in G920 force-feedback slot tracking
      HID: logitech-hidpp: do not retry timeouts and transport errors in hidpp_send_message_sync()
      HID: logitech-hidpp: initialize response buffer before publishing send_receive_buf
      HID: logitech-hidpp: fix HID++ 1.0 battery mileage event parsing
      HID: logitech-hidpp: handle negative errors in hidpp20_get_adc_measurement_1f20()
      HID: logitech-hidpp: mark device online on unified battery 0x1004 events
      HID: logitech-hidpp: fix K750 solar battery feature lookup and reconnect
      HID: logitech-hidpp: expose charge_type property for battery voltage feature
      HID: logitech-hidpp: keep connect work disabled until hid_connect() completes
      HID: logitech-hidpp: preserve transport error codes in __hidpp_send_report()
      HID: logitech-hidpp: return negative error codes from hidpp_send_message_sync()
      HID: logitech-hidpp: rework G920 force-feedback initialization
      HID: logitech-hidpp: use sysfs_emit() in hidpp_ff_range_show()
      HID: logitech-hidpp: manage G920 range sysfs attribute via dev_groups
      HID: logitech-hidpp: execute G920 range sysfs store synchronously
      HID: logitech-hidpp: shut down G920 force feedback on input unregister
      HID: logitech-hidpp: index G920 force-feedback slots by effect ID
      HID: logitech-hidpp: execute G920 effect upload and erase synchronously
      HID: logitech-hidpp: clean up G920 force-feedback helpers
      HID: logitech-hidpp: use unaligned accessors for multi-byte values
      HID: logitech-hidpp: store device serial as a byte array
      HID: logitech-hidpp: use guard() for send_mutex
      HID: logitech-hidpp: use __free(kfree) for temporary allocations
      HID: logitech-hidpp: use alloc_ordered_workqueue() for FF queue
      HID: logitech-hidpp: manage send_mutex with devm_mutex_init()
      HID: logitech-hidpp: manage ps_attribute_group with devm_device_add_group()
      HID: logitech-hidpp: remove unused kfifo and clean up minor helpers

 drivers/hid/hid-logitech-hidpp.c | 897 ++++++++++++++++++---------------------
 1 file changed, 411 insertions(+), 486 deletions(-)
---
base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
change-id: 20261110-hid-logitech-hidpp-6884bfb6a348

Thanks.

-- 
Dmitry

