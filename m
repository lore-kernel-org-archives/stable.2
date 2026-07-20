Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2F43A3E6F
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 19:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784574808; cv=none; b=pyHyxdFkHmVu+GCFIHa9l52y4BQNIGxfpNwQYs03cGE4xNJDc5msXyJSAdQKSgmhwP0QS1M9A+UZpMiPNqUI4YgCBb/DBxmn14dr3wIgXfzWZ4HdTvD+48yyl8JRIDbBS3A3vyrKn6SPgMyumiCyOdIDMiarcdYGSwVIHw0MlrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784574808; c=relaxed/simple;
	bh=n9hjvS79Gw4F+TRn7WgQGmj61r8D4HoJDfkprX6ec5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bRc48OCubhWCtI7krPzt/7fu95dQI8jo6etX9uWVDPT8uopNgnSexHOG95nXXcW/fp/3vTXy4XypBbO/8c3z+tdubGA9lHHLbDjHI+RHD3fUjHWNSugUEjmyOkaCpiwaV5gb3IdMsDgql7frTALTidNOpSWm2wQu5zurY7e/lTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=fwj+4wkL; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="fwj+4wkL"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4955484387cso12590935e9.1
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784574805; x=1785179605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xKFoZd3/2cdDCdHVjqGsrFciG9zJW2+KmWDiRs5og20=;
        b=fwj+4wkLC6PRhYdKyUZFyyaOrLjMUH3IsWa0MEsZFpmtUf3Wb9RwAZxriRHppMwpA4
         WGj8NnPsR0wTSn3GoyzVE44leVL9fZ71cXtCIBJ3dwnkgczYfv56gYRVgwT48m/rnXG7
         HIwMRgFeBBqbg4X0tKuQEY14UKIxSpRaRUcRDU+7R7saJgZuB35g2upMSNnJqPuCHGim
         Rba1nYnrUfec3DxLNsmJ+T5cXRmb3Il67zsHkryz7nkLtrMqDDZ0Kkj1NvMVdj/xlWMU
         SsEIzaPsWBnwn/I1rdh7cDd8JEn7dx1qKyDWfF4HEPq4N+khmL6WHdWaAvbs7HgG6S1T
         oKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784574805; x=1785179605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xKFoZd3/2cdDCdHVjqGsrFciG9zJW2+KmWDiRs5og20=;
        b=em/D6Lt4WbuiLZiJkYnueOdNBrw0YBIEjqXUZVqP+fy2LHyuz/BII7k2lubfLQyPKY
         5TuTKsubN6tMA2beZ/xD/NJyFO2fGAJS659pqBaAOuj8Nhn+y/jC59uVCJE9iL98qZxo
         9quGMzt1SrJGXiFmbcL89JDaWL+ed1qHkWnKNrWC8OdfXF3h786mdsJcbCf9LcFlwvuH
         /7TO/d2qaa/bdsEdrtjaT2kIVj6AEucOhr9V2aIZ3Js1XxkwIvd1HPGgDMXyWDwF8fXu
         wXG6sVUyI9/kd+ZSovWPbvi/6tfWZTz9+R00mx7+k7XBHQVysanKn80NR/KW+czCxsiC
         4l+A==
X-Forwarded-Encrypted: i=1; AHgh+RqEsQltIBxvTCB7A6Qj/I3rxlKjnlCZu3o5/Cg11OC1a+qdtwGEXhShCkuSXO8PIaC979f2V34=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQuCt3vGP8cjLdaksg3jCk76n0gicLKtrtkryRHrtyQMpqmtkY
	70IkPpD5L8o6nCS1izuCSkasxX+dlw/NZ4ITdxm41flx+4ERqCRnNh7P8TMG64/w2frd
X-Gm-Gg: AfdE7ckx9bhGPiYfMU2/HJh4H7IUyCU4a/Y4OXQyL16AGXBLLOUrMGUttFhxnwRJfL7
	mp1TOFXxE39GeZ/xiCx2uo9IPjjeo6WkVwDzwJSkBJfwpYMf1njZuwYPyDnGeNk0lCzXXHrYWa9
	TSaniKGQMjif36JO8QbKd2SlJe8FfI3IVa8tjXHhMbtRVMgFcAR4I+bxd7WIw3kPqCA0ae6OlPv
	smuE898P3+alnZvCqOHGb89Sp2lRNF7QOw+TE5u7P/agGpLqDh6I3GbjfpPfMS6kRbllWnCh+Mj
	AYhjEx+6MkIIXeQxbcpVuhGNvCcrGhykJsn+tiheju4hL/RH94wZuZYkYmuwCh2QbnWYjwEPBMx
	Uo+m/DH+ftZ1qYTRFsi6XnU6r3aintJ+9QesWQ2fZvEneUmcTz/BpV5duVD3mT83VycjK1CxYu3
	3a3JXN14AlhIpVXLJGndyrv8SHungtB7Syb8haWCbEbrtGNgljF+oqmFq/lWJDyPeCIe1qLSweG
	LtZZf8p6ReudWLG8jU4rQos
