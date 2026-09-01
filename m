Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD454A015B
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 18:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288995; cv=none; b=Xv40NtoEidvgYhtxgXcSHT3beM6hRPcluVecKgdIaLrTpUCpsVS7hdt0bdI8oTLfR8VxUs8wEhYyBn62i0oijr5cnojE9hoJMLPL5R+TMRWvXJ7PtGiPJRgTUBr22Ef9WC/WsoaIWsCl6lu1SFYCHkuUKidYm+ddLHYOx9b8Sfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288995; c=relaxed/simple;
	bh=7KrXHOp6zx7Jw6ThttjXtk/cJjaQTyVHIQRYMzgXhRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EyyEm6oGn6HjXIeNJrZRK+HisGrBzE328tGR46mGQfbwi8od/LLQwFe2/1900A1Zl1te9KHXfwGtoDcONY8Ll9NBln2S/BoF0XgW87YG/Un8Y8tDZDzsN9u+4tGK9BGbUiZLcz952qzWeK4bpPghT+yVDp9KNV5zbi4Vt6RmbQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxG95JWR; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxG95JWR"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-46a08218ea2so157370fac.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 11:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788288993; x=1788893793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NDIKr9yFcCSAzvW2dhM+SCgv0HZ3qnZUYRj5rrauH8A=;
        b=BxG95JWRuDbVZwkeB5Y5c5kbAdHVZyPsZrnyTEuQMw+sto9v5T/sJQcuU9KQhpk+3K
         1nRCOfPFDDbYhEoejU9OUWHLV/NR2KJ4Vp6U0wm+1o27s3TaTLw7QMIe4nQ64t0wVYTn
         xLmRYaiO7UWYlf5+FmbwcT0syXpLXKlR1U9NXZCinvwYgL3xuBWYxsrDvnTkgZMVA9ar
         LEqLJL+S+IXU+r6atT4xfRg4Z+37uIdFv4VjZpki5yqRzbXzewdAKUmoWDIov4ElRl5G
         x5r23Fv0akaDYvzGXn5mtNRZwu14R4NX74bM+dZXW5yogMe7DMA7imOiWOMqtKAIuC+s
         3YyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788288993; x=1788893793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NDIKr9yFcCSAzvW2dhM+SCgv0HZ3qnZUYRj5rrauH8A=;
        b=HB7Y6NnkiKKQM8HnZhGHF+tVFuR/tJLBA100E3pd29OVaLAUeBcO0H8tl6dSGoOsHm
         OOVD59RhgHktCdGePqj2IlGvs7mGIpbadxdZa4b7MYA6n2xFm+FZHdRQ8OA/JXdbzGYF
         zocxyan4Rdyhj6K5vZzQrRNWk/avW2gPIQ18T0gO9w3cv3NROi5/4CSMNHHqkfGa96F0
         uHNAT6a5TTAQBbIwl7K4LBMe2RO/HcA0Ts/ZrlpcsTvXWER14ovuriiVdJngsGhWJ16X
         E9hD7DPa8RP/WYQS0zdjQqiX91CIWjERoZXKzk5EUMSEF72qzY1eJqigavL7gETB/Fb+
         pN/A==
X-Forwarded-Encrypted: i=1; AKwUvBz2C0nezV+GcVBNwsa+MnYawsIl85fYEAz6GhN8MesT/KYgw0kJMfLUYVag7fRhx5Jl37rj+MQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nKd0XjqTbhMlDHYoRRFOjO2DB2o77J1ary3WUp3+QS8pSGmtET
	EW91aosFibrdgRAsk8KGPanK0sM2g0Xuc1wU6EfPzIDR05iLl7xM+fFu
X-Gm-Gg: AYBFou2GJyTjeH3B9kdQ9EbrBO6eIt+F0PEGVpF7A/WCsa1o0/C8qxW2yV8uK/fl1PU
	he4prGjqsaBGKpnRVmxxqUpYgST43ICvVh7xGfHWbstG8PwEspJcs6blF2Dplfg8iNgmWdYnFJQ
	d3JzNekgAE4CW0NSTNZOsqnQ8xBsZ0hG6NTH1n41IIk0/lLRvgTY55u8vM28mNKM0mMaNNzWfHm
	Z9x7zMqWZlYAT5IUltPsX8iH/4f+DHxhdaqHNC3K6E4eOItsICr8K3yRjQpHJ89HgYQXkfW4Pwb
	NakY5ELhuV6Ru7LZ1lihncOzbCR7KEUrfSW6c5SpRjBLQ0vAEexsrMVidUaHsLpn7nAgt7EJGVa
	Fb99/eHh5gwSKu0hhSMoPy+sjePS+wwwIr0P6Ar+TYirVL5LTfKHYAzmDOCMRxSoIZ8yzcBCm/J
	+EImfK5d0Oam6L6W+vy7qT17CZc1FOkqlYEoNKmscR1ep2CzigdT4hnET+Rg5L9chi7Y0pVVb5t
	qZDX8DYi0vbWbYOjaWh/q+JSeo1vjZqbuhmAZ96rhwzeBU=
X-Received: by 2002:a05:6870:c20a:b0:44a:e965:b9cf with SMTP id 586e51a60fabf-46af57240c0mr10645373fac.14.1788288993098;
        Tue, 01 Sep 2026 11:56:33 -0700 (PDT)
Received: from memorizer.localdomain (47-163-111-11.bng01.bytw.tx.frontiernet.net. [47.163.111.11])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-46f30baa0d4sm778124fac.6.2026.09.01.11.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 11:56:32 -0700 (PDT)
From: Yudi Yang <2000jedi@gmail.com>
To: vaibhav.sr@gmail.com,
	mgreer@animalcreek.com
Cc: johan@kernel.org,
	elder@kernel.org,
	gregkh@linuxfoundation.org,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yudi Yang <2000jedi@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] staging: greybus: audio_codec: fix stack overflow in stream name parsing
Date: Tue,  1 Sep 2026 13:56:00 -0500
Message-ID: <20260901185600.2725678-1-2000jedi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intf_name and dir are 32-byte buffers. Parsing a module-provided AIF
stream name with unbounded %s conversions can cause buffer-overwrites.
Limit each conversion to 31 characters.

Fixes: 60e7327d54b2 ("greybus: audio: Find data connection based on id")
Cc: stable@vger.kernel.org
Signed-off-by: Yudi Yang <2000jedi@gmail.com>
---
 drivers/staging/greybus/audio_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
index 6daa4e706792..c3fefe1414f9 100644
--- a/drivers/staging/greybus/audio_codec.c
+++ b/drivers/staging/greybus/audio_codec.c
@@ -311,7 +311,7 @@ int gbaudio_module_update(struct gbaudio_codec_info *codec,
 	}
 
 	/* parse dai_id from AIF widget's stream_name */
-	if (sscanf(w->sname, "%s %d %s", intf_name, &dai_id, dir) != 3) {
+	if (sscanf(w->sname, "%31s %d %31s", intf_name, &dai_id, dir) != 3) {
 		dev_err(codec->dev, "Error while parsing dai_id for %s\n", w->name);
 		return -EINVAL;
 	}
-- 
2.43.0

