Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645537;
	b=0X2goWyJMPqNIFc/dpmRKTSE4kcchlTJF/7EoiIrCsI1CV8famzVG39yUz+yXxxFafWs
	 nDBopBKHEHWa/MEaO7MNLrImko6P6ZGPMtQOH55UwUPZGN6ioqpvMH+XpaOSj4scm0Gh0
	 ReYV8leC86vWv2okPM5Rl+S/YJ6cHDvA9peR/x94hJRHVbogf7+Pdoai193DacHbnfMa5
	 KZHsCvmuiHzGp+pdeUl1sc93xK9+EHXgGU5cOIKTzPq9wKa0PTuwwYWeu388tEexxNoUs
	 Q3wUIubwlwa1ROFJ/4sP67RUkv+mr4e9/pMfbFyZQNcwRMNfzQIvH/5zCTjh3JM7zZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645537;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=RZfUBsQBjrYMkeiiy+HZZjsd5SGGB1qkI+nxVlUd/GA=;
	b=zQ6/ZRMu6oIDnczzEd8n1wdCXJ3AJDC46CwOTun9KDbS3ByEdceLqiY1xwwd1WM7UpxZ
	 C7YrSIOn6Whwli194k31ESaxJgmNmLaR1YBz4CcwQ8PT1lSa1ex7DqM5tiBCgsDL7g/4V
	 5+ERo/IZuPwynivcr7XLgUEHfgzD3EXRUZqPbR+dqXmb+xL2laYT+XCeegR/hDUxm6uZt
	 tg4LgABKmbiJvAd7JMTxbtv/G8DsTOkIqkUBBj//871C4vZj5WQggYvTBeSBJyYa0FIhN
	 bKacWUjhiCVgfO0ecetswV6ifc1TAtcWgaIQJuaCTd7WJpydsR1Si4a/ECW/BN5uDfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cJqTWn5o;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E860606A6A1
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E860606A6A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cJqTWn5o
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3869865a304so486466eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795645536; x=1796250336; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RZfUBsQBjrYMkeiiy+HZZjsd5SGGB1qkI+nxVlUd/GA=;
        b=cJqTWn5oOQhFGoNAG1Izk38rCyk4MCBgbryuLJcH4KihfOWdvM41xVsvdqVeJUAadb
         vm0h1/AT8PLlcA8HKe5q0Ds2nMAKWxik4SH46HNJfnAmz8AbRaemE3EVkVk0gfYfr6jZ
         rU0fqpBVFLi+wI5T1u/49hrWDVdhoWI0AuXb4WNKbys7fQtwz/jebrYl1NNNlwaYyauA
         1Am/JSp2ONCRKzKSYlAu13JDGD8vnkYLHV1FvQbMswaBiXxNzk342gysd0KfZPC5TAyw
         VbUgrHVInU4e0g5+xy7LNpNAWDWHkrZg6rfB9oo05nCG6a8Iicqiuch9dyBWksSeBLBP
         Kyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645536; x=1796250336;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RZfUBsQBjrYMkeiiy+HZZjsd5SGGB1qkI+nxVlUd/GA=;
        b=vOihug8Nbrct2L3SpK6lHiZZq8ceBLGrwbHtDQfawyC7LN0EyCo+aogJ+DbJetfZCO
         NAo2iCbDSuTGiHUWvpq3tqnKaS7a6plUV75Cq5fTNczMTZX859JU9rnxQJiHembW9Ist
         pckpq3mN5vwq6KqZsEvOXPOtdwIKoraerGHaMHnjwSrGISN9IDL67EIeTslb2ZjsrUhT
         zDJIm9lW7VQwdlYUNwP0tLtLrujjkXAYPk5S0Z7APncZ1iWnJ+57593+JaSCz0vsVcgA
         dGwhBXfFHDmyBHx1aT1tOzR2tABjjRCxaIsxAKb7f0luBHFDO3fDXiPrgjEjF4q5emXW
         JhGg==
X-Forwarded-Encrypted: i=1; AL+hErHw+fBYB0NVq6c4GdwY+x+5WHn1u9haS8steE1rpDsjOMXspGgVi6B4RIrXr3g6RJnXslazB4g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+aOo4T/tzBhkeFVxk6nRk7D4sBMmDzRqIn4HKTwQC+UJNfo9zc
	vFkJEKh2dZtD/BP4iKdNTE//TGDXvZl5XQqkkV/QjrdPFrxzkltIIS3iGF0vYookNLj9l9KH9B+
	MDQ==
X-Received: from dybpk12.prod.google.com ([2002:a05:7301:428c:b0:377:a5e3:b669])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:c00f:10b0:381:1eb7:938e
 with SMTP id 5a478bee46e88-3856c9a61c1mr23535009eec.4.1795645535979; Wed, 25
 Nov 2026 14:25:35 -0800 (PST)
Date: Wed, 25 Nov 2026 22:25:13 +0000
In-Reply-To: <20261125222513.1446099-1-elkin@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125222513.1446099-1-elkin@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125222513.1446099-4-elkin@google.com>
Subject: [PATCH 3/3] drm/sitronix: st7920: Pass u8 row address when setting
 GDRAM address
From: Elkin Cruz <elkin@google.com>
To: Iker Pedrosa <ikerpedrosam@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, irogers@google.com, Elkin Cruz <elkin@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

st7920_update_rect() passes &i (int *) as the data pointer for
SET_GDRAM_ADDRESS, whereas st7920_store_gdram_address() reads a single
u8 byte. On big-endian systems this reads the most significant byte (0)
instead of the row index.

Store the row index in a u8 variable and pass its address to
st7920_spi_write().

Fixes: 88b09229f34a ("drm: Add driver for Sitronix ST7920 LCD displays")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---
 drivers/gpu/drm/sitronix/st7920.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sitronix/st7920.c b/drivers/gpu/drm/sitronix/st7920.c
index ea4566009c4b..005994a8f87f 100644
--- a/drivers/gpu/drm/sitronix/st7920.c
+++ b/drivers/gpu/drm/sitronix/st7920.c
@@ -309,7 +309,9 @@ static int st7920_update_rect(struct st7920_device *st7920,
 			data_array[array_idx++] = line_buffer[j];
 		}
 
-		st7920_spi_write(st7920, SET_GDRAM_ADDRESS, &i, 72, &err);
+		u8 y = i;
+
+		st7920_spi_write(st7920, SET_GDRAM_ADDRESS, &y, 72, &err);
 		st7920_spi_write(st7920, SET_GDRAM_DATA, line_buffer, 72, &err);
 	}
 
-- 
2.56.1.839.g22a8290db9-goog

