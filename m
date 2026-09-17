Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD043955FA
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613900; cv=none; b=Shi3zlE2fBDUwTDnGQKsZKWY7TMOfGCOf2G4Erpn0fvwaXw2QK82RmMM6N47y1npbIHCvjBoSbdu37Tzbtzye0HE7Pg+sBMh4GXGbSGhliaf2LnUDLvFDC1nMepCvptLNb1IasMvm+7XG10OLdF2JAfkMjwAn4q5sZ53eo3HaeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613900; c=relaxed/simple;
	bh=QLKAWPwXap+v3Btf5VhBNDBF7szgRErGr0Vq6mmOHvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YC5yftnQlfEBa3aTwJwDUe/WNiKL8bZaHHr87a1ajzpzuP7VWJUbndRmbCaeJZ2N1ZcVBKRcOUYJEc+N+NZLgaK8fGcD6iQ5e/M84kIfQGNoV6b0PEon1JSWfSud0YJMENhlRblqlqbq+xMH8PasYMAW0HGDdqZPrRrLryqGKgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBg6K3XN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBg6K3XN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167201F000FF;
	Thu, 17 Sep 2026 02:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613890;
	bh=6Bley/EYJcU0SeXCelRwRldiAZXLkwvPRyjxxhfs5gs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HBg6K3XNZchagjCvunXVF7yv3mfuwruWm7W/kowZPVU2L2NA3H+wVSVVubcZ3e9X6
	 dSiZXwAEeran5e9WMQp45Askylyy20tojM4lkEINzVWbg+aH2GR3bLyotuN43gRFRX
	 JziePOwQfpWfMhITTfZ0FelcZiypLrDWqqSccYe+Td+UmvzKqN0WJpc/CsZAYCCnIM
	 sgBCuGinAIW8UliUqWB/jmf/8zvryNlzhGU/OHcjx2nh41oWmM/fgwlTb6Pz8YCMOm
	 R1TH4PwogciwrqRlTRVN2QZKI8ooLhOHt3ccDSX2tGGq/C07QQ/PV662nv0KoHkEWU
	 7brXdt11QZgow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] mptcp: strict local address ID selection
Date: Wed, 16 Sep 2026 22:58:07 -0400
Message-ID: <20260917025808.3934320-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091645-parkway-theorize-2131@gregkh>
References: <2026091645-parkway-theorize-2131@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 4cf86ae84c718333928fd2d43168a1e359a28329 ]

The address ID selection for MPJ subflows created in response
to incoming ADD_ADDR option is currently unreliable: it happens
at MPJ socket creation time, when the local address could be
unknown.

Additionally, if the no local endpoint is available for the local
address, a new dummy endpoint is created, confusing the user-land.

This change refactor the code to move the address ID selection inside
the rebuild_header() helper, when the local address eventually
selected by the route lookup is finally known. If the address used
is not mapped by any endpoint - and thus can't be advertised/removed
pick the id 0 instead of allocate a new endpoint.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

[5.15 dependency adaptation]
Retain only the passive MP_JOIN clone preparation needed for
29f641951be0d91036d77edf677807f1447dbe65 ("mptcp: subflow: no need to
copy thmac during ulp_clone"). Move the existing local_id assignment
below thmac and retain the upstream comment about the validated request
ID. Use the existing direct assignment instead of adding
subflow_set_local_id(), and match the target's adjacent WRITE_ONCE()
remote_id assignment so its unmodified patch applies cleanly.

Omit the active-open address selection refactor, rebuild_header hooks,
local_id_valid field and initialization, and path-manager changes. They
are unnecessary for the thmac fix and would require new helper functions.
The stable branch's existing address selection and initialization are
preserved. This preparatory dependency intentionally leaves the thmac
copy in place for the target commit to remove.

[ sashal: Reduced backport -- upstream 4cf86ae84c718 touches 4 file(s), this
  backport carries 1. Not backported here:
  net/mptcp/pm_netlink.c
  net/mptcp/protocol.c
  net/mptcp/protocol.h
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 29f641951be0 ("mptcp: subflow: no need to copy thmac during ulp_clone")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/subflow.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 33b16ea7ae5bc..adcda90d6a532 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1802,10 +1802,14 @@ static void subflow_ulp_clone(const struct request_sock *req,
 		new_ctx->fully_established = 1;
 		new_ctx->backup = subflow_req->backup;
 		new_ctx->request_bkup = subflow_req->request_bkup;
-		new_ctx->local_id = subflow_req->local_id;
-		new_ctx->remote_id = subflow_req->remote_id;
+		WRITE_ONCE(new_ctx->remote_id, subflow_req->remote_id);
 		new_ctx->token = subflow_req->token;
 		new_ctx->thmac = subflow_req->thmac;
+
+		/* the subflow req id is valid, fetched via subflow_check_req()
+		 * and subflow_token_join_request()
+		 */
+		new_ctx->local_id = subflow_req->local_id;
 	}
 }
 
-- 
2.53.0

