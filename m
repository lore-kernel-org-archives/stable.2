Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FC5330D43;
	Sat, 19 Sep 2026 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789848371; cv=none; b=A9aF3WF/+8aOmXHrVrdth0dBrfhRGWXhT30RcLbAzC9QaUqVV4ShH31aZkyxo3WEdEv6WPx9VZGkROSK7QMxQ+iB3P94HmQB7l9xneXehbaE+RLNNdEdAdGqEu1nphYNYn3XyhwjB9Wd8YIKt3x4x4oPbu21eRJaj1yT86CJous=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789848371; c=relaxed/simple;
	bh=e4GcvulTmIeF7pJbzhJ1erHzPXPReTT3p0D910LabfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3g3ozjTUSiPpmbBzcNsXydRQ5AzGYkyU5CIFfc1Tz6ta48yYzGCNstjlzMvO5O6c5rzQPV3GhQ3gqIq6D/XFny//AGpNPDAH6PLmCqjboKEk4ETU+8NhtYdxIeO0TAh2BfORkgkqPbY5pPkSpxJgBYNv3pszxgDxGJtlXC4jU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdbPHS1f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdbPHS1f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5E31F000FF;
	Sat, 19 Sep 2026 20:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789848370;
	bh=qEY2FJ8Rgril9UKqC5Rr28fJAVFEpeyKx/yCnNC5Ja8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YdbPHS1flSokBNDXjTKYNxNn2D/GkUYsyJxoDwrZw0CDDV/J/9ohVNpr5ENzlqkdT
	 0JRGUf++XQ/3HYCu4icj9IvIpZOOTSGJ3WEgAuczyCsupDsri/qwJY0wpJlSdYKVuz
	 OfdR6ZDVKmIGqRZPURfczcRjISD4VqFWVs7Zq09GAxLmG/m2oi2U8IPYm9JcZ/eTHK
	 qEGaMnm+HW2ld1H32Nb3NOZz24jko5kLpmPiBXCMh1Kp693kDUgUl4k/RNX3hgX0yP
	 MPO17pcRsOO6PB9Dru6wRCFCHry1BgfqJ3c2zSU/m/FOQyJNBR3i8/kNayrBI3lD1L
	 UFF7xWN5TQvwg==
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
Subject: [PATCH 6.6.y 2/3] mptcp: close race between scheduler and state change
Date: Sat, 19 Sep 2026 22:05:57 +0200
Message-ID: <20260919200554.2005069-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919200554.2005069-5-matttbe@kernel.org>
References: <20260919200554.2005069-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636; i=matttbe@kernel.org; h=from:subject; bh=QLZQJZfmNd524Nka0ukf8EFcTGME13LrnpryXEQN+5Q=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWvVbbxZ9zb3XxW2/ejK1O7fyi0T0qfkcXFO/49zz6+ DpNzlC5jlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImcFGb4Zxm+nOHnt4U2kQee L5xyS+fre83pPU0lflOXKX6QdvAVdmdk2JHtsrVz5T++RKeW5Dkd22tXfTA9s7NAV/Hjvhk2j1K c2AA=
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
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 187e60ab3f77..3c1ad8601fb2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1562,7 +1562,9 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
 static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
 {
-	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
+	if (info->mss_now)
+		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle,
+			 info->size_goal);
 	release_sock(ssk);
 }
 
-- 
2.55.0

