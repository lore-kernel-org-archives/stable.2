Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793538287;
	b=Lu8SusEf+Z7ROxTtWmUvBQRvZTgvFw7AUmuabUsJS3bGs8TX5mxOX8hIW9SF+MhFptJG
	 5e3Q98ZG7hw0M4uoqRfcINeipVZ9ybV1Bnbqt5mh9QrsQyGBQYL/SPRq0gaBgYvaccnnN
	 vQmK1q/MYiYS0zOw9EBMsGzTQX/HiqIzd3LjK927+0PNgWDcP0mEIAFunAxWY5ypp9P46
	 NLOif5GPghfyVuaTQySuNL8sYXzCFmeh0X5ZePcUJcehoyhkNHnkXS0eiYIGteqDvxao1
	 ZDUAdXM/+ESWKZRxsCA54dFfukCnat5QxF+BoBIufnuHj0yAbQIb0XM82+BEVmzArow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793538287;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=80gthP6mOomRmrSiqjxG2lq3VeInwxEBN80IwtAH7zM=;
	b=CJ989u5Ausl09Ua504ky7068RUXNPUbGikiPE+f4I2OE15JJNl5jYhhtHXs2D6Pi5+qG
	 f74fOjmaju1yh5D3jFkttcW8QUmbzU52lyYmBxyFmoOlNz7Ze+pBvoc2/5QXcM+7b33GV
	 9GDqmgEthX7RaCJA1fiQlZvhEC4TxoRFEvnI25EEwelKxS7J4nnK0O3VjLVjEIlsKbkGB
	 mZwnb3wJxpnZHsZGvR9it+HlQfb7+DDF0rKq25sknNq9J1BH6BzbUKDPwu++gsvxlIp/9
	 b2jzi4OcgVGt46EFFjZon1Y+MNyC7rfhpWxYTw3/KNtxbIbsb1OUTiYvQj+dlaTZ6Yw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=botanica.software;
	spf=pass smtp.mailfrom=botanica.software;
	dkim=pass header.d=botanica.software header.i=@botanica.software header.a=rsa-sha256 header.s=google header.b=CgVeX7j2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BA9606A324
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 13:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69BA9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=botanica.software
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=botanica.software
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=botanica.software header.i=@botanica.software header.a=rsa-sha256 header.s=google header.b=CgVeX7j2
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e946155442so19025915ad.3
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 05:04:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793538287; cv=none;
        d=google.com; s=arc-20260327;
        b=FeLEExygSrP88fVnCIyUwBVAwNVJHZTsrrzAqRIuoa/Q/JyzKqszQH29sOCHtYoDfv
         ZH0wydly3aEgFGiqFLx2CCKtF5Tx4VLq0C6RbcJbdM2QnK2DC9JDb+kDne1mwoXfxpN+
         19yHpgrG/eKZq/xmx1qT2wuhlfd4rN8jxxVRBlmloa4DVRTlQevCV/JoX2npa68y5Eak
         V5BFIZLKGd5YTjMoaH9VzzfU7vHOYwv2izddpZ6aYur3rPcwTQzoOo9Qx7m39A1FXdjC
         8E2DBVBQHtDN37zB+zL22xucd+mA+CIr/IW9VNOSvsuX6tfgM1TQRl8WxwwS7c9GRqXS
         2tAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=80gthP6mOomRmrSiqjxG2lq3VeInwxEBN80IwtAH7zM=;
        fh=PprsTl/d5EsJz3/BbtiMPbIRSkkw5MmxzPuPTPNoYrw=;
        b=R9sKKkI5jsgEMA36MMgsahPwJMep3LNfyDp/UKi0qxdrWa/eA20JhwUqdAFR904H/4
         snJZNJalnShhyBthTpux684F/KbuHfTvOV7Gg25AjSufO1n/1x9TApNHcgpEWCs5+1Xz
         MGUmpISdGxm6DAXaHbRDkQRugil15jynNuji0iv+uAYa7+fGg6hHvWpOmzAWQpBo1JJM
         mQm7UzdVLRKG47GwU+mXLEc/+DQFNyL4I7IZpopa7LnQmb7RqCdNiCWEHxyfsE1m/r/z
         OiERFs+//Y3og4jSjSARrJR9OP3l9bL09D2B/ZmnQ/HcnLH2oLhI24IfeWfdj+GOpnB6
         hxIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=botanica.software; s=google; t=1793538287; x=1794143087; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=80gthP6mOomRmrSiqjxG2lq3VeInwxEBN80IwtAH7zM=;
        b=CgVeX7j25hB/UE/rFkBA8D6RGwCTJO2wmKm6eyzGwU/q3BlxLlXbCm6xJSCpP/AXeb
         GXLoUNZZ1zyyah+sVjFXCW4nFJ8+jkoDeL2YGqwaF8FO2evuq4MKNHEy39J19VVo5C01
         WFKzpGeWp056ljqfnCtj2tNDF995bSeHxKn/98Hfl8C8hWw0VIpk6NuV85lvNxtR/9sy
         +EIuaEBAoZSqkUJF4/a7qdtsNv9ZC2Y3+oOz1ZG+uVi4FHB2jM/M8AQylolZqbDcBJIj
         mD4EINDjWDf/3I3Oc+9LVPSBaCq/ZZvz1mk6sdeOuXtvzJNgtvEYtyuBZuyri6k8WPrM
         BJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793538287; x=1794143087;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=80gthP6mOomRmrSiqjxG2lq3VeInwxEBN80IwtAH7zM=;
        b=d56n8jXpvj+ZLgot8WeuJmv8GR7fEGyUrK7+djzR5G2vLP29b35AbeHwpdzgrleZ/t
         7cjvccZ13T9QlVpOYKiDDa9L7YA2iOtNMKvNL1Y2yXwUTB3kIkalrcNxa/+jlcOGwopk
         90YIovbiqqwnruzAm+u+JVFlx11JxbUn0J6ciQK0wwbUIhCfj6cQu188b8L8m5/kQYrA
         i7VJPbTuZQPVVbvmibujvy12pD/lSg1aFEEEtD6oK9pXRdO1ZVE732PEsQlS6loH4yTI
         1EoBpqw4R6mpU+j9fSDKToS5SQcmg6cdrP4wgHSv8uytD+Ppkz4E1GtRsUCTcF9aYKiU
         RVaQ==
