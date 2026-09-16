Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AC64B8268
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576459; cv=none; b=cVMeoyT/4U41+QCkYLfK9Jr36FcJk3JJhbt7y5czJf+1U3GODF8ACQi4u2zh+SWSPVZiGMi8d4VaLlaDlxIAHW5mTyKOjZm3T/Zh2nrXo+Orzsm2GxBPDwncd54GbQrD9SfIBVhlBZ/i/Q+AKi7IyuKXVMSNXCsOLQhQHhD+uLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576459; c=relaxed/simple;
	bh=HuFhXrxjR9hNfkdSoQ/5nCrts+tbGztmHd3Wzz6/7Xc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NjYauWPKZFOSobA2hhkmwG44a0iKJZRy1lOKfbTB5hvhkAONjnurCKk53b6vWmV/n9MojOoKbPe0beM2ipHYkNLDNQxG/QE1GzXjHabTMu1W/YxmkRJxUyiGRP8idMbo1L808HBxCP8p8ABnPitsNKsqt4Tq3ygp74azibgXJ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VZH6qVIb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VZH6qVIb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FB31F00893;
	Wed, 16 Sep 2026 16:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789576453;
	bh=INB89zANcBYfPOMYYoF9CT+aI+pB+Nqwz2itfNEeJwI=;
	h=Subject:To:Cc:From:Date;
	b=VZH6qVIbApLV/YhyBr2wUfuKS/QY9Q7dn8DY7la96Fjo0Fq5uuCO9razr7KbA25FT
	 pRBA3Kex8k3LpDYJj8MN89FwxSvuB7Vdb9+/ffhQSJtSiMH8NBLvU8iVgvNXZR6eNg
	 dK+BH1+oOr7nTRwdMypfcW0q1W2jL7l5rMUynI0g=
Subject: FAILED: patch "[PATCH] mptcp: subflow: no need to copy thmac during ulp_clone" failed to apply to 5.10-stable tree
To: matttbe@kernel.org,geliang@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:29:45 +0100
Message-ID: <2026091645-harmful-flannels-71f9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 29f641951be0d91036d77edf677807f1447dbe65
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091645-harmful-flannels-71f9@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 29f641951be0d91036d77edf677807f1447dbe65 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 8 Sep 2026 16:07:07 +0200
Subject: [PATCH] mptcp: subflow: no need to copy thmac during ulp_clone

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

