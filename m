Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35CF4D7D35
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580090; cv=none; b=gImLf5Oqly3HvcA0hmqq+PJPoXJvq2idOUSFqAC/cWwb3CjKLA86/khPYxNFXu51y+2DmA6xfveyWf+cNYN62zK8QXAapUY+sI3UL3shPzjrGpcrVH7Q8G4T9aVbri74v28LYGvNrqS00gb25Mq/gVZ6uPbOR4P47jZ6kjaII+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580090; c=relaxed/simple;
	bh=O4fQFptbwIWGrP3i51so22Moy8UsJAxa2WB25LmlnH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZB1x1Z9OV81kloU02+FpkpMallLj4t6CCeCnsVKvNqa61Uf37cmN9PXnMtAw9LKzgBrNCUl9WQCLFbTUZm38HMNMCBN6ZNlpfWESqhUGqRAW183zPihmsNvdkxMSZn9AN1BVhU8F5mfgvQHBHUKW8AXlwyBhMC7TLCcbeFKFwsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjakcTaJ; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjakcTaJ"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d097b4939so36595e9.0
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 10:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789580076; x=1790184876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b//GgrHPthUrwrYixVrlFYT/x+uXt+xKgBiSW3+vKf4=;
        b=WjakcTaJvDEo/tboaKFdS/cl9UWHlASfpBtfKZ2v/EmgDeCmOpisQSX48nh5ssgl/3
         Sboh6dMEBy3CHONGqvXLqL3PW14/XuWDlc2KAXStseUXqrGTH69hESqvLU/fmJpZgQcl
         0fH6GCGFr5pm/BNqEIuSykBmX/e7eQIwLXwpa5w2Wxp6tBRFOjKUBiSPggl3GNvLHfTm
         77MiTYzQcJktCzMEL7dEDm21FrRIFTAbUmuo5r6xQ9h8OeBHhBtHFFVhnQZb5Sckkm4Q
         5TIxsHur4ORMPxrzbfD8qHwkRYmuU4sqVsDE3eoRaDumeaArLtSCTub1d520DV+Z3WJb
         1eVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789580076; x=1790184876;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b//GgrHPthUrwrYixVrlFYT/x+uXt+xKgBiSW3+vKf4=;
        b=KCifhOWxnx2/JAwA2FFjAoB7xraxomQZofU2qoYZ6At3vOHFz4co8R4iygvdLCPscW
         sWQwwbH5sb2TAX/vi3L91AJT0oq/ZwG3488cUO0ptBAjSVc4IvnsJhynoRrQsQha0XxO
         nVYDvozwNt17mkSPAKWEtOySeaLQO2EulRTpILxrjomQjc1eB5gJ9qhZ5PeFWfRRdpsQ
         lRS2nerlSf9vBt63EI+0rMdEJshNu0eYzZvMsO3Vz1uq/TTCRzKEF2xrd1SMrj8ONa3G
         vvlj19Yb4o4ZkoiL6HJOuDZ9LKx1qiEnNARG5HmJwniFZ2AMftieHIdn7Jsw3QBBAcPP
         6U5w==
X-Forwarded-Encrypted: i=1; AKwUvBwx96uXG9VynGs6Id/vQ/mRM8VGLawH5eJ3Veg8Pn6J9fgUt8BWUI4tziZTjGkJ9rzEkoGhViw=@vger.kernel.org
X-Gm-Message-State: AFuF++moyBkrlhGDNYmWfRrG9U542Hnz6TgkV5NJUeLCPLIeUBG0Zhpv
	MWR+0AGNtpI2I+0JFuEN4c/NU3/hytMRKBuCWKqYDzcKIXYESDpjpjY=
