Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8826A425CC6
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556636; cv=none; b=cuOHWgXBmT5TifTwd7j6DblJLJxRXH4AnMCynSJajK7zQrpz113hL17ugclUYuxsGKjQlOHEXceS2PdSUjl6+yZuVtA0bymtqipfn9evNXyludaN+rKuc/tmbl1gLqVCT4ti1jl4Z6fAWbJGf70wGsHbS7ofl7zHB65MeseQiLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556636; c=relaxed/simple;
	bh=kw1oF9qsLvrFyeCU0ZXAiGaxbjgK2wMLdIT4ldV7Dow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJt13s7dz8tO59B1fIk8ApKFO/01QgwOCKkcK0gaX3ElgN/fMLqJR+WZouFNe1YDbsAcOQ9aQI0I59wbWWW+l/rhLcC4N1NyfWB5J5uvs8H8WiVzRJzzoUoV4jBL8grUHO4N5muRi5/buNOd12IXurRqXspGnmCj/0oOUAbWgYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ea7NTJfk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ea7NTJfk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE061F000E9;
	Mon, 20 Jul 2026 14:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784556635;
	bh=SRModx71kMCtC7Ni8ePP3VBhIXGU/iAIHVQvv1kV+dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ea7NTJfkX9ljdwbEZI6gs/2JVykIzOo3QoMlGvTIB4qkkw3tcm0fqFM1SL/8lbLnd
	 LHsytERMLWgZ4AsV3aa9KyADhspEHITcoR19P1t0RCVc90ofp+2kCwMEUHLVMXddoJ
	 bqYFKeeqdRFEeSIiP3YMWqgTUk1Ym10Mz58EzDFrdNqkpUGsAMIZr5MWjHBMo3IDCi
	 jIS2OoQCWNYn6VYvvS8ClSnBhU82Rzy8U3jknxzegMYMEfbvMZM1Asfw+AK93BIPB8
	 sQfk+TFx4vsiE086LNSzs37tJQNfmpuvtTCBulU0Y20srma87ZQcrqXkrpbGM2kQSC
	 8A6F1cpda4TPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] nvmet: remove superfluous initialization
Date: Mon, 20 Jul 2026 10:10:31 -0400
Message-ID: <20260720141033.1500263-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071506-ankle-quartered-9eb2@gregkh>
References: <2026071506-ankle-quartered-9eb2@gregkh>
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

