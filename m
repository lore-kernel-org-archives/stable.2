Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AF233939F;
	Fri, 31 Jul 2026 02:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785465899; cv=none; b=G5KYiCmtSqdntni+GtMsSiekMKa/Wqn7cHNBXz09glpo05XPZFq0NuMv3c6mM+exJS6ryw7aHVDHxCcGfnb0j6uEb1DKaHnyvq109apPA0FciWbRP9QRlyKqiYrxzF9qjgA0ORB5xlV/2sZoShQgmcdFxG/4wRqVycncGnn3dx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785465899; c=relaxed/simple;
	bh=/0QDrerinODq9/3piMZlE8oSa1HH99hESCKuwez+nq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hiByVwXz9S69bfh/unVBWy860xMs1f0TwEbQzua94t/jDWuxmWNcQ2+ghKdr9roYT3SQtQZac5QPwvkuU5VWbfStj6RkpYdbVO/nnw5DdI0H39C2YFvVoIec+tHH6VaJc8bUliUgA/HyIuvBiQ81EBS1aH4brfL8sj+s3JBnOPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDXZTUXDGxqWCNSAA--.20815S3;
	Fri, 31 Jul 2026 10:44:39 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgCH9coXDGxq1EJjAw--.19349S4;
	Fri, 31 Jul 2026 10:44:39 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	david@ixit.cz,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuniyu@google.com,
	christophe.ricard@gmail.com,
	sameo@linux.intel.com,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/2] nfc: st-nci: drain SE timers before NCI teardown
Date: Fri, 31 Jul 2026 02:43:44 +0000
Message-Id: <20260731024344.317793-3-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731024344.317793-1-fanwu01@zju.edu.cn>
References: <20260731024344.317793-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgCH9coXDGxq1EJjAw--.19349S4
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?SR4TnAXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI0HnIlrb2PNJ6YIDQJs+Wcx5XDDVYGTb/X7qfj0EuaAmx2c
	Y63qR7Lz02zP9k4Smgap9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxWr1DCFyDZryxAFWxGw1UCFX_yoWrtF15pF
	45Ww17Jr4rWr48WaykAw1DWFW5JayIkFWUK3srJaySvF45Kry0qF4UAFWS9FZxArZ5XF1x
	tr4rXw1UWF1UtagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7EoGDUUUU

st_nci_se_deinit() drains the two se_info timers (bwi_timer and
se_active_timer), but it has had no caller since the secure-element
support was added.  st_nci_remove() tears the device down with
ndlc_close() / nci_unregister_device() / nci_free_device() and never
reaches the helper.  A timer armed during operation therefore survives
st_nci_remove() and the devm release of struct st_nci_info: the bwi
callback st_nci_se_wt_timeout() reaches into the NCI core, and both
callbacks dereference info->se_info.

Register the helper as the NCI pre_unregister callback added by the
previous patch, so the NCI core invokes it in nci_unregister_device()
after the NFC admission barrier (new SE operations are already rejected)
and before nci_close_device() / destroy_workqueue() (the NCI core and its
workqueues still exist).

Shut down both timers with timer_shutdown_sync().  Complete req_completion
after the se_active_timer is shut down so an in-flight SE enable/disable is
woken rather than left waiting: nfc_enable_se()/nfc_disable_se() hold the
NFC device lock across st_nci_control_se().  For an outstanding APDU,
invoke its completion callback with -ENODEV; the existing netlink
completion path then frees se_io_ctx.
bwi_active is an xchg() ownership token shared by the response, the
timeout and teardown paths, so the callback is delivered exactly once.

This issue was found by an in-house static analysis tool.

Fixes: 8ae01f796771 ("NFC: st21nfcb: Add support for secure element")
Cc: stable@vger.kernel.org # 6.6+
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---

 drivers/nfc/st-nci/core.c |  1 +
 drivers/nfc/st-nci/se.c   | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/nfc/st-nci/core.c b/drivers/nfc/st-nci/core.c
index a367136d4..6e8f799f5 100644
--- a/drivers/nfc/st-nci/core.c
+++ b/drivers/nfc/st-nci/core.c
@@ -105,6 +105,7 @@ static const struct nci_ops st_nci_ops = {
 	.hci_load_session = st_nci_hci_load_session,
 	.hci_event_received = st_nci_hci_event_received,
 	.hci_cmd_received = st_nci_hci_cmd_received,
+	.pre_unregister = st_nci_se_deinit,
 	.prop_ops = st_nci_prop_ops,
 	.n_prop_ops = ARRAY_SIZE(st_nci_prop_ops),
 };
diff --git a/drivers/nfc/st-nci/se.c b/drivers/nfc/st-nci/se.c
index 607ec768e..232249d60 100644
--- a/drivers/nfc/st-nci/se.c
+++ b/drivers/nfc/st-nci/se.c
@@ -283,9 +283,9 @@ static int st_nci_hci_apdu_reader_event_received(struct nci_dev *ndev,
 	switch (event) {
 	case ST_NCI_EVT_TRANSMIT_DATA:
 		timer_delete_sync(&info->se_info.bwi_timer);
-		info->se_info.bwi_active = false;
-		info->se_info.cb(info->se_info.cb_context,
-				 skb->data, skb->len, 0);
+		if (xchg(&info->se_info.bwi_active, false))
+			info->se_info.cb(info->se_info.cb_context,
+					 skb->data, skb->len, 0);
 	break;
 	case ST_NCI_EVT_WTX_REQUEST:
 		mod_timer(&info->se_info.bwi_timer, jiffies +
@@ -665,9 +665,9 @@ int st_nci_se_io(struct nci_dev *ndev, u32 se_idx,
 	case ST_NCI_ESE_HOST_ID:
 		info->se_info.cb = cb;
 		info->se_info.cb_context = cb_context;
+		xchg(&info->se_info.bwi_active, true);
 		mod_timer(&info->se_info.bwi_timer, jiffies +
 			  msecs_to_jiffies(info->se_info.wt_timeout));
-		info->se_info.bwi_active = true;
 		return nci_hci_send_event(ndev, ST_NCI_APDU_READER_GATE,
 					ST_NCI_EVT_TRANSMIT_DATA, apdu,
 					apdu_length);
@@ -699,7 +699,8 @@ static void st_nci_se_wt_timeout(struct timer_list *t)
 	struct st_nci_info *info = timer_container_of(info, t,
 						      se_info.bwi_timer);
 
-	info->se_info.bwi_active = false;
+	if (!xchg(&info->se_info.bwi_active, false))
+		return;
 
 	if (!info->se_info.xch_error) {
 		info->se_info.xch_error = true;
@@ -751,13 +752,12 @@ void st_nci_se_deinit(struct nci_dev *ndev)
 {
 	struct st_nci_info *info = nci_get_drvdata(ndev);
 
-	if (info->se_info.bwi_active)
-		timer_delete_sync(&info->se_info.bwi_timer);
-	if (info->se_info.se_active)
-		timer_delete_sync(&info->se_info.se_active_timer);
+	timer_shutdown_sync(&info->se_info.bwi_timer);
+	if (xchg(&info->se_info.bwi_active, false))
+		info->se_info.cb(info->se_info.cb_context, NULL, 0, -ENODEV);
 
-	info->se_info.se_active = false;
-	info->se_info.bwi_active = false;
+	timer_shutdown_sync(&info->se_info.se_active_timer);
+	xchg(&info->se_info.se_active, false);
+	complete(&info->se_info.req_completion);
 }
 EXPORT_SYMBOL(st_nci_se_deinit);
-

