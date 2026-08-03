Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38A413D539;
	Mon,  3 Aug 2026 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773818; cv=none; b=aCKea5cqRRdteGMPdCgdWLAZYPSCsb9nUAzDQ1A9rfm5GN4pyWf2kdgXY4MtgIdGGiycAlc8ZSWSOt22QlgqTc5NsFBWlLWXYyQ3mB5yBBuhwDYltXzOH1AhSjXjRIURvRqqWROYoIGu2gmvxnFWapeVc5mY72fCBJBX7SeLK9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773818; c=relaxed/simple;
	bh=WZs+8/yiJF0P/e4Ck26Shd+DGPg0HtRuV3kDVuZ1wc8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dxfTbwd5mrVUd2sax+E/L45sa8UJSt0gqYsoyGi1LDL85VsytFxncHgszVuGMTf7V72j4x65h5u9JAKor72/G3FsyOMuajbFKXVaZ5Ioy6AYkGP+w7jbcBbvAywA4KIwWI+VfPwerXm3Xj24N9STqod4nMIoTensePH8qQkkhrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TX5fpOxs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TX5fpOxs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0137B1F000E9;
	Mon,  3 Aug 2026 16:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785773817;
	bh=FACHO5L9ypzZbRxgf/kKsyj67LIz/bYjAPs9VlKXMpA=;
	h=From:Subject:Date:To:Cc;
	b=TX5fpOxs/gWrepWJt+T47+H1iDzUAQaPYb1PgDcrL+2tHevvWL3oWqFrt0rtZg71P
	 ha7192pBClpoLkyGXAY+UrV6UjELbbABarrENXScxULIqx98pES7LwaNevY/UJ1A/K
	 kn27cg+cUZzqcuNX5dO6mX8lAerOwDQNtAxodKkiPYWi3158SSe9K6GwH+UGxtC4Cy
	 zy7snDkBXCU9p/TrWGUEe6f2KjUQMJL7emfeM8Q6eYUD/WHsvAAguehU1mCep6ghzX
	 chlKAa0tmGYNG68QalHe1ag/2bz4yCJdrqqZJjpHGmX60AflwNKGxTxbOQjXF9CBzQ
	 SS2PxahsePNlQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net v2 0/8] mptcp: misc fixes for v7.2-rc6
Date: Mon, 03 Aug 2026 18:16:32 +0200
Message-Id: <20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OQQ6CMBBFr0Jm7Rg6hlZceQ/DQssAVSlkWomGc
 HcLXsDln7x5/88QWBwHOGUzCE8uuMGnQLsMbHf1LaOrUwbKSeeGjug5Yj9GO2LvgsXGvTmgQUK
 xGolIHazW3JgCkmIU3oBkuED6hOp3DK/bnW1cxSvWuRAH+WwjJrXB//VNCnNsDFNNVKqirM8PF
 s/P/SAtVMuyfAGllri34AAAAA==
X-Change-ID: 20260728-net-mptcp-misc-fixes-7-2-rc6-22213c66ef75
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>, 
 Florian Westphal <fw@strlen.de>, Christoph Paasch <cpaasch@openai.com>, 
 Qing Luo <luoqing@kylinos.cn>, Gang Yan <yangang@kylinos.cn>, 
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>, 
 Kishen Maloor <kishen.maloor@intel.com>, 
 Wyatt Feng <bronzed_45_vested@icloud.com>, Yuan Tan <yuantan098@gmail.com>, 
 Yifan Wu <yifanwucs@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>, 
 Zhengchuan Liang <zcliangcn@gmail.com>, Xin Liu <bird@lzu.edu.cn>, 
 Ren Wei <n05ec@lzu.edu.cn>, Dmytro Shytyi <dmytro@shytyi.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2882; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=WZs+8/yiJF0P/e4Ck26Shd+DGPg0HtRuV3kDVuZ1wc8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIK9r15tPtXaldKpczeu3m3JbQDhXeyLl/3+MQ2vT8ft
 i+/tvHHgY5SFgYxLgZZMUUW6bbI/JnPq3hLvPwsYOawMoEMYeDiFICJTHjEyNC/atesstOaMccW
 35xyY6Latc19dnvrFuzVu8e6ZtmDdgl9Rob9eTv4bENrc/n1Vk2Rm8H3iPteHvsuYfcQD44dL1I
 f7WIEAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are various unrelated fixes:

- Patches 1-3: harden incoming MPTCP suboptions parsing by rejecting
  non-combinable ones. Patch 3 removes unreachable code after patch 2
  added here for consistency, and to reduce comments from AI reviews.
  Fixes for v5.6.

- Patch 4: fix a data race in the ADD_ADDR timer callback. A fix for
  v5.13.

- Patch 5: correctly catch data corruption during the MPTCP join
  selftest by marking tests as failed, instead of only printing a
  warning. A fix for v5.18.

- Patch 6: fix a leak with the userspace ADD_ADDR list in case of race
  condition during teardown. A fix for v5.19.

- Patch 7: deal with MPTFO with a valid token, but no data in the SYN. A
  fix for v6.2.

- Patch 8: reclaim forward-allocated memory in case of error on the
  receive side. A fix for v6.19.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Patches 1, 3, 6: new.
- Patch 2: handle MP_FASTCLOSE & DSS case.
- Patches 2, 4, 7: updated commit message to reply to AI reviews.
- Patch 8: start comment on the same line as the opening /*.
- Note: the title of this series has not been updated: the fixes are
  obviously for the next RC.
- Also, apart from patch 3, the different fixes are independent: in case
  of new issues discovered at review time, valid fixes can already been
  picked up, not to be blocked by unrelated patches.
- Link to v1: https://patch.msgid.link/20260728-net-mptcp-misc-fixes-7-2-rc6-v1-0-f7e2d229159d@kernel.org

---
Gang Yan (1):
      selftests: mptcp: join: mark tests with data corruption as failed

Matthieu Baerts (NGI0) (3):
      mptcp: options: reset DSS fields in case of unexpected size
      mptcp: avoid combining some incoming suboptions
      mptcp: remove MPC && MPJ check

Paolo Abeni (1):
      mptcp: reclaim forward-allocated memory on RX path errors

Qing Luo (1):
      mptcp: pm: fix data race in add_addr timer callback

Shardul Bankar (1):
      mptcp: pm: fix memory leak from alloc-during-teardown race

Wyatt Feng (1):
      mptcp: fastopen: only mark MPTFO subflows with SYN data

 net/mptcp/fastopen.c                            |  7 +--
 net/mptcp/options.c                             | 67 ++++++++++++++++++++++++-
 net/mptcp/pm.c                                  | 19 +++++--
 net/mptcp/pm_userspace.c                        |  4 ++
 net/mptcp/protocol.c                            |  6 +++
 net/mptcp/protocol.h                            |  8 +--
 net/mptcp/subflow.c                             |  5 --
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  4 +-
 8 files changed, 101 insertions(+), 19 deletions(-)
---
base-commit: af39eb111ce6b5eba9c08513b62c4868eb7e7fd5
change-id: 20260728-net-mptcp-misc-fixes-7-2-rc6-22213c66ef75

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

