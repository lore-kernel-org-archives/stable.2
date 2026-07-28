Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A8C3A1691;
	Tue, 28 Jul 2026 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258749; cv=none; b=IkZuuanX/DTJdK/3tMYftGby6RohSlNqoJXQd/JRji9tVyTJg9mXtmOExLOZ5uNFPhyElpyhBv2kD/6ha3y2H4B6U3LNNXoTUQStqXIMSb86rZBCLBaHTk3DzEIirdddSDyudG3Og5rPIIxkcqTvjBjzNoHVPwuIfQnVzzhtHS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258749; c=relaxed/simple;
	bh=m4x0bxSy6TxsUPrJI6w5irHD5JNUjCHFJQxz6MDrmzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Muj86vy31TJMO4e/2/rtFlvOMUNvDMawai74HseSoea5SO9k6J446FPoJk31SpemMMLFgAHwvlKA7gD0KKfY63m8+gGaY+oqv5wCAaTuzHw3nmYj3cGaFU/v4GKhz5JXLpmu7NKHMj5blPh03HfhowD1Bn+yNrpvsn1Rm+eerEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ur5/NbGA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ur5/NbGA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89B91F00AC4;
	Tue, 28 Jul 2026 17:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785258748;
	bh=mFgngIcB30lySgR+387wwGE2NX/cftkfr18bbdf5vD0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ur5/NbGAO07VVLGDkyPnUqzeHLQvxcIyzNkCKqkVr60xiUPAMc9MsvzMEUNzV5E+V
	 6HUG+bhs+/jFfBUgVcRa/53BB2wjmgPFsgvKaB0u0i+52I4n68QpSlbQElGZLNvqg5
	 tBVC7E/bDJ5khb4ruXUj9fa0vD8/KlHXmRRb21fk0Od0E5ZYcyxO38ty/m4xpBmb7S
	 TbGOux47kD+zy2cWrJvMTaI+Qyl39/46M9mOAAiQHMrVrb+uzbrdpYp7mteWGeo7lR
	 KM1LK98sYE+JDzx5c748ydjkEtt6EeRAqiCm7VJLE8Xr7wNLzh+531nTAB8Jop2GHi
	 wmx9JMHXlc1yg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 28 Jul 2026 19:11:59 +0200
Subject: [PATCH net 3/5] selftests: mptcp: join: mark tests with data
 corruption as failed
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-net-mptcp-misc-fixes-7-2-rc6-v1-3-f7e2d229159d@kernel.org>
References: <20260728-net-mptcp-misc-fixes-7-2-rc6-v1-0-f7e2d229159d@kernel.org>
In-Reply-To: <20260728-net-mptcp-misc-fixes-7-2-rc6-v1-0-f7e2d229159d@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>, stable@vger.kernel.org, 
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1789; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=OVf+JQzy7NpD1xgEnXRFt97nQ/5etoH6bLJALYeGoSQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIyHr1btSHj3MK7V87v/FTvcsFu4vsrv1dEt20/EKZ8Q
 EijKdtBtqOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAijgGMDP93lnp0WEzTdhR7
 5tTpJdtmqKfBGl62qC9Ta/atKJW8WIb/OfPm/d+15NM7rzKuhc5R04ptdjdZf1193vPaqZVSJ2Q
 zmQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Gang Yan <yangang@kylinos.cn>

check_transfer() compares the input and output files byte-by-byte using
`cmp -l "$in" "$out" | while read ...`. Because the while-loop body runs
in a subshell (the script sets neither lastpipe nor pipefail), the
fail_test call inside it -- which sets the global ret/last_test_failed --
and the `return 1` both act on the subshell, not on check_transfer().

check_transfer() thus always falls through to `return 0`, and any data
corruption affecting only the payload (leaving the subflow/PM counters
untouched) is silently reported as PASS.

Fixes: 8117dac3e7c3 ("selftests: mptcp: add invert check in check_transfer")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GLM-5.2
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c0aeffd5cb71..7dc91fac4917 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -584,7 +584,7 @@ check_transfer()
 		mv "$tmpfile" "$out"
 		tmpfile=""
 	fi
-	cmp -l "$in" "$out" | while read -r i a b; do
+	while read -r i a b; do
 		local sum=$((0${a} + 0${b}))
 		if [ $check_invert -eq 0 ] || [ $sum -ne $((0xff)) ]; then
 			fail_test "$what does not match (in, out):"
@@ -595,7 +595,7 @@ check_transfer()
 		else
 			print_info "$what has inverted byte at ${i}"
 		fi
-	done
+	done < <(cmp -l "$in" "$out")
 
 	return 0
 }

-- 
2.53.0

