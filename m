Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E619B365A0F
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138944; cv=none; b=nJOyCzjAHd/tB8mcxJ1yIpq4MtC9hYRPqDsUxrGysviCzWgHY64xrhkXCAzCCxU/o7rwE9U+YWVdEg7TuB20D1SC/LKtL2wpd/v6vqLStjVCi6TgIG16Ydy74V7s1cOKnUhW/ndtmLxptLOPziIrDRZ64Ejb51wNoJDXCKtufLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138944; c=relaxed/simple;
	bh=2d0+6cy6f4XhTG7VQJ3ZaGv/foEhDXBCMdiYmNflVOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BwYL4Q6guO7MQDB7ki6x5Ojs2WcAixUpOFQQBkEp7RQBBUL5+dJi6pCAWdYVkDDyXr4d0l3PsWz+mSOMuLcFPwaJNLszJtqCI5WwYOoPKXXqoqswsrps4L1muQV+91V45/qfReokGwtoqhQGFf/xS9xhP/RMz7cSDQZJI9UZeZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtAqRrTt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtAqRrTt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F221F00898;
	Fri, 11 Sep 2026 15:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789138942;
	bh=swMZ7f05zOxqxgeW469i/fL7joP+FMrVsKS+mGew278=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XtAqRrTtP8xKZW9SVr0TUirwFU4Fo+r37pXpFOOyoNKei/yLzg/IkSUifk1uhaiZc
	 J7xwU5MHiH7S/DLPkpXjLkxfkmrVpmPEWVyUTwTm7am5QxnTv9CGFKNvMkyW9T2KRQ
	 n4tmuEYu7TW/Cnp2hR9BfLb5MoxiAk1tunONuAKbDCdrz6XPe66+4Bq6V6LW6wuulx
	 XcLGnGLX+/jsihyk6BCAlFNeZvTSBXMgXCoxChKZcQhoXtavlwNGQub4hQwn8Kvukr
	 8hYSSTH4Xw1QbzJstKYn6Npo2kPPhlH8UudZ2uqT3cWO1TgXYTli7thNL++JAexRPF
	 SHPNacSi/zjmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Hannes Reinecke <hare@kernel.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] scsi: qla2xxx: Zero dport diagnostics buffer to avoid info leak
Date: Fri, 11 Sep 2026 11:02:20 -0400
Message-ID: <20260911150220.1018221-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090929-drown-fructose-985e@gregkh>
References: <2026090929-drown-fructose-985e@gregkh>
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
index f43969ed87bf9..9319b81ea0b8c 100644
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

