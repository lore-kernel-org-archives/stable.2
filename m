Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822198;
	b=vhdc9T4zFUzCKS1+5+ZMI1aF3F6ctHLraDvRM2Y5u0Ra0GAVYUu0xk7WrqM6zYzNJvxQ
	 JZJVklKXDtxeE5QTVhswPnTlHoKnZxHh+W9hrJP5OFCi5ZakkjBuAEVv3TpyXBYTxSlhT
	 yE/PKrVyBG56BFB3SO19B/sYxyPLKx6Fuquv/s/rkrOJKX/qZUY2r+8mpdTbX70EAboGn
	 UgxtyR6HuPqOEXRNdWJkmWUDncGmHgEGDTRSghjb48nJ+NqUXXm9msORW97W1RJNowg0D
	 N8h3g/OuOGI/lVOUfDzTrhEVUFWYICP+IAVzYLMNTA2wg7iXgYe3SB1zVUi61DWAxqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822198;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zR7X7uE7v/00IVsZHFoE++N3oXIHliCA4DwI/o747n8=;
	b=HkWi5OtCK6YhCXX2ARepGXd5DDXW7EFoZ20PuHqcjeu/fcjBzrehJZYyBw6HNGdvFqh6
	 ztR2cuDCyaeZApuW7G6vGvlzoqce9PquzzRHxClg8CixARdczOUE/uzhGtd/b8BVDKY4v
	 T1kVdL9rNxkL6N4ShQZmJ44nkf3A3LmYH8Jm7FoQoEF6cz6J0Xi94g64wIt4oRg/4EEGB
	 l7JOqZHmP2qFIkfiBjavVhFJJ6ZhmLblLRbvMLlyHmqs1qOIo4tLWQyMAsoJzgZtIuf8O
	 ZNTyTTBA71yqr5yIvyARX5nMtphEvsIiomBP8BXj2CtpIWxOg3jmxQDsdE/ubS+nd7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=EJyYJZ3F;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6979A609CACC
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6979A609CACC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=EJyYJZ3F
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3535a54bed9so1470750eec.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 11:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1793822196; x=1794426996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zR7X7uE7v/00IVsZHFoE++N3oXIHliCA4DwI/o747n8=;
        b=EJyYJZ3F9bdEpJPsWZ1wOgAovQVI8RhP6tOVyDAbvbsEE7x+2DxJELYyLCbGXVsL9+
         fwezr07zwokQMgCBVmHdQIB008dsErvaHtRXGzLBKNlFsRV/29If/S5taAQeohdCORYO
         epvtV+A0sNnWIBK2qALa1ySzZgX1RPfQyAdwSelGlO7KxQzu1X23+8iFYmUJZhVaR03b
         bdp27EQnquqqdb25C4hHt/IRMkogBJOzu4gYQ2BlAuhfFzHf5ZjzFAUeBxGznIMGpbbs
         fzbXhaMIZ/PGcGOV0ULoeVWUePBfHM8cdTSSpMZI/mLqEaPFWRBlITAXV4Wqw1jLL+n5
         DiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822196; x=1794426996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zR7X7uE7v/00IVsZHFoE++N3oXIHliCA4DwI/o747n8=;
        b=m7996eaeO9ZN4LsjAp2nE8E6ToDANiPzO2D8FFv1JftZzM/wnR68ueKBxzqT7oPkyW
         LRJowAhdXVreU1MSHMgiuJuGloHV0OZBSVYK7UI53W7dG8q35Ith9DZNeVsOnzMJCZ2T
         bdaHZVyzXlMHCjKXPSbUIt4p7T9n7/sr34CRTiL10Uha8SpaLsio64VtkINtKI057EtN
         TGzCWLOFpz5Wdac7EKHLR78+b3Qe0UxmmHGB8h6crNaD9AY/pB2PViL6zXC2lqT1zP8i
         ri9p+c0Wagh+5/l2o7KSUsxTtotqW1vCoT4G8XEeXcCCO7m0rfETNw8AQ0rsVTNJPHcM
         z9wQ==
X-Forwarded-Encrypted: i=1; AKwUvBzOG8Vf7knUN2q8wENjK3DwI4jZkzM/XTc+AI+q4WMu9Y58gEkFUXNh9Rq38s0TZ6g23lpl0A4=@vger.kernel.org
X-Gm-Message-State: APuU4Z97QGwRFdEgAltCXrGhPzE9BH74xNpWxexyQ2x4hM9/V3JK/b2n
	nGl1VJ+QGOx0gZmfa/QQa9GxRS+hYs4BrPkwWXZg58VI5OoUteVF6Qd3fncy11WQOw==
