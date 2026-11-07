Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047314;
	b=Q3tP97GysVhCn97l9boDuKybT6PYLw5IeLrdf9OJk+AKcVz8pWvAfjVRcJP+lUBi9uAK
	 2Qlb9RIwa1o7OGTAZsgSymkvEu3STTffi2rAC+JzfbR7Sb6VgPKNzYOb3+krNshDxenj2
	 4v+RgW9Dm5UjiZ7egSwIKD+A5gfKq+YYMJCgF+k1krFtjtBc7jNoH+R6ug3EJK2ZxOKL7
	 CIHJ5eIMh/rXpllrgAlWd+EBOfBE4xMsuUxuuBKEXm28PqlCNleZxRsQxZoB1Nk0ZxCMj
	 CUvqU2Q91aA4UNCR+rxkS7J1qD0d5xO/lFmFBb6srDNetsVJOXNs8/irsi/c5tUXJvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047314;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+o3TlxqUCWEga7rFTqeMzfOD9UkEhcv6JnMzKHeGH3U=;
	b=o61dkco2uNda6wj+XzMPfKH2OgZeAbTmdodDCK99aKqNCm++EyhimZt0omtZ5QaXDeJI
	 MXdJKFS3gtzAM9X74S+jlLVUNR1ZpoLwyIdkpw5GvuF3hYPDs0A7DvXFOcww4Vj9vYcNN
	 hYrwunpj0L21dXwm9dUuyCeo0ePOQmxJbORqIhtPFwPdFQ80ETGBrRNbFGKwYCA3ribnY
	 qO0soltUxr8gaKgleXINz0gSHyggQQ2yf/K3NAJXq44PDCfIf3t6mIsi/wZ9szUytf8ed
	 F8Ms0SWcUInJWsrchzb9GVe4KwycY5KkgOLOe95NVnZSSyZXleJ8qr2bFanuCgFmB9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B1PWACdm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C15606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B1PWACdm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F8F1F0089F;
	Sat,  7 Nov 2026 10:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047313;
	bh=+o3TlxqUCWEga7rFTqeMzfOD9UkEhcv6JnMzKHeGH3U=;
	h=From:To:Cc:Subject:Date;
	b=B1PWACdmmT0OHIIylU0PwO73maGmlV+Lp71voo+4D1SYo7TMdTERBsRAie7cZDrKm
	 Sc9T/QXgOAyy5XtRa4AUDxrIqwMcz+6kHYtMHe+wf5V5+VNJTFBX6OmqhfQXhBhGJ+
	 Cyr8lIacB45w5MlPoVkqkBG5XpjraGKfNVuoPwT+aql5OaHFc1CkPR00B0TGnUX+I9
	 FwJoso8DHXI1FgqP3N1Ma1zYge7Yd9t4wAcfgFva4+9qX7iPYv3YAL1IWvY8jMJx93
	 qs/YER3/u1o/nHKdIKdMVdgaDppRpQBBmnDwCtOYkBl4GS4fNYukXSXjL2SLeg/3o5
	 aFUPHyatwHVZQ==
From: Sasha Levin <sashal@kernel.org>
To: acharyalaxman8848@gmail.com,
	pkshih@realtek.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] wifi: rtw89: cap firmware section_num before parsing" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:28:32 -0500
Message-ID: <20261107052832-failed-6.6-273b0a8be083@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 273b0a8be083df6d0319ce62caa870e927f94a31
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052832-failed-6.6-273b0a8be083@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 273b0a8be083df6d0319ce62caa870e927f94a31 Mon Sep 17 00:00:00 2001
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Date: Tue, 25 Aug 2026 23:29:38 +0545
Subject: [PATCH] wifi: rtw89: cap firmware section_num before parsing

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
---
 drivers/net/wireless/realtek/rtw89/fw.c | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 0099c5c03e7a6..b2991bc93f852 100644
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
2.53.0




