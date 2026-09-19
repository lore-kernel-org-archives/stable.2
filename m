Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEE83911C5;
	Sat, 19 Sep 2026 19:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789847815; cv=none; b=JFnhLH4aApTTo8R5nBdjDfyxttq/ybbEIXUO65cwCIQyYgKC62Xc9D5Ilqjkjx/bhoqFoZWaGWUGX31JJLxGKP4ni8Vws6IBvuWNvmNHW8WEJ3VhIRtRCRD2BQr1uUIH9DMUhhJKmtyDsvdrCf9Yj+9xM5rT1WAxzD9zm/kNApo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789847815; c=relaxed/simple;
	bh=IEJ2woQmIndnetggWUpo2zcdwLKORzGb6bIt9go2d+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LVFvbOhKVGyJRT+xTMlpvl14B9/5dxaPurNLc9uVR3qehmAW/g4tOwSyJLM2kitt4VUQkV5ReGYRljItKrEZbClnpf0KvFdcgyQidmQ9QZHJjb7SSBhfDnqGKRUdGxfgbMJ1/R/ivjjewP7OIVC6F5S934+GfpWBKdCZBi9DMpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9nNH7Qy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9nNH7Qy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B791F000FF;
	Sat, 19 Sep 2026 19:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789847812;
	bh=bN4AKkK4gSL4NVZjh42YD1Xq+r0MTfFa/iNSock8/XM=;
	h=From:To:Cc:Subject:Date;
	b=M9nNH7QyoeUdcVQ+Kz+ivZ+b/901qIi0I5AlZdeYrnx23xagYi9vVsxgpt+xouiuZ
	 8UwzoGaVtIE9bBbAKd20lQXc7RZDi7O/LeI/eDG9XEK/vH5DC8VJ/pQjN8/2Z3l6Ys
	 fy7Y5h1FtEerHwbxlD0IhlvCBFtUR4v4bE72W3dSZHWBinyt5bQS/rzRQYCoViPCjS
	 ZBKV+FJQZjAodfwhlUzdl0e1cEVFdRRYD1uFahG9QVTtIyxEIV8o0IF25naZWJS9Mq
	 FLmjSnGLyH81H5vZkY9r0/NxItN9gw5NKX7CXrDxCCzNcaE8UDbH1gA3nVLXjF9utR
	 RRFecU5M1AE1Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 6.12.y 0/5] mptcp: fix recent failed backports (20260919)
Date: Sat, 19 Sep 2026 21:56:43 +0200
Message-ID: <20260919195642.1977885-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1078; i=matttbe@kernel.org; h=from:subject; bh=IEJ2woQmIndnetggWUpo2zcdwLKORzGb6bIt9go2d+k=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWvfi9Ittx/W+35C4lk8//rnKtsbhlu0hdQ7e4zEesx SJW8gt3RykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwETumDL8L2RWtG/MfrRqwsqc pNauj5ejeFj6lvqcUglm+XOBK03UluF/4tr2nRZrzytWHypvk717I2TWda+U5kltvmGC9U5+e+Q 4AA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

The following patches could not be applied without conflicts in this
tree:

- 2b0f561f21b2 ("mptcp: avoid unneeded actions on subflow reset")
- 42064de57fb8 ("mptcp: close race between scheduler and state change")
- f3ef03357396 ("mptcp: fix bad accounting in __mptcp_subflow_push_pending()")

I backported the following commits to avoid conflicts:

- 581c8cbfa934 ("mptcp: annotate data-races around subflow->fully_established")
- caa4a79f74f3 ("mptcp: remove unneeded READ_ONCE() annotation")

Conflicts (if any) have been resolved, and documented in each patch.

Gang Yan (1):
  mptcp: annotate data-races around subflow->fully_established

Paolo Abeni (4):
  mptcp: remove unneeded READ_ONCE() annotation
  mptcp: avoid unneeded actions on subflow reset
  mptcp: close race between scheduler and state change
  mptcp: fix bad accounting in __mptcp_subflow_push_pending()

 net/mptcp/protocol.c | 13 ++++++++-----
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  | 11 +++++++++++
 3 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.55.0

