Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281081;
	b=DobkWsWoUQYgdD1Mf/v/gBNM1C3dlcwOKv3F1YsUhlLwMhj79jS84OANUURArlG7VpaY
	 pDNjrx17qro0ECEgbpHdNrnpw+AkXwFOeScQXvivyMT/cYas5hmVnwsSu39goyNj+dNXi
	 mZqGGpOJzmR3Ze1lNo9PTlSn8axEWAGaDDTCG7FWfaG7y/4j8SSEWhF7FkUV/Dj//sJmq
	 J5+DbhEpGX3+texyQZVhrbNWEW+yDVebXjXnAS57T/y/+xF2uAIW/H576MIAtUP9l5S7n
	 0mRQxKxSY+EvLpIpImeWXqIvLwQ+1FSoeV4nI5mq5BaXV/AjnWzMw0+rGbBIyW2V9Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281081;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=B1b5+J8iQ2XcB3Uaj940MPs/dMrgMvJeCEe52AQjPtg=;
	b=S6AjTopx+UiE44SKhH+ODSbJLn5gtoFPcRX3n5pEOnKMZ+y+Kg7BUdxbOWcwZDWTgGtd
	 cnNr3R56eLZt1k6xv41deq0/JNAiPq4FHlH7L6Sz+ExrDlVwoNS0D30YYjAwh4i6xRoVd
	 5n3yHry26waW6up426fbHMmA/ptcClNLih5F+qEoLWmFyoZBxx81DDWOniVecY4Sj9hiD
	 dWCzuUT8xzfklkB/FSiDE6yUgLJxaz5hH07MWKdi6CCJbjc5rfP1DLCZwKF3BeiXXMwk5
	 /85s6CTz+haJl3WpnGvIO9ClQ7RQrmn8jt8uEJoMeQHlZvj+Xk6SQV8Nnv0L1V4Mfdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BhmHWW2M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3A4606A330
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BhmHWW2M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5872A1F008BE;
	Tue, 10 Nov 2026 03:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794281080;
	bh=B1b5+J8iQ2XcB3Uaj940MPs/dMrgMvJeCEe52AQjPtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BhmHWW2MvtCgqtuxW3CqBdbsX7DXPWy8uAA6T3X0BbX5yQnHu+7dLZg/gRV1V2s3K
	 HdAN+T/syvsVqV6ZZ5/rl+vb9Nr60UK5H+CPeCIwNhwAwqvWforBejQ0XKCQrjMCgN
	 wZbVv0ARoW6xTQceCl0sq/jje6SzxdfxLuOTu4SbJwp/39X/wldP9m0Q31RK0Uax4w
	 Iv7WzrzKOv3CsfUPyu3AbZz/OLGThvl2VjZterWiKrVHSPcvoi8M8zjCR3rQY1uJpO
	 ZptAQsSsrBL4Pk77tU7pCc3o3wQZZ1hGjt3bje4/gyIyVIIyZ75qBi+lEf0vK/BELQ
	 +MIBNHHAtq32A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] wifi: rtw89: cap firmware section_num before parsing
Date: Mon,  9 Nov 2026 22:24:38 -0500
Message-ID: <20261110032432.186847-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110032432.186847-1-sashal@kernel.org>
References: <20261107052832-failed-6.6-273b0a8be083@kernel.org>
 <20261110032432.186847-1-sashal@kernel.org>
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

From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>

[ Upstream commit 273b0a8be083df6d0319ce62caa870e927f94a31 ]

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
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260825174438.63168-1-acharyalaxman8848@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index fab124dac2408..7a9c367350c9f 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -103,8 +103,24 @@ static int rtw89_fw_hdr_parser_v0(struct rtw89_dev *rtwdev, const u8 *fw, u32 le
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
 
 	if (info->dynamic_hdr_en) {
@@ -168,9 +184,25 @@ static int rtw89_fw_hdr_parser_v1(struct rtw89_dev *rtwdev, const u8 *fw, u32 le
 	u32 mssc_len = 0;
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
 
 	if (info->dynamic_hdr_en) {
-- 
2.53.0

