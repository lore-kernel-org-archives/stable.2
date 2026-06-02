Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA8E3DCDB4;
	Tue,  2 Jun 2026 12:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402483; cv=none; b=S+1iTA0Hh/MUWo969xVcpalu7nbT+ge1S5FWzlWOIqxd7Vr7zjKX2rd6m9rWhbkSHq3dc3EF90AbyKkB4kka6WJD8w0geIwsHJCznU/LsJsm5l7U867QKfpuKaCr04jTAIvq+sKvK99gkMa6qbR657PauSdHMjjNipSCQcezqG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402483; c=relaxed/simple;
	bh=oc48MCDuP3aeYaXgHiH7JAddzOG7ZS+ciJx1cavWHk0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jW30uu3dlw2X0sMjDTkRKq17XSHrHapYtW7LMNVRXjwhpgCKDcxnxlU4I5wmOf4dD3b6/ZEWgdVJqcYAiYcBdcClTJadkcIGlbKpLJMrsT9F5BtBnhY9cSR++9LRWm8FJNKYD3Ffzy7t2Zn40tNEUO9MHBDOUweNPAO1w3eWqp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUk2+jS1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUk2+jS1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCF01F00893;
	Tue,  2 Jun 2026 12:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780402482;
	bh=TrVuRHQhI0OvyGX3Bx4M7qfCICvN1stKotonp9OY6eo=;
	h=From:Subject:Date:To:Cc;
	b=YUk2+jS1MVkUMCAfI6uHMJOx/CVxOIXt22dEO7FotCWFi038e0JTHVJnDz3x97An/
	 UKuGUJp3NiYTtJ4lhO16RWYY7gcfpoEJGd3iHIJbqa6+TvI0WUF1SgZi+yLjV1FNol
	 gAAPBWf0GE5HYcfEjhD5EQB8zhga3EnaT7GVHXbO/2/aSmoIpoHhJ+553k9mF7Vd85
	 PPfondxVsXtoQX239f4R4aFFAn6jv2zehubuC8MXukOxPK3pkAjzbLpX4Pm+BHbjUh
	 bderncYREvUdVOg++wg48h2IP5XQFhCFs3kcmyLXeKItzbNV6dwPOtXI7ypsXfxSOM
	 aKCwAoVxbIAIg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net v2 00/11] mptcp: misc fixes for v7.1-rc7
Date: Tue, 02 Jun 2026 22:14:07 +1000
Message-Id: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-0-856831229976@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOQQ6CMBBFr2Jm7Zi2FAquvIdhAWWEqhTSVqIh3
 N1SD+DyT95/f1bw5Ax5OB9WcLQYbyYbgzgeQA+N7QlNFzMIJgqWZxwtBRznoGccjdd4M2/yqJC
 j0wozWZZSV62QRQdRMTtKQDRcITah/h39q72TDrt4xwbjw+Q+6YmFJzjtFezP3sKRYZM3pFTFV
 S7by4Ocpedpcj3U27Z9Af2D/YXgAAAA
