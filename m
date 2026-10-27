Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793060963;
	b=N6RpZJxzSWqT1XGFLl/y7vpYS94SNN4+7WdgdVo1KGnFSFibjHXeYJ4bT8siXA/q1bvX
	 vLB2dFzOvIUFYEhmfQxFRMnJb24bdafXbkRCw/k9cUxSwmLbS5nAGmCpod3CI9/X2yjAz
	 gZ17DZ0VM/cAeB07QNwA5e8DBCNT8UrhpnhfMXhTIpSTy7DA7qIzMAhxIlT76x8Sl4Eqp
	 2eqOnEn+rYT5H6iblkGUgMwY44WFVVfy01ThpT6Rkyc8OscEvRF30BamQxYzIAxATrjtb
	 MkK5DJBd4N/Wfn3my7rEsXh2L24eJqazdPyMONEA34vhktjCUenVdRBaTyuYwXbMyZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oxACkjXTSKzxgM0GX6iNXbhJe3SlZ06HmpJL0C117t0=;
	b=qATN9cpxayOJcE4lP2EQM0uQDmXeYGl9gNBvb6vCEC3H2AIkbNFgY8CQbDH75QdBX/uF
	 Z9z37RI2oXvL6u+rYhGe10f/hXIzsEBvm7e1jnarW0VZPE4or8jvVMQsTLiS5hthxuSMr
	 tbuPjVKGyk9ZLqk6LpsCD5F3NvMvnq8g/sOMjq6vDDVfXT3FQ96m7tG+bmuSPqBixFYMp
	 PT0DaFedRIYJJwlw5Aj+xbg9qMGOUt8W/QjGtvSxBzOxJ8e5hzBj/XQDd77jZvIQiGE0/
	 cKaXdrjN/vBkFWnmqE+xBykG8Jbc7sQo3ooXihf4T3i231wpeyuOdhENVOdwr1COtuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jTETyL7V;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37BD606A31E
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 00:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F37BD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jTETyL7V
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a7992e2f7dso5737145e9.3
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 17:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793060961; x=1793665761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oxACkjXTSKzxgM0GX6iNXbhJe3SlZ06HmpJL0C117t0=;
        b=jTETyL7VabdKXBRrEOFKN/ABp39W/K4e3YSrvrX9Y98eVsLdhDCj6It754zG1fRdF0
         lN0YNCGtXd7I3CQF7Z/Ugf3OGrmSMBhBVnZn5+51Lo9NiXlM6nIq2+e2JVSm2thzsF7n
         Uk7VOumLDxDYHnRdsuIjGTpCR3yRnhlMjndJUa0gRe6KaIZko28EeWLYWhFd30hwNsZe
         VDlCXhrIbzESnd+u4atAWQQc0K5CIfCAWOc4dTF4U0suvdJPnoceQlddPwpC8i5xiaTy
         4sEUuL4crUFjqpzu5GQSkdJLaxJMfRsmCLuyoailhFwkwEZhZHGqsmJaSLmO8iy6a1LI
         DdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793060961; x=1793665761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oxACkjXTSKzxgM0GX6iNXbhJe3SlZ06HmpJL0C117t0=;
        b=xR1sPx+Td/gF2qu8ojoOWJDzZWrLTtYKYKaqsGovZlqf6O/fGdwwf78Kw8v0fMBWL8
         gynyoBYEiI+Wb/0VXNiWQ65frhMFblJhr6pZvhgYXzmDjhztev8Th3C1icL1RzZNA9bR
         gwWEbhMS9dehEw3CsoEPku/Ci+M2L+mWZTUeLUKWbtd1eoLIapL4RLyBH0dM5LKXgPN0
         wOQK0hVxtGIkN8YKxbKfD5fWXWADeUsEwC5UNetCWVnRjqjz25mWxFQzJC2lrFD8NmCV
         yZin3NGKA3MmEEwz/q7tf7wrfMQgGiPB1LOcabp5aSl0Gt4vmrAXJhjyI3/6OqZbRJKw
         wJMw==
X-Forwarded-Encrypted: i=1; AKwUvByM+RRvImuWA1dlJmKVLuQFoZ0n2b/wvh/CLK01BGoynjzzCA5aVKF88V6g8QDtAfXl9ey9CG0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLikTUBbMsGkG0T4jIL41w42bC1LSnqzzLstTUjNWiUgTNbPJq0
	25UHR1nltBjjZUwGaoebKgoK3wu0HsG6SYe2N6I1j2iZ1j4h/dtmAJo=
