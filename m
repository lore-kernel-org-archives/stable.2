Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362873;
	b=eySA+VLU+V2rqIhK0RmS+cYX7bE1uo0ggip8WUkzUL7eB/wT5B3zze2c+uAjXc5CI80h
	 kKMyiIy43ZxE7OimpQGHbbSoNbdccuQ14dawmtZQ5IqCJ89+xA2VQm0eNlXPjt/CT7nAq
	 duKwEuivO9YHsuzIDWuS7m1bCLUGn2AvrdUQIvTzCaT0midvPDyH+Gnmf+q7XYxZ/W1qE
	 iJ7tvVKdJqhsNc68C0dUg6w1r/5YQsYnIpk0yzxecdYAt/LF1koJm6tCwhBmAkRxWsJrQ
	 GtKUipDDxWfgj2gsWIHOTxrzOySVm9h7Cz8/SWazRMLHcXefw6jeekagFB768F9wh9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362873;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=n2nhmqevJfiSJQacOvaAIJVpher3ZVDBVd+ze/2VYdc=;
	b=4s7uVE7T0UUoqpHwDl9zs13/NuLW2pfJPwOmXeD6pqHaQQGWoTjLSmdMtiwAkf0MMA9w
	 5+bgu39JpUrNRVnMwIfXAX/5jqbg3w2GBbtEB0gDRMRxni1ajvWNzxC+RI8PsMcLcjNoV
	 jnrdkDIc0XNYczPkfqz+lJsdjAP3wBAKa0FA69t2zdzqlON5LL/45QGY1ITee+Apr2yIr
	 XwNY6I01Myk8vQeVv59/AxB+LiTUG3qk6c4GohaekxWHafdbGWuG664tAewqtLTaql02r
	 /f1KtalbdqShPS1ZvS9NTZwGipDvOx4UUItdJXy1KFU5Dzbmp2f68QusJVQhDIHT6mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KY03J+QY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F2F606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KY03J+QY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6F81F0089F;
	Wed, 11 Nov 2026 02:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362873;
	bh=n2nhmqevJfiSJQacOvaAIJVpher3ZVDBVd+ze/2VYdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KY03J+QYqnqm/mPh3JEthzxnicLqWvKR9MqjjncrGoc0Fz2dRweFBvtRj3l/r1sqs
	 HXXjaH/KHNx4adcwOKOFYinAxDegWKQdAlvZn0+PFN/ErDAyht/vPPGPYQWOJKnTZV
	 YtUkJfgV7B9t3JzXLyku+AoUP9purrQ+Uc1sipF5c9NcAWmE8EW84qywMFRcACd6pC
	 +n/ZWKooZvs1muhW5lvVD+ao1ZWMT7QPItPT1Bu6QRzOyLHd/84Rfuq9YF+nnFeKAU
	 Z8VmKIKv9o1/YkIIepAYsuDIHs7KY+Eirj7xuhMnxxs7eSUPvjld1zc/+BVaclOt3A
	 wWQpFSHSP2mwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eugen Hristev <eugen.hristev@microchip.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] media: atmel: atmel-isc: remove redundant comments
Date: Tue, 10 Nov 2026 21:07:49 -0500
Message-ID: <20261111020626.487609-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055759-failed-5.15-d8983c47d4d9@kernel.org>
References: <20261107055759-failed-5.15-d8983c47d4d9@kernel.org>
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

From: Eugen Hristev <eugen.hristev@microchip.com>

[ Upstream commit 1f0c113cc7abb435e531f5777efe2ca757e1361b ]

Remove duplicate comments which are already in place before the struct
definition.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Stable-dep-of: d8983c47d4d9 ("media: microchip-isc: do not touch WB registers when not streaming")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/atmel/atmel-isc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc.h b/drivers/media/platform/atmel/atmel-isc.h
index 2bfcb135ef13b..b0211100a5f23 100644
--- a/drivers/media/platform/atmel/atmel-isc.h
+++ b/drivers/media/platform/atmel/atmel-isc.h
@@ -261,7 +261,7 @@ struct isc_device {
 	struct video_device	video_dev;
 
 	struct vb2_queue	vb2_vidq;
-	spinlock_t		dma_queue_lock; /* serialize access to dma queue */
+	spinlock_t		dma_queue_lock;
 	struct list_head	dma_queue;
 	struct isc_buffer	*cur_frm;
 	unsigned int		sequence;
@@ -278,8 +278,8 @@ struct isc_device {
 	struct isc_ctrls	ctrls;
 	struct work_struct	awb_work;
 
-	struct mutex		lock; /* serialize access to file operations */
-	spinlock_t		awb_lock; /* serialize access to DMA buffers from awb work queue */
+	struct mutex		lock;
+	spinlock_t		awb_lock;
 
 	struct regmap_field	*pipeline[ISC_PIPE_LINE_NODE_NUM];
 
-- 
2.53.0

