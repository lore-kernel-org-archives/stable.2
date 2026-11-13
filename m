Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794540491;
	b=IX2622hufCS2L+IV9PDn/sr+SkGjxUzAf1jC0yRT1mLZcEdpJgqoCn0jgPo0yPta59Dq
	 Wq8Utzv5ZexNiuEmM+Lz7nCcf460qvO+c5k+ZzbNVXIZ8GVLG5niiT6Y59Je4CfrswKNy
	 bdfXOUYilL3+gnKjax4GBC/PHQfSLD8z9L2IMfgtKD42P436dMEOXt6hTbjel+RxvV+Qe
	 OJ/2erXd2JRLUX/IR92niVcbH5C4CUX5VBWh54pvgSFhj07m6p08HNYQ3auDRw/BDn0zQ
	 1KigFmvx+FYjTms62sSBIuNeLIWpYi6dggEuok+HLGwd4gwgzfhF+rDS4ue2ij8fLug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794540491;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=47e5iIUR3s6TA5KQT1aw+v2oYNC63fyYGFv015lE1kQ=;
	b=isCt0F78PiL1UqwV14/k8GCXuGYa8TEaQmiMNui18nrjnUs1UWisaZVZ99l9yaiM0WcL
	 NKHN+ICzBsmlvX+3t08Dib4RmoiEII8kalrSO1Jn64BXrWVhg/QQeYoBc74TMuDKxLmcA
	 zprAEbaiOSrQiAjNR9xcoDjHNdJzJyqZEakPzFKGU4FoHOuG8Ww7oNf5fNxtgXPn+1FC3
	 r/dEhF97Lqu1cm0bNB29USvDZktp+2IWTJuGu2c2fvbvNB2wK99zOx2a2z4CpheT1/Xzf
	 KhVDGRitji9KVpApo/69a+qECevLTFnGUdTqVnxOWlFlbis43XC92lx04XhwoD0Kgxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZTs0jzOl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748DF606A31C
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZTs0jzOl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798641F000C4;
	Fri, 13 Nov 2026 03:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794540491;
	bh=47e5iIUR3s6TA5KQT1aw+v2oYNC63fyYGFv015lE1kQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZTs0jzOlaXOeBY/VEVd11H8J6//sTkXNJXF19BSRzNRdXjF0zEkYdxQRBHcSYxbgI
	 VShx2Aoe5ag8rCpZPmS2CQ7ac9QdsTpkBo1HciHk+3+HQF9fa5E9wOQfhtPCagMhWy
	 wzGuvgcpTvEhODWdRnO0vVfMcTQf0Ehp8lG8iiZRoTsE5Kf5FnpwFCMniNQxM5QC66
	 xqcGBJPKf9FBUCh9VMeQ0XtRWes5W2cXG5Z4q68Ck1D0uJ+S5tzb6v8xMFMoTziSnR
	 X1seYFMqaZc5IfE6Ww4348xHsRaLs7jRAmG9tUfQpmSj6zlhDUvNtwC/5EUgzTH8HO
	 Xj0vb3pj3bPLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guixin Liu <kanie@linux.alibaba.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] nvme: tuning pr code by using defined structs and macros
Date: Thu, 12 Nov 2026 22:28:08 -0500
Message-ID: <20261113032744.1045431-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200733-failed-6.12-a9d431124fb2@kernel.org>
References: <20261109200733-failed-6.12-a9d431124fb2@kernel.org>
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

From: Guixin Liu <kanie@linux.alibaba.com>

[ Upstream commit 029cc98dec2eadb5d0978b5fea9ae6c427f2a020 ]

All the modifications are simply to make the code more readable,
and this patch does not include any functional changes.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Stable-dep-of: a9d431124fb2 ("nvme: unregister when pr_register() is given a zero new key")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pr.c | 122 +++++++++++++++++++++++++----------------
 1 file changed, 75 insertions(+), 47 deletions(-)

diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index e1d07f824b13c..fe7dbe2648158 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -92,109 +92,137 @@ static int nvme_status_to_pr_err(int status)
 	}
 }
 
