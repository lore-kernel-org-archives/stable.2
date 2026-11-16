Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794798244;
	b=iSeZaRx/KcdRb/TtvhhJkayN/LnjQBzfcv34zmALxJuAn/Un8OFBkceKmRHjcN5ctHw9
	 o7CJ4N253vOrSEveFymdazW2Q/vlijdVFzzviOOD7IYT8ePtNOg2IxD3kfquss5ym+iwn
	 HyOYpr2EuLos2eiWts6R0732eoVw247Lq7xly3tJb6nmpbv00A5bPU+/98Y6PGarp7+QP
	 6EMpX+owiSiBAvypKV2TnWae5cwP2z29Z5g2BOcbHxfPpJM581PrnFwn8d3po+G4IeFIJ
	 lIUrCPP6wseJpQJr/bQObEH5S/6rvPgK34ndRmSwbqcV0Km/vukM1eaNtc8uAfo06/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794798244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RtxdEvx2VdJyPhemxlD9laLvznIE0xM53vHAefz3Wds=;
	b=dNfsSzP6PpgvUuI65m3rpcrX64FNbCqYp6TbTWwzIlZDfFFl24UMqZlUe9h+qKQAzNsX
	 IYZJWDpK3Ev+vniz79aOyOkHx4MhJ+5nCPiIbiYINknkxyZC4PlHJgwj1ysQUTbMAJ1bu
	 UTS2O7Vt93niCgqlgIU7/VgTVkKbhN3cuAhYn7PwwHkdSyGEk+d5dsZSPKB6fyeVPxZR+
	 TcWBEmFLEbatmpGyobN/eAt8mdWICM7XBU7Cs3UpuKtN20aLubdfOn0jODSVEG56I7wSW
	 6AqcdLAoI7oLI0ghY9px4p73VYK5vi2YNCNEOI5ij3PQOWKmf1J7ME7L/FMMuUMOsuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bzvDJNgg;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A650606A88A
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 03:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A650606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bzvDJNgg
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36a315ed211so2841432eec.0
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 19:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794798243; x=1795403043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RtxdEvx2VdJyPhemxlD9laLvznIE0xM53vHAefz3Wds=;
        b=bzvDJNggqUoq0TyUa1hN7WNyA7Xjm2AA4kC2UrJ7yMrYB8dbmketv7XDbp95p336CF
         Y0HRuDTMJMUlQGYxnFRLuZzDz5ZD8J6nB4WiUeTqyeRe9EC6bd/1MHxxOv84ViTWC2Ao
         Bh6GxxOZIIvYWh5y7RuU3bNloKyB3ZHcpBTtXY0UEOiv/eFMYcPzgUqcWxWfVEqWAfS3
         txCzve78djzcTRd+Hr9clFzcb9X2HruJ42HaxKsNFn/eyzXkK0nSSyrPgijMKuHFK7/e
         UQOxf21Pvbt5qBHeXaK9VkncOoJ8LnCr45/amjLJHenTxeUtN27BQ0ANP1DxT4UW183Z
         /xEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794798243; x=1795403043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RtxdEvx2VdJyPhemxlD9laLvznIE0xM53vHAefz3Wds=;
        b=eJxCd5mhJAY4Gff/Bhljn1MB+eN2dKYYZ7fw0EY9gWdLO1sms2DbyXKcsNosXQjBtu
         xGFa7RPSDBPsHJaqsjb39o0/mp8LL/E/sLULw3PcS8JmyMcKOA7iQvqooOy1OJvnfj3x
         WyP5eNyW1xoihKr6DHN4oBKsuHfY1WkxstJnnjlU7pxndFZcnAHLVkjdwuv+/j7fUo6T
         RFknHwduD2Ncgkyy80r+ILR05dp25XFwiIq7ur5yrJsTP2Val/yXcbt5Xdg9nbIoJUYR
         O/9BEn2V/i0GxBJrPXK9jhnpKDDKUuPqQ5DuT3+PkieXTb68OjDgD2apHSV0rRFgZzI0
         oo5A==
X-Forwarded-Encrypted: i=1; AL+hErFSTTI9nkPBCKfH+GmOiIFRKZh51a2apToPHSJHjURTIgrFTZUxDYRb6R7XXKARUd/A8snEkrM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9XeXYQ7ZjzI91XrrVYGEjRz0EIufC3HaXrhDIdHpqAPTO+iylK
	HoNjcAyhEOvwDXZF1ZwOamCdC0Ur2PhRtuE5WqkuOCbVqJNpF95kqkgF
