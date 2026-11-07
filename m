Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047715;
	b=Ofp2NhWvval82XcXunQ5QzHd4agnAKG9Z5dC4q17U+VyddkHSiKk5tlhFwc5vhNqb4V4
	 P9MpKKeXHvnZCcVrEesnFUbUyh5n90V2wJzFtE8x81PV5E3va9sQUg0BwPc0aR71MfwKL
	 qSElzZR06RDUkTLpr8nOhGxRz6Y1K+3peneZ6+JC7A7MGGEdPsbc4gJLkgxM79TsuaXbY
	 P0GyocaLFsUleYn7rY/jRYdD211zW8QyjvHwZM3ikF9gGDH+SP/nbY0v2SOMWHLM4AYZe
	 D7tjZ/EOiF+WqaSgc3KF1i67OyEbIXeg4DdEM1VX4K+AQtfyNriDuSxwPvl0MGGw4Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047715;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jzWovSaASms57d2oBI8vaKqTHDkH0jh8s6Irot4qccI=;
	b=i36lkZcEBdPBjTbkaCTezdwg2+Trs/nxZzL6iWg/pQg8dK7CdAzvwDWps6tR4K4g6BSC
	 6xjMcPqIFwUKK6/wOu+skggLUtLnHYy0FompTQhzmmwi+r6u0M62Mat2LN73ME1SqQ8s0
	 vjlv+q0jqQnuA2/4fheCedRXTCMKm9n5dSMKRtaiYg7vFjV0dJ+I6yUdmxuFujuR3lKF+
	 iDp8UJ/PVJ+gDUaGUkRZh9bTMTxKC9tknS++fK1YHy924V5fg2m9C/64UhD7bRmJV1pw/
	 mfcSSXFW7odyE9WLsaYy7M65/jF3ENTKIufk3/akMSaPwhidRs04XkDwxOuFu+amWcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bS4ow5eo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B95606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bS4ow5eo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D491F0089F;
	Sat,  7 Nov 2026 10:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047714;
	bh=jzWovSaASms57d2oBI8vaKqTHDkH0jh8s6Irot4qccI=;
	h=From:To:Cc:Subject:Date;
	b=bS4ow5eoDLUYBkDfIeF3njkJDgGhSbLzC8oNQwHs9j+NlEFJo7ZDIsbp7TdHfKwHX
	 Ke26e7slg5Zd9GCKQP6b2zUJLgcyrWmgmX3ZwVueFTwJICXLD7xx56ZPzkL5l+KGW3
	 Uh9obR9MDXAs29ma1vTYs0oCIeoDWx3H8RDVi76Q0vgtQ0YJtNd4mLWMrssqggBblk
	 lHB4UVp0jqzrdr377PfHzESNI+aSg/WLghEhWwIfAMBiKO5nftXek/mHglyL8dQ/nr
	 DKHbrw0gyiyvXdqSOr21z7+YnqbwOeRD46HxZF7GGzEC4v/5lo3CRmD67K0OAK96Eg
	 hkuYyDt4svH2A==
From: Sasha Levin <sashal@kernel.org>
To: martin.nvme.dev@gmail.com,
	dwagner@suse.de,
	kbusch@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] nvme: make the DH-HMAC-CHAP secret attributes readable by root only" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:35:13 -0500
Message-ID: <20261107053513-failed-6.6-bbca7c312ab2@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x bbca7c312ab25efd0024eb87545c51a76ab2ea39
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053513-failed-6.6-bbca7c312ab2@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




