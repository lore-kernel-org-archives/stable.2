Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794142193;
	b=PMSz5uQSRiOP50b/zzNb5TOZEPvrkMg5jH0pxJAJ+kAZOlbDT5dqIMjXWYvuhBLpFSdh
	 uNwizgxTp+hfNFsugrHtS1eKU27i7sXtZjAkclCs/RwVg6lPP+oPnZO1I+5PJUktESn+E
	 JwcUaa9tjCN21tbVVr5OGX5MZvz+h0ooq6SkX+tIGwOLKhVoHQGq5m1h0plU2OgWD3+XI
	 2oemTuUi+nEIQ3YvHDeSh6QtN8Hb/KpEYzm6c8Oi3TWFOR7bscPJZTW3Sgf3QNrvYb25y
	 b09PHlN/TNhKzGOcdjGuSRvhzo3Tsn0PuCIz4wba8WDX8iejXdGCx+FeIfObqjTgJ+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794142193;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UF6lZcZ5YxbATOBSsPg7rc9dk6wBGqppenAdVVixuRA=;
	b=0AqmFl31PcEIMO0PzRhGnNGD5gGH6CPj39wKoIGQRTr1HA4eygB0S+sz1lmYf7yJZ3PV
	 sL0AcnHVTPa50Q3czRKlpOfmbheeFXo2aP4X7wtm2fVYH3/jsNFCNedPyepsUZ7A5o0Xo
	 R36cUc6V66Gwjh8A0HuqTBc67tBikLOxLiK4PJX3a1K4c9pYP1LEbUD8Dc0EVNndvqIut
	 POgoDqkcvtpjIV6aYY33nlDHXB1bzmj61Ui8hQ1E9pSvtSuPKu8Z4ba1tHZ5XXA83Z87M
	 58fEDiCvE+0isQBIuIqfzB4OW51gu0NncwGuKspJ7khQJrVFfRvnvFrlvY2eax97rVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LeDiOjJJ;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CC0606A333
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 12:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50CC0606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LeDiOjJJ
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1a2761c69fbso218535c88.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 04:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794142192; x=1794746992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UF6lZcZ5YxbATOBSsPg7rc9dk6wBGqppenAdVVixuRA=;
        b=LeDiOjJJTV1qH0oUdJe962ARYenZo4GwF/uIxXoC1O4Bc0+EXAPseKS4DIKzjuh6Fu
         1C5N+7wi//IAxNlOBqf9TfOYhvThtehMIh5Zj0bADC7HDtuUghp1aDKvLa529BSp/PhW
         xrndWzAC9mDRLn9YqhwLsNgZ8FNAzY3PBYnynrzjGfQ06p3Fgwa4fZKxGMfc8o8eoprB
         yB6nJbo/z9fsrpNVCck0L03KGs/U98CLthtSDfDpnyssATGf54OsMLNRrFfAZrmSEki2
         aUqQzjxxbOyG2YN8NlpR1jrIF5RyS9A+aqQt4f38RWb/6xCWmyp0pQnkoT79itrrTy4Y
         hGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794142192; x=1794746992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UF6lZcZ5YxbATOBSsPg7rc9dk6wBGqppenAdVVixuRA=;
        b=XVE2sPYtiLmOK/+eUvEntRyfw77s6VUzpfN0/nlmxnmkaNMPHy8Tc4xKfUt149rFbP
         NVxwHyxWOMA0h/Kcji21CAGmFuYWJDasAr5R8lQZuDVTG0klfLLmoagCrbyPXD0lg0NK
         s4hSK9mCDqcfrjBWf1yYhQpdEhR85B6Spn2myi3Cayo4r6pFbqfsik+Eh3+SzM2yyHQx
         c8x+1u16/9VFulglqnjppr45oelHWaOAGgzQRvJtjHAN+1fUwNDnq7jyhmOBScdzOiIa
         joiaBvwpU2NXGeZk5GedhQbnOTdBQ/CgwsMoCcRE/mPjkszkOgFcypjL/kWeqn+IlQxS
         m0NA==
X-Forwarded-Encrypted: i=1; AL+hErFi3zVzUrBoptyu0HAxYkI1oOZERqODPeDPU+QDoOD7wk7ISpiGmqU7pfCAtpwr27onF516XeU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9TX/rgLzIBu5IbPUpyMHJjR1/awT7+6o9fU8e34n6/DzlkWZQg
	dckw6CeZfW3SDSfGFSRIeFFDTXbzPyWU9KYBngX7yOkChX+yw+l90RHM
