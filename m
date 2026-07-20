Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43283D333D
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 09:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540824; cv=none; b=SLDAUpc+vgUC/RCL3od/QEuc6wuytx0hmE7cHuKC8R6iW14adhzNz7Mn+B4RT6v1MDag0sPelCD0mdnhTlh68V85TvHy+VZC1w71+EXEbMMPzyy63THiXnP+lg6xln8H8Y48/8QPejUmaKhFY4obBYDhvoN2pUSbKZrKTRMqYm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540824; c=relaxed/simple;
	bh=zTW8TcHF8TDtepKYrWzArP7NASIhAQQrPY+zcVWwmVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MnLI8cPZl67n9EqaXCMmDu3A2bvm4zZd8Vfa7CsPXjek/bJE9HXqi4plPweIUViKSYRs0l/RiYYaQec7P8lWMsSaXRAR2NMzs/SM3HpweCvuBvk5OIz8nKzj323wFDBv34YviH7OGcKMvG9sBvAvyD0gyKnOFvjt7GO6e4hfFEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRrEXHxI; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRrEXHxI"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca7c1176317so7229249a12.1
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 02:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784540823; x=1785145623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NXXO5Tq1xzHOucyWExyfULz72X/w8Civg1XxI0ISuio=;
        b=gRrEXHxIstKmT+WUP95icE1mrrELXtT7XWQRmqfuzeIY0bMfgojYrmTTXiKDjFdk2F
         ZRjEQ/gRrXjUVMJPZQu+y0SfyAjSdOlLfdMtGVutNQ6OhKeorKp8uWFzl1PB1mEdleWQ
         oxa37NUgfwa19EiJWSQWl7meeg+Kg+9N6x+VpDUVUKI4VEAQC6GP2QSMlppwkpaOHQOj
         2gdQtqEXXiX9HbOYd8rlkAG9F9bx3tsg3xfET+MeaSjzjG3bPbBe3scqYGPMB9cxE6VA
         ZiuleLBsBhozGkrwjk6l7sJPioL92r2sPBZae1K9NX6ep7GlmkYk1dLiT1puYnXzMViO
         qICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784540823; x=1785145623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NXXO5Tq1xzHOucyWExyfULz72X/w8Civg1XxI0ISuio=;
        b=nWjVWGgP6tHjqSJVFJH/S9C8jY/oqn9aoPGpisT/cP4LkeJHhA5Pr3ZbDaJndK/adw
         LvUSt5X2GEL6qF57iAWfos3Cu+lweTuYKcrekjQELheiO0nleIOrECLyypS80CsdfxgM
         S66/bSJfAdjChJX1htoADjwjbnZyJgzGMFZ9FrTBUzuDpFCUDmmuXQiT9tr6N7qU8xr+
         MobJmXGNhYfjQCwpwopBBtz36vsAeM3cUdR9KWZ/lyIjOI3FtgW11KrzFvQ6FG4JPrkM
         Gk1/p/S3JpB4oZq0plCK5/gKcOnUA8p80y40raLC9X3aHAopyjCAXo1yaDc6Ec6slf1W
         rikA==
X-Forwarded-Encrypted: i=1; AHgh+RrmdsqhNcKGSY2yxqOHFUgVbqWLDQWlu8J++9seMAgPMwnhj5tkaP3eOCru6TvaZ+nD0YSxTbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEc/Kv2CDk36GssSratmXjnhWXLIkr+CF7Uhnk/4pOitya/2a4
	4VMjMdPCfNSg2hkvVFaVdZVYhjMdUwEgaZHmlRe3Nl0/90wctwW3DAJ+
X-Gm-Gg: AfdE7cn4VEVibGEZ8n96bVgebX2yXKgRdd/acOWB86+HRNSV3FmazfjSzZe1k0++qKk
	MXyrqGDtmiq1++87UwtgOtFHFCkrzFO6qlEujI7ZLe++LfhGG/eSN8ES/IxWo0gdxB+lo7KCtMY
	6DDAjKqa9dD91SGFN/NqlOCTKb4UOcyCx734zYzAysRtH8d+i14FjfeYQCOqXu0zW+/uZjoJKTF
	Ju91u8p9w3sKUwHC+mik5FPC0/IOuMpWxxzRCCZak1wk4aCiGFq+LNWw2gIUHDAbyhw+B3tfF2a
	FoWFwkaX4qltiBiceQYb2kInGWqjZBgvryMVlQM/Eiazj1cv23yTk1fsUaZHKGhXvuycJoODEQw
	3d2frLIE8odQJIJCK7OhZ8ZTiTApDFh1Bspy/eACN0/AIwM5KNSgtF9AzZwh3DwGju+UDf/MO5B
	NWnXFtoIItwU9qIxJUjxstb3wWvyHUGw==
X-Received: by 2002:a05:6a21:488b:b0:3c3:bdce:27c1 with SMTP id adf61e73a8af0-3c3bdce2f1amr10290377637.51.1784540822955;
        Mon, 20 Jul 2026 02:47:02 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:8d9:11d7:8597:c44b:bbf0:2c09])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429f9bcccsm39349563eec.4.2026.07.20.02.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:47:02 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>,
	stable@vger.kernel.org,
	Yikai Zhao <yikai@z1k.dev>
Subject: [PATCH] mm/damon/reclaim: fix typo in damon_reclaim_timer_fn()
Date: Mon, 20 Jul 2026 17:47:08 +0800
Message-ID: <20260720094708.243937-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2f54908fae211 ("mm/damon/reclaim: detect and use fresh enabled
and kdamond_pid values") introduced a typo in damon_reclaim_timer_fn()
where '!=' was used instead of '==' (unlike damon_lru_sort_timer_fn()).
This caused damon_reclaim to return early during the delayed work,
breaking early boot parameter configuration like
'damon_reclaim.enabled=Y'.

Fix this by changing '!=' to '=='.

Fixes: 2f54908fae21 ("mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values")
Cc: <stable@vger.kernel.org> # 6.1.x
Reported-by: Yikai Zhao <yikai@z1k.dev>
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 mm/damon/reclaim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 016cd8d83ca9..bb4b705d842c 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -198,7 +198,7 @@ static void damon_reclaim_timer_fn(struct work_struct *work)
 	bool now_enabled;
 
 	now_enabled = enabled;
-	if (damon_reclaim_enabled() != now_enabled)
+	if (damon_reclaim_enabled() == now_enabled)
 		return;
 	damon_reclaim_turn(now_enabled);
 }
-- 
2.55.0

