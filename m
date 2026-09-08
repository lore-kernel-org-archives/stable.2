Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CB8594803
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888337; cv=none; b=MllfOMS/Wk9ZriFtnaJ2H7tyEnbdTA5xRbgPfWdfgKqj9sRhcCKyIhX9cD6t9fXpGtjRQzfDTW3C9cYzdexiWkT5PrmR7fK+2D8TYGiahJvfe7guu2AaglZHTSRdG9j+jjcNPTI/XMrxPauEE+end0L9n7qYNNBjh51csV30gLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888337; c=relaxed/simple;
	bh=ivWbWLrbdqFq6tBx7aDazQifhUx+DQx69NMrE9TUlFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0iBsaSFyL0DtDF2N2xFpxvtPIUFtK3NoNpkQVw9g2t9vA2TTzUCjZGLW1IFr27j4mLFsXK9As2wZL7dwjakOW8GQ5tfPi52KVCLBwzc27NsKJeKTmRxkK/r49z70zg9HsEs3ZvQIkzijPr6wWrQzMhSI6W5LxBSjVAL2a1q/cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsqTPeTr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsqTPeTr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AEC1F00AC4;
	Tue,  8 Sep 2026 17:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788888336;
	bh=yuAhPpxKa5lQbnNWjrq/dFMnrXh5jpxaO+7un2H2p9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TsqTPeTrbxU01GKd/gAcQiuWH22pkkQYqqQXf60SlA+Y3VurFv5QL2V7pVs2pwa2o
	 d97A0H6Gd4DbE8+Te1rBl1nXH5d7B+MiR55k1MT4bk5ZbqGJEnQVxFGdB1t9W6Ph8p
	 PHlFGZj3AQrfclaYR0P6HnhwA8UmHGywwCp1fGtED8AKiY2hF/Apofy8GLZPXK6OK6
	 iRqPGWK9WjdpnUsPknCHUH+KCg0a+KRznCOQUXxyldMYk2+wbmCw56m95Xin34Uu0y
	 s32GdwfemT05oC/PvqNNZRt4afL5n7K5tJrsym9feqmZi+wlrFfSjJFB2yKAF9CSwq
	 BehcLr3tTZClA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] mailbox: qcom-ipcc: fix duplicate channel allocation across holes
Date: Tue,  8 Sep 2026 13:25:33 -0400
Message-ID: <20260908172533.79209-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908172533.79209-1-sashal@kernel.org>
References: <2026090341-antibody-riches-1252@gregkh>
 <20260908172533.79209-1-sashal@kernel.org>
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

