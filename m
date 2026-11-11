Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415612;
	b=Zq+qEzeCxgO5nSyikVd+vCFJAklLQqrebM58+KBDO5eL2tv13mzkFPKvDxnWeC7P0fLC
	 SvyMtqgSC3ohBzn0p865G/i2tcHFCR1Od8liGv22yx/8AXp+Z0xt2MQDyEJZc+JDMGArC
	 hipu0ArKznS5Xf3Akd4xsOwm8tDQ0Dc6DuKtGMHYBHH6NEso064Bgzpm+JB7YNszzr3lF
	 xW9HnLVuUgYJBuAJnWQl0VWewkmrJtQz7/F74U1Q3aICKiJUQPg6r+/tOd7nfwczVC8JG
	 QJTgg0jmuHuxMPWkFQObg1R4G+D/3nirftnM9X6WdMiKHdXz15jdVW7EXk5KgWUjUOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415612;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jCHgsRUMw7NDxNvn0Y+N5QXXoPG/eG7+zuDD4fIGy+Q=;
	b=bxtQ6GN+isYSVJFrFWeqYJs1d3zadQCHQADZMYeMQ9MmovffEL/NLkWaEYS5h8U5933C
	 29JA3w2i13efChBm86GkDYCh6Iys3PHftCRT3smHrJGqF+y1l04JAzBucVhYWcrOqioMT
	 CSGwehwj1JZURPvc0qY4+/1ZaUexr3aVCRePvpb9FRz4GOxuZA+sdCn/X2oWvta7us+nY
	 j5LpOL5zMmN3QvGjCfflvCIZi+1pwjs0Bjw62jYoCBmNsIgm749SuoKYeSfswwxmlH/PQ
	 WQyu609NIEK7+DpTGm8P238BR//+WP7Miioy7otu85iz6gK+fQwq3S5S6xjTEtTw3XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="X1iO/1F7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A798606A32A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1iO/1F7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AC11F00A06;
	Wed, 11 Nov 2026 16:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415612;
	bh=jCHgsRUMw7NDxNvn0Y+N5QXXoPG/eG7+zuDD4fIGy+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X1iO/1F7Yrg9KjYoyyvgkLOp9835xbMe6RZ/uOvEyyuTbYqeOnapEwB3OM5zx04/+
	 9iY9HwxU4WBhVyRL6yxgS477iFVcndLSddaqBMObia/RmghCgrwkRf0HjoT5wGG/nd
	 vLLCN/ZBvJj5iyInfpP4eYWfZ33xlRHcLXFaNuXLiGav5quEUEfVHgfGB3xBikEZud
	 Lf5b4weBRGxjouUk8/GPUdSUSSvMGMAK8RSnC7JMJFqxASYPs+wfCdp+SMKF8lJJCV
	 F8natpzaIlW1qOcpUBdvQ21iCcyzpMt55gUxp8wU2A6us41Fg20rQR95CKH2oSLQfY
	 DWJMsDgn+XmPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Martin Wilck <mwilck@suse.com>,
	Daniel Wagner <dwagner@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] nvme-auth: use chap->s2 to indicate bidirectional authentication
Date: Wed, 11 Nov 2026 11:46:47 -0500
Message-ID: <20261111164614.3321142-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111164614.3321142-1-sashal@kernel.org>
References: <20261107054808-failed-6.1-f9e43d924bc7@kernel.org>
 <20261111164614.3321142-1-sashal@kernel.org>
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

From: Martin Wilck <mwilck@suse.com>

[ Upstream commit 4ae55a7dce04989f289d5c5c8c8e5c37adc36c71 ]

Commit 546dea18c999 ("nvme-auth: check chap ctrl_key once constructed")
replaced the condition "if (ctrl->ctrl_key)" (indicating bidirectional
auth) by "if (chap->ctrl_key)", because ctrl->ctrl_key is a resource shared
with sysfs. But chap->ctrl_key is set in
nvme_auth_process_dhchap_challenge() depending on the DHVLEN in the
DH-HMAC-CHAP Challenge message received from the controller, and will thus
be non-NULL for every DH-HMAC-CHAP exchange, even if unidirectional auth
was requested. This will lead to a protocol violation by sending a Success2
message in the unidirectional case (per NVMe base spec 2.0, the
authentication transaction ends after the Success1 message for
unidirectional auth). Use chap->s2 instead, which is non-zero if and only
if the host requested bi-directional authentication from the controller.

Fixes: 546dea18c999 ("nvme-auth: check chap ctrl_key once constructed")
Signed-off-by: Martin Wilck <mwilck@suse.com>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Stable-dep-of: f9e43d924bc7 ("nvme-auth: fail when the controller does not authenticate itself")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/auth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index c741539afa55c..1679663bf8f01 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -344,7 +344,7 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
 	struct nvmf_auth_dhchap_success1_data *data = chap->buf;
 	size_t size = sizeof(*data);
 
-	if (chap->ctrl_key)
+	if (chap->s2)
 		size += chap->hash_len;
 
 	if (chap->buf_size < size) {
@@ -819,7 +819,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 		goto fail2;
 	}
 
-	if (chap->ctrl_key) {
+	if (chap->s2) {
 		/* DH-HMAC-CHAP Step 5: send success2 */
 		dev_dbg(ctrl->device, "%s: qid %d send success2\n",
 			__func__, chap->qid);
-- 
2.53.0

