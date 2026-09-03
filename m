Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED224B66F7
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445533; cv=none; b=oI1rhRQ3A04pJwE7IlWGskOQXWuydamvQOGlMO1Uj/q888YuM9XOMB4jF17TKHHUgNI3liZ7BURQ36IH3SixZVEK8fffPmAASKsUk1v8hxFnYFiNzNaFUzb84jGXWqwOZtk/IrqN1Mesy/LoZ/LYLbU943OyuOT+rthqShRNArU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445533; c=relaxed/simple;
	bh=oOs67V3R4fVXPvRzxIa+ZJRJXX3ccbmjClpxYANMgPk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VHW29+1SHXRgDParSsM/CWGlioJD6zT0fduDlnNh1vrgytpu+RXaXmkOeQmBOT1EFOzZm9to8VmUMH+5Mp3yTyH0S2M3FiqEK/bM+oNZEAdKk2sRj9ySY4qBeTjSwjideDivtBzPb81f/2Gcb+sfvTHvuGFaqPlMVK4cHSOGI8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fW0YpMBR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fW0YpMBR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F551F00A3A;
	Thu,  3 Sep 2026 14:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445510;
	bh=bsvaBfYAUlJ92os1KQJK3Fclky2VNFPUIFcFCV6fdsE=;
	h=Subject:To:Cc:From:Date;
	b=fW0YpMBRqWGygq0ogb+liliRktctvSZe/kXVzQeqwHME0ZIAym1jI0nt/Chq5nb3R
	 0z9e2pWZ4MI5X6duY2+Wp4R7BdFiI7IlaJ7UNT+escbCRKHdf+fsrCB0KW/cA0iVjm
	 GZGwu4vzURzorK2B1FlsB3KQJ/RWM2dsUTXCvNDc=
Subject: FAILED: patch "[PATCH] mailbox: qcom-ipcc: fix duplicate channel allocation across" failed to apply to 5.15-stable tree
To: anup.vishwakarma@oss.qualcomm.com,jassisinghbrar@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:01:41 +0200
Message-ID: <2026090341-antibody-riches-1252@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 66c7bcad72430a02c860521031350b84b31ad9a8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090341-antibody-riches-1252@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

