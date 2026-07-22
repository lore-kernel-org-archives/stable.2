Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413E035C6AE
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731701; cv=none; b=oLy3MdGP7ZVAVXG2XU7iBvpopozhkeJplDbGE5qV2uc91PpVFrpk76Yhzs6pr2jPO2iOb8rjmd9XGsotyPX7NX0505fDzwxJROpW2/8WfQ6lMgjQ+Gm3ZaueD3ShpwN0gkE4LTTFkQZRB0rFiyryEjW7xCt49YQMzI5+MV2FXEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731701; c=relaxed/simple;
	bh=DbidMpFBGQIlIdQeqqqbrWYhz/akJPH/cjcmr+MSGqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjuB+8SE0dFL4lR2L0SFBG4qYeaEkMN9+sVb3QmakbJRw/xcIfRFZbEH152UxQ2XIdgFrVxoOwe8D1vVUFngzSTnDuZHABJq7gZEyl6sTbWbIlT5aD5hVR2tFhhdCVxPS0QOOU3zMrFOb8NRd/MHDLCrjHKwh9j/lOerQKiW+wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewVFcxj9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewVFcxj9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61131F00A3D;
	Wed, 22 Jul 2026 14:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784731700;
	bh=dhR4l1bi1mOFjvE23KCsXHjxh0R8c3bRAaF1I7jy4EQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ewVFcxj9ggD3tLKGG1qtiuXYt9swr+M3X6V2aFw20PkEC5vqRwSlSLFJ7uUlbI4bU
	 iK+ge9jqmP73ObSHz5ev9ICIqDqwo7Wq1aD7rcknnBeDh0ePcmNDH2qFto+BJxt1Jr
	 AldAIchvYmdM7MKIsPjCzNammGlYLEJ41H7lC9KD1Sv9RLz2crL+kSppANvAS/I7AV
	 ExA5XIfo0bOyXizyo1mAOc5/6S0VN2tw8/8w0Axwb/4N+CXOpslgVk3XkDC6MkOjUe
	 T+LWTJaEcmKxL2oJiaCaWU9LR1d44kesGKxddh/LwGjUhfrGPhiWWEsGa4zw4IArq9
	 aoCksqFjOOTfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xu Rao <raoxu@uniontech.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ALSA: hda: Fix cached processing coefficient verbs
Date: Wed, 22 Jul 2026 10:48:18 -0400
Message-ID: <20260722144818.1599468-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072012-scrambler-friday-82ad@gregkh>
References: <2026072012-scrambler-friday-82ad@gregkh>
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
index bf35acca5ea0ea..5c7ac8e8de0da0 100644
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

