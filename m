Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBC8341650
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980980; cv=none; b=cMr9DOJJ3NQ6IqxYOnpphb+9IVmRBjN7Dq38FWtu/imUKYWDaqab2+mKy2IzLV6sT3Gl+tCxCaTyg4JqQunQqJmv6DU3KsdSFpWymZxhySiOv+5DmOUl6ibbcowZzi0DEGDi2dIPlf7qKWrRx5JBwoNX3r9bT7i0+M7hHMJHqCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980980; c=relaxed/simple;
	bh=DMK2kIcsV2n2cqoqoIEA0y0boyZF282Xc4bwpj51ias=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uuxyw9yVc4RFaxQ0Q//upn/eaM8mDM/0MTWKlYnWwz6HIjmjcLo6x6y6g748PUdQUwU2zhszk1TJ2RwzP5AasZpWToB4gEfXhOS9rcVcGdQzRQte19J+0Ue/pRDrTxcTHvys++uMCl+/st3jOW1h/TgKaYmDkLdE8Ia097+b5DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7rJB8er; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7rJB8er"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8903F1F000FF;
	Wed,  9 Sep 2026 19:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788980978;
	bh=hvniqrMG+jo5NM4deWEVtPQHZXlKyTwxqoUr5N4ySi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S7rJB8ers92MAGEweLpQVIXlKM33lSROxHB0ml+fmH+sfHo4YfpEOPLGvz4F6iTy8
	 10YTxBwY57KhVMplyqHWAe8GW4v6wxxkPRzKf2VGh5e+BX4CG/sqqAYvMovEjd5u6e
	 sxji6LN8/nVuO6VUNr4id0x2yxs82mTp2ZtJO7AYCC88L4FeV2Sm4NjIVLyEwCMQg9
	 dWyX1Vl2ciehV0c8BFy537FywPgrHf9kx87Q9bZPmsCij1Mx6m7KIaNVFG/dnmZqDf
	 +YZcycbAkiveMGLCRcLZrvXRCEyBnCHFrIcPH3Kt2oQapjeavpesy6ZUeStZPDXrek
	 PEdDdQ0QzWmEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Guangguan Wang <guangguan.wang@linux.alibaba.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] net/smc: Address spelling errors
Date: Wed,  9 Sep 2026 15:09:34 -0400
Message-ID: <20260909190935.3545815-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090313-litter-deputize-53d5@gregkh>
References: <2026090313-litter-deputize-53d5@gregkh>
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

Backport notes for 5.15:

The freed member is absent because this tree does not contain
61f434b0280ed ("net/smc: Resolve the race between link group access and
termination"). Add only its bitfield declaration, with the corrected
comment, so db51a8658c11 ("net/smc: stop killed, freed and out_of_sync
sharing a byte") applies unchanged. The field has no readers or writers
in this tree; socket allocation already zero-initializes the connection.
Do not import the newer connection lifetime or link group refcount code.

Keep the requester spelling correction in smc_clc.h. Drop the smc_core.c
and smc_core.h hunks because the virtually contiguous buffer modes and
SMC-R v2.1 negotiation definitions they annotate do not exist in 5.15.
No functions are added or changed.

[ sashal: Reduced backport -- upstream cd959bf7c3bba touches 4 file(s), this
  backport carries 2. Not backported here:
  net/smc/smc_core.c
  net/smc/smc_core.h
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: db51a8658c11 ("net/smc: stop killed, freed and out_of_sync sharing a byte")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc.h     | 1 +
 net/smc/smc_clc.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index 6455371430a3c..1153dfaaca71d 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -217,6 +217,7 @@ struct smc_connection {
 						 */
 	u64			peer_token;	/* SMC-D token of peer */
 	u8			killed : 1;	/* abnormal termination */
+	u8			freed : 1;	/* normal termination */
 	u8			out_of_sync : 1; /* out of sync with peer */
 };
 
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 78a94b9122b64..e7346cd340d89 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -140,7 +140,7 @@ struct smc_clc_msg_proposal_prefix {	/* prefix part of clc proposal message*/
 } __aligned(4);
 
 struct smc_clc_msg_smcd {	/* SMC-D GID information */
-	struct smc_clc_smcd_gid_chid ism; /* ISM native GID+CHID of requestor */
+	struct smc_clc_smcd_gid_chid ism; /* ISM native GID+CHID of requester */
 	__be16 v2_ext_offset;	/* SMC Version 2 Extension Offset */
 	u8 reserved[28];
 };
-- 
2.53.0

