Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B3C1E5207
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 00:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784765712; cv=none; b=WNJL37aAAo5C9ys+nDnEDXkJZe2vciv5pICrU4BwDjYLpZ/5lLMHGsaWCoP2THBL4G3ui5SOY8+U+sKI1agwSBV8EqahrTy8DwvZ4Dx7bgyd9fx/q5wH9SvjJyzsygw8aRaMGueY+GRJbp9uUOxTM/LiN5MTgClS2dwNHyBgfnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784765712; c=relaxed/simple;
	bh=TLQfSVdlMTqTPTmDzRSTa3i03iriBuDGFkfWKfK6fyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NKAmm7GUT2qnOSi30nFdRJif0HYu2Sp6XiVLzeO6inR5Num0yzALqBmlNBrBW/PMQtnYBi9K403q8cNgeJorTLTAUsz19Vk9WBwJVs9JDWpWSIpjEI6yrqe0AypOn84bUg7TIhy0mEu61kwx5m0WCOOZ9I/6dUmu4f8uhuIFTO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rJpItQGi; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJpItQGi"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-667b0ced2d3so24574d50.2
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 17:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784765710; x=1785370510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qp9RLqBI1+mbcSRTjHjiXFbp1lu8yHG6RRkL9RL0Njc=;
        b=rJpItQGifPt0Iw0d1A2ErjLDdK7kFYV/xRigglNk+yuXLotftw/i17UiEHk3xnm5oc
         /1eTNum7M+etTKjv2mObifD7mB7h3q5siTPmLpdnR79X5YEUa5xbuYAnzc4zwCsPm9eK
         YW5nOgJgCvP/MM5F/pcOOcmo108vuDzICFzgHVFiOWcMvLTR7cQ0QRqN/EZ5MeTA18Qr
         AJHBd0oYuYOfpTshECOcssZxWH8IvQr2JXSSaBcxYntjpilun0Pq+17nrE2YYNUyAQBh
         W3rE6WfRuEWoR2/vFpmd8SrC7RLjWoJmfmVyxH88oPvJoUWKsayIVUA9IFA6UNq5Qmcl
         E4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784765710; x=1785370510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qp9RLqBI1+mbcSRTjHjiXFbp1lu8yHG6RRkL9RL0Njc=;
        b=PA+Uh5ffC8mdty+DvV3U6x5mkQt9lSDP76OcjG3gcxitVmaXaiGj6vY7xso21R6T6+
         sghc9PUORvDbmrNi1Mf7ZSjfJNmGDMSlpJDWYtDbRzPYxEMB/dyGv5porWVNJ6Ed0Zc8
         cJg6ZSzI6N0q9O/avD0ddaHquFQsEeHeIkgXEgHNtp2vV2MMQE21denVUanBPEa9U4YF
         hEU1pNv8doeNuKDMJLCG6wGnWPonMIo4/MxYopyuJPyXktnpMeHHJ+0RJdYaUquVuB63
         UJs/og3Q8LbBgqq95a8A8DsBHHfbGL3/4Tt6MTZB5qGA5lNqeeGIRvygJCILDBqwoEwT
         rS4g==
X-Forwarded-Encrypted: i=1; AHgh+Roo9jzQNjERVnH5jDNzBt5pSWvg3qx+2fDRPAgyG3V8bJmjsAYJ+k24a7bQ+7IK/XSweWc+Qns=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXYYtWTN2oaBPASWaPyiMaGG9DlpCP/n8VZ8Geo8GHBtapR5ow
	ErWW/nAdy60vR52TDvPwjFIqGFeBzqUT/0gKFG9ILLOunP+57ueT1YLg
