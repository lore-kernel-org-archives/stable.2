Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C24374E42
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789614253; cv=none; b=FAIp4TS7ujzBppSdJS6eUpa7TCwSrUxwreGq9N1AcUZGE4SuHLDSvJBQKezT/TxexovtN0EvHCTtdfgYZN/zMMaoiWeAs45GDS7jzqV/8IfuJe0tPbYWkJsu2szrs7+WJPix/0o6HH8VUejBIbm79mGRIsNKezO1ReWSpflOLJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789614253; c=relaxed/simple;
	bh=vWxh1/ofmioF7is53rYf1dVelcvTJunyXrBqTBbZHug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fK8LLfWpyUivKlG/FvadTy1pIrs76C7nTsp/AnzpSXPyqz/2ZeIfRyVf29gmaI2z+lVLPkUKW3/LjmZitzMgGc1rh+ZCRGE67UzruyLyVgK9Qv+mjCy1uRAm+CitfsknkOT3z9ka9HYcIG5VnDlAfRaA1coDI43I1/J4Vi6vydY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDpu31LS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDpu31LS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB89C1F00898;
	Thu, 17 Sep 2026 03:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789614248;
	bh=I+L594Oyt9nr/+fy3+t1q3dXcv0gn6Yegy+W+P+LqPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VDpu31LSPWQt1MRoZWyvQ9lzYVumpmVZ+77pJB8smdphf3mGZ1Nz/i/RgoKrWZgNx
	 vGZg65EK+AYmbyusj12zcuLKbrqGlNIXZmISDaDVVhUFeT0JIxs9e2AmrWhrTLwwPi
	 zYy6mjwy3fBBD6bB2Hle1jUWIaHSMBSRHRTN17Fd6za3Cb1NhV57IPkLsvgFbDnNmm
	 swBgBIuVTfdsYo6d/mMBXFYD829ARrg4Pxf5TYxdhFoMjx6ePDwonFnTL3fmK+cEfT
	 l+NGEBmNKtoQ3osT+2T9ZC3fUWfEnaR10n34JmegfzKyaghLhVx12tcrVd9gbhnpLk
	 iysnKtD32zbxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] mptcp: subflow: no need to copy thmac during ulp_clone
Date: Wed, 16 Sep 2026 23:04:05 -0400
Message-ID: <20260917030405.3945919-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917030405.3945919-1-sashal@kernel.org>
References: <2026091645-harmful-flannels-71f9@gregkh>
 <20260917030405.3945919-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit 29f641951be0d91036d77edf677807f1447dbe65 ]

'thmac' is not used after that point.

Indeed, subflow_ulp_clone() is called when the request on the passive
side is over, so when the truncated HMAC is no longer needed.

Note that in case of SYN cookies, thmac will not be initialised. So
better to remove it to avoid a warning from debug tools like KMSAN for
reading uninitialised data.

Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260908-net-mptcp-misc-fixes-7-3-rc1-v2-2-df1de70348b6@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/subflow.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 55bd5ecc9e7a8..e7cd49c4aaee4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1417,7 +1417,6 @@ static void subflow_ulp_clone(const struct request_sock *req,
 		new_ctx->request_bkup = subflow_req->request_bkup;
 		WRITE_ONCE(new_ctx->remote_id, subflow_req->remote_id);
 		new_ctx->token = subflow_req->token;
-		new_ctx->thmac = subflow_req->thmac;
 
 		/* the subflow req id is valid, fetched via subflow_check_req()
 		 * and subflow_token_join_request()
-- 
2.53.0

