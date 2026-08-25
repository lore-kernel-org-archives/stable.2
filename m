Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7CB3CAA53;
	Tue, 25 Aug 2026 19:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787685898; cv=none; b=knmxvriMxoa4b4ffJ5jdniSFxyyDr27DOIq/Hc/ggLuzCpPo5lpWhepBzh2QdxajnzoBdXROooDs1UXCXhoT79OaOshtK22/1A+pP7A61WnBX7Rrwdr0pKhI4Roe4mCxnKDRLxp3Hx27628DF/1dkRbB4AMMafAds1DL6Q3UrMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787685898; c=relaxed/simple;
	bh=kDXb0E0lYMM7EH3imuAOuuUNEh82ewm7w1dTNPRFYWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VfNTCgpXTc9IcAiQyhDOLj1rxmVlO7Ugkez2xCdilH4F5Wtor9RGE5j1m/9kUu4seq+XakoV+vPJkM94B0gSw+VZ4Q/kV7LlMpgjKCeaky21i76rwCkLYv0Jqyd9tTpXSxukofSkNdMHQHLa8bfpF0jtbSBiCTMf4GtriFkIbmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Owww0kPH; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Owww0kPH"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 2EA22C003AD2;
	Tue, 25 Aug 2026 12:16:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 2EA22C003AD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1787685402;
	bh=kDXb0E0lYMM7EH3imuAOuuUNEh82ewm7w1dTNPRFYWI=;
	h=From:To:Cc:Subject:Date:From;
	b=Owww0kPH/CQssl9Uz1S7ZlxUDrZhVVcKQGHWC/vW4FhLDkuCZM/rztay3rA6C4bfS
	 kpPhQZx2RKpTKZwx2RI5/lWnA18PAbXFTww2qYzBwvQ8kDgsuYtb2l07Nz5LFbcjKE
	 zoC61mMplG+LFmjAFNE9fSgm9jdggRF/avg84oH0=
Received: from bse-build-07.ric.broadcom.net (unknown [10.136.28.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 947ACA9A;
	Tue, 25 Aug 2026 12:16:41 -0700 (PDT)
From: Danesh Petigara <danesh.petigara@broadcom.com>
To: jassisinghbrar@gmail.com
Cc: justin.chen@broadcom.com,
	florian.fainelli@broadcom.com,
	james.quinlan@broadcom.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Danesh Petigara <danesh.petigara@broadcom.com>
Subject: [PATCH] mailbox: bcm74110: Cap rx_svc_init_list growth to prevent PMC-induced OOM
Date: Tue, 25 Aug 2026 12:16:19 -0700
Message-ID: <20260825191619.2326087-1-danesh.petigara@broadcom.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <florian.fainelli@broadcom.com>

bcm74110_rx_push_init_msg() allocates a GFP_ATOMIC struct for every
BCM_MSG_SVC_INIT word received from the PMC co-processor and appends it
to rx_svc_init_list with no cap on list length.  The only consumers of
this list (bcm74110_rx_pop_init_msg_block / bcm74110_rx_flush_msg) are
called only during probe and at shutdown respectively; after probe
completes, PMC firmware can continuously inject BCM_MSG_SVC_INIT words,
exhausting GFP_ATOMIC reserves and causing a whole-device denial of
service.

Add BCM74110_INIT_MSG_MAX (16 entries) as the maximum list depth.
bcm74110_rx_push_init_msg() now checks the count under the existing
rx_svc_list_lock before allocating; if the cap is reached the message is
dropped and a rate-limited warning is emitted.  The new rx_svc_init_count
field is decremented by bcm74110_rx_pop_init_msg() on successful dequeue
and reset to zero by bcm74110_rx_flush_msg() on shutdown.

Fixes: 52436007b862 ("mailbox: Add support for bcm74110")
Cc: stable@vger.kernel.org
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Assisted-by: Anthropic:claude-sonnet-4.6 cursor
Signed-off-by: Danesh Petigara <danesh.petigara@broadcom.com>
---
 drivers/mailbox/bcm74110-mailbox.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mailbox/bcm74110-mailbox.c b/drivers/mailbox/bcm74110-mailbox.c
index c8709d509912..bec138d76914 100644
--- a/drivers/mailbox/bcm74110-mailbox.c
+++ b/drivers/mailbox/bcm74110-mailbox.c
@@ -97,6 +97,8 @@ struct bcm74110_mbox_chan {
 	int				type;
 };
 
+#define BCM74110_INIT_MSG_MAX		16
+
 struct bcm74110_mbox {
 	struct platform_device		*pdev;
 	void __iomem			*base;
@@ -105,6 +107,7 @@ struct bcm74110_mbox {
 	int				rx_chan;
 	int				rx_irq;
 	struct list_head		rx_svc_init_list;
+	unsigned int			rx_svc_init_count;
 	spinlock_t			rx_svc_list_lock;
 
 	struct mbox_controller		controller;
@@ -148,7 +151,15 @@ static void bcm74110_rx_push_init_msg(struct bcm74110_mbox *mbox, u32 val)
 	msg->msg = val;
 
 	spin_lock(&mbox->rx_svc_list_lock);
+	if (mbox->rx_svc_init_count >= BCM74110_INIT_MSG_MAX) {
+		spin_unlock(&mbox->rx_svc_list_lock);
+		kfree(msg);
+		dev_warn_ratelimited(&mbox->pdev->dev,
+				     "PMC INIT msg list full, dropping message\n");
+		return;
+	}
 	list_add_tail(&msg->list_entry, &mbox->rx_svc_init_list);
+	mbox->rx_svc_init_count++;
 	spin_unlock(&mbox->rx_svc_list_lock);
 }
 
@@ -225,6 +236,7 @@ static int bcm74110_rx_pop_init_msg(struct bcm74110_mbox *mbox, u32 func_type,
 				 list_entry) {
 		if (BCM_MSG_GET_FIELD(msg->msg, FUNC) == func_type) {
 			list_del(&msg->list_entry);
+			mbox->rx_svc_init_count--;
 			found = true;
 			break;
 		}
@@ -248,6 +260,7 @@ static void bcm74110_rx_flush_msg(struct bcm74110_mbox *mbox)
 
 	spin_lock_irqsave(&mbox->rx_svc_list_lock, flags);
 	list_splice_init(&mbox->rx_svc_init_list, &list_temp);
+	mbox->rx_svc_init_count = 0;
 	spin_unlock_irqrestore(&mbox->rx_svc_list_lock, flags);
 
 	list_for_each_entry_safe(msg, msg_tmp, &list_temp, list_entry) {
-- 
2.54.0

