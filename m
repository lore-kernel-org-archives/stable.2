Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F70535AC37
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 14:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583039; cv=none; b=lelFKl86Ny7Xo8yMl7hjkY4s/kQ7+ubFU+YsTGRPJeeoe6efCu2DPAEPJZQvzzZ2Y7mEpXBPlzHDNHqK3Q/1CiTAP9B1XkYKRmvYdC6uZqiGCcUJwgRp08x1Tn+pGRd3Xtn7I10UnvM+oTSk0Mq2YJH+ymUGx8k58wTrZO3uhfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583039; c=relaxed/simple;
	bh=yjtoxshLlV7GSjzkF0xt8CVCjVKvq8Qj/2fmyxKbmHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yk8cqRAi3ICfZc8V3gDbXTW+pLrxLmihwWeI3DDpIAjYYOBQ2eSACXN++riJcdgUnDv3TJYyv/S1es3rmgkF4trP/5jKK1MEJolBzws27mGyQWhoCCYwE1jkHKQrhCecAsuQlmA2OWLvHh0/4X3ocQ5Jmblx/3O+C3gwGhCA2o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5kCYzfN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5kCYzfN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4071F00A3D;
	Mon, 24 Aug 2026 14:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787583037;
	bh=OqBkIVjS6SqAqsp5k4W9AGPybliMxrx2r2+ReJV0RSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m5kCYzfNY2wPkZJ+lflon0jOcWMjibvDzetzpog1Pkuv4lRhKkxK/VYWF4Hj2rfzd
	 6Y7Qz03CJpShsbWP5Spsejoz3W4f0i+/hMzxgu3P3RH9NZtmg8EDo7C+H1qevpLFn6
	 IUGUSwFI+j4Hd8qe1X2BOutPFCW18AAT/vkc+F+aY3lDJ6AMJqflj6WQgsq093AHUb
	 AIfG3kAmpDNzwj4ixxgxjYHmfRrCInL7u5R1C6R9rUHCjqQNezYeY3m0hXp00QaJE8
	 +a5xMqllh8Ha683mXH0VRngnP6//Dt+kd00bi3S9ncJbZnP3oAYlwkEYbWDO/bkgzt
	 jSlGhIobttW/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>,
	Mikura Kyouka <mikurakyouka@aosc.io>,
	"foad.elkhattabi" <foad.elkhattabi@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] Input: atkbd - skip deactivate for HONOR FMB-P's internal keyboard
Date: Mon, 24 Aug 2026 10:50:34 -0400
Message-ID: <20260824145035.3662153-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082021-ungraded-halves-33f6@gregkh>
References: <2026082021-ungraded-halves-33f6@gregkh>
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
index ea88bcfdb4b6f..f06ce0a7b156d 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1937,6 +1937,13 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
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

