Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DB8336897;
	Sat, 19 Sep 2026 19:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789846566; cv=none; b=j0u8ZG9J5qbwf+FOEMzwe+o0JcLspUiC42GJoqv1NaVMe5Lu3G3slhnpufMZllj1drLn3vP4gXuFSUfHya9IY6+8YehxkyQa3uUPXHzfHEnUn6KmRLN3B9GWRx5kd/s4oaHDQfM74z+yyXHeQTLAETiEQrKgeEDV8sEJhYei+zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789846566; c=relaxed/simple;
	bh=Z7tW9nOA9SNyMpAYQM5shGGa2hmNAkaKn4Kv3tvlEaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NEIPob/88l6SF3H/9J3dmr+BRXUg8OD89L7v94jiTIyafl33MlV4KPiaGX8LhtJ8RH/wK8JGEl7NBtgx/m1cloxC9J7Cpe2Vnw/kOmlvpYbtj7XhC3DaF44QBMO6t/bN82JRZV3ODXBnSDxPMFz0ICtmH2xwrC9BDJn8YqQGgo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agtG2KPz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agtG2KPz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA52C1F000FF;
	Sat, 19 Sep 2026 19:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789846564;
	bh=XuMWs1YM+VTHaEpYpWldHjI0bBRpXXkCQTDqHyt/Cxc=;
	h=From:To:Cc:Subject:Date;
	b=agtG2KPz+HOueZ6JPU1vSvF7mXQwmkeXNhxX6T8s3z3zapw9822phVSSvADzhjmC9
	 5xtqzIghSYgirsIp4hqb20Ik867pHTs1xbpZo+Iy6AOonoyZbIfxN83j9LJ+jk9azD
	 wOQHysEnI70WspcdOvtCvboQlMQQmYtnSSL2Ox1Iru18Kwv3XfD0n3z2TF2hs/FYWj
	 +4YCzmTEAWlBO4ClS4tDkGe630zmmfociNO8G8PTnlKOIdVlV6Tbgz1lU/oDKKpnhv
	 Z7n/vKgfvYnp/pzStv0Pu4VFQzpLdK0TxjpCQK8BXuNgjZQhodwJgeDmR9X2qadlH/
	 xfLQRhk6cw64g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 7.2.y 0/4] mptcp: fix recent failed backports (20260919)
Date: Sat, 19 Sep 2026 21:35:42 +0200
Message-ID: <20260919193541.1915297-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=939; i=matttbe@kernel.org; h=from:subject; bh=Z7tW9nOA9SNyMpAYQM5shGGa2hmNAkaKn4Kv3tvlEaA=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWPeFjK163183VRMu18H/iHrZXotmdT13fRf9NLuf+H 3Cv5P/3jlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlkbGT4KzjHIcOIZfkvpuJl CoyPjyldEPn6VnBdm/4M69PHTedwBDEyzDgwc+vmbczFb6dG6iay2axsXeWw+tbsU1P5s/VMnW5 UcAEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

The following patches could not be applied without conflicts in this
tree:

- 2b0f561f21b2 ("mptcp: avoid unneeded actions on subflow reset")
- 42064de57fb8 ("mptcp: close race between scheduler and state change")
- f3ef03357396 ("mptcp: fix bad accounting in __mptcp_subflow_push_pending()")

I backported the following commit to avoid conflicts:

- 6cafe51e0f98 ("mptcp: move the stale logic out of retrans scheduler")

Paolo Abeni (4):
  mptcp: move the stale logic out of retrans scheduler
  mptcp: avoid unneeded actions on subflow reset
  mptcp: close race between scheduler and state change
  mptcp: fix bad accounting in __mptcp_subflow_push_pending()

 net/mptcp/pm.c       | 41 +++++++++++++++++++++++++++--------------
 net/mptcp/protocol.c | 15 +++++++++------
 net/mptcp/protocol.h | 10 +++++++---
 net/mptcp/subflow.c  | 11 +++++++++++
 4 files changed, 54 insertions(+), 23 deletions(-)

-- 
2.55.0

