Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794200001;
	b=J8SM5KCCJMVFlPevX++JtwR/BzM4wtpqUPkMl9f9Vs2ilA8Odio/4D6GyZu5Bz3VcTuh
	 o907cZCAXf1LA/5hTpWAJ1CvS4zXnNkTzWXouyT073KmWsyFav29RQauj/yyZzFPPPuai
	 io5CWZx/IbPg4Yw01BcBYmhmf1DHSnaUTDbA+cIixQSL6oWvYGndvDmkUYVv9hwMyVauj
	 YvtDC0UEWzvxxU8rj84Sxff8NWixEeVH3Yi62tmTrTyEBOrDbpM9UmsFUO6Kuf0A1rlzh
	 SGrIcDFUSf3QXJyHeMX2OzVQzKSTu0KWzEQ39p5vzNiwkJmJCFUa+55Jk2msfsRXThw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794200001;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OVPWR8szOHg1B5tabceM6OrLtjIwXl1TZU2e2aNbhqg=;
	b=IKz+rc1BZuCxHZCtw1jeipU93iGRemX8Yo+K3zY+ZteqAuk24ENTgqu3fQ/sTUiQ1TPE
	 REa9GaCmf4VuS/CNiXaIBPlWUHfKwzuOroYlMDm6oIVTnmclPunCMgcPqzQnGdCxxhPh+
	 iuLpBHjxihcQy24zMEYZn40MB4iFQ/S33NdScA/vOGpaii25k75D1R46bUQCeOQ3OXWyN
	 YI3dOmjFwc7haFfc+aFJWtlpkTfGTsG06T08Q6Y2CzA3MQPzuDqQAbrvATdjKM4KVHs+d
	 2JM1HlYBAo2lpYWcxwQQXEM4IUkMo47WHAIqU2RHDDOOs5slyLr1vZ4/teSd2qSOi4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qY16YHLa;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BAE606A322
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 04:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1BAE606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qY16YHLa
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so983513eec.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 20:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794200000; x=1794804800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OVPWR8szOHg1B5tabceM6OrLtjIwXl1TZU2e2aNbhqg=;
        b=qY16YHLaYcsSGtQaIHBGRxDeitfflTbWSp5Fg/cztpz7NzD9mnVKzqH1b5OUQZa8aX
         69S1+iA33pi9iwO6mVSLtiRWYlwek60/xHCieXiR84UowCyP84KsBIqoW+YV6Rj4xf3F
         zJYu4QTJ/iDEHLq3MxUw+pcnhP6hGsx7tKN+ua+TprgS1T7F6m6VkDk64IvrxT+nnT/y
         Lz+IRCAK8dMgqR5zf1Hfgm510Cuur0f8/CO1+3iKBrzTdilakBAsGtJ0xJNXqTYcSRzJ
         pyrr5t0uoA728okiY8D7sUXje4KiXpgR8eJNE5vhSUvbJ7FVIJPpg+SHrxpdRfVYLfVf
         +oRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794200000; x=1794804800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OVPWR8szOHg1B5tabceM6OrLtjIwXl1TZU2e2aNbhqg=;
        b=IW4biCL0zELubDG+000dVxl2NsPsOok1Y+sRJXQnUeAFMtIvHw4Hnk18davMGngfCN
         Htl55romCCh8toYQotJ7N+Jntew7n8/6DtNqUfFhd0ARC7nk2gkD2evQMT3d+7VvbeDV
         8sVJ1nHFP3yg/o01aRt5C7SGNiBfFaF04Mf89WeeGUqzUkP0WnxuuZT1VxFHDtFA6LGB
         H+MW1VkJF1uNdz2rLVv0T5z+vE8vKqvD1ozcD4MxCQAtHMoz/R2bo4hrUAEZudbV4K3t
         +YRNoEPbIEVOa2gN+6pC30el/nUwKe35MjSByWRC97M31qA8N5q1WcL+KYeqPM1IOUMe
         QISA==
