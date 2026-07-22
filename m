Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B8B46EF82
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784720032; cv=none; b=l8h+0v6w228Hx/jntX/tbAfiazTWzbRQM/rwWI08rdkdn5OM4YcZuC8gikmjJbQ1zYnhr1suyXiCJoq8WsceoRbDSsLzS+z7u+5KkCW32bhqCxmA8ltPddkZR5/MT7GXXoP/JUyAMs3JcNJ9irAXYMtkg0FGfeCvngNXqf0vhy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784720032; c=relaxed/simple;
	bh=hQXwVvJiJMAJltB/XBNufMgSyDt9AsinxXQZrVpmMzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gz/qN1yCYBomrHiymcGNr1mehA6ulhOJIhQ2J/K3WxDO/vy6i7ZHLd+GsEI8ajyLi7k617HzwNmZc6sPaOGTlFYjFCFwxY6adGwfs7+wQcF6ckHUgH0g/wVEYBz7F30+bvQ6imiNix6bAIgA+/6v4ikoaEh3/x4cDl/xp9AbeYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeOIDK7t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeOIDK7t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF2A1F000E9;
	Wed, 22 Jul 2026 11:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784720030;
	bh=V+vQtKuXnH6YwUK6i5STl+3iYVgoVttTlS4wO7FBp9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MeOIDK7t5W+vusIhXjweLhh9RWjIJB6Mj/Ql5XQRoPWgqgRLUaFu3SFQROHV/2A9V
	 6mEMZHkhLpWyYa4klNkWRvEK6OQrkQ8pf414YAFRdU3n81pHsL8l4xnrWDiim/zQEd
	 zxN5fKgsuQ8ZWtOYpVGVBlWRbFWDNej1ey+UbFtl3Ub1g73O8+ldph41pFeKk/Sgq+
	 DsnGmh7d23Dg3SBvg4WusTX+bpnCNjkCYxkC0j85MhkjhD74wnR3F7rZGZgUf/cSte
	 DEMJBxu2CKWa+Enc4G5+60SL01Uzhnf7d/lNEGSYyRVrVF8LyMCzsU+bu7lIrYqcAl
	 CbqxYcK502pOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xu Rao <raoxu@uniontech.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ALSA: hda: Fix cached processing coefficient verbs
Date: Wed, 22 Jul 2026 07:33:48 -0400
Message-ID: <20260722113348.1150850-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072011-plastic-headphone-afbf@gregkh>
References: <2026072011-plastic-headphone-afbf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Rao <raoxu@uniontech.com>

[ Upstream commit f67be28fdf8b5d31ac1cc1152bb17250f9f8f513 ]

Intel HD Audio defines Coefficient Index and Processing Coefficient as
separate audio widget controls in the Audio Widget Verb Definitions:
Coefficient Index selects the coefficient slot, while Processing
Coefficient accesses the value at the selected slot.

hda_reg_read_coef() selects the slot with AC_VERB_SET_COEF_INDEX, but
then uses AC_VERB_GET_COEF_INDEX for the value read.  That reads back the
selected index instead of the coefficient value.  hda_reg_write_coef()
has the same issue and builds the value write from AC_VERB_GET_COEF_INDEX
instead of AC_VERB_SET_PROC_COEF.

This only affects the regmap coefficient cache path used by codecs that
set codec->cache_coef.  Direct coefficient helpers already use the normal
SET_COEF_INDEX followed by GET_PROC_COEF or SET_PROC_COEF sequence, which
is likely why this has not been noticed widely.

Use AC_VERB_GET_PROC_COEF for cached coefficient reads and
AC_VERB_SET_PROC_COEF for cached coefficient writes.

Fixes: 40ba66a702b8 ("ALSA: hda - Add cache support for COEF read/write")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Link: https://patch.msgid.link/DB9023BF2920BA99+20260707132419.1731342-1-raoxu@uniontech.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/hdac_regmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/hda/hdac_regmap.c b/sound/hda/hdac_regmap.c
index 39610a15bcc988..9b786cec8f1e13 100644
--- a/sound/hda/hdac_regmap.c
+++ b/sound/hda/hdac_regmap.c
@@ -215,7 +215,7 @@ static int hda_reg_read_coef(struct hdac_device *codec, unsigned int reg,
 	err = snd_hdac_exec_verb(codec, verb, 0, NULL);
 	if (err < 0)
 		return err;
-	verb = (reg & ~0xfffff) | (AC_VERB_GET_COEF_INDEX << 8);
+	verb = (reg & ~0xfffff) | (AC_VERB_GET_PROC_COEF << 8);
 	return snd_hdac_exec_verb(codec, verb, 0, val);
 }
 
@@ -233,7 +233,7 @@ static int hda_reg_write_coef(struct hdac_device *codec, unsigned int reg,
 	err = snd_hdac_exec_verb(codec, verb, 0, NULL);
 	if (err < 0)
 		return err;
-	verb = (reg & ~0xfffff) | (AC_VERB_GET_COEF_INDEX << 8) |
+	verb = (reg & ~0xfffff) | (AC_VERB_SET_PROC_COEF << 8) |
 		(val & 0xffff);
 	return snd_hdac_exec_verb(codec, verb, 0, NULL);
 }
-- 
2.53.0

