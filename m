Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622ED4D2EDE;
	Tue, 15 Sep 2026 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789504670; cv=none; b=HO/GvCKdm8nkHbobMnhiAV/CoEnOghAGhlFaUXjFkkBPZNuNoiGp3uOqpCfO264s4YnCb5nrHM0Tc4YK9/Or+c8aIQMeSkwCanPd7bwS1YIKRXuN1zS3H9UfOKeoI4rJHNVZrRIudgeqr2E/U4m4rCkqhpO7GI3fozKuVPhMsh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789504670; c=relaxed/simple;
	bh=TXJmlCK0EV2Vvj7yWZlMK7Wz0K2fRLgslx3tBBCih18=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DW0lehODyl9kFulZ+TrGXtgPG//BmCuT9wUsiiyL9zSltpdx3o1gKCpsPBWRGQEQxiNqZb+B9eiakV8s2L7Iu9vwVtkkN0TONfEX8EYoPobSKo/kONvs9SPYgoYJ/5tgkZS8LINQeKi+/TkS1KfDMnm6wm0mOaaiZ8onKvILlRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVRZg1om; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVRZg1om"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E171F000FF;
	Tue, 15 Sep 2026 20:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789504664;
	bh=kiNjMCC01tqU55p+3+10vGf6AnbxDnpzENdDXyoyans=;
	h=From:Subject:Date:To:Cc;
	b=EVRZg1om6kKHZC+Y2f2t4NXA/LZKlku7rZbd+qpQN5tKhVCjD/1njAr9goXyv32h2
	 uejQq4ZcqT1WfsnVGM3UdYMAXyVPYKZNdUOZlWKKQumeRrGIHmmPO4l0YKsnL6oP74
	 DYsfSevcLwq9V/5spFkPFlAQtv5nSavha03VGP4idNGoFe3fnk4VrlccrirsZ74Zmn
	 imBHkN2WpzYn8ew3R79msSuY1GU9OFEoog97SL7/HZnPMb+BcProvIP7TuHcx9P1sr
	 npsO3mB6Z3Y+kxUGlqfdl99svvyAgCi5/gQeL9RlpLVIPUv6W/iajar+kt8zblV5cH
	 kyhkQIUwYHaaw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/2] mptcp: misc fixes for v7.3-rc4
Date: Tue, 15 Sep 2026 22:37:31 +0200
Message-Id: <20260915-net-mptcp-misc-fixes-7-3-rc4-v1-0-a257797dd5d0@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMSw7CMAwFr1J5jaX0G8pVKhbUdYuRGqI4IKSqd
 8fQ5Ty9mQ2Uk7DCpdgg8VtUnsGgPBVA91tYGGUyhspVnevLFgNnXGOmiKso4SwfVvRYY6IG2/o
 89pNnco0HS8TE/4MVBjATrseor/HBlH9h2Pcv8qs06IUAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=841; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=TXJmlCK0EV2Vvj7yWZlMK7Wz0K2fRLgslx3tBBCih18=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJWrpnCmWUdHjr/VMH8p3/ERB5s/frjdhZD7mrXZT+jm
 Dt/e3916ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZhIqw0jw8u7D0r/zbxq9/2f
 ypqomOs15k2nl69U+7g1YbNrdohXBSPDL+ZVpZ9+5eT4vPy+pPwv58klMrNPh73w0raddHLGAot
 j2qwA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are two unrelated fixes:

- Patch 1: avoid unneeded actions on subflow reset. A fix for another
  fix introduced in v6.12 and targeting a commit from v5.7.

- Patch 2: close a possible race when scheduling a closing path. A fix
  for another fix introduced in v6.0 and targeting v5.10.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Paolo Abeni (2):
      mptcp: avoid unneeded actions on subflow reset
      mptcp: close race between scheduler and state change

 net/mptcp/protocol.c | 4 +++-
 net/mptcp/protocol.h | 3 ++-
 net/mptcp/subflow.c  | 8 ++++++++
 3 files changed, 13 insertions(+), 2 deletions(-)
---
base-commit: 83a945a529d6e002dd7339c532288a931f463dba
change-id: 20260915-net-mptcp-misc-fixes-7-3-rc4-538b9d7ec047

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

