Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704EE3976A4
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140512; cv=none; b=ISuGpTPMeOedQ7hkFPNqDygucsJlRXITnZODzF93FktmiHJla9RMcYsK4u4wpxqx9KTFigcrpkQiJ6Y7bBvMUwtJbp3nnkKJdo8Gp5W2ktxgkfxEBVs6lrG3Zgt/9Z2xZ/TWjdOvxq0Dka7Ni3KREhtYbprWsmtOBm6qhi14Umg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140512; c=relaxed/simple;
	bh=sXlB9ToWp73WnxecwmNiDujxvcGafOxrrWgyZXtI3jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxV87qX0hUvzyZyNgtLr9a8fQ1mSp750Pu50SYi6/ZM8nA+AyptsrN2A1AnNDjLJ1GH37iOwUJKoDEExWzi6BQIRbFQZnavOBtCnXaYgmabYG5xIykvvk3HfwxutiEsL5kRgtADYOCj5TSGYkzrZDZ9P1SWYffTjsvbMtH6RJZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IX91OK9I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IX91OK9I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989771F00893;
	Fri, 11 Sep 2026 15:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789140511;
	bh=Sf+1zhmyK0Q6BZYX05LM2v6d06GzfG9BaVJ3lASuSg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IX91OK9I37Tk4BIbfl4oNGhkrw0yqR3dcJ0fiFVyesSGn42r2gKNg5ycG46BxcNp9
	 M+aNdeAjk7evf8NZC3Jd3A/9iygX3lTv2wauQALD/mfZLdqJvie+J+798/9U0lwrB6
	 2yjAi0NSjokaiFjgVPBbBK5Ps+URIG4YHfKmBYsdvrBP5Y54q7/pucB6AsPMDH6baU
	 baecJH9ics74nRuV20CT4tHpkwtF1w5sgY3xqruJoHwdzJgzndmYqi4MLMknXKhJ5b
	 WdM0NJ/G8x5jdppI3L4YZiTHYWEux4y+Zbjh8ZhPsikelEEh1gluNM0ekx3Rol4r7G
	 jpMmmDqbkZLnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Hannes Reinecke <hare@kernel.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] scsi: qla2xxx: Fix 64G link speed reporting in get_data_rate
Date: Fri, 11 Sep 2026 11:28:28 -0400
Message-ID: <20260911152828.1077940-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090958-palpable-backyard-4a40@gregkh>
References: <2026090958-palpable-backyard-4a40@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nilesh Javali <njavali@marvell.com>

[ Upstream commit 52fba32317ee631faa878725b2f7cd5c08acacd3 ]

qla2x00_get_data_rate() skips updating ha->link_data_rate when the
firmware returns mcp->mb[1] == 0x7.  That value was a legacy sentinel
from before 64G hardware existed, but PORT_SPEED_64GB is now defined as
0x07 and ha->link_data_rate is decoded with the PORT_SPEED_* encoding.
On a 64G-capable adapter a genuine 64G link is therefore dropped, and
the port speed is misreported (port_speed sysfs, fc_host speed, FDMI).

Only 28xx and 29xx support 64G, so accept 0x07 on those adapters while
keeping the legacy filter for older ones.  Also drop the duplicate copy
of the check at the end of the success branch; it repeated the first
assignment with no intervening change.

Fixes: ecc89f25e225 ("scsi: qla2xxx: Add Device ID for ISP28XX")
Cc: stable@vger.kernel.org
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Link: https://patch.msgid.link/20260723050413.3897522-46-njavali@marvell.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
[ Omitted IS_QLA29XX() checks because this branch lacks 29xx adapter support. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_mbx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 3b78c04feabdf..61dafa60385c1 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -5658,7 +5658,7 @@ qla2x00_get_data_rate(scsi_qla_host_t *vha)
 		ql_dbg(ql_dbg_mbx, vha, 0x1107,
 		    "Failed=%x mb[0]=%x.\n", rval, mcp->mb[0]);
 	} else {
-		if (mcp->mb[1] != 0x7)
+		if (mcp->mb[1] != 0x7 || IS_QLA28XX(ha))
 			ha->link_data_rate = mcp->mb[1];
 
 		if (IS_QLA83XX(ha) || IS_QLA27XX(ha) || IS_QLA28XX(ha)) {
@@ -5669,8 +5669,6 @@ qla2x00_get_data_rate(scsi_qla_host_t *vha)
 
 		ql_dbg(ql_dbg_mbx + ql_dbg_verbose, vha, 0x1108,
 		    "Done %s.\n", __func__);
-		if (mcp->mb[1] != 0x7)
-			ha->link_data_rate = mcp->mb[1];
 	}
 
 	return rval;
-- 
2.53.0

