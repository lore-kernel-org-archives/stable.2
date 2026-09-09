Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9C83876A1
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975148; cv=none; b=KhIghyuawQDda4O1JJjnfhCokDWyHnkHKM4oz0Nedlep76KHHStgSRM8FSf5FF6eJYnWAmt9UoJ05sSLQWthalZ8zHIssbkhSDmrRFS5qp6LI1gEhJ520+mDc58z7Zws/N0Zt/SeNwpYeVLstV2DfomrkZTT5BoniovDP6k9qWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975148; c=relaxed/simple;
	bh=8RR3Fu/SrH0/pAY/h+lW46O1BZ7UtFxxBYe6q93YJ5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzNDLEEUUL1/naWX9y5WPkl6c/voK5/50x5gp9CI+FyQ6Ja4u67ypWrOvs+I+8i6yAVAunrBt7ZaAXBv94L1KG1XU2RS4mbdaewtQTnFDwlliz2onNRDx0QUMMeWE/ezxLWVjLHYqrERHQhTpGaF7n4MJaXlifYUO5kGi7Z6EFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boUN5OhO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boUN5OhO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1F81F000FF;
	Wed,  9 Sep 2026 17:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788975146;
	bh=qApzbysI2urjpRwYl01AgE91jNDxnOBw2Yl6fOuMdcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=boUN5OhOjZHWWQz0iY9UbGpz1rbSR0/sNdBUXmftwFXehn+HjlS1SC/lmjyTu5WYe
	 BmDS7igurO9lFF+ussGqgkigeIDHNNmbmFUNbEH4k2MKI5LVXCpbWQYTB7ge8G3/NP
	 DlzfjEJZSPXOZhS2gkneBUZUnwuCmiskxGBl0sf3kSi0wLqAD/7CONFiS72CXJOZIq
	 tuJaAow+TtRyYQbSQyeRg8usU6QflO4MSMcLvDDMkqRo5NLWJwfN4c+q0lbTvU4vzx
	 3erRohXYH3BRZQBRbZtjW9tRtYSpcpVeU9lGaRGT4SVBBv0CdkTgU3o72dqMezGs/F
	 TJH6e7FsR3tqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Guangguan Wang <guangguan.wang@linux.alibaba.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] net/smc: Address spelling errors
Date: Wed,  9 Sep 2026 13:32:23 -0400
Message-ID: <20260909173224.3297067-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090312-corporal-discover-f40c@gregkh>
References: <2026090312-corporal-discover-f40c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Simon Horman <horms@kernel.org>

[ Upstream commit cd959bf7c3bbaf64a29750c5e36776078a18a8fe ]

Address spelling errors flagged by codespell.

This patch is intended to cover all files under drivers/smc

Signed-off-by: Simon Horman <horms@kernel.org>
Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
Reviewed-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Link: https://patch.msgid.link/20241009-smc-starspell-v1-1-b8b395bbaf82@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: db51a8658c11 ("net/smc: stop killed, freed and out_of_sync sharing a byte")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc.h      | 2 +-
 net/smc/smc_clc.h  | 2 +-
 net/smc/smc_core.c | 2 +-
 net/smc/smc_core.h | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index f9d364a2167a7..ea45467c11409 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -278,7 +278,7 @@ struct smc_connection {
 						 */
 	u64			peer_token;	/* SMC-D token of peer */
 	u8			killed : 1;	/* abnormal termination */
-	u8			freed : 1;	/* normal termiation */
+	u8			freed : 1;	/* normal termination */
 	u8			out_of_sync : 1; /* out of sync with peer */
 };
 
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 1a7676227f16c..7672899254108 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -156,7 +156,7 @@ struct smc_clc_msg_proposal_prefix {	/* prefix part of clc proposal message*/
 } __aligned(4);
 
 struct smc_clc_msg_smcd {	/* SMC-D GID information */
-	struct smc_clc_smcd_gid_chid ism; /* ISM native GID+CHID of requestor */
+	struct smc_clc_smcd_gid_chid ism; /* ISM native GID+CHID of requester */
 	__be16 v2_ext_offset;	/* SMC Version 2 Extension Offset */
 	u8 vendor_oui[3];	/* vendor organizationally unique identifier */
 	u8 vendor_exp_options[5];
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index ed0027ba66c75..652e6259b40b8 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -2324,7 +2324,7 @@ static struct smc_buf_desc *smcr_new_buf_create(struct smc_link_group *lgr,
 		}
 		if (lgr->buf_type == SMCR_PHYS_CONT_BUFS)
 			goto out;
-		fallthrough;	// try virtually continguous buf
+		fallthrough;	// try virtually contiguous buf
 	case SMCR_VIRT_CONT_BUFS:
 		buf_desc->order = get_order(bufsize);
 		buf_desc->cpu_addr = vzalloc(PAGE_SIZE << buf_desc->order);
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 0db4e5f79ac4e..69b54ecd65031 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -30,7 +30,7 @@
 					 */
 #define SMC_CONN_PER_LGR_PREFER	255	/* Preferred connections per link group used for
 					 * SMC-R v2.1 and later negotiation, vendors or
-					 * distrubutions may modify it to a value between
+					 * distributions may modify it to a value between
 					 * 16-255 as needed.
 					 */
 
@@ -181,7 +181,7 @@ struct smc_link {
 					 */
 #define SMC_LINKS_PER_LGR_MAX_PREFER	2	/* Preferred max links per link group used for
 						 * SMC-R v2.1 and later negotiation, vendors or
-						 * distrubutions may modify it to a value between
+						 * distributions may modify it to a value between
 						 * 1-2 as needed.
 						 */
 
-- 
2.53.0

