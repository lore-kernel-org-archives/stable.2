Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11A327FD49
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 03:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788578905; cv=none; b=JYHJh1VHW3iK4gXOeUrGPZHG9YDkeJE43Xb072j+4eF+rS6CqwAoe+XUSiT13s57b182LULyZIkc5WxKk31kl4lnQfy++FxUubdEj6fa8q5xjZUm8F0iyaT7vToqoV9QQlKyPa+UDlLX8YWlaTdAO5KBea81+Usy2NUG7JkqAS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788578905; c=relaxed/simple;
	bh=VEbdiPsHHZ/AZFfV2XYS+dPDVELF7joKO7Il5HGkOXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/dKQBVCKpj0KoB+/YXZScTTcK8h5lLvJMPJqnQoFxLMB3bBgK8o+c5ihGJ6GijcuLTcdFMTO0ss7rYBScazfiGKnVX9vWBqfxbfIqcUW22qitz+niLTSaNWaiMGpwVP5lOjyZioi3MEv3M0SE09u7MgDunoprJu8O2F4m9l3f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eob+Pq/B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eob+Pq/B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E66B1F00AC4;
	Sat,  5 Sep 2026 03:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788578904;
	bh=WMmQ+UJvsMLzxYxFlUXLByFNm62tPPeRyI0m93L83vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eob+Pq/BR7XvQvY9CDBQ4CfEkmwMJctEZKIfdLJNCv5dRXQ0TkwM7R51C4Z8cH1Xb
	 FFMM08e2mGsbePtuwykZ08bThO7ljZzZA0eIAcx/lOCN6YS+7qVv2PBxp4mSxUTst3
	 hrfOtfMi8Ywi0ucBQCnnZXQKdJyJc0EKI7M8e4RMAn8nCuBCcaAYPY7i38saqw5fWs
	 JDTUMqJ4YJSlxt81e/Iz8wiWzyUr1Ta2rSk/0WF1gvmSHwaXjHyqlL/6n0GBpG3aa9
	 J+HMesb4xy5ueI+LeiCPAcyXotbEoHNOtv0W/w9gnwc828uBOJOlAGcMipqkaN+v5e
	 1L+NYwm6qJxrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] NFSD: Make nfsd_genl_rqstp::rq_ops array best-effort
Date: Fri,  4 Sep 2026 23:28:18 -0400
Message-ID: <20260905032820.1914550-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905032820.1914550-1-sashal@kernel.org>
References: <2026090358-starry-expulsion-6b91@gregkh>
 <20260905032820.1914550-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit a2d61427fb4b630b94ed9bd457dd8bc239b83e4b ]

To enable NFSD to handle NFSv4 COMPOUNDs of unrestricted size,
resize the array in struct nfsd_genl_rqstp so it saves only up to
16 operations per COMPOUND.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: a99d720ed2a5 ("nfsd: widen nfsd_genl_rqstp address fields to sockaddr_storage")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfsctl.c | 3 ++-
 fs/nfsd/nfsd.h   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 9a3c0011b6674..87c27ad447b75 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1627,7 +1627,8 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 				int j;
 
 				args = rqstp->rq_argp;
-				genl_rqstp.rq_opcnt = args->opcnt;
+				genl_rqstp.rq_opcnt = min_t(u32, args->opcnt,
+							    ARRAY_SIZE(genl_rqstp.rq_opnum));
 				for (j = 0; j < genl_rqstp.rq_opcnt; j++)
 					genl_rqstp.rq_opnum[j] =
 						args->ops[j].opnum;
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index ad0af259e98f8..fea716bbebf1c 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -82,7 +82,7 @@ struct nfsd_genl_rqstp {
 
 	/* NFSv4 compound */
 	u32			rq_opcnt;
-	u32			rq_opnum[NFSD_MAX_OPS_PER_COMPOUND];
+	u32			rq_opnum[16];
 };
 
 extern struct svc_program	nfsd_programs[];
-- 
2.53.0

