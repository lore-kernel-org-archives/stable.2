Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E444499B4;
	Fri, 25 Sep 2026 12:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790338704; cv=none; b=NsbR5/suhREbKrAvw+s1SUXYQFerKUkvjzyAXe/zbuLlDULkaXQmRJW1YPuqQbJazScmiqSwMNTBROHqtKQJ5kOlJP/4vfyVvG+YQF5LuqizrzXDV+3D5R9F+S68/wiM7Vop2kYqnDkd7BzQAlKXai3W5M2nuRHs+YKWg8Gh1Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790338704; c=relaxed/simple;
	bh=umhjgHljR4CuXgvtZfe0tMf7itPF1Z2nsE7E06GiW4U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sDSvPLQ9zUcGg0ztCZT2eQUp1elkjzvxQWKOuQ43mKG5dcLevHMvyjAmw/5/hyqWh1hgPl0xRx+SyIGGdFsUnyUzxY+S4RUSn+KUYorEWT7piDhCVPmQ119EVj5sX06VYMKaUWFcgKOMPg+VhCJW5hUFEr8th1jFA3hZgJDM5hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dbtjwEhl; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dbtjwEhl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=7p
	sNfPfob9qJuUpihyZUAkUqDU0vENMc3d9Em+1xjFc=; b=dbtjwEhls+ve5axcIp
	FuoVyyBc+lrsLNGhQC3+jDHxe6vCCf0RWvrS5xh9EOSjSWfJjQ+oiQIr5WC1CGrf
	b4QtFYtCerz2DkXGHMOLcKaH56hghGvMOvfolBy2oaan/7I7Tp7hzPocILT1muvv
	N4m/WDm/Ga1GVHc99JW0FSo9k=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3t0hkZrZqGDz4Ag--.50028S2;
	Fri, 25 Sep 2026 20:17:41 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: ath12k: validate MAC/PHY capability count before saving
Date: Fri, 25 Sep 2026 20:17:39 +0800
Message-Id: <20260925121739.2061979-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3t0hkZrZqGDz4Ag--.50028S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxur1DZF1rtryDXrWrJr4Dtwb_yoW5Wry3pr
	43ur9IvFWrJF43Grs8Jw4UJ3sYvws5Kr4fKr17Ka4SgF15ArsFq3WFqFW7Aryrtwn5Gr17
	Kr4Iya48CFWYkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEqjgnUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzgX6NWq2ZmX-uQAA3d

Firmware supplies the hardware mode count and the PHY bitmap for each
mode in the service-ready event.  ath12k_wmi_save_all_mac_phy_info()
uses those bitmaps to advance through svc_ext_info->mac_phy_info, but the
destination is a fixed array of ATH12K_MAX_MAC_PHY_CAP elements.

If the total number of advertised PHY entries exceeds that limit, the
loop writes beyond mac_phy_info and corrupts adjacent memory.  A mismatch
between the advertised total and the number of parsed capability TLVs can
also make the source pointer advance beyond its allocation.

Validate both counts before writing any entries and propagate the error to
the service-ready parser.

Fixes: 062ade23991e ("wifi: ath12k: parse and save hardware mode info from WMI_SERVICE_READY_EXT_EVENTID event for later use")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index d5160af60e00..59ac17f0d48d 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -5004,7 +5004,7 @@ ath12k_wmi_save_mac_phy_info(struct ath12k_base *ab,
 					__le32_to_cpu(mac_phy_cap->high_5ghz_chan_freq);
 }
 
-static void
+static int
 ath12k_wmi_save_all_mac_phy_info(struct ath12k_base *ab,
 				 struct ath12k_wmi_svc_rdy_ext_parse *svc_rdy_ext)
 {
@@ -5015,6 +5015,20 @@ ath12k_wmi_save_all_mac_phy_info(struct ath12k_base *ab,
 	u32 hw_mode_id, phy_bit_map;
 	u8 hw_idx;
 
+	if (svc_rdy_ext->tot_phy_id > ARRAY_SIZE(svc_ext_info->mac_phy_info)) {
+		ath12k_warn(ab, "too many PHY entries %u (max %zu)\n",
+			    svc_rdy_ext->tot_phy_id,
+			    ARRAY_SIZE(svc_ext_info->mac_phy_info));
+		return -EINVAL;
+	}
+
+	if (svc_rdy_ext->n_mac_phy_caps != svc_rdy_ext->tot_phy_id) {
+		ath12k_warn(ab, "invalid number of MAC/PHY caps %u, expected %u\n",
+			    svc_rdy_ext->n_mac_phy_caps,
+			    svc_rdy_ext->tot_phy_id);
+		return -EINVAL;
+	}
+
 	mac_phy_info = &svc_ext_info->mac_phy_info[0];
 	mac_phy_cap = svc_rdy_ext->mac_phy_caps;
 
@@ -5044,6 +5058,8 @@ ath12k_wmi_save_all_mac_phy_info(struct ath12k_base *ab,
 			phy_bit_map >>= 1;
 		}
 	}
+
+	return 0;
 }
 
 static int ath12k_wmi_svc_rdy_ext_parse(struct ath12k_base *ab,
@@ -5094,7 +5110,9 @@ static int ath12k_wmi_svc_rdy_ext_parse(struct ath12k_base *ab,
 				return ret;
 			}
 
-			ath12k_wmi_save_all_mac_phy_info(ab, svc_rdy_ext);
+			ret = ath12k_wmi_save_all_mac_phy_info(ab, svc_rdy_ext);
+			if (ret)
+				return ret;
 
 			svc_rdy_ext->mac_phy_done = true;
 		} else if (!svc_rdy_ext->ext_hal_reg_done) {
-- 
2.34.1

