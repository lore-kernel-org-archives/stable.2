Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7C051DDE0;
	Tue, 13 Oct 2026 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897518; cv=none; b=kXRXnDAv48+5SrkP0nDftH7RH2o3RF5jrRa+M6X7M9KGc5ZLqFsN7pQqqBHpXKaJvu3phWgMFYRcf0BifVaH7S8XJ8TD88ZM3HQygViqkrgpABxy9JqmKERqAkq4RJzzoXk7LPGW7iSJYrXyhLChmOvzqoFr6HyTfBIZOttQU80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897518; c=relaxed/simple;
	bh=+56umSPf86TO7NI9AxATzEGulQp/1LC5E2LVPvM9lvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oviOiFsJKkJju8G8GS3oJvsYzBsJHfmt94N69249JBQJY3EKB56AV65/UJZzELUnVQ3QwYGsXClfS7MtRZETZWJi5tQcCwOS87OAje0n1PfGoNhdF3Ahys0jUNPZC8eIUV73xeGiVGtDd8vF6WqDAZI1r8+YWXztqdjTsjL+PLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTJtrv2K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTJtrv2K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A22C1F000FF;
	Tue, 13 Oct 2026 13:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791897517;
	bh=X6aBuHWHcqzOerQPBrr9xhmSkaySdEJzcobohxIHNZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WTJtrv2KjtxdTWTimF+DdKYHCrcF3HZY40TRLactMWGILnXkoJW8RFeS9VDt84+T4
	 yBkAGLS+In7bC/k1vob0NpmGdH8odLmkGmAE2RiPxUaLG/XZYnLgKW8vG1p+ZCT3UR
	 cv2fL2IM9/bL/Dn2Ytoc9FiAqBYIt8tUgIJIW2980ko/pWSuV5ASui3Lv91j+PB9nG
	 FnnmQOZzs5pExRseHeottt27Kv58Aj86CtudaZ5vUVyJ/mmeVvXNFJ59YyrmZ+yxyQ
	 yXzKR1fMEEjEEeSHG+NGzbf8FNCwETeCd6PZT3HLxo2d2YBWfBwcegXAMiKray13+f
	 e/CR0pXRYAoOQ==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	stable@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 03/53] MIPS: PCI: xtalk-bridge: write a type 1 IOC3 through the type 1 window
Date: Tue, 13 Oct 2026 15:16:23 +0200
Message-ID: <b332c21ef99e06405ce95b70fa9a77919c2efc10.1791890466.git.kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1791890466.git.kaloz@kernel.org>
References: <cover.1791890466.git.kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IOC3 case of the type 1 config write goes through the root bus
slot's type 0 window and so writes a different device.  Use the type 1
window, as the matching read does.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 arch/mips/pci/pci-xtalk-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/pci/pci-xtalk-bridge.c b/arch/mips/pci/pci-xtalk-bridge.c
index 2fa9ac8d0a1c..18251a68fa06 100644
--- a/arch/mips/pci/pci-xtalk-bridge.c
+++ b/arch/mips/pci/pci-xtalk-bridge.c
@@ -277,7 +277,7 @@ static int pci_conf1_write_config(struct pci_bus *bus, unsigned int devfn,
 	 * generic PCI code a chance to look at it for real ...
 	 */
 	if (cf == (PCI_VENDOR_ID_SGI | (PCI_DEVICE_ID_SGI_IOC3 << 16))) {
-		addr = &bridge->b_type0_cfg_dev[slot].f[fn].l[where >> 2];
+		addr = &bridge->b_type1_cfg.c[(fn << 8) | (where & ~3)];
 		return ioc3_cfg_wr(addr, where, size, value);
 	}
 
-- 
2.47.3

