Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0000C541E75
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079563; cv=none; b=feO75QDa41fNKjNedJmyDUjPXfuTtv/RTviLkl85qolYdyNwHCwjqobph3QT4bO5UHZLMXQc1zQmvbjH+DPqET2daxVpl6p/dzkBtF/ihpIBQ2LpCFH1C4ESE/Rh95Ku8bpNs5vieVaFEHDZtRBs8xNJBJmMtHYzbiOQTfDPUd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079563; c=relaxed/simple;
	bh=/MuJ5pAgLPx5AGXTcLKgbKkc79oRvuvdapoNQg0snMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkKkLHzbZWDYeUVO0QpVdoDv10FFp8yI3g9MnTVH5cpvZCd48Bqv/WWSyMul5ezmBjop2TUJbe0DzZw8742R1ym5rg1FFrMOardtPs/GhfFIm/5lPuxEujzdn/Jtu2M2TSoQip4genuu8mIPoalU1ZFxj3OSGChsMhTXb7rW9aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUVTF9JT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUVTF9JT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207BD1F000FF;
	Tue, 22 Sep 2026 12:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790079561;
	bh=HJ3SYSi1M0IEtVjXTOBqvdf7nqbwoZQMAsGrLyGDjbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MUVTF9JTdY2Y9yPmSMcedv9IeVJDYbW4rXh/+7WBEUNIAO2CX19PWBWw8fyrNKeWB
	 TquSbhUc388AKmG3Dn7IyVB7fg3u5OkL2kAq3QJnYCZtJt0kRPc0vTgdIGIKGG66Ig
	 hGU4wBh4bwIIaHsx5z36reFRvqA0uodvv4DdDVGFLiL8gd8jRBqflpWG3/mDCelFIK
	 FDokdvAI/ffxv/I7D0/MHp2KY/42tDF43v6cYQ/uC57hWhvpz1O8oxl+1CpBM58hcw
	 0+w77AIVDEHpW2X4HICz7KbIMCsy3Lr/ZFlozzIrBagxSPWxAWgM/XQqQswBO12Q+z
	 dBOYl2LJfeO0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuho Choi <oss.patchbox@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ALSA: virtio: reset device before deleting virtqueues
Date: Tue, 22 Sep 2026 08:19:19 -0400
Message-ID: <20260922121919.2213829-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092204-startup-jelly-4cfd@gregkh>
References: <2026092204-startup-jelly-4cfd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuho Choi <oss.patchbox@gmail.com>

[ Upstream commit 6c05d00af307560e6a9f1631d6270d3df5aa2272 ]

virtsnd_remove() and virtsnd_freeze() delete the virtqueues before
resetting the device. del_vqs() frees the vring backing, but does not
provide a generic device quiesce operation. In particular, modern
virtio-pci keeps enabled queues active until the device is reset.

Reset the device before deleting the virtqueues so it can no longer
access the vring memory when that memory is released. This also covers
probe failures after DRIVER_OK, which unwind through virtsnd_remove().

Fixes: de3a9980d8c3 ("ALSA: virtio: add virtio sound driver")
Fixes: 575483e90a32 ("ALSA: virtio: introduce device suspend/resume support")
Cc: stable@vger.kernel.org
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
Link: https://patch.msgid.link/20260911031121.1542502-1-oss.patchbox@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ Replaced virtio_reset_device(vdev) calls with vdev->config->reset(vdev) for the older API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/virtio/virtio_card.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index 150ab3e37013e..1a4007c99c538 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -349,8 +349,8 @@ static void virtsnd_remove(struct virtio_device *vdev)
 	if (snd->card)
 		snd_card_free(snd->card);
 
-	vdev->config->del_vqs(vdev);
 	vdev->config->reset(vdev);
+	vdev->config->del_vqs(vdev);
 
 	for (i = 0; snd->substreams && i < snd->nsubstreams; ++i) {
 		struct virtio_pcm_substream *vss = &snd->substreams[i];
@@ -378,8 +378,8 @@ static int virtsnd_freeze(struct virtio_device *vdev)
 	virtsnd_disable_event_vq(snd);
 	virtsnd_ctl_msg_cancel_all(snd);
 
-	vdev->config->del_vqs(vdev);
 	vdev->config->reset(vdev);
+	vdev->config->del_vqs(vdev);
 
 	for (i = 0; i < snd->nsubstreams; ++i)
 		cancel_work_sync(&snd->substreams[i].elapsed_period);
-- 
2.53.0

