Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974679;
	b=SReph7YCCp7n152x03+5RLOxP8AsCsM9iCM81FnWC292piYdVKt7MgpV6k4kIAoSyaxl
	 gMdCqawhMDbw7c8F1y3IPbhSaXfWE7d/j55OG2OkWq7arJRgE5U3hjbSl0Rm03WlAudD3
	 8g0dWTeGtXRFg9HlOOh0LISj/vME2Y6WPjHk/r/6NHSWF6oSTKu4cCT128sRtO8T2ru3V
	 aWExXaCLqmuZ33U/GIFKCTMS9g/RANsKcimoqN/o5bjCYIR17myr/Poxzm1bpV6WpLAPa
	 4cGeTU8fxYwWmCskhPIYwPeMNW9aFMTGBQFAYFpWcIkXSEYfZPXzk6elbjbfavxrhOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974679;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VCh2ZaFuxfC+u/rbMqTxz5XBMsPuDvmJBVHq8w+GZe4=;
	b=45gw0ah7wrgO3SLdrlNNjzkiEzzvj/Ycyjh4r6ICQhBbnHOYmqr2FKvSmNEwqCyoMnDb
	 Zx9c9vUZ5AtUGyCQzZICjS048v5wtKnkrpbBxkZSLb2408URD27MVAacnVBoGs16aXW8c
	 7psvKYI1HGCY+Ul/WU6yeN8LAehdDrfoZr0ITZkboCR4uFSCsxSsEM/ZXByGJskLBrINI
	 Uyf4TidoImCtIiouWigh99kOHX9ilC1xAEh3PElenNv5cTL8+LDgmUFCffYk34JyWTd7g
	 qKtxe55DAJ4FAVHsNYpMPzBufNfWE1ZroR8KnKSbfbEK2oE+rlUuPsQRgBXzEwWfaFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJT67RRm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14532606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJT67RRm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305341F008A3;
	Fri,  6 Nov 2026 14:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793974678;
	bh=VCh2ZaFuxfC+u/rbMqTxz5XBMsPuDvmJBVHq8w+GZe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PJT67RRmERftfBIzbiT/GzLzvsAVAfycyO66SoB8HTdMDMiQtBS6JPBHke1MtmlbA
	 /H4KiUA0ADOXgJDe3kKZRf8AcB+H4OdopNntasgoN5eNM2Ma8wh3Iv5tIUzUSc6iBm
	 JJ/q1pp/Xas6Wfi3X+V7eUDuTXdBLUK7YGPJjJ+/iuFNg2ImQQvXJYC4jLMeKU0Utg
	 t66JcK5I6v3sKoH9Gczxx6CLxA1RDodEc4aO/AaG61kkgl5j4uEmR443RuiHrZ4FpX
	 TENYZyv6NyEu6xw7ssJFe3mFF+jHAhW9Q/vC9MWc+7Hnu1NhKttcHhQrPZDLpRqtg7
	 jpIfuYDmMN6pQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Benji Wiebe <itsme@benjiwiebe.com>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] nfsd: don't offer flexfiles layouts when NFSv3 isn't being served
Date: Fri,  6 Nov 2026 09:17:56 -0500
Message-ID: <20261106141636.256539-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110412-uncounted-lung-91bb@gregkh>
References: <2026110412-uncounted-lung-91bb@gregkh>
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
[ sashal: replaced the CONFIG_NFSD_FLEXFILELAYOUT preprocessor guard instead of extending an existing IS_ENABLED() check ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4layouts.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index bcf16dd07d488..f55092c66f42b 100644
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

