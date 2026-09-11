Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C820935F5E7
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 03:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789096291; cv=none; b=pEM7V8VGvc3DIwrHSuB/o0huYIfk9raICVYfiG1Mjakl29Bv0W+X4xUYkZigh92cvkEg0wwbcSaaytLl47TMn1BQcku6bw8gn3mV5P9cnV8nsH8M/GFWp7p0dPhtneKMnssKxCSMjzMSXmUoywqiWlx9kjIuc08EWndTHpvuY7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789096291; c=relaxed/simple;
	bh=IsH/uiXS6PCMYKUcTa6HJLyo15+CD5yZpyixAyCfD84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q/d9uf/gXdepHacezuHjD2SWiGx7Fs2LPusYlmK3gmEDETtDdCfRiD7+nui7WrEjmaxUQT8C/9gYoJ3Dq/buNgXtlWeVzU6osUBYrKMwCZLDJc00Lz/E06gJ+1OKLBB3qwoLQxdmFhiTo2LeqHUMtbKdcG0p2Wh2tP3kIoYQzvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgm6T8Kx; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgm6T8Kx"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9399a1c21c1so41761785a.3
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 20:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789096289; x=1789701089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W+7mpvDw1F56ZPu1ONqje79/4zvVptkv9Mg6Nl0mTjo=;
        b=dgm6T8KxbyCxESOM4r/q/CFHYw+ksIcv+MUJ3BZwIginVpvVqLvs+KULqtJcreG2o7
         /UdQXv36CbYJ8MwUmKKUJSOsU35ohzJ5onzRDnK1z6uojOhOWuYal6KhFvSGVIJmMDYn
         Bbapo5gb0sk05iUt/utI5HQO5Ah/vkZDoTsDbljbwMAvM+LZd/AcNcetPwy64WXgZw6z
         5ZjXrDI5fdOSEr2/mr9cvcNuD60AO4QvtDMxBB7fFdWRujCWC0xRJ3277xO+vFK1ciMX
         8KtmCCIcgcP2463cBXEl3ZHoQDutfsAxyFbaU5Vz3lYI/nbyA7Od91GKcmUuagGKfdcl
         3UGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789096289; x=1789701089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W+7mpvDw1F56ZPu1ONqje79/4zvVptkv9Mg6Nl0mTjo=;
        b=TkKzT3S0rfTTl0QxU3b/svp9tWRlCGYZqyIJ9OrMupvgzW9CabkJLr6AicUvq3vXTj
         +0G6nHTh2F7NfTuabG/ehWbQxfU799vWGkkdv1rgEyictBJ/hihcSyBBqQJ/EFP9+IiL
         vmjKJYUtt77zjpG9Jf441TEfmNWtgK03yIjl9CioS0+IaO4Ks9CIIsYQmTngCPrCIlNL
         ++8H2piBGNKfxTCU6kr6pOaGAG+nMs93/s4RWy0m1FvVQlBdqOefg86L2GhROVrmgMwV
         2RCtKfvA0KlPXpgYQIizxmiBmkrt8wiE3xooqVBAgbtDT67RMUVylqi1dzxGXILLQr4K
         cVeg==
X-Forwarded-Encrypted: i=1; AKwUvBynpaiZuGphJEqWi1Q8Mrrb5fsZIwP+RMZwrChuZunfwgCsnJDCrXNyAq6S675vHZGOuapgokM=@vger.kernel.org
X-Gm-Message-State: AFuF++klsv/m/tYwnVvr+o1rfE4PfcLcVP04FEglt7TAhvfjV/0qwz63
	HwIaSmc+EsD06kYKUBivHDCViTMIVfeFYYB8ZDwXDTuXh7km0+ttGuBPaldq/oWq4nc=
X-Gm-Gg: AYBFou1gCQ+jQGBCKeLVGoTA8sAbjq8xh8kKVTsedr6I5o7jubACufwaLmlj99OkrZN
	aNpTwljXDE1rjkChsmPAFrqh71uVmONQhw5uSdgj9WWpe6iUZJspKzu6oma/fWeiaKTCZ5p5Pi3
	FeYr1GLxsYrZ18CXuM7Rpa61cVfas2HeMWdVawFPl4ZS4zhVIkWpkJTJVn05W0xtuDdoefnHlgv
	1mL14GsEt/snBi6mzXf+CfXDmynewcCKdodYUPonTJCnB/YGIgncSfDTYbeNX0XMbU4/BPDCtod
	vMzycZqyUJzjkJWJ6PPdAvWw2vgfGNG1frkF8WTzr3gE686cxfnNy0FYynqSXVImjQZ2SxAprlX
	S1CM6BfkLVFP+tqox1va7bylKyu9OprSRxGiiHsfiusmhrEGDBVya17t9PrDVXmQEL1xQvBipJ4
	DPUJMn2VMmp2V+dafA422LLZzuN2VT6Lg150QIPxTJsSr8U0WCXVGP9l9Q4eg6cFWVF+uqVrTkC
	coWuxyihok9z2OIow==
X-Received: by 2002:a05:620a:1a08:b0:934:970a:beb2 with SMTP id af79cd13be357-939ea22a13cmr252005985a.26.1789096288727;
        Thu, 10 Sep 2026 20:11:28 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80bfc90sm136878085a.37.2026.09.10.20.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 20:11:28 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v1] ALSA: virtio: reset device before deleting virtqueues
Date: Thu, 10 Sep 2026 23:11:21 -0400
Message-ID: <20260911031121.1542502-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 sound/virtio/virtio_card.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index 647190f4d5afc..6f35276416fed 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -354,8 +354,8 @@ static void virtsnd_remove(struct virtio_device *vdev)
 	if (snd->card)
 		snd_card_free(snd->card);
 
-	vdev->config->del_vqs(vdev);
 	virtio_reset_device(vdev);
+	vdev->config->del_vqs(vdev);
 
 	for (i = 0; snd->substreams && i < snd->nsubstreams; ++i) {
 		struct virtio_pcm_substream *vss = &snd->substreams[i];
@@ -383,8 +383,8 @@ static int virtsnd_freeze(struct virtio_device *vdev)
 	virtsnd_disable_event_vq(snd);
 	virtsnd_ctl_msg_cancel_all(snd);
 
-	vdev->config->del_vqs(vdev);
 	virtio_reset_device(vdev);
+	vdev->config->del_vqs(vdev);
 
 	for (i = 0; i < snd->nsubstreams; ++i)
 		cancel_work_sync(&snd->substreams[i].elapsed_period);
-- 
2.43.0

