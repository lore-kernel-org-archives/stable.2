Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EA93E639E;
	Tue,  2 Jun 2026 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402516; cv=none; b=kgx7RyWTuDUZTEoHRRxfIiUmnqTWRSG2wANeqCu402qhqYiVIDnBGndblcDR5o7ggi07PrOyIgvJeVoVvhjrxDyAkecnRMxyH3YUseVeHR4tDgyBma4qGMpL9Z71ZpQ3QF8smTpg9wdXquZLbLE0DLJYmIpyuvMnYGz16ShOUZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402516; c=relaxed/simple;
	bh=MNwk9kiw5Gw4uouuz+RiKh+UVqshlnpxa58+xHjhdHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f2rvoJDA8IxdRecu3XRNj6cOgA0ZgcagaLiPLcKIJhXzZ2UHh5nOCoVbmplRq1L20eKGw+PhvpGfdsAsAq2FTDVoviLb7F5boVcZIKNS/8mHT+xdYJTScIrXrN0BOBDfvePofAbN/0eYaWAtQEeAD+FplwQA28Dl/DCq9Pe01H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEc5ZcBx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEc5ZcBx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B6B1F00899;
	Tue,  2 Jun 2026 12:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780402515;
	bh=SlNpdZug6zmUodf4JIGKJ0htxXImybIlq2fCzCj5nQM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fEc5ZcBx0v3HafHbGntOBW3JgkGPNdxQAdq2caYsdipmxU0O4OgyxNjqSbpFQIfHv
	 Ugj7/NYCrRevdFfVJbL1Bl+gLlcIKW19bRelmaeKhqDojaHwUDBL3onhRsB8BbkqDF
	 2GlVn/IK9iRK0ssd9c5SsmngBoRl6buctHl6pZVEz+gbdRxsIhIrWq11QzoFQm3gJW
	 UguNlLoyujakQCJFp9Cu/s5eq73QxlvLbQehPGYykFJ+/f91wX9opOv02opW86r6oT
	 Fttq3+aHW6RhKvdBvGK72ZMqfvfU1ZITjiaUcC/5YCIWkI+9SURDmVPCoptaMNMM2k
	 ntNIKLUxoOmpg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 02 Jun 2026 22:14:14 +1000
Subject: [PATCH net v2 07/11] mptcp: sockopt: check timestamping ret value
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-7-856831229976@kernel.org>
References: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-0-856831229976@kernel.org>
In-Reply-To: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-0-856831229976@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1470; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MNwk9kiw5Gw4uouuz+RiKh+UVqshlnpxa58+xHjhdHA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHsks+gEDHD+8KKy8v+m9UoX27Z7RfIR1LIIRX
 C4zBZ4A0mqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah7JLAAKCRD2t4JPQmmg
 c5fMEAC0OWnt7+b5c3UirNPd60AM/QpcXKzcdhMWwzixF0eUbHPORAAWGPnBgLckVAQNJgmZkfv
 Y9ioTPjPS+wYMFGH/btWBJA4AxArukcvEdnQsL2e/Ofxtcs0BBudTtTUjddsop3mjImldNWUUwd
 +xgmOYyISUFk8Ier6lOopSeUj38xJ6zYBTqQ/Yjo66E6hxPae+/KMJMC9l3I9oc0FkmwIQfbvSh
 0lV7Pczo4At4Bmqa4kCQMyltXe5w2plPmCs757ZvGlJwxnAABi36tC4Dw1iNc4n8mVs/AH86QND
 7rTe6y2R1qPm/v2KyzDfkhvg/ZIyxTo/D8DtZ9d6KFcNHcaEO6hAdso0isjJj4XMGa33ir5IP4g
 i52xwYb3hT9wpGf8XIT0EGcNVI9ZuFF5kTsDJuJtgInzEyHCqnVGhm4J9eQBisY9tyel2tOOO6a
 OqLsnNAjOBSSSSDxoN4ojdXLLfu6AX6Ml+5KZTq2mURsgXjenH1lzbZjdIP0WDQMlz2pofMHTwZ
 sbSKyrW8xJm62dX/CrpUlrjtWTZOuhbJQCGxaAmvLvVbEzGGdXYe0EYlun30YOswOXOD4c+1ot4
 ydALniXkfnfIamIQIVKIGLPQby90I6c6HKw4Z2sxm89sLh3iK1BdDam22udsi+glJepxvYb3VIQ
 UvZkg41V6kIXK+g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

sock_set_timestamping() can fail for different reasons. The returned
value should then be checked.

If sock_set_timestamping() fails for at least one subflow, the first
error is now reported to the userspace, similar to what is done with
other socket options.

Fixes: 9061f24bf82e ("mptcp: sockopt: propagate timestamp request to subflows")
Cc: stable@vger.kernel.org
Reported-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Closes: https://lore.kernel.org/willemdebruijn.kernel.178a41a53d041@gmail.com
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 87b5796d0135..91aa57f1d0fd 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -241,15 +241,19 @@ static int mptcp_setsockopt_sol_socket_timestamping(struct mptcp_sock *msk,
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		int err;
 
 		lock_sock(ssk);
-		sock_set_timestamping(ssk, optname, timestamping);
+		err = sock_set_timestamping(ssk, optname, timestamping);
 		release_sock(ssk);
+
+		if (err < 0 && ret == 0)
+			ret = err;
 	}
 
 	release_sock(sk);
 
-	return 0;
+	return ret;
 }
 
 static int mptcp_setsockopt_sol_socket_linger(struct mptcp_sock *msk, sockptr_t optval,

-- 
2.53.0

