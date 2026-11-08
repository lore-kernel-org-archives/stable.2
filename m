Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794142200;
	b=YPad+MuZ+0OYqBxTUaeJpP5EQztfPTymlGV2FwShQjW0pmbu+3t1zfmWqlBDC/De6bha
	 6BIu5Qreu+H/Sbz1Vbcuz98yZ9UGIJ6B0+LqJRsVFwVIv6LIGCtpRL/Nq3ZgCsa6/kZU7
	 LaS6dO3YAbwvKEVafbfRUVklTFDlmmdDZ1F5Kcdx1RIWEO8hRREjIdpjEmbLbgfmyMbR2
	 7e+ovpH6OOpPdcQueo9twOhaoqd7rDUVUl5E51y2TVQRvrwv8clvhu+M+gK4pp/WrrP2q
	 gVYeke6wYCrCDkup5PtTwUFW5EgwCC3aR8hzSNyFKhcPfMYUemzaDav1LyM1VstVlLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794142200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IoQo8Ev145zYNI4sJvqMfjocFsM1lzUVt+7IcsLfNeI=;
	b=5Xw5lrPur6QSG0QTr7qg8Qb9c39jbysmpXQSAIsDJimmGCuE+DVEdAtDN+jM6yDh/wx/
	 v07FA1qEbBpawnXn2TTWIOYSF2GzrmG/SriHy1ajFidCvMjaMaiSWZKI3Tzc6bHB3dJ21
	 EDfa2c5LKNoj/YjPuHwvwY61YETdf5L/e1/wekFAz5Y7RgZj67Z+c4kbbeL2pJYSsfivz
	 l5f0G6cFJ3FCyIRL97W2+8zpRW2y0T5Om6PePJrzwwaQ1XhL83oLrCyPOjnvjcUgESo8+
	 2wWOfSN48A4om87kJmttFbqjR0DbbQ8n687vwtlwfyceMQOmTuoFdBlOfUUhi/W+4dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lLBr7vtG;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EFA606A320
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 12:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6EFA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lLBr7vtG
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso151919eec.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 04:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794142199; x=1794746999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IoQo8Ev145zYNI4sJvqMfjocFsM1lzUVt+7IcsLfNeI=;
        b=lLBr7vtGw530+wSxNKJt1/Rzs4ZWTAXW8Gk37acorxBOvVrfjgLEr1lWuz0YVWNPab
         uJrAAAZ108ffE05Rg846q0OpNwJi+PUPWy4aGiPaGCmSQ6abvMABNUiKRSIN0fr9ia5a
         jHR674uy28Re5cCriHy7M7G7397l/E16ou3wg2FuDdtv7ST30nQ4O2X3M2FTS0lNF0A6
         qmL/a2iycOy10e173BwAN5dNGaFzcgg82hjm3ynN1NfWddQ9xTSyx0U8gEJAcNp/5yiU
         acD05jL6beHD+iuH63mbZNUhiB9OWEF5E4Fz9ky16doz/Mu0sq2NrNLIpuMgf4Rp6Yak
         874Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794142199; x=1794746999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IoQo8Ev145zYNI4sJvqMfjocFsM1lzUVt+7IcsLfNeI=;
        b=GPAA3swjSDw5fxr5eERYKhjjptrwRJYFA7KBkjZY6CnrE9g2rzirBTtdq6PP2Sa9Rw
         SORuUrDdsBQe076VqkXtiVODObWRQwm9sf27nsreEpL6okNZfqbOCqf/1auFKJFbnJLA
         DKCnYPvexambDCywUgIdiMWKpsIjShRotH5nVu03m9Q79ovDNSGawI+922DQG44QYE9y
         IwJacEbmZD/T5E9mCvc5qZv3+6VzBcRiGOcDU48wv5jRyH+VZX/u0IvpWH5sUfhgWTcg
         ZBxpk48BE6t33frHzZj8SDJyjZ/blzAUWvDnojVV8okpUeyHntlGy3qIsZz6/k19voVZ
         f6Mw==
X-Forwarded-Encrypted: i=1; AL+hErE/COm5Z1wgT6XnXVxzJHkv92hJOm1SyH6jH0OrszhE2lOO+fxlcfLfkjvyPaBLf8/cSdq/l6g=@vger.kernel.org
X-Gm-Message-State: APuU4Z8QLB8iP6bpp+barv/ZwBILkSge9g27XUD+HPBvxjPmCkstOvqV
	IhVb5FE37JzAsoObOpsV7vVrP2vi5b7EMFp4z+LvjwEqmD1hmYecwTka
