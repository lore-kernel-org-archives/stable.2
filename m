Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CE6466B01
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129588; cv=none; b=Foz8shfeBA9GESVGOIUCQqOwTKN2sMNaheHH2KHKfEwvXRYvi3f0IVp+CIqMwZu1NmlTgTP0QZgX8SP1d/I3KUKy+Ej9N2ntNpkjIn2mvaIgm47JUhITwJDffHqSv5/eWCQ3lxILDhby3Rf0FrBxavNbitC9Sx7ZIBTUR6iJFs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129588; c=relaxed/simple;
	bh=S08cZfQohHE3JHGTBtxiB0Z8qzcGhJgVcZo1+VRzJ6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oi42H9tLcaaWFtxMgef+xGufV98mR9u9DLWnsGhIgQ4zp807izwybof6/oaJgEEBPzsTfNcWMh0FjxS5Xlv9KjdYNfGFKcrEbu84HuAWvxm83wWp4iNhCobwWYA6cD1jwa22tdjjyqNEvd7GortHoB0ai8yjMBALWiR6eNT0dos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcLrAfdd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcLrAfdd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18B21F000FF;
	Fri, 11 Sep 2026 12:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789129584;
	bh=tTsuF/JTiUbERVzbGhGJ+vT8hRzI2GBYOpv7By6G0E0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WcLrAfddnOWtQMdd46cWOl0uywt+q7e+ZQRb8FUAH1bFZlsDpGqVRFrsN0a/HREar
	 gaA1GKwDzpAjj/fI8t1MFWsTBz28yW7pYSytdz62Kyz+HCNU8EmtJavnmHaVUWUkGO
	 0XvxI3OMReLc8YM7FJNcRisknXWELPsWVaCCHzeiXnPModO7+aaCHO0uPWVbkr5TcU
	 aYUY8inM1b3r5VR6fyV7RlCvnk/erRnM8DKIGx01vYDlNgQMvKGM7ZbomBR1L32v94
	 zc+RgQUk1CSEwM6TE3/YonNyPbZc8t+SYpDOvnOT1WAS6BbtshAmFee2AKTlhMzQQ/
	 K4i1+WJhJNLqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Narasimharao Vadlamudi <ahmisaranrao@gmail.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] media: rkvdec: Propagate platform_get_irq() errors
Date: Fri, 11 Sep 2026 08:26:22 -0400
Message-ID: <20260911122622.540312-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090929-dictate-motto-3cf4@gregkh>
References: <2026090929-dictate-motto-3cf4@gregkh>
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
index b5847259f4541..0b19a089e56ca 100644
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

