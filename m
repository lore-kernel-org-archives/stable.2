Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3A63909B3
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 05:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790053380; cv=none; b=YlxHZED405gmosaCkrGaR2bD2gmMPITfk6fvFsLBDgcvkBmGZocPuLA4J4OAUTrTT6IQH1HI16RmDgh8r762HDgeasgKHhRk/9EHCToSEgY0g8ZxOZfsj0aNFNePb/B7eSHpGDMDzTXru9WMdipuD6uki1wKRHPeVw+Ms02PLp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790053380; c=relaxed/simple;
	bh=lYFM2icJd9dTPDzF6woXYA1zRrS4VpaQ8uxQMpGJe7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HFuf0M3gLdaBusfKfl2hjS54EV1s78SgaDN8pxI/XQjUlZkjMp848fMhWnMbR6OdK4elv34wkpjzCSIljGswASgsqCMBWLzrRM8yG7DlrPfa8KqHDrXZOWR1Nb6DOFjeqf8fED5FBQXe03AB+7rEkw/f1R0R55mhP3usfjy2zK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIJi/p5l; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIJi/p5l"
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-939109f067fso480908385a.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 22:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790053378; x=1790658178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Ara9sJRSL0sr/3H6tA1EEPm7uyc4h6klL0iWIcKZUA=;
        b=mIJi/p5l9/1m4K6tUJpfb+IrGVP4mX+OMFLejJ9+ER7FnS3cf3oqF6Pe2/5WE1pcpy
         sCG8OnKQVbRffQ+TcgqZ1zx8haYCDQ2mgtQo5zvf6lxCu2SeGaBIdY+NRUuBPu8uqaDB
         2+ykFB6ZNsCoCCFCQ5ZJv6sitPhuE1oHO8KHy8zcEJ3Uv1geIMZ8bzjnQ9313mwekc/j
         vxnXZfdNFtD1GZHmWFVC/l+GcfYlBcEdb665ezVOj5pPfMYdFw6tu1HU/EAaxDGWAZyU
         xIOz9m/k7YD/lX+5uYm6P+bwgU1Poj9Hjfv0/fGmyo2p0SNmCm5mc0xdcc2U2Ef6ZLiZ
         q61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790053378; x=1790658178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Ara9sJRSL0sr/3H6tA1EEPm7uyc4h6klL0iWIcKZUA=;
        b=iCQQlM2TP6/gpIMQZEbqeayQsF4jVNUjaNNiYQENfbHGHDq/Yditi5Pj5BBSlK54Eh
         bZJnnecPMG5Y4XZzt9lvGOBM8j1c6AZpNyWcthfyU0k98IdDuzR2vDxSaJ66645xO+O5
         z541eHScdBeqzyeeCtEZGOvCsMiauCiYBGWwQqHGY5UBUcC3bhcpaixaEiwYpQWmx5WP
         qi29ZSNCMjQuttNxUKd/VEs+3EI427k9Qju3ohV3xyK1J0XzMQIAYf5c+Ay0c/EHsOsv
         5msbc5CyTc3QikuMsX0uV6KWR5W8mM+Id8knIO7DS2qurKI4DcU/zdoTvSz/eQGcjGND
         /VNQ==
X-Forwarded-Encrypted: i=1; AKwUvBwuO6PW/mkWLEP0goizl7HZvtyJHrHUGJFGJznSPjP7qsmNBiWcXl04FXCf4YnEJC82EnZ3TzE=@vger.kernel.org
X-Gm-Message-State: AFuF++lWW6NKWKazzm2Ks7pXtVGAcTiahhwdI8pbKyQKEVPTmhKgS78O
	Twk3DK2QeXXGuEVGBOs4mNKBzyU/J7mpXgRR5UJRJUp0Df7zkRz5blt4I4GOR+0v
