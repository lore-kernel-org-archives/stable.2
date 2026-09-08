Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FBA5452A2;
	Tue,  8 Sep 2026 14:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876875; cv=none; b=PN/peoWs2Dceg9Ra9FuBbLBbymtD3d4HTsyZxTPA+Dz8SpgsReNB03O9PGZzTCl7NEF0LLPpFXE8injokkbxDFF35/BjNesFR6Ttycun5a4lDrQVJhEcZEWUWFNJCOHk7vlwdkp5vCkIXyxV4d5vPfMvaM9UbspPh18OpFnuMh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876875; c=relaxed/simple;
	bh=fxMH39EiXefslZTzlRWNigq/snXjgcnGUl/f/2XEJ3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pJ8MRnmAx7nGJTPWDqKUiUZgDSXKxxAz8K2PTMehEmkaIxavP3BynpZ4AhxV9AMGJ/8d1Cd1OXwJ/UgwZXAb02yiPjWkCRQI7PIsLb0yl/U1F9b/bTTLHdB/nGTyoKqWLu0Uomb/oc+ECTN8o+NTr9+J430QGgrBzxNPR/YTq7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnSBQRiG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnSBQRiG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3579A1F00A3F;
	Tue,  8 Sep 2026 14:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788876862;
	bh=fw3sAfr3TBuViXjJMX6QyiDIAVSnEhj3ZWxnrfrUtV4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MnSBQRiG8CnPZkipcwyFkfJhN995n7+p1AslPgPe6b96ftWKsKOc3DwEuzprpWSEa
	 pipTrNZzrse4qOvqvOeGHgea1POz07Fl8lZjYvCO8njoEPmz1TXFP42Lu0GserqKBZ
	 tVTadBamAOoXcxLc2+woO8I1vOMq6T6hdLzbabQamsR60RIFeKRzqfY2GjbNF9MQyq
	 iH4mAmyi8tgIsrClCh4kHc51P182cHqo6NIpJG49PRD+VAt2aYps5N+W9N7lre67Yx
	 k2igUU00k0CXNo1MvRE0fivrlLp4DOJIG+J7xqXnMyVFAO5vkMbQ2n19qb2vvfcdYv
	 NkQyjOHyw6hDw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 08 Sep 2026 16:07:08 +0200
Subject: [PATCH net v2 03/15] mptcp: syncookies: remember the request
 backup flag
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-3-df1de70348b6@kernel.org>
References: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org>
In-Reply-To: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1762; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=fxMH39EiXefslZTzlRWNigq/snXjgcnGUl/f/2XEJ3Y=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIWSGgIPnSbFmqr55UwVcvaqu6rgY+a9R+7fd/2Gl6YH
 DRf6kh+RykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwERCLjMyLA+YzGNotfernsMz
 EbXN15Q+7ki/nxrxuTfRwzxrWfm5JIb/AVuWqSrPrPfYs77UbpPAsYMtV5ZEl7f6tnip+3v5lv5
 kBwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Instead of using an uninitialised bit when copying the info in
subflow_ulp_clone().

To fix this, no need to extend the join_entry structure: backup is
coming from struct mptcp_subflow_request_sock, only one bit. Do the same
here by using one bit for both.

Fixes: efd340bf3d77 ("mptcp: distinguish rcv vs sent backup flag in requests")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: update the Fixes tag (even if the target version is the same)
---
 net/mptcp/syncookies.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/syncookies.c b/net/mptcp/syncookies.c
index b5cac5701122..9474706641c1 100644
--- a/net/mptcp/syncookies.c
+++ b/net/mptcp/syncookies.c
@@ -26,7 +26,8 @@ struct join_entry {
 	u32 local_nonce;
 	u8 join_id;
 	u8 local_id;
-	u8 backup;
+	u8 backup:1,
+	   request_bkup:1;
 	u8 valid;
 };
 
@@ -63,6 +64,7 @@ static void mptcp_join_store_state(struct join_entry *entry,
 	entry->remote_nonce = subflow_req->remote_nonce;
 	entry->local_nonce = subflow_req->local_nonce;
 	entry->backup = subflow_req->backup;
+	entry->request_bkup = subflow_req->request_bkup;
 	entry->join_id = subflow_req->remote_id;
 	entry->local_id = subflow_req->local_id;
 	entry->valid = 1;
@@ -117,6 +119,7 @@ bool mptcp_token_join_cookie_init_state(struct mptcp_subflow_request_sock *subfl
 	subflow_req->remote_nonce = e->remote_nonce;
 	subflow_req->local_nonce = e->local_nonce;
 	subflow_req->backup = e->backup;
+	subflow_req->request_bkup = e->request_bkup;
 	subflow_req->remote_id = e->join_id;
 	subflow_req->local_id = e->local_id;
 	subflow_req->token = e->token;

-- 
2.55.0

