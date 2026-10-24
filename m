Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792809659;
	b=HnSyIRGMVZxH918nhs98jEjzSO5lRmRVDhOfjA4i7lWTNjHQV5ouC+wRzH4V8l83jfnN
	 weuQmsYX+cbkhkIkl5IrcZbzRQGgVMTaZCw/epoIGFSfchIuoZdjt2W1jQ2ZpzOBZ74Vr
	 Kh51G2PJTRpGBcc1qGW0UBFdIGeXbxVzIHEBBYqgF4wkNoJrAg+u3b8wS5YKpIVsjDoet
	 2FFF/OQ2WEB/7IGdyGOiOFZpK0HrZiEVgONfhLx+/lj0nzbK9ammFrC6c8UkeAJ6HweCp
	 ylTvQ4tmzL4rkPxyLhqQz2C72znwaxsySRaQG5bZ1V6jrvvMGd4aKVqwl0g0O97P00Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792809659;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dyxLFL3v3aOd1FtHeGOANRa81M315sVflTjGuyXXt9k=;
	b=pIqmL/uZoGhnN/HPbSwGRcGLaJ7bnWckzVsnbL17zJce0HktiQ39E81pWmXZo2NcFKIF
	 gjowu6vJeYqo0vSgFw4svJHM95LwDVo5/vnX2Awyue/PeB29COGubVRnSOmFiNLAwP6d1
	 z7xUdaJSTcfAZRp9PcwagOS3oLVHsioC9/7B61kf0C+L/pk8+OnMQtvxxujFaL89dH7fh
	 Ejn31nt7cxezAlysbiWPMY/41t/yUiNmMy1ysy3iTWbQ8C24o76+5pD0UWkM+plO8TeEN
	 QAqblyeta5s7ATcgYQtl4l8R2UkhzVLHEm6wwbWesPoRKAnPC+GAQ1H9cGy8xOKRe5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b1jx1KTN;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528D9606A31B
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 02:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 528D9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b1jx1KTN
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91b9e758c50so18845216d6.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 19:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792809658; x=1793414458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dyxLFL3v3aOd1FtHeGOANRa81M315sVflTjGuyXXt9k=;
        b=b1jx1KTNxpYtk0D26oCx4jhvPEk0vYhRmZpnl5znUQg3qNFXmRrBjJntRKJJkfCVd1
         2FUP06UB8zo808hn+ke+HEmT7VKYpChDPP4k25cPQqi3apwjTmsXZLyIDzjo3atPyzKv
         t+5oLTjVY4ZQbtq+fpS8jBEfXV/SL7vMIMNhNnBn4BKwC59MO0zyA28u1heY1u5bpY0B
         Wc4qiqBYIUTmpfOrrx/lbiUihMi9lZnExf45fzvqXsIPXEkXWn90UgAGC1wn68+cP0Rm
         0QWgpcYEc+7/0FuxPVsPe92Mjk8lqo9J8OdFoXhFgOOJZj6BJAhykZ42RJcld0v0MZru
         JOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792809658; x=1793414458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dyxLFL3v3aOd1FtHeGOANRa81M315sVflTjGuyXXt9k=;
        b=19Nm1g7jo1lvrG2th6y9R/v2AMqBQ6HvnAKRubY/fSlVfKfepF/yiggVJIupnekMgD
         h8upFhlybsED2oZOk+Z0X99rLxkKYNCoRsVA4pt9yw9guguEX1oh4bbIAhvsZPRDM8TG
         kxJmv8SWSlnhT9/lNPuxgy9Zu4/1NxbeypmtCmreBn2kQOvNJBvprYFqWfQU8qXnncIe
         XFpK0Sp9H813WfVGLyCSzXNLUi07LSnEfFR9o1nH6dG8XpKYozXv+0GMBGYyuLR07yhk
         vxOkyYcSBlOy4dYLUOvFW9rHJ+vFZZubK8oEwMpU/UNOQUa5djqGeRMy1JkthlIbEhVo
         MRvQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJR9dDeFHxtbOx9Aig4wMEZ1Z5AIxSzpxFsLcUhb21kVFzBiE0HkoaSbEQMNcWB2H9Upe2Vpk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZszn031ZrujyhDZbQm3iLV6XIfIjcuPmYQBtXfxjugteirEdz
	BbXdVgApBqytabzGkbSwCHu2t0SL5JRSrlJNLF47eVKU2br8uILxpZ0=
