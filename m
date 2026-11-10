Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281080;
	b=tGyjeIkaawmRgBw1B0mzrubLzyU6XHwGDR3EwhX8bqn+oxv6Z1w49Pk0yPWlFx0lcKoq
	 yOA+UeK2mgbJxkUUdAPpPhEK9Jk6nMqDHlsSWScktAyiSM9useCiak0ipP3Q5h3p4W+jf
	 dxDy+2zQBd032swzuox6f5xemmK4satdubBTZHsaOGUyU+u6uM5dwYxrehe1YNSDhET7V
	 PV26mJmc3TVkWyI0Fra4jtyadAL+IYtt9Cnqv/AxgXCnN/9CFgqEqmvpFIO4DLi6tMHXR
	 GevgVNQsfNEo3gagqo5woTsGV3WGUEUAOSqYdZRUzoCC5I9KowiMJU0m7vkLcmbKmIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281080;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4cvl1mQllyz+dpzguWWULX7xFReHwVtNgL+OXtMcGFQ=;
	b=jax4eLAs23JlVHu48ANx4ua5TQLABqyF5dmg85FYBjG5JZpnNwDNdbchvkg/6c+kCAwL
	 9I+r3zNmeE9vf2fl1kq+reCAn733LzOx6com4CRmuNtT4S6X6vFH9arWHLva7ecKsEf06
	 OoKOWxyYIMv9686rTYdb5tRJFBTHqXSaBR3AJ3KKv6tVFfAjz5X7ZcQGOfG/O1rdM+24A
	 WZEIakfGMjKGz/IxL2aZNk6kv6UaDakyNmGtEhJKxoQU5R6Sk4E+sCenO+trZKHFSWQXA
	 3w2c9sUl5TB3J9b7bCLn7Ddwbhd16708vgL8l64O6JMVt95rmft9+S6aq36vUF0SmQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gFRj2B6F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E24606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gFRj2B6F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF721F0089F;
	Tue, 10 Nov 2026 03:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794281080;
	bh=4cvl1mQllyz+dpzguWWULX7xFReHwVtNgL+OXtMcGFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gFRj2B6Fnjz29kxA9r0y+eJnURIC42FcHS6NLAEih3mXV8OQh5AzRpM93eBWZCah+
	 A4l5UCGuv8gSyy0YwupoyPf3sGcLFCR3KELJsi1McemRRMGDirFgo+nT25ByOb/ism
	 HlDh8KSB3GMfomUs5O8bu7zCdqs0LBfcLiURNjdF+wAHUHIOhbd5hy57GYBZP5kwRK
	 HYT10gS/b0KaiRZtna/3faLk5E5FQfrqmGNeoHpCdHOnpf5P07s6MCrV7ZOx0nO1zi
	 iVra2fwSwhAUwdc/NHx3wxMnrUQS/C+9xgRkrTbysnfgpOyd4yPCRoqt8g8xNSJPHC
	 QVA7tTrkjg4cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] wifi: rtw89: fw: consider checksum length of security data
Date: Mon,  9 Nov 2026 22:24:37 -0500
Message-ID: <20261110032432.186847-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052832-failed-6.6-273b0a8be083@kernel.org>
References: <20261107052832-failed-6.6-273b0a8be083@kernel.org>
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

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit dedf78efd2885048ca36bc17fbd4e1c0af33f2ad ]

The newer firmware file provides security data with checksum, so we need to
consider the length. Otherwise it will fail to validate total firmware
length resulting in failed to probe.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20240204012627.9647-2-pkshih@realtek.com
Stable-dep-of: 273b0a8be083 ("wifi: rtw89: cap firmware section_num before parsing")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 3 +++
 drivers/net/wireless/realtek/rtw89/fw.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 48ed0e5dbed8f..fab124dac2408 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -169,6 +169,7 @@ static int rtw89_fw_hdr_parser_v1(struct rtw89_dev *rtwdev, const u8 *fw, u32 le
 	u32 i;
 
 	info->section_num = le32_get_bits(fw_hdr->w6, FW_HDR_V1_W6_SEC_NUM);
+	info->dsp_checksum = le32_get_bits(fw_hdr->w6, FW_HDR_V1_W6_DSP_CHKSUM);
 	base_hdr_len = struct_size(fw_hdr, sections, info->section_num);
 	info->dynamic_hdr_en = le32_get_bits(fw_hdr->w7, FW_HDR_V1_W7_DYN_HDR);
 
@@ -197,6 +198,8 @@ static int rtw89_fw_hdr_parser_v1(struct rtw89_dev *rtwdev, const u8 *fw, u32 le
 			section_info->mssc =
 				le32_get_bits(section->w2, FWSECTION_HDR_V1_W2_MSSC);
 			mssc_len += section_info->mssc * FWDL_SECURITY_SIGLEN;
+			if (info->dsp_checksum)
+				mssc_len += section_info->mssc * FWDL_SECURITY_CHKSUM_LEN;
 		} else {
 			section_info->mssc = 0;
 		}
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index bc6a9ea9352e0..1264330b26279 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -225,6 +225,7 @@ struct rtw89_fw_bin_info {
 	u32 hdr_len;
 	bool dynamic_hdr_en;
 	u32 dynamic_hdr_len;
+	bool dsp_checksum;
 	struct rtw89_fw_hdr_section_info section_info[FWDL_SECTION_MAX_NUM];
 };
 
@@ -421,6 +422,7 @@ static inline void RTW89_SET_EDCA_PARAM(void *cmd, u32 val)
 
 #define FWDL_SECURITY_SECTION_TYPE 9
 #define FWDL_SECURITY_SIGLEN 512
+#define FWDL_SECURITY_CHKSUM_LEN 8
 
 struct rtw89_fw_dynhdr_sec {
 	__le32 w0;
@@ -523,6 +525,7 @@ struct rtw89_fw_hdr_v1 {
 #define FW_HDR_V1_W5_YEAR GENMASK(15, 0)
 #define FW_HDR_V1_W5_HDR_SIZE GENMASK(31, 16)
 #define FW_HDR_V1_W6_SEC_NUM GENMASK(15, 8)
+#define FW_HDR_V1_W6_DSP_CHKSUM BIT(24)
 #define FW_HDR_V1_W7_DYN_HDR BIT(16)
 
 static inline void SET_FW_HDR_PART_SIZE(void *fwhdr, u32 val)
-- 
2.53.0

