Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3A7368D7E
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139864; cv=none; b=WWKFZhxRFrAuVvzfAez2DNbXx3dEKY1dL5/sl0a8t5ywET+fvAhDqShR9Jcxd9BXNOWsjD9SZarJEX9RRxAPz2djQuZbC2G6ACiEIIEALpD9FFJsizi+09k1rd75h9sTVtDGNf3MpkOwJr6wNt7zlNGOtZXtZxLGyoBucKHg4B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139864; c=relaxed/simple;
	bh=DLI/DHgpW4LzcmbyblIveq4grLqjnRjBWaQZr3VDECk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGT0ZiiQtFxc4Wz9yMNFR3hceuCdGWh9zlJoaI7vcyvOUgkzeNCdSM3WVOcaEX8OItbvHZ/tErulQrfNdbErImFu7foJpXZ+TRHR6tfdqB2KWwZUjjB8KT5YxPDNHZbWoW4ktGovPRlAvAt8iHwUO7z1V6A3V2CvPWwt4KMLlrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjQnzc0V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjQnzc0V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2676C1F000FF;
	Fri, 11 Sep 2026 15:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789139862;
	bh=KuLibJ2VU9Kb0Y4Lsv8tovrxHnN21J5gaq4F6R7Qpng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FjQnzc0V02O4Ox63JcqJ1wz/RncQVgoph5AAxF4CzWBWYcFrtZ3Q72E+4AwXocwNY
	 A+9SVwHR1gXWznBifbbc2buDYIbf8byO+qaByXUpwT9BTcbMbWXAUfLfWhq7FhEOzH
	 aXLXT254Z/SPC8xtnlodgfgyVyIhEkqlFP8apst9CmZR8IsGfpQh/3cUeqwKsxetj5
	 M6jJI3ELwOiMgqnOPhcuDPg+M43y9aasoGaMWxrOt0M6WkmL0QyZmbKBLcZ8S6cbHu
	 8PTObeNfSU+vKWeDbBqGiEbz8qgEpn6E763iEq+gaW/znX0D+NiuwHLgUIhA406xAF
	 vEnLhI1I/fmrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y] scsi: qla2xxx: Skip vport under deletion in report ID acquisition
Date: Fri, 11 Sep 2026 11:17:40 -0400
Message-ID: <20260911151740.1061861-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090949-dipper-unlucky-6791@gregkh>
References: <2026090949-dipper-unlucky-6791@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nilesh Javali <njavali@marvell.com>

[ Upstream commit 23582731afa35031c94fadb71a4f3b4afd094649 ]

qla24xx_report_id_acquisition() format-1 handling walks ha->vp_list under
vport_slock, takes a vref_count on the matching vport and calls
qla_update_host_map() to register its port id.

A vport teardown via qla24xx_vport_delete() sets VPORT_DELETE, then
qla24xx_disable_vp() removes the vport from the host_map btree and zeroes
vha->d_id (RESET_AL_PA). The vport is only unlinked from vp_list later,
in qla24xx_deallocate_vp_id(), which clears vp_map[idx] (RESET_VP_IDX)
but does not touch host_map. In the window in between, report ID
acquisition can still find the vport on vp_list and call
qla_update_host_map(); with d_id already zeroed it takes the
btree_insert32() path and re-inserts the dying vport into host_map.
Nothing cleans that entry afterwards, so once scsi_host_put() frees the
vha a later host_map lookup dereferences freed memory.

Skip a vport that has VPORT_DELETE set before taking the reference, so it
is neither re-registered nor scheduled for DPC re-registration. This
mirrors the existing guard in qla2x00_alert_all_vps().

Fixes: 41dc529a4602 ("qla2xxx: Improve RSCN handling in driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-dev@google.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://patch.msgid.link/20260730155838.2119230-22-njavali@marvell.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
[ Adjusted context to use rptid_entry->vp_idx instead of the missing local vp_idx variable. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_mbx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index f604aab8b161e..233e7fe2239a3 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -4204,6 +4204,8 @@ qla24xx_report_id_acquisition(scsi_qla_host_t *vha,
 			spin_lock_irqsave(&ha->vport_slock, flags);
 			list_for_each_entry(vp, &ha->vp_list, list) {
 				if (rptid_entry->vp_idx == vp->vp_idx) {
+					if (test_bit(VPORT_DELETE, &vp->dpc_flags))
+						break;
 					found = 1;
 					atomic_inc(&vp->vref_count);
 					break;
-- 
2.53.0

