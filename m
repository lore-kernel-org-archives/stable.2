Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794142189;
	b=BdD5LWpvNyYsLTAti324ZMq8nB9eVeZhdUUcrRgZE1oivxxXtQS3bdYpEwuvhaYtdKCh
	 InbmmoXYTfHqAxkQLta6hezZEHW649AUUdRgL113mbupC9ubf6WnJo0twLHmhyMCf0XN7
	 1MqbBZPTRNNFHi/LYRIFshusbP9d9p311x/TU0RJtvWhvwCtZAqRx9yHJATLXbyMe3s30
	 GjQ9Qt2zfnTUr/m++Ot67dUv7BMvTavPdFComRpsWR7IPb4YKentV1JnGnfLievwqAuF3
	 mkfbDyxruUkJXv6HjbAKw5l/Bh3ck1sP0IPhLGfAlv4j695IEGYVIykhje3v/o3rKOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794142189;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KxflWA4WOI96BKFzV6JbVT2LnPTK5JHYTV9TFwfYl1I=;
	b=Ens+bER6RIXOI42GFwZUPWzJ3WkQJpbMMXxgHDm9tu556g+AWJyyt7RZ8pEjOJn8PKjM
	 Ud6kmM6MY2usSwQeCxTXrReXw6vF53lhjAd2DghReTVXwZpUYW6HhDjr5HuXgvCRgGFNT
	 i6Ww2Z0ZkwlOlchJzyZWrsqC/rvEBL6Ocxtlf7Emc1Rtd8tNgSjge16+UvbcusuwgE7ih
	 HEjFaAK4jcA8YpI0L5OPmkAH9E9uEMmmjiCUm8n1UFZGuOORQMO4QUoYbmjcjmbzuej7i
	 RkXoyfyMeq1AEBi2cK12E7p5Lt7rAE3bjf3k7tzGajOXOB3W9ozMvH4gdtG+oWCd19Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y61DbvZe;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896CA606A321
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 12:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 896CA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y61DbvZe
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36dbde64409so141526eec.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 04:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794142189; x=1794746989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KxflWA4WOI96BKFzV6JbVT2LnPTK5JHYTV9TFwfYl1I=;
        b=y61DbvZe2lUmXfaLUEJfKZqVmCjPt+aeuZSUhBiwmJEvhKOh1+Itf3YfVdlzN7jE2l
         LLnzdiAePJG9UFfp9h8tK9d5IjbvRQ9BwEB2fGR5Kbn35vnRodj55p/yK0Y8gBaxjs2E
         t71Rn5eNEpfinLST5UzpczmCV68TwNc5SaAu9FugcxXRzmt9N/qeYM7XmhQmAShRL6xW
         4fjHowOnSzn+alMx7Q5V6ehydC/0/rMIdTXUxl9HVdeBJH1aho5/eIeNZPPimpNVaJhN
         CBYHlVR39JHK7GsKHfHWBpKUBg9LXbCSmuCP9OpBFATU3wp0QRUlAvyAf3ABeh+SnHxs
         H/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794142189; x=1794746989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KxflWA4WOI96BKFzV6JbVT2LnPTK5JHYTV9TFwfYl1I=;
        b=ITkWnQd0516mO8kmWqyTx1Jw1fvsWNRX0sTZqMUjVkTK4rZdpOTt35jFXbIIqU0XBK
         EpTWlL3FuKYVqEwlCAbzrbl+f0vSjvC4kUK6IDn5nJOXRMYYr0hC9oEUzecCFB8jHKcL
         tdi94c0ZaOKUQ+wsEJhphNGiVFprxL5gSsAMSJ2+Ki8Zg0vN6SILxzyV0T9teOpcvJS4
         aRRIaAVh8bi+nO+J4KCbW0cIm7Sef8Z7033O7MZrdKrUr/DfxxZCWCSBcqGI39FMfOFP
         8jWzwN6oAjw5NCC/b1OKrV05/i/YWytnJYY405jS2kFA67tdUC22Evi2jpO4RGOvTKbZ
         d57A==
X-Forwarded-Encrypted: i=1; AL+hErGLr8HcXptd5+uSmOyvZjt7N1cveIH3VJRdg+GbAYWnLBAz9g4lI7eTl9uz+GxJbjpJBIfXy0E=@vger.kernel.org
X-Gm-Message-State: APuU4Z8RS2RV1RhAt08C6NxGwMSmFREheRwGKx9+Dlf95hT4/RAJtbJC
	MWWu29UVkX3+EcgUkA3oo4gODWK6e7sh3xEGmM5U/ENn3vmeFlRt+/IQ