X-Forwarded-Encrypted: i=1; AKwUvBwTVatHCEGHr5Bc51oGaz7Z6Avboi6pWKJmvufaAQCd27tU9MmsRoIM47DpeP522OOd8Rjz7dY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/i4Rt1Op5VrGbpU1e0NlV+N8/pQIcz8RsW8EJLw0hUlU8szSXg
	eSVnt7DBickCoAKkw+0mMEbBEX49V3SPmUi7AX2FTdbygVOl0uFPALns4U0dWWwRdqYPul6XBKH
	SlAPH9gX3Z7zjRYPK8Zlw7OxudVWAeNpMSDpXX0nhtg==
X-Gm-Gg: AYBFou2K/FK7Gxm9H19l5ivtH48f7mjX5TnpRKqiiUhwUeA7qQqjA3OcqcXZNdndCzZ
	r11Eu8iv1xPfzUPwNlqi4FBPA9sT3woayk8o+c+ljomnIDJOgN1gvmpdghjnoWFP7sbN4fYZmHi
	viDipHjNnw7iGvEU6meelGCuOlxroqPUflZhUgZ90GXfi1w6tZncBBpUtTsvSEofTDj41u0sc61
	mVrA2QeC2pm3C4KbImZiHxslRtLTG28Izkb1qS13P501q09cpPebYtsCZiKb5ki9md2l8Bwh4h9
	vwCmIlLAWQKW/+DC/mkeGgu/upbsh4T6ObhNutwv0i3y87WyRjzUZ+G+2DaFqg1vBjukOnsO5Ac
	CA6whkeTUiRuz0uIiWvjnctIInZkH4/Z++Dyf75OhUbSsgkeNOGN709lkc6I02sTv5eHA6o30zN
	7+YGauQOA3otLMzwYs7PMpUy/q4sxCLgS8rJXVdd2wifNFqIJS9QqE4uQ=
