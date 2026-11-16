Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794798242;
	b=Q04+L8hIBIYqbbaQwdzz5jX5pbH6nPsiVcG1UTApSliZUY5dLRuhnhfT51O0OYI7KqVe
	 W9esjvXZuUhjCjcHnqJNqaZY1Si2F2Mh0GPgf/nJiEtWmx1VlZONgaG6EoHqOJ5tFrQfX
	 6faFxLkRKGZxaHJUvCkw19VAzD3X9Q3uGaqdq/TPkKNWTtbAs8RY7s46+lLYkOoktohSt
	 PgU+RWbglCBk4kNFWdnxSwDNd8nPxT4odFAk9kh6PZrtIEsXXoneINWa73E7dy5Mx3YfP
	 /BeCBusV+ZARPlGUg3WVt+NR0iiDeUhL3/TZUCrglV+KnsA6pFZ76e+wFt/1r/7gjVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794798242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tilAlplfK1rw0akhzzldbfcTxnq5HziwNFLGGQNriOc=;
	b=Mlh/BOJa5Zzef9+6D5Mabb1dSl+QeCLLApwMBsonTDhKWxKWi7vz7M2EWafY47cEZU0J
	 GxLGaKrTQzsPfevDax3doQm2VvWsI7pPCfr/QQZ9z/XUwMALOGF/KzSYIfXPSeoKc9orp
	 9zuS/hQO6W0+SZyWVKdu+v5tbio5uJQLegYuVnWV5Oq5rckeLfMEocc81iGsBufL04x26
	 Ui0qu/6VNrtoxhizeIbAblG9fO5t46lyh8h4tAcCCQpw+ZtU1+Ca2YpkpzUPfHkIvusRt
	 KPPpoqhnZtogOycfeE1xCLxitQVtX/tiXrgILw9JkZfnM5GELBeXoKIYIo5J9XHxL7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ybKS4G7a;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582AC606A337
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 03:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 582AC606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ybKS4G7a
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-33fb4680717so8219700eec.1
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 19:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794798239; x=1795403039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tilAlplfK1rw0akhzzldbfcTxnq5HziwNFLGGQNriOc=;
        b=ybKS4G7akInIdfyuopW0i7MzNAHHhFJs0VsmC1NaI3dodJUHEUeD9GYw5jDoc+Y+2z
         bKKvyev8t+msX/NArlcSHiHRiup94Bi1hrRxuyVIkSvo+7Wonh5p74vBPp+lXf4d7LQW
         hShCDEQfRFUF1svOwlYaosXNmsH80bj5XZq6ahsAP6h588kapU+P0aR9tY7HIVpUTCgd
         4Ul9sfPta+4Yh7qS8ywSa9NKPMo3dNcLMvI4+qhstc9eqPUKqHcdSINel9sK/jBjIoNG
         yWebFEGEZjHkpDb1Yr7B+HqM6uMWF8u0qzt++bWztvlpSQHLd2gLXR69BpV+MgqIyrHI
         6M2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794798239; x=1795403039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tilAlplfK1rw0akhzzldbfcTxnq5HziwNFLGGQNriOc=;
        b=fiyM7QFeLoV6lo1K3K4fE8yT9uxKMyEPuLG7gHInGwXIc/+ST0FQN/aNuPmnzcqYcU
         zdIqIHJPq1ORsl9gtAk5guga8k+Weuc2e8josUFTI1DgupkjL7iVDEfbjhcgXH6lPlb8
         BB2s8ICStH6nO+O5A2e6Eiy7CxZL+NH+hvE1Qakpuh4rejdOEpQQ2+4sK0U4SFz2tPkx
         U7lypw6JTJi4WyVHwHm86dydQezvxq34ATCV2MVmFxYcWMhTy6Xh75xtrm1e2bThvmZV
         IA2tQmPdEW4M9YdnGTBff91jR9ipTjDaG6g8QRp7ywMXSb3FK1rcx+UGTE1AkHOm4Ids
         s8pg==
X-Forwarded-Encrypted: i=1; AL+hErHcGjbdT88Apaexg+f5W2jwOnrZRykXWC+KfmDN00BeakXZEAyqgxIzBh3JVI6dQBX6zIEyy5M=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gIpHRQ7zCIuwxDPiowwNcTVXXVb/lMyMUjC6EseH6HpEAztJG
	tFFoBH6QO2nJbbCXmKfKyRkNgke8pJMW+gVp0t9P1+g/GBYNVuJGd8aV
