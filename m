Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4981DDC33
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 20:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785788806; cv=none; b=ia+NbN2za9sh0Dz0WrHj+iSbn15Nrgxo23JS8EjkgsTGhKCwFgrFxUEb81ErNRXsKYmKQ8O+8J+5Of//Ps1jnhB8K5/X/acYdmrt/6ViQWmfIAw9qJVKzHurGtGl29VbQRmDg+YlDbtiPHLRfUiVEVPSrK1oWRUpl9JPEGWjzcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785788806; c=relaxed/simple;
	bh=PkClmh99PfV3ETOJ7r3UKm/WK1zCvjYD14fzCutRF9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7JQ80wruimwY5uVko835JMp6GmpZ0ypyIMSwadGcnf/Fs8F1bDrgypklu9I/EM2pFtOcb62tyDo/8Zg50G+GE7ScoS2CKuYzEca6eGmZkUKOw/af+1Hy2ZtdJnGBHybG9UQiaUy9HnSBZ3u2viKhQYYxGZWrnpln3eq/0yrEYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvS0a9RT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvS0a9RT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2891B1F000E9;
	Mon,  3 Aug 2026 20:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785788804;
	bh=zExrZzhiojQ+jeBTV+O2dmpr9TiPE7oteNy8v8y9BZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AvS0a9RT+qvby+d06IiiZI0AlhJfjfPAmeRVohIq3eySxfWt9svXJ430IciIsWlIB
	 /iBv2bEfPWJetxeTSLtqxFkbEotSjczt7rl3QoSyoJrF1AYFWTkgTb3usjjEJ20stu
	 d20mY9I7Xf48fS2OcJGIyhTS8NrBzjeGgW8opKL4AgZWr0Tjx0ZNeS2/CE7fkmq64t
	 PkursSDf5gkM027jQAV8ki49i7mdr9Nr4UK7UwSTFrvBhcGXMGqxC+84wkWbzLL1eJ
	 K9jkmTvzHzND2CeBgqlNx4unnoqKCh+kU6nDBlR8ubLs+h0dLSRGBvVa3Mx3LQtDlf
	 Tie3GA4vjn38g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] media: aspeed: fix missing of_reserved_mem_device_release() on probe failure
Date: Mon,  3 Aug 2026 16:26:42 -0400
Message-ID: <20260803202642.1646103-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072935-kinfolk-unsightly-e510@gregkh>
References: <2026072935-kinfolk-unsightly-e510@gregkh>
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