X-Gm-Gg: AYBFou2oDRtHLF7U20oupkJRLMalGYpMTf49QN+DkP8qIrEJUf5xkhUiaz2QhO8eTdS
	goe6EjeEVrbRyTPNtHOS9Mmb/L8mKrGadgUWPvrRMuo2XDz41GfQ5Ci5YkflahsgOtIkm3NeBRA
	j1g/4a7ZqmEGtZJ3SkxiDlbZ8zh6bnrBMAHrDku2+GJABbkeTKzcn0E64xaMJRPGl90bg0S+Sg9
	CUUXzdnZcPrvY+AFs5TiSq5hCAdHfIs26eNgwT4OvzvAsEo38HN4tPtsQwlz2MAL/r/m28bLx8V
	cYjqtHP/W3doDEE3hSp3PKxCp6+VbQsmpJqm1cgom/LUagvSO6Tc4K8w5gMI9LxTgmmZ+d59Zel
	oL3eJRmY6ku3JeurrVuPWaMpECOBsQJs4nCCtGy4lTTSTI9GEpyN443p9Xa3Edk//A4XdueV929
	fOw/4l8u5QYPshlb3Ggcm7WSqWJ8KtWzB0EoIpsdiNTnXdOcA65abNd/fzeCWAh77IwVjg+BS0l
	vfcwdteDKs6X4Hfzl8woo/dV6mIJhKH/8suNpPlwgQ+8GVOA9wI3tt/j92g9oh/F65we23qllJj
	xNir3aG5LAAe4frDCiv6t3e7CSRFC3LXMGLWKrqNp5nI4/0YgDc6ym/dL0qw9+GBB/RvRH9GibN
	BgbmwXsRqyWu3/YQhbDFO3kLG9/3uSRJCgpWmX/jjPXk=
X-Received: by 2002:a05:7300:7fa6:b0:36d:38e0:79f3 with SMTP id 5a478bee46e88-377e1af812emr17694637eec.25.1794798243051;
        Sun, 15 Nov 2026 19:04:03 -0800 (PST)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379508762a5sm29195595eec.0.2026.11.15.19.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 19:04:02 -0800 (PST)
From: HyeongJun An <sammiee5311@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Mark Brown <broonie@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/4] ALSA: seq: ump: Keep a soft MIDI 2.0 Note On from becoming a Note Off
Date: Mon, 16 Nov 2026 12:03:36 +0900
Message-ID: <20261116030338.422671-4-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116030338.422671-1-sammiee5311@gmail.com>
References: <20261116030338.422671-1-sammiee5311@gmail.com>
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

The cvt_ump_midi2_to_midi1() scales the 16-bit MIDI 2.0 velocity down to
7 bits. A Note On with a velocity below 0x200 becomes a MIDI 1.0 Note On
with zero velocity, which a MIDI 1.0 receiver takes as a Note Off.

Send velocity 1 then, as ump_midi2_to_note_ev() does for legacy
clients and cvt_ump_midi2_to_legacy() does in the UMP core.

Fixes: e9e02819a98a ("ALSA: seq: Automatic conversion of UMP events")
Cc: stable@vger.kernel.org
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 sound/core/seq/seq_ump_convert.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/core/seq/seq_ump_convert.c b/sound/core/seq/seq_ump_convert.c
index b35e3a50ec52..b42a7ffbf31e 100644
--- a/sound/core/seq/seq_ump_convert.c
+++ b/sound/core/seq/seq_ump_convert.c
@@ -457,6 +457,10 @@ static int cvt_ump_midi2_to_midi1(struct snd_seq_client *dest,
 	case UMP_MSG_STATUS_NOTE_OFF:
 		midi1->note.note = midi2->note.note;
 		midi1->note.velocity = downscale_16_to_7bit(midi2->note.velocity);
+		/* a note-on with 0 velocity would be a note-off in MIDI 1.0 */
+		if (midi2->note.status == UMP_MSG_STATUS_NOTE_ON &&
+		    !midi1->note.velocity)
+			midi1->note.velocity = 1;
 		break;
 	case UMP_MSG_STATUS_POLY_PRESSURE:
 		midi1->paf.note = midi2->paf.note;
-- 
2.43.0

