Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793926171;
	b=n2OGhcp9QG2JVFI/e0r2caKEOxUMQJPg8TT129xcY6cPJDwE1US0jWUTnPaCHZWtSxr2
	 iA91RCPrT3m0Iiwjon7bgkH++O2SQyRhEkKPBF2rjtNke87B+LQmtcICp77bjKwnq1TyD
	 /GGMklCF1xUdqwQE3PnYxQ7qDgBtKbUn4ida3ebFjqIcJbhfaY69fwwwnvC7eBpkqAuGG
	 GBCxnNYKr3BeuZ678bE04r3iuNfBJRDfAJA7fRyDpPu1u8/J5V85pHs3rUTQnRUXsjoWP
	 X/MG0ERmf9wEro2L1B56hhkp3vALp8LSTNadmEpy07CQnoMC0UNBb/IHWHaHGuJNiMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926171;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pDVcgir2pjk3qs2ckCIMT0A3bGhbKkL3WwfN7rJLn+Q=;
	b=oKDLRts/iV67thkm3gCv+oQf1PVupgWkLSsJJI+6UFgXhV9iOFtHsQEpPX1qDQDT+h7R
	 CyfXGHin6p2l4sgoq1f0F1QNj4K44TPUUbIFxvxqEVRPMUS76uklV6rWYLqlqWnXELCyg
	 jCjHNXMnT8foCqgQYGcb3Vfo+p2mwBe+4zwDDqrsfrMoHFF8bSeYs3IlhbqrO2W8nBkU0
	 nXWr7DTP0d45LVC4xQ6zwCavnvLXgo9T+1FrNFB6vU+29elIaQpLBe1ghHexAMo0PiMj8
	 S505Fb8mzJPNhlRptgRXyjeHh7ln1t7mBcO9y1XcchqxLpHN+gITXJvgyJ1CTidpXMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nzxwVSvJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8288606A31B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 00:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nzxwVSvJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48B31F0089F;
	Fri,  6 Nov 2026 00:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793926170;
	bh=pDVcgir2pjk3qs2ckCIMT0A3bGhbKkL3WwfN7rJLn+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nzxwVSvJ/Nl3t+bEGs90BTxybkW++aonQJlvOdnxFAVUr/f7729bzXDe8RxluFCKQ
	 FOvP4yOGmXHEtEmi61HEwPQ3/TmOtvYooGeZRy5W1xy4OplQLGxIxFlHEck4vUSulj
	 OxnPbLhfKoL8AHdJr42k3A7Eca0fcVfN9oz7i5evUAIHdvaWJ1mMwauCIB2CbXG48N
	 Ud+9104X+A7wbUs8Xx+/FrxWsDIh9OCIdwrgYbG2Ga/Lsrg2pi1czkaYRuAI4KG1IR
	 Iw4GSHJ2QuD7Qsgf0i6DU3sO3WbUr/n5n6z05bhNUjhSF973odvwI3A8ntXEKgRdGa
	 Pk2b+1tMRG/eg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>,
	Benjamin Coddington <bcodding@hammerspace.com>,
	Anna Schumaker <anna.schumaker@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] NFSv4/pnfs: bound the CB_NOTIFY_DEVICEID array count before allocating
Date: Thu,  5 Nov 2026 19:49:28 -0500
Message-ID: <20261106004445.3298203-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110458-pelt-tragedy-4542@gregkh>
References: <2026110458-pelt-tragedy-4542@gregkh>
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
[ sashal: Adjusted context to retain the existing kmalloc_array() allocation instead of kmalloc_objs(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/callback_xdr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 1aa6a6e14b057..34fa00f1a1c20 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -275,6 +275,13 @@ __be32 decode_devicenotify_args(struct svc_rqst *rqstp,
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