X-Received: by 2002:a17:902:d2d0:b0:2e9:5714:6082 with SMTP id
 d9443c01a7336-2eb3652031emr74872735ad.55.1793538286694; Sun, 01 Nov 2026
 05:04:46 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Alon Livne <alon@botanica.software>
Date: Sun, 1 Nov 2026 15:04:35 +0200
X-Gm-Features: AclHuK9ArFYWUdjusrpBxbq0GOsE8Xto7w81yu6lg2XoZBGhwFNoMbsmz8wtwCA
Message-ID: <CAL1NV=j_naY7Mf3BZtFR4OVQdHsxXurr4_6FF7RhJvxwF3Ma7A@mail.gmail.com>
Subject: [PATCH] HID: bpf: bound incoming report size in dispatch_hid_bpf_device_event()
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>, 
	security@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

dispatch_hid_bpf_device_event() copies the incoming report into the
per-device scratch buffer hdev->bpf.device_data with:

memcpy(ctx_kern.data, data, *size);

hdev->bpf.device_data is allocated to the largest parsed report length
rounded up to 64 bytes (DIV_ROUND_UP(max_report_len, 64) * 64). *size is
the length supplied by the transport and is never checked against
hdev->bpf.allocated_data before the copy; the only size check in the
function is applied afterwards, to the value the BPF program returns.

For transports that bound the report to the parsed model (usbhid,
i2c-hid) this is harmless. But uhid accepts up to 4096 bytes per
UHID_INPUT2 and hidp up to 16384 bytes per interrupt frame regardless of
the descriptor. A report larger than the buffer therefore overflows the
slab allocation with attacker-controlled length and content, in kernel
context, whenever any HID-BPF program with a hid_device_event hook is
attached to the device.

This is reachable over Bluetooth with no local access. BlueZ feeds remote
HID devices to the kernel through uhid, the remote device supplies its
own bus/vendor/product ids, and udev-hid-bpf auto-attaches shipped
programs by those ids. On a host with udev-hid-bpf installed (common on
machines used with drawing tablets), bonding with a device that claims to
be a Huion KeyDial K20 over Bluetooth (BUS_BLUETOOTH, 0x256C:0x8251)
causes the shipped Huion__KeydialK20-Bluetooth program to be attached,
after which a single oversized report corrupts kernel heap memory.

Reproduced on Ubuntu 24.04 (6.8.0-134) and Ubuntu 26.10 (7.3.0-10) with
slub_debug=FZPU. Driving /dev/uhid: create a device whose largest report
is 8 bytes (64-byte scratch buffer), attach a hid_device_event program,
and send a 120-byte UHID_INPUT2. slub reports "Right Redzone overwritten"
on free via hid_bpf_disconnect_device; the same report with no program
attached, or at the exact 64-byte size, is clean. Also reproduced
end-to-end with the shipped Huion__KeydialK20-Bluetooth program
auto-attached by udev-hid-bpf 2.3.0, presenting the K20's Bluetooth ids.

The missing check was noted by automated review on this list on
2026-07-04 but left unaddressed; the copy is still unguarded in master.

Reject reports larger than the allocated buffer before the copy, the same
way an over-sized program return value is already rejected.

Fixes: f5c27da4e3c8 ("HID: initial BPF implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Alon Livne <alon@botanica.software>
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c
b/drivers/hid/bpf/hid_bpf_dispatch.c
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -49,7 +49,10 @@ dispatch_hid_bpf_device_event(struct hid_device
*hdev, enum hid_report_type type,
  /* no program has been attached yet */
  if (!hdev->bpf.device_data)
  return data;

+ if (unlikely(*size > hdev->bpf.allocated_data))
+ return ERR_PTR(-EINVAL);
+
  memset(ctx_kern.data, 0, hdev->bpf.allocated_data);
  memcpy(ctx_kern.data, data, *size);
