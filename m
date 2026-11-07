Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049520;
	b=oBKqyXwmejoept1ibNi09usxqcjAFCO81pNw3IoZQnXsrl94m+JsHZoaPjgFZQNoYT9V
	 5QgA9Eudbq8PYism0IQWcvqR+x8M6QYy3eHI3Xs/+/2XjvHe1YSW4wcZTpv0d1L8IRJXR
	 nwvd9EWvb4EEwPPbPOpNnv9iGcxLzG+MHbhT8wDVQiJYa3CFXcKvMWzB04dY95+GqAHQS
	 kBtGJyxKqIOC53fzPDRJY9lq3k6wVlcQOnmSDbl785Ur6ZWjcUHtfFyiqRxEoIEQ0orPD
	 j1CCYAiFXovDXFFR2Vb5BMPU/GJos8+psGfb3V6d7OpImVgH4aErlHK2AotEzLLEZ8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049520;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+8eXRpCT7V3hF+T+UT21ylD+n5T2jHL4FdpNhdCkScg=;
	b=etiVoNSb7v5RQ4ukdAfcnOz/6Qe57wGQthujtEMme4ASeMhoX4vSkq6vARVfQF5thi/b
	 vwXFFJlI+0MZ/K8ghBmHri3GUV6XXZ6XeJmGYYdmovQ6Q9Un3pESYtYQRjfjlFmRsysXX
	 Y+5N7pRmQj7+IAV78DBS4XKW3zHVv/2/uC/GsdE5aEASGsV1iaN5GuDjpo5d3w8rfDXmD
	 auqtUFDa/eIBGIp1hrrUpoD+9CLaHqif+LfOjmP5RILc7nze4gWo1TnyIQJFRwfLjlHmm
	 EtVv6MtkWum/2cqqepq3eWVb76j1ivMwt+u5LlC6rmWdSR6EK6BFFBNrq29ZQJ2H9YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LR1Yu5nL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBF0606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LR1Yu5nL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFEA1F0089F;
	Sat,  7 Nov 2026 11:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049520;
	bh=+8eXRpCT7V3hF+T+UT21ylD+n5T2jHL4FdpNhdCkScg=;
	h=From:To:Cc:Subject:Date;
	b=LR1Yu5nLbIraHvlN/rUEE762GJYaVAOEafqilToR/yZPuvav4ePdwpPTpfCLfQkot
	 o5GwEUdvXnTWG3SC6740oSoKACReKFFxeLgJlKie+CXWSTeZHBfmn/u1dyyaZDdyRx
	 XnkpK5xZRu2mbdzzKMOi56pTVDo05RF5DluFaEDWkeXs2lg8xE5xDl2UUytqodctA4
	 CEUQ466MSsEZvrHLHmhZp16LlnFqouubrgDhgOr1Bx4Bfis96XXI20JaW69liAwgZe
	 WBwu9V9Twjo2n3solunSASzFHYb/lMTBpOV7XHbZiDAoMnzvQkWCajt79Beecu3D/X
	 vb7XEpdzlI2cQ==
From: Sasha Levin <sashal@kernel.org>
To: hvilleneuve@dimonoff.com,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: declare MCR and IER as volatile registers" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:05:18 -0500
Message-ID: <20261107060518-failed-5.15-1c41d09dcd07@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1c41d09dcd07ee9648e20aa8238e404c2e6a12fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060518-failed-5.15-1c41d09dcd07@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




