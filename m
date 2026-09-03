Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DB24C77BF
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447778; cv=none; b=E19Evl2rmvaEffdDlgJU8UrjqUY8JVUBYPKj8fEXhmUcRdGxB1KXdOnyuYh+c1ESFvEy/W/F2eoNF4E7tCR+6sNSMhtYlnysJEMmnxs8xrefsW26eYYuRGH8LMpumpfqFlnzt4OzTxLTbK2nrCoSGVpH1CLWpys9IBQ73JTfUr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447778; c=relaxed/simple;
	bh=HpFbx9jd9yHYQd1e6IayPO4HjUodum4wtSPcBUGyRVk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RNrKy737yowPtXkonQay5tEWD0XHSqKV81x5OeGsszOMetFxWO29dXo7R6xuf97qI+fArjWVh4e4W+JV2nB6uqLTh8H+m4HD/kt6s2hVzID0+igWAyMeh1zr5wH5vVM+CR1FG/bQZVUtP3bqGNjno6UTe2jj3moYwW4vzUEtEGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jESfyoPe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jESfyoPe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333191F000E9;
	Thu,  3 Sep 2026 15:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447776;
	bh=DY3GGI5DJ1Iqk36DlVwixBYYdY7TzB1/4dYcsTuk4TY=;
	h=Subject:To:Cc:From:Date;
	b=jESfyoPe7g1sYkfa98dSrR3J0h8n/pG5aiaK74GY0EUq/a0HUc7frIxO/gzRBTYT9
	 Kn5qNKUF6nC2QFCTRWZ50j6ejGkoEkipIycCK+iD4WL8W/vVTSubgi/8SoaPwQq7+S
	 mz3tgvRiNbRZT0LTuvTDgl94bzq0RKsKpi/XC63I=
Subject: FAILED: patch "[PATCH] nvme-tcp: fix host memory disclosure on R2T for a read" failed to apply to 5.15-stable tree
To: yhlee@isslab.korea.ac.kr,kbusch@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:36:03 +0200
Message-ID: <2026090303-snowshoe-motivator-818f@gregkh>
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
git cherry-pick -x 6efbc52237facda35d2d874fe1765bb4839275d8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090303-snowshoe-motivator-818f@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6efbc52237facda35d2d874fe1765bb4839275d8 Mon Sep 17 00:00:00 2001
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Date: Wed, 29 Jul 2026 14:46:02 +0900
Subject: [PATCH] nvme-tcp: fix host memory disclosure on R2T for a read
 command

nvme_tcp_handle_r2t() does not check the direction of the request the
R2T refers to. A malicious controller can send an R2T for a READ and
the host will answer it: nvme_tcp_setup_h2c_data_pdu() builds the
H2CData header and nvme_tcp_try_send_data() sends the request's data
buffer. That buffer is the READ destination, so its contents go to the
controller.

The command then completes normally and nothing is logged.

Against a test controller that answers every READ with an R2T, a 4096
byte buffered read returned all 4096 bytes, split over two R2Ts. The
pages contained stale kernel data, including an array of struct page
pointers.

Reject an R2T for a request that is not a write.

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Signed-off-by: Keith Busch <kbusch@kernel.org>

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 46c2acc6abe0..62c5e38f5207 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -779,6 +779,13 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	}
 	req = blk_mq_rq_to_pdu(rq);
 
+	if (unlikely(rq_data_dir(rq) != WRITE)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d unexpected r2t for a non-write command\n",
+			rq->tag);
+		return -EPROTO;
+	}
+
 	if (unlikely(!r2t_length)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"req %d r2t len is %u, probably a bug...\n",

