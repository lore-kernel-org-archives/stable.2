Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092F12E0B5C;
	Sat, 19 Sep 2026 20:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789850417; cv=none; b=Jcnb+D5f1udsuvyv+cBZa7ygI4Kwfjg443aPtfiI87Ft4LeKzcVpIiQ9IZUAeZkG+zhW5Yp7HLzQNkl+oFhJcdcgLyKQwwmjoWWy1Zxxdh06sozdWobpJzN6RFOZOxCNEUu6sAxRqJMyBr9d/SkYAaTS+d6vL3BqjZ5Zb3CcU5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789850417; c=relaxed/simple;
	bh=ET+0iOGOqPpVPKE5P0X3fT7+cAJZuDccHOJgI+Kfgd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RatOpd9W8eQnJaKIImcfnMTFEtZMJnIVwndbT4UHcGsWihGuLcelEPr5LDtruXyduX6b4YjPVF/NYTjkH7asbsfrvl6RVs8QHshXUzr/o/eu9M8/Ga/TYVbEZA/BoYIFt8wjYp8bWhrBPtXf9Hb/ts3h7Ly8wZOo3OkaConp14Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBSwlzvB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBSwlzvB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119D71F00899;
	Sat, 19 Sep 2026 20:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789850415;
	bh=8uwkxK3VPQyQs+d2+4+P1xYmZUb/w2JAsx6JTe7d+TE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fBSwlzvBt3tB9EfFBFPKFgAKkM6zuNt5X26gM1UC9AVB7I3Iw3XsSsX4YJr09s3OI
	 zn7Xrn6Nq+bR2lHbKx1+eqyvbJzYbYbWTSEiKgDy8UPE30mj5gT6c7hIgDpJ/6jCxM
	 WCeA9ktJ11BUNkZzsqY2Ax5Wi/DFyX5GeUJajQz/2x/6nGF+7DJ/hCHZBNz2Hh+imp
	 0rQpKCXGVDvsyD7ITdGahOb1tAZE9yALmfiAokNo2wFiy+f61uwOMPy3ujtLvFBX/2
	 8QPiZFLvJfzhbbwo6oOTfWDwSvb7iiN16GTdu9EKqmhOo8Be6unii5FFNCzM29TdmS
	 FTBE1X+WaLjGA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Florian Westphal <fw@strlen.de>,
	sashal@kernel.org,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 5.10.y 1/3] mptcp: hold mptcp socket before calling tcp_done
Date: Sat, 19 Sep 2026 22:40:04 +0200
Message-ID: <20260919204002.2106015-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919204002.2106015-5-matttbe@kernel.org>
References: <20260919204002.2106015-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1686; i=matttbe@kernel.org; h=from:subject; bh=hwPSCI3l/mXUcDu9zOApkdd3oQgvKAX8zTBIfvs/ZjM=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWfVZ5vTF+9sIJafWfDG4tDhQ/emeGkdsS75ULzZhPL zW0bp6f11HKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjAR+WkM/+y1DmZfYwkx6TxS Id5ttUmpUvmQnaS8/Bpe5h1vcqNuizP8M7tpWbzf8kha1EPWbZabv7h03ax48y9OY9YZH/M51S3 mrAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

commit ab82e996a1fa1b9ae514fa357d9ce8df62321157 upstream.

When processing options from tcp reset path its possible that
tcp_done(ssk) drops the last reference on the mptcp socket which
results in use-after-free.

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 2b0f561f21b2 ("mptcp: avoid unneeded actions on subflow reset")
[ Conflicts in subflow.c, because commit 3ba14528684f ("mptcp: avoid
  setting TCP_CLOSE state twice") has already been backported and also
  had the same conflict: this commit here should have been backported
  first. Fixed now! ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c9cf0fdbfbdc..77cc4f585cd8 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -279,11 +279,16 @@ void mptcp_subflow_reset(struct sock *ssk)
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = subflow->conn;
 
+	/* must hold: tcp_done() could drop last reference on parent */
+	sock_hold(sk);
+
 	tcp_send_active_reset(ssk, GFP_ATOMIC);
 	tcp_done(ssk);
 	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags) &&
 	    schedule_work(&mptcp_sk(sk)->work))
-		sock_hold(sk);
+		return; /* worker will put sk for us */
+
+	sock_put(sk);
 }
 
 static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
-- 
2.55.0

