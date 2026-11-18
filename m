Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795045819;
	b=krKt3OrUqulKiWzbJHgbK1PpKkNQsF+PN/QKL1VkB38VKFFPwSzTuOYP/DtpXNEBBmnk
	 fgmOSlBnGE/LTWUAhapPckPFqJsUggf4U/BsHAHc7hUMbUXw7El3aYqJP9kAN2LwYQNuh
	 +LQobHOVXpbosHMyMM8Tajd2rJlxPvxjQiM2bmzsJM5hBW0y1AV8WEt7/hc+x+qIgSGe6
	 RXMZtWyi4Zf0TOSDn+voZXWTr1oHPVx+iyLqWggISEgV4pTdpBFann+fB037J8+qQ436Q
	 6Aaex7+ODPmpROW7P8Vw0cJETUkUVMCy1iG4McmTuby5MNAP/3dv8+zb0brshk+9AOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795045819;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fduH1+3PZ/9MoDFOHCe3dYefomwFptmBxA3+ByWc1yc=;
	b=bL+bUEWgsYx/ARdTQ4zDvZkIxTP6P9n/tOehZ6rK+RDjJxoyiIQHMPPyiMiZnLnHMi/4
	 aUOirOyimB+xYwF1z1CpYkD18Regx5vhNHRa6Z1pH5Ra8W4a3Nx+XWetT4ajxxLhreU7T
	 ysd/yO3XlbeA0IMsOHU5OoVUc3/K2Bpt5EuUioA24WBo3s+SUUj5iTKkiI+3Er16JZUOD
	 cLhnEFNIpeK87bE7wmeccpM0wRyA9Rle5Cvl5vnGxkgr6HO+NuZqfZ3jkoTqmd6liRGmm
	 oIorbH3kKv+cGCnqpx1nmcJQ8r+OD2kmXindYGW+gd06Tns/6QDL/c3W/t7GBA/wC0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GrC4vKpJ;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DF6606A325
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 23:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5DF6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GrC4vKpJ
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-844a8bf7e25so1046570a34.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 15:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795045817; x=1795650617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fduH1+3PZ/9MoDFOHCe3dYefomwFptmBxA3+ByWc1yc=;
        b=GrC4vKpJ3CsPgqGTknzfnPz9X85IHt+SfYZidKboL13p5Ur3sfNCf+Z7a3dc3RLeny
         9E18YdymITMZ31wvetqb94MdtegskLeOHC9QrjGoPJ+Iqe0JZDT0lmtUNdR6e8DIedCO
         aF3JzfBB0bpMDo/ZO8NBtYN5MYPrdlunidnv0NBNo+cPAT7VeLpW99PVdZsU5ShMdIi+
         Jl4ieKOwKwnf1e+p/8rF3atEuExcPblM4D3v462LbLbEsYhKxSAL2zaw4jyuXHL8vWHW
         cS7uYCTnA/4rPJr255DaUoZZUVSp//5SDt/PYvbx69yWK57r2z/Qi6uF3fvwNxY8Lvbb
         XYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795045817; x=1795650617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fduH1+3PZ/9MoDFOHCe3dYefomwFptmBxA3+ByWc1yc=;
        b=bib8jEpEzSsR38wJjdSiUIZp4XbnHwsitJjUs5YOk/MClsdOJMxQWF/OlgufJye03c
         Ta9N67T983u3Bv/7P2CvXyfBblPh6KHKrWGwlAKyIkdTg69sFB1+naOqcFhsalxyXCs3
         9dBwjdcFyqDb4edcuE6L7KcpImtYZL2PrMWA4Y/t21ekn8XAgHy/YOW7dXLVFcaoAcPv
         o4WZ9n9jt9jETwlUFr2T6++fPEyrg4PE5XOQTmCFll9eTMcu+kBRE5ZMZsQbz8ONvI6i
         f+JFhZNKO5n7q8jt0SMTQKD7FAoQrSZ6jFKjH9vjUYxrOtFu2N4Blx3Gz6KTN4ypLoE+
         iX+w==
X-Forwarded-Encrypted: i=1; AL+hErGmdSOPhHPU+zyEpronbP/8EJD+Ikfvp1RrXYQ3C912wXrxTmpRq7/ZGQxWkiqRYA99oY/Y528=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gRO0GSPtur8cj7+LaVo682U0ql4hYo5e0pqjV1l04U4gMXyvY
	j4Q+j57Yq/Fkj0YiSwWNFM9f1N1NGdzx8UCQRmGYSTE8zRT4EDeuTyBo
