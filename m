Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C074189B8;
	Tue,  7 Jul 2026 13:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783430697; cv=none; b=B+RrqltqPMVzJMUy8KTW52vizMWiu9749lVNnEaXmq8LDUFSSkYyXstZWdz529aUz5HIYDzDSaWwgCfHbnCyXWoqp0qtjwFATW4xTgV1s5fRLMg2V9lsi1Zh0GQCb60nC7UhRMdTIQkMHg52qozJ8TX06mQm4Fg+nF8r+aqdgsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783430697; c=relaxed/simple;
	bh=vtrZtH5TDoDuRwYUu+2qUXFi+UWqM85rbapuzzsKooE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aWsjOvko16H6rzO5CMF22gVF3hdtnMRdVSUQcwfsusS1T7kXa2zQAXD/yfqcA9UFm/DqN/TkqyDd3xziSBlkZ6ujkw36Jm4W5kDLGXuGH4KBWhBlOaHPoXOsRZOXZM/pnD5k5u2NpvqPJphX6jSXsc9LS/xV7mMij9lpr6l2ers=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Dk1t/251; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Dk1t/251"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783430667;
	bh=m0aV9/Bzvgo91Wu7FQyhRfJtZRz32PhgnIpGOiDxBO0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Dk1t/251n0tSiOIUJavuTzYujTnzTRr+yWnv79BPG/d05muAuCdUcSkDMCYWYxWxH
	 VnLU+pSiTPHHmKCn0IlpsnBBOwdRwwmpqNnsjDv6qR2zf5zn4vGAUsdU9h+3OZlO2o
	 TQF3K1KDi2/y1MbD7pmRwtoR6rGsEqYKreMrkfNc=
X-QQ-mid: zesmtpgz9t1783430662t310a248a
X-QQ-Originating-IP: 2KdvJXoZsAUFuZXHtvFZbycg5b07oD6nW+2U2BzffGs=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 07 Jul 2026 21:24:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7072674216128944020
EX-QQ-RecipientCnt: 6
From: raoxu <raoxu@uniontech.com>
To: perex@perex.cz
Cc: tiwai@suse.com,
	raoxu@uniontech.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda: Fix cached processing coefficient verbs
Date: Tue,  7 Jul 2026 21:24:19 +0800
Message-ID: <DB9023BF2920BA99+20260707132419.1731342-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NgFno1SrO4sPwunoyO9iepoo+viWXnWaQRjx5nZ7kAh+Kds9G7K6iDGB
	D3N1mx0EWE5XbtYqcq9X8XHB9yJtbtMLYrp1GGhA0MQ93l95/ns0AiZtuCA83rW9ZeeitzJ
	nc9pG+C4PnTRTsOELlP/xxY8H4ScHfyELGCU2YTmEJ4eBWbUxCwbOXAi834TxEvg7dB9lMh
	AkDt3ncPmBc971kiejx5dcyjgkdKU17e0O80V+rPbAqaJcPtWivZ4fZjrGTflAUVaHj6+u9
	S8l3OCeIDvI5IIP/wArBRud64fZ7F/1sRAzPF1Sl9Ofg+IjRia716+0jYfljgMgiZ0zxABw
	7SoJvRomY58y22lK7aFviRabSKYkTfLZGC3MzXZsHoY1f6zWoAWEd5st0hGx40WILv/lbD7
	W+7AIG8Te1/JBoFxsZIUbvHU+rR7icOevNRmwZTNtRfo3EY1W+jypUSyaFLuukUsPK+19tJ
	6iX1J5oUDdSMMB5UzcG1fV15MD4QCzBiv+fqOP/RisRyNw+Gd60lL5Z+UYHJ25apyPBeqPX
	wwlJkByQQ9tfyEIPSuifMPirNsn6AOEECr3YBSZw13m5tRRjLHV/v3DFNKYa54KOIASIt0K
	gu2KKl8FwUosvCvkdxT3UaZVJPLs97Fzlb+rEmXsf0fP+vYaJMXbTquicmvb95Bh+eHMTMY
	1RD7i+EMyCH22mRo2dixm5wxJsm9UlqkavDkKJlDMEMmtOeRPJ1lipza4EMHOELMl0Ggnrp
	O+rB3z3ApJW6LDm/mhVOdaQGQDy1THTWgfdmELWWArykHf+jj5L8VH5+GIiqd9vbebhQ1Vx
	l2w3bHiIYq8iEtnoKb6rSE3NsXcynvz+quN8J+aB4eXLUvYRSnps7lNkcbxWp0njpjLBbFs
	rbgecl4XzVSvZtqV4FtaRyplTARf8RVeCKs3K2PMIvV2jUXqok/Z53Dwhq2Wp8Mr2XH9oPH
	uOf2ohodo5qnYLUCDNNYGGqw+nBdB2FUPlQT/24eUbzJ5XFPQFUMd8dbqLbzJXc6dJ+BUPR
	gG7IiUgV9fstLvczj++KFDbQ23zPU5OSBXTkyoV95pXtfhJjxdlEillYtKq5RvqyDwz1oOO
	Q==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

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
---
 sound/hda/core/regmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/hda/core/regmap.c b/sound/hda/core/regmap.c
index e7b866fc52c1..d6eb17aa9e08 100644
--- a/sound/hda/core/regmap.c
+++ b/sound/hda/core/regmap.c
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
2.50.1

