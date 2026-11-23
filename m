Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795449149;
	b=RUvE+tiPHEs4aRmqFMYyrpPG7mBQnWXj19IpkrTrthAgUAa+2x66VM0T9GpvCApjH5dM
	 swh9EabUmSkyw8arvqqZBYYIGD67/o0ixp9RCNSSjwx8fXYbqm2Eurx2diZN/6fU/NmRh
	 eVJDSeZlJ3wTM9RpxinJmuTP/l1CvjzWHVlLLcnEOvb9Pepk9YNdgwQD+/dVIgjacXFau
	 rJO6o+KXypXpaDQUQ9SQ6DoVU76kGLpCKtCCJKefdGz8wTP61mIsbJAxDa7OIbF6DScCl
	 H/ScVxrxQrKczPbFOJr+Tbcy74Nz74ocTq69aBpNcqsSKcm6xaoxRE0fDJ5hNHwOvEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795449149;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=T1eKsQdeP1W/szEmEQnzcI4fvm00qDmXu7Ua9kiN2Po=;
	b=npz+99YuaJzhudk+Ytap6F67NFF7NNsCF/rh83JF5hEr3VWVZoouUUI3yerA6eMvp1nK
	 F4KQwAEb2kxYJhnvCyNfFMtoeuFC3DdtHDX/eKWvoUx+d6a0UUWnPsftBkRUCBqpjngY4
	 6wSRiRNEf4H9z3i3U/FIwLeAl/uaucnlTw5VzTDCnS6Bdn1FiXQCmVVnUGHU3gZS3FYY1
	 iy7NbPLh5Oaw+hW35yk9Y0m7BIhch2iTXOUO+ouvdzplbSHek3Mw2m/ThvWpZ8+k5Ba3K
	 QzF9mppFZVdSbvBP3lgO4IsD8KsbEGAhUSJ+rLHKGfy+BP/nFuyLFr6WcAiyrtTSW9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c4VnL3nZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4E0606A33F;
	Mon, 23 Nov 2026 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c4VnL3nZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08911F000D1;
	Mon, 23 Nov 2026 15:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795449149;
	bh=T1eKsQdeP1W/szEmEQnzcI4fvm00qDmXu7Ua9kiN2Po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c4VnL3nZwcgtGvdfTgYTFfjks6zqU3FAAeAPV8cpQJHC4DfIbEH98PbMItYdLuIB1
	 I07mA4gpa4s70zl0WEaTwu/lciNC+GTv2MsEk5wJoX0iLabisUaCuZRM71VAq3JCA3
	 HCMnhWyvA6z2Jqi8+WvMmlZp+arSpkWeQtB71eP9OEy6wZIVNwWpXooZX6hgJ/PZ9K
	 gmziNb4p2oQGrNqeaafpKbfYtIsfCijQfgwed0uqX8WRW4mW2V0f01Gk1BaC7MFlIC
	 Xn0HZqAB3OR33et7+wxW1PzjMcqV+bS2t5W6Qke60M/BqQC1X3iLDw68uQnFO6wneZ
	 63A6Lccq5KLlA==
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
Cc: stable@vger.kernel.org
Subject: [PATCH 06/10] HID: hyperv: Validate VMBus packet and payload bounds on receive
Date: Mon, 23 Nov 2026 15:50:50 +0000
Message-ID: <20261123155138.2907049-7-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261123155138.2907049-1-lee@kernel.org>
References: <20261123155138.2907049-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Signed-off-by: Lee Jones <lee@kernel.org>
---
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
2.56.1.750.gf70dc682cf-goog

