Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3087B3921E7;
	Sat, 19 Sep 2026 19:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789847825; cv=none; b=pirNLzmEvHY2QThYPFl44DD2E6x1stbdLPuYepfrO6bYdqzR85f9SgyaXAecnH2CJOzCt5DOy+yH1FYvJVJNSbiT9ZpcDVzVX8RvQsuzBGJTCWzBtutF2pO2gZZsGAPEGChQJkqDPNkWV1aUxU814GM+mgPW5/oyxFjSC/0lCRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789847825; c=relaxed/simple;
	bh=z3eG0hDjQKm0uthwOF6gQpzQRPUyT+NQRh+DalhKjps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnNE6d08Ck9bloImxSoDU8mAdOmlEMYMORe6qNEoQ0LCsn6d6U4Pgz1GjwWaSOefSFOvEgkwET2K7Q60FU9OnwydUNfxSGe2I3C/nI1JrRb02KMyTgAUUFgDpPcbljlMYRnG//aZneeYg5TvXPWWsBN3bPOJF8QNGUFXiL6WVx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCjqwO8U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCjqwO8U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EB11F00893;
	Sat, 19 Sep 2026 19:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789847821;
	bh=JUx6utZXkDZLh4llFLFuj2gS6/ubIv+qwUeW0tnZEHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OCjqwO8Uh0B/uRE7Y05hbqhO5FFfbmAO0vxB83eG35CKm5MD4TJ+MOjVs58PYXwt9
	 nOJrZKANa9/aox199jrcAvCA/mPhfJNjcNOxp4iibjfsSqKXoAF+yxdKPF2+X1wWwg
	 2UNA4lPP4pEA9n6mGBoG5paFpKH+tBnpVhxKw6Ci/U+iUtGdAxrlfwaOWuPRzsfmwC
	 Nx5iy+n+enXpuiwFK3dAFORC3CT7fW9tcEiE9F9d72vvrHLPsgLVMDB1pUOatMdbT2
	 dbUQ6Aa+vHtQFQIJFd5FQTc8SlRbLkm4iaSEvy2yD/fL0mUt9r8oReC/jVSFdvN1/Q
	 gUq9ZOITx3Z5Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y 5/5] mptcp: fix bad accounting in __mptcp_subflow_push_pending()
Date: Sat, 19 Sep 2026 21:56:48 +0200
Message-ID: <20260919195642.1977885-12-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919195642.1977885-7-matttbe@kernel.org>
References: <20260919195642.1977885-7-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1208; i=matttbe@kernel.org; h=from:subject; bh=D7mEQdlUlOkhHr7cnnZ0yQi/+uAedqRlpcZ5JLZDPAo=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWvfjfmC3/QHGTT56Hohvz3Jx8zeu8G0yf//WUjE3mb 3h8JUKwo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCKHRRj+ZxT6lsr77b80v2my Bv87gZsOD/pabSa57vzhL+tjGPvWjuGv0Ion+103rdilOM9g3g7d6Y8WF34qmv609ZrlviX7+dM PcAEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit f3ef03357396d4b147d8e76c75fb612c2f264ffc upstream.

If __subflow_push_pending() errors out we should avoid updating the
copied byte counters, to avoid mismatch push call later on.

Fixes: 0fa1b3783a17 ("mptcp: use get_send wrapper")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260917-net-mptcp-misc-fixes-7-3-rc4-v2-3-0cf5c72667c8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1304f3cb6d14..ee160c783ff5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1757,7 +1757,8 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			ret = __subflow_push_pending(sk, ssk, &info);
 			if (ret <= 0)
 				keep_pushing = false;
-			copied += ret;
+			else
+				copied += ret;
 		}
 
 		mptcp_for_each_subflow(msk, subflow) {
-- 
2.55.0

