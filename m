Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08EF37B030;
	Tue, 22 Sep 2026 02:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790042518; cv=none; b=BQbCHjfC1TgW9uys2x6DCNMOmo+6440sclA4hPR1IQ3Hsehyph3Nrhka8JHXW/sjq0doTqjxhsWqs5HWS+AZazARv4sPh6MCtaYOxZ2Hr2H+ECQm0shKqGW9k/lMSfXyNaGOCSkc68pPWor5VL7ckJPxQMu25rBH+QTit+vkFzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790042518; c=relaxed/simple;
	bh=P6dYgJxGG8rVhsXBuE+XyyKHSnnOHUAQMNn7iMezy10=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eWwiSevrCRqW7c/4fuh4V3D1YA2jYbLVbWM37aWgDqAy/xAllCzshgGBOPZxbqK8+wnpIb92YdE9pOSJyJdKqC2LQUBVOKC+DCMBxKNb6MSSYkHecg2EQ8wW6flNug4o/F2evcrsCWfzsy1PTDRSwvoTBKJwA0l3sjdDakb0MNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 911b2e7ab62911f19a56ed5b684f684d-20260922
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:0d9230ce-21c4-4d91-abf0-feadfc1adc08,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:3eed73de39325b084e66fd99e071f5bd,BulkI
	D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50|99,EDM:
	-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 911b2e7ab62911f19a56ed5b684f684d-20260922
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1783181564; Tue, 22 Sep 2026 10:01:46 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH] Bluetooth: hci_core: Fix inquiry cache timestamps on 64-bit systems
Date: Tue, 22 Sep 2026 10:01:41 +0800
Message-Id: <20260922020141.389269-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 64-bit systems, outgoing BR/EDR connections always fall back to page
scan repetition mode R2 with no clock offset once the system has been
up for more than five minutes, even when inquiry found the peer only
seconds earlier. This lengthens paging and can increase the risk of a
Page Timeout.

The inquiry cache stores jiffies in __u32 timestamps, but its age
helpers subtract them from unsigned long jiffies. INITIAL_JIFFIES casts
-300 * HZ through unsigned int, so jiffies crosses 2^32 five minutes
after boot on 64-bit systems. Assigning it to __u32 then drops the upper
32 bits. In one trace, a 7.6-second-old entry (HZ=1000) was reported as
2^32 + 7620 ticks old and rejected by hci_acl_create_conn_sync().
hci_inquiry() is affected by the same truncation when checking the whole
cache. 32-bit systems are unaffected because unsigned long is 32 bits
wide there.

Use unsigned long for both timestamps so they have the same width as
jiffies on 32-bit and 64-bit systems, and update the debugfs format
specifier accordingly.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 include/net/bluetooth/hci_core.h | 4 ++--
 net/bluetooth/hci_debugfs.c      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b26004a05368..788d6600f500 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -63,7 +63,7 @@ struct inquiry_entry {
 		NAME_PENDING,
 		NAME_KNOWN,
 	} name_state;
-	__u32			timestamp;
+	unsigned long		timestamp;
 	struct inquiry_data	data;
 };
 
@@ -79,7 +79,7 @@ struct discovery_state {
 	struct list_head	all;	/* All devices found during inquiry */
 	struct list_head	unknown;	/* Name state not known */
 	struct list_head	resolve;	/* Name needs to be resolved */
-	__u32			timestamp;
+	unsigned long		timestamp;
 	bdaddr_t		last_adv_addr;
 	u8			last_adv_addr_type;
 	s8			last_adv_rssi;
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index aadffaaff20e..2559fb6324d6 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -364,7 +364,7 @@ static int inquiry_cache_show(struct seq_file *f, void *p)
 
 	list_for_each_entry(e, &cache->all, all) {
 		struct inquiry_data *data = &e->data;
-		seq_printf(f, "%pMR %d %d %d 0x%.2x%.2x%.2x 0x%.4x %d %d %u\n",
+		seq_printf(f, "%pMR %d %d %d 0x%.2x%.2x%.2x 0x%.4x %d %d %lu\n",
 			   &data->bdaddr,
 			   data->pscan_rep_mode, data->pscan_period_mode,
 			   data->pscan_mode, data->dev_class[2],
-- 
2.25.1