-static int nvme_send_pr_command(struct block_device *bdev,
-		struct nvme_command *c, void *data, unsigned int data_len)
+static int __nvme_send_pr_command(struct block_device *bdev, u32 cdw10,
+		u32 cdw11, u8 op, void *data, unsigned int data_len)
 {
-	if (nvme_disk_is_ns_head(bdev->bd_disk))
-		return nvme_send_ns_head_pr_command(bdev, c, data, data_len);
+	struct nvme_command c = { 0 };
 
-	return nvme_send_ns_pr_command(bdev->bd_disk->private_data, c, data,
-				       data_len);
+	c.common.opcode = op;
+	c.common.cdw10 = cpu_to_le32(cdw10);
+	c.common.cdw11 = cpu_to_le32(cdw11);
+
+	if (nvme_disk_is_ns_head(bdev->bd_disk))
+		return nvme_send_ns_head_pr_command(bdev, &c, data, data_len);
+	return nvme_send_ns_pr_command(bdev->bd_disk->private_data, &c,
+				data, data_len);
 }
 
-static int nvme_pr_command(struct block_device *bdev, u32 cdw10,
-				u64 key, u64 sa_key, u8 op)
+static int nvme_send_pr_command(struct block_device *bdev, u32 cdw10, u32 cdw11,
+		u8 op, void *data, unsigned int data_len)
 {
-	struct nvme_command c = { };
-	u8 data[16] = { 0, };
 	int ret;
 
-	put_unaligned_le64(key, &data[0]);
-	put_unaligned_le64(sa_key, &data[8]);
-
-	c.common.opcode = op;
-	c.common.cdw10 = cpu_to_le32(cdw10);
-
-	ret = nvme_send_pr_command(bdev, &c, data, sizeof(data));
-	if (ret < 0)
-		return ret;
-
-	return nvme_status_to_pr_err(ret);
+	ret = __nvme_send_pr_command(bdev, cdw10, cdw11, op, data, data_len);
+	return ret < 0 ? ret : nvme_status_to_pr_err(ret);
 }
 