X-Forwarded-Encrypted: i=1; AL+hErGjIi/XCawyQrMUs8+oo33qTvW/HqAlgvAbNDiHazbX9jP2Hu+V8gGfeOIqqc6two1hLQb0RTc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9MKNbcz0dJwF5xwLBtSl0WBxnQ5iFsurrEu2lvRJ5T/DA8pHem
	SrmM2blKR7OEXe7OUUpwbQv/OIG+KCFKmgwkvsR9j8F1E1LYTOtWHilR
X-Gm-Gg: AYBFou2pmEF+AZ91+ehTWjx1eW86cVHBrhZtes3cudr/7QZhA8O4U9pciKP5fJCSP4L
	HCTHAaTyDOzsEm5PiV9YgH15QocrrUmui2q++J+Z6EaSos953rrQe7MIPQbiof/aqIpsu4xhbYV
	JiQc6rPwqmlIoxcNQ0VZeQdeDNv7lFs1IxOOzSFsvCGrVXakffKFH4f/o9VK1Nd2rBf19Xn5xJ3
	xLncOg1ait9NWij8Z/SS7uSjS4SdHepUuQpUFy35LZoYcVD6RWYolBt7SAagAKCZXSM9h34QuqT
	Yz31osUBxkOiJUoe7lTpA0+vfFCClyh7ICoKNFRrITHTABFIxo3kl4IFzcSvtGlb8iGHL/pNrMl
	+14ipw3/ftRlcdvSUhX7pBSk3Vi3XWPhksum9pca7wuYgHmc8jxqritJG9PWZtF6W7/3u/VX19q
	axh61mAtsZz5zJScIyPttm/yGzFIPV1HPknWYgrjyhMyznegfggm2VmXjs9Sk/SjBUWvaWQXb61
	EM9koV4eaiS87DT8ufGkF4NeSz6CpLUHj/E/9F9qcaPhR/kUJx9y7dvGhoYsF7zPzW2lT401T23
	MZ9AW48asm6lZbamChSz6JjUivwkMq7+PhP3cz3k5dalTM/KF46ry+FnzkSFhzTf7wL+lw==
X-Received: by 2002:a05:701b:2506:b0:176:a225:e364 with SMTP id a92af1059eb24-1b39febea9emr4982230c88.35.1794199999858;
        Sun, 08 Nov 2026 20:53:19 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3755e8838sm8409707c88.8.2026.11.08.20.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 20:53:19 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Martin Tuma <martin.tuma@digiteqautomotive.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] media: mgb4: cancel err_work on teardown to avoid use-after-free
Date: Mon,  9 Nov 2026 13:53:07 +0900
Message-ID: <20261109045307.1167784-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyunjung Ko <hj351016@gmail.com>

The err IRQ handler (err_handler) schedules vindev->err_work
(signal_change), which dereferences vindev (vindev->mgbdev, vindev->vdev,
vindev->queue). mgb4_vin_free() disables and frees the err IRQ, so no new
err_work is scheduled, but it never cancels an err_work that was already
queued by the last interrupt before kfree(vindev). As err_work runs on
the system workqueue with no timing bound, it can execute after vindev is
freed, dereferencing freed memory -- a use-after-free.

Cancel err_work after the interrupts are freed (so it cannot be
re-queued) and before vindev is freed, mirroring the existing
cancel_work_sync(&vindev->dma_work) in stop_streaming().

Fixes: 0ab13674a9bd ("media: pci: mgb4: Added Digiteq Automotive MGB4 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/media/pci/mgb4/mgb4_vin.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/pci/mgb4/mgb4_vin.c b/drivers/media/pci/mgb4/mgb4_vin.c
index b247854..64b7a9b 100644
--- a/drivers/media/pci/mgb4/mgb4_vin.c
+++ b/drivers/media/pci/mgb4/mgb4_vin.c
@@ -1068,6 +1068,8 @@ void mgb4_vin_free(struct mgb4_vin_dev *vindev)
 	free_irq(vin_irq, vindev);
 	free_irq(err_irq, vindev);
 
+	cancel_work_sync(&vindev->err_work);
+
 	device_remove_groups(&vindev->vdev.dev, module_groups(vindev->mgbdev));
 
 	mgb4_i2c_free(&vindev->deser);
-- 
2.43.0

