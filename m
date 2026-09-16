Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E76C4B0E32
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576464; cv=none; b=dZp9yTk75RGOXNUkuF6mg69tmBqGn8ssnyU+QcjNexoj9oT33tWeFO1XKbLmn/ien4h9mCEonq+7dhXR1vdOGMriKCqsQZ3kEt5hDJ5joD7zAOndILZ4EnFvzy852VyMnGBxUcg8a3XAryujZHQRP7Dg8x7efpaXRUOCFGWv7Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576464; c=relaxed/simple;
	bh=uh/oGeXCQdHIr9Q5QwspCM0Fi13Ru3Tk0U0o0Qzjfhk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Vwa2M6AGu1S/sxq4uE2HVnejx6LKu3xZrnG/06jDwBCQ/Ak7vQHP2dJ8oj2iVSCdO+akTy1NE2CjxKSaBVbAJqajovKX60gki5awnlPmkPvyDysTmOot2Rb/1gI9Yojt3h4X5v1ufyr7KzEX/h0rtZdsjF4JpF3pb1NX3FSmmu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rM3Ni5AE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rM3Ni5AE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C951F000FF;
	Wed, 16 Sep 2026 16:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789576456;
	bh=Eo6BthBpsAG/Y4RsBhWZR5xQu4vagLHE9q1LEVhgKgE=;
	h=Subject:To:Cc:From:Date;
	b=rM3Ni5AEG14qP7+TGE6WdxCb83gEHyxieAl7RjW6T2GYvA8fNawekJVbXXnN6K27M
	 dWB5WrdqbmImrISEFY4f3284cQE0Er6zKCO4uJ8g1md/RSi6mcsP0nqIDTDKL8PJgV
	 6r4WQmvhEGctujRR8mkaNThpFq04ufJAlKGji23E=
Subject: FAILED: patch "[PATCH] mptcp: subflow: no need to copy thmac during ulp_clone" failed to apply to 5.15-stable tree
To: matttbe@kernel.org,geliang@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:29:45 +0100
Message-ID: <2026091645-parkway-theorize-2131@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 29f641951be0d91036d77edf677807f1447dbe65
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091645-parkway-theorize-2131@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

