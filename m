Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8234137F313
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129788; cv=none; b=io4XvwUsvhvODb7FhuuoFCOmHBJ1d/AgPiuUSKBHH+V1hwpqOrPFmCAzQqFrmzvVOFbRwM61ZSmvNShqKDKt9crd1xBrNTfcCWN+A9P9Argk0HNuzJng8jQgTOvfcknCgHgSbrXfb7FQcrsYMHJZ2zPd4xODhBYKvmHn+TBxc2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129788; c=relaxed/simple;
	bh=zbdiK2lvJB4T2RglzYoymlPMBJr9OZV47nwwXM7JQEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6T02aL24T6UUYJKFoQg8Q74xZa4ptPPyBzwIQ0dq4y0j43v9c/RrNGgFvHVf/dHhYApDYo4Y6w/LtIBSYi5q5+I9NJntZOCCPxwSupG4CNPoz1UJqCL8mgkTlHqMq9UiekaLcec7xS10UigB6uch3Lkx60gTu0Nv/Nv0eApo0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EReAJOxK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EReAJOxK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FABC1F000FF;
	Fri, 11 Sep 2026 12:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789129785;
	bh=0PPLMt59vG/uJpSsuQEKlQJmYuMBVuP7k8AviHAH1AI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EReAJOxK8GYtl4DuDEXeme2WppxMF0TTT7RC6zffZHenw3wmUlrA+RPLjdHxtIuHJ
	 5hQ8C3MxEWnTvuxKVbz1UzkJTMXcbb2RlkM6KVrJH2tjUJlUdrLUwuU4iZE6/chtzb
	 TOJc9itPWSHqFse8piQgidfemG3yRZAnz110o3Z0n1If3wM1PXfKHXaNKiPvXtWKOf
	 Ii9sxbxWnJD2ueyQBgpgbutCAmSWPAEjYQhes49wXHHmvOFoPE8dka/z/UDjub+X2w
	 Wv1cn896lDHTQhOYrPHhK6Z+POA5akZyI7r5uxDeDQ7uQcudwQn1HpOTcHfULNRlkR
	 2w5/S+eXSsy0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ruoyu Wang <ruoyuw560@gmail.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] media: zoran: Avoid freeing a registered video_device twice
Date: Fri, 11 Sep 2026 08:29:43 -0400
Message-ID: <20260911122943.555242-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090919-ricotta-twitter-442e@gregkh>
References: <2026090919-ricotta-twitter-442e@gregkh>
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
index 11d415c0c05d2..b6a9fef71ba2e 100644
--- a/drivers/staging/media/zoran/zoran_card.c
+++ b/drivers/staging/media/zoran/zoran_card.c
@@ -832,7 +832,7 @@ static int zoran_init_video_device(struct zoran *zr, struct video_device *video_
 static void zoran_exit_video_devices(struct zoran *zr)
 {
 	video_unregister_device(zr->video_dev);
-	kfree(zr->video_dev);
+	zr->video_dev = NULL;
 }
 
 static int zoran_init_video_devices(struct zoran *zr)
-- 
2.53.0

