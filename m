Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D979B330D43;
	Sat, 19 Sep 2026 20:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789848367; cv=none; b=IPc0CrHGE/HDzOPRn0IB8+esWD1Y78KDZHTU0WRmYZI7avT3GUj6QWbyLVDTnNC7QEKha+6TPiVxJbGT3xnnxPbvbTCoWI9xEJOyLQd1NzgndYm/qTI1cmtBdMFU45VXJzVPmb3AauMMM+BD/R3d2J0lI/9EYZc4fbbXlxNFCMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789848367; c=relaxed/simple;
	bh=En/SU8k23iBCkpXex1BZcCGp05+GIRDKeYizPNPVWTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LCT7qmZ+RiYj6Fm3PdHBj+wAPh3uj9r/yYQyDPzbEWxWlEvGwI0XZG7QSLSk1waagRpxlhQYz8Og71wcMoUI1dJwbQCI6rrf2iHJqWUkKuKyZVGyUjR/UFNV5T2juQnrrmZZhb0MCvDRLIFut2ZtgDKLn0ODMpHvo2oy+pw0Joc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvR2lhUi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvR2lhUi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A86A1F000FF;
	Sat, 19 Sep 2026 20:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789848366;
	bh=x9+LAKuVfE3eAu+vOSDn/bpXV7AN6gohMRKlAeqvfvw=;
	h=From:To:Cc:Subject:Date;
	b=VvR2lhUiR3UsrNu0GxW1TRkp9bVSrvdqreAqwq57X1pfLAWUmm7VnySWl47+sNEg3
	 17AYA2hj9YnDby0mGFzsUj47b7ifzKL252elFHpHYHchLCDiSaRhrKhjZL5Z9TZT0I
	 pNKx49hSQZF7gWggn2Pz4CDNM7ahQrYaqrAWX1eDVw6XIug0I2cmwU7X465TCzI+Bd
	 HnfArbXp2YfS4xf+4S048dZ5LIi8qjiVQixXn/6z+vVOe3KxgusJcawVUyPPs+xq+r
	 7zWCKQtabwk0z6YlJD/7yepXeyOe0fkc0tGPr95JIJ8q4YeSn9b4ixAZ0a9yRdKrdQ
	 JsnjwwfkjLW9g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 6.6.y 0/3] mptcp: fix recent failed backports (20260919)
Date: Sat, 19 Sep 2026 22:05:55 +0200
Message-ID: <20260919200554.2005069-5-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=743; i=matttbe@kernel.org; h=from:subject; bh=En/SU8k23iBCkpXex1BZcCGp05+GIRDKeYizPNPVWTQ=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWvVbmaKhXu82o/HqlcPIE0217pUv7G+61cH+2zqk+2 T+vsSe6o5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCKvohn+Z9800Vr703Z+RP0D q9s/9h3N/h8XF7VqfWODAo+b4963Sxj+qbXwr167ZXK27t2w3vB6SUbhmR27a279COL3DNz4u3M JOwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

The following patches could not be applied without conflicts in this
tree:

- 2b0f561f21b2 ("mptcp: avoid unneeded actions on subflow reset")
- 42064de57fb8 ("mptcp: close race between scheduler and state change")
- f3ef03357396 ("mptcp: fix bad accounting in __mptcp_subflow_push_pending()")

Conflicts (if any) have been resolved, and documented in each patch.

Paolo Abeni (3):
  mptcp: avoid unneeded actions on subflow reset
  mptcp: close race between scheduler and state change
  mptcp: fix bad accounting in __mptcp_subflow_push_pending()

 net/mptcp/protocol.c | 13 ++++++++-----
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  | 11 +++++++++++
 3 files changed, 21 insertions(+), 6 deletions(-)

-- 
2.55.0

