Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED51C383992
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138250; cv=none; b=lOVDw1y76m33s942IYRQBkSkWhQ+hNwTuJGFpbTDbs406c1RtQV84qwV1N6sF7HfbkZcOeVDvf50cF1M/6mv5muOx3UJQSLzWh0LHjDmBfeSv1N7OdCVqtMOKxYq5x6QRkhHR0bBty8WsHGwIyV1t1ymfTn/L2Uayh/a8GAJrX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138250; c=relaxed/simple;
	bh=jgmo3l5+sd4cWOiQWKQG9rygh4ZV/blUhOcnuVncVuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpc22zBfgHCgpYN8KsYotKf4jLBFjV46yZroYCbA/K2bgHS9sNAjkqdKFNzIGKsxtVjmQQV6lNr8QVmz5SAO18UuIiA/8M7HMgu8phs86ihMJq3O4JHBc8HsuGTFpu8uhw3kqvzZ0Yh0B+hYqZz5tVHVNwQ5FMBrb4ZyF/C6GIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bupkyScB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bupkyScB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AE61F00893;
	Fri, 11 Sep 2026 14:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789138248;
	bh=CMucD6GGn0cm/F5lEJGAUuD89BgOTaRzg/xEZv/p23Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bupkyScBi1/bVJA1hizm366vg58yoMwTwVqnXGM4rN38ZKPx455cKB8azoLMMvwKS
	 D1cKSnZY7DWkWdoSO8cFtz61lSBA72oi9/YBEd45zQ5cYzwfSHHg3X2u14ucHuZAu5
	 piJsYbhLY6hW1WQfGgzegnnO37rD1TpDW+F+KCMaDBqCSbzIKp1coWz9q1GiwjzL6p
	 PKNfgImHkRnxSvQdTRgDMCR0iuPPVtxHM3nzUUOJNqQTfGQLXOkfX7AjFYS5dm2m1h
	 ze2DR4x7IbWGmuO10fdiDmFbULx6+AOxJbikgMzpSwU1Fe3mBrgxeiL6IzRtgA9YuA
	 s1UF5K18ssEXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Hannes Reinecke <hare@kernel.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] scsi: qla2xxx: Zero dport diagnostics buffer to avoid info leak
Date: Fri, 11 Sep 2026 10:50:46 -0400
Message-ID: <20260911145046.984265-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090928-deputize-waltz-4cbc@gregkh>
References: <2026090928-deputize-waltz-4cbc@gregkh>
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
index 647f89c635785..352d05a02f107 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -2412,7 +2412,7 @@ qla2x00_do_dport_diagnostics(struct bsg_job *bsg_job)
 	    !IS_QLA28XX(vha->hw))
 		return -EPERM;
 
-	dd = kmalloc(sizeof(*dd), GFP_KERNEL);
+	dd = kzalloc(sizeof(*dd), GFP_KERNEL);
 	if (!dd) {
 		ql_log(ql_log_warn, vha, 0x70db,
 		    "Failed to allocate memory for dport.\n");
-- 
2.53.0

