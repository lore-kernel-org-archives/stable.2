Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6F73ACA5C
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787385622; cv=none; b=ED6euW7HfAClpxlDwDzQLg9ri9toK2oee6x1Vtse4UvwmTGR6pDjliX79HyFgwnuwH9ep+G+6O2/P/b1eUc+qQOX3dO8bMl6+HN56IKvBJMVrdyCVPQoS6io15xhZA9h7fN7WSLbq7MDzNViT9JJf2SvIop3Ps/bwsKSkkcAPj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787385622; c=relaxed/simple;
	bh=yAOiruEm9L8AjUBZGFt6yw9dAsrnsAkjYEMNNqDarWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e7iKLNq8n0Q80DGVfHdMgA2NfJ5GrHFHTy9J9TTswCCqW+nSFPH3Q2f+R7rCBoZO7LkSzQdu/i2tCF94+zzw0rKdqc3ly/EPaej6qcabl84DY0A4ELr/RWIHygs0RKvaJ3ZHudOZ9Vleu4qjMdLjxdH6VHlsicrTzqupDFP+qI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oagJeHyV; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oagJeHyV"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e58034d05so1483915a91.2
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 01:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787385621; x=1787990421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vDG9YXYoRtMkAetCjmKzpnMDn+Xh8GlN8oNesgXLH1w=;
        b=oagJeHyVlwtClV7l2gpw8K0kF9mFeM0vIb0o/2l9raenmWa9RvIqYNjrt4XrGfpZFx
         MrOyb0TbA7pJREpdJ3cYl/ri5Wgl+3MlrYdR078YYiDnYjt3T4QZm7pkfAWVA+7xyoqX
         WnsCuCrCeODPRbXtadDlw44OtguiKjAJtE5BkimYdCHRNbHov52PM+5RaR4lqxEmsB0+
         jqDHthH3lTQFRHdyP/I+eyqdu4QYYJB5DJDnIJbFx5QifmLE6fBK8gqIJlYLkDDBcIkC
         CWAmzh3AOUu26Kh8VYPbK2Iwp/R35alXDOhtNIWDWLsqWsxpISeEiuoao+HCgF9xqJV1
         yl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787385621; x=1787990421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vDG9YXYoRtMkAetCjmKzpnMDn+Xh8GlN8oNesgXLH1w=;
        b=pM183XSZy3bMjLR3a5h0PqMsG7h66C4ij9dMP+8z/vJE6nhy6GceEr5ORVjhZ8j2Tn
         R2Nq9kvj7Lu+4pKqxVpAPprWBrekiJ0QfDQhTRiDru8TF6sEolSX+Fx7q0R6JmbPnB6O
         WFVVI9rJwQXV3SdiUR754L8GlVJB1JXIbSHojy9IKRDDYKICVVW+gdV/PZR1wfZiVjyz
         KByHYmuUZLNxUVhvjZuj1drv7dQEI4Ur+HwJtgemqvBGTjMoMz0sqo8jO/LeO86duum+
         0D+b7JaaXONpJUYQTKTM24XLF3vYldnWNlsWKJ91Rr6RpuD7JYkdQjM3UioGj8smCTs1
         HT+Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro+5hflX+BCJ85asAivm4Ug+0oKLgnny2lUBFImJxrrfsikp8zdRqDvwxcWiQdgzwosfVFKEl8=@vger.kernel.org
X-Gm-Message-State: AFuF++m6k05TGf1TYnLXoYM2pD0pAlEZmhUzu7p9nBUv1n9GRo/orGzN
	DtqYqJFCUOp62n+IXhM+SRM2nyp7fZ2BH5donTsFacGF4qsxatBCFrF3
X-Gm-Gg: AR+sD10IDZ67ZNUKAm/ONAFi/DImLlLE08zac9UNrJ64NCW4A/EghPnTKIayqYR+IRu
	0Gd6z7aRcrTEf7Z9a+p1RJ4F26GK2sYSfIFIzxfUuUJwmC+EUHjX7c8GQ++XqpO1AvQ1XdBQRzg
	X/2g1rt8oHYc+fZ6nWq3fkD3SVMhjmoNOp3JLgihsPOTBzie3hIHplusUI1iD184eA5qLUS5O0+
	OjaK/PPhf03XWpgyYMRbYAb/JItYO4wjPTiL0MZVf91wi4qoNV4bm5ElqYpJO+hAxb5CAz576L/
	wYwDIpYmh66JN6QoXnQZ4YB/+8KFyVarL4Imu1KT11CkDAv1ziTwbmQbU97oFzgQlz2cZFPk3QD
	uXRo7gXh2ecD07n7z+p1I9MdaHjBnzQHSz2KI8MUxIBvhXvDQLu3PdZXfkaOWp+noRn3DgGSt9E
	XDAlUhFHg0KWeyp1IKgtk+lUWDSQnPlbXBdApE+uwGIbMHdRerGegdA/iYCsI5eP6qFC/dYJpVI
	LBbR6pLWAqRYKzBAMNr/tgjqjl8HzMjglc6bb42Ceh78Oks2NJjyeLZbFBUxuHuOIXpD5vXU2kQ
	ItjtlylWQbUGEB+zYawbVb3hjlhWAHfb7m9kweOb1ilCBKuFajot/h0QQCI/rEIo5wyWmXn2EvC
	dp7s4af27bMLFiu1b8wtornGTxS1W4H8N9QjcEnW7nlRrtn6kATPyRPJmWMz1KrXnlZsa+Q==
