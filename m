Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795440324;
	b=IeKedVCiIdI3rgUTYsWaj+mbb2/RE1dYBBga+zyQNxRz1HqezfynKEXLv8pltbcF3/Zc
	 7A5ryeo3NAibuRP3+1WLZ3jwtvUcLQy1Bj0kkvddfG164/n2s29YAOzF/nMNqUglQWzGy
	 Xh6H1ozjU5sOq9n4ghxXL+49WuqttkQHgZ1ANV/JMuyuD2FXued7YKTCfuQJ75AVgKeGw
	 L493BYiANX/TdSTxKTKhccufrkt+em0UOVXwTz1D8gbJI8E/yjQmItumqWGSSl+QOmGCT
	 mJuC7aTpmFuapL8x9vQoecmR74vYi5yHXX7T+tydm5+4+HWKddVH3VNdTciibP+d2vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440324;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=MrNU+nV/zJnhBjm16IqK8XVPj2Zt687O5n6nlSUOWGQ=;
	b=5orvz6oDAPy/D+kIxS+40GLJb5PW8IAV4vsNlsu02un0cr6YnA/9qaL813yNtlv0d7Ds
	 RwZjUS1plYP4OAlpxqHpFiFpKM/qeS1N//hpR9Uss7bHvPe8sHHpH3RuOOoAV+fHPaJsN
	 nhdk5sdon8a6MjhjSMUSWFjFsBJQ7Zflf4pQuaMVDTXCzInvqYC89JVTRw8q7mvruotuT
	 hxuh4kA0XdYfXTD9caKyzaqpY1W3lta3p8SFwA3gCbPZbvrEOLdbc0tEqPosH5HxgWq2r
	 p/ma55EzlsmqHv1EHh3fDSY7jAnQlEIefVXrHfMPQgITfw5yGoUIOBY6WKiPq9R8b+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lM8GFpif;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5B2606A31A;
	Mon, 23 Nov 2026 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lM8GFpif
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F261F000C6;
	Mon, 23 Nov 2026 13:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795440323;
	bh=MrNU+nV/zJnhBjm16IqK8XVPj2Zt687O5n6nlSUOWGQ=;
	h=From:Subject:Date:To:Cc;
	b=lM8GFpifZpq4wx5tU4vQWvW7dNwHv6dqiIUMrWb4L+fn07tFT/rj0kTEPMUyShbhg
	 6AsFRzKm/BptjwCl2S1Lf+xjM+6DshM94C35apyz6RceJtMQaIc/1NNVU+TbgXHWBX
	 8wryqG1tBCOE0lDiCNXVbBCYFJBv38ICWND/rxbgrmlngSCHqBzq5Y7wsjePGC4Jen
	 eGY61QZg2rP8niHzAqcs5YPiHBVFdkBecG52TaxfnDbA9w77vO2oOMsOEaAB8rWAfC
	 F5frIGgMLe4ZgP+iw6seftYW3Bqqhg78HIO56ZCB87mFyeCOX3VD0aAGj71e8IT+0j
	 yOWAj5Y2h9BaQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 00/10] mptcp: misc fixes for v7.4-rc5
Date: Mon, 23 Nov 2026 14:24:48 +0100
Message-Id: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-0-278042217e8d@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMAxFf2Xk2YCtW4v+iuzBZplGWC1NFWHs3
 436eC73nBWUq7DCqVuh8ktUHtnA7Tqg2yVfGWUyBr/3wTl/wMwNl9Ko4CJKOMubFSP2WGnAYxi
 mkPo5xRjBEqXy72CFM5gJ43/UZ7oztW8Ytu0DsDq1lYUAAAA=
X-Change-ID: 20261123-net-mptcp-misc-fixes-7-4-rc5-965d6b4fb777
To: Eric Dumazet <edumazet@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 Simon Horman <horms@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Christoph Paasch <cpaasch@openai.com>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Davide Caratti <dcaratti@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Hyunwoo Kim <imv4bel@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
 Martin KaFai Lau <kafai@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2284; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=B2trs4kIXIiqPkIOyZnC9TAND7g5DiPoVSenkct0YWg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJZ7LYXVK51/zCdbWmp03Y5r4sV/+UWfkr6tXB1/2G7U
 pPlzCmLOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZS2sbwmy3l2qQnoirpHp7T
 l8zue3ClcOnVk7f8Hu4V5y4Jv9h+QYzhf1Bz+eEzz/0KP+2cEPyNU76kbOP//NvGU0/uX73M5lR
 MDgsA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are some unrelated fixes:

- Patches 1-2: drain the queues of a TCP or MPTCP socket when listen()
  fails, not to leak sockets and their netns. Fixes for v4.4 and v5.11.

- Patch 3: clear inet_opt in the child of an IPv6 listener, to avoid a
  double free with SELinux and NetLabel. A fix for v5.6.

- Patch 4: fix UaF in corner cases from delegated actions. A fix for
  v5.12.

- Patches 5-6: do not leak an orphan moved to the CLOSE state outside
  the worker. Fixes for v6.15, and for another fix introduced in v6.6
  and targeting v5.11.

- Patches 7-8: do not let PM listeners pin their netns, leaked
  otherwise. A fix for v5.12.

- Patch 9: initialize drop_req, not to leak sockets with SO_REUSEPORT
  migration. A fix for v5.14.

- Patch 10: do not pass a BPF request sock to an MPTCP listener, to
  avoid a slab-out-of-bounds write. A fix for v6.9.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Chris Mason (6):
      tcp: drain the queues of a listen() that fails
      mptcp: drain the queues of a listen() that fails
      mptcp: clear inet_opt in the child of an IPv6 listener
      mptcp: leave an orphan's DATA_FIN to the worker
      mptcp: initialize drop_req in subflow_init_req()
      tcp: do not pass a BPF reqsk to an MPTCP listener

Hyunwoo Kim (1):
      mptcp: fix use-after-free of the subflow context on the delegated list

Josef Bacik (1):
      mptcp: pm: don't let listeners pin their netns

Matthieu Baerts (NGI0) (2):
      mptcp: don't leak an orphan when the PM closes its last subflow
      net: add __sk_net_refcnt_upgrade() with a GFP mask

 include/net/sock.h              |  1 +
 net/core/sock.c                 |  9 +++++++--
 net/ipv4/inet_connection_sock.c | 12 ++++++++----
 net/ipv4/syncookies.c           |  3 ++-
 net/mptcp/protocol.c            | 42 +++++++++++++++++++++++++++++++++--------
 net/mptcp/protocol.h            | 18 ++++++++++++++++--
 net/mptcp/subflow.c             | 32 ++++++++++++++++++++++++++++---
 7 files changed, 97 insertions(+), 20 deletions(-)
---
base-commit: 3896ae4adf5ffc11ffd0f7f42c3923e8dc195e75
change-id: 20261123-net-mptcp-misc-fixes-7-4-rc5-965d6b4fb777

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