X-Change-ID: 20260531-net-mptcp-misc-fixes-7-1-rc7-34884c9b246d
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Tao Cui <cuitao@kylinos.cn>, Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Gang Yan <yangang@kylinos.cn>, 
 syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2790; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=oc48MCDuP3aeYaXgHiH7JAddzOG7ZS+ciJx1cavWHk0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHsksy8owi15dOVO53RUbRprPAt8yXy9qAJg8P
 00ypTnDiAiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah7JLAAKCRD2t4JPQmmg
 c0oUD/wPQdvjeYNrhR5oRrm5edTPqIOPk7KfkQbfIdnqQthouaRv699cv3tpC7gXl2XE275ScTx
 ZwOJSva3J7ACsXXUbIINvO8UmzEFHWI8pYcih0T5dwU2kCzU1yNn+TCtSbdXsZH9XJ4Fwc8tmUq
 OKN/SwuXO8KeLK+kOgY14xTV4EO4iO+JqYuKnMIfDy2SWmLZX3EIsAfR01iKY5sbUMCSL5vw6k5
 siVsV65a4fjChoI7OS2wP/45KesU3x8VCfce1uccTWLkBq2yCvJuIgy2ymKlNPqwXNhYKg3AmwU
 EI4zzQEtgSmhWpeSgO13hO12yy1cQRhVpQ1ZkOANvlwAptgLv6q9Tj3g0NBULma7TJyDnsyy7p5
 KJhr9ekl/0CgQxZMuSwobH2zrYxz5tu4bcbHOfrO5XeCpai2VIraHEYVM9bH2ZpPPHGgwlbmtpq
 0vgb6w75/k/y3aq3Ye8DUI3DsoBrESAMUf0VnLy+E8BhYx1Cyzl2G284x1MCKQT4ThEiuBARF7K
 YZGZQWSx05qUrs+CcZ2f3bOsJvArUOOjwpufr6Zm4mFeM3KWx17aNnKduunkMRLSvIpcAGvEK7W
 mQx2UzY0X4R6CqHp8U5sCvHqcZ754gZbD6XAV5mV4PVWO29cA36TDL5S8NO2pfOsB0IUG3gpylO
 OiJ0Cw8tm4mFUGg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are various unrelated fixes:

- Patch 1: fix missing wakeups when multiple threads are reading from
  the same fd. A fix for v5.7.

- Patch 2: fix retransmission loop when MPTCP checksum is enabled. A fix
  for v5.14.

- Patch 3: fix a TOCTOU race while computing rcv_wnd. A fix for v5.11.

- Patch 4: allow subflows receive window to shrink if needed. A fix for
  v5.19.

- Patches 5-6: avoid 'extra_subflows' to underflow with the userspace
  PM. A fix for v5.19.

- Patch 7: report errors if one subflow cannot set SO_TIMESTAMPING. A
  fix for v5.14.

- Patch 8: try to set TCP_MAXSEG on all subflows, before reporting
  errors, if any. A fix for v6.17.

- Patch 9: check desc->count in read_sock, to act as expected. A fix
  for v7.0.

- Patch 10: fix an uninit value in mptcp_established_options, reported
  by syzbot. A fix for v7.1-rc1.

- Patch 11: fix a similar issue than the previous patch, exposed by the
  same modification from v7.1-rc1, but was already causing issues since
  v5.15.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Drop former patch 9
- Patch 3: add a missing 's' in a comment (NIPA AI)
- Patches 10-11: new
- Link to v1: https://patch.msgid.link/20260601-net-mptcp-misc-fixes-7-1-rc7-v1-0-a5ae7791754b@kernel.org

---
Gang Yan (1):
      mptcp: check desc->count in read_sock

Matthieu Baerts (NGI0) (3):
      mptcp: sockopt: check timestamping ret value
      mptcp: sockopt: set sockopt on all subflows
      mptcp: add-addr: always drop other suboptions

Paolo Abeni (5):
      mptcp: fix missing wakeups in edge scenarios
      mptcp: fix retransmission loop when csum is enabled
      mptcp: close TOCTOU race while computing rcv_wnd
      mptcp: allow subflow rcv wnd to shrink
      mptcp: fix uninit-value in mptcp_established_options

Tao Cui (2):
      mptcp: pm: fix extra_subflows underflow on userspace PM subflow creation
      selftests: mptcp: add test for extra_subflows underflow on userspace PM

 include/net/mptcp.h                             |  7 ++-
 net/mptcp/options.c                             | 79 ++++++++++++-------------
 net/mptcp/pm.c                                  | 15 ++---
 net/mptcp/pm_userspace.c                        | 14 +++--
 net/mptcp/protocol.c                            | 10 ++++
 net/mptcp/protocol.h                            |  7 +--
 net/mptcp/sockopt.c                             | 15 +++--
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  4 ++
 8 files changed, 81 insertions(+), 70 deletions(-)
---
base-commit: 3522b21fd7e1863d0734537737bd59f1b90d0190
change-id: 20260531-net-mptcp-misc-fixes-7-1-rc7-34884c9b246d

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

