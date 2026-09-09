Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F191A49E5EF
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940977; cv=none; b=dTAaRFacJ9IzKuFbBNOfr/Sd2s8l42J5oPc73B0ztq8P/k/0H83ESikzDw/OYrqO18qE3gt9fkAKDcq3VlbXVVCCpeyFI2EaqvN2I7tfd167CVkvldy7FvaivjyoVnP6qS8xtNLgnSdL2uZb3O6MK37VPAsZL5lIlqXSQQnjTe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940977; c=relaxed/simple;
	bh=/m0RpJ0u8S5AhBcgXm1RmBFb5U3snGeLm8WGcbiID5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gg9z3pXvqFpMFkboe00ULh97x8lEhmcXQQXr4MJPz4cfoQCecGqFh3PNuAhN+5/nfb9e9UWql1MM/5wQOssDbgAKbbHH1Pd54hByABZaKHpPxApqprnxYC81s9Ipdocm4YmrT38vYO77S541/8OARdyOQCCSF3k7NfV9oXYFI1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1GlQuqd; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1GlQuqd"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49ccfae359fso47949435e9.3
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 01:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788940974; x=1789545774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aVDpspAXsp3IRqO0vAB8A/WjYsXTyisUBY8DG2eZLy8=;
        b=A1GlQuqdfGVUGWy8D+0ghB1MHVrUG8KPVFumA5pVVLslWymUDszMXEJYDEKNdzSYO5
         +LVUIOjoRjwlb3Fib2F0f61oJpYWJgVbmzlBlIbBOXvoFWs1llrFpPrZOHNfppHH3X+a
         mRaR45Tu8oq5AKYn3VjKjESQuGwXlDDH5S7q3Ka5ZUBqQuMRj2p4YR1+i8hnLP8kXhXI
         RNT2zothJms6GhYcMHbJlvb4/2Rlh+2WeFwV1vrkA1RJbh3pW1Ndfy5KONxiY3WeWeuB
         o7QmrqKZ2XtCBL+IZss0sPB7braGfJaSi8Vu64j4R1NW4WbMKyFw37L6tzR2oN+2fNYZ
         7IWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788940974; x=1789545774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aVDpspAXsp3IRqO0vAB8A/WjYsXTyisUBY8DG2eZLy8=;
        b=QmVpTPnX4MQ9cyyNh8fg9Tirulo2WJjHwjkjM9RcJoCOqac7DfvvEM5IbYBp8HgPvg
         2QgxS6uAMi/GSkMY0mHQNdTVud1/kKQozl8U5w8ek+XJnAJCAOoLIP/tYhjJtIp2bQxs
         RidPVt7bV2+sy3ThoLw44RMGNXGHlfuht+naM/ek3wIhxiaPM1spOcwRpqmU6hM1R7IN
         nd6vF2+VRsKn1VNFwSlEZcmfsHhVT8v+lyshWPKrcVJvPYN4dzGEB71rYx5Duud3w4Xr
         PhszdExEHqyzjQs1/CMUpzyq7jdyyzlW2dcoaC9rHIug57Q2FW7wUouuo8HnDoMgRCeS
         awnw==
X-Forwarded-Encrypted: i=1; AKwUvBz2unkNBXfpiPyqPuYT/r4dHzqY4tiF/vkBgWaGABl+utsBQtBO2tIbDWT7Y/4KdOMg5lBvx8E=@vger.kernel.org
X-Gm-Message-State: AFuF++mOyMF3C2vdBRmJaQFBZNR1JoKp7iX40PuoivVzYSEI7jNQ+TOI
	bruRJXOitxUmY2iqe5knt5TNVGAkwfL9TV0AOYnbHVMlwqxsi9zVoV/Y
