Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048550;
	b=vmumCBQ8gnPQ6ei9uDX/MHXuW/dwjRx67SP1iA1OILYrUZKHjs4FtTx2dpH21AywNZxH
	 TNRiplbm4BcVGE3zb5moPQAfYtM7jwqfFe2ulHBtl2848wZBB4qBN9/0Q49c7cFwC5bYS
	 x4pUG/p3730OA4lDTfqhmMMAlNK1ZTrGKGgBtMab0uTCjCi2ByH82n5xowSGL0HoxiXL7
	 PXEBVGetIbkmL2o3oUsD/GFA8Z956WJb+tfivI6HDECZiaEkhD4yoOjgg3yd9Pk2s5Ypa
	 5WTGgOLrgf/Go7JBWhu8JBwrYhxhj2M7SMfpfKVEtY/0+FLso2P5BxBU3Lnw1Rh78fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048550;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cpUcjLqsIZVLVOihaxNqT91iS9ymKLKdyKlXYlJaOek=;
	b=0XrJ6o8I7SWmFleu3Kbmk4EX74KY1QX6b9Z/XrgwVCL9zfaQ0dcDJ+WTGLkfPKWIMRE6
	 bHyC9RWM37CMWE3SwexwawbbHQbSGaRG0DjzWzYdFssuldZJa++MJmdWh17UffJ1L+FIO
	 RvLjkd47YLMEI3x+S7+VAqYmP+uKF+SnuTqlptL3Qct+5LrqG3xhYW8OT27Aa5WYUz3Us
	 7H/gxjuMeqk7EVO5PJYIDOapLqBYRJ23lPm5uDh1f1+YmG5XSfjUOgQd0ISSlOCvSi0tE
	 VlR7Y+JTKzIa1evwXIXiRJkTjH+wNmz1tQoaJW29tQjWlAPfRU52zvEmIfqtuHYyTJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TP+8he43;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3FC606EEA4
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TP+8he43
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466681F0089F;
	Sat,  7 Nov 2026 10:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048549;
	bh=cpUcjLqsIZVLVOihaxNqT91iS9ymKLKdyKlXYlJaOek=;
	h=From:To:Cc:Subject:Date;
	b=TP+8he43kQ/pb01a9OYI5nENQWamn6+dHIgvYW7WVmaxnh0dGutsXl/BJSnAR+vpY
	 uEYLMJow01VTl2SkQUOSQNNhRq/w+JM/QI5yhOUZfep9FRPVa7eScsZC/uGLVIQX6h
	 CwCWTcZb9R75o6gzW/JyPQo17vYPNzNaiPl3+xH80cTNR+qr2/ytp12Y8pZbEyNQEF
	 kH3hOIIUjr39laAadtEI5W1PF5yCychsh/IueGco+vvzzmvUyazVlBrXp5cQoFvo28
	 0oaTuA8vP20hwzeJ+Tzs93iWm6vkNaF5e0EfptgoVesreLz1JYs5tA990eTgWTlvyZ
	 8xKRsX6dNwCmw==
From: Sasha Levin <sashal@kernel.org>
To: martin.nvme.dev@gmail.com,
	dwagner@suse.de,
	kbusch@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] nvme: make the DH-HMAC-CHAP secret attributes readable by root only" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:49:08 -0500
Message-ID: <20261107054907-failed-6.1-bbca7c312ab2@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x bbca7c312ab25efd0024eb87545c51a76ab2ea39
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054907-failed-6.1-bbca7c312ab2@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From bbca7c312ab25efd0024eb87545c51a76ab2ea39 Mon Sep 17 00:00:00 2001
From: Martin Belanger <martin.nvme.dev@gmail.com>
Date: Wed, 14 Oct 2026 08:02:57 -0400
Subject: [PATCH] nvme: make the DH-HMAC-CHAP secret attributes readable by
 root only

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
---
 drivers/nvme/host/sysfs.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index b3abb852a3ecb..5224597a32f1d 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -813,7 +813,7 @@ static DEVICE_ATTR(io_timeout, S_IRUGO | S_IWUSR,
 	nvme_io_timeout_show, nvme_io_timeout_store);
 
 #ifdef CONFIG_NVME_HOST_AUTH
-static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
+static ssize_t dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
@@ -824,7 +824,7 @@ static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", opts->dhchap_secret);
 }
 
-static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
+static ssize_t dhchap_secret_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
@@ -868,10 +868,9 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
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
@@ -882,7 +881,7 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", opts->dhchap_ctrl_secret);
 }
 
-static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
+static ssize_t dhchap_ctrl_secret_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
@@ -926,8 +925,7 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
-	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
+static DEVICE_ATTR_ADMIN_RW(dhchap_ctrl_secret);
 #endif
 
 static struct attribute *nvme_dev_attrs[] = {
-- 
2.53.0




