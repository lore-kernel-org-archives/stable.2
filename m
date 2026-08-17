Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D763E073D;
	Mon, 17 Aug 2026 19:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786996450; cv=none; b=IyQeIMeusEJRY6cz2e34sMweBjj6Kkwl2offEFYaUkF/8/kZPwn6lYxiMaxr6qFzNhIDfKgnMxB31aHXLcs9QbP60KoI8SFBquru3FhoR/ZCMvqYgP3lKCzMVyS+MbwuE91MJw3cmo+aQ7ySN5mf/1GkxFVLz7pfLHepzoMXwtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786996450; c=relaxed/simple;
	bh=37S7RQ5LwNH9nlt1g5IvJLZ1k45TEnNmFes8Iyi3PQw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N1vbZLaHm4T1Ss34HkebgHJFAYNg8j+07h5Ezir3TBse60sF2pioKPn6SVQ96Brg9qPvXE3CavsgC70bGSVkhybhSbl3KpBgzAU5nio/iA1mu6cBmv2xmKuPjyyH2Sx6rCzfT1naYuX9BCaG60QZwovE0Y8wIIM3QLZyxuIinUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bo3QV26n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bo3QV26n"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DE82C2BCB3;
	Mon, 17 Aug 2026 19:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786996450;
	bh=37S7RQ5LwNH9nlt1g5IvJLZ1k45TEnNmFes8Iyi3PQw=;
	h=From:Subject:Date:To:Cc:From;
	b=bo3QV26nBDP1xc/B16Drz08jzpCJDfpnyNyhNOVFFhsjmKdfgS7LLVeYl8OcSMT5p
	 O6xthYXuuBZFKjQ91bZqfuXJI+gS3OBfKgzNg/oHFyAJsk3VXjNsuVtiVgrIiWmCR7
	 1RXOX6/hzn+dwovwl91euWLPLO/5C257ar1QyWhePHTU2evM0YjTc26lS4l5/zXrbm
	 loyjEnhGndF5KVbNaJPLamEHgLmGu7o0VcrhL0F9ZsSIo7vUhBIupntSMv6YPdsMzr
	 zATvxoAxKf5YzhOyJrKM0S7mez7H92QxF8svgSDjuN/sFhx3YX7L9lPc1L41nxQEMN
	 cFHyaGfOZdj1Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E07C5DF66;
	Mon, 17 Aug 2026 19:54:09 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Subject: [PATCH 0/5] thunderbolt: Fix DP tunnel teardown while an async
 DPRX read is running
Date: Mon, 17 Aug 2026 21:53:57 +0200
Message-Id: <20260817-b4-tbt-fixes-v1-0-eded2461f5fc@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqEMAyF4atI1hNoi5bqVWQWrUaNC5WmMwji3
 a26/Hj87wChyCTQFAdE+rPwumToTwHd5JeRkPtsMMpY5XSFocQUEg68k6A31tXaWaVtDznZIj1
 DLtrva/mFmbp0f8B5XvQhm2twAAAA
X-Change-ID: 20260815-b4-tbt-fixes-a2689186016d
To: Andreas Noever <andreas.noever@gmail.com>, 
 Mika Westerberg <westeri@kernel.org>, 
 Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: asahi@lists.linux.dev, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>, 
 Sven Peter <sven@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1361; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=37S7RQ5LwNH9nlt1g5IvJLZ1k45TEnNmFes8Iyi3PQw=;
 b=owGbwMvMwCXmIlirolUq95LxtFoSQ1Zz2q09k1njvE6qNuue5nc+kRwmxVC4+ulF9j0dIQ1iZ
 8/4Sod3lLIwiHExyIopsmzfb2/65OEbwaWbLr2HmcPKBDKEgYtTACaSacjwP/Lllg0CIgv9srxn
 TK9YIv323JkAxYCtexoivmq/4Jkn0MTwP9I/v7jpb8nDxwnpl3m226ju2t9V9uhh9TNVAR/tXVf
 6WAA=
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

Hi,

This series contains a bunch of fixes related to teardown while an async
DPRX read is running. I ran into some of these while bringing up the
Apple Silicon NHI and just haven't implemented DP tunneling support yet
such that the DPRX capabilities read can never complete and will always
time out. 

None of it is specific to that hardware though so I figured it
makes sense to already send them out.

Best,

Sven

Signed-off-by: Sven Peter <sven@kernel.org>
---
Sven Peter (5):
      thunderbolt: Fix tunnel reference leak when the DPRX work is not started
      thunderbolt: Hold a switch reference for each path hop
      thunderbolt: Fix domain reference leak when DPRX read is canceled
      thunderbolt: Don't access a DP tunnel after its DPRX read was canceled
      thunderbolt: Cancel the DPRX read when the domain is stopped

 drivers/thunderbolt/path.c   | 21 +++++++++++++++++++++
 drivers/thunderbolt/tb.c     | 23 +++++++++++++++++------
 drivers/thunderbolt/test.c   | 12 ++++++++++++
 drivers/thunderbolt/tunnel.c | 43 ++++++++++++++++++++++++++++++++-----------
 drivers/thunderbolt/tunnel.h |  1 +
 5 files changed, 83 insertions(+), 17 deletions(-)
---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260815-b4-tbt-fixes-a2689186016d

Best regards,
--  
Sven Peter <sven@kernel.org>


