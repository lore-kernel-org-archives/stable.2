Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959D442A7A7
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557090; cv=none; b=rlZzvvDXFYbAe87huww+Q7qFjHi7zXPDJJsLc4hlGvr2OU5vSunFIlmfC3bwvdoItFdqguK4cGOmZfzX4R0Ion+Yjv1A9uio7w/M6Zxj1aevo7j4njUepfk5p7Vzxuyl0yoYFfnHZ/ZkDFnpHv7q2g5c1pgDDVo27B8IddbT998=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557090; c=relaxed/simple;
	bh=kw1oF9qsLvrFyeCU0ZXAiGaxbjgK2wMLdIT4ldV7Dow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCBJvtzQ9FdXyBbFeKhatnRXoG7dzG9d1D12u11jHXwvrqDEE2UDjoIE+SNEi/AIF98gjTu7+wCcdAuy/GyA7ZC8MtEMIun/GoR+b4QaMSxhf40cGdrLUvxhHX2ba5fsxa9au8VPOtEJGTmBMBDty8CYHR2AETsqpMr+SYwneYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UD+CVOzT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UD+CVOzT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BB81F000E9;
	Mon, 20 Jul 2026 14:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784557089;
	bh=SRModx71kMCtC7Ni8ePP3VBhIXGU/iAIHVQvv1kV+dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UD+CVOzTWNiZbl2UprBb1DrzVnP6ZNsDxxB7a3E1o7HQn05+UfOMjApCKwaOB84We
	 lSyBbdV0gM+GxqImoQiO31h/DwYJY0GqcremF1dHxkluz8r5cIsp2tZd3kVn2lEvNC
	 u51Nvkb9DP+bRFjLQK8uzm5MSjYMjnsrt6hS1USpfIti3mA4gck+xWf+Kcu0pLwwEd
	 50CQDkxhKy5tQm790CWEZOYrEBqPRCT3XpdZY2HByB1uJby1PJP/I/K19Ak0vagdXK
	 nqg/c6PU2oT1XUR6Dtw6bXC+04CsAlWdnF9ePN8+uY1CV0GzWtHjThRE09TYmrVDr3
	 BBRCds4gTEdcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] nvmet: remove superfluous initialization
Date: Mon, 20 Jul 2026 10:18:04 -0400
Message-ID: <20260720141806.1621638-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071506-uncounted-retaliate-5437@gregkh>
References: <2026071506-uncounted-retaliate-5437@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chaitanya Kulkarni <kch@nvidia.com>

[ Upstream commit 8d30528a170905ede9ab6ab81f229e441808590b ]

Remove superfluous initialization of status variable in
nvmet_execute_admin_connect() and nvmet_execute_io_connect(), since it
will get overwritten by nvmet_copy_from_sgl().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Stable-dep-of: 3a413ece2504 ("nvmet-auth: validate reply message payload bounds against transfer length")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fabrics-cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index fa9e8dc9215398..441a6b6170fda5 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -209,7 +209,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	struct nvmf_connect_command *c = &req->cmd->connect;
 	struct nvmf_connect_data *d;
 	struct nvmet_ctrl *ctrl = NULL;
-	u16 status = 0;
+	u16 status;
 	int ret;
 
 	if (!nvmet_check_transfer_len(req, sizeof(struct nvmf_connect_data)))
@@ -287,7 +287,7 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	struct nvmf_connect_data *d;
 	struct nvmet_ctrl *ctrl;
 	u16 qid = le16_to_cpu(c->qid);
-	u16 status = 0;
+	u16 status;
 
 	if (!nvmet_check_transfer_len(req, sizeof(struct nvmf_connect_data)))
 		return;
-- 
2.53.0

