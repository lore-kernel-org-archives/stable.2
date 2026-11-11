Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417970;
	b=tgmD+spbsHvbvPFfXfKI5RAJDfmPwk5B5CiE78xDWv9gWG7SEi7a8OAOnZaQnfGZ6STu
	 N1EBR/MgKL/ADum/ltMi7VK94FeL1NwpkvsznA1Y47mMb5mgllEm+8DbC1dgSDfRJ5BYW
	 ZgzZcf9BmUpCUngvfszSQjiYezP8AOuew/jWABLQVc07LZdlJAfAHgNNsmp17hw6Eg3mN
	 7Z+QIMwROOKgcFv6aH3HB/N85ZyG2lNs0ySyfb9qnVmq+MxCf5dxtGbWDM0jI9wvRAvwV
	 t2ObG1S1jS3zzJCLLeYHLI0lZbE+Pp/JWoIrmdT78Vg0IkFn4/O3kRr0DLF2Gep9j5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417970;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zkmWQaVjg6Hbvb47qMfrvfUg6HwcP38/oe27gnNIWyA=;
	b=SwdJxaJbuFeOPeBiNbSM5SuiMLkI2h/Fjd+UJu8fTQW9q7Imp1K3Bbe446EihONYPKjU
	 gbZWyu3S7newD9xDhli4wT2ymb5zKzYCazgjbCuhSd3dOfAdZO5LWYTMtMqg1scAyrhWu
	 zH4ukAuU/DZD58XVifA9DxV6ikv7Ln/AGdh+I+96JQzT+ceOeQWW07bBxwRC4ZILgdf/p
	 k//2sobawmQhWtpyiw6K9ES0NX819pwGlXpE72JpxpTfwLY2UYpiRsPLL+cT5Ua48ktfz
	 rkmq5IL+2uVnz6rfEmfjc/cLeGFwuBNXbxFeVarS85hg+v9h5eIEM9iEXsJR3HFvskA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e0pqXiCf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D237606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e0pqXiCf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716D41F00A05;
	Wed, 11 Nov 2026 17:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417970;
	bh=zkmWQaVjg6Hbvb47qMfrvfUg6HwcP38/oe27gnNIWyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e0pqXiCfUY0S7iJvvpV1E+M6TYwUYJ5QxkQ7kegQAMd2rCQhzHSSSgUNmCujAVeQa
	 wIcOsxRu//KJgWkG+6UXa+k+CzqmHsXk76DRykl/9YkBWuoCCLg48na7FacfvP2jn1
	 FTxAeKuMHQfBjm9a4NYW8JjRPMB1nJjP4iGSY0fBngx0/yFova6Ik+Ot6ZFB/tY1kk
	 gg45Xayy17mvCRwFMVOAx3I/1wDCuNHlQDB5zLSpMoN9yG/o39fg2T53VEYKGaac+t
	 Tfbu60EmO7FFIWysv7fOsrbgFwq/l5WhLxGIkCs6ufEpRWdx96/sGNkM/XDMNSNq5p
	 Y7tnc6enqCmfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] nvmet: force reconnect when number of queue changes
Date: Wed, 11 Nov 2026 12:26:07 -0500
Message-ID: <20261111172541.3562889-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055312-failed-6.1-9f426f140511@kernel.org>
References: <20261107055312-failed-6.1-9f426f140511@kernel.org>
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

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit 2be2cd5287152a6284b45244b6e5c2f7e0a218bd ]

In order to test queue number changes we need to make sure that the
host reconnects. Because only when the host disconnects from the
target the number of queues are allowed to change according the spec.

The initial idea was to disable and re-enable the ports and have the
host wait until the KATO timer expires, triggering error
recovery. Though the host would see a DNR reply when trying to
reconnect. Because of the DNR bit the connection is dropped
completely. There is no point in trying to reconnect with the same
parameters according the spec.

We can force to reconnect the host is by deleting all controllers. The
host will observe any newly posted request to fail and thus starts the
error recovery but this time without the DNR bit set.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Chaitanya Kulkarni  <kch@nvidia.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Acked-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Stable-dep-of: 9f426f140511 ("nvmet: take subsys->lock while force-reconnecting in nvmet_subsys_attr_qid_max_store()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/configfs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index c966d1e3a1354..8c12de188e992 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1318,6 +1318,8 @@ static ssize_t nvmet_subsys_attr_qid_max_show(struct config_item *item,
 static ssize_t nvmet_subsys_attr_qid_max_store(struct config_item *item,
 					       const char *page, size_t cnt)
 {
+	struct nvmet_subsys *subsys = to_subsys(item);
+	struct nvmet_ctrl *ctrl;
 	u16 qid_max;
 
 	if (sscanf(page, "%hu\n", &qid_max) != 1)
@@ -1327,8 +1329,13 @@ static ssize_t nvmet_subsys_attr_qid_max_store(struct config_item *item,
 		return -EINVAL;
 
 	down_write(&nvmet_config_sem);
-	to_subsys(item)->max_qid = qid_max;
+	subsys->max_qid = qid_max;
+
+	/* Force reconnect */
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
+		ctrl->ops->delete_ctrl(ctrl);
 	up_write(&nvmet_config_sem);
+
 	return cnt;
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_qid_max);
-- 
2.53.0

