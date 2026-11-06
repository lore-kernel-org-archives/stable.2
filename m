Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793932187;
	b=2dstAavyDXMxkM0i9+8HzODw3clcmOLZaL/EwI7C4PY8pucIdS2aPDZqgXjo3dBfg+0D
	 heNY5ICgWaAJGjKyv6QLiaCMGo5kQD7nI7EOZlywwJZHX3Qf2mOH2P7l9O6O1p1xqhzHz
	 8rnayrUrTKh/uJBjkGA/kyhLhI2uLwdcy65q05zkX1o7YX5Lmu2+gh+P0IYjwmZR+CEdz
	 eVUsEskwBsS8CaeTo4aVzslGZ8gJEkyGpqIK+xD1Jug7C/mzUo7eQOHJQVzEQaxehV+QP
	 o1I0HNeZN7S9qOBL04ixUujZHsmbeYSpH1Ei8oXYGaR1WyqZg5TGgS/TTXoQUTWmzUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793932187;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wvrQBoqgZFThbL4TLdHkhLS7fsz01PH61NErtG2+PQI=;
	b=yXCxsvMxZt+OyNFUMn0rudqKKsqYSbqEiutWj43MZDl1zbjHfT/ahuUZGdFc9ZNY0qDj
	 3PK+bN0kT62B+BoCBXKLWDm++N1op9oORNYTHNCoQgMRaQI4SOMXRvNblC8NcN4BtSvfq
	 nk7JOa5bz149NbSSlUX8yMmj7d4n5KbHptvhakbmi+my+ma6n2xToO+ioSWh5bdaM12mR
	 s0fK+TXUvK+gmIpKl8n4fNCRpnQAQlUSC/RhkKIIdUgN/dYig8QgkNWLPxnjLfHC1xbJ/
	 EIt0hPcJ9KoQj+YCINOLzIk+devaJiLxB3gSaDkw+fnPTiRV6wT9hyzuEy+7CMISIug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jt2Ar2ef;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE867606A31B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jt2Ar2ef
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF421F008A5;
	Fri,  6 Nov 2026 02:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793932186;
	bh=wvrQBoqgZFThbL4TLdHkhLS7fsz01PH61NErtG2+PQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jt2Ar2efaO19W6ADtIwTqMaS8OK984h/ZrJU4Yyh0YvdnKjN6OeCiaIi5h839FEep
	 udiJelKOKRDGvVUJLppJ/rWo1np5TjwJ1od4yJUtVYgKSBhDgzcJQrPS+Cf2v3Kz6q
	 omP1E+VAgaFSejVNOojPOguwXZbWoPDq2L6NelGKVPOxzK2VchfM8d7d4pbxGbbpDU
	 gn3iBhEwkQjAZu2PgXlEq1mzGnnqpVCivoN7dkyKo450VhSjaLt8BRdRnMwDQ/lxim
	 YV52uVqy1Tt0/MfzA6sWS4UVZkIXkZStQm6dMMVRZX88SwVG1eFl0K1dob0byUNnIX
	 BNRAILidI8wqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>,
	Benjamin Coddington <bcodding@hammerspace.com>,
	Anna Schumaker <anna.schumaker@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] NFSv4/pnfs: bound the CB_NOTIFY_DEVICEID array count before allocating
Date: Thu,  5 Nov 2026 21:29:44 -0500
Message-ID: <20261106022849.3724035-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110459-utility-dropkick-7942@gregkh>
References: <2026110459-utility-dropkick-7942@gregkh>
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
[ sashal: adjusted context for kmalloc_array() instead of kmalloc_objs() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/callback_xdr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 9e6176ae9ca54..9e78f73474224 100644
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

