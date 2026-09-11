Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FF044AB88
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789128521; cv=none; b=Y1IRi1knSWvkGUCM5XsNVvwTSqttyD7G+9rw70YJlyIfwwcoGrm9klX8rw7z0HGJczpXeeacOfGGToSYgDKm1lx9k0yjpecacEeOiucnrs7qjpEDdBboojHsSpnBhrXK9w5BjZHd6JKS7xfG0Ga9RFeoZsJv6SMA2Y0eZf4Qs48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789128521; c=relaxed/simple;
	bh=dxyVo2oeRJ2/e5H7gkIsKAYiyS8Ke4ZPDP8ucAOaYYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCyNaOIIHKpUEw0UBt/gx5dJtVLSIjhKBmQ9lFeW3kl1RlzMECtTzulPQTtKAt9mpa2BENL9L51KCeBEBCecuee39JTRDH30GZvE5qPnoR1zJcltbMck+J8rbIDFehXY8Xr0XCW83C/AA0IX2msyxA1jBFT7jBjj4icYssOAiZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAcSxYYK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAcSxYYK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F5D1F000FF;
	Fri, 11 Sep 2026 12:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789128519;
	bh=Lxan71TKAP9LBMIRepbrB9PWl18IXnTLXn0IcV3uqTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YAcSxYYKTnhYRksrzkgkdIZP5TurlQfTAtMm+/ojMXuxeTaHM2XKhWgpvwjFBNAS8
	 PeV+VDoIuGbS38NvOR3eCAoU2C4KPg/VDGIy09upl9VGsoJsODfgk3qdd+9v+vuYC2
	 k3/jkxpKIVDFggbecg6+eNnLV+V8cHp1yrMwHS6gffHm4Mt57lRykmTTphPPUqmzbb
	 lOJXZX6kOQniyhLfIQDmCxJe1BVDUbWu/9jwbYRvuoeTuCwh2uY2zk/KxfIWMizND2
	 9OQhXg4UI4f3gvF1TDEVaJ7j6pCXW2orxBPiO2dXT4TOQqAZ8AANJ7g+pJnmLicS3T
	 /z38ftv/Xj0mw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Narasimharao Vadlamudi <ahmisaranrao@gmail.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] media: rkvdec: Propagate platform_get_irq() errors
Date: Fri, 11 Sep 2026 08:08:37 -0400
Message-ID: <20260911120837.494377-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090928-froth-sprinkler-1445@gregkh>
References: <2026090928-froth-sprinkler-1445@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Narasimharao Vadlamudi <ahmisaranrao@gmail.com>

[ Upstream commit c37aca64206fafe938119e801a3fd10a537a051f ]

platform_get_irq() returns a positive IRQ number on success and a
negative error code on failure. It no longer returns zero. The driver
currently returns -ENXIO for all failures, which loses useful errors
such as -EPROBE_DEFER.

Return the error from platform_get_irq() directly.

Fixes: cd33c830448b ("media: rkvdec: Add the rkvdec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Narasimharao Vadlamudi <ahmisaranrao@gmail.com>
Reviewed-by: Detlev Casanova <detlev.casanova@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[ adjusted the patch path to drivers/staging/media/rkvdec/rkvdec.c. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/rkvdec/rkvdec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index a1d941b0be00b..85dcabe11bf9e 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -1044,8 +1044,8 @@ static int rkvdec_probe(struct platform_device *pdev)
 	vb2_dma_contig_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
-		return -ENXIO;
+	if (irq < 0)
+		return irq;
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					rkvdec_irq_handler, IRQF_ONESHOT,
-- 
2.53.0

