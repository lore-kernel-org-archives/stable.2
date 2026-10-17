Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6B8395ADD
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 05:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792214385; cv=none; b=VNdbgFp3S8QGoT/qrN8fOHCZo2RD+VMOkOyV8w/JXP0fxdqk9Zz0oGLYa2nXzFJlNSlWG0UKblJgkwk9PF6GKqS0o7AVpqJkeI9uNU5Q4R8v9uZCBJ86t/tNRwzUoX6fzp3Vy4TzUcLiXkAoK2LSVNo6peIoonkviI3AYah7XTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792214385; c=relaxed/simple;
	bh=ky6PePi/fpetxqkSpkooLbGaqEzmRUTxqPP/Cm69q4U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CcHD4vwxfLD2duHyLRclhMBlLeMPv20TeCgwddI5Q0Wcgu8uZnVtGad/PuHCnTOMfirDrEa6/Bpr51uMrBDhAb9WVq1KQyBnW8oxXhZhwP9d4QiMHcd+2y1AVDS7+ELFe14hzQ+hXJ0NOHKNDJ3McF6EgH8oYzCKIqidIh/0N1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=okFXP1LQ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okFXP1LQ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1dede3c2cso161905e9.2
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 22:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792214382; x=1792819182; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jI5B6P/xW04ozzor4R64wJbnVhuui+cU4FBwYRf4wko=;
        b=okFXP1LQCHhsR6CaDNvjGINHKyFbBoZ/WxFo7PdwyISuvckUtoC4LUiD6768UXfIXj
         FEF8KmAnOlTslAqaX5z3lves3Ou/Bk+lH6qpoUT8+lD+P63qJZk3ylPB0d1Y/qoBqh7t
         xZ+C3QuzyPhuGoBrfxNuZtfd7SgRx30VdSPMY13OdxoVWH62I9Pe3zzO5+pJlramaXI5
         UHumHwzbSx5iSE1u5CGJjQYIBIPfKrXSG4hekNCWBqPynZDYq2PDvR47KLK1Dar9lZck
         9RKd7Ge89TLVNgThyd28nHE1TghZbpri5qugzt34aE3NwZsFqKt2Fy/6mQHu/ckjHwNo
         6Wrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792214382; x=1792819182;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jI5B6P/xW04ozzor4R64wJbnVhuui+cU4FBwYRf4wko=;
        b=lZhBVGERS5XYTFbLoubaR7fiMNzGDnBf8XCpBLjsGSIKF77/Q8SpVNpFZ71n52D7rQ
         E4ZTBGWRy2+a5NfLycrma4eTMXiu1R5ItqYvezGkGeDYVmJaeGKYOjJYXr1ux+iPlwpk
         1Porhx5/6PBu85K0UPbZuy1JNOk0y43iY13MoBXr/GZ8WJvp1gBoL1PWDKuT0XMsDr3W
         AsSbTwVnylnFQCJrkZUIb/Bywj5K0rrE40ugPWBeZRnBPY7ExtMuUlql6rHiiG0BBgd4
         d1sZ300kOU6y6Oc/sZ4h0xR+7+3LRi5Dy3sAI4lhJc4BMOSAtmK3j7vEbIuuLbC8EO6Q
         z+pg==
X-Forwarded-Encrypted: i=1; AKwUvBzzeSi35lxcHqGi1adAXdeF8ddnZNGA1+Ov2nL0n1q3MAgZ69CAcECfUs98FiW25inyTNGWI4k=@vger.kernel.org
X-Gm-Message-State: AFq9FYKv6Ie978sLQUItu5mdQx7D5l2l+9whVgk4xLJ+9If/V4TlKmVB
	DPKX6tr6nPbblfTJTQ26vxYn31cBqpuqdTagDXp13oNIe1AtWXWN5sgv
