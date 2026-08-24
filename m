Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16C5453A3B
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 15:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586805; cv=none; b=t125q2BNvJ/dBK4odoK1q0WtZmwP+4g8bScxeFZaOuO1QFXEMXQX2o1tJpMosZ4VZTFc0NsSNp4SphymF5I8NlipWxLqLjPIUYZvlMElvpZje4fqfDmQpPEFLh7t8M+O0IkoORy724mNoF54fjuq0ZjcUes8Z2VbY4AN8JAO1DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586805; c=relaxed/simple;
	bh=KK5LAwxvV7+oMGwYCzRtnB+iXxVC2gMoPAy4JvyMTgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgbkKX7OGRHQm7dpxDj69iTyRuvoESWXX0A1f6YfmJTCyMFfe/1S1xdBYXWFZM2K8gVrRWKAlM+bMxhud/I4vPlCfiIJYl7RISCb6KnDlSSb/+vsdqQ9SIGRNSSI4mrp+NtlCkVIhzbPNfvsxyk6hH3933YmhUot6acUf2156Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNogBSct; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNogBSct"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905EA1F000E9;
	Mon, 24 Aug 2026 15:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787586803;
	bh=FE81jBQM9gvNZUFQSLV6EVDp/3KvwyPjKn8bL8vX50I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BNogBSct4HlAk3RN3PR7qMto+wS/zITcN27e9byOo3P2Q3vp+34GbqqMD/W/WMeg5
	 umeKk2BMXxoImqD7Ni6sXDFLCIzXSFjraqlXH3l7uANt+3XjbNWBZprSWyy916ZUEZ
	 +F1msPsJSH47c2IudruRLEi8nP7FRqTFq+ZIPMMHMUOrsbJGkEtd7CkFI1j/BhM/uw
	 FROcvN/MtCcx0l+pGNfkZN+fhUEgbsVrAaYpiliiplbfrNptNTaMBEgFssjjy/Vi4M
	 z+1Tbpa/UqQJtSyfiW+fUMG4XfqxHuLrOq4I45hlgA20bClo6imJ02YM8SMGvMGMdE
	 DgD3/w/oDyWtw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>,
	Mikura Kyouka <mikurakyouka@aosc.io>,
	"foad.elkhattabi" <foad.elkhattabi@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] Input: atkbd - skip deactivate for HONOR FMB-P's internal keyboard
Date: Mon, 24 Aug 2026 11:53:19 -0400
Message-ID: <20260824155320.3962460-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082023-staunch-apply-c4c5@gregkh>
References: <2026082023-staunch-apply-c4c5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>

[ Upstream commit 2aaf33c6e1e82561d7dce2345298a985a2483266 ]

After commit 9cf6e24c9fbf17e52de9fff07f12be7565ea6d61 ("Input: atkbd -
do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID"), HONOR
FMB-P, aka HONOR MagicBook Pro 14 2025's internal keyboard stops
working. Adding the atkbd_deactivate_fixup quirk fixes it.

DMI: HONOR FMB-P/FMB-P-PCB, BIOS 1.13 05/08/2025

Fixes: 9cf6e24c9fbf17e52de9fff07f12be7565ea6d61 ("Input: atkbd - do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID")
Reported-by: Mikura Kyouka <mikurakyouka@aosc.io>
Reported-by: foad.elkhattabi <foad.elkhattabi@gmail.com>
Signed-off-by: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>
Reviewed-by: Hans de Goede <hansg@kernel.org>
Link: https://patch.msgid.link/20251022-honor-v1-1-ff894ed271a9@linux.dev
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Stable-dep-of: 410c44b10967 ("Input: atkbd - skip deactivate for HONOR ZQC-P")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/atkbd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index d8b7645e8d4e9..70cb19a8219b8 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1939,6 +1939,13 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "FMB-P"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
 	{
 		/* Lenovo Yoga Air 14 (83QK) */
 		.matches = {
-- 
2.53.0

