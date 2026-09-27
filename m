Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C43B846A;
	Sun, 27 Sep 2026 00:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790470711; cv=none; b=Cu0uD18dz65cPpC8xhws1AvnCOwJ+ml7v8GHDVxEvr/jIk70gvoc/GHjuxNXnm3tHkO2lIhmhtYX/UKG1Nv93dbfN4borp5/5PUTOGceCzFiI3ya6fDQHx0jKxtlaMFgxEWi03YpYWdqaD8Uag7jlpdJJxo3FIgeEZP8SaQEPe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790470711; c=relaxed/simple;
	bh=EW2DJNVQDkdJzaE3jiH5FqIORuX+Yzz0K8kL/nRQTko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SiadYF5BF7Qx/Es/zSlUf639yqFXjLpAl/s7OapDfyxL/v4kAW8H+XgiKNcYmHE7ccS3W0pqGd9n4bXdHnVdF3069+S47zaS0TQqcoEP50Cp1kfVMRNB78tsMPfY/5+4/mzp5SXdN27n78RnfAnBQz/wuwIP714jtCN5cW04EM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ILRbvs0k; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ILRbvs0k"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 545C080A44;
	Sun, 27 Sep 2026 02:58:20 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mUEK5sRQ9zkz; Sun, 27 Sep 2026 02:58:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1790470699; bh=EW2DJNVQDkdJzaE3jiH5FqIORuX+Yzz0K8kL/nRQTko=;
	h=From:To:Cc:Subject:Date;
	b=ILRbvs0k8vzogZG7xUtb+WAK7CgCOCLvf7V32xxwc/upPQwmYULKIdH909gVruolR
	 Iq/jkEztdA9ViyVblriMUIRXeosszaw5iXT6qxRk37eMyJPZsGn2VIfJfDVO+B0J8f
	 A7VhHBdb9/n4h71peoXEYBpR08stPT2KdPLlYeO9s6R//JdciclCozscEdz0s/ki9i
	 ATmheg7hjCFoRFqBqt8A+S3A6uNo8KsPjvEtmnRnxjb1mD862TYCogTCGG8KyQr6O4
	 boZT6Bi11WFOOeaMYPvYEMLZLOM56JmLTSGIiQyQjY8FKEoZ/QHWnaM4EN80YaCErI
	 dJobU8m7vyIHg==
From: "R. Larocque" <rlarocque@disroot.org>
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	salmundani@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Rapha=C3=ABl=20Larocque?= <rlarocque@disroot.org>
Subject: [PATCH] Input: synaptics - limit T440p InterTouch quirk to LEN0036
Date: Sat, 26 Sep 2026 20:58:10 -0400
Message-ID: <20260927005810.85971-1-rlarocque@disroot.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Raphaël Larocque" <rlarocque@disroot.org>

The ThinkPad L440 also uses board id 2722, but does not have the SMBus
initialization problem seen on the T440p. On the L440, the SMBus
companion becomes available shortly after psmouse probes, allowing the
touchpad to use SMBus/RMI4 normally.

The T440p's quirk is currently applied to all Synaptics touchpads with
board id 2722, unnecessarily disabling SMBus InterTouch on the L440,
as reported by Daniel Salmun.

Restrict the quirk to PNP ID LEN0036, which identifies the T440p, so
that other devices sharing board id 2722 retain their normal
SMBus/RMI4 operation.

Reported-by: Daniel Salmun <salmundani@gmail.com>
Link: https://lore.kernel.org/all/20260925230039.236786-1-salmundani@gmail.com/
Fixes: 26eb3d92c7a4 ("Input: synaptics - disable InterTouch on ThinkPad T440p (board id 2722)")
Cc: stable@vger.kernel.org
Signed-off-by: Raphaël Larocque <rlarocque@disroot.org>
---
 drivers/input/mouse/synaptics.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index a8ce89d41faa..cc1e0bb4325b 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1839,8 +1839,10 @@ static int synaptics_setup_intertouch(struct psmouse *psmouse,
 			return -ENXIO;
 		}
 
-		/* Disable intertouch on known-broken board revisions */
-		if (info->board_id == 2722) {
+		/* Disable intertouch on known-broken T440p board revisions */
+		if (psmouse_matches_pnp_id(psmouse,
+			(const char * const []){"LEN0036", NULL}) &&
+		    info->board_id == 2722) {
 			psmouse_info(psmouse,
 				     "Disabling intertouch for board id %u\n",
 				     info->board_id);
-- 
2.55.0

