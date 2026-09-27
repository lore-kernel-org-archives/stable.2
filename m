Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5FB283FC4;
	Sun, 27 Sep 2026 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790506579; cv=none; b=koN8Er+BR2vRe6CZHfTMYBxCnVW+b3P1wAJyHykEFhwDu2jW4KNBzynIXeDjMji/+NEuulIW4kQqqWfGacE5RPLcQzLlg9VKbfpE5I0J6fAKZmBI5z4BwBwWg+CJAcOmINOczCPsT6fNjfz7aAdnYGPFtsJeYRgZ9f7r18NAyEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790506579; c=relaxed/simple;
	bh=oJwSkogOlCkJEX2M9qOFXIHtwxo4wSLRSS7i/KL9jd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GeM+xBMgdvlgGy+8xTPibwxM+RfpVZYQEi45Yyz2YuAq9volL2ggXAHYcaCd876AVCa0JxMiKFQ+bIeXDkDvqatqliKzNXGwYFJX17B2RGFu1rB5UXpXaQysQJi8Qz0FXMuBo2tuQCBrbN3Ev7MG0ckkiaaRQKN7pKGztncYHRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YV6Eu9sg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YV6Eu9sg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19311F000FF;
	Sun, 27 Sep 2026 10:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790506578;
	bh=RzTxqTERssXjW8NhJ6TLxPG/Cn30rU660hyaG9qd1jU=;
	h=From:To:Cc:Subject:Date;
	b=YV6Eu9sgzaJA9BxW42PCheqct8VA3Ct7FxaYz0TZjqqj1Cw7MtBNjeELA/IuHlwfG
	 QP0VlX2LgN3u6S4p0QMJdYFbjTL3Jqf45Yq3XvVlTgAQlY2ATRaim4cWYup7K6Typf
	 bHrd13aVEiEfWEQjlZ+cOYJwjLg5cW7ZauZMiE+b4itMFz1NsJOHUSl2FjrqNDi4Xt
	 fKLRhmxkNHEz0zLYcaWxET8uSHwXnp58tfJ5aoMJsElINThuHaQg0GYq5lhZP/pfUQ
	 wxuhoTgMcUVlioOF/96Qq+F4Nc7hHkYgjaaOktiioJLTtU4LaruXon3sVw+MZyLgJT
	 XdsQd2MqpLkKw==
From: Imre Kaloz <kaloz@kernel.org>
To: Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-pci@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] sparc/pci_msi: Clear the MSI descriptor irq on teardown
Date: Sun, 27 Sep 2026 12:55:15 +0200
Message-ID: <20260927105515.8701-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 2f2940d16823 ("genirq/msi: Remove filter from
msi_free_descs_free_range()") the MSI core expects msi_desc::irq to be
cleared by the architecture teardown before the descriptor is freed.
sparc64_teardown_msi_irq() never clears it, so disabling MSI or MSI-X
warns in msi_domain_free_descs() and leaks the descriptor.

Clear it once the MSI has been torn down.

Fixes: 2f2940d16823 ("genirq/msi: Remove filter from msi_free_descs_free_range()")
Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 arch/sparc/kernel/pci_msi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/kernel/pci_msi.c b/arch/sparc/kernel/pci_msi.c
index acb2f83a1d5c..bb1610497b50 100644
--- a/arch/sparc/kernel/pci_msi.c
+++ b/arch/sparc/kernel/pci_msi.c
@@ -211,6 +211,7 @@ static void sparc64_teardown_msi_irq(unsigned int irq,
 
 	free_msi(pbm, msi_num);
 
+	irq_get_msi_desc(irq)->irq = 0;
 	irq_set_chip(irq, NULL);
 	irq_free(irq);
 }

base-commit: fe2ec83746e501645709761605c2464a44fd2929
-- 
2.47.3

