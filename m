Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794142204;
	b=W2bNHO7DU+zxUt40/zl9c/DN93fwyxhbxQ7ivVlbH8fpTJWah1MLhxjayMteIzTVh3h8
	 dpp+SyGYfV+cZhQYKsE9FKq8e2z4F81lHRPc0KMIcmKELvtE4QHZnwnJVohL1bQB6i1ZO
	 f3ojq/jTlT01dZioQnKUyx89Tkm5kLLujxV0qKn9TSP89KmNc1nVsbsuYm8dT4OWktcfX
	 NqxdZJyRU3Kjkb8Hbxe35vD8ivDrH8lD+9h5vzaNbHqDB4rYMvqqj2mGY5sXFR9SyllM/
	 5TBrza+OFAhAEoG9vcNuwcyx1gQ6We4SNMzRigR89HRfjIX0HfjXzt0uWuR42LRMJNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794142204;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oJfGnvR++7Vf1CBC+n/pTwXWA1qSah/VZzevfV91S/I=;
	b=GM8Ziv6YxklZiyVDwmE0OYbaOpkcVOMTOfHUdKNYSkKXNf0sgrrBiwIvKqdhCO4OIhDg
	 HtIKZ7y6GMWIgvpvfszIq1FnQ+dw93mfrbSA+K4x1kLMXsVn+GGj4iiRyJQEQn/CxnY8C
	 TtJBlw7ntnllLLwlHQplEx8sEVUtaYIxYQN97q9ijFi/zjWA6wevF9H9xE6oRIvuxODJ8
	 q+yQg1Dk6pnbMdBF86Im6F1S67lF420aCO0p2ToAiSclWIvcKFPsnUespPuOhokQmM+hB
	 VkK6pPfI2V0T4xkhwRFPWae1dyRRk+eQjpbL8pXYkFxAlZLwYFb07jWDfpMY3ayWLwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vietNS6N;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF995606A322
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 12:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF995606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vietNS6N
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36f8cdd30beso184440eec.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 04:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794142203; x=1794747003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oJfGnvR++7Vf1CBC+n/pTwXWA1qSah/VZzevfV91S/I=;
        b=vietNS6N5zCsXv6MLfVJkKW9Da18RJa+gqmlpEKL3gTzyuenpPTs8Flg+8jYPloUwr
         QKxqjzIvVYnGgRI0CEJdbogCArqwHSilB7AI/kAl6NlhcH+EtjTFdw2W2RywsB3rh40s
         Bnn//LrSSnqlq+58nWsayWK/ofII7wwbdWPbF2T/1lwWnm2yEKEb6A03pJif/gb2G7h7
         DI3eXF6KBpW0zQZqamjz5TAFCZNLJuEzPod3UXSoM2fUxjOLQB5aOqShpV0KTbAhV2fS
         LiU6SwIA+bYlmAvJ9M/ux2wVmaq4rakvWSI1oDiW60uPtRgbeCvWjg75E9BbrUE6JGeO
         iahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794142203; x=1794747003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oJfGnvR++7Vf1CBC+n/pTwXWA1qSah/VZzevfV91S/I=;
        b=m96yxYgcX2lNXiidmkgdSAzkfxffhXUHnnZgfyU7JGxyv7BW85r9d6GOjWhpjJsdKP
         DULTDrpMrGDDCVIXRk9X25iK6gtoh2pprzTXM42uYgyGTvIWXChsNRS4mVIXHceIdiMi
         zK+9I1ZT4AbcWDDKp4HT7JDAn8m8WhGnOMtRQP8pgImDcGdj9bTtpleHtAeHoTxN/hWt
         2316MtnEXxJUsDKp3TZTp5wRGizhQJfmC52u7h7qSbtP6gKQhNKrUOTTDPsf6eUsLGuQ
         voudAjihFzDQTsKn1q87F8Bhml7+/1RCJ6H6PckOvbQ0dXEUJk/rY/J354wDsad3kBil
         6+Nw==
X-Forwarded-Encrypted: i=1; AL+hErEMGYMbtRkvON0lQm8H9P702oDnblJhZgDQeq3KujbxHe8iatV+8W7g9F5vyebhHAxBrjiwtJ4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HVQg5DheJafgiRUb6unHX4YDNMJumwzpx2+OqNJgFL6enwwHK
	AjSnSeRQzYDNUNvYwo9IUDxM027YlGiyAppB+QiWhhlvWxn5Mk6eLsvC
X-Gm-Gg: AYBFou2Tn+PDLL4qyusoiNefHR2hX1/fKgmN3LQWCRKAZa93CxxLy3M6jI37TtZWbZZ
	ufHpHeQvVLb2AI+5YtWxh5CxhX1fxW1bONTo0wCvP7fh5pXerxf5Nzdzz7+ZyonbjtLgftgBAwR
	6Dr6yzxZF+DqA720iFd8jOShRgcf9MBu23ejYLVvAR1SBDtxpCt3Pjz3lGaeh1EVWhi7MsrkerQ
	uGwfK53DwH6pHexLawflrmyZxxNHusRctz1lfhgadGFJGYbyRJdHvxNs3cVWaFJNQ9TL6vHzmor
	o/VWAUlR8nxg1lcRDyrECwQsOnQ8i1KvghAd3mr38mdA8RWWHFDg53UsxVBBCIGYLRQFc+ee+Nh
	jIlE+OX6BuN9LYl6xpcg74cOqrgLeMAFkVKK6+vOhPUfd5p8w8qE+ofdMONBxZtkfLhCPEBWWzZ
	N0jh2+qCUb3DX/YoURnJk9JNFOZhKmeIgHh2ka1mAp+/2+7qwCxRvRsRtICzXSgDT5AUJOvucXx
	4lwdVn3ptZoCD5DQsN4brwTdfz1fwL6mg0br80/PQbuwV923bP5oB/+DIRTECoyBklLB1+y5JSR
	bovgQJOvupv8NbZGkvPde7cS5LzW8yy47Knz0gQG636o//jHa6EFhKT9DxCbNyXeCfpob/Tmh0I
	rx1IaraVwjm5qcUWIbgclvxyaMx4S0A4GiQrsN1kP
