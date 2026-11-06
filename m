Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972844;
	b=il185FT2BX0G9Nb05AfmMKB1hMxDrOAr80Bek/QHRUbj+ebRpnaZf61rI1CZufXHZJKS
	 U7xkbdnZR65DdUM03S8MoEVYwAoqGDbity882xqdjMMM8uyWVy3xBRZja0jYsMAeQuXH4
	 TTJt/fLiK+bwBBdZWgKXqfZpIxHzv1REzbQHNamIUY9i2gs+JF1I8wvPJDND1E1TUTFLK
	 PXyywEers0Tf4hQC8+5kTGCOaTywDFT+AzjhsLqrlbreezyDPN8LoXNyehlmmt3I7SDLC
	 RgXjiHZW/hXHSWE51zID42yrUXJvcLwxL9lpR1AaB8ioab4Z7hutAjyH9Ffq12scdRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972844;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AQXta7caG2t5JEi+vLGtdpb0UwRr2wKnn3UDCjsVPks=;
	b=RkOGgv224NKUajpPPS/T8xwafKgXn4m14resdg4xFtJ2427t5fhBeYmGDyWrObte/ukn
	 BONM+BV6oTyx1DxF7Py7uT6pZ17s4kuzbuzqc8Au4yxQt5lKKf79MVMU8VYQQtq6Ia7aG
	 riwnrfe0bqHQ4ND++pYwxXhoJBWlUOdg0eqoVDYuYHqI3cjWYxeoz8Y0XEYXggb7pJlni
	 BNWnPPGj+Yef1XswdERxsLeaAqOYAzIs3QXyHlDN46KWaJLx7f+NNUyQWVhJadlijYPjk
	 G6OSYtUz3wE2CgtOOgFnKKnvo0Rh7JMUzk2EEJCEhcYyliXfXYYrwTRJ11isWYFjtnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QKuKhEGB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A32606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QKuKhEGB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F861F0089F;
	Fri,  6 Nov 2026 13:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793972843;
	bh=AQXta7caG2t5JEi+vLGtdpb0UwRr2wKnn3UDCjsVPks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QKuKhEGBaaRhOZ9Exi2VWDEsGZ2uCKWxL1McWEupPTGFO5iPBD9ntGoIX8lkfvDtM
	 AVUhFoHonxBxcJfiRxHXv2OSPYYy1Kux2VXp9aKVkkbuHieGWOuSPj/0Msqa8XXN3h
	 6mgHZKzP9JmFLiLjMBgDqD2nsy/3f/RNjVo2DY1RyRjc4UlNnMFl3HybQN9HR2/ZnC
	 gZd8ie+cWtx/qomhhle9dPEllyZMd2QmE0PUj9txqKbPnCFU+tuC158wAdXZSFT/Jx
	 Mp0omlC73yDKwJ9Kqo7D0wHfKMU38neB/yUataXXiSZBvQiUG51qVOKBGZnLO87cMA
	 HrRRWWIQdjksA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>,
	Benjamin Coddington <bcodding@hammerspace.com>,
	Anna Schumaker <anna.schumaker@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] NFSv4/pnfs: bound the CB_NOTIFY_DEVICEID array count before allocating
Date: Fri,  6 Nov 2026 08:47:21 -0500
Message-ID: <20261106134703.14265-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110400-luminance-syndrome-19a6@gregkh>
References: <2026110400-luminance-syndrome-19a6@gregkh>
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
[ sashal: adjusted allocation context to use kmalloc_array() instead of kmalloc_objs() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/callback_xdr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 505d195ed61dd..ff73aee4f72f1 100644
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