X-Gm-Gg: AYBFou0KJtvaKeSX+oDU48MP+DKfKzLLvQvUiZAtNqJpnx2p6zotKdTUaypCII53Cbs
	FnIOAGWkiz9oS3NFNzxm/20fcSCCrfkfkcjo7Fd6r7ogUThRiyt/P/qZcvlnzZCykS/0mtv4tNa
	5d+We+qLDr7B86d1RN5NBtLC1xfdmWnon/Eu0nTzYomx4rs/4Gzp8UXhzk5hw8pVhEtw4BI06C8
	6IsWvaGEDS0rGNc5k6jpHJTrshEgy85IAGVZ90hXgvSzTQWFJxb/AEA8zo0CRTPte7ViyM9L5Oe
	g5DtsOMIkeHOnP6OUSaEcEpHIDTLvC2ao+mmAw6w5Qed6Xe7FFNc57D9PBydK7pyl6dIUGrYVS8
	lRKAqjI5sbWWrVhti3eWjtP/n7RiAhgojUdSXfS8UbaxBRpvb5ucRTYzPvv+VuGARYRqinRtQ6G
	94cwOXCzlbZvyXs1qayJ/TuH/VTQ/TD8Z1lrdFLUERXQvc705cF+tvxcN9m0VwrrxzVoT6wr+Yh
	jQtvcwhXjGkYyc3imnZmx7D7WPPm2VsQW7b62mpn7OeWDj22PFgctVexWEKPWyT2xZ1bUQEX/1Z
	HE1FYJqUpxr6Mr/Q/7kYAEJTVa/63DOav8ILfqKVTYqwBdhRBd2fNtNqSkvt6DrZP3VV8V0O7r4
	Q/Z+ibCpsggWoioFW+TH1g0Sj4RNkZ9JInEHVOlsMiq05E2wzXG536/SfI2mXzQ==
X-Received: by 2002:a05:7301:1284:b0:36a:1e0c:e28d with SMTP id 5a478bee46e88-3796395410dmr13036616eec.4.1794798239386;
        Sun, 15 Nov 2026 19:03:59 -0800 (PST)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379508762a5sm29195595eec.0.2026.11.15.19.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 19:03:58 -0800 (PST)
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
Subject: [PATCH 2/4] ALSA: seq: ump: Convert a zero-velocity Note On to Note Off for MIDI 2.0
Date: Mon, 16 Nov 2026 12:03:35 +0900
Message-ID: <20261116030338.422671-3-sammiee5311@gmail.com>
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

When a UMP MIDI 1.0 client sends to a MIDI 2.0 client,
cvt_ump_midi1_to_midi2() passes a Note On with zero velocity as a MIDI
2.0 Note On with zero velocity. The MIDI 1.0 sender meant a Note Off,
but the MIDI 2.0 receiver gets a Note On.

The other MIDI 1.0 to MIDI 2.0 conversions send a Note Off here:
note_ev_to_ump_midi2() for legacy sequencer events, and
cvt_legacy_cmd_to_ump() in the UMP core. Do the same.

Fixes: e9e02819a98a ("ALSA: seq: Automatic conversion of UMP events")
Cc: stable@vger.kernel.org
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 sound/core/seq/seq_ump_convert.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/core/seq/seq_ump_convert.c b/sound/core/seq/seq_ump_convert.c
index c248d87f7a83..b35e3a50ec52 100644
--- a/sound/core/seq/seq_ump_convert.c
+++ b/sound/core/seq/seq_ump_convert.c
@@ -380,6 +380,10 @@ static int cvt_ump_midi1_to_midi2(struct snd_seq_client *dest,
 	switch (midi1->note.status) {
 	case UMP_MSG_STATUS_NOTE_ON:
 	case UMP_MSG_STATUS_NOTE_OFF:
+		/* MIDI 2.0 doesn't treat a note-on with 0 velocity as note-off */
+		if (midi1->note.status == UMP_MSG_STATUS_NOTE_ON &&
+		    !midi1->note.velocity)
+			midi2->note.status = UMP_MSG_STATUS_NOTE_OFF;
 		midi2->note.note = midi1->note.note;
 		midi2->note.velocity = upscale_7_to_16bit(midi1->note.velocity);
 		break;
-- 
2.43.0

