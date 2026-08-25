Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338E7360EE1
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 17:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787679886; cv=none; b=TIXtM0AIG2pzwHdeMUsQp6qKR6Y6lj/HtD9TofFNRL17ybfviVkUBEzsIPB4J//W8Vn8Yj3fk4w0hW8sqJrzQh9b6Lb8LqYns2spwpn9NplK34o0SAawt0Ro0RDE22OyG580lvyzeV07Awtx8sie0dvY7ADJCgyi1crLE+TYWDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787679886; c=relaxed/simple;
	bh=xP5hC3EW+QrXcJ7cWu3d/5v7Pw2lYYABlggw/9Rw3Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7Xm/OhJpObv1gfUebFMpPf1As4DAYqFgtveHMvGJkCpV2yZaNFgGzJUCy19K/ZXZ7u4NZQNHNW9Tj5MdB5yb7tE+ruSiwZy7ezxcldT8BERPpK3kmyrvdJNDvdDwh0bf3aGki4MhW/AFWt2oH1oIxve+6pyuf5RIsvJ4s/etL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwOIdaoM; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwOIdaoM"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso138058a91.3
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787679884; x=1788284684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7rCB6I5x4Roy9GfTsNUlX+UKlokaetwV2w4y3hwUUZs=;
        b=SwOIdaoMvWGkxIDqhyz//Hhrbs5yjavIwc5MXbFZNWYH08AtziNnJjTf/1M7xo6YW3
         mCr9SAp2zWrTQmzP7br8DjKyaUk58IQ2Wsu6/e4SqF0NmGPESOpQefME2F9FCFqeoDyb
         XlmfuZmxI5WjVE/9FlKEtkdl1cvNDaqRm8qkq6oJU0Wm7c10k6dSCZT6csPvZcEcx/r+
         YDJaaH2ZUuMGA9QTNVw/ih641KYQVOrgDusbwe24d9MCX60/qiDr3+m41UWRCShBHgEb
         g2BD4YjOVJubmGqY/XF97UNeCo0BeTytUJQArffKsK+Vz3t4+cjI79V8Kt36dVrx3Ry6
         5p8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787679884; x=1788284684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7rCB6I5x4Roy9GfTsNUlX+UKlokaetwV2w4y3hwUUZs=;
        b=OX6QU0RpOSOCeD6bO0x4I8xGG7b0X3sV02n1liE1mEzL2ND+ox7DX52dAaFbUoqCyx
         yvrGpom93Xz7kCs3htgYktD88ue6TiufDeAQ/BixLMqMPlU05boJoRNic5CGMnsNL7eq
         H14kaZxYDzAQmJunm3jYtxse9UhLehRGs2cbbgtJs+yGFKqJ9R81hja/RgD8g779XDwj
         tVmrbFK0tZ2sjXQJPoWhRLa9RtC2ELlrGPh2PICxoer8iBicWHW5IbGBm5DA5xH5wtSz
         mh9ya5dEX45f9UWcxxbBIhimSd03jRKjcHBYgXVomksf8Ir6LCEBN6gbFjYqLX7D3R8k
         AfZw==
X-Forwarded-Encrypted: i=1; AHgh+RrP2sX2f+DTGYEcOHG+jk/06V54tquYd9n8d8q3QEz6+UkX0uqpK8irm/NJq1XfKdOjhY8yoes=@vger.kernel.org
X-Gm-Message-State: AFuF++lreY6aY0Zk86JJOMfBS58/GHob/N96Btj5MJIw46yzLg/QZsci
	s6H3XKT54tumHTH4kOY+xgsqxThcKP+QfxnEgk9JobT2Xi9poW1ECUXk
X-Gm-Gg: AR+sD108riDiJU+S9dpZvSxo7bKn0qXIU//2ga5/I+fY45FYlfN9lr8sDpEGPxeFXfC
	j6aSuhWx0Y0lCprQxfk6a/M/tZ8kLZ+eE/Nt7dsLXRGQ2tZll/0RtKyWr4PkUq4TyMhISWbhVNw
	UAAitogxj2/1m6HmEVYwdfnvh1PVOr2m2lLNgTk9QSYJoEiOUxupkj2MXTP2Grf23WnhkMIYlKz
	c9ZdOG8xHxtgBaWsK59vJ0/JvxjjT/H5ZFMYHIw0ENsk+GOKD5aIB9v8XVXnfxbKpvlcg9WgQ7K
	yGjOoYchjQbD3YZXO0iW4Gyyp+70W9+UGmLPUfaxwfmIzPKVpFbEffuhRtUjRxkK09sbe7+LNfc
	rbY72f5vBqPuKbXQwkhKnblWwNd1p5klOSIuECVZh8jByoRfmoNYURagJ9wsky6KoffORAcGxhO
	27C4UkU5nu65McuZ9po/eDOTBjCJVfSbuV2gjKhtXKC+7OMiW9UsMKbT/e2FXXuToEu7PEOFdL/
	WlL10k7q0rd4PhVgUTqe6q6MUG6XZUClo7QvoFmyidpdLPfOpY6/jV6WxX7rT3Go0h4YE6dXSVe
	5I1HjOKWKioV1BSlQaZdm8Q7951DsO1BpgEuZhpnodLKuqntIpt42MSQM8a/FHZM14tJApJ9Zl9
	BuSADRLnXgsrvEsfi9YIkAIGD2tva3PlRdu1dOgLQJfHun2tx
X-Received: by 2002:a17:90b:1fd0:b0:38e:70d5:b12d with SMTP id 98e67ed59e1d1-3966d3ed042mr1750141a91.6.1787679884462;
        Tue, 25 Aug 2026 10:44:44 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a905b959sm775562c88.13.2026.08.25.10.44.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 10:44:43 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] wifi: rtw89: cap firmware section_num before parsing
Date: Tue, 25 Aug 2026 23:29:38 +0545
Message-ID: <20260825174438.63168-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <26bf80f23bfa4fe49183d1f724fffc5c@realtek.com>
References: <26bf80f23bfa4fe49183d1f724fffc5c@realtek.com>
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

Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
Cc: stable@vger.kernel.org
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
Changes in v2:
- Add the requested empty lines after the section table bounds checks.
- Add the missing Fixes tag and Ping-Ke's Acked-by tag.

 drivers/net/wireless/realtek/rtw89/fw.c | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 0099c5c03e7a..b2991bc93f85 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -156,8 +156,24 @@ static int rtw89_fw_hdr_parser_v0(struct rtw89_dev *rtwdev, const u8 *fw, u32 le
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
+
 	info->dynamic_hdr_en = le32_get_bits(fw_hdr->w7, FW_HDR_W7_DYN_HDR);
 	info->idmem_share_mode = le32_get_bits(fw_hdr->w7, FW_HDR_W7_IDMEM_SHARE_MODE);
 
@@ -455,9 +471,25 @@ static int rtw89_fw_hdr_parser_v1(struct rtw89_dev *rtwdev, const u8 *fw, u32 le
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
+
 	info->dynamic_hdr_en = le32_get_bits(fw_hdr->w7, FW_HDR_V1_W7_DYN_HDR);
 	info->idmem_share_mode = le32_get_bits(fw_hdr->w7, FW_HDR_V1_W7_IDMEM_SHARE_MODE);
 
-- 
2.51.2
