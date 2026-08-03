Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7546838837C;
	Mon,  3 Aug 2026 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773832; cv=none; b=OtSobTJJU9plcr4k+LqmC9GB3uVAUdAEjG+pbBq/kEDdWATHRqieA8zB8Iof4AZV69a5/N0bcajSrFiyUz8I8cXNbS48ZEROaHxuCAmRoO5DBc0qR5OAokqTAA5RNh9TJcNjazcY3sxcfkM2oHuD4maG+IgIWvaLnOiqFi/0Oz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773832; c=relaxed/simple;
	bh=m4x0bxSy6TxsUPrJI6w5irHD5JNUjCHFJQxz6MDrmzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N1TBj0QQDx7g2LmvaZd9tb+FlY3u0fxUKzSo7/UE87RQWss1RSbUxaVWqYkmqXOFA5DWPbzs2TEIl4p3vCOfGyL+UVu9LpsEtO11IFt2aWVtb3U0+gq55NyKpISO3JZMLhtUUgroiJlPH0NvEgCzQAAKkD8SU4x7ZGr3SyvbgJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETX0ARW+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETX0ARW+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946421F00A3A;
	Mon,  3 Aug 2026 16:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785773831;
	bh=mFgngIcB30lySgR+387wwGE2NX/cftkfr18bbdf5vD0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ETX0ARW+Jn/ys6uDSy+TVJMDUfgQwAuVIKKHV80gsAlNGTS0TJxFdl6TW+Rts3pPB
	 W5DoijpGogKrrz9x369A/7bw+etoa2ezB18RJsjtp0hFn4Ek+M0Ba1bscAJTJaqab2
	 ROTBtOu39hksKwhwC1NIPH7QT11wEiEYeF+1nU0Y33w6nYs5/caH33ZD29UmSukp4X
	 pGIeAgr7Yr7C4mJH77mjOSZJiju/AjfR8M/KYIdvZwmQJAcqrFQUDT6YfxVNzGB1To
	 m+7+THVNg03uCSYL3LlvLZdyyLpP+8Pvv/v18enEiZbIyeWRY6FZA+PS0qSpyjYFGJ
	 Pw76SiEGwHrIw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 03 Aug 2026 18:16:37 +0200
Subject: [PATCH net v2 5/8] selftests: mptcp: join: mark tests with data
 corruption as failed
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-net-mptcp-misc-fixes-7-2-rc6-v2-5-b8f496d71664@kernel.org>
References: <20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664@kernel.org>
In-Reply-To: <20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664@kernel.org>
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
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIK9n00O5i3f97XW+op7pwB1z7vPFp2f7vV3BuaGw9ks
 s42WO9l3lHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjARH3+Gf9pPtvT+evKs/d41
 qVtFEw2/fd395jbbvv64DOcVif2ZulqMDGeDbZ5W7T93/u13H/sau0kTDm67svGv8IMLiTcOhj/
 M3c0GAA==
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

