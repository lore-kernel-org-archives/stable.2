Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046260;
	b=pNLB9FbuLcUSgnQXBDjOycPLK6UhV9bR8szPL1oJ3GvWgZ58yrnq6y6WM9FpNfgr+6EX
	 Tjio31gwYMZ1eX50gQ8W8wJVxCPLBIY3VnYtd6APa7jhkfJppfvzzYQqvmUgIdOtyyAde
	 zctZu83VA+kYBwh2GGh2A9yMLAT+4xtWKlYVeQGngRckqyjLTkR4s4j7NcDEYP2QRG1a4
	 xhZgc/g/+h1smkygJErme3PHqf9t38L2ALKTkk9bXFrZzk+4/yym0OpIveeGyxT2tB7Vu
	 +H53H148p5efYv7QLJfaV/emYopjE2O7GyORk19Snr+gu+Aj8kPoN6QOyMQ7+jrlZ0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046260;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Z2uZS2rLn6YHpuH02R1AGL2VQefZ/SJ149nymj41owA=;
	b=MTViFDPJZ0HbrXqAeYm1ijbsTliLj9yU/L45ziDnpFv+0koVYK/khvKoLikoTbOMY/co
	 9P3WLpmlVDmXsj7HH8FM05zg0uUYmu27AjJG9SH+8rEnUYtvPPPSUD3SQ9W8XP6kt2QZu
	 GuDIcX+MVhccqbuVwzW5mZ8bGxi2vpPhDL1PlMb3YixSzBg2zQSVqZOPpKBKObEs4VZD9
	 HAdHnhn3NqfAUg0x3orBTVay9eBXOenCspEWkr1M8aXdqZjW/viZV+HoXM4zGqOlUUikF
	 nHjenlUEwgqpZZU7MWeCAIDdv9rjr6QPkazoj18UEtJ0a+7DQohzMYeT3nl8ZhRr1fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j4Yi+9LB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9BA606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j4Yi+9LB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957CE1F0089F;
	Sat,  7 Nov 2026 10:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046260;
	bh=Z2uZS2rLn6YHpuH02R1AGL2VQefZ/SJ149nymj41owA=;
	h=From:To:Cc:Subject:Date;
	b=j4Yi+9LBJQ3HlUwR3wTDJEVHh6CrITmZqkn24MhY3JSqRG/2h4NLDkAMTa5qV2ouH
	 QKJ2gVUEuXoFJE11cp1zBNNqX1wS00npBF7Ze7iUT9vG2u0aAw8je7v3SsG9yh/qq/
	 cu/1/t3Dzkk+JzckkYnafuFO1rBrzZ2Y2LfrpnCzkqKNwSchGQKXDFJ32SLBYXbCZv
	 C1loSEC1wWdffLBuL9hc3Lrv5/CqztOrEWyb1/di+M/HHLXQEyd6NI9s7abIjzRAw+
	 rmpSfix6ws8C8uoQRgZsK5BPdWdQvqUVL8SqE8NCtaewl4n78Pf4efUp/hn2SBs0Ve
	 IkZ02FyWBx8wQ==
From: Sasha Levin <sashal@kernel.org>
To: hvilleneuve@dimonoff.com,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: declare MCR and IER as volatile registers" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:10:58 -0500
Message-ID: <20261107051058-failed-6.18-1c41d09dcd07@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 1c41d09dcd07ee9648e20aa8238e404c2e6a12fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051058-failed-6.18-1c41d09dcd07@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




