Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272560;
	b=zaSW8JvuW9+PVWzQZd9d/1JYgPdRuaVAbQ713t/1MnLSpu1/dZBAcArypJ1kJSVD7v2h
	 1EjBlVC3cq+Ml8WIJnnMtwlV+nVUApVC8xHuQVoTRQT6f5h+jjt0azPIjf+jZG2/tolXN
	 JfF7QEfe5BcDJQC38e52dZ7EFUdC6IXPhypGcP9gDQCz4h6Da1YnIn3OLVxAiu6qdtEk+
	 8FF3ktpqg923RzirgGxzKLJQ/Otgbu6itMI2HGYzao8flO1FMyZgW1ZPsPveuY3dh32N5
	 t2wC0szSrOWs8vMbuXIv3KGKs9m/fzZY1hm029xR3wpU/wZlUaN1xleEFBdJgCdhDTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272560;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=npA4NYOV5H8P1n+vIZU6UGMx8NArUrA79U/Hilipvbs=;
	b=UN30fR4FjN14JeL0+mWzKeXipS8RyAls4JkTPoTf0fzSsRUdsA1+aqpzG2/k3mv369G/
	 GuGFzq6dyTL4NoODGTuFpIS8QBZ/SScw+bejOPW5da4Eh5teJYy/U/JPpSqTKBZ4EMQ0+
	 scnCXxSYbD8t1lQJZ9GmbR5FqoaevE2YraPpcBHyIPiAph0BxziZdvxL3R2s+AV17dh3x
	 lR2MSNar+pnA1zTbcIfSSkmT8+7bzM/lsMu4FRHXxMFxyoEq86REAysYCZJb60Mz11id2
	 DncAnNnU93skm4rioGDPuP0nEnnwsAnEsJkwmnws+bJaJCBTJAeJ95iULyHcBk5tj6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OOk0vvq7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9357B606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OOk0vvq7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D4C1F0089F;
	Tue, 10 Nov 2026 01:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272560;
	bh=npA4NYOV5H8P1n+vIZU6UGMx8NArUrA79U/Hilipvbs=;
	h=From:To:Cc:Subject:Date;
	b=OOk0vvq7uDUvLyY8ZNUQ7pnE8u4+6ZDU8IZSTOSMGgq4zlPF8CMSAWH9EwbQ1leH+
	 Kz3f3PSGwlpTnJHeu8K5KLfBw+6ow+etDUtiyvt91kyLs2MM7ZwgK89pjiP1g3qCso
	 RHEfhslguA60EHmvsEwDcpbAHlyHWSfLSAx7MfVF7sQCLl4Gg6Whup54iIFHKWLsLN
	 xSxPGNjDQPO/mpAv9UF/H+kcVresLybXwVRB1QsTEFaAqG5vjhkKTgqKtuhFpSIsY9
	 v1iZIybwAFRuO0q7B+9tNIb3uaK5SAtRkDI85qtA5XeDRA64PCZuhTKRe1py6Xbm4Y
	 Cc6YYXTWest3Q==
From: Sasha Levin <sashal@kernel.org>
To: gianluca.balboni06@gmail.com,
	vijendar.mukunda@amd.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: amd: yc: Add DMI quirk for HP OmniBook 3 Laptop 16-by0xxx" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:02:38 -0500
Message-ID: <20261109200238-failed-6.18-1e73257dff33@kernel.org>
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
git cherry-pick -x 1e73257dff33ff851af60d5bb00d73893a8b6dc8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200238-failed-6.18-1e73257dff33@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1e73257dff33ff851af60d5bb00d73893a8b6dc8 Mon Sep 17 00:00:00 2001
From: Gianluca Balboni <gianluca.balboni06@gmail.com>
Date: Sat, 31 Oct 2026 11:21:36 +0100
Subject: [PATCH] ASoC: amd: yc: Add DMI quirk for HP OmniBook 3 Laptop
 16-by0xxx

The HP OmniBook 3 Laptop 16-by0xxx (board ID 8EE3) has an internal DMIC
connected to the AMD ACP6x audio coprocessor. The BIOS does not set the
AcpDmicConnected _DSD property or the _WOV method, and the board is missing
from yc_acp_quirk_table[], so acp6x_probe() returns -ENODEV and no DMIC
capture device is registered.

Add a DMI quirk entry for this model to enable ACP DMIC support.

Cc: stable@vger.kernel.org
Signed-off-by: Gianluca Balboni <gianluca.balboni06@gmail.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Link: https://patch.msgid.link/20261031102136.24600-1-gianluca.balboni06@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 1d06b2a16e58d..4908f4cc147a3 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -780,6 +780,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8DC2"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8EE3"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.53.0




