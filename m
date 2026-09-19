Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CF1225403;
	Sat, 19 Sep 2026 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789847168; cv=none; b=s1jVNMLxm/JRIB1RuWBTZL/VEc0QXiBWbk6u/eXnH+xbc0HWMn0+p6SAdLA2YJ3sp35hdZrMzhb3k4SQzrFpYykaCURnWeQUNWs8+IKHzQKXZgkX4vvSCxQfUvlvOdxpeDhejawWl+n0CBYFAmUojBnG2P2gevcMBdELYhWsYCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789847168; c=relaxed/simple;
	bh=Z7tW9nOA9SNyMpAYQM5shGGa2hmNAkaKn4Kv3tvlEaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AoiEPvZ/pMM1u/XnqFgYlYpanQsybG+01779NZFoZfP/EbR3hO5Gg70ZwjJnDXSjE3y1sEIEkfYI8XJalQINxwR0LuyMXlmSSngEdyWM9duqV2nkGTvgGAyMX3p+tsAAq7rzErMzPy0ug1uGjOe5siLG004xP4Yd1QMHKickqdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Amv0J3Y5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Amv0J3Y5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D251F000FF;
	Sat, 19 Sep 2026 19:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789847167;
	bh=XuMWs1YM+VTHaEpYpWldHjI0bBRpXXkCQTDqHyt/Cxc=;
	h=From:To:Cc:Subject:Date;
	b=Amv0J3Y54uvRBcTwr1yoYr+JD+WUmWpf00xjLIBLy5E2lMtZdvZZAqfn7CPNtT73s
	 jq30lgrkW1qckuYGBSsEFj50Li+BPmnoMmYaZfT/p/EOsl+x21MyC7BGhz9eaMRJMV
	 EwApxnoYm5W8M2nIgjH76bLWPVQJB2kmZo7hqXmW8HhIkyoXXnTMtfrkPRSlvUoSWT
	 8CTvGcqBMteaUz6IT8m+LGVlY/4N8Gs1rdfckpvG/gRMSOOK11GJ5MEp+tF608gemU
	 nVsKXXXJVUQVrrUhLptTHovlkGntTXDrnyJ/U9cklBiN+tBwWjMO/SN2Lp9zKnWvC6
	 ULsGR48dpqmQw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 6.18.y 0/4] mptcp: fix recent failed backports (20260919)
Date: Sat, 19 Sep 2026 21:39:49 +0200
Message-ID: <20260919193948.1927666-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=939; i=matttbe@kernel.org; h=from:subject; bh=Z7tW9nOA9SNyMpAYQM5shGGa2hmNAkaKn4Kv3tvlEaA=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWPWVjK163183VRMu18H/iHrZXotmdT13fRf9NLuf+H 3Cv5P/3jlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIl86WdkmPBpX8nNn/WKc7bc /RL8w5dba6JnBGO4liz/z6PLTW0nHWBkeHO4awfL1ucfHyu8k3xxbeq843oz7Fheb3qW4dv/S// WVGYA
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