X-Received: by 2002:a17:90b:3bc6:b0:393:194d:5366 with SMTP id 98e67ed59e1d1-395c354da4fmr22617902a91.10.1787385620517;
        Sat, 22 Aug 2026 01:00:20 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f909c6c9sm4897116eec.6.2026.08.22.01.00.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Aug 2026 01:00:19 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: rtw89: cap firmware section_num before parsing
Date: Sat, 22 Aug 2026 13:45:14 +0545
Message-ID: <20260822080014.29611-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtw89_fw_bin_info.section_info has FWDL_SECTION_MAX_NUM (10) entries.
The v0/v1 header parsers take section_num from an 8-bit firmware field
(0..255) and write info->section_info[i] with no cap.
rtw89_fw_download_suit() keeps that object on the stack, so a crafted
firmware blob overflows the stack.

Reject a truncated header and a section table that does not fit in the
firmware image before reading fw_hdr->sections[i].

Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 0099c5c03e7a6..57d4252ee78f0 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -156,8 +156,23 @@ static int rtw89_fw_hdr_parser_v0(struct rtw89_dev *rtwdev, const u8 *fw, u32 le
 	if (!info)
 		return -EINVAL;
 
+	if (len < sizeof(*fw_hdr)) {
+		rtw89_err(rtwdev, "[ERR]fw header truncated\n");
+		return -EINVAL;
+	}
+
 	info->section_num = le32_get_bits(fw_hdr->w6, FW_HDR_W6_SEC_NUM);
+	if (!info->section_num || info->section_num > FWDL_SECTION_MAX_NUM) {
+		rtw89_err(rtwdev, "[ERR]invalid fw section num %u\n",
+			  info->section_num);
+		return -EINVAL;
+	}
+
 	base_hdr_len = struct_size(fw_hdr, sections, info->section_num);
+	if (base_hdr_len > len) {
+		rtw89_err(rtwdev, "[ERR]fw header truncated\n");
+		return -EINVAL;
+	}
 	info->dynamic_hdr_en = le32_get_bits(fw_hdr->w7, FW_HDR_W7_DYN_HDR);
 	info->idmem_share_mode = le32_get_bits(fw_hdr->w7, FW_HDR_W7_IDMEM_SHARE_MODE);
 
@@ -455,9 +470,24 @@ static int rtw89_fw_hdr_parser_v1(struct rtw89_dev *rtwdev, const u8 *fw, u32 le
 	int ret;
 	u32 i;
 
+	if (len < sizeof(*fw_hdr)) {
+		rtw89_err(rtwdev, "[ERR]fw header truncated\n");
+		return -EINVAL;
+	}
+
 	info->section_num = le32_get_bits(fw_hdr->w6, FW_HDR_V1_W6_SEC_NUM);
+	if (!info->section_num || info->section_num > FWDL_SECTION_MAX_NUM) {
+		rtw89_err(rtwdev, "[ERR]invalid fw section num %u\n",
+			  info->section_num);
+		return -EINVAL;
+	}
+
 	info->dsp_checksum = le32_get_bits(fw_hdr->w6, FW_HDR_V1_W6_DSP_CHKSUM);
 	base_hdr_len = struct_size(fw_hdr, sections, info->section_num);
+	if (base_hdr_len > len) {
+		rtw89_err(rtwdev, "[ERR]fw header truncated\n");
+		return -EINVAL;
+	}
 	info->dynamic_hdr_en = le32_get_bits(fw_hdr->w7, FW_HDR_V1_W7_DYN_HDR);
 	info->idmem_share_mode = le32_get_bits(fw_hdr->w7, FW_HDR_V1_W7_IDMEM_SHARE_MODE);
 
-- 
2.51.2

