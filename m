Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822200;
	b=M8j4kqwLHWQo17K2zoh2FRG2QbaIOD/saKGVH3qdxfPCk0WV8JMsTMHUPP074JOAj1EL
	 3nwCN/F3pkVhYeLlaiVQg0nzWgStkj3rKfY2yjd/EGl2LR+Vimldb7Bd9CAF/zd3xokZH
	 IzMC9UqOqSyNynquOjM61pYQTSfvNVsxvGn4hsjhBPtzaP0AfHE+Yn1DhXFVnjkOb+WEs
	 wVM9HE0wEojQk82Gdf0+Ex7POBhn3h41KBNqBo0oaXSU2Qb+655O2nIVTXPFRupf80I72
	 xLPkjpKr64QXratskDbFB1pz1aOONSwvIENN5eatvA4M/Ta/CPEP2j8UOjR4ZQOWo2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6kpL4kjKXO5+zpcv/2EB9Ui2OiV7DWWpQ4VPKolISpI=;
	b=yUykxajTiVJXx+Op8sZ2wlHcBaAt3Q/BkEn/tHLXm6FsTYVFYcXYJr6A8rAQ2J80UpFs
	 PkhZGpNhgfIu7VSsUhaHpBD3WNwbeyiRFoBh7PiZvdTkXS7ibVZMNzbZnXinJ6uUUuKve
	 IqgZ9QLIaSTzeIfO/RmruxKOXIPyurHn8o476pnzrHX9oAKFJxf57W+OnpY1Ud261xnJQ
	 /2qOiMS93KRnh8MlU7KzT/yJEUSxPKymY2ba01614rpdjVAHbfM798CEC2K/w3XKtBHDo
	 OlLGGL68zMvI8N4k3wIwDEhRuW5Q4LlibsyGVZa42A6PT2I48Q01d14F8I/03DXapmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=U6zV6xcw;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD1B609D0B8
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAD1B609D0B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=U6zV6xcw
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36cad25b8b0so1652222eec.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 11:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1793822199; x=1794426999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6kpL4kjKXO5+zpcv/2EB9Ui2OiV7DWWpQ4VPKolISpI=;
        b=U6zV6xcwHj+Ax1U+kmYYDq1jY6NvN5hhUkbJvszowRriybXgXLwACwvbvkPqlDfu2b
         8GC9h+JirXzYbhj0gNfFxBPLgAgwOYxHYEHQv4Apns+QEoiHcGE9wYDoEQXe9SQRdqfZ
         3xbQWrcltPSc1dgqb2q9JPCZVJXWfu1Lz20ZZtzxDidI57lisI2a7rVlQriDzRoWlsG0
         xDp0AgA2/UZy481hsx+WW2GSTWAQe/l27LSoVypdKpy0mJHesnQOlR+9/WhtPuNcWN0m
         0uSz78X20X57tMIazycsN8widOYGBeRTYvGKbqe3W5KVjW8sfHY6UnAld+tBJchOWNcq
         PjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822199; x=1794426999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6kpL4kjKXO5+zpcv/2EB9Ui2OiV7DWWpQ4VPKolISpI=;
        b=nd6DmuLIDqCzFCeDExxHq9T5Vzu2sXZw+V713+19NtrTL8f+YViNteaoMZ3Oniqibq
         tTVYhK6HwhFivd92GbvSwWjGZo+yTgeFRnJAEnmP79VAc0OF8x8QaOocrHqajPNcuCJp
         sIIZfo5/AyEegkvlxm5xyZ0upjOlIURIqXD1Q2UyvI/Qab+F+aY05krvESBhBH+coZzw
         UBBM+ez6DmYGvRgBnUgSW75DezC6v0z8VXPh1fI7nCxONK3dQyKaopns1Gkur9C8uMNP
         kI6x+7TRzxQ/QEV2jxmDQPZDNBsyjetSpAuM+VcEwK/AEr7AETxa1SyBhqtuLqvqsd7c
         hXaQ==
