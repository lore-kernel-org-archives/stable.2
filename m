Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082344A68B5
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 21:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791147891; cv=none; b=sDQrg2mNnNxT4fnp6yVB8Y19ZlCx5OSloOSlhGfLQwQ+KTX7GJVLLy2Jr2w+AX0Ad1HfIzQChJrw9ruba/SRL98sDdPjDCbbJf5zGd1AC9+6H94+tuR5aam3UcC4+LWXfL47rtI820z5tHk8JJCN+LIbLmYsBh8IzwZJnZQQ+kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791147891; c=relaxed/simple;
	bh=1udbvywflEEOvh6UGj05vzpmjH5xwvMMmlSNaM1Uw2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nv4Lipbqnv8ILWSRU2p28IvYPEa9yMlQ4Ie+uDfpJ15is03ycNPJop8fnM6n36OmWqzyv/Xf63fA5f2+CkgrSmNbRamnEF4I/H2FC+3SEJNsowOXCIzqy3HjWWTWuivweV/pvNvQXbGCrHXllsQOPJJaXVTK1XIQwFjsJPxH+bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhNUFLdu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhNUFLdu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFCC1F00893;
	Sun,  4 Oct 2026 21:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791147889;
	bh=Z6zSr1Q4hg1/RG3HvPBmSW7a3c6JkdZrfHIe5ybsF0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OhNUFLduINpyGy+CB1rTs/uEG9mLNcPBH2sEjK0aBFcvVRXZ0BXyg8ZgTYd191Cgu
	 OCsWJZcUymw4laQm4vcuxJREfO8pps6wAoJNtUY7nYa7AVIoEGgzxZNQYhqgHphFA+
	 uD/LgdCEMcQrZDsGojP9tJYwZE6Ju12AzHrHy2WYM4Fho2vq+MSCSdIU4B6RayLdcj
	 5ZIGZJqs1FtiyosR10x9pmcLJ90s+DLAmUBTxHw22AZMlFWUQPGQTxVB8TPEEGdMtM
	 yQfvFDVSMntOFnFBSD68tGQP+jklrH+sywYjpO+DnjVxCBCFeBCE+AAxKsyrbyNDly
	 YNDFXIPmfflpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] wifi: wlcore: Fix runtime PM leak in wlcore_remove()
Date: Sun,  4 Oct 2026 17:04:44 -0400
Message-ID: <20261004210417.1052493-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004210417.1052493-1-sashal@kernel.org>
References: <2026100446-celtic-uplifting-ac0e@gregkh>
 <20261004210417.1052493-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit a8b8881d0c1aff544fae190469d86db7b07f43a9 ]

pm_runtime_get_sync() keeps the runtime PM usage counter elevated even
when it returns an error, so the reference taken at the beginning of
wlcore_remove() has to be dropped on every exit path. When the device
was not initialized the function returned early without doing so,
leaking the reference.

Release it with pm_runtime_put_noidle() as done on the other early error
paths of this driver.

Fixes: fa2648a34e73f ("wlcore: Add support for runtime PM")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20260917122325.2150910-1-vulab@iscas.ac.cn
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ti/wlcore/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index b5ae25e7ed897..ec3eaf788abf5 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -6748,8 +6748,10 @@ void wlcore_remove(struct platform_device *pdev)
 
 	if (pdev_data->family && pdev_data->family->nvs_name)
 		wait_for_completion(&wl->nvs_loading_complete);
-	if (!wl->initialized)
+	if (!wl->initialized) {
+		pm_runtime_put_noidle(wl->dev);
 		return;
+	}
 
 	if (wl->wakeirq >= 0) {
 		dev_pm_clear_wake_irq(wl->dev);
-- 
2.53.0

