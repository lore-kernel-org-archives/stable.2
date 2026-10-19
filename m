Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424FF3B840E;
	Mon, 19 Oct 2026 07:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395077; cv=none; b=hSlrtp8e+2xWAcPuoQdAgUUPrWx+uJ8yq6EeM6WlFhiWikaRA9EST+Zo8Mz025KLzLC04BKkRCHWu1lDDF+HTx53UEisgRrYQEvAZzElGXCkysetOSKAI/ipGaoXnkBTWJi4kSBOfHcgUdyPwSE6ligb9GS+a7GsSoXfBCXXiCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395077; c=relaxed/simple;
	bh=EHY8rLc2FwiDGXDYp12bwuY3kPhNQbNyoalFhdVK0bA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oSzEQRZCrZVRY3oVTi3VZp2qaAkv1vlUmjmOLuUr/oP2hdoW4TCiqF/9d9U6Gd9MeAFECn5Q2I6NojFFNZoPSiU++0iVxEWg/zNt7Ks1PaO3WNPf9WcV2uEnb3zoZT5jsg+Kfxvlh7mRCLTsQuKacL9hK8bpzvXHqi8XlG0QzOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=V9ZudTh0; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="V9ZudTh0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=12
	85rFpzC6YZHeY1fzSe60PUfJDV9XOWaOJECVINhlM=; b=V9ZudTh0UimYum8+Ny
	kScKWBtvLO7qj55W5MSX9q40iIY0G0lY37k3uDO0/YV0J1d+Y+wXIwGHAjJ2/WwJ
	YgtC1kvVBPKxaU1fo0Gn25i86PBmNyE2q5laafm3OYFSfuHBQmf2iBhCmKo4jvee
	BwtQbGjTjGUeZBm5kdvx78QeM=
Received: from LAPTOP-BJS5C4G0 (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD331Y8x9VqPYGvBA--.37115S2;
	Mon, 19 Oct 2026 15:31:09 +0800 (CST)
From: Heyang Tan <thy15333007817@163.com>
To: linux-wireless@vger.kernel.org
Cc: chunkeey@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] p54: validate firmware record lengths
Date: Mon, 19 Oct 2026 15:31:04 +0800
Message-ID: <20261019073105.1853-1-thy15333007817@163.com>
X-Mailer: git-send-email 2.51.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD331Y8x9VqPYGvBA--.37115S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr13WFy7tw4DuF17Aw48Crg_yoW5ZrWrpF
	Wjkay3JrWDC3W3X3s5Jrs7AFW5Ja1fJFW3WFyIq3ZxXF13Ar1Fq34YvFWkZrn0krySyrWY
	k3yUta47CF4DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UqYLPUUUUU=
X-CM-SenderInfo: 5wk1ikatttiiixyrlqqrwthudrp/xtbC4R0RumrVxz3eYQAA3t

The p54 firmware parser accesses component ID and component version
records without checking that their lengths cover the fields being read.
A malformed record can therefore make the parser read past the record.

Validate the component ID and component version record lengths before
accessing their data. The descriptor record is also checked against the
shortest descriptor length found in the supported firmware images.

Reject descriptor values that underflow the RX offset or produce an empty
RX range before updating the driver state.

Assisted-by: LLM Codex
Tested-by: Christian Lamparter <chunkeey@gmail.com>
Signed-off-by: Heyang Tan <thy15333007817@163.com>

Acked-by: Christian Lamparter <chunkeey@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/net/wireless/intersil/p54/fwio.c | 45 ++++++++++++++++++++----
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intersil/p54/fwio.c b/drivers/net/wireless/intersil/p54/fwio.c
index a3d9053f043c..b19d054441b8 100644
--- a/drivers/net/wireless/intersil/p54/fwio.c
+++ b/drivers/net/wireless/intersil/p54/fwio.c
@@ -52,6 +52,12 @@ int p54_parse_firmware(struct ieee80211_hw *dev, const struct firmware *fw)
 		u32 code = le32_to_cpu(bootrec->code);
 		switch (code) {
 		case BR_CODE_COMPONENT_ID:
+			if (len != 1) {
+				wiphy_err(priv->hw->wiphy,
+					  "firmware component ID has invalid length\n");
+				return -EINVAL;
+			}
+
 			priv->fw_interface = be32_to_cpup((__be32 *)
 					     bootrec->data);
 			switch (priv->fw_interface) {
@@ -71,17 +77,44 @@ int p54_parse_firmware(struct ieee80211_hw *dev, const struct firmware *fw)
 				return -ENODEV;
 			}
 			break;
-		case BR_CODE_COMPONENT_VERSION:
+		case BR_CODE_COMPONENT_VERSION: {
+			struct bootrec_comp_ver *desc =
+				(struct bootrec_comp_ver *)bootrec->data;
+
+			if (len < 6) {
+				wiphy_err(priv->hw->wiphy,
+					  "firmware component version is too short\n");
+				return -EINVAL;
+			}
+
 			/* 24 bytes should be enough for all firmwares */
-			if (strnlen((unsigned char *) bootrec->data, 24) < 24)
-				fw_version = (unsigned char *) bootrec->data;
+			if (strnlen(desc->fw_version, sizeof(desc->fw_version)) <
+			    sizeof(desc->fw_version))
+				fw_version = (unsigned char *)desc->fw_version;
 			break;
+		}
 		case BR_CODE_DESCR: {
 			struct bootrec_desc *desc =
 				(struct bootrec_desc *)bootrec->data;
-			priv->rx_start = le32_to_cpu(desc->rx_start);
-			/* FIXME add sanity checking */
-			priv->rx_end = le32_to_cpu(desc->rx_end) - 0x3500;
+			u32 rx_start, rx_end;
+
+			/* 0xa is the shortest descriptor in supported firmware. */
+			if (len < 0xa) {
+				wiphy_err(priv->hw->wiphy,
+					  "firmware descriptor is too short\n");
+				return -EINVAL;
+			}
+
+			rx_start = le32_to_cpu(desc->rx_start);
+			rx_end = le32_to_cpu(desc->rx_end);
+			if (rx_end < 0x3500 || rx_end - 0x3500 <= rx_start) {
+				wiphy_err(priv->hw->wiphy,
+					  "firmware descriptor has invalid RX range\n");
+				return -EINVAL;
+			}
+
+			priv->rx_start = rx_start;
+			priv->rx_end = rx_end - 0x3500;
 			priv->headroom = desc->headroom;
 			priv->tailroom = desc->tailroom;
 			priv->privacy_caps = desc->privacy_caps;
-- 
2.34.1

