Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330550;
	b=qwAlyC4GmFYzgqoa5LVsSTMhpBPBHfcVRwThANAOS+u/nfXF22EKmdCibZObhpQWajE4
	 +F0R+3gu5watB5U9kRoWXwqwOoO1/pxaOX+NLwn2qcrGk/WK1iktA/hmglmJfhH7gOj3c
	 dCACw9R/OLPTKlddKY7cvPcDhGUGo2CnN3JQr4VaYLkIVhGmdKryx7WvyacmqKFLKwX/a
	 M7vXYq8Bz3LTrbsqmfjsAZkq6HserQi1SZaXz8xrtnJDHKJcFI4FxetLbyVKo6opRJt9u
	 Eo/UWNMiv25ERq5O/FiMGyBPKto8U/AGHaOKlTvGbckTu2pB6fczY6WBWjxOI8fBozw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330550;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ozPk7mrBqFbhc4YEdxTFDg/zR3mC1mrgt4RzOVcjm9o=;
	b=oj96XYoWUtSQGVmVXit2Ji0VfN2MBj1/E36BKXdUGkzyamKripQPnrqFk6aqj6FGNTKK
	 /y4FseTipmK9ApIZ+UfyB+SW9TcTaoMejzOr7+sPNxqERoHuUErT0EFmwcMQh+rOUHQSI
	 MZTmq97pPl/Vn1BSRJ3Kge9GQLwe+F5zzaZlbaBEUG7pF8lNTOtdb0wCxTP30VLsc/zdB
	 lhNjDCq+I6uIsQ2gT4liMqxhDcLeAbeG1ULsuRv0JpSLm705LZ3mOGJMJ0H7a9R/JkG3+
	 n6tbpLfXLJpR3T9SbPGRqbZOhLp7DN4Bv7XOBCf/4WVxqxrQU0Il7+/alAaYmqgZiCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jj1ET3n1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD55F606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jj1ET3n1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47811F0089F;
	Tue, 10 Nov 2026 17:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794330549;
	bh=ozPk7mrBqFbhc4YEdxTFDg/zR3mC1mrgt4RzOVcjm9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jj1ET3n1uFe86DsXfVR1FosI7zukYeoh0/yE46Q82AyWjrVz1+n0fnXhgcNc6rxed
	 91sV8wKwSrYpPGUxX3u7dSff3RefXwT32DpLW/YL3+/d2fkgfRZE+34ZuWe+u04HJX
	 u8c1WfMvHUT3gVEsSAajaQ7R4lMVZ6imUBKWk/PNYnzZCxaPbw11LWc2FBEWmqSSL+
	 kgXOYXFBssuYWn7frK1tjnZKPNTYkbwM37TIbFpVAxzl8yCEkUTuJPP6l881w7LAFu
	 PifSeRdM4G0XohecQxevjmR+Dw0GF/t8uYRNC28DU0f4jmB4VCvvmCHZaZ+/3CakXP
	 4kHniXZlj5Tvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Jacob Chen <jacob-chen@iotwrt.com>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Michael Tretter <m.tretter@pengutronix.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] media: rockchip: rga: fix clock cleanup
Date: Tue, 10 Nov 2026 12:09:05 -0500
Message-ID: <20261110170859.2632294-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054358-failed-6.1-a875c43dd95e@kernel.org>
References: <20261107054358-failed-6.1-a875c43dd95e@kernel.org>
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

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit 254f3337ce2575bf94f1fb40cc40fdbc70371116 ]

Fix this smatch warning:

drivers/media/platform/rockchip/rga/rga.c:734 rga_enable_clocks() warn: 'rga->sclk' from clk_prepare_enable() not released on lines: 734.

The reason is that aclk should be disabled/unprepared before
sclk, instead of the other way around.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Jacob Chen <jacob-chen@iotwrt.com>
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Reviewed-by: Michael Tretter <m.tretter@pengutronix.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Stable-dep-of: a875c43dd95e ("media: rockchip: rga: quiesce IRQ before releasing m2m state")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/rockchip/rga/rga.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/rockchip/rga/rga.c b/drivers/media/platform/rockchip/rga/rga.c
index 9b20cef5afc61..4c4e8eabdbdbf 100644
--- a/drivers/media/platform/rockchip/rga/rga.c
+++ b/drivers/media/platform/rockchip/rga/rga.c
@@ -717,10 +717,10 @@ static int rga_enable_clocks(struct rockchip_rga *rga)
 
 	return 0;
 
-err_disable_sclk:
-	clk_disable_unprepare(rga->sclk);
 err_disable_aclk:
 	clk_disable_unprepare(rga->aclk);
+err_disable_sclk:
+	clk_disable_unprepare(rga->sclk);
 
 	return ret;
 }
-- 
2.53.0

