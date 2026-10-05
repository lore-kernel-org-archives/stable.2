Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D6044AB9B
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791209441; cv=none; b=jZN/SG1MTjR09mtxbGf0CMsV2nT4I4/Kvi79pPSfL7qxA5hmXN7fvjDDCWrLJeWgJpANHjhZcOYnW21UeHcekM7e92CYzgEu45LM2ILBNnUaaGzlJ5GCJqXAwONCaeUOxocZUuV+Ijt0vuKKVHuuTjGlLu7TrzO+yxyxjjFG1RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791209441; c=relaxed/simple;
	bh=8DT50Ou2AOtvKGk9/nCApY8h5N9oTbvwNPEMR37piPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZM5yyFAqiJnwVAlo1IB2QuyQTCkOHyUBVTcWn/YB9Pvb+cu6fBl29Ao9ClFtvECg7DWUuZ/nGZsVAHNyPk8TBa2zJea1/PFlsmw84hMFDbwWhkCzptfVZhauswPOwHfEG2qv4VGObHyrHMSwNZxrGWPhSZNG7+RV0eOCHrFpR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOvVo0sH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOvVo0sH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6161F000FF;
	Mon,  5 Oct 2026 14:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791209439;
	bh=SBmefpHW0ukAen0Iy4lgUwmExRG1C/Wm4LqDtjheVAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gOvVo0sHVFuhftNzooeJQ+MecVAcfik58ZvOHUft6T02iC3ZATj8eNZz8AAmQSgVb
	 io88xdu6TmYZgMG9bLH5ZeYQzSmBIZ6xEFNNP7x/I556x06X6/QCzBX732h1OafdXA
	 YGP5Zdg9FGD0MKqk1IY4KbfI9XQYJGVx5bW1suDDkQbRGcKUAsz/UsVAQN7RHx7nPT
	 3IcJse9FgXcuvPUaYQJJ7hP7JzbiEpyJjOtyvbAiNgq1AUH1RlWIOyoGQM3ADTDwOi
	 1MHPTh/Nzy1NaaTKKMqTLFE0PoJSpZ3uvAVXOfEW4NxGY3cFDDkO82gRS0NwEf0sAv
	 wXvPwX7HzvQJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Orgad Shaneh <orgads@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] usb: octeon-hcd: fix the FIFO-flush timeout computation
Date: Mon,  5 Oct 2026 10:10:36 -0400
Message-ID: <20261005141009.3003096-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100527-aloof-resort-fe25@gregkh>
References: <2026100527-aloof-resort-fe25@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Orgad Shaneh <orgads@gmail.com>

[ Upstream commit 4c7a1b9f1f1979f2b3b69428ada12680695159c2 ]

cvmx_wait_tx_rx() computes its 100us deadline from
(u64)octeon_get_clock_rate - the address of the function, not its
return value; the parentheses have been missing since the
CVMX_WAIT_FOR_FIELD32 macro became a function. The cast makes it
compile silently, and the resulting deadline is effectively infinite.

On a healthy controller the flush bit clears on the first read and
nothing is noticed. On a controller whose PHY did not come up (for
example when the reference-clock configuration is wrong for the board),
txfflsh/rxfflsh never clear and probe spins forever in __delay() -
observed as a hard hang with a soft-lockup splat on a CN5020 board,
where the board watchdog then resets the system with no console output.

Call the function, restoring the 100us timeout the code always
intended.

Fixes: 3e195a80e096 ("Staging: octeon-usb: Replaces CVMX_WAIT_FOR_FIELD32 macro with a function")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Orgad Shaneh <orgads@gmail.com>
Link: https://patch.msgid.link/20260901193100.1352110-1-orgads@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/octeon-usb/octeon-hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index e2f8b6b67f75e..10dcc9b8072e8 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -576,7 +576,7 @@ static int cvmx_wait_tx_rx(struct octeon_hcd *usb, int fflsh_type)
 	int result;
 	u64 address = CVMX_USBCX_GRSTCTL(usb->index);
 	u64 done = cvmx_get_cycle() + 100 *
-		   (u64)octeon_get_clock_rate / 1000000;
+		   (u64)octeon_get_clock_rate() / 1000000;
 	union cvmx_usbcx_grstctl c;
 
 	while (1) {
-- 
2.53.0

