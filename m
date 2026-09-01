Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722B1396561;
	Tue,  1 Sep 2026 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272734; cv=none; b=vGLZid87U2Ho4M4ppp9b8ZLr6xAGVr6uNqoJUE6lGUtutJBAm0kE0W+C8gGl9WZVsm6gzT/5fPbxKPvBgsTN44d9CGF+3We17orHUiONe8dU6HfLp7mFFBWp/iwEluMrtd+VeOPHNl6e0DcPtTzD9pSasZM/fNw7WFiK0JeYEmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272734; c=relaxed/simple;
	bh=d6UHHHub2HFh8oW5s1BgBOohqSuTaTW+4t1jz2j7TV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VF/SzSeu9/iDGFhaN1It07MN+G62g7kodsKrNSEmN8ZXztoLt8att+KB4vdW1Gkdtq1H2N9sPVOua759lqdto7MZ425FfaWP/pmb72Y/x8gCUQVSp7qF1ks+uSZpy1elhZFc2f9C3kPiyu+FwzTxJcA/5KdE4kO5zEax2M1F9Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=kIk0zt3i; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=N6znFkXb; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="kIk0zt3i";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="N6znFkXb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788272730; bh=d6UHHHub2HFh8oW5s1BgBOohqSuTaTW+4t1jz2j7TV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kIk0zt3iM4TMuHLCERUkcF7KLI4GN//toBpXk3HY4faUeQZAVBiWrLznf1T0cP6tA
	 7akmYXPGEpGPsqFJw+Nt3ZhKKHDPhHZLJYQXKxmrEauKW6c5e4wh2LkgYXm0zt/0Qg
	 7QvuYs0KxZFcMDoK8TKnzRMLMWbwSlRrYkcUawrhLCTQVPmGB6My3KYJZRj5GT74oJ
	 DGw3TilT5yOc5tgfKv/XFCP8nzOtwm1haMEQVQ4ZbKoNblOhonoZSMbHWNO3kjY9v7
	 AlPuaOyEVXI+3ppdJpxM7H52KvvfOwxz8dlI9EfFYoN6VMFUvmW04Vur4NicUNM05T
	 INByMeT9z6Wxg==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id E548A4144B; Tue, 01 Sep 2026 15:25:30 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788272728; bh=d6UHHHub2HFh8oW5s1BgBOohqSuTaTW+4t1jz2j7TV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N6znFkXbUv0IsIykM4Y3ylmO6pXLTMVDGSFOY5U7CaCpuOhEcSxYHkvVrFBTOabZg
	 9WsZT2+hTaukM7chlVupMMG7mokaEQKTZnyoEgSmwkiug738RNP6k46S260cL6ey/D
	 FrciaAgGSNoc19ShxhR36ZZz8Il2j2vFgwyY+xa7JlH9KOBXgL1ufrM7fqdo6Rr+wZ
	 DzdyYs7FS7/a35VULR+Of4mX5LvTs5NyfAvgpcsKAbqERNh3e4GWnkB/DU3K2f8uzZ
	 HZHeaCRlPqtE6vM7q5OH8gqi6qJEdpA9g3j1TRuEvkIo7Qozq91nbryrKhDctUcTDt
	 CXr4l+dW6mIYw==
Received: from maru.home (host86-128-233-22.range86-128.btcentralplus.com [86.128.233.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 09DBE41445;
	Tue, 01 Sep 2026 15:25:28 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 5/6] media: rc: Fix race between bpf(BPG_PROG_ATTACH) and device unregister
Date: Tue,  1 Sep 2026 15:24:55 +0100
Message-ID: <aa202bcf11d1564d72c617fb205cc29fe71afe76.1788272198.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788272198.git.sean@mess.org>
References: <cover.1788272198.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark the device as unregistered before tearing down raw IR/bpf
state, so that racing bpf(BPF_PROG_{ATTACH,DETACH,QUERY}) calls
cannot slip in between ir_raw_event_unregister() completing and
dev->registered being cleared.

Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/rc-main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index 3091bcd0e927..af7888fbfb91 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -2050,18 +2050,18 @@ void rc_unregister_device(struct rc_dev *dev)
 	if (!dev)
 		return;
 
+	mutex_lock(&dev->lock);
+	dev->registered = false;
+	if (dev->users && dev->close)
+		dev->close(dev);
+	mutex_unlock(&dev->lock);
+
 	if (dev->driver_type == RC_DRIVER_IR_RAW)
 		ir_raw_event_unregister(dev);
 
 	timer_delete_sync(&dev->timer_keyup);
 	timer_delete_sync(&dev->timer_repeat);
 
-	mutex_lock(&dev->lock);
-	if (dev->users && dev->close)
-		dev->close(dev);
-	dev->registered = false;
-	mutex_unlock(&dev->lock);
-
 	rc_free_rx_device(dev);
 
 	/*
-- 
2.55.0