X-Gm-Gg: AR+sD12R2RE+B13RWHigDQTwwp7zcUVww3RJXliveU2MWuWoPnzKMhwIr4muO8rQvBg
	tRWqt87kvunp5ETbrp1GkSYFjzsA88QC0FadyKCMbMXftoGh5eoMZNCGkYCm8A425ztDCEnuOy3
	7sdDPkJvG1/jHDHhVZfVRHsFDpdrKothqnPgUtCmPYwIhKNEyKUj0GCnpzkNVhEJ2hg8RjuuWxf
	PxrWGwrk3neFzWryhVOLmgO6lNfJxs/guBlfHutgglZnMkqwUt5Q0N4nt6PH2Mf54eI2AAnSn/R
	LbNwVDev6NPwe5rYgfF1ZJeGuqev20k6W5NMt6+kPZ8bQhQPt8PDFbjkcKVC2Ph8ZTgQZ/EEywz
	AOKbgdlJJjrqizOPM7w5x0x/kQCtGi8GZjkUrUonVeQhkroxBcNhJQCpu50oPA2TfT28k8H5+pL
	hDMMe2ek5pdtWinauQnDLQJJYzZWDFiQeN7DHuyAHKkz+AsVh9i9Lj0Z9pIsRc1fgJ8pFbqn9Ow
	gygO6+S41QlSPA+tY3e+CEEfa9lLlsh5cbWdtPHJPpPIuM2joD0iH7Qzo2lLXIBtII=
X-Received: by 2002:a05:690c:4b86:b0:81e:8985:e0e with SMTP id 00721157ae682-81f4c30bdbfmr2886347b3.37.1784765709572;
        Wed, 22 Jul 2026 17:15:09 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.f7a5e5c3-cab1-4810-bdbb-207cdd06de9e.globalsecureaccess.local (76-204-101-112.lightspeed.tukrga.sbcglobal.net. [76.204.101.112])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33c397c9sm21446967b3.14.2026.07.22.17.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 17:15:08 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: mchehab@kernel.org,
	hverkuil@kernel.org
Cc: kees@kernel.org,
	rongqianfeng@vivo.com,
	axboe@kernel.dk,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] media: dvb-core: add upper bound check in DMX_SET_BUFFER_SIZE  ioctl
Date: Wed, 22 Jul 2026 20:13:06 -0400
Message-ID: <20260723001306.84709-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dvb_dvr_set_buffer_size() and dvb_dmxdev_set_buffer_size() pass the
user-supplied size argument directly to vmalloc() without any upper
bound check. This allows excessive kernel memory allocation via the
DMX_SET_BUFFER_SIZE ioctl, which can lead to system-wide OOM conditions.

  Kernel panic - not syncing: System is deadlocked on memory

  Call Trace:
   out_of_memory+0x12fd/0x1370
   __alloc_frozen_pages_noprof+0x2620/0x2fa0
   __vmalloc_node_range_noprof+0x7fa/0x1490
   dvb_dvr_do_ioctl+0x11e/0x260 (drivers/media/dvb-core/dmxdev.c:296)
   dvb_usercopy+0x15b/0x360

Fix by cap both functions at 64 MB and return -EINVAL for oversized
requests.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: a095be4b030c ("V4L/DVB (7659): dvb-core: Implement DMX_SET_BUFFER_SIZE for dvr")
Cc: stable@vger.kernel.org
Reported-by: AutonomousCodeSecurity@microsoft.com
Link: https://lore.kernel.org/all/20260722193719.81157-1-blbllhy@gmail.com/
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
V2:
 - Add Cc: stable and Link: tag

 drivers/media/dvb-core/dmxdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/media/dvb-core/dmxdev.c b/drivers/media/dvb-core/dmxdev.c
index 3c8bc75e4d6c..b4dc87945be1 100644
--- a/drivers/media/dvb-core/dmxdev.c
+++ b/drivers/media/dvb-core/dmxdev.c
@@ -20,6 +20,9 @@
 #include <media/dmxdev.h>
 #include <media/dvb_vb2.h>
 
+/* 64 MB upper bound for DVB ring buffer allocations */
+#define DVB_BUFFER_SIZE_MAX (64 * 1024 * 1024)
+
 static int debug;
 
 module_param(debug, int, 0644);
@@ -292,6 +295,8 @@ static int dvb_dvr_set_buffer_size(struct dmxdev *dmxdev,
 		return 0;
 	if (!size)
 		return -EINVAL;
+	if (size > DVB_BUFFER_SIZE_MAX)
+		return -EINVAL;
 
 	newmem = vmalloc(size);
 	if (!newmem)
@@ -333,6 +338,8 @@ static int dvb_dmxdev_set_buffer_size(struct dmxdev_filter *dmxdevfilter,
 		return -EINVAL;
 	if (dmxdevfilter->state >= DMXDEV_STATE_GO)
 		return -EBUSY;
+	if (size > DVB_BUFFER_SIZE_MAX)
+		return -EINVAL;
 
 	newmem = vmalloc(size);
 	if (!newmem)
-- 
2.53.0