-static int nvme_pr_register(struct block_device *bdev, u64 old,
-		u64 new, unsigned flags)
+static int nvme_pr_register(struct block_device *bdev, u64 old_key, u64 new_key,
+		unsigned int flags)
 {
+	struct nvmet_pr_register_data data = { 0 };
 	u32 cdw10;
 
 	if (flags & ~PR_FL_IGNORE_KEY)
 		return -EOPNOTSUPP;
 
-	cdw10 = old ? 2 : 0;
-	cdw10 |= (flags & PR_FL_IGNORE_KEY) ? 1 << 3 : 0;
-	cdw10 |= (1 << 30) | (1 << 31); /* PTPL=1 */
-	return nvme_pr_command(bdev, cdw10, old, new, nvme_cmd_resv_register);
+	data.crkey = cpu_to_le64(old_key);
+	data.nrkey = cpu_to_le64(new_key);
+
+	cdw10 = old_key ? NVME_PR_REGISTER_ACT_REPLACE :
+		NVME_PR_REGISTER_ACT_REG;
+	cdw10 |= (flags & PR_FL_IGNORE_KEY) ? NVME_PR_IGNORE_KEY : 0;
+	cdw10 |= NVME_PR_CPTPL_PERSIST;
+
+	return nvme_send_pr_command(bdev, cdw10, 0, nvme_cmd_resv_register,
+			&data, sizeof(data));
 }
 
 static int nvme_pr_reserve(struct block_device *bdev, u64 key,
 		enum pr_type type, unsigned flags)
 {
+	struct nvmet_pr_acquire_data data = { 0 };
 	u32 cdw10;
 
 	if (flags & ~PR_FL_IGNORE_KEY)
 		return -EOPNOTSUPP;
 
-	cdw10 = nvme_pr_type_from_blk(type) << 8;
-	cdw10 |= ((flags & PR_FL_IGNORE_KEY) ? 1 << 3 : 0);
-	return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_acquire);
+	data.crkey = cpu_to_le64(key);
+
+	cdw10 = NVME_PR_ACQUIRE_ACT_ACQUIRE;
+	cdw10 |= nvme_pr_type_from_blk(type) << 8;
+	cdw10 |= (flags & PR_FL_IGNORE_KEY) ? NVME_PR_IGNORE_KEY : 0;
+
+	return nvme_send_pr_command(bdev, cdw10, 0, nvme_cmd_resv_acquire,
+			&data, sizeof(data));
 }
 
 static int nvme_pr_preempt(struct block_device *bdev, u64 old, u64 new,
 		enum pr_type type, bool abort)
 {
-	u32 cdw10 = nvme_pr_type_from_blk(type) << 8 | (abort ? 2 : 1);
+	struct nvmet_pr_acquire_data data = { 0 };
+	u32 cdw10;
+
+	data.crkey = cpu_to_le64(old);
+	data.prkey = cpu_to_le64(new);
 
-	return nvme_pr_command(bdev, cdw10, old, new, nvme_cmd_resv_acquire);
+	cdw10 = abort ? NVME_PR_ACQUIRE_ACT_PREEMPT_AND_ABORT :
+			NVME_PR_ACQUIRE_ACT_PREEMPT;
+	cdw10 |= nvme_pr_type_from_blk(type) << 8;
+
+	return nvme_send_pr_command(bdev, cdw10, 0, nvme_cmd_resv_acquire,
+			&data, sizeof(data));
 }
 
 static int nvme_pr_clear(struct block_device *bdev, u64 key)
 {
-	u32 cdw10 = 1 | (key ? 0 : 1 << 3);
+	struct nvmet_pr_release_data data = { 0 };
+	u32 cdw10;
+
+	data.crkey = cpu_to_le64(key);
 
-	return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_release);
+	cdw10 = NVME_PR_RELEASE_ACT_CLEAR;
+	cdw10 |= key ? 0 : NVME_PR_IGNORE_KEY;
+
+	return nvme_send_pr_command(bdev, cdw10, 0, nvme_cmd_resv_release,
+			&data, sizeof(data));
 }
 
 static int nvme_pr_release(struct block_device *bdev, u64 key, enum pr_type type)
 {
-	u32 cdw10 = nvme_pr_type_from_blk(type) << 8 | (key ? 0 : 1 << 3);
+	struct nvmet_pr_release_data data = { 0 };
+	u32 cdw10;
+
+	data.crkey = cpu_to_le64(key);
 
-	return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_release);
+	cdw10 = NVME_PR_RELEASE_ACT_RELEASE;
+	cdw10 |= nvme_pr_type_from_blk(type) << 8;
+	cdw10 |= key ? 0 : NVME_PR_IGNORE_KEY;
+
+	return nvme_send_pr_command(bdev, cdw10, 0, nvme_cmd_resv_release,
+			&data, sizeof(data));
 }
 
 static int nvme_pr_resv_report(struct block_device *bdev, void *data,
 		u32 data_len, bool *eds)
 {
-	struct nvme_command c = { };
+	u32 cdw10, cdw11;
 	int ret;
 
-	c.common.opcode = nvme_cmd_resv_report;
-	c.common.cdw10 = cpu_to_le32(nvme_bytes_to_numd(data_len));
-	c.common.cdw11 = cpu_to_le32(NVME_EXTENDED_DATA_STRUCT);
+	cdw10 = nvme_bytes_to_numd(data_len);
+	cdw11 = NVME_EXTENDED_DATA_STRUCT;
 	*eds = true;
 
 retry:
-	ret = nvme_send_pr_command(bdev, &c, data, data_len);
+	ret = __nvme_send_pr_command(bdev, cdw10, cdw11, nvme_cmd_resv_report,
+			data, data_len);
 	if (ret == NVME_SC_HOST_ID_INCONSIST &&
-	    c.common.cdw11 == cpu_to_le32(NVME_EXTENDED_DATA_STRUCT)) {
-		c.common.cdw11 = 0;
+	    cdw11 == NVME_EXTENDED_DATA_STRUCT) {
+		cdw11 = 0;
 		*eds = false;
 		goto retry;
 	}
 
-	if (ret < 0)
-		return ret;
-
-	return nvme_status_to_pr_err(ret);
+	return ret < 0 ? ret : nvme_status_to_pr_err(ret);
 }
 
 static int nvme_pr_read_keys(struct block_device *bdev,
-- 
2.53.0