X-Gm-Gg: AYBFou2U9UPOXftReuHNyYPdR4jwjhcbUbK03Cd4c4OIaamModfIScDxde6+CWDIQQG
	lYo5UUxVc5Y0iALESaF++VEmr0rT8wU9/a9xQVXBIvg3k05/vdhMnl47tYmapZfgcDBpxeY10u6
	VR9C7jdBQ3aiKhbGXF4iStTI5ejIFFgJKPXaTJvJTNFQAcUuVqiYAaItK1UEHEiZ0HqbEV5O6pT
	VYWW3gO1Zrk7ZeR/SorTLkU56Fu59ic09fcFVHvHlH8cxJIQ2kw+06xlrsPY+OYiSAb0WJBUUbl
	KWWIE9SOZvgc5XNdeOJSYmi2uRfRQz+PsV/QK6+bvBJ9LGizzy0lYxgk9lIVygmgZVpk45tTtDo
	wGPXu11nQeZb1sG1x7mXbr3UMrUJcCDHTziK4WwyPXFEn0Ul5Ui08k6gwMJDmd8PSc8SNvBy0rn
	Q7Qju4CTUFGKdW8jYxOjH9Owm0hPISzoYOVAiDbwSljCrT/obbfYwKTo+5YFIwNTNFpRmEI9edv
	eT4A5xKdo5kWxzgcNel995+54yz25JXa+eZGOs1gBw02GDXfN0d+P2v7rv+np90YwC5Fbn1M+58
	sTpIx4ckSI3Ik8kRGq6xMw0IH2QYuabWvh7nnaqa+rlNIBq8M8YRi/g8+jUcrTgpV6Dq7gSw/lX
	xulDoat/o+g2wsYvMfjwDwFAz/jKmkL3xMZlRZXIDSKkhyJKclaHSKvKw6r/QGNkLRESUH7Vz
X-Received: by 2002:a05:600c:1f83:b0:4a0:27eb:49b with SMTP id 5b1f17b1804b1-4a1d761b900mr33747025e9.30.1792214382055;
        Fri, 16 Oct 2026 22:19:42 -0700 (PDT)
Received: from [10.200.7.52] (109-81-110-105.rct.o2.cz. [109.81.110.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1dc952d63sm16432585e9.2.2026.10.16.22.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 22:19:41 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v3 0/2] iio: gyro: mpu3050: add missing trigger cleanup
Date: Sat, 17 Oct 2026 07:19:19 +0200
Message-Id: <20261017-mpu3050-fix-v3-0-d6f29f335a2b@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Myw6CMBAAf4Xs2ZrulgX05H8YDzwWaCJCWm00h
 H+3cMLE40wyM4MXZ8XDOZnBSbDejo8I5pBA3ZePTpRtIgNpylAjqmF6Gc1atfatMOUyzxsmOlU
 Qi8lJ1NvteovcW/8c3WebB1zt/09AhaplrnSDpqgkvXRDae/Hehxg/QTat/zbUmzZtLnhAiWje
 t8uy/IFzir2HuIAAAA=
X-Change-ID: 20261011-mpu3050-fix-145a77d5229b
To: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, stable@vger.kernel.org, 
 Dingisoul <dingiso.kernel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792214381; l=1108;
 i=joshua.crofts1@gmail.com; s=20261015; h=from:subject:message-id;
 bh=ky6PePi/fpetxqkSpkooLbGaqEzmRUTxqPP/Cm69q4U=;
 b=M0LgvKOdE5yjdYECNlUil2WtEt41lBcIPYWXooIAJS+O/mKpogTlJtcVyXYXIjFBabRb+aQ+6
 VaGsWIXoEAzBZKdoyX5/8zWm+alcUgHmEZ9pO5ndFzUM3twFjICAXHo
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

This series fixes an ignored error return value that causes the device
to behave in a weird polling state and a subsequent use-after-free bug
reported by Dingisoul.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Changes in v3:
- Add a separate patch addressing the missing goto on trigger register
  failure
- Link to v2: https://lore.kernel.org/r/20261015-mpu3050-fix-v2-1-53f73581e62c@gmail.com

Changes in v2:
- Add a local struct iio_trigger and assign it to the data struct only
  after a successful IRQ request to prevent a null pointer deref as
  pointed out by Sashiko
- Link to v1: https://lore.kernel.org/r/20261011-mpu3050-fix-v1-1-f55b0d138be4@gmail.com

---
Joshua Crofts (2):
      iio: gyro: mpu3050: fail probe() on trigger registration failure
      iio: gyro: mpu3050: add missing trigger cleanup on remove()

 drivers/iio/gyro/mpu3050-core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)
---
base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
change-id: 20261011-mpu3050-fix-145a77d5229b

Best regards,
-- 
Joshua Crofts

