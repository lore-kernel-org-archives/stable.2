Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5305111B0;
	Thu, 17 Sep 2026 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650380; cv=none; b=jV5vrWXJGmVHe7jIbCqph9GbyMI1IwzuKtNyEqyeuSZ2vMA5JIHEDG9c3lnGkJ5jXzs/On+FobsKIY8+U52rD5RO5OA8deUSVjEOCJho6kLq4O2l+drGHzMct8b4YVPX5/wWmn1MelSSiTLK+h2gYXc/WAksRd1zTLFhWta7vcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650380; c=relaxed/simple;
	bh=BFtu9BG3LXW88IuhrGMQsA1AdjmI0Ht4wDmdDAcOAko=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jH012uoZOYnRe5Rh0hOCuzMumO4VJsuYySQ0ws6qH3sgvjsIGoGavhtsJisEokanJaiBtmmZeIW8SthJhBEBh+VxE1wr15FZxgej/HzqR6ofU8yfmeV6KDxBdr0jn8vV0BmA2IZnXvOlle1dOQpw5zlHsX6gttmmDK48G5tezdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6ahSMVQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6ahSMVQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CEA51F000FF;
	Thu, 17 Sep 2026 13:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789650372;
	bh=gZlsyDZ2QI6w4s5TauCQWCUnsIAd0UB96M7zvhi0VFs=;
	h=From:Subject:Date:To:Cc;
	b=i6ahSMVQQsrR4a36Pf1RTVMjv8ccYdji076rrLk453vOtFIyr6HLhO39To+IhbzAl
	 SnSJJtRNAOEiPctDL5mT22IldpDF3L06IYhxFEPd+7Tpi84jgJbS0efKjHPOf89TUp
	 DTnS0qpXKKC5lI3M4SSZVoFA1Dn/HuQocrAtgP9p+qQEosO7HkJSNNTh52Xui6HeYf
	 lGP0TVNlQq3TtGP33XG9JndOclFiBSHY4Ipcx+tAcl8o7IN0RoJVXgwME0GycuqBXM
	 mozS+Ty1ZvSxE0XdYBqKXFhOa0pnH0nHJN/gQK7+CH2JZl0hyuJvGWHaCkCgx8Kb73
	 urZi/x4H8ItuA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net v2 0/3] mptcp: misc fixes for v7.3-rc4
Date: Thu, 17 Sep 2026 15:05:56 +0200
Message-Id: <20260917-net-mptcp-misc-fixes-7-3-rc4-v2-0-0cf5c72667c8@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OQQ6CMBBFr2Jm7ZhSqBVX3sOwgHaEUSmkrURDu
 LsFL+DyT968/2cI5JkCnHczeJo48OBSkPsdmK52LSHblEEKeRRlptBRxH6MZsSeg8Ebvymgxhy
 9KVDlp6a0mowoNCTF6GkDkuEK6ROq3zG8mjuZuIpXrOMQB//ZRkzZBv/XN2UosJZK61Jbq6y4P
 Mg7eh4G30K1LMsX2ghUMuAAAAA=
X-Change-ID: 20260915-net-mptcp-misc-fixes-7-3-rc4-538b9d7ec047
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Xinyang Ge <xinyang@anthropic.com>, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1267; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=BFtu9BG3LXW88IuhrGMQsA1AdjmI0Ht4wDmdDAcOAko=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJWP93/Ktrt06SeasddPMvPWvpvZPBkn599Q7eaqev93
 QPV2pzTOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYSncvw33O/7Kes+ddrk1oL
 60ve/di7jG+lg9yjrMtnuQJU8k47nmRkaDDa6Hsj+oO6uY7Cqxjha2fU8+PPu2uaLcgpXzz74Ol
 MbgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are two unrelated fixes:

- Patch 1: avoid unneeded actions on subflow reset. A fix for another
  fix introduced in v6.12 and targeting a commit from v5.7.

- Patch 2: close a possible race when scheduling a closing path. A fix
  for another fix introduced in v6.0 and targeting v5.10.

- Patch 3: fix bad accounting when __subflow_push_pending returns an
  error. A fix for v6.6.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Patch 1: rewording commit msg & consume skb and purge queue early.
- Patch 3: new, for an issue spot by Clashiko.
- Link to v1: https://patch.msgid.link/20260915-net-mptcp-misc-fixes-7-3-rc4-v1-0-a257797dd5d0@kernel.org

---
Paolo Abeni (3):
      mptcp: avoid unneeded actions on subflow reset
      mptcp: close race between scheduler and state change
      mptcp: fix bad accounting in __mptcp_subflow_push_pending()

 net/mptcp/protocol.c | 11 +++++++----
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  | 11 +++++++++++
 3 files changed, 20 insertions(+), 5 deletions(-)
---
base-commit: 9ca4ba24259183ce15665be86b2956cd896c4687
change-id: 20260915-net-mptcp-misc-fixes-7-3-rc4-538b9d7ec047

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

