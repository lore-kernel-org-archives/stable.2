Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618813;
	b=Pl9ne5J9iF1qrW3mvyJTlStx0zmFi/j2Ng2bY3KqKNGDInMnnub6EkJcFWTILKlXBcAP
	 nHxLu5hrYlc+BZHLTrZs8JL+WtVKA6OBCFz+TmLtCIfK7jfCDZjbdHSqiBTbLVBkH6YUD
	 8dUafnuSPfkuoRoibC2435FBsclBMCH82QZx1QlUwfTsQ5INpbT4VBOdueiGDbqy4MSAS
	 B4YRk5SeJGOSMTNHmJxBn1J1K9zrbLPlCpXx9oHY4oDW6LOGpd+aTnr6MXkdum2kDQgut
	 tgiGfn7miiEh12SC/5yn9XmInnJ6FylMjTTh5/0AGsRzn18QyneWzMTNQUM5pIes6zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MuHBdOREgT33dVaiK+GfvRB4AtU3CtWcrJ1VyfxYTOA=;
	b=t2aos6bR5tRu7A4qOD3xFav1xUsYOWsHvx28THwPrN2eAgUvmtrFNdoaHMIF9Zmx8DuH
	 p45lsqOiIucRp/j/hSfvplAMqoaHdtOHjTTWrsGA4ffUqydUsl7zGZ3JUhQn2vQ888oVw
	 sNg7nmsg9WWFsvlq4UbAzNdm1ejF0IJmo1OqIoRUHaULSGQQUwc63ULb+yKL9ZkM/2TxS
	 bQbENVCy7lSMwJmM7LpDEnx+FQWsLWT5EoomGWe1j7hSZQJdzivULTgwIM9iZ9WLromES
	 yOcYv1AYTjaNmJsA4islkvbUkR06eZFXV+CW1TPcjM3KLxUhZTKI1cEbj4TmqZTK9PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=botanica.software;
	spf=pass smtp.mailfrom=botanica.software;
	dkim=pass header.d=botanica.software header.i=@botanica.software header.a=rsa-sha256 header.s=google header.b="b4U/A0ID";
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70D6606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 11:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C70D6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=botanica.software
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=botanica.software
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=botanica.software header.i=@botanica.software header.a=rsa-sha256 header.s=google header.b=b4U/A0ID
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so21839185e9.3
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 03:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=botanica.software; s=google; t=1793618811; x=1794223611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MuHBdOREgT33dVaiK+GfvRB4AtU3CtWcrJ1VyfxYTOA=;
        b=b4U/A0IDMYCMtbjw9NloplekzGCqR6wa7FE9ezsCBxD2IuUmdSrPkxqpvKl5J7SyjC
         ApI5ZRq9/MpJr7krna024i4ZSo5701g8Yg958IVVzCakwr+CDVZc0iSkgMnYAQerjxEA
         siBV8Db0jwVBmmPFQRQRarJLuTzQTEOIhqLd7HJrVhiVOU9UwcHiI7bmMuFCVKjwWFq6
         foZPQROpagq8L3cxXWE7aHIl9C3Oi0sA+pncM9LjubDXh/ce1dGoZ8wOqrYT9RXPcdHf
         iT+mjRmlU/xpABHX/9pPzgOqEnzlhg8d73QF5L40WNS5pqPpgdznILbp2NTR+nhH7ETx
         0Uig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793618811; x=1794223611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MuHBdOREgT33dVaiK+GfvRB4AtU3CtWcrJ1VyfxYTOA=;
        b=ULqKpqN2Onam4bU3dc5CLkjNuz8f5zvEIRAWgT29uOqMr/+fajaAkD58k3WJ0OM/fz
         7vSoZ5Hjt2haL6/KfWcXL/8abQX77lYR5hfk2IJdAKEKZpC788gWOR8QL1hZO1A9byv5
         000aTf9bZ+LTnxKP6Scf3A5W7GaJ8wsK2qjqW9qTQdKXYw8+9+XBo++JITrN7Wbjzx4U
         pmsIAKKGY1q9MFLPXyun8OnpE3RiC0hzYpF7mODpAWs4yAc0ZAsSPQK6VSRuFJQ70c3p
         z7VombiVej629kupROoZkMDF7OHJ+iyJ1/a7rC9FaV9XXPJPAGyfKeOlfr7Ax8iz9gqw
         W2fw==
