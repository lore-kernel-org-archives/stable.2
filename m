Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94C43A7193
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782131205; cv=none; b=kTKOkxRFSj+QPnoQc3xuKD05LQ3krvHbKvhHtw3DiY3xQRW6uFOSe1jc+qsEFCGsOL6ms+amm71mLFp1mtCAEYtQb22h6+3yufYgYEhozQ+n6GqYeRVOi26CSS945C5u27RHFlKkXJFfDGuRUEUetLag8FBQkF2k2Ya+o5+dIJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782131205; c=relaxed/simple;
	bh=5Hu2qBT5Fk+1jqMEqYg5XniloZ1f4s6qcip4ZB7U0mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNBvxthn6vBwnNRdFdQ22d62t7PKXT0q5JGt/A5vbPfPRp+4qJxBo4eVLGaTovN43tsd1GAByE5aVKnin7wVxE05WGosHVtRFoyd5RVXUQ+ddRbhZSpqU6EZ+XLCzewmGIHYiJjQG1B8nfi0Hlnr3uG9o/li93kSRwdJ0u9Wr7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZC8yXWoB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZC8yXWoB"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4908b92904fso62822325e9.0
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 05:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782131202; x=1782736002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWBXR6ADAVQ2Qq7HEur2Os4QsmTGdoI3snIfzoQqpdU=;
        b=ZC8yXWoBFufAAyaqgSHo1nF5A2AfB00Cd6gWEG2gw0cEd83YcYWGJioHM8LLG3ercF
         WL9eITgo0jRiyGNMrGVzZGQNkR+rZ2oFhe4SQzUAdaEmx5749cqANoaZ2DSGwOBebrNE
         5ryqboqogjLZSd5WNx4MDGt1c3LzNTBkXijr2+6HaIJsPeNJEgs+yefgtRqrLzQngNXu
         u7I3XfPb0DT94l5lnUJLG+C50++MPNmHBrYh8mr5UgcSeUyJ2xjsuTltVr8DPuztlmkp
         CRl9WIpHd2Z6EIjG7w6z6z7SCMAOQRg+l0BLqco3JOrKfnDFGAW/5C9WE8AOkTPhpfV6
         He9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782131202; x=1782736002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rWBXR6ADAVQ2Qq7HEur2Os4QsmTGdoI3snIfzoQqpdU=;
        b=TYdUHcO86nJ+TrZezgJspDxk/SjK8fb2AePMXlnL4aIewk9N9PDiasP+ITI1m49BJh
         +ysVyO4oB0dSfqLSTTKmSTX5auGxY++UAiIkwSO93MxbrCnZOd+Oq333CeOvcBEy1+kG
         OxfsHf66h2BU/En5iEhXKrYm7dzkgn1XjuHjVjp8rthsJuPHvouGYWkIeLL6vy16syG2
         mGAg4oCM0DIO5LmYZOmtzydQU//0Vs5kEsVl+/jmV4D4/4d3MsF9nWnMO6RLhJK5G0pD
         a4m8sAfonDF2Um8diqqErgM38VXlyncaDlnQG3OMp3mpevrF0kYON9KXr7J3VGtBy6cZ
         6zng==
X-Forwarded-Encrypted: i=1; AFNElJ/X7VQp36ajzPd61c5btnuYhYrgVPYRY81bMcyCqj4TtyH6M7VgjKjjw7/zY+fnHR8z7Fmuycc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb4De4k4fclvrIpl/M8samQAdlfPSirr0AvgeEMlSemqcR5dhv
	3gCeWzWkpC/IM43GqBN08Mf4aACXEczi3cjV05AUfpta80qP5pIMD52m
X-Gm-Gg: AfdE7clj2q564lnKk7Q3aAoo0hMIYhR2E3LoDsKGqyxHQQiuV+xNsm9PevTlzha7+9m
	1eqpBm5Yn72CI24dU5Vh8M0cPUnY4Kqok3kraphbqUZWyIOlVSxGCBfYtmI8674nNyqXVYKucd7
	CgQ54IlXccHwVz8h8UQ8YWNUIoDvdNdGR3W4OGXMOsjjbzbj7+AoYFOZl8cSt9DcCuTUvc46a9y
	MWV61QYvWbrdhOmeLD01ze39xJWeOTYIw46s0YXa5nSlvHAIwYePFx82a2p62BluZ99Ydm8BwvP
	FJEOufqzMHy9BAgh93s/57vKE0Tg8hBdDwoMdbrjJL+7Zozq9AUVU/Uc1C54swt0aUx9PlRwQjI
	SJIR+kILM56iNY+oWKVQRiP3bKKYFY1lGkhDMx8AqvUro2s09GK8YZJdvHee7alQJcOdFu7/bD0
	+0mgabP6+VwU6fj1Ux/wlruEx77HiOiNa73TRCYQ==
X-Received: by 2002:a05:600c:5493:b0:490:e190:38f3 with SMTP id 5b1f17b1804b1-4924256fe84mr192162475e9.21.1782131202105;
        Mon, 22 Jun 2026 05:26:42 -0700 (PDT)
Received: from anthony.local ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240ee9bc2sm208803975e9.1.2026.06.22.05.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 05:26:41 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Jocelyn Falempe <jfalempe@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Amit Barzilai <amit.barzilai22@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] drm/ssd130x: fix column and row end address in partial updates for ssd132x
Date: Mon, 22 Jun 2026 15:26:02 +0300
Message-ID: <20260622122604.32500-2-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622122604.32500-1-amit.barzilai22@gmail.com>
References: <20260622122604.32500-1-amit.barzilai22@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On partial screen updates, SSD132X controllers expect to get the
rectangle addresses as arguments of the "Set Column Address" and "Set
Row Address" commands. Each command expects the start address and end
address of the row/column in absolute format, however the end
addresses were being sent in a relative format (relative to the start
address).

The relative end addresses work only when the start address is 0. In
those situations, there is no value difference between relative and
absolute addresses.

Fixes: fdd591e00a9c9 ("drm/ssd130x: Add support for the SSD132x OLED controller family")
Cc: stable@vger.kernel.org
Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index c77455b1834d..77aa5585a46c 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -864,12 +864,13 @@ static int ssd132x_update_rect(struct ssd130x_device *ssd130x,
 	 */
 
 	/* Set column start and end */
-	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_COL_RANGE, x / segment_width, columns - 1);
+	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_COL_RANGE, x / segment_width,
+				x / segment_width + columns - 1);
 	if (ret < 0)
 		return ret;
 
 	/* Set row start and end */
-	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_ROW_RANGE, y, rows - 1);
+	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_ROW_RANGE, y, y + rows - 1);
 	if (ret < 0)
 		return ret;
 
-- 
2.54.0

