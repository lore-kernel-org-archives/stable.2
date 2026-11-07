Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048067;
	b=lBWM8Dth8r6ew0Yz4OKMrssfmZ5vWc7YxwxCbSG5wU9WnvtJLwa3tr62CF9FLqG4oPUt
	 KOJHazB8V0rJgQ80t0bJJpNpHa2d01bcLO8iXJpRAus5yxRNRhSXU64reXRTux3duV105
	 iVx3tBKDQWFe/zVHBWPSykmJyOeIkh6cqrNDIccNc0JCqknnZKeLKM/Cqea3rX3x7N/sk
	 0+h1SuOdue8cw1vRPpWh5kWy+Hpv7FPXx1VS19tqf1KQABB9Cv8ocCYyoumtT/209DLi4
	 hCGunESFMBDecy4ZqNAs3/by1h/VWe+EROPnheNJihedyTjaQM5S+sMlNn9K4R2QyBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048067;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tPmB7jaikNnv4ObGkHuDlTAKGTiARXfujTSgJF11laU=;
	b=Eo2fRcisUIqSzXbVmZ4cdk0MP66wUwmZ+KhG2E5tfDZD20Z+QJ48VJ1wwzlGGoBERFJE
	 Y6c9L28fbqUKvX0FnJWLuUuevdx6YkIGKfIuT4P1FA4iyyTtA9qLON6u3YGYoj4OPcGUV
	 e0beZTm1WJDjHDBjdOSqWM4SlIgqS95OLtssQWx+kdFi0spYX4vzMbrJB3AhYlHYvk9Nr
	 DOUZXqZvUKDnoHdiRztpS7m2YVL4/YhkQKzHiiqec0uUqbGTVBgs/16HkPTjKnHTW8FXA
	 SO6S9n0SQaeF/lDYtOsF3tFGruq813wHQt9Epo9O9W15TNLr64Hy0dAWN9sNGcOJvHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZThuhNAa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C07606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZThuhNAa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848A41F008A1;
	Sat,  7 Nov 2026 10:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048066;
	bh=tPmB7jaikNnv4ObGkHuDlTAKGTiARXfujTSgJF11laU=;
	h=From:To:Cc:Subject:Date;
	b=ZThuhNAaARWtHZLAJ7fhF7KK4IjDhbUdQjrzdw8wtj/ZASJm7RHgm1TNLuVG8yFPl
	 jvZPoK3SBaUNd8hZCaAk4tb8kw7dD2Chc+9yCtGalXdIgabOBxfMnEmd5Rl1ZRHyFX
	 cS4qgnVV6ooLII89B5UTcij/THUh2AOZAc5q0XFYqPNl68P5a/7D3LK9vGG0K18SYt
	 ALp1c/EFeUWT6JGze6XHAVkG75d5k8b3owEdbLnQgr6az4yWyqj5KoDa6x3j7JT3I7
	 p565aUpMHd8AEAz8JYty/CBo6AoLE1JZWZXK/zR7Kz3oOYezMticKW+Zxp+e7wMOjg
	 CwE6hOcl4BH5w==
From: Sasha Levin <sashal@kernel.org>
To: acharyalaxman8848@gmail.com,
	pkshih@realtek.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] wifi: rtw89: cap firmware section_num before parsing" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:41:05 -0500
Message-ID: <20261107054105-failed-6.1-273b0a8be083@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 273b0a8be083df6d0319ce62caa870e927f94a31
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054105-failed-6.1-273b0a8be083@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