X-Received: by 2002:a05:600c:2204:b0:492:3754:15f2 with SMTP id 5b1f17b1804b1-4954a40bbdemr129148725e9.32.1784574804745;
        Mon, 20 Jul 2026 12:13:24 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956536870esm13926345e9.3.2026.07.20.12.13.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Jul 2026 12:13:24 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Neeraj Kale <neeraj.sanjaykale@nxp.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH v2] Bluetooth: btnxpuart: Fix out-of-bounds firmware read in nxp_recv_fw_req_v1()
Date: Mon, 20 Jul 2026 21:13:22 +0200
Message-ID: <20260720191322.14432-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 25c286d75821 ("Bluetooth: btnxpuart: Fix out-of-bounds firmware
read in nxp_recv_fw_req_v3()") bounded the v3 firmware download offset but
left an unbounded read in the v1 handler.

nxp_recv_fw_req_v1() advances a device-driven download offset
(fw_dnld_v1_offset) by fw_v1_sent_bytes on every request, and that
bookkeeping runs even when the payload write is skipped, so the offset can
walk past nxpdev->fw->size. When the controller then requests a header
(len == HDR_LEN), the driver reads the 16-byte bootloader header at

  nxp_get_data_len(nxpdev->fw->data + nxpdev->fw_dnld_v1_offset)

with no bound on the offset, reading past the end of the firmware image.
A malicious or malfunctioning NXP UART controller can drive this to read
out-of-bounds kernel memory during firmware download.

Bound the offset before the header read, and convert the payload write
guard to the overflow-safe form used by the v3 path (fw_dnld_v1_offset is
u32, so fw_dnld_v1_offset + len can wrap). Log the offset, expected length
and firmware size at the reject site to aid debugging of a real device.

This was found by 0sec automated security-research tooling
(https://0sec.ai).

Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")
Cc: stable@vger.kernel.org
Reviewed-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v2: log offset/expected_len/fw size at the reject site (requested by
    Neeraj Kale and Paul Menzel).  No functional change to the bound
    itself vs v1.

v1: https://lore.kernel.org/linux-bluetooth/20260705115650.81724-1-doruk@0sec.ai/
 drivers/bluetooth/btnxpuart.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 0bb300eef157..6d62d07a542b 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1041,11 +1041,19 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 		 * and we need to re-send the previous header again.
 		 */
 		if (len == nxpdev->fw_v1_expected_len) {
-			if (len == HDR_LEN)
+			if (len == HDR_LEN) {
+				if (nxpdev->fw_dnld_v1_offset >= nxpdev->fw->size ||
+				    nxpdev->fw->size - nxpdev->fw_dnld_v1_offset < HDR_LEN) {
+					bt_dev_err(hdev, "FW request out of bounds: offset %u, expected_len %u, fw size %zu",
+						   nxpdev->fw_dnld_v1_offset, len,
+						   nxpdev->fw->size);
+					goto free_skb;
+				}
 				nxpdev->fw_v1_expected_len = nxp_get_data_len(nxpdev->fw->data +
 									nxpdev->fw_dnld_v1_offset);
-			else
+			} else {
 				nxpdev->fw_v1_expected_len = HDR_LEN;
+			}
 		} else if (len == HDR_LEN) {
 			/* FW download out of sync. Send previous chunk again */
 			nxpdev->fw_dnld_v1_offset -= nxpdev->fw_v1_sent_bytes;
@@ -1053,7 +1061,8 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 		}
 	}
 
-	if (nxpdev->fw_dnld_v1_offset + len <= nxpdev->fw->size)
+	if (nxpdev->fw_dnld_v1_offset < nxpdev->fw->size &&
+	    len <= nxpdev->fw->size - nxpdev->fw_dnld_v1_offset)
 		serdev_device_write_buf(nxpdev->serdev, nxpdev->fw->data +
 					nxpdev->fw_dnld_v1_offset, len);
 	nxpdev->fw_v1_sent_bytes = len;
-- 
2.43.0

