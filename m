Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EB3369224
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139149; cv=none; b=PS08D9UsTRZPNufKrna1X/FT2Dlk+RlGB1ELQFhm1bVGaCiUeTYV4QYY5ojv3JHfJGWl402d5SU0eyPMLVWy1QqSWtaWYpvc5N5b+WporU4ZrBrBA9YERvSkVMXxFAS8sZ/l/rVIkkWzLwO/+beVTTjDBBh/6gpwOi9BdA6D2eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139149; c=relaxed/simple;
	bh=2d0+6cy6f4XhTG7VQJ3ZaGv/foEhDXBCMdiYmNflVOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q0qX8663sY8c4wxgK+xx2clfVmHzWzprWdtua3FFjZqquBoFVGDW9KHtV5/UyOXQcu/LiQhSaHvjBGIPDveWHJZyc1uJoRDIvx0oIljnV9c58PB1xOqmaK29yUlhPtVV0kWVZugEb/wNe7/tiHpTJCf2V2PX6qlnLXqYRGptCaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLim+o0/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLim+o0/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6080B1F000FF;
	Fri, 11 Sep 2026 15:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789139148;
	bh=swMZ7f05zOxqxgeW469i/fL7joP+FMrVsKS+mGew278=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nLim+o0/TTJfr+WkcmazyeYKFlxMFTrvbrEw5nmbxV9z52mNq91tLLVI2wgKQdXKS
	 ApqTkRszE6lqJhfJXm0vc03zl7ImDlVqsXVOhKOxsXyMuY1vtwTjBkS2aSAdQxUY7o
	 n8Ny0/giMWwElKoDkqSQOuHPIK0FUlPLY3c/HnZV3sbGRc6tBHoahBQuocGcNuvu0/
	 /D5s2v+V9RlwcXl4j7sQG81ovCii7jzxMphFj1OzR3bPAvDk1s59o/pA3roFR6dPRG
	 SbZ1tqgdWITOfhTwFJ9v1rfMMy7X/fpZcwmcYQiUQ002GMhrfKxUf4J1mCbeGTCuI1
	 MCVvF5LQT4Mmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Hannes Reinecke <hare@kernel.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] scsi: qla2xxx: Zero dport diagnostics buffer to avoid info leak
Date: Fri, 11 Sep 2026 11:05:45 -0400
Message-ID: <20260911150545.1033533-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090929-willpower-demise-a921@gregkh>
References: <2026090929-willpower-demise-a921@gregkh>
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

