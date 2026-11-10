Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334677;
	b=cCcHUN4CYcrwCSuQg953+Ge7DHDBEpj83nIMIiyejmI7WXnisR9l8SJL+eguoz9Qhecw
	 KYwd1x8K+RYwEp9aE+e9sg/Xq8NgInBUuQzZGnCWou3TGjbB9dKP5TmZiJ/7L+r5168/6
	 Xq8HJf6XA9BYL2FXITNplIIJEei+6+sC//UabYzghX+2Sdf7gsJNXcnPFJQ2zJ/Cp3M1f
	 feozPI2xy/SjCN2bIegy451luREDW7VbxQ16BAr0TCaKdKf64q7azysIFaCD0VSwFSBzX
	 z+DL4FGQrlHH3Bte6uiFYkP2Y5OLGjzHCGAZRbXd6OEXRHTe8DkCr0dFS9bAt8cOAyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334677;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HzeTURttd4mPyv0OmDEbUe2uq14hvJr30KSzOyEYe2s=;
	b=CG+BEzFk0i9N7uxCRCjxllJsAo0Ws6/MqZaTFHyEdS2NbZBJTYx9XdcDQvnuMgQ2p39U
	 oxxt+iweuIgoNenAWgytMF8WHq3itko3EXWxwB7ckX47hHs76S8jT8PKmcIqNb2wC2l2f
	 o9wr73imNdO11hS2GtL2vVQSE4xpYuEOhvrtQZNKS8wtvNzLNAXHgsjTzOQxJhXAyWt7l
	 EIUcLqMBZCLoYzvATA1IolC+Z1m1hGY90sV9Njwle5l2qSGRN4O1SfAvSBxpeYnQEXUN1
	 Lzu+FRCu3IAwkO+SImqK04uTtMoUI8uq5AzJ9Q9Swxphkds6ObBG5hTrwYj3ZAgwvvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ffpPOHzq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5AF606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ffpPOHzq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962931F0089F;
	Tue, 10 Nov 2026 18:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794334677;
	bh=HzeTURttd4mPyv0OmDEbUe2uq14hvJr30KSzOyEYe2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ffpPOHzqkdukh9HouYOTqyCYx3QDckkq5u45BxoVlkOUZ8my9qjgxENnylSr4pU06
	 HHLcbDiIK35GEsH4vRtDG4aevxSGnRoxdRctw26eCeqUlPYwcx8rGeuW+drDEf+4jd
	 hMuNU1tRHkiLJarYw93I2DIOFjjbeZlnycDOQsUT1TnbwFVN9JzIO5WvkOHFccm+Tg
	 1RUqoSuSPoZXahqLq/KQdwQvjAxrnXL5S3/1EuZkscpF+LN0tGE4tUJo8JQcTWmPjF
	 OkJ5SNJdWAm3RMW8c3ykcO9WFwPB0RF3wvf5ywZkhKAsOcDWBDauMFAA8P4DGxUvj5
	 ZLE+voOAHyivA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Martin Belanger <martin.nvme.dev@gmail.com>,
	Daniel Wagner <dwagner@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] nvme: make the DH-HMAC-CHAP secret attributes readable by root only
Date: Tue, 10 Nov 2026 13:17:55 -0500
Message-ID: <20261110181732.3108035-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054907-failed-6.1-bbca7c312ab2@kernel.org>
References: <20261107054907-failed-6.1-bbca7c312ab2@kernel.org>
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

From: Martin Belanger <martin.nvme.dev@gmail.com>

[ Upstream commit bbca7c312ab25efd0024eb87545c51a76ab2ea39 ]

The dhchap_secret and dhchap_ctrl_secret sysfs attributes have mode
0644. Their show functions return the secret, so any local user can
read the DH-HMAC-CHAP secrets of a connected controller.

Define them with DEVICE_ATTR_ADMIN_RW(), which sets mode 0600. The
macro takes the show and store functions from the attribute name, so
rename them. Writing the attributes was already limited to root and is
not changed.

Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
Cc: stable@vger.kernel.org
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Assisted-by: LLM
Signed-off-by: Martin Belanger <martin.nvme.dev@gmail.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[ sashal: Applied the changes to the NVMe core code because the sysfs attributes have not been moved to a separate file. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 26233e6a50da9..9521126738940 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3847,7 +3847,7 @@ static ssize_t dctype_show(struct device *dev,
 static DEVICE_ATTR_RO(dctype);
 
 #ifdef CONFIG_NVME_AUTH
-static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
+static ssize_t dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
@@ -3858,7 +3858,7 @@ static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", opts->dhchap_secret);
 }
 
-static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
+static ssize_t dhchap_secret_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
@@ -3899,10 +3899,9 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 
 	return count;
 }
-static DEVICE_ATTR(dhchap_secret, S_IRUGO | S_IWUSR,
-	nvme_ctrl_dhchap_secret_show, nvme_ctrl_dhchap_secret_store);
+static DEVICE_ATTR_ADMIN_RW(dhchap_secret);
 
-static ssize_t nvme_ctrl_dhchap_ctrl_secret_show(struct device *dev,
+static ssize_t dhchap_ctrl_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
@@ -3913,7 +3912,7 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", opts->dhchap_ctrl_secret);
 }
 
-static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
+static ssize_t dhchap_ctrl_secret_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
@@ -3954,8 +3953,7 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 
 	return count;
 }
-static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
-	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
+static DEVICE_ATTR_ADMIN_RW(dhchap_ctrl_secret);
 #endif
 
 static struct attribute *nvme_dev_attrs[] = {
-- 
2.53.0

