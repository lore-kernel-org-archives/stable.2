Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF1C3905EC;
	Sat,  3 Oct 2026 10:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791022819; cv=none; b=VKOu++Wt9mVZ4656E6YMfQdkgZK3ll6mQdOZPi/DbXmnlja6wcEQ8xXfH6/0/jb4nJ3bPJolz8gh7D7KdyQEAJ9iWOt9NfwgZ9Rt8ps3MRv8Zxh58dhFO2r7qj76DZi5ngmmmf6C9XJ2jF4ibasUPWF5X6w91uwwm6RuSHAZLec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791022819; c=relaxed/simple;
	bh=V48hnmGwm5Zxzh//0DXpviOCCNy2P9IUTo2RKpAvg8s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aCn7OvQ767KQ+qCx3XVJ2ism2NXExnd5KC0iLF0VJTYdOCaFOSqThdu7J9+PSG4XIhiLtqw8cfewTKy2QO0u1zXSjXXwIEidrlc+b8ZVlFHz3e4Qii8g0Gy32OeI/Zm34uNSBYYjTjx9rGHkx9bsfUKcU2ieeVuwNPFEbzjodMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pWfHVPKV; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pWfHVPKV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=HX
	ZZg6hcOZR13yuP5Pno2uBQWWVd5X5M6BD9+YK7sug=; b=pWfHVPKVqagQoYVFFt
	3gsspefLzKQAfAughoECQZiPujV91ViV+LRHEZMLT+hvq80PRGl1Q8T370wsED1n
	Z/hWADTi7VVfN/1JsRMXyOpY55hsBCMXCUIpM0j8gEykpQ/3hvl9O23lYmnq3vhT
	OsocvjP5HZiJ1xwRxc2hyftdc=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3f8bC1sBqnrifCA--.20254S2;
	Sat, 03 Oct 2026 18:19:47 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] wifi: ath12k: validate MAC/PHY capability count before saving
Date: Sat,  3 Oct 2026 18:19:43 +0800
Message-Id: <20261003101944.596546-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f8bC1sBqnrifCA--.20254S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAry7WF47Gr18uF1xJw1DJrb_yoW5GFyxpF
	43ZrnrtFWrJF47Ww4DJw4UJa4Fvws5Kw4fKFy7Ka4rW3Z5ArnrX3WFvFWjyFyrKws5WF1U
	Kr4Iv3y0kFW5tFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEubyLUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wOw6mrA1sPNzQAA3J

Firmware supplies the hardware mode count and the PHY bitmap for each
mode in the service-ready-ext event. ath12k_wmi_save_all_mac_phy_info()
uses those bitmaps to populate svc_ext_info->mac_phy_info, but the
destination is a fixed array of ATH12K_MAX_MAC_PHY_CAP elements.

If the total number of advertised PHY entries exceeds that limit, the
loop writes beyond mac_phy_info and corrupts adjacent memory.

ath12k_wmi_mac_phy_caps_parse() allocates the source array for
tot_phy_id entries and rejects excess capability TLVs. However, if the
event contains fewer capability TLVs than advertised, the remaining
allocated entries stay zeroed and are saved as invalid PHY information.

After parsing the MAC/PHY capability TLVs, validate the destination
capacity and reject an incomplete capability list before saving any
entries.

Fixes: 062ade23991e ("wifi: ath12k: parse and save hardware mode info from WMI_SERVICE_READY_EXT_EVENTID event for later use")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>

---

Changes in v2:
- Refer to the service-ready-ext event.
- Describe a short capability list as a correctness issue instead of a
  source-buffer overrun.
- Move the checks after MAC/PHY capability parsing and use '<' for the
  reachable count mismatch.

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index d5160af60e00..3e812c79a649 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -5050,6 +5050,7 @@ static int ath12k_wmi_svc_rdy_ext_parse(struct ath12k_base *ab,
 					u16 tag, u16 len,
 					const void *ptr, void *data)
 {
+	struct ath12k_svc_ext_info *svc_ext_info = &ab->wmi_ab.svc_ext_info;
 	struct ath12k_wmi_pdev *wmi_handle = &ab->wmi_ab.wmi[0];
 	struct ath12k_wmi_svc_rdy_ext_parse *svc_rdy_ext = data;
 	int ret;
@@ -5094,6 +5095,22 @@ static int ath12k_wmi_svc_rdy_ext_parse(struct ath12k_base *ab,
 				return ret;
 			}
 
+			if (svc_rdy_ext->tot_phy_id >
+			    ARRAY_SIZE(svc_ext_info->mac_phy_info)) {
+				ath12k_warn(ab, "too many PHY entries %u (max %zu)\n",
+					    svc_rdy_ext->tot_phy_id,
+					    ARRAY_SIZE(svc_ext_info->mac_phy_info));
+				return -EINVAL;
+			}
+
+			if (svc_rdy_ext->n_mac_phy_caps < svc_rdy_ext->tot_phy_id) {
+				ath12k_warn(ab,
+					    "not enough MAC/PHY caps %u, expected %u\n",
+					    svc_rdy_ext->n_mac_phy_caps,
+					    svc_rdy_ext->tot_phy_id);
+				return -EINVAL;
+			}
+
 			ath12k_wmi_save_all_mac_phy_info(ab, svc_rdy_ext);
 
 			svc_rdy_ext->mac_phy_done = true;
-- 
2.34.1

