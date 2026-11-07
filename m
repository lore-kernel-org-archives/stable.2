Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048482;
	b=DwCFpwtu3Vzb1FT++InktxTYmQ6jUuj270T1N0xIja9cvHbe2KPf5EK5p4140SaDIMQb
	 HxbEXBB2S9nQ7oD0G5+DOTzR8zXtRBscORHPTS6LBEIufCbG1cRC+v+MWzzhB07vsEgUm
	 v3js+pCkCn5EwNzmXWHqGhjxSnX1kR3x/1U8M/jYUszpmZ0I9qCRMxalA5kOWMBoIWhl9
	 uN7OKBKiAVsvA5ya24MxcSOlGeHNspNKrgXt9zWW78xreE85qBxRwr0/ZuQgrO2BHD16e
	 FheMRMR7sTa7wLc9EYLclUozOEmM/YQNg2AlvNii182ubu0HGCGY/MVFa52xDZtnQag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048482;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=G1nDflEIDsTd/wLjFuIGuemEaih67siaMR7NNbYeWNk=;
	b=kjLO7ayxyzq12jbZn5dxhOgntlq3Esf2OS6WopD3HlghCTAoRWZsY58X2+1GMJ73f/Ru
	 W7nkV8xXRO3zT56FBdEDk9WUvr8D2S6YSkkDlTimMGNgT2HG/SGSNd9lpJ1cYjQmCUddZ
	 wRglqJXa2yBhMHAn0mMMRZGQcyU29mFHwIQy8jH/X0GXh6LDsIVgyRFBDRctupN+uypge
	 v+V/kGt41gUWZEUCcFN4DwZPkOU7qe8Kbz41IOZSbOvnEcvPSXo1ng8FxXieQ3a16Tj8G
	 fkX3LFzVRCkXBFirC7f8IPcC+r4eWduDH9yN0Zg+aDy0NcOFBSoo47Gir928iCKp1Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="X0fZ1/Cp";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C47606A33D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X0fZ1/Cp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2151F0089F;
	Sat,  7 Nov 2026 10:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048481;
	bh=G1nDflEIDsTd/wLjFuIGuemEaih67siaMR7NNbYeWNk=;
	h=From:To:Cc:Subject:Date;
	b=X0fZ1/Cpq83ddFfcWyW5ZBoNsMR0TTqARkOy8QBDU8aDjPR3zQu4LA7jx9KgZMWU3
	 5++Dv71LV4+3gRiLs1aWrcv+jF7JQhP8ctQpYwgkOujOMYkxpX3zgCnnfbiIZtXNPF
	 /kxTLTyNLf1Lr1qTvJtrcXoS/s84JvLx9UhyGcV2O9At+pW2J61ypIDtxMxzJOwKtC
	 jZ67vOx3dFLMdPbZBE+nQerBAcaktK/k3eIx9RD03yAoMdmlsELJgN1YkS6+k+R+0d
	 T2wjxdHWu+ghTOYd3z2ePiUtpcY7xyqfav89/d/oMzsvyRBAeuJwLpPgVnZaPWVmPU
	 v659n6YbHxDgQ==
From: Sasha Levin <sashal@kernel.org>
To: hvilleneuve@dimonoff.com,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: declare MCR and IER as volatile registers" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:47:59 -0500
Message-ID: <20261107054759-failed-6.1-1c41d09dcd07@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1c41d09dcd07ee9648e20aa8238e404c2e6a12fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054759-failed-6.1-1c41d09dcd07@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




