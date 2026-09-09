Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A906519CD0A
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788914196; cv=none; b=IbgQ2EW3YJ1wB/KZzVALyxtlFru9NIjGZa40ChMaB7jgK2JRZWBCdkVbd3cKGBQtSz+x8D+fSrZtZxzLhLibwUKDVWLM1nNl+aSNQQDHCvWdy2HG9WnwYLCeeExn1DaZEmw/wGN0Wo7EVdmQJVoI47DDUaco4twFTpTRZhkmrPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788914196; c=relaxed/simple;
	bh=Syg+CkMMsf6Tz8TxdNiMh29oG3aluAyKzWM/yJLyV0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVgeuYun1fUbPkRKO3GsY3RIZp4CDkQ+fh4fFSvhHcg5zNJeIbxc+drZZLpen/CJlnOdTrmV8bHWoJPT5DTiGKjBHZgWfv6Jlcij4lUgC+i+312wzOVqYv9Tijpa4pw89NWc4t31BEbosnW5fuTrkZWC4v7FX0CED2TrfaeR1yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKWaUBoj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKWaUBoj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F101F00A3D;
	Wed,  9 Sep 2026 00:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788914195;
	bh=APV2antKuNGiOYuma6AOp1bjwnQYq6+Ya7vVVehtob8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EKWaUBojmr0j1vwGmzV5n4/g1Z0Djm886KWB1TwFJXnS17eEigGfwuG37PFfCkx4J
	 kL5qlAOcisiY2AHGfN04Q0IBN5+laEQ35kVYU518yFXJV7HWOF4yAgERflsLSmumY0
	 V29/JFBDTbcNrjAJ0BfghVgucZhaBtZKfdEvSgnh8PrWM5CetMShZsMFDhUZK1zKht
	 pPViSfoKl/ffrCs4qZnPwy9q2Wl8Ef+qNNfQmqIt0N52VNOJfCXmU4UkrSVEBBbyFO
	 kwGXQiDdeOB1+W5G1hcZHB43snzp4AzNr6L4/AFpnpnsfmEgnQBSRxnWdm/CgSfHsK
	 zWkLQiAuHAMpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] sunrpc: Add a helper to derive maxpages from sv_max_mesg
Date: Tue,  8 Sep 2026 20:36:31 -0400
Message-ID: <20260909003633.747471-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090342-canary-synopses-a220@gregkh>
References: <2026090342-canary-synopses-a220@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit eff042ddf4b9587fa7394d502b93e06ec6015177 ]

This page count is to be used to allocate various arrays of pages
and bio_vecs, replacing the fixed RPCSVC_MAXPAGES value.

The documenting comment is somewhat stale -- of course NFSv4
COMPOUND procedures may have multiple payloads.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 9808eb765666 ("svcrdma: Reject Write/Reply chunks with segcount 0")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/svc.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 617ebfff2f304..2285fd735eacc 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -163,6 +163,23 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
 #define RPCSVC_MAXPAGES		((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE \
 				+ 2 + 1)
 
+/**
+ * svc_serv_maxpages - maximum count of pages needed for one RPC message
+ * @serv: RPC service context
+ *
+ * Returns a count of pages or vectors that can hold the maximum
+ * size RPC message for @serv.
+ *
+ * Each request/reply pair can have at most one "payload", plus two
+ * pages, one for the request, and one for the reply.
+ * nfsd_splice_actor() might need an extra page when a READ payload
+ * is not page-aligned.
+ */
+static inline unsigned long svc_serv_maxpages(const struct svc_serv *serv)
+{
+	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1;
+}
+
 /*
  * The context of a single thread, including the request currently being
  * processed.
-- 
2.53.0