X-Gm-Gg: AYBFou2MAz0TnlmYwsqruPCX0V27FXXQaxHz20pzBF02HnnKfWZ1y+Fh6BRVKRiQFXT
	4UZ9Yl03nBaiWRUvatS/tfDKKBOMrLpLQ2xrxJfJBurTbtYBiLPy1ma543GJ+rtQG5lW1dlWrI3
	zlwHUyOsyBVVhwyVIjVpPIlO7z9VfgZMVPzzp0Aa2V1SOaXGvBtdq8zxrNqYs+9+D4I1r1T7NzD
	GFDDD4bPcsXku0TEGtOJll7WEJEx6vn0uvdFE+54lqjfASZhBYH+WHxzkVS6eJ9W5QVVRFYSE5/
	lBmrt7Yj7HB54/9NzpbALPZxqBKOC8poEx7JrWMWLVjyhMEYPoxQJxtPNIB4qIlI83UXqy9KWLX
	/QyBGs0YMomW8CVdJ7TFRCKOEDojPit9iFQMAPOP1DOxdLXQdG0yhk/SoIGVFuHrq22FEnNodtE
	WqUJz8AG/P4e8GSHGdSdFILJBTKk2OE+HbN6V7xdVaE7ZeNfgdGyZe9l+8Wb1myrtNO8Hm5nwA4
	ldA9SmTkSpRMHMZsPsICUb1r9p4fZL1JFIxSxiUovohxVYyqwPl/dSXMqPslRv6fE8EE7m5CMvK
	NOIygM5heGcSSyYDcustwMqDt/sCJD65c1r4eQ==
X-Received: by 2002:a05:7301:152e:b0:366:83dd:4713 with SMTP id 5a478bee46e88-36a4249ba39mr22383337eec.30.1793822196328;
        Wed, 04 Nov 2026 11:56:36 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38f53a6sm8941712eec.15.2026.11.04.11.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:56:35 -0800 (PST)
From: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
To: "Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>,
	linux-gpio@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] gpio: virtio: bound the line names block by its configured size
Date: Thu,  5 Nov 2026 04:56:31 +0900
Message-ID: <20261104195632.1702765-1-lian@is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.56.0
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

virtio_gpio_get_names() walks the line names that the device returns in
a block of gpio_names_size bytes, which the driver ends with a NUL, and
checks each name only after stepping past it. If the block holds fewer
than ngpio names, the walk reaches the end of the block after the last
name, and the next iteration starts strlen() at the byte after the
allocation. With a block that holds one name for four lines, KASAN
reports:

  BUG: KASAN: slab-out-of-bounds in strlen+0x57/0x70
  Read of size 1 at addr ffff8880026687c0 by task swapper/0/1
  Call Trace:
   strlen+0x57/0x70
   virtio_gpio_probe+0xcb4/0xfc0
   virtio_dev_probe+0xa7a/0xc50
  Allocated by task 1:
   devm_kmalloc+0x6e/0x280
   virtio_gpio_probe+0xc06/0xfc0
  The buggy address is located 0 bytes to the right of
   allocated 64-byte region [ffff888002668780, ffff8880026687c0)

Check that a name starts inside the block before reading it.

This patch is assisted by Claude Opus 5.5.

Fixes: 3a29355a22c0 ("gpio: Add virtio-gpio driver")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
 drivers/gpio/gpio-virtio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index ed6e0e90fa8aa..32326d91f33d6 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -520,13 +520,13 @@ static const char **virtio_gpio_get_names(struct virtio_gpio *vgpio,
 	gpio_names[gpio_names_size - 1] = '\0';
 
 	for (i = 0, str = gpio_names; i < ngpio; i++) {
-		names[i] = str;
-		str += strlen(str) + 1; /* zero-length strings are allowed */
-
-		if (str > gpio_names + gpio_names_size) {
+		if (str >= gpio_names + gpio_names_size) {
 			dev_err(dev, "gpio_names block is too short (%d)\n", i);
 			return NULL;
 		}
+
+		names[i] = str;
+		str += strlen(str) + 1; /* zero-length strings are allowed */
 	}
 
 	return names;

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0

