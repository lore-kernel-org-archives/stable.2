Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73FF57D203
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888847; cv=none; b=vCGN1AaPUPM0mp/oGa1VvbGBGnvFqpECksih2FIlMHJkpw6HqnLmdybt+jqmWgSAmKXY2tpJd8DOXmmPGRHPdQU1tO14SxYObKSpfFkTbvhrIFcL+87m4Kb57DNT145JgqDw0zE4GV40Yt13WBkbNblhphMLQ2kHSEeQs9XZDc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888847; c=relaxed/simple;
	bh=ivWbWLrbdqFq6tBx7aDazQifhUx+DQx69NMrE9TUlFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbwo92zPFwIzWyO8qhccnmKMlwmzDIJYZMy31bV39M8AwDkA60C+bR06nY21KXSnXtZUJldX00pk4jPtHTxQcTqUdT8Y7rUWMXUy+Y1sqYZEzdy+m0+unMr77MYNKxo4ZAGyscH4FV994tlw7cyyQZpr2f7SHHbFtfpVMtH1qxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuY/eAw5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuY/eAw5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171531F00A3D;
	Tue,  8 Sep 2026 17:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788888846;
	bh=yuAhPpxKa5lQbnNWjrq/dFMnrXh5jpxaO+7un2H2p9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iuY/eAw5rE18weSDVuNLa3fPKzjYeHP8BdnjtrmwATQW4HHZ61ILXU2VEWE7uNwhz
	 Yv5YyhH42xurXbMSFQheU5AHgmZiEDufsfxN2g2m0uaW+QSze4+sAxMvR2OwMtCcMj
	 tEK5lE9yGO8qj3IhsOd/iOXrSJnxpYS14y2BInQ9Ht/CApnGVO3QAaPgEZoFAd9nBi
	 1csR16ZK3uaEpzgEZLJaZ3OFIDnCxZZw20ak3eV9AbeGOLulGNhRrnsu0eFmfSr0pP
	 IH17pb7thCG+mkT5ESFtoYEvCMAqOOZ7ao0HjCLzONswFiL3BgjaJJ6GwWIVd1eedV
	 s4+BYx21nXiJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] mailbox: qcom-ipcc: fix duplicate channel allocation across holes
Date: Tue,  8 Sep 2026 13:34:03 -0400
Message-ID: <20260908173403.109367-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908173403.109367-1-sashal@kernel.org>
References: <2026090341-antibody-riches-1252@gregkh>
 <20260908173403.109367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>

[ Upstream commit 66c7bcad72430a02c860521031350b84b31ad9a8 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/qcom-ipcc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
index 10cb0b5461090..b421f84dcfc26 100644
--- a/drivers/mailbox/qcom-ipcc.c
+++ b/drivers/mailbox/qcom-ipcc.c
@@ -164,7 +164,7 @@ static struct mbox_chan *qcom_ipcc_mbox_xlate(struct mbox_controller *mbox,
 {
 	struct qcom_ipcc *ipcc = to_qcom_ipcc(mbox);
 	struct qcom_ipcc_chan_info *mchan;
-	struct mbox_chan *chan;
+	struct mbox_chan *chan, *free_chan = NULL;
 	struct device *dev;
 	int chan_id;
 
@@ -177,16 +177,21 @@ static struct mbox_chan *qcom_ipcc_mbox_xlate(struct mbox_controller *mbox,
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
-- 
2.53.0

