Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E311031A572
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786822726; cv=none; b=dD+pLxx9GTswZsFX9R9pl8BTcbKSoQh2K5wH6yT0xLrkkrOxd153+gs8oB5WOJN116Zn22mVyinQqxTTS+Xe9+pBa3LC019riWoUPwIjEyOgJgpEKTjMk7XFO6s16eO7RrIDP/q3m0QWCE3fRpWp3sKJdD5Tiq9LQLtjff/7LEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786822726; c=relaxed/simple;
	bh=m2/jhBAYg2/LawuSqK1sjJNSGD3aaB4RYTaRo3ybk8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CSwO3njCQnTn5+R6+nBZTkf8j9TtshnvLqKmEedd0jWNt8VhRtr/JDXGrEhPUbT+KIsOQPwPH/WB2lY4Bp0Rr/V2r/OwR7didQ6IOaUXpgpzT+L19o1QjKw4+Bz8Nd/DSMREu0coCaBvECO0nXaxGSEqyiOgwbVpZPsB1kmNZoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=quwHRhxl; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="quwHRhxl"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4956242332dso22016655e9.2
        for <stable@vger.kernel.org>; Sat, 15 Aug 2026 12:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786822723; x=1787427523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eaUiQBv7IUsoP0lKzTE6/BdETxQ+RizUmTEW5rmY3XY=;
        b=quwHRhxlUpi5qslJfGtJAe4Ssdgl5NSWHCGzufE/bLT56vPK1UqDJtsQiOxEdKcATy
         uUIXLFgyet7FAI2edZaWDdGJZAb38fkHnATCcMHylxHsEOJRSamcteEmvRuXGLqhaJqh
         7Jnis00azx7zoiCFFN7o1NfgSZ8oM6WVGf2dtbwF6WlObeTJ2EHSobmiDSaIsut/5fbx
         8uo7WQez9XT6gX/SUYs8zLxl19hsSi87c39SgVnTfcQMTVebvESuH5KaQZjcSitn+K2d
         gBDpuXSjyby87b7wnCo4vsme/CcgXi3+w/IEijFuLUBR8chlJn2fq0R/lWh1YfesBK3D
         8JfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786822723; x=1787427523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eaUiQBv7IUsoP0lKzTE6/BdETxQ+RizUmTEW5rmY3XY=;
        b=CIZvb2HLPEtXawegc8PJEg2y37EygiwTIQk6X2lN5mW21IFNqBt9YDXpffdh8AoJ+h
         Ot5og8mSw7huZrvuOdhW1PHjLvYG0RAn8YWA9ckMmWN1eMkHCpuX3IOE8n8MagoWERnT
         8wv66hIbP1tzyPhiUd4n2bm2rru9Jdq/2WO/d2Wt/oJ0QKBBWKLdCC27ZfNy3GrONhWT
         Td1h8htJZMGgmdNOyvW9KeNSadOYdue88YeiaONQ+0DzazW707hvEbePbiJDi2G6ndh4
         ecC2UU19OHlv8N7cLui8n7yFRAppOhcHSEscrq/Z8tixNbSAF7m2uckRRO1JJTWSK19f
         PAvg==
X-Forwarded-Encrypted: i=1; AHgh+RqZVR4d8MNYZqhriw6/TkmENEgS4LNFnS9nCmuFZYSHDtSxmq9SeSlj3Cs1C3X42jsSgkX6hKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ6W8cuh9BvywUqDOY0OAphBt2GwHrRbvNkPh1yaR/vUuVK428
	PAM9lEZxi5qQL+egPOud4n9+7KRZ8B8HvIMdvBaWnslxdmGgY02gM8Ao
X-Gm-Gg: AR+sD119lka4mAxl+6T4nncEmCXJ5IrCpRajvzSwtKTpzgtstT6km08G5SlBTtelIP8
	/uAFxDYaOeV23m9PY4IgZBk/kMxHt74rvCRbegSvRINmwJIlPLxnkAmwK8YVlkx+RjSV9oAAmDO
	EQBdlZxmAehnjxxOFULqjQErIa9e5lKMnkFdZ81SR7cBaGuK9fhbJzT5NZiONQ/I0ExZVkYWyDO
	xg8ieIBRM8Ymls3YKVWfIV+3q7XXYuOGjG2/+1Rk5XN63QNWhu8LzZ6z/8U5JCGaoEVz9K+SMu7
	04nqgkp8MHs7nhp6XhRHtPoYyj4YRXf88jftBZ+ZKHLUH4LWJlkNMDog7Zq+2qJhbCp+BzyW4KA
	0NfITgi28XgSqu9SBel0ZOSOstrqMeMf1/9PFC/Zt/udaTxo79dzsQhatnec7Cbx5Qnr25XzlNU
	dTeMsxVv/GQredQz6TifRCXWOb8UiflHz7+SxUSlidsDw2vj9R6uJD0STmxoWKPxsnKoqtulvFg
	lncmUDlL5Uk0T7QiS1FwSwtpdOU1I5oSS7P82TH7xtOKHFW
X-Received: by 2002:a7b:c5ce:0:b0:499:726c:d658 with SMTP id 5b1f17b1804b1-499879bb9e5mr156201405e9.19.1786822722856;
        Sat, 15 Aug 2026 12:38:42 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f15b946sm19640500f8f.0.2026.08.15.12.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 12:38:42 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Michael Riesch <michael.riesch@collabora.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] media: v4l2-isp: reject zero-sized parameter blocks
Date: Sat, 15 Aug 2026 20:38:39 +0100
Message-ID: <20260815193839.141406-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4l2_isp_params_validate_buffer() advances by block->size but never
bounds it from below. A block with size 0 passes both the
block->size > buffer_size test and the comparison against info->size
whenever the driver's type_info[] entry is an uninitialised hole, so
the walk makes no forward progress and loops forever.

Drivers call this from vb2 .buf_prepare, so VIDIOC_QBUF on the
parameters video device hangs the calling task with the queue mutex
held. rppx1 has such a hole today; fix the core so the walk terminates
for any driver.

Require every block to be at least as large as its header. Blocks
carrying only a header to disable a block are exactly that size and
still pass.

Fixes: 3cb6de6fafb8 ("media: v4l2-core: Introduce v4l2-isp.c")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/media/v4l2-core/v4l2-isp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-isp.c b/drivers/media/v4l2-core/v4l2-isp.c
index 1eb46e080afa..760e16a5ba9d 100644
--- a/drivers/media/v4l2-core/v4l2-isp.c
+++ b/drivers/media/v4l2-core/v4l2-isp.c
@@ -84,6 +84,13 @@ int v4l2_isp_params_validate_buffer(struct device *dev, struct vb2_buffer *vb,
 			return -EINVAL;
 		}
 
+		if (block->size < sizeof(*block)) {
+			dev_dbg(dev,
+				"Invalid block size %u at offset %zu\n",
+				block->size, block_offset);
+			return -EINVAL;
+		}
+
 		if (block->size > buffer_size) {
 			dev_dbg(dev, "Premature end of parameters data\n");
 			return -EINVAL;
-- 
2.55.0

