Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7F225B0AD;
	Mon,  1 Jun 2026 03:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780283467; cv=none; b=XYNnwJoDQTHDtQLFdP1qTDRLZUSU6yu5j2wLUOobENQ3IZL8/jDRtsaWQThsh+xALZaPAxnKIACc2ug+Q0ll706QCgyXmXN87VXsg5DJg+xgIEnnUvz510/cj/48LA5FDKFyNmaXJzoki52GmmauTUSSKbB1sMIwv/UaNbOOqUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780283467; c=relaxed/simple;
	bh=MNwk9kiw5Gw4uouuz+RiKh+UVqshlnpxa58+xHjhdHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MMnnANl/wrQuLclRpRLnkaMK4bNM8vdQ5cU4gt6P7GhFJ8QdlsHX/9vr4uAgJVtwUDZgFr4HE+OisJqFcxNRXwk/0h+/TLrgW7T/DNBEVEhgJTtwFqFqEUIzwTfYYe55bPTXLeJhsDkYEBmqL7QYX8Eck0t1Z3xdB+sDUzYENPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRmgEx6m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRmgEx6m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3ED1F00898;
	Mon,  1 Jun 2026 03:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780283465;
	bh=SlNpdZug6zmUodf4JIGKJ0htxXImybIlq2fCzCj5nQM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HRmgEx6mo5HJdMxbCYYGbe3hruJHOCiYzsm0NTtY9Rcwr/8xKnkEo1ovGsFcQBCGE
	 412jwPmVNPX3yw35vwsjY6zIJ0fAubnX9fzi/ZKn9A5xROtvmPwb77Z4MEnyq2zL8h
	 FhwESQyWpZtleYQMdERSBsZ9uxO016+kjchCWAdL1wRSObsOQRV3f/c1k9kF3oQlQs
	 EgIEv8gb0O4anMvHY7yJJU57+l1CexBS5FJIN0O+k8zdflMCUh6kx2iNa/0JBX8GmC
	 TNCp9Pht5tTbSQcnGGuz6EfIsMhwVtbNfVLCiiN6d/foRvwaxoPuLFP1xhRNTAnUp2
	 f66HyprNvRU2A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Jun 2026 13:10:03 +1000
Subject: [PATCH net 07/10] mptcp: sockopt: check timestamping ret value
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-7-a5ae7791754b@kernel.org>
References: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-0-a5ae7791754b@kernel.org>
In-Reply-To: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-0-a5ae7791754b@kernel.org>
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
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHPgeBBlAQ7nJn/sXIa1+ZnFT7h7/ZVOomNl9p
 vdJK8YZzr2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahz4HgAKCRD2t4JPQmmg
 c+k7D/4ufZfUHtXs+WV6sxu/X3R0mz5SXfH/ef+xL2ilno8D0fPPNXCUtNsaKaFbZMPdmQ1ZX67
 j5GaLQBMqSxecArzlgA7RT60QpcIBKCkyhU/mv+QS3pOc5tsD+WFt3GASQUDvvBSG5GhLXuILu1
 uaVSoknF//WRmIAUauqThF0RHn906ltDUdW5Dkt7OmrLeSbKj8oqqINQDaQZdVgGVchWfTXJ5HC
 A4xyYCUstX5z0kgtnzrwD6VdTdCTrkpIO28ZU0AEyAbUrPaTm9vdnkAmZ8cM87IezmA9ESd+z+D
 qqnTFltnZEPAIQCvl47jRuCrdvz3HP2m8324TC23HWqwrV3JhmS8RkiPSSWJuclol6SIRwMHn54
 1UX5x+09zKSuAG/20XrShujw+ka6T/otrHA45hJPNlwI77BVrcrvnqSCNtOZkOnmg93FzUhEK95
 Arat/R4vQaEWz+lXYKiSF85RoCsdhOZT8Gkdtn0n57ZEwMkhKpbuQ4q4lZFAN+559FbiO25l4LJ
 OnQzbpmrewSMUp5075R7+uQ5fhYk0SJx3FKOAPDeEAnjEbZeoZA4TpvWZSKkkYexDt35eiaUGTC
 rXYCHO5NcwZ9iQAJvSCyqdJqaiv9mcun9JBrXKDxfkU9lEG9N9BIRa9VQM4CdbaJCZRBn7JTDsX
 GeDVsTAAa2WO64g==
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

