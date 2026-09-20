Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613123EDAB5;
	Sun, 20 Sep 2026 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789897314; cv=none; b=MYhwxzyqy6IQi0yvqCKExvXWeE/8X6n2wdfPAUwiScMcHyN8TSpbTMEGrW7TZ8g5pkalkcFkIQyvXSmElfXr91VNJABVHhGWvuvKUEL05XBaPD9iU5DYCw//o0Aavwuh+eCljB7N4uONQCzvTsV76C9Vq0v19RBB+DnuCqCeal4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789897314; c=relaxed/simple;
	bh=z3eG0hDjQKm0uthwOF6gQpzQRPUyT+NQRh+DalhKjps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RhiF/H7GWVTpAAp3v54DKQdHN+s7yve/xEW+Q1NMejOvVH7Fj3dzy3ajVO1+u2LFpzz+ULGR1u8oswwPyvJHHVb9HQxbPrClRbTmB3STPWMCiLoXfUVOZsfq5ubL4pKLc5pNwIec9RQ0dGn1X9K8+zX27coPArqZQxYPFlYYLyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBnKD3OJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBnKD3OJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DDF1F00899;
	Sun, 20 Sep 2026 09:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789897313;
	bh=JUx6utZXkDZLh4llFLFuj2gS6/ubIv+qwUeW0tnZEHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gBnKD3OJYNuOYciJwCaZc9rUOpd4N4COYfPJE5XtUdPJ9A8diWrGV6EO8/QABhwhA
	 bBaJigc0Wt1kByu3ZRoHcdw1i+ssNiaKA9Ce7XPWrpqdbS6LCECZwJQ8VxQt2AE90l
	 j8gTKzAMUWnkKoWxWo9EJYKaMonQxSxW1u+Lyv75yTLvNPomzq5fJYvU8p/atRw+GR
	 QbivPzsdw6FCwoJmnVOdkDQ3Gs5zdnAA5xZKDdaSf0jIFzvmxt9i76fzwfkVw7U9J/
	 s4lZYoZ3en3wpPfUnaK/SkyhePzUwvD5ZmMTTi1URUElHTW3+5WNkizoruVWzqs6ws
	 H7omO3AIgK59g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y v2 3/3] mptcp: fix bad accounting in __mptcp_subflow_push_pending()
Date: Sun, 20 Sep 2026 11:41:39 +0200
Message-ID: <20260920094135.2431797-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920094135.2431797-5-matttbe@kernel.org>
References: <20260920094135.2431797-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1208; i=matttbe@kernel.org; h=from:subject; bh=D7mEQdlUlOkhHr7cnnZ0yQi/+uAedqRlpcZ5JLZDPAo=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWrwpuzJZ/oLjJJ89D0Y15bk6+5nXeDabP/3pKxibzN zy+EiHYUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMBFxMYa/0jkRM3Mf/mI61PIm OWkFs/Ne6cDQHXyNfzXzbBtTkrMmMvwzudlxprXPxsjd9WS+6KICRx/Zwy+j5/yY53JKVSDzuxQ 3AA==
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

