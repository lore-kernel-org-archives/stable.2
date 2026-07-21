Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD80434DCE3
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784669411; cv=none; b=QZQj7r1kmt5JCeywE0H0W8ggfSUTvXawOvrY1DgS3G2yBvC1e12WST27YuLl4W+t9u8bZj1eqWxRgWAEGQzaKENC+V2DB6pkMXP/n5Bx6v4hrRa8tATqix++rl7SCxGk1PXoo4lPxleqHV9iGHSzUasScb2E7nlEBU1v73uDmf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784669411; c=relaxed/simple;
	bh=P7ujY1EjctEEJ5BiCaydXlUdc5GaBLmNSJjxyuWmsJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YrMZcpE1FyE4+Izvlczwb8yljm2uLN0O1aaAQEl05l9UVcKIYcFDfiEPIYCHFgt0PxaOweJqS5zhZPQT5AozY9cEGZ8mlJJxs7K8XQ0LLmrtP/XJ666ZcrDUoaa43Vx4jau+zKo6C9IESLxk+CgVyOf2gZ/EAJC3bRo4viiOaTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=T3WJo1Sp; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="T3WJo1Sp"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f71156e1aso1539238f8f.3
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 14:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784669408; x=1785274208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3s/JSUZXhrEE+qb2/7zOa34Br6kcFp6PkK9c5SJgKlI=;
        b=T3WJo1SptPzmlk/ldenzEcIE2GqeIiJwBqYm1DocSde9Txix6fRcGn2tIWpocS/Z3F
         8yHBG3boHSQBSSioe1OsfCMHVhexXDHxLd5NkCQgXFAzRZD3Qi+mP1XIcef9pk8rQb4t
         64CrHX9/6PwLnCmPw0GafMTPDc4qDszvl8UlKfK5onTE48pNSLb57l0trC7P8HKaBsDq
         QHLPURCMCFjMmCDs0Yp8qowj8Qn///BVCFv3Kx/lvZZeu4WsrN0/uSnn4xhxVmm6xh5F
         4RN8d7/a9XliGagmN4lj3CEIQquNtRxID6ZvjkMtWfcItQFHqPDCiDcEBPXg2UVvppYM
         WT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784669408; x=1785274208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3s/JSUZXhrEE+qb2/7zOa34Br6kcFp6PkK9c5SJgKlI=;
        b=aSHRvbzkAP5L6s+cz1V3yNNLbPGTWsZ2TEDwMHWU0wvGkLr2z8mVZWFnltgMmn8ZnV
         fFAME1Ypem/Hqhtx/zpTD1XarI5jujN3QvD349hkSc5IuXFJ4YXv0K83d9gEV7zaHp1X
         wbFCKjj0QxL6O4CnAKn1vLlCFI/e6TayuLXZG9F7y/+HUDio7iL7GO3+2VyjivPcMtgL
         VVDjqswMMdnYmDlfo3FDO8Lj7fQ6DLxYzGu36tveP+gLrnydmrTFGFWDAOeJln8CAdQl
         kE+U44R8tbZ5ALgQ5u8gf/0gV999UBjaI2HZzlWV3LI2AkcSKeKAoPvn9guRcAgTmnej
         oLKw==
X-Forwarded-Encrypted: i=1; AHgh+RqsZ5k/dwI6EBWE1nLNyAQ1lrO8uNB+rwcMkMu62jK4haDwEaqa50JXA9LeSoadxWy8igXPi5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2lr2P71l5rNQywl5N5ZkxvDCuvGQ8ouXk88G4oA9lDNaGaDqs
	9KVdKSY/ZJ4c2ldk+/XF9H9hKarGB5DOYKfDaseYF/vqkMDbYGV4EuuiupHJHZ3YJSQT
X-Gm-Gg: AR+sD13MSr3eqFQnx905Lt1KzYyuKGvAAXwDLl3y3W0wobXd1xZyNYhiIKKt3wflwVB
	Hm6EGw6oq3w5B5lHm1ofjnAgVT+7zqLSw5fuIzERO/78v32Z2/1qiAlJjCcfp1k/21Zvbcsdbsm
	u0LgdVklL+vuk8D2cbT8cDNxLgIyYPS3qpv/yJMVOPy62NXvw++bL22cJj+gK8Fm7/NSmk7gPos
	56LWJe8T7rGHG1YFOVycDzoj8+2zZ9WQ+6uG4hyQgZYcE8f8TfydJAA8mRywgBs142YYGPweEsB
	vyj/eg5wqdHBA45aDqDeZUOG+gaxsL3DsqjyQsMi1Fk8n220vHxPfWdHRholaRrXX43dZduk8N9
	ghBa0Am1RXEKGG7+7B5OhN3JRRjaIsoaFIQMF3C9QazR9p7z764H47phGNkC4VuWcuDFBC2Pnle
	/29BgHhAnxeeScDqeib4bntqj4NBlfWnoWA1YG9c/TaBRakcF4b7aBggmHCFLaxCFuJotsLaIi7
	MLKROoFmNTAuPEmHxtKM2fl
X-Received: by 2002:a05:6000:2c10:b0:47d:f023:b4b3 with SMTP id ffacd0b85a97d-47f62328323mr23668481f8f.34.1784669407123;
        Tue, 21 Jul 2026 14:30:07 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e519f4sm40482672f8f.14.2026.07.21.14.30.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Jul 2026 14:30:06 -0700 (PDT)
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
Subject: [PATCH v3] Bluetooth: btnxpuart: Fix out-of-bounds read in nxp_recv_fw_req_v1()
Date: Tue, 21 Jul 2026 23:30:05 +0200
Message-ID: <20260721213005.38581-1-doruk@0sec.ai>
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
u32, so fw_dnld_v1_offset + len can wrap). Log the offset and firmware
size at the reject site to aid debugging of a real device.

This was found by 0sec automated security-research tooling
(https://0sec.ai).

Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")
Cc: stable@vger.kernel.org
Reviewed-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v3: reformat the reject path to stay within the 80-column limit (hoist
    offset/size to locals, fold the header-request and bounds tests
    into one guard); no functional change vs v2.  Drop expected_len
    from the log line -- it is always HDR_LEN at the reject site.
    Shorten the subject to 80 columns.  Carries the Reviewed-by,
    the logic is unchanged.

v2: log offset/fw size at the reject site (requested by Neeraj Kale
    and Paul Menzel).

v1: https://lore.kernel.org/linux-bluetooth/20260705115650.81724-1-doruk@0sec.ai/
 drivers/bluetooth/btnxpuart.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 0bb300eef157..423a20f78baa 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1041,6 +1041,16 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 		 * and we need to re-send the previous header again.
 		 */
 		if (len == nxpdev->fw_v1_expected_len) {
+			u32 off = nxpdev->fw_dnld_v1_offset;
+			size_t sz = nxpdev->fw->size;
+
+			if (len == HDR_LEN &&
+			    (off >= sz || sz - off < HDR_LEN)) {
+				bt_dev_err(hdev,
+					   "FW req OOB: offset %u, size %zu",
+					   off, sz);
+				goto free_skb;
+			}
 			if (len == HDR_LEN)
 				nxpdev->fw_v1_expected_len = nxp_get_data_len(nxpdev->fw->data +
 									nxpdev->fw_dnld_v1_offset);
@@ -1053,7 +1063,8 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
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