X-Gm-Gg: AYBFou0ZoRag5FzWUKNzgEcqjZoU3M1xqGBEEe/lUIWOOAITqyF1kr7MiQCAff80XlD
	83/PG5T9Wf4qT5ZsA8B7zQJo9O61iEBLWMFyKejkS4l4weLUAui06FbMiff3TvhVIkZCfoO76r2
	BiOdEqEy3fido6L97IowIX5dY7ad4MUdc4+pYrUibhyRxKkxDbfHdhwllxA7+zDop/uj6rPIA+o
	slL3b716eAz1VhUZqt+Z6xvZp6qc4HxkFr3RzEibPMuR9u3sTVFxfPe2P4x399fE1uOGZIk8ZB0
	YgHHF6ptL7Yc+Sdp+FRIuIbimNbFtjiEC5FtFJ5tJe/nWddub99lvj7LbKPUVcMTiRqb1O/XIKQ
	DrDYpP2/iziT4wysPQkN3KhKdWmLvl02Q4ymaelpkHljoQl30MXc/P1zOvU/rAosoj8CLrZNIGZ
	TaBn6WPEurdgZOcIpO+5uY/gLHTAtzrHIJxz2OvH7ICdd9f+6f2SKOTTiXP0Wu7SSLgJLV6rk5m
	z6U89TlPwtUQrSKcJgMGObRc4uoYoaFU57ncQ==
X-Received: by 2002:a05:600c:8488:b0:4a1:e0d5:293e with SMTP id 5b1f17b1804b1-4a35aca1366mr145088605e9.21.1793060961143;
        Mon, 26 Oct 2026 17:29:21 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a5ea0df763sm142804565e9.3.2026.10.26.17.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 17:29:20 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	tristan@talencesecurity.com
Subject: [PATCH] Input: applespi - validate ACPI property buffer length
Date: Tue, 27 Oct 2026 00:29:19 +0000
Message-ID: <20261027002919.3589149-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
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

applespi_get_spi_settings() reads three ACPI _DSD properties
(spiCSDelay, resetA2RUsec, resetRecUsec) as u64 values from their
buffer pointers without verifying that the buffer is at least 8
bytes long.  If a firmware implementation provides a shorter buffer,
the u64 dereference reads beyond the allocated object.

Add buffer length checks before each u64 dereference.

Fixes: 038b1a05eae6 ("Input: add Apple SPI keyboard and trackpad driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/input/keyboard/applespi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index b5ff71cd5a701..25910786a6c45 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -642,19 +642,22 @@ static int applespi_get_spi_settings(struct applespi_data *applespi)
 	const union acpi_object *o;
 	struct spi_settings *settings = &applespi->spi_settings;
 
-	if (!acpi_dev_get_property(adev, "spiCSDelay", ACPI_TYPE_BUFFER, &o))
+	if (!acpi_dev_get_property(adev, "spiCSDelay", ACPI_TYPE_BUFFER, &o) &&
+	    o->buffer.length >= sizeof(u64))
 		settings->spi_cs_delay = *(u64 *)o->buffer.pointer;
 	else
 		dev_warn(&applespi->spi->dev,
 			 "Property spiCSDelay not found\n");
 
-	if (!acpi_dev_get_property(adev, "resetA2RUsec", ACPI_TYPE_BUFFER, &o))
+	if (!acpi_dev_get_property(adev, "resetA2RUsec", ACPI_TYPE_BUFFER, &o) &&
+	    o->buffer.length >= sizeof(u64))
 		settings->reset_a2r_usec = *(u64 *)o->buffer.pointer;
 	else
 		dev_warn(&applespi->spi->dev,
 			 "Property resetA2RUsec not found\n");
 
-	if (!acpi_dev_get_property(adev, "resetRecUsec", ACPI_TYPE_BUFFER, &o))
+	if (!acpi_dev_get_property(adev, "resetRecUsec", ACPI_TYPE_BUFFER, &o) &&
+	    o->buffer.length >= sizeof(u64))
 		settings->reset_rec_usec = *(u64 *)o->buffer.pointer;
 	else
 		dev_warn(&applespi->spi->dev,
-- 
2.47.3

