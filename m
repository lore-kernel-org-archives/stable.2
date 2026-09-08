Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A0F4A6CCB
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888623; cv=none; b=e3ndc5juqGRFsjuVx7Y4nNrci4+n5qiFGowDAN9gfFT5NuC9CgNOgHhd+JJYq3dp97XHkrAKIite4J45EK/5rpf1L4VyCBXJrut8zUiZipYHMVGs6VSQlPpni+q8yz8AohBG/HHN9unWuH8amoXh38y8V9jC5lYIOh8aKfGLrU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888623; c=relaxed/simple;
	bh=nzxHDAERnnQAqglfpVtc3ltlUJoQm6DOl1ktpz8E9kI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epplqdj2rtlfpRCB75b8HZEoXgj3akcLH75HlBvTHX8Kh7Hv/CKBEpR0pxpCBCkQJ6k05Eh0J7K0nN8/w4Ma/SJp5ZDpIkASTtIoZCPyJBIrGLENDQaqujD0XQXjspln65LsuZD52/eLSkQtO9dG3vZk3zqiLpqZlfFNcz8r2uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2FzHKHb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2FzHKHb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5B41F00A3D;
	Tue,  8 Sep 2026 17:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788888622;
	bh=KOmpY+lWyqFT2ZUpyqeQCVj9WkGfk0dy7vVrs1iURLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T2FzHKHbugFuzZrNN4RqCmKjizo4r1/mcjjEuIyLzTMzphKSsyUuzoFSrSdXNCbg2
	 PdcCpj+FM6eJjevgSs36JIqWjr0cmaqmkv4iJEruI1Sajw6P8PRFhKlbbrU33A4c+Y
	 MhHmPyyF8NE00ENLRVL+F4ZwUSUP95S8ziXfYBzeY4l6suKvYbePY2fnETFOhyLz1n
	 znCReqvPK+M9AqugjBzEQPi9//CfPqFoxpUDDwUKh4NLK48gu5NwvwxXoOFxmRuTnr
	 3vy010dPUw5kIS0VJ0hXnwLLzReD9QV6N5KcJCZY/I/05JdAaQyVqrmmDVtSQvdJAw
	 UrVgbLJfmBKpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] mailbox: qcom-ipcc: fix duplicate channel allocation across holes
Date: Tue,  8 Sep 2026 13:30:19 -0400
Message-ID: <20260908173019.95356-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908173019.95356-1-sashal@kernel.org>
References: <2026090342-wildfire-scrambler-d994@gregkh>
 <20260908173019.95356-1-sashal@kernel.org>
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
index 1bc5382c8fc81..1ab8b25955a05 100644
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