X-Forwarded-Encrypted: i=1; AKwUvBy2q1IiYaKYnR8wBDgwAot6ejASAg7l4Zf9tyzUltAObXSXtYySBQIq1C3Jf0L7iaHYIQUGRDE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjpyTGa+qOTQ3pPsBYmZ9gQTLfTRzLs9pHM8IFVPj7nFa9prp6
	Q5SQTpBNd88u3vty/8/byANwtgzO0I3+kqZQ7JrgJJ5mkcxZuHEJTlmPm0/U3rzUn8/e2P2W4cF
	OiSihjHg=
X-Gm-Gg: AYBFou0m5SMD5NTGXho7OJNA4VVSCuVoDFfJxWsdQPbT8IIU7UIesh/fazRvMjtzykC
	QKCsIQHbhMCSyQtOQfDpsVU+OqF6rGQNunS/zZjOEBVz38n5YzzjBu2jLzS94NrAuAba/8etM5C
	dnu6hvBwEek4uDVHKG2ZgUOMoKgB6adpvf2cIVDBShFIW5GRL5yETbmDLyNPxs9Zay9GKK1XjQc
	EIn6xyaeTjiCS5xVWoW25HB21N5lnVpMuT5WwvPxx0PrPVbUwCzQ98pN3SaP1Md0NSCIqm77omS
	xAJf7eBHdmfkinixdOLvj7ZStMPPnaA36ZIc1yYPuPr5/AT0QJeWv3/dYGPmYUKpWOX3FKRay7H
	hpaP7TzuQDhVyh8msM+VIo5trnVvvC0W8elqx24mnxnqtS/GJqHDl7wWnPvon6i+0TrGksDRCS8
	CEytCfrGRgvaDdAtLMbnLq84uM+V68/un+DJovudUFVs27rrziHWCgJU86aHFiCP3i4jouvZAgB
	yq4JuMEe6vqRWVffxfeKi/YlZZFyRdX8FhB5OHLw8BGqBK8qEqpRxgmZiNRw8LgOpQcXfMEizCh
	Ina3EIyz3Vtujq4uFHRnWzInulQWt6OSkbevPUvAJbL+AcX4MvL3hLVI6tMUwgZrGaVkkqc9byS
	3/c5s3v1z5aN9XkbRtTS8YOpn3hFfUv8xmj/A0bS9XxRfagLr6GIWQxcvhJOpdrnxpJENiwdLZX
	SKDAfyWR8gHh6BumjNBtpvPKP21InRaCCeEZRb1XDh
X-Received: by 2002:a05:600c:628d:b0:4a2:397:73e9 with SMTP id 5b1f17b1804b1-4ac17d1995amr226446505e9.18.1793618811026;
        Mon, 02 Nov 2026 03:26:51 -0800 (PST)
Received: from localhost.localdomain (bzq-109-67-147-102.red.bezeqint.net. [109.67.147.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac0a0a3495sm211033105e9.4.2026.11.02.03.26.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 03:26:50 -0800 (PST)
From: Alon Livne <alon@botanica.software>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	peter.hutterer@who-t.net,
	security@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] HID: bpf: bound incoming report size in dispatch_hid_bpf_device_event()
Date: Mon,  2 Nov 2026 13:26:30 +0200
Message-ID: <20261102112630.53400-1-alon@botanica.software>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAL1NV=j_naY7Mf3BZtFR4OVQdHsxXurr4_6FF7RhJvxwF3Ma7A@mail.gmail.com>
References: <CAL1NV=j_naY7Mf3BZtFR4OVQdHsxXurr4_6FF7RhJvxwF3Ma7A@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Changes in v2:
- Resend with git send-email. v1 was whitespace-damaged by the mail client
  (tabs flattened, diff and hunk headers wrapped) and does not apply.

 drivers/hid/bpf/hid_bpf_dispatch.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 6b467c7..ea56223 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -50,6 +50,9 @@ dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_type type
 	if (!hdev->bpf.device_data)
 		return data;
 
+	if (unlikely(*size > hdev->bpf.allocated_data))
+		return ERR_PTR(-EINVAL);
+
 	memset(ctx_kern.data, 0, hdev->bpf.allocated_data);
 	memcpy(ctx_kern.data, data, *size);
 
-- 
2.56.0

