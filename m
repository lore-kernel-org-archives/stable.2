Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A172C3757;
	Sat, 15 Aug 2026 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786801958; cv=none; b=E/+P7923Uuks6eYl3MHGhiM0ZXS0DFVh+luDCFZHQq2/L2WsdC7DF0thfuOwxilaeFG1qR/ATWqX1Bh3uco+lyRmFwxDsyrPwcqX451x7KYtVWbnZostR0at1q3aKWrILOSLzC344b7bGo2RxrvZLgfXvEvFXsrdrRrROLgIP2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786801958; c=relaxed/simple;
	bh=adzBY+vyUPRDkFg3C127280D0dslJ/CDMqjk1ZJcDxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lWVkneUGLxXKs7K9dHUhsr/KjBW4vyPielwqVlM/mrJke7T/oURUQOANz0MDIuA72G6urg7NhcODynRroGeKOZ4ESm3VmKa+kLLEBq1UU4jxeDGHPCOTo/2k58dNV92ewHo0nY1kp8I1CIBRw0QjUv6Z6I8GDMOo8xytnbT1k6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-05 (Coremail) with SMTP id zQCowAAXhT8bb4Bq3mvRBQ--.23067S2;
	Sat, 15 Aug 2026 21:52:28 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: briannorris@chromium.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Francesco Dolcini <francesco@dolcini.it>,
	Amitkumar Karwar <akarwar@marvell.com>,
	Ramesh Radhakrishnan <rramesh@marvell.com>,
	Bing Zhao <bzhao@marvell.com>,
	Yogesh Ashok Powar <yogeshp@marvell.com>,
	"John W . Linville" <linville@tuxdriver.com>,
	Tristan Madani <tristmd@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] wifi: mwifiex: validate scan response extents
Date: Sat, 15 Aug 2026 21:52:27 +0800
Message-ID: <20260815135227.50392-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXhT8bb4Bq3mvRBQ--.23067S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1fKFyxWw1rtw1UXF4DCFg_yoWrGry7pF
	Z0kw1fXr1kJr17Kr4xJF1Fqay5Ka1rXryjkF9rZw1furnIk34rZFWjkFyF9ryYqFsFgr4a
	9r4qqr1fAr1DZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r
	4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUL0edUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

mwifiex_ret_802_11_scan() subtracts the fixed response fields and the
firmware-provided BSS length from resp->size without first proving that
either extent fits. A short response or oversized BSS length can
therefore underflow tlv_buf_size and make the TLV parser walk beyond the
command response.

Compute the fixed extent from the selected normal or background scan
response. Validate that the fixed fields and BSS data fit before deriving
the TLV extent and entering the parser.

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1:
https://lore.kernel.org/all/20260706092654.79403-1-pengpeng@iscas.ac.cn/
- narrow this patch to the independent response/BSS extent underflow
- account for the additional fixed field in background-scan responses
- leave TSF and channel-band array validation to Tristan Madani's patch:
  https://lore.kernel.org/all/20260421134938.331334-5-tristmd@gmail.com/

 drivers/net/wireless/marvell/mwifiex/scan.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index 97c0ec3b822e..256201fff971 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -2096,6 +2096,7 @@ int mwifiex_ret_802_11_scan(struct mwifiex_private *priv,
 	u32 bytes_left;
 	u32 idx;
 	u32 tlv_buf_size;
+	size_t fixed_size;
 	struct mwifiex_ie_types_chan_band_list_param_set *chan_band_tlv;
 	struct chan_band_param_set *chan_band;
 	u8 is_bgscan_resp;
@@ -2111,6 +2112,14 @@ int mwifiex_ret_802_11_scan(struct mwifiex_private *priv,
 	else
 		scan_rsp = &resp->params.scan_resp;
 
+	scan_resp_size = le16_to_cpu(resp->size);
+	fixed_size = scan_rsp->bss_desc_and_tlv_buffer - (u8 *)resp;
+	if (scan_resp_size < fixed_size) {
+		mwifiex_dbg(adapter, ERROR,
+			    "SCAN_RESP: response is too short\n");
+		ret = -1;
+		goto check_next_scan;
+	}
 
 	if (scan_rsp->number_of_sets > MWIFIEX_MAX_AP) {
 		mwifiex_dbg(adapter, ERROR,
@@ -2128,8 +2137,6 @@ int mwifiex_ret_802_11_scan(struct mwifiex_private *priv,
 		    "info: SCAN_RESP: bss_descript_size %d\n",
 		    bytes_left);
 
-	scan_resp_size = le16_to_cpu(resp->size);
-
 	mwifiex_dbg(adapter, INFO,
 		    "info: SCAN_RESP: returned %d APs before parsing\n",
 		    scan_rsp->number_of_sets);
@@ -2137,15 +2144,17 @@ int mwifiex_ret_802_11_scan(struct mwifiex_private *priv,
 	bss_info = scan_rsp->bss_desc_and_tlv_buffer;
 
 	/*
-	 * The size of the TLV buffer is equal to the entire command response
-	 *   size (scan_resp_size) minus the fixed fields (sizeof()'s), the
-	 *   BSS Descriptions (bss_descript_size as bytesLef) and the command
-	 *   response header (S_DS_GEN)
+	 * The TLV buffer follows the command-specific fixed fields and the BSS
+	 * descriptions. Background-scan responses have an additional fixed
+	 * field before scan_rsp, which is included in fixed_size.
 	 */
-	tlv_buf_size = scan_resp_size - (bytes_left
-					 + sizeof(scan_rsp->bss_descript_size)
-					 + sizeof(scan_rsp->number_of_sets)
-					 + S_DS_GEN);
+	if (bytes_left > scan_resp_size - fixed_size) {
+		mwifiex_dbg(adapter, ERROR,
+			    "SCAN_RESP: BSS data exceeds response\n");
+		ret = -1;
+		goto check_next_scan;
+	}
+	tlv_buf_size = scan_resp_size - fixed_size - bytes_left;
 
 	tlv_data = (struct mwifiex_ie_types_data *) (scan_rsp->
 						 bss_desc_and_tlv_buffer +

base-commit: dac3e89a2c90c2feeb471e1f22a2512ad424b792
-- 
2.50.1 (Apple Git-155)

