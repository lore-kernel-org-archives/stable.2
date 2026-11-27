Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795799280;
	b=g1kj7awOGeJgai+ZL8S9APFEYzvRjxuF+w0dcBUUwtdWaFLoH/GeNV6GYNrqrzvOSQoM
	 SuMRPlNUeYabbinWBzjO9gNKPRFeKjwDMsbRpcs4Td7YY7zeW+0Cub9YFjuHNOjqAcTx/
	 c6hZXj7TrXB0s/9AN38ELNOohUlSIsL6gr6m1E8OwgKdeOFiAN1L16PyJl5MfYzB6jXvA
	 4cqtOxcxiKVj5ju90BZ9B7dxjpN3rS93VC+rAt0Asi5GbUxjaour8o7Uag0vllmZD3oUt
	 yVduk4WwJ8GhYExY6nmWTBHEGwuc4gT6QeA/sdvU9xBrtrrpLehOok8G8LhD7RX/IVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795799280;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nrYxwVugEYYYRaOAp5rMoj6BwgZ4LewGuH+K0t0KuAM=;
	b=Z+noXTo4N2t8kTmBTOMG0XnP9hurb0H+TfckIXzqD6rgqDiSyY6gM8R1fDSJvGj3PG4o
	 lTmbcjxyAsZQf8/Y/zaCtaVufBkM5bIntZFZi88/fy6ZrkheV7VUyrZyktwivSyce/AMe
	 iOyDHGLaWZxUsHDCA9aY2tQQxyKphEHNQVGdHr78xQ3yytpMAKswDu4kHJJdC4gvVvh4P
	 vAiFQ4fVJ+4JV4H6GwPtdvTL52fOsyCLQoyftxbNceroQJX26JIQMsnKoYoHkgVQPRpmY
	 YcS0OcHqtr1Bm9YFfLlmUPm2vkxTgAfbSKJwDZ1WvacU+c5c2G5vYoSciWXH6zYBHlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqKyXk2k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77D2606A329;
	Fri, 27 Nov 2026 17:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqKyXk2k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FEB1F00899;
	Fri, 27 Nov 2026 17:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795799280;
	bh=nrYxwVugEYYYRaOAp5rMoj6BwgZ4LewGuH+K0t0KuAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nqKyXk2kVyZjlw+YjnqtTUPW044JmpUNgXadouf17sDAQvYCQeDOfUA/r5l3DPpiL
	 cXhDwsfZTJakui4yrMrHib289DO7z9XWFe+X3p+6IfBSq7ickxuQWmA38ImOnLBJs7
	 c9hv/NbRl63rdtT1lAj4FkfEaromiriudFXQsWSV2TkC4RNmUJebh7wO9anqj/FAcq
	 /gP9OqYclccDIHRZYDXqsTPaJ1fzpK7Gs9TV8BnKOlJLDNCxD8luHNdFM4ieFccwAi
	 OKRv5rugUfJcIZIFMzFjOEkinio1pqtUrwXjRQZvp6Hxd80Zaa//9r1/DqSA8/68Bm
	 /JhT0hZtT+kvw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: [PATCH v2 06/10] HID: hyperv: Validate VMBus packet and payload bounds on receive
Date: Fri, 27 Nov 2026 17:06:24 +0000
Message-ID: <20261127170712.3163443-7-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127170712.3163443-1-lee@kernel.org>
References: <20261127170712.3163443-1-lee@kernel.org>
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

mousevsc_on_receive() dereferences pipe_msg and hid_msg_hdr without
verifying hv_pkt_datalen(packet), passes the untrusted pipe_msg->size
to mousevsc_on_receive_device_info() without checking that the VMBus
packet actually contains pipe_msg->size bytes, and copies up to
sizeof(input_dev->input_buf) (16 KiB) from input_report->buffer in
SYNTH_HID_INPUT_REPORT without checking input_report->header.size
against the received packet buffer.

Validate that hv_pkt_datalen(packet) covers the pipe and SynthHID
headers, that pipe_msg->size fits within the received VMBus packet, and
that input_report->header.size fits within pipe_msg->size.

Fixes: b95f5bcb811e ("HID: Move the hid-hyperv driver out of staging")
Fixes: 934b7778aa7b ("HID: hyperv: validate initial device info bounds")
Closes: https://sashiko.dev/#/bug/linux-03d64dd2-820e-44e2-ba9e-b4a70f1e55ec
Cc: stable@vger.kernel.org
Reviewed-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Signed-off-by: Lee Jones <lee@kernel.org>
---
v1 => v2:
 - Add Reviewed-by tag from Hamza Mahfooz.

 drivers/hid/hid-hyperv.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index cfc061dbdd24..1de03e38f363 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -272,14 +272,22 @@ static void mousevsc_on_receive(struct hv_device *device,
 	struct synthhid_msg_hdr *hid_msg_hdr;
 	struct mousevsc_dev *input_dev = hv_get_drvdata(device);
 	struct synthhid_input_report *input_report;
+	u32 pkt_len = hv_pkt_datalen(packet);
 	size_t len;
 
+	if (pkt_len < sizeof(struct pipe_prt_msg) + sizeof(struct synthhid_msg_hdr))
+		return;
+
 	pipe_msg = (struct pipe_prt_msg *)((unsigned long)packet +
 						(packet->offset8 << 3));
 
 	if (pipe_msg->type != PIPE_MESSAGE_DATA)
 		return;
 
+	if (pipe_msg->size < sizeof(struct synthhid_msg_hdr) ||
+	    pipe_msg->size > pkt_len - sizeof(struct pipe_prt_msg))
+		return;
+
 	hid_msg_hdr = (struct synthhid_msg_hdr *)pipe_msg->data;
 
 	switch (hid_msg_hdr->type) {
@@ -317,6 +325,10 @@ static void mousevsc_on_receive(struct hv_device *device,
 		if (!input_dev->init_complete)
 			break;
 
+		if (input_report->header.size >
+		    pipe_msg->size - sizeof(*input_report))
+			break;
+
 		len = min(input_report->header.size,
 			  (u32)sizeof(input_dev->input_buf));
 		memcpy(input_dev->input_buf, input_report->buffer, len);
-- 
2.56.1.839.g22a8290db9-goog

