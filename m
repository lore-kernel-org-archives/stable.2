Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E300D5695
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 03:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786418885; cv=none; b=Gn9HgFoh6ED9uG0qY5vP4+Z5LpISnDe+ThApSz/wJGWhchtyaBdJf9v36OMnN3wISjUoOkBr3fOcjdRxJ5KrIsNqih8m/ZyuI8sh4oYxXZWhOQguyn07MiLX9t6E0eLLv1S/2P74Sc5ff4jA2I9dMtjUFxhBUq/yU0VI39NOq1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786418885; c=relaxed/simple;
	bh=NAEBUQQ2AUnEn6xuldI9PfMUSZtDCVv6anOxeEpm3Y0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GZtbpUxLZ7GvA4AcLlxHDEPhuEM93F0gv72kpP0FzmFvOJtz9CTcQfVCzzVJzQHk0E1XecwjWft28EwLW08jqlPOKOSnH8iWUIyFAioCLyEzR1sZ8prWlCuMEsNVlEVoLMXL24gZNQRUE9dGmL769+CJeJ7Dvkw/SWheTP5yCdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rEfg5VHa; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rEfg5VHa"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786418880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U8JLY3isdF3184j5qDWC92G4CjVW3t6zd0a3jfPW79E=;
	b=rEfg5VHa53FA4Mc7/XKF2zQdPMj6EIirDjTrxaqnguqqE3SEzOBOC78ePolhuNStZW5AR/
	uNRFwTI3wjlUmXfUWPz15oDX3lw8ruchMnUSn0Qtuj+xSD/S+36D8cdgGbsGUzk+E2pWwY
	0XJpJS521pk5ulS+2rFwFKC2nYCFbfM=
From: Yi Cong <cong.yi@linux.dev>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	stable@vger.kernel.org,
	Yi Cong <yicong@kylinos.cn>
Subject: [PATCH 1/2] Bluetooth: virtio_bt: fix leak of vbt on virtio_find_vqs failure
Date: Tue, 11 Aug 2026 11:27:01 +0800
Message-Id: <20260811032702.67908-2-cong.yi@linux.dev>
In-Reply-To: <20260811032702.67908-1-cong.yi@linux.dev>
References: <20260811032702.67908-1-cong.yi@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Yi Cong <yicong@kylinos.cn>

If virtio_find_vqs() fails, the function returns without freeing the
allocated 'vbt' or clearing 'vdev->priv'.  Add a 'free_priv' label to
release them, and let 'failed' fall through to it.

Fixes: afd2daa26c7a ("Bluetooth: Add support for virtio transport driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 drivers/bluetooth/virtio_bt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index c20d54088c8c4..b674fe0c2779e 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -315,7 +315,7 @@ static int virtbt_probe(struct virtio_device *vdev)
 
 	err = virtio_find_vqs(vdev, VIRTBT_NUM_VQS, vbt->vqs, vqs_info, NULL);
 	if (err)
-		return err;
+		goto free_priv;
 
 	hdev = hci_alloc_dev();
 	if (!hdev) {
@@ -404,6 +404,9 @@ static int virtbt_probe(struct virtio_device *vdev)
 	hci_free_dev(hdev);
 failed:
 	vdev->config->del_vqs(vdev);
+free_priv:
+	vdev->priv = NULL;
+	kfree(vbt);
 	return err;
 }
 
-- 
2.25.1

