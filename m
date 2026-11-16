Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794798237;
	b=ffdVmWehVeOXAc1SExm8aFpfT6QJ26BejfZenzEw+BQJ9Qajqq+FlyXu7+yGtGleXpJ7
	 mzeMV9sDmrIbNu5YbN5q7WGgXPKHFuExlopFyyCuyKSxL/fYImQl2HJjTmzSXPLS5x2qx
	 QiaZgNv+YA41bAeUmP51+TnEWkAe/ddZmJYI/KV/VloTPS8JprWg5dGcj6EjP5w6QMmx9
	 hlH8k88KcsWVtaWco0EvP+0QXGo32W75cmVPT8nnfWzFSDyCmjlH/vmhDBdkd1TTy7Qb9
	 tHGmuV4e+UEhXsbXg2LYZZSTVHzAxcikLErAzxUZ+M9589Ozv7ie9el0/suRkTgkTgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794798237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SNeaXfTa9XrrJcc3jd4rJaGJBMOoRygkUVLasRGgUSw=;
	b=O+nFC3OZbMnuLYo5VqauZDU6GAPFOcztk/9G+VrJVVroZxqfY4gvOqgg6VXheCZD+goc
	 eK9AAuQzLXaCeVWzyxyEVfaCD8Yog8t6pNP7y+QamqSwC9Llpg3l2spBrk/Vt6PqZjEgT
	 oGuIKYOYG4aX947QWaNc9SXhxmrW63GuU6SYV7M7YJ2IKLifmj3GRaRr1uoLHVNvmE+LK
	 leANGMofqXlBxNW9zm9rx6v9NLF8hTnuzpw+gi6DW5yjoLUL6o/lKX/Bc4vQw4+q59lKE
	 81grZNj+K1W2jkwBl5X6jX4b21gOsV4i9+MtgfVRnNl4VJ6QxtMo7DBSGfCcuveuZ4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pe90he5M;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E18606A338
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 03:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14E18606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pe90he5M
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-37000e7234bso2179811eec.1
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 19:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794798235; x=1795403035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SNeaXfTa9XrrJcc3jd4rJaGJBMOoRygkUVLasRGgUSw=;
        b=pe90he5M91kANyHpOtEYXLVei3WC1v6hnxARz3LPWc+ngmX9flCf8dFGhzEps3ActE
         ufnm/3kO5npj5GS90QK74eqTir8h+5vpLwfA+cYlWN5uLa5R0Szpu38UXMVtYEaQ+WdE
         55gAdIgoEzNr/FrMY/Z9cyO57SveUqLkRJ0/3KowgS4NM3jZmMDfn99HjuvVldswJs9X
         /osx5NMwRPT6o87+Ng33GMT36pbHNouP450qaHTrO0L+vAyCgeMbdvOT9KEYnBEf30pc
         yi0Q6qGdGesBF1xABj+cp52ZrvUd4Z7cLNB9eb8TCfXgRXz/pfHPvYsFO8sG6ISfRG3E
         0tjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794798235; x=1795403035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SNeaXfTa9XrrJcc3jd4rJaGJBMOoRygkUVLasRGgUSw=;
        b=UVdTTvpWRtgcp79Nq7U0Ig42pCROOH5R7hH0TalDlh6eVz1ZBNnd2w7JhHP9ewplle
         ljNsAp5m43WJNf/ht12PZp3DzczAzuRzXfI1q1hSiqY6+GUXv1hUUHw9eTU5sDge+TRv
         uisiqq/Pin1V8rTCh0V+Zn4ngdaka2xFvaneah4n3xmL1sRoUNhEfM2gtHtCPB04YPND
         d2i6b8DqqX//x2gVz9JxZqZmlwCPLw9gvxGPD9fXfwVSR84mvzVEBkAxr9SIEEuVNiZW
         PvFwMaZ/NulZRKvc3ZQYDrwyJigv9jk+BAL1WMed0UF/BNHBwTsq/G8sTlFq+maDzxGk
         AomQ==