X-Gm-Gg: AYBFou02EOuuie68IOK72bjk8xNnGkvdkwzxcXLInLqWaBf5JWKPJrOmqGA4unFkoDM
	SljYNpbIOrcnuZXgq8ywMvX6VvcIylxoDK8gPm6IySU98i33Rzj5OW+ayDL8S5YX7LAi1/gRWom
	zfk3+JezZpRU3OuIVL6BR57monwTMqoxM+GYRh9ebplqispX7aXGgtM9DatTuOozRfZH0D3k/Sx
	Wpk7DmgnRJB4gNeRX9kNr2Q3ypeeWZclZL6bp7SoEgwpi6IosXwfcEBMJErcFzq48vzCIYDziOP
	ZqZWcEzt39Ca8P/tGMhFgv/V8GH33V/Shqg8bv0UxgjEuSyJ4Ck0ehQLz+s1U/YDWnV277PQ7CC
	B39VKLHOdqM5bBsRYHx0uTY3QocQ2w34ycuhb/jG9k1sVVTSrQm/qDLuAbboqN8lSig4tOGnfe3
	1EbeaJjwdzEyUAL2dVoaQZV2xCWw59Ni+iY+l74Q7LUJm6Lvcqpy3tGaeRF9S3EcgH0jXqGY4dj
	RqMnAKM1B+yFU2/YgY4Yw+HBQE0Upda
X-Received: by 2002:a05:600c:3b9e:b0:49c:fc6c:be1a with SMTP id 5b1f17b1804b1-49cfc6cc121mr298320835e9.32.1788940974059;
        Wed, 09 Sep 2026 01:02:54 -0700 (PDT)
Received: from chubuchnyi-ThinkPad-P1-Gen-4i.lan ([158.173.155.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfd3f8192sm412817125e9.3.2026.09.09.01.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 01:02:53 -0700 (PDT)
From: Aleksandr Chubuchnyi <chubuchnyi@gmail.com>
To: sakari.ailus@linux.intel.com,
	laurent.pinchart@ideasonboard.com,
	mchehab@kernel.org,
	mani@kernel.org,
	michael.riesch@collabora.com,
	jacopo.mondi@ideasonboard.com,
	nicholas@rothemail.net,
	benjamin.mugnier@foss.st.com,
	sylvain.petinot@foss.st.com
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 4/5] media: i2c: ov8858: Add missing v4l2_subdev_cleanup() call
Date: Wed,  9 Sep 2026 11:02:26 +0300
Message-ID: <388522f369605158e040af66390a2a518f3e38a2.1788940469.git.chubuchnyi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788940469.git.chubuchnyi@gmail.com>
References: <cover.1788940469.git.chubuchnyi@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The subdev active state allocated by v4l2_subdev_init_finalize() is leaked
on unbind. The driver has no common cleanup helper, so update both sites.

Fixes: e14d3ac81bd2 ("media: i2c: Add driver for OmniVision OV8858")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Chubuchnyi <chubuchnyi@gmail.com>
---
 drivers/media/i2c/ov8858.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/i2c/ov8858.c b/drivers/media/i2c/ov8858.c
index 3f45f7fab..2076620c7 100644
--- a/drivers/media/i2c/ov8858.c
+++ b/drivers/media/i2c/ov8858.c
@@ -1953,6 +1953,7 @@ static int ov8858_probe(struct i2c_client *client)
 	pm_runtime_put_noidle(dev);
 	ov8858_power_off(ov8858);
 err_clean_entity:
+	v4l2_subdev_cleanup(sd);
 	media_entity_cleanup(&sd->entity);
 err_free_handler:
 	v4l2_ctrl_handler_free(&ov8858->ctrl_handler);
@@ -1966,6 +1967,7 @@ static void ov8858_remove(struct i2c_client *client)
 	struct ov8858 *ov8858 = sd_to_ov8858(sd);
 
 	v4l2_async_unregister_subdev(sd);
+	v4l2_subdev_cleanup(sd);
 	media_entity_cleanup(&sd->entity);
 	v4l2_ctrl_handler_free(&ov8858->ctrl_handler);
 
-- 
2.43.0