X-Gm-Gg: AYBFou1xbpaA6xDDv6UzQ81RSCXMzAmsgSJIJc08pWQ3DyIDvVf2Duaw+Mydbo/Lzxx
	vNnp+IvRS6qPjSzzNftzm56M29UQYaihxz0FVV9DJzu6dU/cC/kjgYI1Q0aWoKHD46S53w76Iae
	gt/66EGeQUG3aGw+VhLjR2RMCXliy7DYQBxnre/jxDx3RNUoPp0G85OzQajtwNkjBdxe1g3/Eau
	LN7CKA5EaxnjXJnkDvL9fRSgI4GDT68tcqj0PRVfkW6AMhnMzRiOC5cknujH6EpXrUWPuRjY6My
	xSIHkI8g/Vm80sUv2cTwSGQOwNM9CRs6OE4Gr/A3k5veUyoWBRMwNnbX42VSXumGQ0Z9jGRXGeQ
	OOV+YG4sgJuyOYQ/Nkf9sFxyQZ9h4ffETDsqKFqwRgYjq3AdglXfz2O55MwgymEXFT/76pEP9f2
	mY0nAVlm2dc+x6vG26PCdFxoWb7nI5d7+SztFF57mTkm6/Qto21lo/miweb2o2h/HplODUotOe0
	W98D80Mprf8f1zvpgTobAlBkzA4lpjWxGDqAqzbahuJ2s0YSJykFAoLI1SGZCZUbbO3VrXbIQcR
	6gho3UAiXgXYg1n0vZybE6mHb3otWaJRAWsAf/+8Xzv7J9STip2N0hrFbXafuzPJMGEKDhntdFI
	IaBjHnn/uVoxXiocl7WAHyMdbmYLwC2cx0qIE+A==
X-Received: by 2002:a05:6830:254a:b0:843:cc20:9d07 with SMTP id 46e09a7af769-862f093b805mr5979128a34.16.1795045817527;
        Wed, 18 Nov 2026 15:50:17 -0800 (PST)
Received: from FKXX2DL94F.bytedance.net ([72.29.204.230])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f023a1c7sm3148912a34.23.2026.11.18.15.50.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 15:50:17 -0800 (PST)
From: Yifan Feng <evanfengff@gmail.com>
To: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yifan Feng <evanfengff@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/damon/core: fix damos_walk() hang with zero watermarks interval
Date: Wed, 18 Nov 2026 15:50:12 -0800
Message-Id: <20261118235012.14859-1-evanfengff@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
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

kdamond_wait_activation() cancels damos_walk() requests while all
schemes are deactivated by their watermarks.  But it returns without
waiting when the watermarks check interval of a deactivated scheme is
zero, which is the default of the DAMON sysfs interface.  The kdamond
main loop then runs with all schemes deactivated.

In that state, kdamond_apply_schemes() finds no scheme to apply and
returns before it calls damos_walk_complete().  The walk request is
neither completed nor cancelled, so damos_walk() waits until the
watermarks activate a scheme again, possibly forever.

For example, with a scheme that has the free_mem_rate metric, zero
interval_us and a high watermark below the current free memory rate,
writing update_schemes_tried_regions to the kdamond state file never
returns and cannot be killed.  The writer holds damon_sysfs_lock, so all
other DAMON sysfs writes including "off" fail with -EBUSY meanwhile.

Do not skip the deactivated schemes when deciding whether
kdamond_apply_schemes() has something to do.  damon_do_apply_schemes()
still skips them, so no action is applied, and the walk is completed
with no region for them, as it already is when another scheme is
activated.

Fixes: bf0eaba0ff9c ("mm/damon/core: implement damos_walk()")
Cc: <stable@vger.kernel.org> # 6.14.x
Signed-off-by: Yifan Feng <evanfengff@gmail.com>
---
QEMU: the write hangs before, returns after; kunit and 13 selftests pass on both (2 need drgn, not run).
Found and written with the help of an AI coding assistant.

 mm/damon/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b8678a53b0a9..12578fc3280c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3498,11 +3498,11 @@ static noinline_for_stack void kdamond_apply_schemes(struct damon_ctx *c)
 		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
 			continue;
 
+		has_schemes_to_apply = true;
+
 		if (!s->wmarks.activated)
 			continue;
 
-		has_schemes_to_apply = true;
-
 		damos_adjust_quota(c, s);
 	}
 

base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
-- 
2.39.3 (Apple Git-146)

