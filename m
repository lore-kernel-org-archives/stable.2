Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313765;
	b=uMBVJNznOhqOYRYI67aEZjzoHL2iZYsaNlYWjAoLbrERdM9vJ6arHRI0B5mjYbV9fsry
	 qgu0KoElv2AWEQ6EyuhZmcdfAjxYvZP28GtvfxvEvDzRZXkwxZ42E+5CnyVv4CJoDHFEr
	 QySBEtF7NfWM2ljGpUNOx3ZD3TuzV1dhPvplX1zg3hgiZxaZK1CsL+vGW1hhpHcIejBpu
	 DAhIjtzHs8Sm6PJadTbzDAMVK2flNOil6dNmKmXvDzuDDH0fVNWnwV9Pl0t/LXWtMA1hF
	 ICSX56fN+FBmJ2HhOvInSFRfpuvYh+Kewz4mCeGk7ixSVrP2R7be7V2c3mcHwv5cYng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313765;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tl+LZeGZWGeSUw90USqRWCm+Clm+8u7G18Q+e9qoUyo=;
	b=w5yq8bHH0EftYvnzKjHkWrWwXqUQLiJCKUVy1Ff/aTNJT8gikfTFdr0TJCkzAvYQnrt5
	 xOhet8g9ZYY1HfD0tJ0pKV+r+Mp+GX9fAWzc6CL8SHIUJWiI89XY6nElEQ6EIPkRWdA5d
	 omOxj7/PBqkZsh/mE9pj6YBWfBgxq+FFsHiykONq/A0woNZkE+SZNIQwfsCo6CpfCBiwa
	 XnoDerv+a9zl3aktf1tY/h0JckMcH7M+L8y4XXNQk3CySzAUtoA6p0xH+Asg/Tmu8ljr1
	 PIaDx40IKoncyzultDMJxNn+zR06xDRhHOHPn/36LHqsYPy7roEKGF3MmgtQIAjGaAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Am9rYuE8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF34606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Am9rYuE8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD6F1F0089F;
	Tue, 10 Nov 2026 12:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313764;
	bh=tl+LZeGZWGeSUw90USqRWCm+Clm+8u7G18Q+e9qoUyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Am9rYuE8Us3jtrZERPBS7+TahWK2dS3tbWMifbqxj4NiTEl4pioYJXS10B24w9Msg
	 SeaAzUVSnvGIJGZ6Yi0XZrt1XTKOxixoJOebg8M4v8r00sy+BJM6ZpQU5B3yRd1oZC
	 OxIBPGCGyEeQobV5lVcmYma0YCwtiqZUgyFXtEa/5vd/ADmTLj1YOsp2l75KePdS4Y
	 J7hd/W5hjed0e6oPO9/zGlvUdJ+dkV+DRCg5VohIJOm0mkiD7mqVvAs//Ddy2VK/PT
	 E47Vt3NN8HS/0OY4r+4UV3MNmn6F06qlqtzI8DJhEvRcQ2Ln/SoWDdwwlXU1K7YgD8
	 52HXNEZGL3/ZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Dipen Patel <dipenp@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] hte: tegra194-test: shut down timer before GPIO release
Date: Tue, 10 Nov 2026 07:29:22 -0500
Message-ID: <20261110122907.1187972-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052856-failed-6.6-30167fadbf87@kernel.org>
References: <20261107052856-failed-6.6-30167fadbf87@kernel.org>
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

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

[ Upstream commit 30167fadbf87fa901a2fee49c30a5c5a506a43e8 ]

tegra_hte_test_remove() releases GPIO descriptors before stopping
hte.timer. gpio_timer_cb() accesses hte.gpio_out and rearms the timer, so
a callback concurrent with remove can use a released descriptor and rearm
after teardown.

Shut down the timer before releasing the GPIO descriptors.
timer_shutdown_sync() waits for a running callback and prevents it from
being rearmed.

Fixes: 9a75a7cd03c9 ("hte: Add Tegra HTE test driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Acked-by: Dipen Patel <dipenp@nvidia.com>
Signed-off-by: Dipen Patel <dipenp@nvidia.com>
[ sashal: Adjusted context to remove del_timer_sync() while retaining the int remove callback and return 0. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hte/hte-tegra194-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hte/hte-tegra194-test.c b/drivers/hte/hte-tegra194-test.c
index ab2edff018eb6..d9adcd64a263a 100644
--- a/drivers/hte/hte-tegra194-test.c
+++ b/drivers/hte/hte-tegra194-test.c
@@ -218,10 +218,10 @@ static int tegra_hte_test_remove(struct platform_device *pdev)
 {
 	(void)pdev;
 
+	timer_shutdown_sync(&hte.timer);
 	free_irq(hte.gpio_in_irq, &hte);
 	gpiod_put(hte.gpio_in);
 	gpiod_put(hte.gpio_out);
-	del_timer_sync(&hte.timer);
 
 	return 0;
 }
-- 
2.53.0

