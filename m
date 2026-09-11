Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F3C477E2A
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130819; cv=none; b=XeFbGj7VvGw1zazuGHpjMct1Lr+LuVCyTqLP1LIgb1TZoYcEuVGzq5uXSpq+96+E7p7rtJNu17mQV4SjhBkpHMrdinaFbuBvErD5tc4flEvAWcrCMaiWpFkjjlghreBaq7ZdXLJUf1Pulilcp6IpftmcMq+9Tf05exJDrCk9PPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130819; c=relaxed/simple;
	bh=mdbJ2D0GkopVgeu2Z3IoMTYQbPzFumpLhI37Vi6M1KY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1y+ayMO2rUwMVcZwMNr+99CP4+p5gAw8M357rfLKAClZHDohuaBWAD+mnIBlwKl2RfFUtPaJ3wr6wGu3mOLFabCYOLZDqnyEvvRBNWDc5OxMOcxrxRBDR+OaaaBDE/9bbQYsY0Tr5A0E23c0WlM2dOUHHFe+jX46tcY3oD+jyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQempuXd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQempuXd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04B11F000FF;
	Fri, 11 Sep 2026 12:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789130817;
	bh=17OKDy9a2uXmZMlmR3DkXenIEDv2tVuCS31bfHNvRpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mQempuXd2aEuK8u5z3zv3NtQq651lxWJ33oz4oMgscnZhHiPDhigX0pnLk8b3ClPF
	 4oysfhJmWMcpsbO86OiQk0mhvghFWp9p7yLsSr5z8xLFZ6/6pXyBQ8Eo/FhGx1PuZt
	 8Hlty4tqysg2FZRk3j33gOrymlfQuvgDq/fI4m196WTliScE3l/Fm/Qx6hzafS+WCx
	 o+9kzUcIGfy1ojbn+nhs7jgu328yhaRz/Zzzj34+ejBV3yK6QlTBCZnWRWG/xc7Tb1
	 e8OBDgFGKWJT5ToQYWuJbK0fk1zzZg5bOkFF19H1k+3YeGIxDMuMMZnJ2Sthdf3D8G
	 nsBwv6HyCbOwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ruoyu Wang <ruoyuw560@gmail.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] media: zoran: Avoid freeing a registered video_device twice
Date: Fri, 11 Sep 2026 08:46:55 -0400
Message-ID: <20260911124655.642739-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090920-computing-favored-d2a1@gregkh>
References: <2026090920-computing-favored-d2a1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ruoyu Wang <ruoyuw560@gmail.com>

[ Upstream commit 0735e0b5a96761a9ce277a238e834008ad92a0a5 ]

zoran_init_video_device() installs zoran_vdev_release() as the
video_device release callback through zoran_template. After
video_register_device() succeeds, video_unregister_device() drops the
registered video_device reference and the V4L2 core eventually invokes
that release callback, which kfree()s the video_device.

zoran_exit_video_devices() called video_unregister_device() and then
kfree(zr->video_dev), so device teardown could free the same
video_device twice.

Remove the direct kfree() and clear the cached pointer after
unregistering. The pre-registration failure path keeps its manual free
because the video_device was not registered there.

This issue was found by a static analysis checker and confirmed by
manual source review.

Fixes: 82e3a496eb56 ("media: staging: media: zoran: move videodev alloc")
Cc: stable@vger.kernel.org
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/zoran/zoran_card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/zoran/zoran_card.c b/drivers/staging/media/zoran/zoran_card.c
index fe0cca12119c7..9ee30b70b9d9b 100644
--- a/drivers/staging/media/zoran/zoran_card.c
+++ b/drivers/staging/media/zoran/zoran_card.c
@@ -831,7 +831,7 @@ static int zoran_init_video_device(struct zoran *zr, struct video_device *video_
 static void zoran_exit_video_devices(struct zoran *zr)
 {
 	video_unregister_device(zr->video_dev);
-	kfree(zr->video_dev);
+	zr->video_dev = NULL;
 }
 
 static int zoran_init_video_devices(struct zoran *zr)
-- 
2.53.0

