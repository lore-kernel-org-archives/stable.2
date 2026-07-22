Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE1D4BCAAA
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 11:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784718086; cv=none; b=KNAVchuElMySS8pcWGwBDXpmzMwSBujY8I0gcf6aCuIM3VLko8mnDYv0yt3WyGehGavczFOA3M7Qg8QUTAhvjwDx1WxYLEVDpfoaREgdTothD9JfzPuSiOOqsdEkiTWUM9cCqeLmu6uSgZFC1z6pM7eLWN00/lh4BR47sQABcMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784718086; c=relaxed/simple;
	bh=cmq6VmbtjVAGDjVj2SlOAghqo7Co3qZifsljxwWs5DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQVllZBrl9DOsxR3j3PeWnqHn8/+Iz8IblYagAxHaEXAjazaY2AkyeMstrI4HYa+gRcA4XH07GBqeJmQXi6EY5hj+Q+kunDSnHCaIf/ZZtNRBhp2C7oEk0+IBN2GRpTZfBvJlVzifgtq9+0ltoScz5dIjepULWums9xgU/187zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZenUtQQP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZenUtQQP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EAE1F000E9;
	Wed, 22 Jul 2026 11:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784718084;
	bh=whsWH9JJjU9x17YJP/XQnEQj1U9fbpgiTlnUZEfD5NE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZenUtQQP/ZWWjkKtX6Q5cQLqw+k3B6bcADqLbSfYsLjtdsaKPzF7i6iWMi0l7eZ+z
	 fjlTIr4ko8FlU9tGeifbgWaneiB/i68XZ3ZsRFQsKx9sLUmA6gA3DqWf/KxBisFjgY
	 d3su1O+cSGsUGoU0JbcMVDBSH0Py3ujnzQjb8K/W79QXf0+O/6qPkkKqsg1AXJxqGv
	 Nlwe7crm42B5gf29D4RJAFH5ZX53e85EZomAeTqPw8gXX5iTBdsQgQsyzwOn/pP2Yi
	 ZWMZ/UZE8EdnNl478kUXgdfR13S5TN6ZvpaYdimLCvD9XDk5ZbeIpp0PepHyvWsxLH
	 VjZ6Av4O3iGoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xu Rao <raoxu@uniontech.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ALSA: hda: Fix cached processing coefficient verbs
Date: Wed, 22 Jul 2026 07:01:22 -0400
Message-ID: <20260722110122.1006393-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072010-denial-election-d397@gregkh>
References: <2026072010-denial-election-d397@gregkh>
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
index 97cee096a2864f..1ebc6dcc66893f 100644
--- a/sound/hda/hdac_regmap.c
+++ b/sound/hda/hdac_regmap.c
@@ -214,7 +214,7 @@ static int hda_reg_read_coef(struct hdac_device *codec, unsigned int reg,
 	err = snd_hdac_exec_verb(codec, verb, 0, NULL);
 	if (err < 0)
 		return err;
-	verb = (reg & ~0xfffff) | (AC_VERB_GET_COEF_INDEX << 8);
+	verb = (reg & ~0xfffff) | (AC_VERB_GET_PROC_COEF << 8);
 	return snd_hdac_exec_verb(codec, verb, 0, val);
 }
 
@@ -232,7 +232,7 @@ static int hda_reg_write_coef(struct hdac_device *codec, unsigned int reg,
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

