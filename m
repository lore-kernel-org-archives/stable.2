Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41502D738F
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 03:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792119763; cv=none; b=B3XhBXQQ1+PNZ1OkdtpZr5V/T48Z8PhPRtxkCSWf6pL61RE7f13IZImbUF1B8JadnUsE3xmNISML/vdzCHSgBW/On7ZJ/cJmzcGAelxoomHCL2FsRbQHRX2xqiJgddiNny1kd4oy+HTiydYnKEIYHAikQ4VZXwuaMEPQfVPZVLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792119763; c=relaxed/simple;
	bh=L2CSYq3mCoqIUn6oPxJeobbnJD5kXI5TuxiahJaHTFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fy8Wit6jpj5ahLCEF9n/eBY5srSV9I21nnocsRXhw7hvRFnCzUM3o7NL5HbyreeQRIpdCqOrUCFFMdwKFJHPA0llt1G+Rm0+bT1WcXolfeHV35j2MbE48zTMgJrTDzz3wWJkBmOxWxDpVzb+TzBbs/mD3J/t9TA88xrWwcduzBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klsEHlY6; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klsEHlY6"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53391786e55so96905871cf.2
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 20:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792119761; x=1792724561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s4D9yM14KvjVwR70sp6To7FJ7frrG/aute3zZt6nzPY=;
        b=klsEHlY6hJxsdb10Hz80kpuVCAljJEWLIbFLKLBMj3B/AUa2BE4IsR1lDQZhwIM9wQ
         MysNrG4TMY47JijxTpIgeuNWXgFw4JSu3X2rS8HOgznH5TmZoxz8stxcIIDdpI+uJz3D
         Hz0JO6QWtXKjffHnMWJ3DflXe6S9OrewHfOz8F/o+QULXWMZeobCunRJBhq9rKx8W9BU
         4kSVeDEAE0cUMNfxqpwoRlKpgEqUmAy0tm/NqUok050GTBSiohNAfO6t5OmcTZIBoEad
         Y1JNaAhbiNNb83gQCk+fNsYLRckVJDpRNlY/twozhEKGOcwLwxoWdsDzforFPdP27oVC
         Zm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792119761; x=1792724561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s4D9yM14KvjVwR70sp6To7FJ7frrG/aute3zZt6nzPY=;
        b=hE+umVKtwUDYoXQGPhLv5OKDli3OQgMhL3zO314RlgnDgeLVN4SONn2Kk7UOYTuaRO
         h+gZ4mzdhXuMypPBjLtD/fsf/Fu9ZFc0jtnRTp7X3cfSw+7P7BWuAgVOIi5NeokP8k9t
         wYN2mhjO82y13vq2cKPzIQQJ0oiOfLgmHZP9ayLw9/zzDsbGMhSnqX300RFS+4fWZ8iX
         SwogOi9N1LJ8Cj+aRmEuGSP5FO1ed4PihI0kbNwqZdJ1NLZtY6QN2Hb5yAIfCO4I3Xaj
         YNgD+5fYKSm04M0lJzH7LIdAm/zhGss9h8b+q/7EbkUXovu2L8+SR/X79YtZH3vSJeq8
         X7iQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/f1WvNOaYVZT3UlZPrA72bETBJ+Aply7mpQy8UPJ5XoZ1MDgooD8X7/AUSNA5Ks+p866Zvp0=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6kyQOTZdMrUOPQAmO3KogRUYUg6Rl246L6dCb1v4wvBRewlx8
	IxrZhBfyw22ib77ZvqcW1allzxdzP74CGjZmuB4oDRg8mAt9G7zjVdCWQG6vDw==
X-Gm-Gg: AYBFou14IGenkt6m46uQwyr3ufVCKOH61zgNpns/6I0iAUBzWo8dHgPW1aixeSEso9H
	1L+kfHLkf6RNG9xUaEPd1ZmYBBb2ZyCLKLSxNO0ytOnAirxYZOOGOgQRsQA9Y39tc7KVnSIOhbU
	JUUo1BjCIBwnwTB46NylKJJ/keKuTakfA2C2GjGJHVvdjI6kQDp6edY0fwxDPHZnA/GMHrk7qk7
	q2mS6yOGUf1nCtHWafbykHr4Bu6tdegGpF75StU76xpa2xINVZgBiKIVoksbbxpWLbfp1WKxWUj
	+ohQ4IWUQKKPsYo3N5JmFtJYWtBhAf5d/PLANfV0ElMnLeqoCvml25QMD31L0F69mEhMkp+rpjp
	VXT4QKxYTEiicNZLcYw8ulc112N811R3zezZBaRLquUTZUuLiHLT4fxOr0XumyOzbiX4R9w2kn4
	Zh+vow68Q+iMkZ3xrydLSNxOUpiXpztpJVqwYYXylsi3QzTpSc24o8TZ48LWpobEZPQLF5rtbKG
	aUxDfjYVrQPHPcdIaId5g==
X-Received: by 2002:ac8:5f4b:0:b0:533:43b1:5610 with SMTP id d75a77b69052e-5359fae165emr373990021cf.21.1792119761476;
        Thu, 15 Oct 2026 20:02:41 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362aa19a3asm10205701cf.24.2026.10.15.20.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:02:40 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Alexander Graf <graf@amazon.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] misc: nsm: reset device before deleting the virtqueue on removal
Date: Thu, 15 Oct 2026 23:02:03 -0400
Message-ID: <20261016030235.758830-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nsm_device_remove() deletes the virtqueue without resetting the device
first.  del_vqs() frees the vring backing, but does not provide a generic
device quiesce operation.  In particular, modern virtio-pci keeps enabled
queues active until the device is reset, so the device can still access
the vring memory after it has been released.

It also leaves the device status at DRIVER_OK, so unbinding the driver
trips the WARN_ON_ONCE() in virtio_dev_remove() that checks the driver
has reset the device.

Reset the device before deleting the virtqueue.

Fixes: b9873755a6c8 ("misc: Add Nitro Secure Module driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 drivers/misc/nsm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/nsm.c b/drivers/misc/nsm.c
index a3a9f9bfc6b7..7193dfc4343b 100644
--- a/drivers/misc/nsm.c
+++ b/drivers/misc/nsm.c
@@ -483,6 +483,7 @@ static void nsm_device_remove(struct virtio_device *vdev)
 
 	hwrng_unregister(&nsm->hwrng);
 
+	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
 	misc_deregister(&nsm->misc);
 }

base-commit: 2f2f7eeef8b0a1a9b9ca998231419873ccae8d4e
-- 
2.43.0

