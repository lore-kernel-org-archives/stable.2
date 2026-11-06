Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929992;
	b=Oa+hWEnocDcKruI3FXy/mkEKY6JheT8rT5+Foz8vrj3KCekMzNjReIqcqdtr3pldFC09
	 60vCZ/BM5KV3pFjtM8c1nJHa0zz8bUqa7QHkZlnvC6Jrigm43NAaVyskqPQ5nokqCCMz6
	 IvRlXa70QVvIdvSonGj6V6ArnW5JRAKfYgZiblKlqRK+jcMcQp5y7wwMFeqNOju+/gVuY
	 SEHF6bWMz5K3OAX8hZ8bMwbKCCdg+8XCD/LSii8GloFilbhNmCtOrzvXcG0WRtmy++0TN
	 SG+BVo7h9y/c187gXPOTPbw4lv1JrxgKZl5ukbE5A/qakdUTJt9SOYIUDrNb9q/pgqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929992;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JQlFkSxZ7OulS+LVyOvgczl9qmny304Q/HJtsD2btV8=;
	b=oGX6775GxW2IS/RRBSIpiMUsR/0WX1VLp+W1NQ7Ur1cRxTNUIgTRqCcYXXSJsVeWlMPw
	 gKD2P3uslzrZnxZJ3d2qTm1SLpjDmdaQmjr0pw+Cs4BklVZUQ0O2T23WK7b43Cl86DD20
	 sqg4Q0dZaJKgeXwKCaRxCxhQJ8++06xzROdSYpX8UMQ2FnOw8/ldYDImZh3D1tR3kY7W1
	 mwJcp3CVtojh+g45RfmlrpaphKE/t4mWjmv4szzw/8oOvll/BR4YNHFdMRCCTxy0jtTcG
	 2wHF5IPRz1P9AQD5d7OKy4iFXd7DwKtiMA+nwAy8gXSjdQYtB+XZt6QuP0MjWyy8mVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UiutYnFP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1035606A328
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 01:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UiutYnFP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D0C1F008A2;
	Fri,  6 Nov 2026 01:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793929991;
	bh=JQlFkSxZ7OulS+LVyOvgczl9qmny304Q/HJtsD2btV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UiutYnFP+sel45azLtG132VDHfTbZqnZQfh5o/vHkphnnA2fi2hMGepcaLNlquWKW
	 /WeGjbInwFs24n0Zv+eqr7gBixzqG2uKVykhiUcqrOJeXqY24F1kFQtMMk6+Buvh9R
	 LRWQ1jNq+cjQpMYa89GS0Cx8O8nSNjezy8P3pzptiLdiUEBJ0RH3W2T7ppkqbxvLUc
	 4Z4cGF8XmdF2hqRRUCLgmxg3/5+gVBUnZGk1ljIEY0oa4m5dnS7TEtsdV486CDeHeP
	 xiMmssfPAGaHqpY09FFXdEDk7C9Lwp1HRLsRczdGSnNWLnii3x9CUOllIjdOossHky
	 BCo7d+GMVH2Cg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Benji Wiebe <itsme@benjiwiebe.com>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 5/5] nfsd: don't offer flexfiles layouts when NFSv3 isn't being served
Date: Thu,  5 Nov 2026 20:53:05 -0500
Message-ID: <20261106015245.3586810-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106015245.3586810-1-sashal@kernel.org>
References: <2026110409-glaucoma-strongman-8f52@gregkh>
 <20261106015245.3586810-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4layouts.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index c2d435c99bf5e..8ec980c69bec5 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -125,10 +125,12 @@ nfsd4_set_deviceid(struct nfsd4_deviceid *id, const struct svc_fh *fhp,
 
 void nfsd4_setup_layout_type(struct svc_export *exp)
 {
+	struct nfsd_net *nn = net_generic(exp->cd->net, nfsd_net_id);
 	struct super_block *sb = exp->ex_path.mnt->mnt_sb;
 	expfs_block_layouts_t block_supported = exportfs_layouts_supported(sb);
 
-	if (IS_ENABLED(CONFIG_NFSD_FLEXFILELAYOUT))
+	if (IS_ENABLED(CONFIG_NFSD_FLEXFILELAYOUT) &&
+	    nfsd_vers(nn, 3, NFSD_TEST))
 		exp->ex_layout_types |= 1 << LAYOUT_FLEX_FILES;
 	if (IS_ENABLED(CONFIG_NFSD_BLOCKLAYOUT) &&
 	    (block_supported & EXPFS_BLOCK_IN_BAND_ID))
-- 
2.53.0

