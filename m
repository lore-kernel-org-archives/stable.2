Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5861837107E;
	Sun, 11 Oct 2026 10:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791714242; cv=none; b=a4dQnOitY9OjKRXz/o+CJFmGfliM92LQ4gjWL6q3DEmjXbEm1AbvTPrV3fabCGgGIiEnSUTKhHcgZZMojDLnKXeY439FvmfwMSsg3xwA+6yIFLKFqSOesFf/peqvD3BaEPtu3fEXfvsjYioAtPM155CtGFOqlL+aad9hCpUp3DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791714242; c=relaxed/simple;
	bh=fK2tzPk9pS2sFCfeHuxr0Da5pVUFgosRSnhrzusFAa0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V+jlzEPP2UG6UR5WVMnNVkUt0Ye1OrX2XVGgRwAS3Wye2dNPupVrMom7HA4mPqhotonVgwv8njK5gSL1JimFKtHZakMzrPsYBpwnqCqId20dH32uYMB7q1hknZy7RNmTxteXQ0icE9+golE8z88+Jumo+G/stPRWWo2mXz2Psrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CUM3+YRm; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CUM3+YRm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=2N
	o19gjcCAleHLbC1vC1puofCJ/6DkwtwmQE8K5mKWk=; b=CUM3+YRmSVYc2f9ldT
	sUypQosXeUmr2d2194JCcTIjp5fcDaSYtrxzNzwvbP0knvKzni3pZ30fU5vfr0Xf
	c1lx9w5EDKyXNQKD541r9Y4K6HNYqgIgUsk3K1/34w1pbRNb+/7isZtTGOeILBLn
	y4fAHgeak/KKV76oxGy9ZdxhI=
Received: from ubuntu.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBn1_WWY8tqY2hkDw--.34149S4;
	Sun, 11 Oct 2026 18:23:27 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	make_ruc2021@163.com,
	kees@kernel.org
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: [PATCH] sparc64: Fix leaked platform_device reference in schizo_register_error_handlers()
Date: Sun, 11 Oct 2026 18:23:17 +0800
Message-ID: <20261011102317.3233411-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBn1_WWY8tqY2hkDw--.34149S4
X-Coremail-Antispam: 1Uf129KBjvJXoWrZrW5ZFyrZry7WFWrJFW3Awb_yoW8JryUpr
	Z8C3ZxJF4UWFy0kayDZFy0vFWDAFnIvrWfur18Ka4Iqw15GFyFqrWDXF1vg348trWkta18
	tanaqr40qay8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEJPE7UUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC0x+NmGrLY5-F0AAA3R

of_find_device_by_node() is documented in drivers/of/platform.c:

 * Takes a reference to the embedded struct device which needs to be
 * dropped after use.

schizo_register_error_handlers() looks up the platform device backing
the PBM and never drops that reference.
tomatillo_register_error_handlers() in the same file has the leak.

Release the reference once the error interrupts have been registered.

Found by code review.

Fixes: 22fecbae4446 ("sparc64: Record OF device instead of device node pointer in pci_pbm_info.")
Cc: stable@vger.kernel.org
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 arch/sparc/kernel/pci_schizo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sparc/kernel/pci_schizo.c b/arch/sparc/kernel/pci_schizo.c
index 4348ca2c4a3f..a8db997675cc 100644
--- a/arch/sparc/kernel/pci_schizo.c
+++ b/arch/sparc/kernel/pci_schizo.c
@@ -1050,6 +1050,8 @@ static void schizo_register_error_handlers(struct pci_pbm_info *pbm)
 
 	upa_writeq((SCHIZO_SAFERRCTRL_EN | err_mask),
 		   pbm->controller_regs + SCHIZO_SAFARI_ERRCTRL);
+
+	platform_device_put(op);
 }
 
 static void pbm_config_busmastering(struct pci_pbm_info *pbm)
-- 
2.43.0