X-Gm-Gg: AYBFou2/W4RlBnGBDTfCVbnFVb5JEj6GMdCtL9GNl8etSJC/Jvsjh23SYXGOno3JIpS
	gGqRpWk7Ecmr8Ij8nA4WiazEZsGZLC3sSoHpU9nI13fQF3eyOAExYjOiL26sv2i+jnnIVa+CHdI
	eQ30nT2EjnuEv6i3O0PWcOLnPTPgESpcULXfr65c47RYQ5/mLE92rp4+FxJJKJRKPPWBtO1JgrL
	mIQT16+3sx1IKDFWxG/B4B3aylvs54c58YnkfsljYdjNy1NUIyiqhWCoeWUy8nF6Xru848ZiDoO
	+B1oG0HFTSollkpWUd2FdPrQ+an+v8rTZXiwh5tyqyd+vPgMLg4/ffbQkjVrwmrwSq4tcZ70qKx
	FPJjOmlTaPmxz/uOgvjwuwDpwuAQzkPrjWRL1Ka6SHcksKfmHXUlrwe/diVrPflvOj6aNE2gzWC
	BH+OtEwkTByKnfCRbxhqhMSXfmAmQvWlijJfJNBxAteD2GF79TFGo71yIa1eEYMBxv/fvpAOGXf
	zEpKi43lzxML0dG6mZdUHcWL+K8f66fB6fm8qRs3AZ+dNls1Tj4HWs5+6kYd/5eS3a0bf3mmhkL
	9q3OxYn8SaABO8v4wc40zLdy+b2UBPYJGCrdZo10FuKsi8M/yh697T0l4TqfiwdT5m/C3H1HAtO
	J8pD454KIIrfZcvHCZOREwiJH0yfWsRSkuid2TamZ
X-Received: by 2002:a05:7300:7943:b0:36f:64e9:f1c4 with SMTP id 5a478bee46e88-372573d2436mr3151348eec.6.1794142188476;
        Sun, 08 Nov 2026 04:49:48 -0800 (PST)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37265619774sm5623975eec.8.2026.11.08.04.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 04:49:47 -0800 (PST)
From: HyeongJun An <sammiee5311@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Alyandra Zahran Nadhir <alyandra5b@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH 1/4] ALSA: ump: Clear stale RPN selector on NRPN change
Date: Sun,  8 Nov 2026 21:47:48 +0900
Message-ID: <3ed25a99e07b8cd803f9bd6eb0f88ef00ae23f4b.1794141913.git.sammiee5311@gmail.com>
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

The legacy-to-UMP converter keeps separate RPN and NRPN selector
flags. When a stream changes selector type without sending data first,
both flags remain set and fill_rpn() gives RPN priority, so subsequent
NRPN data is emitted as RPN.

Clear the previous selector flag after flushing any pending parameter
data and before recording the newly selected parameter type.

Fixes: 0b5288f5fe63 ("ALSA: ump: Add legacy raw MIDI support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Alyandra Zahran Nadhir <alyandra5b@gmail.com>
[HyeongJun An: capitalize the subject, add Fixes and stable Cc]
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 sound/core/ump_convert.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/core/ump_convert.c b/sound/core/ump_convert.c
index ecbd894f4c83..fe7d3ee3c6b1 100644
--- a/sound/core/ump_convert.c
+++ b/sound/core/ump_convert.c
@@ -378,6 +378,7 @@ static int cvt_legacy_cmd_to_ump(struct ump_cvt_to_ump *cvt,
 		switch (buf[1]) {
 		case UMP_CC_RPN_MSB:
 			ret = fill_rpn(cc, midi2, true);
+			cc->nrpn_set = 0;
 			cc->rpn_set = 1;
 			cc->cc_rpn_msb = buf[2];
 			if (cc->cc_rpn_msb == 0x7f && cc->cc_rpn_lsb == 0x7f)
@@ -385,6 +386,7 @@ static int cvt_legacy_cmd_to_ump(struct ump_cvt_to_ump *cvt,
 			return ret;
 		case UMP_CC_RPN_LSB:
 			ret = fill_rpn(cc, midi2, true);
+			cc->nrpn_set = 0;
 			cc->rpn_set = 1;
 			cc->cc_rpn_lsb = buf[2];
 			if (cc->cc_rpn_msb == 0x7f && cc->cc_rpn_lsb == 0x7f)
@@ -392,11 +394,13 @@ static int cvt_legacy_cmd_to_ump(struct ump_cvt_to_ump *cvt,
 			return ret;
 		case UMP_CC_NRPN_MSB:
 			ret = fill_rpn(cc, midi2, true);
+			cc->rpn_set = 0;
 			cc->nrpn_set = 1;
 			cc->cc_nrpn_msb = buf[2];
 			return ret;
 		case UMP_CC_NRPN_LSB:
 			ret = fill_rpn(cc, midi2, true);
+			cc->rpn_set = 0;
 			cc->nrpn_set = 1;
 			cc->cc_nrpn_lsb = buf[2];
 			return ret;
-- 
2.43.0

