Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100C24B5413
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445524; cv=none; b=azDMiI8pVU0mixdfFqb0dcUXiBDtF2d8qBrA7ZpYS3ZZl7ZB27b08BPj0lbF4YJPlzmXNchquJsDuIJ6OWtBrWza8im8DCc9w1ghWAvm5WcccIYzCYstdz9sbCPGrLiNMnlBIqmdSceZZ7ym2gQ2OpGgjVENcS2Z6ELcdUt1fWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445524; c=relaxed/simple;
	bh=KpBVCzT+YNiC+7Ki4Zlqd5LZTI8zVHxh40eScFeIHbY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GZfFYJuRxxPaIIEBcHZ0u6W3tzCUIjGtrMeFrp+iO19Vy/fQ9BLmNFI6i2RLefgCINZRB9GPCunURb7HP36bJLdUECtgxTxnQhslRDAXkWrZ618PZ6i3s8efVmiDEZdFlXw4Nyv3CZWS/yZdHKl4q7TZJkLH7yg5G+ObXTyM1Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DHgZMaCa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DHgZMaCa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1E61F00A3D;
	Thu,  3 Sep 2026 14:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445512;
	bh=KVtGUWqOsmdS7WFb0gfzx7Kghn/G53FGrZltOAHZzpc=;
	h=Subject:To:Cc:From:Date;
	b=DHgZMaCaBSNuAGbUKFNihEUw5gkwiqevocSGMjSADoYp+FeWJbySH3pi0xUmlA2Y+
	 wZufeMb+tbtRF2BVKbQjSXSgCCjK2RmyS+EmHw/DMA3jGGFC3ZSXZ098kewQQTQwD0
	 yNlb2YxVyFz5d0wtGRc7jOLvZVlMjk2NutGSnfq4=
Subject: FAILED: patch "[PATCH] mailbox: qcom-ipcc: fix duplicate channel allocation across" failed to apply to 5.10-stable tree
To: anup.vishwakarma@oss.qualcomm.com,jassisinghbrar@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:01:42 +0200
Message-ID: <2026090342-wildfire-scrambler-d994@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 66c7bcad72430a02c860521031350b84b31ad9a8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090342-wildfire-scrambler-d994@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 66c7bcad72430a02c860521031350b84b31ad9a8 Mon Sep 17 00:00:00 2001
From: Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 14:34:07 +0530
Subject: [PATCH] mailbox: qcom-ipcc: fix duplicate channel allocation across
 holes

The IPCC of_xlate() both scans for a free mailbox channel and checks
for duplicate references to the same underlying IPCC channel. When a
channel has been shutdown it might have left a hole in the channel
list, which would terminate the search without considering duplicates
later in the list.

Continue the traversal of the channel list to detect and reject
duplicates, while keeping track of the first free channel.

Fixes: d6fbfdbc1274 ("mailbox: qcom-ipcc: Fix IPCC mbox channel exhaustion")
Cc: stable@vger.kernel.org
Signed-off-by: Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>

diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
index e5ebb4a237ff..185b63f724d4 100644
--- a/drivers/mailbox/qcom-ipcc.c
+++ b/drivers/mailbox/qcom-ipcc.c
@@ -167,7 +167,7 @@ static struct mbox_chan *qcom_ipcc_mbox_xlate(struct mbox_controller *mbox,
 {
 	struct qcom_ipcc *ipcc = to_qcom_ipcc(mbox);
 	struct qcom_ipcc_chan_info *mchan;
-	struct mbox_chan *chan;
+	struct mbox_chan *chan, *free_chan = NULL;
 	struct device *dev;
 	int chan_id;
 
@@ -180,16 +180,21 @@ static struct mbox_chan *qcom_ipcc_mbox_xlate(struct mbox_controller *mbox,
 		chan = &ipcc->chans[chan_id];
 		mchan = chan->con_priv;
 
-		if (!mchan)
-			break;
-		else if (mchan->client_id == ph->args[0] &&
-				mchan->signal_id == ph->args[1])
+		if (!mchan) {
+			/* Keep scanning past holes to reject duplicate channel requests. */
+			if (!free_chan)
+				free_chan = chan;
+		} else if (mchan->client_id == ph->args[0] &&
+				mchan->signal_id == ph->args[1]) {
 			return ERR_PTR(-EBUSY);
+		}
 	}
 
-	if (chan_id >= mbox->num_chans)
+	if (!free_chan)
 		return ERR_PTR(-EBUSY);
 
+	chan = free_chan;
+
 	mchan = devm_kzalloc(dev, sizeof(*mchan), GFP_KERNEL);
 	if (!mchan)
 		return ERR_PTR(-ENOMEM);

