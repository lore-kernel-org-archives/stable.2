Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C46327FD76;
	Tue, 18 Aug 2026 14:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062841; cv=none; b=TidD6DsyDQlyg0F+pApZdwxfQmdZ/mYY9g2iZo9hKw+lWXAVeD9fOP5MLINqcKCBjM4Y+f73xKKikGe4H8faOx0wdiobR//B7AnJ/31i7wTY799mQA4hYsdRbo3tqV+lw8Fj91qY0musSLO9OsrLsKFrdPHHNJNyJDn4mYTc1x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062841; c=relaxed/simple;
	bh=/Kr5dmvgPJR4hlWsUpgfpkRcAawOfZ7Iq8R4JZiezkE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C1R56rwb2rJ8PoLP5HcbnVcj0GcMAFaANWI1pLZvaulisx15ElL4NkAq/i4+GA8bKfLaYzpUyp95dG5GH3G3tQlDgdbQ+/cFX8zZ6LmBS7sInFTut0Qgs9u1ptxvmsDBpJJ73Pi9ulNfEjDMwrqwOJ6ihFgQYi57wk51EQN3ANU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=C1+xiXuN; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="C1+xiXuN"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4a6e04a54;
	Tue, 18 Aug 2026 22:20:28 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Rui Miguel Silva <rmfrfs@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kris Huang <huang_kris@projectara.com>,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] staging: greybus: light: initialize channel lock before registration
Date: Tue, 18 Aug 2026 22:20:20 +0800
Message-Id: <20260818142020.1989539-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0153ebc9003a1kunmbbe28056113d13
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTk1JVh4YThkYT01CTUIdQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=C1+xiXuNF8CAiwHns/klXhG7XHE9nlX6iy+h3BLmA7hdFZ1/Y2DDNJ5tFSWv11tNIKzlbmNSZLTFVNwNEc91vWE7sWL3gMpZTuifV2RnbO7aYWEfe83aV1d1uWIUgTxHakYdecf1k/FOz48k4F5R6aIhqqx52SY0mkh9J+YfYwo=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=zcdn4qCXi0btpehraWQwpC8/QF/QAeexuPuSZJubGAA=;
	h=date:mime-version:subject:message-id:from;

gb_lights_light_register() registers each channel before initializing
light->channels[i].lock. Channel registration exposes the LED class
device and its brightness callback, which later takes this mutex. A
concurrent brightness update can therefore hit an uninitialized lock.

Initialize the channel mutex before registering the channel so the
callback always sees a valid lock.

Fixes: cc43368a3cde ("greybus: lights: Control runtime pm suspend/resume on AP side")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/staging/greybus/light.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
index 38c233a706c4..056ef6b0276e 100644
--- a/drivers/staging/greybus/light.c
+++ b/drivers/staging/greybus/light.c
@@ -1043,11 +1043,11 @@ static int gb_lights_light_register(struct gb_light *light)
 	 * found.
 	 */
 	for (i = 0; i < light->channels_count; i++) {
+		mutex_init(&light->channels[i].lock);
+
 		ret = gb_lights_channel_register(&light->channels[i]);
 		if (ret < 0)
 			return ret;
-
-		mutex_init(&light->channels[i].lock);
 	}
 
 	light->ready = true;
-- 
2.34.1

