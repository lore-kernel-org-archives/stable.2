Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6C84CC269;
	Wed, 14 Oct 2026 12:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791979382; cv=none; b=b9iKIzj6w144zNy+S3tglv++a8f2vvTm1qCpZ4RjmhdaIsDhs4Qf0OCozbgSN7b18MFMexQ6vYNDNl/qZxbcVupDrh8joT3MpQ7E7mEVuAjBYl4VYznOrKkfu9HfEPhVRCNe1N6jJeWJpNpCRKRmo2AzQNdWHM2X14v9R9Aq8T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791979382; c=relaxed/simple;
	bh=VYajclvzOrwjNaQXV7GOh4I3DUluj9rV+N6b3tU5QZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TqaeEMX9RfXAQqzpkLYObcWL6NnSrKM2kr8P+F6Fkmr8kjYlQ0Vj86kvFoBzs/kecxU6s2mir+khQEgP46SOGYoMnNNL2zHntNcc0sYybQLTpaQheE7UKVfIOiT4VWEba/+Go6wy1qBktr1k2QifNw8nmPhLgqhQuUkLn+qkRaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLiRyBy/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLiRyBy/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33421C2BCC7;
	Wed, 14 Oct 2026 12:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791979382;
	bh=VYajclvzOrwjNaQXV7GOh4I3DUluj9rV+N6b3tU5QZ8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=iLiRyBy/gDQz1etnARTXamUCsQvRIwka1WYR0OSlbc9/SMvFJex2VKkZBlOXFBq1K
	 18PogAKBRzCV438zdWAU50CRHzCXkf5A271Be2U/Pbbab96Gfki9IrgxW+CRJzdjZ1
	 0NY4P05BrleJd7PAGJFJwt4JtB24INRGeREYfSePQgNkhNXsYcY75dLqrdv9hpOguJ
	 tULVTP/+ZQgO8PZ3Ht/EiZsWXYTkKkIDXO+hQ9SL7RKY0EJSgLU3mMvPJtpXGp7IWY
	 8kAZqj8R3VPz8RpsUCkM4F3H8sa6fIQK6mhstPKLR2wt4MPhA68ags5gzajDkNjHeu
	 DujxM+JRZ5WxQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC42CC6B24;
	Wed, 14 Oct 2026 12:03:02 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Date: Wed, 14 Oct 2026 08:02:57 -0400
Subject: [PATCH v2] nvme: make the DH-HMAC-CHAP secret attributes readable
 by root only
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-nvme-dhchap-secret-mode-v2-1-00f153e9d8de@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMUQqDMBCE4avIPruQBBXbqxQf0mRat2CUrJWCe
 Pem9vFjmH8nRRYoXaudMjZRmVOBqysKo09PsMRicsZ11tiG0zaB41jGhRUhY+VpjuCLNT36trG
 +81TeS8ZDPmf5Nvyt7/sLYf3l6Di+N1PvwnsAAAA=
X-Change-ID: 20261014-nvme-dhchap-secret-mode-9108e8541a6a
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>, 
 Martin Belanger <martin.nvme.dev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791979381; l=3245;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=YzbJwanbX41Lark5YtJVe0AVHqjgNwPQp5aKXMjqULc=;
 b=Ib1ZrDnxDTZUZttiA/j38dYPB1shdfmMLlyzRHHYeQXx39wMBm0oCvjyCGsOWT6Pg9LxNjdEe
 BPQOfx/SYBSBcZ9lScWoyTQiBHjNkklIXz+JidH/a/XcYrQTafeCu+O
X-Developer-Key: i=martin.nvme.dev@gmail.com; a=ed25519;
 pk=4K+XXetGK35w2LzRRddd/bbHawZU222BN+YZRuSpN+k=
X-Endpoint-Received: by B4 Relay for martin.nvme.dev@gmail.com/20261014
 with auth_id=1176
X-Original-From: Martin Belanger <martin.nvme.dev@gmail.com>
Reply-To: martin.nvme.dev@gmail.com

From: Martin Belanger <martin.nvme.dev@gmail.com>

The dhchap_secret and dhchap_ctrl_secret sysfs attributes have mode
0644. Their show functions return the secret, so any local user can
read the DH-HMAC-CHAP secrets of a connected controller.

Define them with DEVICE_ATTR_ADMIN_RW(), which sets mode 0600. The
macro takes the show and store functions from the attribute name, so
rename them. Writing the attributes was already limited to root and is
not changed.

Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
Cc: stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>
Assisted-by: LLM
Signed-off-by: Martin Belanger <martin.nvme.dev@gmail.com>
---
Changes in v2:
- Use DEVICE_ATTR_ADMIN_RW() instead of DEVICE_ATTR() with 0600 (Greg)
---
 drivers/nvme/host/sysfs.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index e1e3dcfd084b..c0ecb5df1a30 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -809,7 +809,7 @@ static DEVICE_ATTR(io_timeout, S_IRUGO | S_IWUSR,
 	nvme_io_timeout_show, nvme_io_timeout_store);
 
 #ifdef CONFIG_NVME_HOST_AUTH
-static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
+static ssize_t dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
@@ -820,7 +820,7 @@ static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", opts->dhchap_secret);
 }
 
-static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
+static ssize_t dhchap_secret_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
@@ -864,10 +864,9 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
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
@@ -878,7 +877,7 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", opts->dhchap_ctrl_secret);
 }
 
-static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
+static ssize_t dhchap_ctrl_secret_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
@@ -922,8 +921,7 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
-	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
+static DEVICE_ATTR_ADMIN_RW(dhchap_ctrl_secret);
 #endif
 
 static struct attribute *nvme_dev_attrs[] = {

---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261014-nvme-dhchap-secret-mode-9108e8541a6a

Best regards,
--  
Martin Belanger <martin.nvme.dev@gmail.com>


