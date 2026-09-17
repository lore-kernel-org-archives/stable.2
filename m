Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302E637A843
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613905; cv=none; b=Krm6yhNCdm5YmSSq3pjrdpYpREF2VLnfzpXbJIPGCqR1ChzuCGG6OBmirzVYW8otdmexmULZvtefxNzvGuxOM1fnTq1x6cwIU35pcTO6/D0KZgGDCe848cp2RfFl7++jfE2fJawLZ/FLoA1xH0m16UVqw0bGgfB7omb6BEUeP/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613905; c=relaxed/simple;
	bh=bp8trsE7d6mAGgE4wP/h9NSq9seuK7VdLBUO1hRa2h4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhr0nwmsKSil+7mkX6Ed1zOok/B1NV/mIusCSpE4uwpuw9wpv/l7ZR9s404Mcy6hOubS43NNVALpZ7nm0bkalyRUVe/8O5ROq4KC+f3rK7K5nhtL8j86HTFan2Wg9oegJWdSXxl+CSkj5SlZt0OsSpiomlOZZX4Qazg/8CuEvwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3R2JJ06; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3R2JJ06"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF261F00898;
	Thu, 17 Sep 2026 02:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613891;
	bh=x6Yy9hq3XXxuu/4NXWbbSngHJzDoFKsIZIAsAlfyhg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U3R2JJ06EkeXF5BVdGOTug1BLXnRpXzQWcZ07AmPEWdtnWwnF//j0FN2ThE3PSncg
	 w6OaxHtMWlXd0uMNgiCMEIJ74klscG4qr5AM0vHFaixUeyIdIj/WQTwItG2oo5Jz9e
	 F/Ru2QsB75HxIWZ+JACUMm2WE6zVpBzFfVjSIz3cfOslZ4hZZLcB8e5qAUbwY6ppeX
	 AvkfmspZi+uCYimA8a0i3YMiGpKrgDPttvFlahB0z+rke7GFiR1fc8eN5JTvVPUV0I
	 iyVfbCdcFf67+qjHkS78qdMWpad5Ld5/KLHlRhNXYcTvhFQm4uDDEu3M8TvaQziH3l
	 O+Ac6m0Lm9qdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] mptcp: subflow: no need to copy thmac during ulp_clone
Date: Wed, 16 Sep 2026 22:58:08 -0400
Message-ID: <20260917025808.3934320-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917025808.3934320-1-sashal@kernel.org>
References: <2026091645-parkway-theorize-2131@gregkh>
 <20260917025808.3934320-1-sashal@kernel.org>
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
index adcda90d6a532..486777bf36381 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1804,7 +1804,6 @@ static void subflow_ulp_clone(const struct request_sock *req,
 		new_ctx->request_bkup = subflow_req->request_bkup;
 		WRITE_ONCE(new_ctx->remote_id, subflow_req->remote_id);
 		new_ctx->token = subflow_req->token;
-		new_ctx->thmac = subflow_req->thmac;
 
 		/* the subflow req id is valid, fetched via subflow_check_req()
 		 * and subflow_token_join_request()
-- 
2.53.0

