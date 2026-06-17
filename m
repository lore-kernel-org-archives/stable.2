Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1864645BD5F
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781709885; cv=none; b=OJOWxWSuY04MkS+/xLSwsYa88h8ZNR0ApXrv6zLDckw72AaXfPeVIdjRPRkaX2ZVFGs+/gLB6KukAOVcid2e1Z+7R1h+x0mIE+7YM96gb3jsaq/jQn2TjSXkUz5jPcFSEwpjI7mpqkbioHUJoSUn9y0TEFHV2SaOa64xJAvGif0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781709885; c=relaxed/simple;
	bh=K6BdhynNCxTbKte0oto9qXNQxgiuj197Vq3cvTizjVg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CjTdwtk6fVBxKqc3KGnfgbMdbxbLTxDgddzGKy7DQSMHq3pFoN5W6snNNojCaBsmdADYN3uCm+xm9ZBdy+oaeI4LlnmcSvZHZ09JY3KKd/MzFFOzbqJ93Me5hM9Y7Qd3VkFFJNrDeEyLvOwfsooT33YcXxHuLY3oFJ5+wqjuANs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CXz0HYJt; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CXz0HYJt"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781709882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/1YITrhnDXSdmC6Dqv+F70YQc0TGd3NsGsm13gGEdTo=;
	b=CXz0HYJtk190U/sx4Wh+h4WEdBGdG8kvRojZHqmHkrTL30R7QlpHwmdrAsFAW9WWyEcG3T
	xGW691kNb7opYYX3Y+JvQqZ5VHE0g2iA4DLyV48lj0qNtPMa65C7+NHBF2TVXeQyBMtsYO
	wRgsOTWWDN/7rLn2rG4eCwvWJBfqSqg=
From: wen.yang@linux.dev
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepak Kumar Singh <quic_deesin@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 6.1] rpmsg: char: Add lock to avoid race when rpmsg device is released
Date: Wed, 17 Jun 2026 23:24:18 +0800
Message-Id: <20260617152418.7046-1-wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Deepak Kumar Singh <quic_deesin@quicinc.com>

commit 17b88a2050e9d1f89a53562f2adb709a8959e763 upstream.

When remote host goes down glink char device channel is freed and
associated rpdev is destroyed through rpmsg_chrdev_eptdev_destroy(),
At the same time user space apps can still try to open/poll rpmsg
char device which will result in calling rpmsg_create_ept()/rpmsg_poll().
These functions will try to reference rpdev which has already been freed
through rpmsg_chrdev_eptdev_destroy().

File operation functions and device removal function must be protected
with lock. This patch adds existing ept lock in remove function as well.

Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/1663584840-15762-2-git-send-email-quic_deesin@quicinc.com
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 drivers/rpmsg/rpmsg_char.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index 3e0b8f3496ed..a271fceb16f4 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -75,6 +75,7 @@ int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data)
 	struct rpmsg_eptdev *eptdev = dev_to_eptdev(dev);
 
 	mutex_lock(&eptdev->ept_lock);
+	eptdev->rpdev = NULL;
 	if (eptdev->ept) {
 		/* The default endpoint is released by the rpmsg core */
 		if (!eptdev->default_ept)
@@ -128,6 +129,11 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
 		return -EBUSY;
 	}
 
+	if (!eptdev->rpdev) {
+		mutex_unlock(&eptdev->ept_lock);
+		return -ENETRESET;
+	}
+
 	get_device(dev);
 
 	/*
@@ -279,7 +285,9 @@ static __poll_t rpmsg_eptdev_poll(struct file *filp, poll_table *wait)
 	if (!skb_queue_empty(&eptdev->queue))
 		mask |= EPOLLIN | EPOLLRDNORM;
 
+	mutex_lock(&eptdev->ept_lock);
 	mask |= rpmsg_poll(eptdev->ept, filp, wait);
+	mutex_unlock(&eptdev->ept_lock);
 
 	return mask;
 }
-- 
2.34.1

