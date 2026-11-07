Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046920;
	b=orF+nbEaGc1QDYZzy9tmZlARVPiS769Bji+eMocWj8Io/gVPLeLgRDyHwBNRXQqOTUH7
	 HWb2upIt2//wYEuut1sSmtddIbKFZGN+pLJblr4fvIUMZ1DPpxEY1NXK00O5t1ChaTyvt
	 BVbxpMB182aAfDF8fZnD+PGqyGVK/jI5lIiVfuZqJr8yGB7pUHiynqOK9ampds4F6OGS3
	 Lt6r4GGUGmWdFqmGVSfw/YlmX4qXEDaR2kygQSehN7fkuRsqixRQ1CpaCsLqe/9Bsi8BJ
	 CF03yPUbzbJr7xg/pHp3K0OSsgQDHS/wxQ22r60QJ++goYzbXbDmew0/tbCu3MxErnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046920;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xK/NFpnQQD+1N7oUM5bzOvr8nVulzlTXISrc0YHFU0U=;
	b=jdl4RITXJTjMsCh2Qa3OKR9EisqWUO7vaUUhimAdTZNWtaXZG1e7Dtfzp+Wo4Ouc3L+i
	 aIwDI0hP9pFi1A6zhFi90DLLaakya1247WNUAc/i2FaT1pCnzix3CpOJLlnVei3FXhshi
	 ka5fVcFmv26T/uxjoRvTkHRx92j0UcmkCSbLAWsMSWzxrsi1WNW7ge48Kdvyp6/PEFZu0
	 q+XlAwDWyyNl/X7CkscY3UZVx+buI1PE+sV7RDjKocCCAVNMMGj2krwgGlUW2y/VBslbH
	 oWYegwetHh66fMHtyaMJXEfM6cEr5vyT2FeHU9+6o7I1XAenED7YLdmeqfdFolNfiGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nykO2ilx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F91606EEA8
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nykO2ilx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D87D1F0089F;
	Sat,  7 Nov 2026 10:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046919;
	bh=xK/NFpnQQD+1N7oUM5bzOvr8nVulzlTXISrc0YHFU0U=;
	h=From:To:Cc:Subject:Date;
	b=nykO2ilxUqnuQcOzvPXh9mLHDbUDk2HGp8BNHLWin0jVaHpxCKT2sf14C2DbIpTvX
	 MotU0ky3BzbhM6yQfRbWGblty/7RaCpk3MAmPQp8i5elqMsDCru4YChgrvE+BAZczk
	 5XrXlb5bz/P+BNwmeKJ+e49cQCC3wAQ+U6d2LB5sN9mHCgCMCKahOymof9qj8f7XfR
	 YxShlHAJG9XH6udd6qVOwpxIIKRseNyFkbvYngvoSsvWTTnsoH6+LKukukFEwzgyOi
	 El7009+3a5qt5QkMi0dwQ1FqyN0cnfNEYK91n+1m7w/sRbNuGYk3mTblwcCx+KJrZs
	 HhklGiHjrK20w==
From: Sasha Levin <sashal@kernel.org>
To: hvilleneuve@dimonoff.com,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: declare MCR and IER as volatile registers" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:21:58 -0500
Message-ID: <20261107052158-failed-6.12-1c41d09dcd07@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 1c41d09dcd07ee9648e20aa8238e404c2e6a12fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052158-failed-6.12-1c41d09dcd07@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1c41d09dcd07ee9648e20aa8238e404c2e6a12fb Mon Sep 17 00:00:00 2001
From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Tue, 6 Oct 2026 15:25:37 -0400
Subject: [PATCH] serial: sc16is7xx: declare MCR and IER as volatile registers

MCR register has the same address as XON1 register.
IER register has the same address as DLH register.

Which register is accessed depends on bits configuration in some
other registers.

To prevent potential access errors, declare MCR and IER as volatile
registers.

Fixes: dfeae619d781 ("serial: sc16is7xx")
Cc: stable@kernel.org
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://patch.msgid.link/20261006192540.234402-1-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sc16is7xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 7ddc8a38adab4..fba5885595957 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -501,7 +501,9 @@ static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case SC16IS7XX_RHR_REG: /* Shared address space with THR & DLL */
+	case SC16IS7XX_IER_REG: /* Shared address space with DLH */
 	case SC16IS7XX_IIR_REG: /* Shared address space with FCR & EFR */
+	case SC16IS7XX_MCR_REG: /* Shared address space with XON1 */
 	case SC16IS7XX_LSR_REG: /* Shared address space with XON2 */
 	case SC16IS7XX_MSR_REG: /* Shared address space with TCR & XOFF1 */
 	case SC16IS7XX_SPR_REG: /* Shared address space with TLR & XOFF2 */
-- 
2.53.0




