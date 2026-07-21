Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A628443AAF;
	Tue, 21 Jul 2026 22:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784672118; cv=none; b=Pu57AQdIdvQ/X8ml8g87f+/ash+r2yPPn2rHmbbafVkWqKqjMlJcvGFGQjiZpX+rMRa/G80r/9bLg+ZnxUYhFw9Q8Ig9c6PBTV2Apx+uhChvVOwRulYJhVT9q05kI2gA+Uw1EdRndozD8MEv7ZC82FD29HLe23LeEberedu3VaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784672118; c=relaxed/simple;
	bh=cQebUUc3b4trxwzXFkPnBUl35n/3pGClyHHp+w9wnHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l5i4HJkDyXaCptSRGaOVxE08ybjpXUZWy/4+T4mo/AixiJftEchQo3BHgzHBmpV/xVBZHUC42aQ2kK629Y3EqRKDQsxbsMZSDBZ1GjvaTjqJ4QGAbE1c3zP2X2AeonvWeRGZWATzU3V7UiG71rd5EwS7h7/5teblyBryd22101E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9QOAxV8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9QOAxV8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D431F00A3A;
	Tue, 21 Jul 2026 22:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784672116;
	bh=LA1GN88xFwR/n7V23hRxm12Z3KevDKUurEIo5L4Unic=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=E9QOAxV8AEuVIl2eI/NS9SD6Fa83K9SYKz3OOc+eOd1cnZucKEG/N1hcTv2gZkIzV
	 7AypNaLHOYJykI6Kn9qK5hMImnmcZSCsParRJLhCdWQ2pOj38Fl9KUcPhIZRfV2dGp
	 12/i5GGDrjA6cQYouT6PWQJppzVVbHlLO3GLbD8DfgM6OHHilOnz/1VXUVOICIJlOk
	 pCHg7Yug997qB4ayD2kMqUNmzGS/ccER7z05AlkSAaz313OB8YxqdptOIa0UoeGZWC
	 TuJYfpGMCPMUtHOswAAXNQ4HlPXHfA4YxomUbAHccs8HFzFPveMNXJ8Fmx2jePNv8v
	 gXwhhooPdQ60g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 Jul 2026 00:14:41 +0200
Subject: [PATCH net 4/5] selftests: mptcp: userspace_pm: fix undefined
 variable port
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-net-mptcp-misc-fixes-7-2-rc5-v1-4-6fb595bc86ef@kernel.org>
References: <20260722-net-mptcp-misc-fixes-7-2-rc5-v1-0-6fb595bc86ef@kernel.org>
In-Reply-To: <20260722-net-mptcp-misc-fixes-7-2-rc5-v1-0-6fb595bc86ef@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1857; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=AAR5vqT0rqrRZnOlgAxMfAI48G7bJDKuLQu6poOze3I=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLi36eeWXXTOoxDVJLpzLO5DyxWetyzc153WcX9l/iDV
 6dkHUNdO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZiNoPhn8KUKUu/mvTz6Ie+
 zdsQnSXTfP4dg+ey7jQpQY639k+CXzD8T/6f2psfrl/3oeLRgnBupia2teJPJS+/cbkY3qhwnse
 VAwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

In make_connection(), the variable "port" is used but never defined.
This leads to an empty argument being passed to wait_local_port_listen(),
causing "printf: : invalid number" errors:

 # INFO: Init
 # 01 Created network namespaces ns1, ns2                          [ OK ]
 # INFO: Make connections
 # ./../lib.sh: line 651: printf: : invalid number
 # 02 Established IPv4 MPTCP Connection ns2 => ns1                 [ OK ]
 # INFO: Connection info: 10.0.1.2:59516 -> 10.0.1.1:50002
 # ./../lib.sh: line 651: printf: : invalid number
 # 03 Established IPv6 MPTCP Connection ns2 => ns1                 [ OK ]

Fix it by using the correctly defined variable "app_port", which holds the
appropriate port number for the connection.

Fixes: 39348f5f2f13 ("selftests: mptcp: wait for port instead of sleep")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index e9ae1806ab07..30a809752d1b 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -212,7 +212,7 @@ make_connection()
 	   ./mptcp_connect -s MPTCP -w 300 -p $app_port -l $listen_addr > /dev/null 2>&1 &
 	local server_pid=$!
 
-	mptcp_lib_wait_local_port_listen "${ns1}" "${port}"
+	mptcp_lib_wait_local_port_listen "${ns1}" "${app_port}"
 
 	# Run the client, transfer $file and stay connected to the server
 	# to conduct tests

-- 
2.53.0

