Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA36497B66
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791209022; cv=none; b=DZTaxfFI3BYyXWLzj4iSnhREv2RmS8fPRflFFF3cp5AtZxfzHKmBZ9Y21ERyu6GLIm1dJMxBehPfpOHcAeWy5+pkB/54vU+opZK5gbVADowrVee78sb0rKFlHN+NH6tzjMM6+mk+7XXLqVFTENGvQFHg3jmQR7S75SqJO8MVGIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791209022; c=relaxed/simple;
	bh=ThtFfkiAs5oo0Pkft2jlDhF5vLEjthoX88xHJfyJ9P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTq3KoUIkQG2ZT9Bq8NwoKXkllRcTHfXn1m2t1uCCAgyYOpro4eJvXCbIK89hk27WoP7ftzl8nES8qVBUshXOP+yY/ZBjVDphKXbq7IlXjdIQwrPa97JOJNHw0rzrft1Rndn314oVBnT+yoDRlEmG+vpEm2j4MSzy0JGoAQnhNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yc8ShETS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yc8ShETS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E9C1F000FF;
	Mon,  5 Oct 2026 14:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791209020;
	bh=4BZIqloR7jg6qSr1Mjjpspk6kytQApPH5AF5pV7I7g4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yc8ShETSmjrg/ZpugltEBJ0xcZRAv8aI7uLovRs0JyNpKxfQZ7CLe+1EhIRLRXJ3I
	 GHJ9ZFOWT+a+QWU9qpA2v86BwJYRRCjTk02r7GD3DwdlslMFuwRw7FXUc7XkeLzIxo
	 FcLmjfZWNVNaWuJEwVp6AEArTh7Uah+D0jnrYJ3h+R6J47JxR2uW4EWe8Pw6dTpQMN
	 v0oLi9UAxeoHWh70kuXncXeXVzvpf18eyQt/4pDpyAW7Pi8Je0TfTgO38kxq4u9S3s
	 wSEhmyq/K5936s5QYbbthWO2PSuo8QinumGceIiVelqBm25jmxe0wjzA+vKd702gP0
	 vPe3NxWNZcPcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Orgad Shaneh <orgads@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] usb: octeon-hcd: fix the FIFO-flush timeout computation
Date: Mon,  5 Oct 2026 10:03:37 -0400
Message-ID: <20261005140323.2988609-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100526-seizing-camping-01bc@gregkh>
References: <2026100526-seizing-camping-01bc@gregkh>
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
index a1cd81d4a1144..16fb72eb3d185 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -578,7 +578,7 @@ static int cvmx_wait_tx_rx(struct octeon_hcd *usb, int fflsh_type)
 	int result;
 	u64 address = CVMX_USBCX_GRSTCTL(usb->index);
 	u64 done = cvmx_get_cycle() + 100 *
-		   (u64)octeon_get_clock_rate / 1000000;
+		   (u64)octeon_get_clock_rate() / 1000000;
 	union cvmx_usbcx_grstctl c;
 
 	while (1) {
-- 
2.53.0

