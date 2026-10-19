Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2044E3799
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408552; cv=none; b=W0EyIUhQEcvdxKvSTSS9u/OAd25Nc4tjqDf7aiyLb7Tjkqm5OIWgCDatw8/N5sBQC77d5ewXEKRb3bLa4g0cYYYZ25EbjJAlp+MI+3jJVyWAe7CRy8r74OZ96KP7A44TOFr3L2bKKhD8wskV5Q7aM1mrq/RlwE10Hed16QqVj34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408552; c=relaxed/simple;
	bh=oHCnAsvL8UPQUkf8HIgtRHdHU83LOyilj1RaGvr4dnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VNQuXLbEZ2NL810LeHrDKNBzmxDZZYkU9SfMPk7+Dziyf4BIVUWCudPl3Kk1m01hNcj9e0Zqodq/rjWdfZTqQxiNDzHDsiIP+uq6np+Hx9h7HINP96tShpGjn2+JBgO9zLShiHml57p2YafQyxOCWOem3HnFXbu3OHMppOoTj+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rxlJ84G9; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxlJ84G9"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso5751241eec.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 04:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792408549; x=1793013349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1rNKhg7wsxoFyd3ycK+p9wlTbGB7D0GBZ0I8jEotlmY=;
        b=rxlJ84G9g2yzlOuPaIHWDROybLmgy9wyKrMVzNOVTC+MYZ4glFbv2yHqDI4JzpO76o
         rBw5ncoFVHFZxTGtfmgXeWieaJR5BVYQsxU/AlZH+4Uu3sHqyoRzCdn7Aro3LczipOkd
         Mvlsek9lIetxA5WaKNASes1b+iOKCr10qYupoE7YR8PhHziT3O/m2rVJPJGtTBOPIXq6
         /5l08HP+DN1nhRYSI/tlAzgEZLr/F92HJVgxwFy0gOiseGLsJ49mcetg/7lrpciPagrZ
         wBqwAIlDzOgfvHylROR/AzC+9XUaW748gcPgJZrMo+pndlQCU8WjapZ3QmO5wOZop2aP
         hgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792408549; x=1793013349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1rNKhg7wsxoFyd3ycK+p9wlTbGB7D0GBZ0I8jEotlmY=;
        b=aXatWrqA/ghCuohU8PmiWdPVODWp99YSz0N9t/XJI5J8ey/UaCgATFTiaJhEFYkXwF
         bL+dv9uQaCSv7ZBbTDsQaPP/vB/PNS7ItJXZXjKVC8YBcg4iyZ6YNjjtpJCVKZqudkaT
         vDKyubFYKvwD6FkI+yPLRq0NOv5YOoobLgASrtkB/8oo5Y8r7W+M++qrQkl8Bqtyw4F9
         +nlM8XWHQFZga7TzbAPiIp6b4GkBH3OLqe6jPlKmi/u3RGFjQ5OfJSzYy0bCTjO1Xgpl
         IizPLzivJjaKycgaQV4lWlCnls2lwRdeCvHzR+PT167Qhvo3pJZDX2pxm2uNVKG/GTHb
         oI2w==
X-Gm-Message-State: AFq9FYLDtILbjzP80nveJGAJ+IktFoFk7j2Rlmzc4Sc0XECUVsFzs9qO
	eZL1mvV0vYU72mnWekAfVnoBnJ/DUTVmv9o5bbx7XM9ORktvR4kv7cKAMrkfSg==
X-Gm-Gg: AYBFou1q/aRcZfo9n1yy4+ny/Zev664Awaagw+36N/Szr4IykYHWPDvXXQWtidg0drR
	xu7kePBaP06VgBxjpYP31piSA48azyejR9T1pPBWK2+yWPgZmgZyDWx3wAow1+HGVqemJDGL6Lv
	VpGB2Kfbx3xmIaYJ+hRQJXWjGD9ooVZo/Sv7zIfkxNW9VMKmeRBa+cN7wPYJfMyOLzezSHaKmvn
	NxTcPggKKtzpatLws+2JMsLPCllzyKLgUi+jj8ez3nWpQQJUk3qWCoBq0oV5/EZf9Z6Pb7EWxwf
	C5l+8xt7hhB2Lf9+qHZ5qoFPVRkCAEgOAW1vyUcfY6fCA/3SdPpox9Gf6A7UMYr57czeoBfPofb
	/l8mZn1v0pCh7GCC1TnoJe72CdmcH5Wvr3JljAyy5F1EuB08XU2hkRbti+0wG/qmDcSfdDt5gFh
	TeUamwXn8Kqi/FBYgJ6spUoRWtvD6EG68jaOc2uRKg3ewAsi6EI+ih+4QbtdK+NrcZ7VwM5dNp0
	4iSszKFQOoGd5yoJA==
X-Received: by 2002:a05:693c:88c9:20b0:351:7444:8bfd with SMTP id 5a478bee46e88-361a2e2fe01mr10666792eec.39.1792408549090;
        Mon, 19 Oct 2026 04:15:49 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081ab80f9sm51054961eec.12.2026.10.19.04.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 04:15:48 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: stable@vger.kernel.org
Cc: mptcp@lists.linux.dev,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.12.y] mptcp: move the OoO check back into __mptcp_try_fallback()
Date: Mon, 19 Oct 2026 11:15:41 +0000
Message-ID: <20261019111541.2063142-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 6.12.y backport of upstream commit 1bba3f219c5e ("mptcp: do not
fallback when OoO is present") put the out-of-order queue check
in __mptcp_finish_join() instead of __mptcp_try_fallback().

So the fix itself is missing, as fallback still happens with OoO data
queued. Worse, the passive side now refuses every MP_JOIN while its
OoO queue is not empty, which is the normal state of a connection
already sending data over more than one subflow. The joining subflow
is reset, so such a connection can't add a new path, and a path that
comes back after an outage can't rejoin while data is in flight.

Move the check to __mptcp_try_fallback(), as upstream does.

Tested on 6.12.113 in netns: 6 connections (5 uploading) over two paths,
then a third endpoint added mid-transfer. Without this patch only the
idle connection gets a subflow on the new path and the other 5 joins
are reset. With it, all 6 join. Same result in 3 of 3 runs each.

Fixes: aab400cf8e35 ("mptcp: do not fallback when OoO is present")
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 net/mptcp/protocol.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index da774b1a..00997357 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -74,6 +74,13 @@ bool __mptcp_try_fallback(struct mptcp_sock *msk, int fb_mib)
 	if (__mptcp_check_fallback(msk))
 		return true;
 
+	/* The caller possibly is not holding the msk socket lock, but
+	 * in the fallback case only the current subflow is touching
+	 * the OoO queue.
+	 */
+	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
+		return false;
+
 	spin_lock_bh(&msk->fallback_lock);
 	if (!msk->allow_infinite_fallback) {
 		spin_unlock_bh(&msk->fallback_lock);
@@ -943,13 +950,6 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	if (sk->sk_state != TCP_ESTABLISHED)
 		return false;
 
-	/* The caller possibly is not holding the msk socket lock, but
-	 * in the fallback case only the current subflow is touching
-	 * the OoO queue.
-	 */
-	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
-		return false;
-
 	spin_lock_bh(&msk->fallback_lock);
 	if (!msk->allow_subflows) {
 		spin_unlock_bh(&msk->fallback_lock);
-- 
2.43.0