X-Gm-Gg: AYBFou00gLn5HgJFmI4PU22GI4C4RVg1Ww2STQ601ipp/aLubb2Ri3Lysq2zsBj0fle
	TZg/CUH4hYNBT/S4eJ+giKG6gAGnnUCB0vgwUGwlzRYkZv4txIhVyOsrFBQSSQtmVuJbjU4qgBX
	4J+ZRbvck54hx5wgyKs7w4kQ4rX7oo+nusfoQShMezfhQXcwfQ+/boQSZz2oEcEkVle2FDYccrh
	9QhylJ3SaRORmnYihSkP+OeVf+NtE6LaLjisavwxWMfm13zkilD7h3kwlc2dvpISNhx4wDI7otG
	+XIT5DlrUs12cLsnP7Y/yK4h61JNWJbPF7U0QkOzDeRRxfVDeDlCbJ14A5RJ0xQYhC3DdC6ROvD
	QOJ8b5DStMXWJeSF1rTQwSHfBWhtcb8C2aTly5TpXVRtRoPL93vdIoATIrZSqIkOR0QtO1ZDzQO
	VCtCdQSpoYrf2PXPmPK732dsrKNz7GarbP1GdxppOssvazMfvVDj2gudIpVFFwHOjvtgLZdQZYB
	BYJbKiEpjGsxou8QSwxv00aG2SAztBu0vbcyqniUupBEoy2BF0QLm5AOWpexHxi/BHVV5UPRFfd
	v5Y03gIeXQh/4Y0=
X-Received: by 2002:a05:600c:1909:b0:49e:715e:ec1f with SMTP id 5b1f17b1804b1-49eb7339c99mr38436865e9.30.1789580076159;
        Wed, 16 Sep 2026 10:34:36 -0700 (PDT)
Received: from nn ([2001:1ab8:1003:0:f23c:f0c3:c09d:d6d6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf27ce2sm8987544f8f.20.2026.09.16.10.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 10:34:35 -0700 (PDT)
Sender: N B <gen.benner@gmail.com>
From: =?UTF-8?q?Nerijus=20Bend=C5=BEi=C5=ABnas?= <nerijus.bendziunas@gmail.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"John W . Linville" <linville@tuxdriver.com>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Oleksij Rempel <linux@rempel-privat.de>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	stable@vger.kernel.org
Subject: [PATCH ath-next v4 2/8] wifi: ath9k_htc: fix the byte count of a full RMW buffer flush
Date: Wed, 16 Sep 2026 20:34:23 +0300
Message-ID: <20260916173429.403889-3-nerijus.bendziunas@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916173429.403889-1-nerijus.bendziunas@gmail.com>
References: <20260916173429.403889-1-nerijus.bendziunas@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ath9k_reg_rmw_buffer() sizes a full-buffer flush with
sizeof(struct register_write), 8 bytes, instead of
sizeof(struct register_rmw), 12 bytes. ar9271_hw_pa_cal() queues
exactly 15 read-modify-writes, so the AR9271 PA calibration has been
losing its last five writes since the buffer was added.

The corrected command is 192 bytes, three full 64-byte USB packets,
and the firmware ends a command only on a short packet, so the device
stops answering WMI on the first interface open. Send the whole buffer
on a full flush and cap it at 14 entries; 15 is the only count within
the buffer's reach that fills whole packets.

Fixes: 8badb50cfab6 ("ath9k_htc: add new WMI_REG_RMW_CMDID command")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Nerijus Bendžiūnas <nerijus.bendziunas@gmail.com>
---
 drivers/net/wireless/ath/ath9k/htc_drv_init.c | 2 +-
 drivers/net/wireless/ath/ath9k/wmi.h          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_init.c b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
index 3798d3375158..2d9c14006972 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_init.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
@@ -408,7 +408,7 @@ static void ath9k_reg_rmw_buffer(void *hw_priv,
 	if (priv->wmi->multi_rmw_idx == MAX_RMW_CMD_NUMBER) {
 		r = ath9k_wmi_cmd(priv->wmi, WMI_REG_RMW_CMDID,
 			  (u8 *) &priv->wmi->multi_rmw,
-			  sizeof(struct register_write) * priv->wmi->multi_rmw_idx,
+			  sizeof(priv->wmi->multi_rmw),
 			  (u8 *) &rsp_status, sizeof(rsp_status),
 			  100);
 		if (unlikely(r)) {
diff --git a/drivers/net/wireless/ath/ath9k/wmi.h b/drivers/net/wireless/ath/ath9k/wmi.h
index 5c3b710b8f31..f9c0fe54a884 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.h
+++ b/drivers/net/wireless/ath/ath9k/wmi.h
@@ -126,7 +126,7 @@ enum wmi_event_id {
 };
 
 #define MAX_CMD_NUMBER 62
-#define MAX_RMW_CMD_NUMBER 15
+#define MAX_RMW_CMD_NUMBER 14
 
 struct register_write {
 	__be32 reg;
-- 
2.55.0

