Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D661C3E3C4F
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140809; cv=none; b=j4AalTNbGCnH8aElvJtiuJ4Hp5KGvo/S7GOwd0THk1U6tN84CwN8Wky/Fj/RctZq7WSmX0EEY+VWjt1YM2VPsJ17n1aWC05nHdpA6SNg6Sky48Dr+0LDQzYInUFoQW9+wBc9W+c9h6V3Z4YNWVXjC3Mf17FWGvt66yicUV3wuL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140809; c=relaxed/simple;
	bh=pdnyD01orYe3KZfDnG7wXxeJdVF5I+26ke3V6u5iXuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lfRHMLXP199cT4SZAhMDzSJluheOTw4zzOj63WgUclz35q+ZSGEZc72/W8i3z6AAOxDONVShNuTC48Bo3rv2N07WyGijXo+Ns8t5pZDIh+TERl+wkToyXviBgbYn4Vj+DJ7mbdlfmXxpHmxx9MD4ECM0j2MwHYS1GRJDTnJkDm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6WZgos5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6WZgos5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304C71F000FF;
	Fri, 11 Sep 2026 15:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789140807;
	bh=YbvBpLtPOn8BVnKmdv1NrpIxXf57FIo5KYwkd6yKpEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b6WZgos5fFpK9FjRpfcZ31YsVowkbEfswD4V7jKqomeQv2ocEZoI2EmFCqWxxxzqw
	 p5BzUJqYLhhAv7FlU3H+hi/LjLpclkuJfVwS6OHMpXB7TqQVpn2jDDZ62r5P+CELgI
	 TvfLieFkGCP42qfTbcYpok+sARTBVwLUwv3FxFD/M7GSufwJtE1wkL3JPGNQteQF+D
	 UnQz0PBdT7AgdTVDg/bAj5YhUZEm4Yn8yDeEpBKlQS8ZGSNbJdkUyT6XTeZtf3QuLF
	 Ig78+t+btcMgC+pMwL1wcgQZvm4qiAIpXO2WRK1khz2qBaiOtNJN1v+iPKJjPFDTpi
	 qVQW7ZkjPPPIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Hannes Reinecke <hare@kernel.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] scsi: qla2xxx: Zero dport diagnostics buffer to avoid info leak
Date: Fri, 11 Sep 2026 11:33:25 -0400
Message-ID: <20260911153325.1096405-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090930-eternity-flask-8944@gregkh>
References: <2026090930-eternity-flask-8944@gregkh>
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
index c37945ac9eca7..a2468662d05f5 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -2370,7 +2370,7 @@ qla2x00_do_dport_diagnostics(struct bsg_job *bsg_job)
 	    !IS_QLA28XX(vha->hw))
 		return -EPERM;
 
-	dd = kmalloc(sizeof(*dd), GFP_KERNEL);
+	dd = kzalloc(sizeof(*dd), GFP_KERNEL);
 	if (!dd) {
 		ql_log(ql_log_warn, vha, 0x70db,
 		    "Failed to allocate memory for dport.\n");
-- 
2.53.0

