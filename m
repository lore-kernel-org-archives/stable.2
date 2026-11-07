Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047662;
	b=HbdW0pKJqFoCHkZQwQfLxHPIEF2NmByL8o0jTNSQRNr3x5NtZ+wa3m7luCvLkmuV1Dc6
	 Q/KIrE/2+OACmQKjjnimi8c/7i5R+zk5bNIRnhtsz/NEQgeUUEWQxlaYo/7xL209kBlnj
	 b42GLrZutoVfbsY+Le6VISUsR8ATCfFLVYFdEJQkOExOD1I/NAeiHdp6MNystsB7sqHNS
	 ypJ6QgPr3LRQNcRjAoyMPzjPqXoiEkBZBwvoTOWMNPC/WcBNMqLM5oMnicw4qVNbpiP+o
	 ZI5JChNhHbwcw0bXgQe5oWSVvhFasI/2pwMOZVvqVjeXy/iaYsA62kYNKxcB4c40V2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047662;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3JZssPyYtBs4j2FbeLwuKrinHnV302TPfSq83x47Ctw=;
	b=KbnI0cHVgAHSMOFN51s/mUHLmjMe80O2i6uLPoRgDgrPPCvLECC/qj7OtNQGnBMUX9Vn
	 s//ky4tLVc/nu8q0TpADv6PowjQG4BzkN7rFHmUnpuhipFo7lwqbn1yjqKbbmCGV3fMqI
	 gJwYyjeTDHpIXN+Hl7ewwMw8Ucqa/iFeou1caDN3T/la0lQwAgaEGIC4EVNk9AFdWN9JO
	 lJK15ZJgLu/zXWGuxBiAlyXCxNzot03o3+LOiBdjz7a/3wOla6L2iaR8uQ3x53brodfLn
	 cs4Xph1zNxioybiH3eYYY7NMjhzaV8K7ank4NtBoHh83jPAQq+br+0JCIzSFOAsADKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fJ6W6dKI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D7A606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fJ6W6dKI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2401F0089F;
	Sat,  7 Nov 2026 10:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047661;
	bh=3JZssPyYtBs4j2FbeLwuKrinHnV302TPfSq83x47Ctw=;
	h=From:To:Cc:Subject:Date;
	b=fJ6W6dKII5xYsHgOgvkksRYnFv3luRwibJ7gcoHfKw6HcrH8pmrLoBEycfKoH/eE9
	 HblXreMMVTBPUwzf+jBDiYUmlHOeIbRtJOwBK7KqxOAbz8n9B0wrIMFEHs5q0lipwX
	 6+M4ZiwqOYOEfZ51GtOEQGtFWeppfOHGEZQ6wc9demEzLvegNesu8s66T9ISRRfp4W
	 1HCfLlb2Wv89K5NNwOZx21OWVvhZfbE+gwWqQs/3TCYNCYWVEI6z473bW7zrWaa6XN
	 7axpGa7MNOHSFt6iE3MznfCcpY+1njDk+L6GAO5FeT/WRdV4rvyacmraiyWTgzOcfA
	 r4dOs80JN6MAA==
From: Sasha Levin <sashal@kernel.org>
To: hvilleneuve@dimonoff.com,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: declare MCR and IER as volatile registers" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:34:20 -0500
Message-ID: <20261107053420-failed-6.6-1c41d09dcd07@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1c41d09dcd07ee9648e20aa8238e404c2e6a12fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053420-failed-6.6-1c41d09dcd07@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




