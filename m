Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050534;
	b=1NLXKcxs4LDjy1xFgNJ6cGNJEYVlzUXkVc0/rWcScmOrWV8arRv7InNLVtWyFLSE8LcX
	 bHUpjrVL954chYPm3c418+ttAt5V99wDUbWAW858krjT+obPGmpMaNLx+LMUILagG+V4G
	 PmR3ZfQxf3VTJMAjg7qqeIZFsQBkjh62M3EReu06LFd9/Ufddp4QCOeeywurbZ5hQVvg0
	 4/6TQE1jhTGIIE5Rv49822n6+8z1XVPIwl9WVY3ASkK1cOQjuK9b1H5Zj8uceLWp/7aJS
	 /brkVmKj7ur9A3e6XAkjgRsAJiJzwgfOsfvDZA1twlqEM4A2u9xBziuwpdBDlUqGvtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050534;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7UdP9tXls7NGKAZbpo5Ti/Nl3MVlFZ7SphUPpZR4+bM=;
	b=zAvprKy17MtxcBP977jTH62pBszz/LY3T0zYJSCf/j6Dh6X12Lp+URc0DFuDNjGHBPB9
	 hWFyM7oFl5uALOKGqphHOisxp4jI9aHS13p0JdY6dcrcQCuu2iwn7Z+KhdcP4KFzF+TYM
	 kZFHiXo6M2GUQik2YIQtzt9AQh8IdkbXMZ7ylnDOeZ4nlt6qw0/N7TNtcEo0x2C41Tw2s
	 T4hy/fUCcmg6ztoLQRRL3fzbznHaGGreQ/HgzJXhR2adbpxHZy4umq6r10gjnHYVhKtEp
	 ZiQMttyuFGKGwY+lzeTND9MBw0CsOV5RfT0U/2AyKM+T8AEYImaUHs6rcuWMGyVCdKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kwHNBaAu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECFE606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kwHNBaAu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C961F0089F;
	Sat,  7 Nov 2026 11:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050533;
	bh=7UdP9tXls7NGKAZbpo5Ti/Nl3MVlFZ7SphUPpZR4+bM=;
	h=From:To:Cc:Subject:Date;
	b=kwHNBaAu7aenE6atAeJpAm2Ar/GktGN56YjPWEUqDpueIzcIwhRla6LKC7d9GM8K1
	 jFGWRFb3g13mfJIt1iJr4NcNP9IwHXWqgC/0Nzl2kk0vbtDZ07KxO/US3teUeNaknF
	 sD3HoFmxeyKd8Fr4EyNC4MEmW+Epe//giN9Acv2pPoJilEmE8vRm62WkFilOUWtSbF
	 cQUv+ioMNa0WjfsiM6SRJ5Hoq8jgdfz2i86xe5txfWdth0AyKouu1OW5Pa4Ccl+wkq
	 EehZvwCYRVjhc7AuJmPYRQlpd0GW/2PIL8K+pLg25d8axrZhm248oqGIWPaySpH8HP
	 Y/HURaW8Xv21g==
From: Sasha Levin <sashal@kernel.org>
To: hvilleneuve@dimonoff.com,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: declare MCR and IER as volatile registers" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:22:11 -0500
Message-ID: <20261107062211-failed-5.10-1c41d09dcd07@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1c41d09dcd07ee9648e20aa8238e404c2e6a12fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062211-failed-5.10-1c41d09dcd07@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