X-Forwarded-Encrypted: i=1; AKwUvBx1oPDX+8y5JdZ71QD3gV2U71qG6u+ivP0tx+yopYHxXZJmTxgRvdEBhdeqGCE5UD/ZbX1rMY4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9qgDS9feC8Kgc4bxJZmNVH1comsyXu396qYHeREJHc7x6gkCy4
	KAX/Zbk9QzAewtsjV8ycb5/FDbF/8ghuXeTvyGnYhRYodrjP6hIPzEYodZ8JCtOzU7HRyc+Q2gy
	9cHQ0LA==
X-Gm-Gg: AYBFou1UEw8zVb+8Ylzqy9RibAOyd9sPfMQkOeGK34NXj8k2kwcRzDEqwmjZeKESWcs
	3D2i2jD5g8OjqHiseQkp6T+PbqLC0M4+iI9ci7A2dapRizFzdy3FF0HfZ8DwUtbgWqBX3ExAmtI
	88aFsYJpvI4/G4RH5GSCtdhDxRmFd7XEcrzNKllA6ZmTJbQSfFvmtOOHupt36fsu0t1Dj2WQYMI
	U8fW8klTlqzXKoRJm1yfWt+YDsOOwRnJtRdb6lCxaxV3wRxH7Vo4gmP2RoavcR6WTJGHNF5kyC7
	yruaHr0flv8BGHyaqPEvY3l5wKlvy0GnJU+xnNiN9HB6GtOc+pAnzBWlbuZAQI+WUi9admxZf+Q
	aihuVs8pJWfM9EC6xhAaarQ3fGMo9IduG0Et97tOo5tJHYpMiuaSTD55CzyefqXE0fPA/k2I9+M
	RQqAH8wPpjSNw+gAV76WZgT0NygXpzSm2XxHJVuyZdpQkAc8VDn9DuoLc0zo+mfD6oBwbxDvurM
	h0M/KZG1ZdBL3+Wl3IDJsp8EPJDVgKBFrqln1ehdM7rTcM0DAAeDXCv64QQMyf/dholPQB96Idv
	s4KvJE8fw0So1Ata4fqQ2A1CSwZTB+Mw47wBQA==
X-Received: by 2002:a05:7300:e9cd:10b0:36a:ac68:c745 with SMTP id 5a478bee46e88-36aac68c84amr10067389eec.25.1793822198657;
        Wed, 04 Nov 2026 11:56:38 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38f53a6sm8941712eec.15.2026.11.04.11.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:56:38 -0800 (PST)
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
Subject: [PATCH 2/2] gpio: virtio: compute the line names size in a size_t
Date: Thu,  5 Nov 2026 04:56:32 +0900
Message-ID: <20261104195632.1702765-2-lian@is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104195632.1702765-1-lian@is.s.u-tokyo.ac.jp>
References: <20261104195632.1702765-1-lian@is.s.u-tokyo.ac.jp>
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

virtio_gpio_get_names() computes the size of the GET_LINE_NAMES response
as sizeof(*res) + gpio_names_size in an int, where gpio_names_size is a
u32 from the config space. A gpio_names_size of 0xffffffff makes the
size 0, devm_kzalloc() returns ZERO_SIZE_PTR, and reading the status
byte of the response through it oopses:

  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] SMP KASAN PTI
  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  RIP: 0010:_virtio_gpio_req+0x2b8/0x550
  Call Trace:
   virtio_gpio_probe+0xc2a/0xfc0
   virtio_dev_probe+0xa7a/0xc50

Compute the size with struct_size() into a size_t.

This patch is assisted by Claude Opus 5.5.

Fixes: 3a29355a22c0 ("gpio: Add virtio-gpio driver")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
 drivers/gpio/gpio-virtio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index 32326d91f33d6..fb7b40eff37dd 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -494,12 +494,13 @@ static const char **virtio_gpio_get_names(struct virtio_gpio *vgpio,
 	struct device *dev = &vgpio->vdev->dev;
 	u8 *gpio_names, *str;
 	const char **names;
-	int i, ret, len;
+	size_t len;
+	int i, ret;
 
 	if (!gpio_names_size)
 		return NULL;
 
-	len = sizeof(*res) + gpio_names_size;
+	len = struct_size(res, value, gpio_names_size);
 	res = devm_kzalloc(dev, len, GFP_KERNEL);
 	if (!res)
 		return NULL;
-- 
2.56.0

