Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793933964;
	b=mtWdwAk5L52QK9jQlsQA9otEXNmvdlj+XGph8FB1JjSCoVH3Hfy0dNROG/RcxY7ZqssE
	 2I5Z6Wkv10CZdeaurgNLnSYhmkCeRTAmel+V29HHj0s+2T54S3Wq9XzJHlX/nxUBQKz4N
	 3a+dk/Zx4SN5m4iuEX9iSZJFobhgnityXz1H14qZL+SXDEf8rMLazSikLD8I/shSGrkXA
	 e4q1bbRNDoaqN4xMxtgs8JNRxHkGgWlrubcoixM8jhLngwB/RFHjgyzYUXGTEce1YR8N/
	 PzzDDR1Vvh9285SjWzUDzYWkIRmnaawy7M3PAXdGUMbayajCwvjhQz6CjLdtCYReyIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793933964;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=T/PT/5w8cqZUZRBh79gynJeQwQtWyQcp5gjxbZ7UqI4=;
	b=j44pF1u7SAC+Kq5qrrEj7z1QgJCklL+sVbLruaGZsc2sx1QlKipPvzAnmgXh1idsRtbF
	 8+3A+vjk1i63HMitZKKTJmmbSCW85lKvz3j8j+Bj9aXTpfMtWBEXBF2G0uVdWyQRJ0Oo1
	 PgV89menoYk2MoF7DFaP6qb+B7B4BVRDzwWmbRL5c1ysratkdBinrZXj8DdLPsNRQNi7Q
	 y+yjKPmc4R9vsfPF+drqIclgbrOwNlbNa/ptmbZ7tVbIRBbstNX/pu24SHjD2+EB/yiOj
	 Q9cDB+BXQv1JqGl9NsPybsA3680/qt017xQw6YvCsxm1SEskdAzELrf+DFRgrb/2yfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hgW33AEZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24485606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hgW33AEZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E571F008BD;
	Fri,  6 Nov 2026 02:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793933963;
	bh=T/PT/5w8cqZUZRBh79gynJeQwQtWyQcp5gjxbZ7UqI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hgW33AEZnvS5qqqCMhDh3AUAIpPbedy9y9epB2eY8jlf2TgE1EauBbIvErE9l9t7F
	 ghe9n760NALfTz+SjLP+eLZspQ1MxKMy4JJDo7hPXKdhTFZApudqiflhKVgQRlQAvV
	 6lIkBaymC8Yrjvv3Pm1erV/mZg4kVgChp1dohgwrPNLgZadW4OtaHrMY25TWhz+I1t
	 ROmvpYeyWdBZ/GoBa2OaXkXTBXhXQpuc0E8ad4hE+zUxUOcU2JbJcqPK8hKmsD1iYk
	 sY1pBN9GAuoweOXvvLh23z301N7E3C6T8zSNjO/vWoqzBvr4zzbBrtAIkcyOjw+5GP
	 WtlQoOLKyp3NA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Benji Wiebe <itsme@benjiwiebe.com>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] nfsd: don't offer flexfiles layouts when NFSv3 isn't being served
Date: Thu,  5 Nov 2026 21:59:22 -0500
Message-ID: <20261106025802.3723414-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110410-embellish-phonebook-a972@gregkh>
References: <2026110410-embellish-phonebook-a972@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 5d28b2c920d9d9d3c45b41769342ad785eb372a7 ]

The flexfiles layout driver hands out a deviceinfo that names this server
as an NFSv3 DS (flexfilelayout.c hardcodes da->version = 3). With v3
disabled, the client can't talk to the DS: it loops on v3 NULL calls that
the server answers with PROG_MISMATCH, and I/O hangs in D state.

Skip LAYOUT_FLEX_FILES in nfsd4_setup_layout_type() unless v3 is enabled.

Reported-by: Benji Wiebe <itsme@benjiwiebe.com>
Closes: https://lore.kernel.org/linux-nfs/c734eeb8-8486-4491-bb4d-b9656cbaffbe@app.fastmail.com/
Fixes: 9b9960a0ca47 ("nfsd: Add a super simple flex file server")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260904-pnfs-ff-v1-1-5f502cf25401@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
[ sashal: adapted the flexfiles condition to the older layout-selection code that uses direct block/SCSI checks ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4layouts.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 0ff8994752637..a78e0bfdc9363 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -125,6 +125,7 @@ nfsd4_set_deviceid(struct nfsd4_deviceid *id, const struct svc_fh *fhp,
 
 void nfsd4_setup_layout_type(struct svc_export *exp)
 {
+	struct nfsd_net *nn = net_generic(exp->cd->net, nfsd_net_id);
 #if defined(CONFIG_NFSD_BLOCKLAYOUT) || defined(CONFIG_NFSD_SCSILAYOUT)
 	struct super_block *sb = exp->ex_path.mnt->mnt_sb;
 #endif
@@ -132,9 +133,9 @@ void nfsd4_setup_layout_type(struct svc_export *exp)
 	if (!(exp->ex_flags & NFSEXP_PNFS))
 		return;
 
-#ifdef CONFIG_NFSD_FLEXFILELAYOUT
-	exp->ex_layout_types |= 1 << LAYOUT_FLEX_FILES;
-#endif
+	if (IS_ENABLED(CONFIG_NFSD_FLEXFILELAYOUT) &&
+	    nfsd_vers(nn, 3, NFSD_TEST))
+		exp->ex_layout_types |= 1 << LAYOUT_FLEX_FILES;
 #ifdef CONFIG_NFSD_BLOCKLAYOUT
 	if (sb->s_export_op->get_uuid &&
 	    sb->s_export_op->map_blocks &&
-- 
2.53.0

