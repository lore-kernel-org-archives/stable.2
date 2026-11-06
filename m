Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793933932;
	b=KZI/tyKlZMs7w2LwHmFn1QpfYMVwakPbd7qpAEHUxg1z2HOh+epo2JheaxF35lvR8zLA
	 9wnSqX8Ey3K4oJD4JJSo/AlKGva+hO0R1Iejb6EPjEXTic61nOQE5sR03e45mWtzguQAL
	 P5cPX0ZU7uAl+6Km3mygzKz6dWZISj7pw7v7/z9ZH018eY/SEop907z3YhHzg7RnCXovt
	 2XO79zflu3guV7j5NZLwB6T/e3P3F/LcpsPIisU5pXG6greOV8NcxvK8gSZNwRocWD57F
	 vEtGCfHy/iWlzxjpqU4O5Q7FhTDkfcZRFGpdi1ARTtQuGa/pO3yK76WPPc5L917ssLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793933932;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NZdW0NiXClk9PgZ61P2TZ39TOtpvtagpxUqP5u6oOw0=;
	b=n1KcUfAS2G4qkx/YC2wX62u/cvWJTD39XP04cv0U/g44WX+aifWYMQp2nR672vxEiNm9
	 XSq0MErVqEnTWmk7CkTFfTF1VudiPXBXoL2LRDJf8Xr91/CtxNd/NTR3drPOF+h7K03Vo
	 9W6XLnZpdBPGqRs2RFnyWYt2P5AfrihtGqrvUoQpoGnT1V3bc9TYKRQvFq1TPuymZAMPA
	 6sGCkKGR3sa55gjud7rHdrR0YYtwsW5Vx+P0tc9l/Umq6d6YJiDedkSUhro4ToYrbgg1O
	 9EdtGofq/2ocxKkxzgTNgoowDE3ZH4sQ4iEbQLcom4ghUL8m6Kr+GhkwGpmH7Nnk9SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UuXWHnPF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B90606A31B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UuXWHnPF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFED1F0089F;
	Fri,  6 Nov 2026 02:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793933931;
	bh=NZdW0NiXClk9PgZ61P2TZ39TOtpvtagpxUqP5u6oOw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UuXWHnPFMWFPmIASZREdY8OJqIwxQcQFvA4gKv3xKtN3dhigx2qeBp6qrwAgXF7Bi
	 6LjMcyfqKkXLQmkl0jMWD91AEfZg1tnkLwepMA9lmCGDT6OJI4ZS4VsgFuPrsbMiJI
	 DIb6T0Pdoh8bHzDTHORe6jKgBaHs4sO7PdtUz37W4kipLv1iy7d+aAsX46xT8DwPbT
	 eIHVJAN42XzYMwcsZ3puZqrFrhL//T9tTVLqz/hbf6c/AjLm3V9l1emWLP9dWZATZk
	 wH4sA8C8KjroQQICbKbfSpQHh8nPOJ/IefsRdJuKKfC/WMfSXTQVRZbdeE7HkbaYAA
	 yes7zgZXkOwiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>,
	Benjamin Coddington <bcodding@hammerspace.com>,
	Anna Schumaker <anna.schumaker@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] NFSv4/pnfs: bound the CB_NOTIFY_DEVICEID array count before allocating
Date: Thu,  5 Nov 2026 21:58:49 -0500
Message-ID: <20261106025803.3937857-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110459-venomous-panoramic-8040@gregkh>
References: <2026110459-venomous-panoramic-8040@gregkh>
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

From: Benjamin Coddington <ben.coddington@hammerspace.com>

[ Upstream commit 32f0967ea296d447925465c98e7eec71d4e2f755 ]

decode_devicenotify_args() hands the server's notification count
straight to kmalloc_objs() as the array length, without checking it
against the message that carried it.  Bound it the way nfs4xdr.c bounds
an attribute length, against xdr_stream_remaining().

Fixes: 1be5683b03a7 ("pnfs: CB_NOTIFY_DEVICEID")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Signed-off-by: Anna Schumaker <anna.schumaker@hammerspace.com>
[ sashal: adjusted allocation context for kmalloc_array() instead of kmalloc_objs() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/callback_xdr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index d9e9dc3612af7..8d7b0f42afee1 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -272,6 +272,13 @@ __be32 decode_devicenotify_args(struct svc_rqst *rqstp,
 	if (n == 0)
 		goto out;
 
+	/* sanity check the count against the remaining stream */
+	if (n > xdr_stream_remaining(xdr) /
+		((4 * sizeof(uint32_t)) + NFS4_DEVICEID4_SIZE)) {
+		status = htonl(NFS4ERR_BADXDR);
+		goto out;
+	}
+
 	args->devs = kmalloc_array(n, sizeof(*args->devs), GFP_KERNEL);
 	if (!args->devs) {
 		status = htonl(NFS4ERR_DELAY);
-- 
2.53.0

