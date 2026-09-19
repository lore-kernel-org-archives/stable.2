Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E91B1E7C18;
	Sat, 19 Sep 2026 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789848785; cv=none; b=Dm2vrmB7DxEKPaieaVV2xyp697zH4pugSEagNIhLmPrUGZZc+1THy1UG20t9lEBlOjUlL/a8euV0EekSqzhdkpa8frbTb7Lc69RLXo5GbbzQLn2qDeQW5rhuVoDhssl2Bg6ZJj5yC4VUKUPFGmWESd7ctlb3iY4T6elKX1z7VK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789848785; c=relaxed/simple;
	bh=eTxlQ+VyAf06cDaoP45ZIbQ71JAoKr3xos41SDmMLJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JtWwtq2DaabuJrlIBo3h5bAgUEjk6NIKNSAIvxVvtr05YdCJCqGlbIG/q2+ufBXDmniaZ/AyvuWsrB3gRdzr2nEkqzNlV3FSs9y/w+OU2V8kvXV7UIPVd+DMgyXmZnehP1eBVY6BAIT1Z/bT8xcDkrPWH9GUOF+Cc3ov7H05u4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CP+itcu6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CP+itcu6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D661F000FF;
	Sat, 19 Sep 2026 20:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789848784;
	bh=9WSkMk4jciG9h8xturWsdn1aa3mIcj8qsX9/U5hBU14=;
	h=From:To:Cc:Subject:Date;
	b=CP+itcu6WKTmLrd+hMkZipYF2hvjjVU05hI/CueUG5V/UFdhBzF6yiWM4S2I6bTAd
	 KQ9aUc3ecuH6U9yL9s0LoLmKXC0khmCWjVlX9zMqsSPPuKdN6WFQhfSFEi/JGiXpsy
	 ee0u4Jl9qELSZeOITlqS+cRqsx5uZa+mVT8zL0JoFvKx2nX3cqX7jtX7wHflo+axkG
	 8zWWj/OYHM8XGbNznCRsTcswUhDZ7x5Yr1o5eqGMQvLsR6V6g/8X/UEk6W+SWG2yrC
	 3ZdCD8yP5YzK7Z+gTc2v7xR6g0fs8JGHnaQf8TOq0C8QdD0RYp9eEd83z5kZGWhVT9
	 G5PSzQfkCeTug==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 6.1.y 0/3] mptcp: fix recent failed backports (20260919)
Date: Sat, 19 Sep 2026 22:12:53 +0200
Message-ID: <20260919201252.2025112-5-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=783; i=matttbe@kernel.org; h=from:subject; bh=eTxlQ+VyAf06cDaoP45ZIbQ71JAoKr3xos41SDmMLJ4=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWvTk6Xfow99HV91xO8k6Yu907d6aDYdALWQmbVa8WT vXyym2r7yhlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZhIahfDP43eGZdf/td8p/Vx buju21oZbz1LFoqlPQgy2bUq5NQ63ysM/7TP7jr6hTfwanreSa6v89a57t2+yn/zWb7H5loBYRv /XGMAAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

The following patches could not be applied without conflicts in this
tree:

- 2b0f561f21b2 ("mptcp: avoid unneeded actions on subflow reset")
- 42064de57fb8 ("mptcp: close race between scheduler and state change")

I backported the following commit to avoid conflicts:

- c3349a22c200 ("mptcp: consolidate subflow cleanup")

Conflicts (if any) have been resolved, and documented in each patch.

Paolo Abeni (3):
  mptcp: consolidate subflow cleanup
  mptcp: avoid unneeded actions on subflow reset
  mptcp: close race between scheduler and state change

 net/mptcp/protocol.c | 10 ++++++----
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  | 46 ++++++++++++++++++++++++++++----------------
 3 files changed, 37 insertions(+), 22 deletions(-)

-- 
2.55.0

