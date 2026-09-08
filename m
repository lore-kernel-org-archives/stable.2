Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174F354A7ED;
	Tue,  8 Sep 2026 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876870; cv=none; b=HDeaNeo+vGvQlJ3FTm40td+XvkXumsEZpeHt7xQJQ8WKXC3pHa8WDALbiMULFjFVVBq947jxxmoboSRnUwnAO8HHxE1ITxfHtJtlG2oxeGlPi75yPmiRCSYZhsC4EGJSphnhuO939xcWIUTuvvUnBqUvfePwtDFkA2X6sSkcSy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876870; c=relaxed/simple;
	bh=CDC/K2FJRHVAGcRgJXtSdI6Hc3vAAlafTF+wKI4l1nY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DLLbAc+CSc0k0wHT7JXRxQckfimXpHoT0LV7bO9oOU/DvARAfsn60gN5T7Y0O4vAp9JKhAOEK7M2OpGPcCjALbO6j/yW2ij+smsAHCGU7lfXc3R26/wQCHNmRQto+/KiHM/jeTwbQ8Kljy1Kwe8G90MmYY3aSD+HxCfZncROONk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tcibpc6p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tcibpc6p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD92A1F00A3E;
	Tue,  8 Sep 2026 14:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788876859;
	bh=0oaYRQgH57DHWr6sOc46cwyYSafOI68a2pNXApHJ4u4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Tcibpc6ps1nIcgg86IfKX7uvEGmRiVA1BOcGsqYLXvWMlKSlvpUOt9eFJWlQkUfo9
	 yKkUbt+1kpgoMih3mT712MOhYlDfrUKUAa5qpiXFxP7VZykW7VRWIixEa9KyCZ/t9d
	 gzzxR2d9Wf5N+JIhcwa12rDfK4L8dYf1yJjbXYGwkjCps8esiMb8uDSJUte2JzwVd6
	 ARxZIBpUEY6FZp9GA6vce+qPO6VJr9ggFbUoOsvkAxbRK3KRnFJgw5X4SYZgaiC28p
	 REOtbkGongFU8pHddpJJlkyF/lYxxgAJeaRgmU/oBsGBZnLnX7b9YnfQotZvAkjYLn
	 493cmO5YBG2Sw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 08 Sep 2026 16:07:07 +0200
Subject: [PATCH net v2 02/15] mptcp: subflow: no need to copy thmac during
 ulp_clone
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-2-df1de70348b6@kernel.org>
References: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org>
In-Reply-To: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org, Florian Westphal <fw@strlen.de>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1448; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=CDC/K2FJRHVAGcRgJXtSdI6Hc3vAAlafTF+wKI4l1nY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIWSKizt+3eeEbIbVtl9FxHrf6lLJJzrHUbbkzw4U8+v
 3+S9erHHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABMxn8bwP/HHhK3lx09pT1p6
 iHmJ8PfLBZVCS0w5j/048Pn3i5mftToZGfbPlpjKqFLFrx3N1ZoZonnLxnmXH5990wudrwJPJNO
 i+QE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

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
---
Cc: Florian Westphal <fw@strlen.de>
Note: Peter Krystad's email address is bouncing.
@Sashiko: yes request_bkup's initialisation is not fixed in this commit
          but in the next one, no need to complain about that: different
          Fixes tag...
---
 net/mptcp/subflow.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index af81ad5e699d..01db7edce18a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -2084,7 +2084,6 @@ static void subflow_ulp_clone(const struct request_sock *req,
 		new_ctx->request_bkup = subflow_req->request_bkup;
 		WRITE_ONCE(new_ctx->remote_id, subflow_req->remote_id);
 		new_ctx->token = subflow_req->token;
-		new_ctx->thmac = subflow_req->thmac;
 
 		/* the subflow req id is valid, fetched via subflow_check_req()
 		 * and subflow_token_join_request()

-- 
2.55.0

