Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB0D411661
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376138; cv=none; b=HqxS7u3eiJW99+LBv+ubgZvcVluSOIjbqdT8ykkr75JdhDTmKpW1WAjyVbzQRgGITEm6v2+eHMvBvV487bSx91aHxdy194mWl9cAZsPFlfqibiSVuRL9PKzLyFDPRVmY1VsMutjUREZk8PYaOaM/0ugcg2x9bFkhAMQho20+DiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376138; c=relaxed/simple;
	bh=RvwfwsibcIKVeXocpg4YyIcnyvBRCDfLjxr1o0x/eoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iY4r9hP8xFxbkB5amW/l6TgfP+ONJcWDVDFMYT7KrGWh1ga5i4XruEhz0uglwcdg6qFHI3TsJjpjv6s0cF+u2zcdyKgpluqCeSOCGhsgJSVZ+vlv4PfyXu8W3uVF1B/BzqHlaNtQIuRbCsoGEKkYO78Hn5w8MZ6dyBlJ9kafwAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awJgfLgY; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awJgfLgY"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccc09d65so1708486a91.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 01:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789376133; x=1789980933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NHO8MqohSxSNmUhoqWgAJs04LZZgNjwjhI5rapZreFA=;
        b=awJgfLgYusmxP2DeGei/AKFb0VQklQzErtugbI8dZpAJgWOewxdNsSh4xYrK6OZxCi
         NA7RyH8IjkFQjW8rM8W1zEmFN/h8n5zjex/sPsSgp7OF6cVKhfSMgqACSuUQBRNaHJcg
         Y+Cq53rvvD0Hi84Sety6F+HiCJlzTxu/nqtkt6vXMQ673V6XzSKKK8pyAjYywuRZ0mwz
         gY/GwDZGcPGWeERfIYkU7SPIGICWZbwV4+S3dzaftpU89LfA/g7fZvxxUoggZb0ys59n
         EguyZkV7OuPJILWGCoX/OYuntOitzdwh23EaJvMPrgfKY1d61n8YbrgkusgBJ2Agnm1t
         4F4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789376133; x=1789980933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NHO8MqohSxSNmUhoqWgAJs04LZZgNjwjhI5rapZreFA=;
        b=AQn6PcGco2BiY2AjTpr7gvgAEYznfzFxgTDTqkZYToqQibbKgaOPj4atG/p8EgLI5N
         rGK19+53Pivc4Ll5YduUsPFMEySvpkAE3u7mjiq/OiF9KGaxGZldGC1d8c11sviGY0Pa
         iKaOGcXi30ZZspudjQ/dnegBDzh32du6JlL2xQApdHF1LPncjCDUKQVwQuuZ0Yxns6N7
         ny4GHR+3/m0jSxYAvQcp/ncLtvyh1k6pAp/Kz1sr1y7ZHn70Ms3/SATFTbgSb6+dBYwA
         XfWCQAPhmEJ6F9qMydp/aS2b3eoZJaQZe0e2JQISl6m8bt2Zsa10Fqnn4Zc+Cvx6fzy3
         vB0g==
X-Forwarded-Encrypted: i=1; AKwUvByURpn0VQFbBJEavEsBdwQqQ9aRLgy8vhIZk4YnFsn/dCaL6x5FCEePwfE9yDa3ica1ksjA0AQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nQSLU1WPzwsprgVqv1JGhGosKTlfIgWdtiXRjh8wXk+1qSvk60
	GBRuaerLMgfMyB5s5QFI42zptc00iqGfoiythmdoiqnNFgRXzQc7/8PI
X-Gm-Gg: AYBFou0F7wD6bAUxG4JgJPKaL5aQdNbBt8OE2pLkvsTLfwofcfxb0ONzOflaZ0onN5B
	y+7+2Amuoy1z5on95Lf0dt6Bh2YnZDpGOuoPNpOK2ah6x5+w3U9KJ56Gz9MWGfsy1oQoZ+GCZOl
	hXCxJxFE8g8U1dndRkMaxkJ708bdPOWcq1Tae6zRe47DrVmP8Sx1ebnTcljdzx5TKIvjBsUKq7/
	W/TcP7N8CdGooT78cZOGuO4nNj8snWZIPlog0T8lDxlVoBx9b5Cgty8TFR8C6C/TKVbzGEv17dM
	Is6bYQlexwUdAsMq0S1QG0IR04VQ1cbsSvEtB5zn2kLpZFSm5Z1sgav4H5uZL6r0zs/+Ola0vaQ
	A2sRiYTL/S8HI3v4lA/UoMtz4JbjsrRhxa6m7Klnr+oMFfGD1VFLkhCAYWKGw5a5Htoc0wV0KFw
	i9nT67iPh+jHYw2bP5ONB0DJcEHDcuJ9C9kCRcX0Kz6NIJITTyCTpcSw==
X-Received: by 2002:a17:90b:1dc6:b0:39d:84af:a0b3 with SMTP id 98e67ed59e1d1-39dec09cf6dmr3712915a91.18.1789376133103;
        Mon, 14 Sep 2026 01:55:33 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d9d7ff2c5sm4885197a91.2.2026.09.14.01.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 01:55:31 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Ed Blake <ed.blake@sondrel.com>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: img-scb: disable autosuspend on remove
Date: Mon, 14 Sep 2026 16:55:19 +0800
Message-ID: <20260914085519.1665498-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

img_i2c_probe() enables runtime PM autosuspend with
pm_runtime_use_autosuspend(). The probe error path correctly undoes
this setting with pm_runtime_dont_use_autosuspend(), but the normal
remove path only disables runtime PM and leaves autosuspend enabled.

The runtime PM API requires pm_runtime_use_autosuspend() to be undone
with pm_runtime_dont_use_autosuspend() at driver exit unless runtime PM
was enabled with devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() call to the remove
path so that the runtime PM state is fully restored when the driver is
unbound.

This issue was found by manual code inspection.

Fixes: 93222bd9b966 ("i2c: img-scb: Add runtime PM")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/i2c/busses/i2c-img-scb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 88192c25c44c..9cfa403cda8e 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -1415,6 +1415,7 @@ static void img_i2c_remove(struct platform_device *dev)
 	pm_runtime_disable(&dev->dev);
 	if (!pm_runtime_status_suspended(&dev->dev))
 		img_i2c_runtime_suspend(&dev->dev);
+	pm_runtime_dont_use_autosuspend(&dev->dev);
 }
 
 static int img_i2c_runtime_suspend(struct device *dev)
-- 
2.43.0