X-Forwarded-Encrypted: i=1; AL+hErEyMdiRjdOFSyFhGuKL6+6AVDejPBAoCU3sGy3k9eo67f6/IaJh1W11IgydZVQBTFXvOQehkTs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cYf6b8/XyW10v9EVdBHtosq3G75EaZEHpf3PwbHZZTBDNSaj2
	S4KyNlTIbsaPbPXfOLzNxjOzWGCeX9dF6f5wBVM11cbBTbQZcdjEMT6/
X-Gm-Gg: AYBFou09Gz49RcBywFxWnICmwzzYB4dij7rQKpDVOOGdw1UyR4uI72roaibnh4R7AWq
	zpOdBqzRai2588S9eHoA6MImc0I1gHHkPlsxuBuNctbZkpphtiZVB5670PQqfQt+wCqPA+uTd1/
	VCQS6LuUUT2bZYxOFxMCfo9QE+9C0Jf+vigdIvSR2G1iHoQUoYfnvNh1Qj2jYJ8W1kXS1BId0jU
	zO5n0WWjJCCAo21d9SKZwNhOMOOvjeUQYA3O1kQPpPEdCH53jC9Ir+jJwhCnEu9gmNlb/7rBAmB
	0fBGFFrfyhUr0CDAEPhD5/pJ7VBKTqRpFgR2s30lbhF0IFlYUCa4ansklpvmI5nb6EylPwzDTJB
	UV6PALxT+MIMbPEgtEJzXhXoqhsl3iw4OG+/jlMsu9YP1I2tIXaT1EnjEPp1IOjn9PvKlgbV0a3
	FdYZLPc/49qnOcGrkSrHXVbVOoVTC2enV2p2EJtj9FEJPSqaRPKf7OiLpbH9XGoAOmv/ds01BIn
	Mu6IGnB2mGCivQE95Y08DLU3lEqhzeGWpYjqIoPu3s2VKbrGRNCSvkaEhL7DgIyR/AflHOYy+lE
	Y5JuCRz5NNvHe9keRN/DFyCrmXC2lJ/pIIT9kTZ6t5SgHxtidBS/5Ip4uvIUmESAh9bRnvBm4qf
	NIIgxkHD0olgSdrdVOnyG2wkAq5O9liPXWChKFrON
X-Received: by 2002:a05:7301:db11:b0:369:fe4c:b48f with SMTP id 5a478bee46e88-3796047be6bmr8947853eec.0.1794798235185;
        Sun, 15 Nov 2026 19:03:55 -0800 (PST)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379508762a5sm29195595eec.0.2026.11.15.19.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 19:03:54 -0800 (PST)
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
Subject: [PATCH 1/4] ALSA: seq: ump: Don't turn a zero key pressure into a Note Off
Date: Mon, 16 Nov 2026 12:03:34 +0900
Message-ID: <20261116030338.422671-2-sammiee5311@gmail.com>
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

The conversion of legacy events to UMP MIDI 1.0 uses
note_ev_to_ump_midi1() for KEYPRESS events as well as for note events.
The function turns any event with zero velocity into a Note Off. So a
Polyphonic Key Pressure of 0 reaches a UMP MIDI 1.0 client as a Note Off
and ends the note.

Only a Note On with zero velocity means Note Off. To fix this, check the
status, too.
The conversion to MIDI 2.0 already sends a zero key pressure as it is.

Fixes: e9e02819a98a ("ALSA: seq: Automatic conversion of UMP events")
Cc: stable@vger.kernel.org
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 sound/core/seq/seq_ump_convert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/seq/seq_ump_convert.c b/sound/core/seq/seq_ump_convert.c
index 62bdef6dca58..c248d87f7a83 100644
--- a/sound/core/seq/seq_ump_convert.c
+++ b/sound/core/seq/seq_ump_convert.c
@@ -630,7 +630,7 @@ static int note_ev_to_ump_midi1(const struct snd_seq_event *event,
 				union snd_ump_midi1_msg *data,
 				unsigned char status)
 {
-	if (!event->data.note.velocity)
+	if (status == UMP_MSG_STATUS_NOTE_ON && !event->data.note.velocity)
 		status = UMP_MSG_STATUS_NOTE_OFF;
 	data->note.status = status;
 	data->note.channel = event->data.note.channel & 0x0f;
-- 
2.43.0

