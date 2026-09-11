Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B185328B7F
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140521; cv=none; b=EMftMJvJPu97pBWZhAJ3St+FJb+4bYKzLPIxyP7wCZkPkNxXtSBoqRBJA6ZapMtJEKHRM5dTY5k5AcOpGu0Al8P2m3r+aPLjivLgWCZCHPvZ7PmNQv+9+F3C6UzOY75DjC+3T4myMRGxj6UhG6wRwsJPFzxjLoLyVnDYW95/Vqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140521; c=relaxed/simple;
	bh=4C84/TUsxxJwmsBibCJQO2DYmN2mixkh3HDLrVl7oiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PuvYnxgP3+PKOvAUejTSgKB7SpkjLJcHZPe8ICGnO/5zb6RHPJChrhUP7+KppeR/on4Bjy7OkwNZIhpFQvngNVMSeTCeOANBRNEY3AjeCpUg4CDVi2i6aitZwWE2ImHeQ/L3o5mlHX5HmczcgV2BdMjQkvLyjj0eEXCv3uOwT+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofye3mWy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofye3mWy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A2D1F00893;
	Fri, 11 Sep 2026 15:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789140518;
	bh=weQxR0eF2QY5C16vQOJebhJuVIdSwpmzxqLxA0CWWHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ofye3mWye3xIlMyUz4UGZzDeYsJoIbgdgatFUe7xBY+JwVK/aOY2pxHSV3uhhGWzv
	 NR9b9RnHbC1hl9lnkY4LEFWHeNqkrDSIGJP5wasqYH8q6BGu/sRpmg9R/8ggMy31sz
	 s0TQaLzCFa1zC1ZK+t964jjwUH0OLnEzbvThiSN9lp39KPXsDK+/k2cQn8SmAw+yjS
	 MkxGJ/ovT3YU88g+aXa58kVVyLSOyBihHyqK6SuavF/hjzFhQ1kHreE6JXnnPm0oWs
	 abS4Ixn36kbvejDDU1Pu8jWWKUOMQYldJNZdNIS1lFlS6ZlKcIzMXKpUY5NOmp8QjG
	 92I4MBY2C5LEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Hannes Reinecke <hare@kernel.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] scsi: qla2xxx: Zero dport diagnostics buffer to avoid info leak
Date: Fri, 11 Sep 2026 11:28:36 -0400
Message-ID: <20260911152836.1078305-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090930-ridden-childcare-44d5@gregkh>
References: <2026090930-ridden-childcare-44d5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Nilesh Javali <njavali@marvell.com>

[ Upstream commit a152edab3854f01dd2daf3eaf8f32cbabdb3834e ]

qla2x00_do_dport_diagnostics() allocates the qla_dport_diag response
buffer with kmalloc_obj() (non-zeroing) and, on success, copies the full
sizeof(*dd) back to user space via sg_copy_from_buffer(). The inbound
sg_copy_to_buffer() only fills as many bytes as the user request payload
provides, and qla26xx_dport_diagnostics() zeroes only dd->buf. The
options and unused[] fields are therefore copied out uninitialized,
leaking kernel heap contents to user space.

Allocate with kzalloc_obj(), matching qla2x00_do_dport_diagnostics_v2().

Fixes: ec89146215d1 ("qla2xxx: Add bsg interface to support D_Port Diagnostics.")
Cc: stable@vger.kernel.org
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Link: https://patch.msgid.link/20260723050413.3897522-54-njavali@marvell.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
[ Adapted kzalloc_obj(*dd) to kzalloc(sizeof(*dd), GFP_KERNEL) to match the branch’s allocation syntax. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_bsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index 23779a1f0cee9..aadc5d0b6c270 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -2393,7 +2393,7 @@ qla2x00_do_dport_diagnostics(struct bsg_job *bsg_job)
 	    !IS_QLA28XX(vha->hw))
 		return -EPERM;
 
-	dd = kmalloc(sizeof(*dd), GFP_KERNEL);
+	dd = kzalloc(sizeof(*dd), GFP_KERNEL);
 	if (!dd) {
 		ql_log(ql_log_warn, vha, 0x70db,
 		    "Failed to allocate memory for dport.\n");
-- 
2.53.0