X-Received: by 2002:a05:693c:8347:b0:36a:1d6a:596b with SMTP id 5a478bee46e88-3725e91fa89mr3067487eec.29.1794142202678;
        Sun, 08 Nov 2026 04:50:02 -0800 (PST)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37265619774sm5623975eec.8.2026.11.08.04.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 04:50:02 -0800 (PST)
From: HyeongJun An <sammiee5311@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Alyandra Zahran Nadhir <alyandra5b@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/4] ALSA: seq: ump: Fix RPN/NRPN state handling at MIDI 1.0 CC conversion
Date: Sun,  8 Nov 2026 21:47:51 +0900
Message-ID: <81e86fb562df29953314f754b1daace962e85566.1794141913.git.sammiee5311@gmail.com>
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

The sequencer converts MIDI 1.0 CC and CONTROL14 events to MIDI 2.0 UMP
with the same RPN/NRPN state handling as the UMP core helper. It has
the same problems:

- Data Entry without a selection is sent at the next RPN/NRPN
  selection, with the number only half updated.
- A repeated Data Entry for the same RPN is not sent right away and
  ends up as above.
- A Null NRPN is not handled.

Apply the same fix as for the UMP core helper to both the CC and the
CONTROL14 paths.

Fixes: e9e02819a98a ("ALSA: seq: Automatic conversion of UMP events")
Fixes: a4ff92ff0bdd ("ALSA: seq: ump: Transmit RPN/NRPN message at each MSB/LSB data reception")
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/all/20261104121508.3972314-1-sammiee5311@gmail.com/
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 sound/core/seq/seq_ump_convert.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/sound/core/seq/seq_ump_convert.c b/sound/core/seq/seq_ump_convert.c
index bac37d4ef43c..62bdef6dca58 100644
--- a/sound/core/seq/seq_ump_convert.c
+++ b/sound/core/seq/seq_ump_convert.c
@@ -790,13 +790,22 @@ static int paf_ev_to_ump_midi2(const struct snd_seq_event *event,
 	return 1;
 }
 
+static void reset_rpn_data(struct ump_cvt_to_ump_bank *cc)
+{
+	cc->cc_data_msb = cc->cc_data_lsb = 0;
+	cc->cc_data_msb_set = cc->cc_data_lsb_set = 0;
+}
+
+/*
+ * Deselect on a Null RPN/NRPN, but keep the 7f/7f numbers as a MIDI 1.0
+ * receiver does. Otherwise, when the LSB was already 127, the second
+ * message of a Null would select RPN or NRPN 0/127.
+ */
 static void reset_rpn(struct ump_cvt_to_ump_bank *cc)
 {
 	cc->rpn_set = 0;
 	cc->nrpn_set = 0;
-	cc->cc_rpn_msb = cc->cc_rpn_lsb = 0;
-	cc->cc_data_msb = cc->cc_data_lsb = 0;
-	cc->cc_data_msb_set = cc->cc_data_lsb_set = 0;
+	reset_rpn_data(cc);
 }
 
 /* set up the MIDI2 RPN/NRPN packet data from the parsed info */
@@ -820,6 +829,8 @@ static int fill_rpn(struct ump_cvt_to_ump_bank *cc,
 		data->rpn.bank = cc->cc_nrpn_msb;
 		data->rpn.index = cc->cc_nrpn_lsb;
 	} else {
+		/* no RPN/NRPN selected (e.g. after a Null), drop the data */
+		reset_rpn_data(cc);
 		return 0; // skip
 	}
 
@@ -827,7 +838,8 @@ static int fill_rpn(struct ump_cvt_to_ump_bank *cc,
 					     cc->cc_data_lsb);
 	data->rpn.channel = channel;
 
-	reset_rpn(cc);
+	/* keep the RPN/NRPN selection for a following Data Entry */
+	reset_rpn_data(cc);
 	return 1;
 }
 
@@ -866,12 +878,16 @@ static int cc_ev_to_ump_midi2(const struct snd_seq_event *event,
 		cc->rpn_set = 0;
 		cc->nrpn_set = 1;
 		cc->cc_nrpn_msb = val;
+		if (cc->cc_nrpn_msb == 0x7f && cc->cc_nrpn_lsb == 0x7f)
+			reset_rpn(cc);
 		break;
 	case UMP_CC_NRPN_LSB:
 		ret = fill_rpn(cc, data, channel, true);
 		cc->rpn_set = 0;
 		cc->nrpn_set = 1;
 		cc->cc_nrpn_lsb = val;
+		if (cc->cc_nrpn_msb == 0x7f && cc->cc_nrpn_lsb == 0x7f)
+			reset_rpn(cc);
 		break;
 	case UMP_CC_DATA:
 		cc->cc_data_msb_set = 1;
@@ -993,6 +1009,8 @@ static int ctrl14_ev_to_ump_midi2(const struct snd_seq_event *event,
 		cc->cc_nrpn_msb = msb;
 		cc->nrpn_set = 1;
 		cc->cc_nrpn_lsb = lsb;
+		if (cc->cc_nrpn_msb == 0x7f && cc->cc_nrpn_lsb == 0x7f)
+			reset_rpn(cc);
 		return ret;
 	case UMP_CC_DATA:
 	case UMP_CC_DATA_LSB:
-- 
2.43.0

