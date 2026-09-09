Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D71E37BE7E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975302; cv=none; b=BPSuxAfToJpVm1ypIYQAMaQKmJtAEsXh1FiMIofgOs5bBQZx4uLsDnpVF/WYQPkId+eF7JIBFTJ8HjqzoM8oUhIKcb3zb8nsKamOQgaN8C5/jg0XRbr3RjVzzd224laJ4PVA1FvB5aI/DU6igs9JgH//pmZOTvW9W+9tdOmQwf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975302; c=relaxed/simple;
	bh=y6NBjC1beVtB6aZJgyA4+Bn2q2jM+A3FXYh+n7gQNaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYbLrRh2nstxMA8tLmZVlUWAqurIufL3icHDLSRof5pWLpO/d7cOmukFGC/Tx2e9DElL/07yGUJBK0ndwGWrEj7pg6yKdwIDsXtUz4iUFtnXfvW8dRVEvUZmUwO7LmN1INDkLq0x1ZUQv1lxgU4HkGeSTAXoyYGkBttVzKuXe64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqeSQCnN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqeSQCnN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8308A1F000FF;
	Wed,  9 Sep 2026 17:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788975301;
	bh=Rk3hS8txQwUXEP0swj55c1NnGXpXpwK5DQyABt+vZok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IqeSQCnNbI+0NF+mWzblP3/sc3G9K9TNaTYRxIaiCo4n8ZavORCa31tMEwg+Rs4Mn
	 ojjk9LvzoRgF+3oo9k1ugXuyer2VM/uV8I8sdJChD9t6NdW2LkC3n3VAwiuWzhLBSq
	 Wual6+nxQhxokzwSkEwZ7yzX6NicpPHCqrDWKpoHCK/cKSI5+Dfi2yIWRECqmZr0yM
	 rnnALku1wcTCfYgOw+yYFk1uGif9nmP6zTkHH5JWXlas5ywJANw4SMNV6fzNH4e7yO
	 4Em3Xvq/tZR96ukHbMvkeciNitdPsZFX6uYrkYL/jtGQ0zRxlPfYMsHD6zsPVAmT6z
	 buswKk9ggln3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Guangguan Wang <guangguan.wang@linux.alibaba.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] net/smc: Address spelling errors
Date: Wed,  9 Sep 2026 13:34:58 -0400
Message-ID: <20260909173459.3308094-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090312-cedar-failing-0a11@gregkh>
References: <2026090312-cedar-failing-0a11@gregkh>
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
index 49bf6971610df..366cd1a0b950e 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -239,7 +239,7 @@ struct smc_connection {
 						 */
 	u64			peer_token;	/* SMC-D token of peer */
 	u8			killed : 1;	/* abnormal termination */
-	u8			freed : 1;	/* normal termiation */
+	u8			freed : 1;	/* normal termination */
 	u8			out_of_sync : 1; /* out of sync with peer */
 };
 
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 6e24d44de4a7b..fc31eeb586b80 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -150,7 +150,7 @@ struct smc_clc_msg_proposal_prefix {	/* prefix part of clc proposal message*/
 } __aligned(4);
 
 struct smc_clc_msg_smcd {	/* SMC-D GID information */
-	struct smc_clc_smcd_gid_chid ism; /* ISM native GID+CHID of requestor */
+	struct smc_clc_smcd_gid_chid ism; /* ISM native GID+CHID of requester */
 	__be16 v2_ext_offset;	/* SMC Version 2 Extension Offset */
 	u8 vendor_oui[3];	/* vendor organizationally unique identifier */
 	u8 vendor_exp_options[5];
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index d325dbd012254..1e2a526a9f3d1 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -2272,7 +2272,7 @@ static struct smc_buf_desc *smcr_new_buf_create(struct smc_link_group *lgr,
 		}
 		if (lgr->buf_type == SMCR_PHYS_CONT_BUFS)
 			goto out;
-		fallthrough;	// try virtually continguous buf
+		fallthrough;	// try virtually contiguous buf
 	case SMCR_VIRT_CONT_BUFS:
 		buf_desc->order = get_order(bufsize);
 		buf_desc->cpu_addr = vzalloc(PAGE_SIZE << buf_desc->order);
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index de001f4b46c7d..3694949b243db 100644
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

