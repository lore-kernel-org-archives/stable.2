Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25B030C60D
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 20:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790083; cv=none; b=fbjanID7Z4Xk5XDmN9fVbukijQZiGPc7Ib2QpWggEmaVPLsa84HDCeXvIOB4yEXceJSBRlgtdYGJO7iJ0hjhXFfUYobPNjxj8OMRqMTCo610+xVRxRmuBaBfXh463td6+dk6LNY1ho3lDSUirco8bsa8uKzyl84SooWEZccAkEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790083; c=relaxed/simple;
	bh=PkClmh99PfV3ETOJ7r3UKm/WK1zCvjYD14fzCutRF9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0T4bByLofs5EHTiZR+a57ybfUyfV39rajxpXYK3UaBO0CqLI1ywyyTkLMZskN4tcB+jkrQyDZxXeev8OFetnmq3FirjuKyFKpB5I3SwO2FN5HJI1YZjEB0CW2oiw7ilEj+dLPKTYQkujxnV8eN1JRnwPKkN/qc3ORZcA6dWAVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcXznGJX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcXznGJX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0477C1F000E9;
	Mon,  3 Aug 2026 20:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785790081;
	bh=zExrZzhiojQ+jeBTV+O2dmpr9TiPE7oteNy8v8y9BZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DcXznGJX+j/kHA+Pp79qvp3cNQPL23Fwgdw2jzWK7QOUMeeQ1P4HWa8z80SsQgUKL
	 opu1wKgBxl6IIXv1qj3EsiS+TjRRg61ETAFFo32hZVEdW4GFAWSZhquUxVFB+ZhW2Y
	 oOWpVLi6peu/ebqxps9rb0CiU7NgFtwheddJCQrBZQuIl/LEGKT/h0HGriRXSe7whL
	 63IbK0X9jjouKQq8FqqVGv6ZLePaGOkF1qdOx1CfSj4AYyGsQf33rj0auTNFZF49rX
	 hokjGG3qAZ+otHN/s96qgFqZbCeSpsTnLpZHp1cVXv8ElxabH1HUnr1IodzqeEo/dy
	 kNHLq/9d3sTbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] media: aspeed: fix missing of_reserved_mem_device_release() on probe failure
Date: Mon,  3 Aug 2026 16:47:59 -0400
Message-ID: <20260803204759.1661368-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072935-extenuate-bonsai-d478@gregkh>
References: <2026072935-extenuate-bonsai-d478@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Carlier <devnexen@gmail.com>

[ Upstream commit 253c8ef7d57da0c74db251f385324faaa5ae2257 ]

aspeed_video_init() calls of_reserved_mem_device_init() to associate
reserved memory regions with the device. When aspeed_video_setup_video()
subsequently fails in aspeed_video_probe(), the error path frees the
JPEG buffer and unprepares the clocks but does not release the reserved
memory association, leaking the rmem_assigned_device entry on the global
list.

The normal remove path already calls of_reserved_mem_device_release()
correctly; only the probe error path was missing it.

Add the missing of_reserved_mem_device_release() call to the
aspeed_video_setup_video() failure cleanup.

Fixes: d2b4387f3bdf ("media: platform: Add Aspeed Video Engine driver")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/aspeed-video.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 9d9124308f6ad..56fe20ba8041a 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -1724,6 +1724,7 @@ static int aspeed_video_probe(struct platform_device *pdev)
 	rc = aspeed_video_setup_video(video);
 	if (rc) {
 		aspeed_video_free_buf(video, &video->jpeg);
+		of_reserved_mem_device_release(&pdev->dev);
 		clk_unprepare(video->vclk);
 		clk_unprepare(video->eclk);
 		return rc;
-- 
2.53.0