X-Gm-Gg: AYBFou318vUrqdylG/PAYW5pKMS9iGmMKheqNEo4irsoA4vbHptVQtVnJIO9tiqEFaY
	VthFp9UVT+HQ4E6UcZUiFBR3Z1O8rgq4l5Opj/wVrb3aORCqut6y3u9Oj3u7UXG7OksF5PaaQKM
	73SMNS/jvx60X294RIcO11ZMlsnvhgxmJCeM4Yh06a4hbrohbjxT2xuqchNCKAwE0VbuECCz44z
	RBTLdHzjxLl8jjtimwzC9S3MLkLFRn9VhIUHOpVD9H63bYi3sgX1Tt8eZH9dPfRr8xQ8jxMmQ3g
	77M/NBit4zMfkucRFtbL5FiWVGHcBQAQy5ufCowOqeXN6+zQ1t6UajCPEh1mwz8puyv2NGiwNGG
	eeRIF4Ui7Ead+b4o+3MYs047w+s3lLlA7NsXMTyHCConNjt8TCJtfP2RVXGrPjgZqTLidAfUqGu
	F9XDW8Flmrvb98ptOdOivlq8JUbXmUBMNhtxvgdQgQCnt5WkmtV8JzWzwTAj5mczFgOvVze3J7N
	KeabDvdV0YNJ3jkAB84mg==
X-Received: by 2002:a05:620a:6006:b0:93b:d79f:d955 with SMTP id af79cd13be357-93c15f2e6e5mr372386185a.74.1790053378323;
        Mon, 21 Sep 2026 22:02:58 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c1d18948esm48202285a.23.2026.09.21.22.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 22:02:58 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: "Chen, Jian Jun" <jian.jun.chen@intel.com>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	linux-i2c@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] Revert "i2c: virtio: Avoid hang by using interruptible completion wait"
Date: Tue, 22 Sep 2026 01:02:51 -0400
Message-ID: <20260922050251.403857-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit a663b3c47ab10f66130818cf94eb59c971541c3f.

When a transfer is interrupted by a signal, virtio_i2c_complete_reqs()
stops waiting for the remaining requests and virtio_i2c_xfer() frees the
reqs array while the virtqueue descriptors are still in flight on the
device.  The backend can then write into freed memory, and
virtio_i2c_msg_done() calls complete() on already-freed requests.

Commit 84e1d0bf1d71 ("i2c: virtio: disable timeout handling") removed the
exact same failure mode caused by timeouts, concluding there was no simple
fix because the buffers must be held until the device returns them.  A hang
due to an unresponsive backend is preferable to guest memory corruption.
Restore the unconditional wait until request lifetime can be decoupled
safely.

Fixes: a663b3c47ab1 ("i2c: virtio: Avoid hang by using interruptible completion wait")
Cc: stable@vger.kernel.org
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
A proper interruptible wait requires refcounting requests and bounce
buffering to hold memory until the backend returns descriptors (similar
to virtio_rtc/virtio_pmem). Since that is a larger rework unsuitable for
stable, revert to uninterruptible wait first.

 drivers/i2c/busses/i2c-virtio.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
index 5da6fef92bec3..581e55b5c65ba 100644
--- a/drivers/i2c/busses/i2c-virtio.c
+++ b/drivers/i2c/busses/i2c-virtio.c
@@ -116,16 +116,15 @@ static int virtio_i2c_complete_reqs(struct virtqueue *vq,
 	for (i = 0; i < num; i++) {
 		struct virtio_i2c_req *req = &reqs[i];
 
-		if (!failed) {
-			if (wait_for_completion_interruptible(&req->completion))
-				failed = true;
-			else if (req->in_hdr.status != VIRTIO_I2C_MSG_OK)
-				failed = true;
-			else
-				j++;
-		}
+		wait_for_completion(&req->completion);
+
+		if (!failed && req->in_hdr.status != VIRTIO_I2C_MSG_OK)
+			failed = true;
 
 		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
+
+		if (!failed)
+			j++;
 	}
 
 	return j;

base-commit: f0100363d8c374bd8e9ea7c9ba02744f0b802ca4
-- 
2.43.0

