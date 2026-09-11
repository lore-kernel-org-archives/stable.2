Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9753943C055
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130836; cv=none; b=PghGhpqr3lD5NZX4xRleSyVzH1LOImFzHjh/svku4xN99n+w5NcZXsbztHCPmLVn12mkZNqn7eWK8xMitb3Amxd4B/jb2EO/hRyGi2HwnchvpKkv1rCTNG5809kBKIcSf1RVSoJalZ2vPMblIEYKw8QlL5mmQBVebFqgmTEl+wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130836; c=relaxed/simple;
	bh=3DFvITyVCAvUBssENxStXNt2264GeYaIN5LCnJ3xo+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/UMjvPsIeFO9F8qPhSA6W82c5aElYowBJY4LUk4OiYbtlun+Noe3HzVuJsUwy56E+zIYshME/jw9/1WBas0oGVy6Orc3/WjQjMmoNrg7zXuaP3KY+gxzQMnmtsetClWLYCGc5iEH+daUFFJrSM0hckg3w9MT7ab3T84mW0SFLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mn43r35/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mn43r35/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D941F00899;
	Fri, 11 Sep 2026 12:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789130832;
	bh=O7wLYpnhl9BZaRPcRwKVxlME1c8ReAp5BwMtmXUlmG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mn43r35/GO0t+ntNxVoqBi07I+rlsAC5hXQQZUmovfA8HUCMeFj8p9+KIdouCSmAu
	 lpKbkU+a3hClrFLSTEW8PE5p6wreuegnw40Ye+sbE5Gzvwc0Pjcim/OqcObJWZYESc
	 y2oF01/U6Q6cCe4iWpsenUC6V+JMaFVn1vRRQE02+eeDndJTT+Mbo9nchFIWVu6x5w
	 XzIYim/qEQi4IpNqFDekLSN0iq8sAb1n+X9ino8vA4TUEeiKaOGSAttffjRY/jWuhO
	 crZIdRoh4YcDoCqlI6KyLltk+vsIEcmK2bPPz9Dffh/4RPeYeiKya4v7H3t2j9uL4Z
	 NPeqmU57TPxmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Narasimharao Vadlamudi <ahmisaranrao@gmail.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] media: rkvdec: Propagate platform_get_irq() errors
Date: Fri, 11 Sep 2026 08:47:10 -0400
Message-ID: <20260911124710.643225-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090929-grout-renewal-43d1@gregkh>
References: <2026090929-grout-renewal-43d1@gregkh>
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
index 41b93f09e6df0..8b87213f69a70 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -1017,8 +1017,8 @@ static int rkvdec_probe(struct platform_device *pdev)
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

