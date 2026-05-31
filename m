Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478891F8691
	for <stable@vger.kernel.org>; Sun, 31 May 2026 00:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780187045; cv=none; b=or49o2vZS4jp5GIgyhwizVOpl2bv2GIh8mr8R3d05QPvGSQjObk7tTeKGH8EAF8fW6WtxMJ7zJA5d/MWOYpRGtT7XLZsOzWiHLIMQvHASfVDXAnumXoGgTiMBjGLBAK1qaE0xvCir5v503oXTr5UMsLedzSQQJh6Mwjv11nMNH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780187045; c=relaxed/simple;
	bh=VJ/pH34+W0ttiWWoHGnNz76bhQz/hLYa1f0rEnqdTbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AE6mVyRP6WTwAQyf4CrnmVneykDdIUTbOpV4VrQNFo7YdCQYTkxN1C2cECSGDC6IO3QPi5Q/A7pm/KGsXkLar6nm7PrOyIFaRhmQZkiLjkj9G36ZgrgIFB8WwcosqYXnamJxYvluanRNMMyeFyoeM5Uwh4T3q83nzigfJeDpR/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1LTtjAg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1LTtjAg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB061F00893;
	Sun, 31 May 2026 00:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780187043;
	bh=YFxDPyERyPPlSNLc+Sru+cnpC207PLNgQj/1KvnuqJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g1LTtjAgKf5ESlljdq+olBb/pYkyqHkppqWguqe8ybwSVvaPve/79QI0fdifjcDrj
	 eg4l/PSsL/8nKDVip0LRnC7A027QVcZMdfArTiiwDzd+wXDf2r9UE2+sX05X7VF8uS
	 RkEjyF0twqp1rz+TggvyM1IeLoztTJpEqmN5M6eNAOJ357/OKW9WILFDBfxGy1MWsG
	 bs6Tu93Bu8zhRwsacMEyWjcbycX+yhDQiPOoPTPqgBvP1nJToA5yAlKuYnrV6LKuQn
	 BL1zMBJS7BOBwH+wgZN/NeI+5p7bIvL3Fn+/EG4VHjYiihty4cXsTA8XxgJ0f0ndSp
	 UR4kVDrTrcfYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hariprasad Kelam <hkelam@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Simon Horman <simon.horman@corigine.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] octeontx2-af: Add validation for lmac type
Date: Sat, 30 May 2026 20:23:59 -0400
Message-ID: <20260531002401.3659638-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052833-reuse-denial-9a59@gregkh>
References: <2026052833-reuse-denial-9a59@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hariprasad Kelam <hkelam@marvell.com>

[ Upstream commit cb5edce271764524b88b1a6866b3e626686d9a33 ]

Upon physical link change, firmware reports to the kernel about the
change along with the details like speed, lmac_type_id, etc.
Kernel derives lmac_type based on lmac_type_id received from firmware.

In a few scenarios, firmware returns an invalid lmac_type_id, which
is resulting in below kernel panic. This patch adds the missing
validation of the lmac_type_id field.

Internal error: Oops: 96000005 [#1] PREEMPT SMP
[   35.321595] Modules linked in:
[   35.328982] CPU: 0 PID: 31 Comm: kworker/0:1 Not tainted
5.4.210-g2e3169d8e1bc-dirty #17
[   35.337014] Hardware name: Marvell CN103XX board (DT)
[   35.344297] Workqueue: events work_for_cpu_fn
[   35.352730] pstate: 40400089 (nZcv daIf +PAN -UAO)
[   35.360267] pc : strncpy+0x10/0x30
[   35.366595] lr : cgx_link_change_handler+0x90/0x180

Fixes: 61071a871ea6 ("octeontx2-af: Forward CGX link notifications to PFs")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: c0bf0a4f3f1f ("octeontx2-af: CGX: add bounds check to cgx_speed_mbps index")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c  | 15 +++++++++++----
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h |  1 +
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 1eaf728d5e79f..91d607f031dfe 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -669,15 +669,22 @@ static inline void link_status_user_format(u64 lstat,
 					   struct cgx_link_user_info *linfo,
 					   struct cgx *cgx, u8 lmac_id)
 {
-	char *lmac_string;
-
 	linfo->link_up = FIELD_GET(RESP_LINKSTAT_UP, lstat);
 	linfo->full_duplex = FIELD_GET(RESP_LINKSTAT_FDUPLEX, lstat);
 	linfo->speed = cgx_speed_mbps[FIELD_GET(RESP_LINKSTAT_SPEED, lstat)];
+	linfo->an = FIELD_GET(RESP_LINKSTAT_AN, lstat);
 	linfo->fec = FIELD_GET(RESP_LINKSTAT_FEC, lstat);
 	linfo->lmac_type_id = cgx_get_lmac_type(cgx, lmac_id);
-	lmac_string = cgx_lmactype_string[linfo->lmac_type_id];
-	strncpy(linfo->lmac_type, lmac_string, LMACTYPE_STR_LEN - 1);
+
+	if (linfo->lmac_type_id >= LMAC_MODE_MAX) {
+		dev_err(&cgx->pdev->dev, "Unknown lmac_type_id %d reported by firmware on cgx port%d:%d",
+			linfo->lmac_type_id, cgx->cgx_id, lmac_id);
+		strncpy(linfo->lmac_type, "Unknown", LMACTYPE_STR_LEN - 1);
+		return;
+	}
+
+	strncpy(linfo->lmac_type, cgx_lmactype_string[linfo->lmac_type_id],
+		LMACTYPE_STR_LEN - 1);
 }
 
 /* Hardware event handlers */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index ccd58d378fe48..dba8825ff3ade 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -369,6 +369,7 @@ struct cgx_link_user_info {
 	uint64_t full_duplex:1;
 	uint64_t lmac_type_id:4;
 	uint64_t speed:20; /* speed in Mbps */
+	uint64_t an:1;		/* AN supported or not */
 	uint64_t fec:2;	 /* FEC type if enabled else 0 */
 #define LMACTYPE_STR_LEN 16
 	char lmac_type[LMACTYPE_STR_LEN];
-- 
2.53.0

