Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845770;
	b=ZB1AF1Vx2JaWUSGW5SfakTjdlgkqgagVy8WySHVbCWLOEt3aAR9/+Ddoebd/LxMGgcCg
	 0hg0ZckpGAUwzfyGKcczm7v6VTTCdOxgS+K9a9LtcSFVXAeQnvUbRIeCAz8onCcbNVHwl
	 PrUMksmVvEa/Qt5jBjI+R6pHCN/3i82L7KYKgNClR5XrjuhakU5llJXvAa6Qo7eVd0Cxe
	 6wciBZpvH6YRMciIuTR0qo4Ve1mIOb5B0K6Ee7mNhKBwphnbtGiQnQ+YZH4k6D7souiep
	 tSRGWbtVUx0EVUB0JyxDhTqU1cYculuyPPi4MhXMcjwFLKccsNENtQpMV78HCxZ53XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845770;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=u8OM82i/n/vgWyId+NC+VEpMoNyAg9PAz01gC1ijy4U=;
	b=daNjmXbFEUPsMwuQODUhwLedP8cNjhqhuz+0NjW47N2rOq5vDNFsL7+RaKIiyZEjnpQ4
	 9B73oCOKtSwvaqPpGurpwA2Ik0eNxv40A2dtgcT6ZK2i+5Dnbra95TJY8O9xZKlFIlsMM
	 8kYYu9csQmIuJDWDfsd85E4OiOQUsFtn/bu+or9nDF+Ui4KwhS3nHTC8DRCK8JmFN3R6y
	 WNiXYgZm73q4Rfv+jMIoy6/KmXUYo28KoxZBtIhQUlV133nhbLt4FOpDESacwbL1Si7OT
	 8/2MUWTfBTLz6DyqYvI4LpWc9vYAhQP7XO5be1EsquXuZLWhuJPVyGMJztW5+HxwE2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=NO123rfb;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F857606A31C;
	Mon, 16 Nov 2026 16:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F857606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=NO123rfb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=u8OM82i/n/vgWyId+NC+VEpMoNyAg9PAz01gC1ijy4U=; t=1794845769; x=2110205769; 
	b=NO123rfbGaJEYu5jaoZPTyN3G0Iw3n4vqK0WA+KKZX0SundHEvFWCfkLVXUCD4hfV61R/JrBaLS
	NH7NnPlcYRXGTNgGrodX+M3ugV6qcFcnqGy/KPwozMLyR7Hdxag2qWs0zRIMcuB3LxSHdF0OR8y90
	fYjJKNTdq1//HMKJ6ryQ4KA6wmfVl4/8rQcGYowIBApfY/ZOOr8zO9l5RrqoZacnXx67tJ8XNO8qD
	Qxzzkbtnos6RLtOmRgJiGLVaTlGxMtWkSqLreJpxBWC8+gQw7+jZ4N8koH28XF6SrkEc+HpfQtG53
	o4zydwRlV1SOaP+9PuIn6Lkpu+50bJrb68AQ==;
Received: from 186-249-149-121.shared.desktop.com.br ([186.249.149.121] helo=[127.0.1.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xSzNH-00000000GXQ-2Oa6;
	Mon, 16 Nov 2026 17:16:07 +0100
From: Mauricio Faria de Oliveira <mfo@igalia.com>
Date: Mon, 16 Nov 2026 13:17:28 -0300
Subject: [PATCH v2] wifi: rtw88: fix skb leak in hw_scan probe request
 length check
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-rtw88-hw-scan-skb-leak-v2-1-cc9644774fff@igalia.com>
X-B4-Tracking: v=1; b=H4sIAJcs+2oC/3WNyw6CMBBFf4XM2jFOecrK/zAsCh1gAlLTEtAQ/
 t1K4tLlOck9dwPPTthDGW3geBEvdgqgThE0vZ46RjGBQV1URkQK3bwWBfYr+kZP6IcaR9YDXjm
 nNDHcxiaFMH46buV1hO9V4F78bN37+Fnoa3/J+F9yISSMa5PkaaZ03WY36fQo+tzYB1T7vn8Am
 QXmgL0AAAA=
X-Change-ID: 20261112-rtw88-hw-scan-skb-leak-9e7154def3d5
To: linux-wireless@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>, Po-Hao Huang <phhuang@realtek.com>, 
 Kalle Valo <kvalo@kernel.org>, kernel-dev@igalia.com, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mauricio Faria de Oliveira <mfo@igalia.com>, 
 Luka Gejak <luka.gejak@linux.dev>
X-Mailer: b4 0.14.2

In _rtw_hw_scan_update_probe_req(), if the first loop fails (goto out;) the
skb is leaked. It does not reach kfree_skb() at the end of the loop body or
in the second loop (out:) since it is unlinked from probe_req_list.

Fix the leak by calling kfree_skb() if the first loop fails.

In /sys/kernel/debug/kmemleak, after simulating the failure:

  unreferenced object 0xffff88810965a000 (size 232):
    comm "iw", pid 4729, jiffies 4345008185
    hex dump (first 32 bytes):
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    backtrace (crc 20f7de11):
      kmem_cache_alloc_node_noprof+0x302/0x380
      __alloc_skb+0x74/0x2f0
      skb_copy+0x57/0xe0
      rtw_hw_scan_update_probe_req+0xff/0x230
      rtw_hw_scan_prehandle+0x4e/0x180
      rtw_hw_scan_offload+0x186/0x1d0
      rtw_ops_hw_scan+0x61/0xb0
      drv_hw_scan+0x81/0x130
      __ieee80211_start_scan+0x2e0/0x760
      rdev_scan+0x42/0x100
      nl80211_trigger_scan+0x53b/0x730
      genl_family_rcv_msg_doit+0x103/0x160
      genl_rcv_msg+0x1b5/0x2c0
      netlink_rcv_skb+0x52/0x100
      genl_rcv+0x28/0x40
      netlink_unicast+0x26d/0x3b0

This leak exists in the first loop since the function was introduced, and
still happened with the addition of the second loop, in these two commits:

Fixes: 10d162b2ed39 ("rtw88: 8822c: add ieee80211_ops::hw_scan")
Fixes: d95984b5580d ("rtw88: fix memory overrun and memory leak during hw_scan")
Cc: stable@vger.kernel.org
Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
---
Changes in v2:
- Add 'Cc: stable' (Luka Gejak)
- Add 'Reviewed-by: Luka Gejak'
- Link to v1: https://lore.kernel.org/r/20261113-rtw88-hw-scan-skb-leak-v1-1-3bd47562abf6@igalia.com
---
 drivers/net/wireless/realtek/rtw88/fw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 945fedcd375b62b4110ab631e87889bb84e2f16b..09b5836540c41e80a5fecca0f781aa45c6327cc0 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -2061,6 +2061,7 @@ static int _rtw_hw_scan_update_probe_req(struct rtw_dev *rtwdev, u8 num_probes,
 		skb_unlink(skb, probe_req_list);
 		rtw_fill_rsvd_page_desc(rtwdev, skb, RSVD_PROBE_REQ);
 		if (skb->len > page_size * page_cnt) {
+			kfree_skb(skb);
 			ret = -EINVAL;
 			goto out;
 		}

---
base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
change-id: 20261112-rtw88-hw-scan-skb-leak-9e7154def3d5

Best regards,
-- 
Mauricio Faria de Oliveira <mfo@igalia.com>

