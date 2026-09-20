Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F7E2931C1;
	Sun, 20 Sep 2026 03:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789875899; cv=none; b=jymOTIiT1CDuValGdnPlxp7Gn0t8L41ibzLngMLGky4iihSwCDB/S6khb1S05lOj9+i5d8pkJEZGM/jlBTNWCpb+voDkVULs+mXfapeWRADfpQj339J43qvpFlptpATFjnwyT7VozK0UUPLESMVKrHLnXRX/7rucVTDrchepR0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789875899; c=relaxed/simple;
	bh=v/ryXX14uxu441FylU9bkqvTa+aB551HhVV58EKBz/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W/MaJ6sHLTTa0llV+22gflGZDCtSutFW2amROP2h9H5EiU5q6DfhPM7xypQjC8K3KAVED2iyW6xodOfaFQm9PRLKwmQFj7mcQrDpP3n0KFUiZfD8YnsYWZM1FVpXuFLKiJlBwLuq3CDJGRl/wgUau9xi0ENvMNr1UKJAF8G27NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YKJ01d0L; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YKJ01d0L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=iw
	W17lpQbLLbRPGN1g79TKomNjjKcvqflnJ75C8Wfic=; b=YKJ01d0Liuhbgtb+uX
	M+4Q05TLxS/DsBbTBczeAQVwSctfQstBIx3iUOrtJleo6Hu6yllaFdWVI7PbXqlI
	NAgfNqq7C4HT+uT6uajta6hhAbzPkYwl/Hk1baahZn1oQPNbiy0TLubXYIvhXfRU
	z9+qjtvkVDzY623yhJ44fmnFE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3F7aQVq9q_LsDBw--.15248S2;
	Sun, 20 Sep 2026 11:44:16 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: arend.vanspriel@broadcom.com
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	hppiscas@163.com
Subject: [PATCH v2] wifi: brcmfmac: bound NVRAM comment parsing
Date: Sun, 20 Sep 2026 11:44:14 +0800
Message-ID: <20260920034414.16948-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3F7aQVq9q_LsDBw--.15248S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFy3XrWrAr4DCw13tryrZwb_yoW5WrWxpr
	Z3GFyj9r4DJan7CrWUKr43ZFyFg3Z3G3yUKa98A3WSvF4Dur18uw18KFya9r4YyFy8Ja12
	yrWDtr90vF4DJ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRJkuxUUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7RJACWqvVpKrgAAA3c

The NVRAM comment handler searches for a newline with strchr() even
though its input is a firmware buffer with an explicit length. A comment
at the end of an unterminated buffer can make the search read past that
input.

Keep the input extent in the parser and use bounded searches for newline
and NUL. Preserve the full input length: the capped size used to
allocate the output is not a bound on the input, which may contain more
than 64KiB of comments. Leave the outer parsing limit unchanged.

The issue was found by our static-analysis tool.

Fixes: 3e99b08ab53c ("brcmfmac: enhance nvram processing")
Cc: stable@vger.kernel.org
Assisted-by: gpt 5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
Changes since v1:
https://lore.kernel.org/all/20260830135328.12321-1-pengpeng@iscas.ac.cn/
Store data_len, not the capped output allocation size, as Arend
requested. Use size_t for the input extent and add the stable Cc
trailer.

 .../broadcom/brcm80211/brcmfmac/firmware.c         |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
index 22ff326f1924..a2ee7b43aa21 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
@@ -37,6 +37,7 @@ enum nvram_parser_state {
  *
  * @state: current parser state.
  * @data: input buffer being parsed.
+ * @data_len: size of the input buffer, including comments.
  * @nvram: output buffer with parse result.
  * @nvram_len: length of parse result.
  * @line: current line.
@@ -51,6 +52,7 @@ enum nvram_parser_state {
 struct nvram_parser {
 	enum nvram_parser_state state;
 	const u8 *data;
+	size_t data_len;
 	u8 *nvram;
 	u32 nvram_len;
 	u32 line;
@@ -171,12 +173,14 @@ brcmf_nvram_handle_value(struct nvram_parser *nvp)
 static enum nvram_parser_state
 brcmf_nvram_handle_comment(struct nvram_parser *nvp)
 {
-	char *eoc, *sol;
+	const char *eoc, *sol;
+	size_t remaining;
 
-	sol = (char *)&nvp->data[nvp->pos];
-	eoc = strchr(sol, '\n');
+	sol = (const char *)&nvp->data[nvp->pos];
+	remaining = nvp->data_len - nvp->pos;
+	eoc = strnchr(sol, remaining, '\n');
 	if (!eoc) {
-		eoc = strchr(sol, '\0');
+		eoc = memchr(sol, '\0', remaining);
 		if (!eoc)
 			return END;
 	}
@@ -210,6 +214,7 @@ static int brcmf_init_nvram_parser(struct nvram_parser *nvp,
 
 	memset(nvp, 0, sizeof(*nvp));
 	nvp->data = data;
+	nvp->data_len = data_len;
 	/* Limit size to MAX_NVRAM_SIZE, some files contain lot of comment */
 	if (data_len > BRCMF_FW_MAX_NVRAM_SIZE)
 		size = BRCMF_FW_MAX_NVRAM_SIZE;

base-commit: 518e5b794c06c0f0eb40df3e202274a66202c137
-- 
2.50.1 (Apple Git-155)