X-Gm-Gg: AYBFou1AW2pCz4IJ/oP7ph6KGvZkkZr6JfxqLsOpogMZNC/fhqLGROFB6wCWYf5By4F
	mSeam5dibfdnk+i1vwO+ySg0ZBOppKwp6e6RYZrn0sIlzG8DKOImB3dB9FKYf1fYKUgSKY2pY3K
	gOdC2Sfho1c8b91o8oMxBSZJFYIZTt0eDbPu46+9TDx5rtTXJxWK+QV8T57uY2RHheGMgqX3Hdq
	ToAahbex25eO84Qh5X44lmTUn9AUtcsZMeabG3dyrgDbTk/RD3oExryBNjf9xBm0uIh541nF/yf
	laK0snp63GT1O1L9jA1cIiDZEThXw2L0n3Gc2PdMEmXPZWlcDWzrgRqpO/RTZHLWYOkjgjRaSVM
	cN1XRkNc/G1KG6iQHyvAwISsd3Lm1YC/b9ruBZ6bnb012+Dpb6KaDJQ4wOj1U2ooyqo5ofDG+co
	ljRXqPWOYPoQSr9jK8R1wdZLFoDJbDVgS9YfLFEjAxQwebg/UZyqOkRcol/P4A2b4ZODzR2/cLQ
	FY6KwLzhaBcOQMvGFwXVDklDzoGXJI4OEzEHdR0nr7P4+l/8g1aQiasiDDd90XKxnkF6q2vsTTk
	jUqwEi49Ca2muXUDx7kXIacwfceUC8UenMLvTD6NAIMnryEVlyKE6uNTQoBFW7zvcJLCDIq375a
	0eErRbNcIcTaBnFmTv7Ux7Naa7cMFSdkgNEsgKeRi
X-Received: by 2002:a05:7300:f788:b0:35c:f667:8b9a with SMTP id 5a478bee46e88-37256038776mr2762386eec.6.1794142198756;
        Sun, 08 Nov 2026 04:49:58 -0800 (PST)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37265619774sm5623975eec.8.2026.11.08.04.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 04:49:58 -0800 (PST)
From: HyeongJun An <sammiee5311@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Alyandra Zahran Nadhir <alyandra5b@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/4] ALSA: ump: Fix RPN/NRPN state handling at MIDI 1.0 CC conversion
Date: Sun,  8 Nov 2026 21:47:50 +0900
Message-ID: <22377a352b928cf3db750c32daf54250fb9477ff.1794141913.git.sammiee5311@gmail.com>
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

The MIDI 1.0 to UMP converter keeps the RPN/NRPN selection and the
Data Entry values per channel. Since commit e6ce8a28c768 ("ALSA: ump:
Transmit RPN/NRPN message at each MSB/LSB data reception"), a CC 98 to
101 also sends the pending data. The state handling has a few problems:

- Data Entry after a Null RPN, or before any selection, stays pending.
  The next RPN/NRPN selection then sends it, with the number only
  half updated.
- The fill_rpn() clears the selection after each send. A second Data
  Entry for the same RPN is not sent and ends up as above.
- A Null NRPN is not handled, and its data goes to NRPN 127/127.

Keep the selection after a send and clear only the data, and drop the
data when nothing is selected. On a Null RPN or NRPN, clear the
selection and the data but keep the 7f/7f numbers, as a MIDI 1.0
receiver does. Commit 50a6dd19dca9 ("ALSA: ump: Explicitly reset RPN
with Null RPN") reset them to 0, so when the LSB was already 127, the
second message of a Null selected RPN 0/127 again. This follows the UMP
spec (M2-104-UM D.3.3), which holds the latest RPN/NRPN numbers and does
not translate an RPN/NRPN Null.

Fixes: 0b5288f5fe63 ("ALSA: ump: Add legacy raw MIDI support")
Fixes: e6ce8a28c768 ("ALSA: ump: Transmit RPN/NRPN message at each MSB/LSB data reception")
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/all/20261104121508.3972314-1-sammiee5311@gmail.com/
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 sound/core/ump_convert.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/sound/core/ump_convert.c b/sound/core/ump_convert.c
index fe7d3ee3c6b1..2f19efdc31fc 100644
--- a/sound/core/ump_convert.c
+++ b/sound/core/ump_convert.c
@@ -288,13 +288,22 @@ static int cvt_legacy_system_to_ump(struct ump_cvt_to_ump *cvt,
 	return 4;
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
 
 static int fill_rpn(struct ump_cvt_to_ump_bank *cc,
@@ -316,13 +325,16 @@ static int fill_rpn(struct ump_cvt_to_ump_bank *cc,
 		midi2->rpn.bank = cc->cc_nrpn_msb;
 		midi2->rpn.index = cc->cc_nrpn_lsb;
 	} else {
+		/* no RPN/NRPN selected (e.g. after a Null), drop the data */
+		reset_rpn_data(cc);
 		return 0; // skip
 	}
 
 	midi2->rpn.data = upscale_14_to_32bit((cc->cc_data_msb << 7) |
 					      cc->cc_data_lsb);
 
-	reset_rpn(cc);
+	/* keep the RPN/NRPN selection for a following Data Entry */
+	reset_rpn_data(cc);
 	return 8;
 }
 
@@ -397,12 +409,16 @@ static int cvt_legacy_cmd_to_ump(struct ump_cvt_to_ump *cvt,
 			cc->rpn_set = 0;
 			cc->nrpn_set = 1;
 			cc->cc_nrpn_msb = buf[2];
+			if (cc->cc_nrpn_msb == 0x7f && cc->cc_nrpn_lsb == 0x7f)
+				reset_rpn(cc);
 			return ret;
 		case UMP_CC_NRPN_LSB:
 			ret = fill_rpn(cc, midi2, true);
 			cc->rpn_set = 0;
 			cc->nrpn_set = 1;
 			cc->cc_nrpn_lsb = buf[2];
+			if (cc->cc_nrpn_msb == 0x7f && cc->cc_nrpn_lsb == 0x7f)
+				reset_rpn(cc);
 			return ret;
 		case UMP_CC_DATA:
 			cc->cc_data_msb_set = 1;
-- 
2.43.0

