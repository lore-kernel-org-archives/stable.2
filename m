Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2525C2E0B5C;
	Sat, 19 Sep 2026 20:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789850421; cv=none; b=H4nj51e2hd+/OuXF4sibL7O+xryRHHXcoMAgDJ6A9Hg1IiK3R1mH34GSN2ulvLcVY60fXxHvhzde/H6iFFtzlecZBqZ7TYm2/dJ9JLFcFBjRWvtWA4op9WOHlVU3cKlRFDqh4BR4109GEzHQS5M+AfkEMMlQojleXkYD7LuZwTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789850421; c=relaxed/simple;
	bh=7Mqhwzy14SxGpSCxgPzS8B1ZTiAqAYuw8Z11BcOTLfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slgmpZjqBtI9WKlRj+t5IRrxL62tW4xJsw4GRYacihiA6o8MJKkUr93K6KdbgBsk86Izfg/t1IxQYQ4Qw03VGS/V5lMHj/LKBYtm/3dwG64ik2u5Tmy++O2hw7A4ZGsX45IGU2atgvVev6STHGF90cRhqSUB8Ipwv3ZIbfqhgk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Stqr7POM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Stqr7POM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049691F00893;
	Sat, 19 Sep 2026 20:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789850419;
	bh=FGiN7DZE7SNmGs8mXCCFJxnriRZj+k7YKH0AUKtG4PA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Stqr7POMhRyetoKUWCBwaJPlehWCBoS57VVOGI2OXKICWn0ko+AOVWmDwquh/ZFOu
	 Mw8uJd2q202x5TRi17nhk62Xe5NntEU+NkDlOcORlq1PklEDqr8rpauncCJGnYIkn8
	 5yMJU3/6rHLpP4uj+3a0qBb+a0Nav2wFDd/ghOF6EEIvXEjV9Vr3YNRDzwqFz2oiAN
	 2CddJ+PwWYN1QH02bqAs3JO9JXQ7f3Xyz3Vf9zPjHk7YzgqF7UaLXf3rVpGykh9K6W
	 iLrLRCMd5xNdat5FdCfuqE5Af9Fs7HZo5kYicb3zikXh6ME68kodfOOsVKeCn3AS7i
	 DvpylsR1n1VAw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	Shardul Bankar <shardul.b@mpiricsoftware.com>,
	Xinyang Ge <xinyang@anthropic.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y 3/3] mptcp: close race between scheduler and state change
Date: Sat, 19 Sep 2026 22:40:06 +0200
Message-ID: <20260919204002.2106015-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919204002.2106015-5-matttbe@kernel.org>
References: <20260919204002.2106015-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2004; i=matttbe@kernel.org; h=from:subject; bh=3J0g0H6jWDUocJNJZFyoOd1sBfQi2zLg4TVOF/B6coU=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWfVbTUEjS+rqzcS5z5EvRiC1L22Tl1E+v/7phXsbh4 x92TFXc21HKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRgjKGf9rBK5b/P3BxxYrY jqCVdkUzupdZPtw8ld3xDaerm7JkuSIjw5KpGs9WaP9cVl9ks+f5jJwL38JXK2z/rrK9SHW//Kb Ku3wA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit 42064de57fb83231fcc89663a94885f228a1ee53 upstream.

The mptcp scheduler may race with subflow sockets state change: data
transmission on the selected socket may fail and a later release could
try to use mss_now reset to 0 for a divide operation.

Address the issue by explicitly checking for the critical scenario.

Fixes: c886d70286bf ("mptcp: do not queue data on closed subflows")
Cc: stable@vger.kernel.org
Reported-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
Reported-by: Xinyang Ge <xinyang@anthropic.com>
Closes: https://lore.kernel.org/20260525194828.1137119-1-shardul.b@mpiricsoftware.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260917-net-mptcp-misc-fixes-7-3-rc4-v2-2-0cf5c72667c8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Note: moved the mss_now check in previous places before commit
  d9ca1de8c0cd ("mptcp: move page frag allocation in mptcp_sendmsg()")
  which is not in this version. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 292c21713eb7..fdebc451e23a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1381,7 +1381,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 	mptcp_set_timeout(sk, ssk);
-	if (copied) {
+	if (copied && mss_now) {
 		tcp_push(ssk, msg->msg_flags, mss_now, tcp_sk(ssk)->nonagle,
 			 size_goal);
 
@@ -1891,7 +1891,7 @@ static void mptcp_worker(struct work_struct *work)
 		if (!mptcp_ext_cache_refill(msk))
 			break;
 	}
-	if (copied) {
+	if (copied && mss_now) {
 		tcp_push(ssk, msg.msg_flags, mss_now, tcp_sk(ssk)->nonagle,
 			 size_goal);
 		WRITE_ONCE(msk->allow_infinite_fallback, false);
-- 
2.55.0

