Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281938;
	b=IUbMsWqKiIKHCzfjIvhLjg1fraPum1bSaGSwOjUmd9kGukO0eMEXavY1DS6snQpNdGDk
	 uOAAMGlnHDm/VB/xjOpssF8CV032MdIxAUBVOIK9nwu0eE+eh2mQO+brKc/Qy1gPsdSBG
	 avVv06m4bYcohrwb5yYVmcw/1bNKzXPFUDuiodDooxj1Tt4dQ7L6rcFfeDWznf16rNSs9
	 G8x9jj7HbDq+tKnpZbXKLmqofRUa1MMiWc1eIXs48Nsfie84106VoxGHm5r7a19ROA1b6
	 BnScsTxGu8oohtk0fLgpZGYvNwR9t5AO/Y6S3KBA76t7pR3i7XI1mQfbDszxg2oANUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281938;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=j6ka7w4bW9kHXjCHcWGE1Ik3ovo23Sf/2SQyX70KGaY=;
	b=BCYW09gbLYlcs76hqjBm5LZSvQwSUzXaAzChPB6/tmt++JWb6xV6I9fUIVUFsx2HLWLg
	 AMZpQtG8mPd8fdLNhg70dGuNM46gsB9oPTBbg5skSNWMhWBQrldlcRjsGiI38e1xfc13z
	 +hppXaJ7vW2bPw9gP0eKZHb6bWGB5LTUYYfLsEJIpBEo1TR5UHPw5kgbnMX3AOM6YEOBx
	 AhV5g4wbTSbucMONuA2H4rAlY56uZu/DTepcEsCXCAhxlrp0Ci8QqDHFVP3d8OVAXTjCt
	 8aL1trBIZsO3TRiiwij/fnUj35rlLVAtw2+dLm3vNl2l5Mrby3i9kC9r/JYZrFgtXpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H89yoMbB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D72606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H89yoMbB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF861F0089F;
	Tue, 10 Nov 2026 03:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794281938;
	bh=j6ka7w4bW9kHXjCHcWGE1Ik3ovo23Sf/2SQyX70KGaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H89yoMbBSxPfoxPcjEeKu9aPyK1xjncsbNI7KgfJfBS2IDQtORZ+fprkxRPgeMUGi
	 rjX2d4oXZvdFb+Ncvnx4hYrPu3kYgcwN2J/sXhKX0cOStUEglP+lmYSaqsxealOaLj
	 C6SwL99w3puQyZ3W1okbTs3YzNYrV39zHFaZZn8xGyrlJNTxLWh2gz7/U52FKRHla6
	 5OV4FSXPU+VoJMKoyVIY8skPLoY23+CFqvOkEIW8N+RmEbjiAKplXdvOGb6kCWJOa2
	 mN1NxHa1jxcDSPwjjVR/uh3S3+WjHLlgUBG6RRAaYFzBs2G4mW4uiH1WuXooKkgtRK
	 l4/TWgSxmmTgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] wifi: rtw89: cap firmware section_num before parsing
Date: Mon,  9 Nov 2026 22:38:56 -0500
Message-ID: <20261110033839.240767-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054105-failed-6.1-273b0a8be083@kernel.org>
References: <20261107054105-failed-6.1-273b0a8be083@kernel.org>
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
[ sashal: Adapted checks from separate v0/v1 parsers to the single parser using byte offsets and size constants. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 977aadfdf997f..0963b6785329c 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -91,9 +91,24 @@ static int rtw89_fw_hdr_parser(struct rtw89_dev *rtwdev, const u8 *fw, u32 len,
 	if (!info)
 		return -EINVAL;
 
+	if (len < RTW89_FW_HDR_SIZE) {
+		rtw89_err(rtwdev, "[ERR]fw header truncated\n");
+		return -EINVAL;
+	}
+
 	info->section_num = GET_FW_HDR_SEC_NUM(fw);
+	if (!info->section_num || info->section_num > FWDL_SECTION_MAX_NUM) {
+		rtw89_err(rtwdev, "[ERR]invalid fw section num %u\n",
+			  info->section_num);
+		return -EINVAL;
+	}
+
 	info->hdr_len = RTW89_FW_HDR_SIZE +
 			info->section_num * RTW89_FW_SECTION_HDR_SIZE;
+	if (info->hdr_len > len) {
+		rtw89_err(rtwdev, "[ERR]fw header truncated\n");
+		return -EINVAL;
+	}
 
 	bin = fw + info->hdr_len;
 
-- 
2.53.0