X-Gm-Gg: AYBFou2js5MhMKMJjNGR2+iioPJPFjAtSNRm72O+M9NtcaGQr5UE0agFFLlFl5AQLXF
	rQo9myPJcmKL5BW08zP6o/BZugAWGYTjVcmA88j7bEycYjTWGn194RO8gzuCy1VZKq1oBR0d8Dp
	Zw0jpPXYxod1jxkDszbUKE7+NtIEuA7LV/JYa1q+khRSWyyt2QKyd4dvWPt7yNtBfcmHgFhAyhQ
	uVgBLDbP8uaXLTypUGriAI0GUx1F0GpAc62tOEgyfqga+FlI4aRD0JSdC9B3x3X7Y5amJCiU3Ib
	nTL9FDunvl4syFdaEzq766EJ9Hwou4XG4Y/LuhXEoNcp8u/8WMXfed2S6PpZBVZREkBdWS4p3eu
	fbyOYgx+q0r4eFpVyWIKMbNm286wu46ZUmQ0r7h6QvbhKpk+54PsFssi4djs7rmyypkKb1i+vcR
	db9RvXRKaWkjfORcng12oYHlnKjmqmW21CDfh/lxhG0yGs00K7o9cMgzWQE1y6ycoUsz+px1Zo7
	Awwo9Z71869mcZIYKh3Z9tY1kognJlt3TDwfgHwgycSMotXtT0cx7kd3cgJ8X91thMylFNe8zNo
	lS1sAITKWYi0GN6QQnIcVjmO/ISBmxGF6A2moAR90evTqVZqXqcsjKFs+vcloaYTR5owxKwmrV5
	CPmVKJiSvAHI=
X-Received: by 2002:a05:6214:d62:b0:917:a7a5:af08 with SMTP id 6a1803df08f44-91c48f16f2bmr13423826d6.25.1792809658336;
        Fri, 23 Oct 2026 19:40:58 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c48feca9bsm7203526d6.39.2026.10.23.19.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 19:40:55 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v5 2/2] media: venus: disable recovery work before HFI teardown
Date: Fri, 23 Oct 2026 22:40:51 -0400
Message-ID: <20261023223635.3c895c4752c4-3-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023223635.3c895c4752c4-1-mhun512@gmail.com>
References: <20261023223635.3c895c4752c4-1-mhun512@gmail.com>
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

venus_remove() cancels core->work while the IRQ can still schedule it.
A later IRQ can requeue recovery work, which may access HFI state after
it has been freed.

Use disable_delayed_work_sync() at the start of remove to drain recovery
and prevent further IRQ or worker requeues. Drain the work before
disabling the IRQ so recovery can finish completion waits that depend
on IRQs.

Fixes: af2c3834c8ca ("[media] media: venus: adding core part and helper functions")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/20260730153912.BAC5E1F00A3D@smtp.kernel.org/
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/media/platform/qcom/venus/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 7087af32060f1ed4190bf9f5d4a58cf88dad537d..6e495bc046913b46c926a498c062a6b55c6f7b64 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -596,7 +596,7 @@ static void venus_remove(struct platform_device *pdev)
 	struct device *dev = core->dev;
 	int ret;
 
-	cancel_delayed_work_sync(&core->work);
+	disable_delayed_work_sync(&core->work);
 	ret = pm_runtime_get_sync(dev);
 	WARN_ON(ret < 0);
 
-- 
2.53.0

