Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D070264617;
	Mon,  1 Jun 2026 03:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780283463; cv=none; b=ikqSJztZVGbvv8P3hZfTRHLZ4q1yS04T1YQeSSJ0s291A8ZzIogd5CaK+/xukRoGQJiUUZ/FmfT3nArim1ryFhCtv7LEdyZ7A7MyZfMqaGY+Tk0oPOMh0ypYZBseUzU4i+DShPTuLLHkw4FOGJaDpi800zFsGy2fccwoD8sMmiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780283463; c=relaxed/simple;
	bh=McbAPzejErfT3vRXQ/3hwMvfOEHqfV+gtaE6BzKmcQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wi9TZUhF6qKAzKEG3LgvbJt4Zzz7iM5972MmbLQwXmwJNzFKOezeUpnBRfXd6ZA/QjYpdrcnbzIA1Tx0+ikX0iG18Poh4tBFFpZzy365W2+neWZfC607w6likeYgNWp6H5s+0x80nnZRutXpjkShZw43C/qz9vR5Ayf4KtDTYXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHPbiZjv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHPbiZjv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17731F00893;
	Mon,  1 Jun 2026 03:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780283460;
	bh=4EWYupGYd5fMa1tvYvYfivxtiq5o+ETcaNhau+4S4So=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VHPbiZjvBi3URIbh+9yy1Ty0f5ERdJok9O/jdthqPra31SzdHCq0cp8NZJt4APYEG
	 czsapRFgQxA1jsmWCVNieeB0gsAicomDdig4xdSLTWvvw/HdhC0sjPbbCQUDyhYoeW
	 oIClSq+OKWX7ribSmXdprd2qqgL8z+bTXxrIz+Bjw+auvRwB2hZAtA6xzE+6TQeCsn
	 Pfj4ze5xMEemqvrvYSKrSHBt9JR+WfUB51WSEKzg+H9cknCASEDGih5jAKVUKvKN5H
	 FEweXYLav1JmJ9xo9n704aL75hOJRF+KlryecwTgDvQXOzfsXZVZb6ZP8Nj+XB/wJ0
	 4837g2pSZCskg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Jun 2026 13:10:02 +1000
Subject: [PATCH net 06/10] selftests: mptcp: add test for extra_subflows
 underflow on userspace PM
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-6-a5ae7791754b@kernel.org>
References: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-0-a5ae7791754b@kernel.org>
In-Reply-To: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-0-a5ae7791754b@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Tao Cui <cuitao@kylinos.cn>, 
 stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1256; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=cyJve84NvhmylEe8skv2EBSqKlu2Y3sUtFlAamahTeg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHPgeVqo4MD4RbWI77LRUvcraY7/mPtF7LoMdC
 S0S5gOPfq6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahz4HgAKCRD2t4JPQmmg
 c/WIEADBsojBBx6aa+lOXi5MVUtjGRHSyaatf20rWs7D+XtxEbZ06HVU8OsoNdq3Jwb/xjooi+d
 Jr1YBHyRQAOlUbJhe7KQKqfl/eSMXSbYsFoct2WPrZ263rejFVVxOrjufTvDtFWFt6BLC6LoNbc
 +IQ0En6toato0zDqsf+Za2/ipT2lIpuzbjbNAQDiq79BDSyXVlU4LH/RNJUKDeZyCxst+M0Rw61
 lA+C+PSXASc2SahUZu72ercuVm0Lj8sNb3ndKU860Tk4mj563xs7vKYFQazgIlcA+L6DNXjM8pZ
 iBdHPulFmpA3K/odyrD003b+LSTxsjJve5x44/BObLWTjfbP71HdgqhxY9RoSIz2tznsbQtPbBU
 bBQK5pA319AulbK7LTKutbIpaKwDYD/nSFBSkUgQIyI172mo58bMBdmxJCILzvlUIP5yg1G1XXa
 9bCmt70AEyfwzJZBWL5rL/7ZFQAfepvy7G6x0wU3DjnPYokPOFIOF2XQWw/LYXWN6t0jX/ax3LH
 +bVlk7khSk1lhsjd/GhJa1a6XBVquj+lBFWKO1hCW+uGsVSeK4JK5Zlo8dA/S+wEfc6OOp7PwmX
 VFqXMXQQ4Gug5p6CAkzgA0kisj0c0t0He+ZhItL5VA0dIDrnagv8JOh+D3/DeixhwMM9dYUCteU
 47T3a2Fr5gHgA5w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Tao Cui <cuitao@kylinos.cn>

Add a test to verify that when userspace PM fails to create a subflow
(e.g. using an unreachable address), the extra_subflows counter is not
decremented below zero.

Fixes: 77e4b94a3de6 ("mptcp: update userspace pm infos")
Cc: stable@vger.kernel.org
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5acd12021e6e..4b3f71e66609 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4100,6 +4100,10 @@ userspace_tests()
 		chk_rm_nr 0 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
+		# check counters are not affected by errors at creation time
+		userspace_pm_add_sf $ns2 10.0.12.2 10 2>/dev/null
+		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		kill_events_pids
 		mptcp_lib_kill_group_wait $tests_pid
 	fi

-- 
2.53.0

