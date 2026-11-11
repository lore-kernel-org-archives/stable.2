Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410285;
	b=BmflkH+6NP1X36ctNPrvsg7c9Uw+yLkhTjVzXHBqskbkNlX9Df5EarZPdueSJ2Tk87Zi
	 yYLsTJkiO4K6eexxiU/ZK/d7dKFtjY18ZQDD71ChJlYl14CAmRgSfpRjJTLkBV8UgTesO
	 Q4I+q8B6jdAhfudkG4B8vwkP0EglFDD7eQcICvMxuxDmOxA6PiXpMBrUi7jy9vBp4oE4f
	 T3RYMuRi0aKY/bSDvLmSPRCTyGarIhB2XtIMi5yjmBKyEcqog++vRi3M2r3rIcSvWUBTP
	 lzpOe3YQ5p7+XQa3AKvWwSpon414bmXrzhLFdvAPDcGeEO/Loj/WDG7K/oj6lDujMpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410285;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=i8WEC1d42w8jQAxaPMEGYdL933h+MmxuX60YZNJM8Rs=;
	b=gOtuZdgLOGSJ97svX1b5zHJ0udEASIizLvuCo0gp0ZuUIv0r4fCZnqqv+H9V4cP5wsVb
	 2HlrIgcRhiHN4ulOwlysGDZqoqbZ9fjetTGMrcN2pKuPK2dBH4AlJvq8O/moZsLiEb1n7
	 VdrlLMPGLI8e3WjUMlWupOc9TCot4vaH0NYGwpm39fmu51z506YTWRUUabV+pPkw5ZoTC
	 OUE6ibxF/nt1PnkcBzf2bYyicWqJ/URHC3N/bpDo1mQlvzvi9tsliUTxBiO4BQnGmg3sK
	 Q1T/iWB9cJyFvP1WWcYWqJi610SVD8+5pIhT4w435iB9rjdYe//dIgtzp4ROQyq6nOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="b8l/10EA";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F756606A32D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b8l/10EA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BE51F00A05;
	Wed, 11 Nov 2026 15:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794410285;
	bh=i8WEC1d42w8jQAxaPMEGYdL933h+MmxuX60YZNJM8Rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b8l/10EAmQkUAX+g2o4YJpyGTVOkwLrVjbtcIDgxdBLdmER0LdFRwmlTlpdgvzUOz
	 1IB7kfL0I6REGbm6+vz3sbiQfLsyIodOp75yx94XDlJ8w4sTZ6IYlISEbONfeL3tDC
	 vcu4EqaxBTf8A7EJqPAjj676sVd+nKIO5Zw6pwpuwhkiVR4XJViYsRCy0isQSAMT4r
	 3+s7x87YdtUVSpjE9ndjTJGRjAavRvz9xDX1jiRA0dJ78BJZ+SazJt8M2Q+p7i/Xlv
	 KLhJhsEHBCyj0XeiFq2hu+YMSoUgk/gALOYN39L57s/IH/dhjv4dNfb/QwgjOSsI+N
	 FpSnPvAQjbK1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] media: serial_ir: Fix race condition where timer can be re-armed
Date: Wed, 11 Nov 2026 10:18:03 -0500
Message-ID: <20261111151739.2623242-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054233-failed-6.1-d74ac4016ba6@kernel.org>
References: <20261107054233-failed-6.1-d74ac4016ba6@kernel.org>
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

From: Sean Young <sean@mess.org>

[ Upstream commit d74ac4016ba64cb3b20f395511d0b18025ca0ba9 ]

Ensure the timer cannot be re-armed.

Fixes: 2940c7e49775 ("[media] serial_ir: generate timeout")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
Acked-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[ sashal: adjusted context for the existing del_timer_sync() call instead of timer_delete_sync() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/serial_ir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/rc/serial_ir.c b/drivers/media/rc/serial_ir.c
index 96ae0294ac102..dac341c68b2bb 100644
--- a/drivers/media/rc/serial_ir.c
+++ b/drivers/media/rc/serial_ir.c
@@ -797,7 +797,7 @@ static int __init serial_ir_init_module(void)
 
 static void __exit serial_ir_exit_module(void)
 {
-	del_timer_sync(&serial_ir.timeout_timer);
+	timer_shutdown_sync(&serial_ir.timeout_timer);
 	serial_ir_exit();
 }
 
-- 
2.53.0

