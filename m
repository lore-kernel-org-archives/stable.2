Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1384225403;
	Sat, 19 Sep 2026 19:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789847175; cv=none; b=LdyZIW1cyQo6zCNpHs65AKquaRUsK8z0j3bSn3OsXkQhEOO5V9Rt55WElYaA/iNPgYJZ7S/yp7xm0f2QyApe9XKi9dzcqvJZPL7nxzModU0/vNyNDcA512NfSDTPFQH9RLeibe+X2Rc13CnSGawr6zinq5saX67+pogKIvJjV9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789847175; c=relaxed/simple;
	bh=Wq/mhJ8JL8dkThvrw/lYB/SIPWU3pvX1UqnHvFYvL/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWgVWrqKw1ONbAWuFbD1Be+ihp0hDdQlN12CViKLcWTE1HCyGynK21pJQlCKX0QJ+TB4LJ53/giQVhVXVhikT+UyszgjVmHWP7CM4zjcw+nDouOxMDiQIAQ/MzR5HXTBXfmlBg3nam6F5hOF+InJzRsJrW4sMpjhM3PCUo/9mRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inmB3m4v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inmB3m4v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A311F00898;
	Sat, 19 Sep 2026 19:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789847174;
	bh=GP+r0fxuSCklfuLFF2m4lYHcHX6RTsdo33U151xfeb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=inmB3m4vmahsg9H2EWDnZ2sjWhuuqXCjGBF2SQrw8shEMLIWAstAtqoJSEMrpfbJv
	 GjaGGcevkNWvC3eFadUylE1lepKUy+zrjhMrobe6+0d+i2+i/dR0Dg1ZA1Q8cK9YBm
	 yiGk5g0MCA+0sdJKXZyeso7l6S9Smf2KbKN1cbv7gAJ8tSeQlgq09SSyK+J3UTswuw
	 tArD1+vqIj9goyewxu1pnl0Gel+JBb37vqvEYzq4pCLU5SXC7qmZgJm/9jjcmoEkfK
	 iRRxn81S+IOR5fr+NoxbpkysfDCOedorrGbVfmjb4CPnoTT1Kdy2e3H+MV8Mm5EfbE
	 Q+fthlF9hlq9A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18.y 4/4] mptcp: fix bad accounting in __mptcp_subflow_push_pending()
Date: Sat, 19 Sep 2026 21:39:53 +0200
Message-ID: <20260919193948.1927666-10-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919193948.1927666-6-matttbe@kernel.org>
References: <20260919193948.1927666-6-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1208; i=matttbe@kernel.org; h=from:subject; bh=zBx8JjjlaRjg7GAQr1Ldif2BN6BCKriH9oQ3xfJlvH8=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWPeWOP/jPUV2pwvuTgJN6sePK8vUHPx31llhdqhTDG /FEbuOOjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIncncPw37/QdfLBbWYdG+Mq N8TLBiudmnHBOPTtk5YvB54X89Ze7GRk+KUsUmNywPS0UOi82X+nyP1zOH9rvk1eGktcJlvz+k2 t/AA=
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
index e600b2efd0df..e9967d55b8ac 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1705,7 +1705,8 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
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