X-Gm-Gg: AYBFou0vg3Qg+ddWOxdDe0ikI5I91fzzAedUGQ+FSNw1vZE6bfqe1kOmMoD/T4i8afL
	wIB7qlpvy6CiYz6HeQ1aB5E6zrX1XsYYo9DTBNYaWjdi0Sz0XdUNWjjVJrnxQmfOIcfuOvu0roH
	zOYGGk+dEStCToPw6KLymMkYtFawjPsLQpL3qhTEza9EOdCt3zL9topg1pVkk/oDvOrvHsN+v0K
	ZC7srVlW8k1hypTo9ARVquS6NhTPNn6Qyr/SJgGNqxaLRPOzL7VRBYw5RwuAM0EgD/4kBNNfl4j
	rLryupkpSdoBRJEwauhc/ahBbVz4fRc48fB+QK85LXZ+V+cIczoPYjg/z2Db8HaBMhTsZZLCYZv
	pP66g76whF9/oqaEUT43sdYiN/LGXXZR/XbwgFtRwz+bWYMjg3hvYC9J7fjcbCAFcc8kZBAGO/M
	7+klhsrjRgUh6nz22wUoNmcUwPF5B5YufgMK96Cq7b/kcqs9zQghOLGk+QbUBUNf8ExPOSZp5BV
	WkXIPICoU58cbVcbL1bSjjGhTZlN/TZ+DC+2/q86d+foghIq5hKbxO93qCv1+8Mq9MSeRsG1V5P
	lOZp9GtfxuVD4yPGAm47TgvV7hGfJZGcXB572kjjbsJObyEJwISU0HSP0knvLY4yHGlkRTsHCvG
	D0WV5mizHf9OE/xN4hp1bHWoZ68jEsjziw13SPbSi
X-Received: by 2002:a05:7022:81:b0:144:de98:eec1 with SMTP id a92af1059eb24-1b39fe87bf8mr2150277c88.11.1794142192325;
        Sun, 08 Nov 2026 04:49:52 -0800 (PST)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37265619774sm5623975eec.8.2026.11.08.04.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 04:49:51 -0800 (PST)
From: HyeongJun An <sammiee5311@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Alyandra Zahran Nadhir <alyandra5b@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH 2/4] ALSA: seq: ump: Clear stale selectors in sequencer conversion
Date: Sun,  8 Nov 2026 21:47:49 +0900
Message-ID: <3c5cb0ef0023c4d2e835805498a14751a92feda0.1794141913.git.sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794141913.git.sammiee5311@gmail.com>
References: <cover.1794141913.git.sammiee5311@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alyandra Zahran Nadhir <alyandra5b@gmail.com>

The sequencer MIDI 2.0 converter tracks RPN and NRPN selection flags
separately. When the controller stream switches selector type, the
previous flag remains set; fill_rpn() checks RPN first and can encode
subsequent NRPN data as RPN.

Flush pending parameter data with the old selector, then clear the
opposite selector before recording new state in both CC and Control14
event paths.

Fixes: e9e02819a98a ("ALSA: seq: Automatic conversion of UMP events")
Cc: <stable@vger.kernel.org>
Signed-off-by: Alyandra Zahran Nadhir <alyandra5b@gmail.com>
[HyeongJun An: drop the KUnit test, fix the subject, add Fixes and stable Cc]
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 sound/core/seq/seq_ump_convert.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/core/seq/seq_ump_convert.c b/sound/core/seq/seq_ump_convert.c
index ff4ee26adad1..bac37d4ef43c 100644
--- a/sound/core/seq/seq_ump_convert.c
+++ b/sound/core/seq/seq_ump_convert.c
@@ -847,6 +847,7 @@ static int cc_ev_to_ump_midi2(const struct snd_seq_event *event,
 	switch (index) {
 	case UMP_CC_RPN_MSB:
 		ret = fill_rpn(cc, data, channel, true);
+		cc->nrpn_set = 0;
 		cc->rpn_set = 1;
 		cc->cc_rpn_msb = val;
 		if (cc->cc_rpn_msb == 0x7f && cc->cc_rpn_lsb == 0x7f)
@@ -854,6 +855,7 @@ static int cc_ev_to_ump_midi2(const struct snd_seq_event *event,
 		break;
 	case UMP_CC_RPN_LSB:
 		ret = fill_rpn(cc, data, channel, true);
+		cc->nrpn_set = 0;
 		cc->rpn_set = 1;
 		cc->cc_rpn_lsb = val;
 		if (cc->cc_rpn_msb == 0x7f && cc->cc_rpn_lsb == 0x7f)
@@ -861,11 +863,13 @@ static int cc_ev_to_ump_midi2(const struct snd_seq_event *event,
 		break;
 	case UMP_CC_NRPN_MSB:
 		ret = fill_rpn(cc, data, channel, true);
+		cc->rpn_set = 0;
 		cc->nrpn_set = 1;
 		cc->cc_nrpn_msb = val;
 		break;
 	case UMP_CC_NRPN_LSB:
 		ret = fill_rpn(cc, data, channel, true);
+		cc->rpn_set = 0;
 		cc->nrpn_set = 1;
 		cc->cc_nrpn_lsb = val;
 		break;
@@ -975,6 +979,7 @@ static int ctrl14_ev_to_ump_midi2(const struct snd_seq_event *event,
 	case UMP_CC_RPN_MSB:
 	case UMP_CC_RPN_LSB:
 		ret = fill_rpn(cc, data, channel, true);
+		cc->nrpn_set = 0;
 		cc->cc_rpn_msb = msb;
 		cc->cc_rpn_lsb = lsb;
 		cc->rpn_set = 1;
@@ -984,6 +989,7 @@ static int ctrl14_ev_to_ump_midi2(const struct snd_seq_event *event,
 	case UMP_CC_NRPN_MSB:
 	case UMP_CC_NRPN_LSB:
 		ret = fill_rpn(cc, data, channel, true);
+		cc->rpn_set = 0;
 		cc->cc_nrpn_msb = msb;
 		cc->nrpn_set = 1;
 		cc->cc_nrpn_lsb = lsb;
-- 
2.43.0

