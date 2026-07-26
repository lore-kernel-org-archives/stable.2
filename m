Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F9A37AA6A
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 07:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785051906; cv=none; b=RNCqtn4D+OA+2O0PT2zQjSnHPOpFd4jTx4DzpJpnQ8fubn2UmnP+2gNAL59lIK6NT7l6xJ7R7smQpzL8kkbwLu1E+e9hU5gl5CcPKJ7tfpCFU11YbR54B0m0kNicZZJYDPGy7rGPeOD+tc4l4F8ba3SewlzdEOUeHM9my8XcxyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785051906; c=relaxed/simple;
	bh=o4sS3pNcMrPIt5lAItdgt9pdc1g3KpcfFAAG3Ro9GY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIMNPWmwa7MGtf2l3Y/JsBmmyqFNH+nUJSK2TmVU92sLdPh5Uhh24e8jrOieyRWAgSWSgq1Poy8HVfXrkrPJlHYmwJbY62I/180+cLkG1IQo4fJ38A9h5Ek/PX8SyyiKrYWaihuJSUjWHISFSZnqkXlPto9thcwS/6Wf0e3W0Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=YshoKKOF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="YshoKKOF"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ca64c3ce5fso20883025ad.3
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 00:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785051904; x=1785656704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QIOw3G9cR0WlaOF2E7R+FHWgkAS7O5dwSaIK4mjCqdc=;
        b=YshoKKOFSHwP4sMZIX1vbJT2yOpa7eI3CfgLaSR+qw8JVHjig2EjX4uJO7bFpd/cfb
         sx93jwKoG15vRcTVxq2g+xUy9gWL3jnte5l3u4fxbHlfR2Em3zwjY2vnimEZ6hTSiNXj
         0Ovj8uFRMdlFrMN0fTfcuWsh9zc4OwWQriAn2p+reVqp6luc+9OH0Ecb+ajeaaEc29vj
         IPyxUd0uZAtaAu0UD2zPVs395CfeqgAAVVsVPJGb7vpcZKt2iRLimo1PQLd3Nwe9JcdY
         ytoI1MJ/1O/GuWGSPMZrOTJsmqc0AMNlmAzZMlDOzy1rwBqrSYVjnOzu9Rf2Nh9Y/JJV
         nDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785051904; x=1785656704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QIOw3G9cR0WlaOF2E7R+FHWgkAS7O5dwSaIK4mjCqdc=;
        b=WjE9d6IZY4x6ISH2WKgILn1Y/zigJq9WebDNtECV8Xe7FOXI6KYx93DVbbdrwE4WAY
         3IjywKEeEQXQ60OITcKV5YjVW1YP+2AQGXisTdZDRWu2PUmY/N+mUGRXMidngl564sCu
         BzUb1GyjEKmGGpAuaFArJFEbhHSEqxIW4Ffz3aqpJIogIuXH0PxubamrGpJSRIKJk5gd
         J5uIiokeFwhTUEAxJOlxCwUH/fvnTwwB0ZagI/Rp7a/lDrLtxDGQAwt8uSECimacOzN/
         yVTgbp1oBfuTOMc7J2iAkEgSD4eU5e2gqxNAjWe8ex/v+thsDss5KCQ9WdI+9RsEwPqa
         ZjLg==
X-Forwarded-Encrypted: i=1; AHgh+RrkokW6lqi1CI5fBnHr5q1QfQgGhDRi2zp9LeXSwrIyY6JCB+HRuQg0NlAvUOS+DOTqS32Ef0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAhYKPvwLmTwTQWcj/B+/oAmHy2lWM/QaCWD1qsOsVyy8Kdsa2
	O9tOIWy0ZmhUXLopYKUlXnWEpXHEZXdC3q+rsHy56EBSbTDUcSokdgqBDxUzdn5nyv8=
X-Gm-Gg: AR+sD13wilgsw8S+T3qwTLlCZklV+QI2c8ORTq1bFmeOmKxyAUMUEHjQ+SOmNhovjF/
	sRw9VNJU0r+iKTkvf+9MjHCFxzvxDW8HwnnC05sH1jRUtbvV/xBdcbLrUdoP4l0kP6DekjBz/4v
	VyggN0MoykvngMJ8KPBaqpRE/1n1ulbX1cqCM+BIleYKsWX5YhumKD7urWhv8mnQwzJOFHiKuzS
	HInNFAhjzAUDdQ/PMlFGpvEs3hvyCRVrfVabEIjwm8j10a5s7OuifcS78Y92zsoSgVN2Ji+PcpM
	UySRKfnHJ8/mUGC5LEvUVlk7IZ7yl5LQbNiNN/7CkSKX1V7YZEEsXFgvEi2jAJIUsefD0aLX5oB
	glZJw0kodezg0fpNy5BIWCpaM3TKq4DZE+6DCDz4NMYz4cqQo+ZICpxV+0NdXqwgdbKA0VHuJid
	QrkiDXKcyO1JmoBcbL+LWkxrmnO0+hF6rcfKcbSPc8nzNIhN3FPR5BR8mfcVl2
X-Received: by 2002:a17:903:17c8:b0:2ca:ea56:7a58 with SMTP id d9443c01a7336-2cfde851e69mr38145885ad.37.1785051904571;
        Sun, 26 Jul 2026 00:45:04 -0700 (PDT)
Received: from localhost.localdomain ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7bc502sm17143375ad.54.2026.07.26.00.45.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 00:45:04 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tiwai@suse.com,
	tiwai@suse.de,
	perex@perex.cz,
	clemens@ladisch.de,
	federico.kirschbaum@xbow.com,
	Baul Lee <baul.lee@xbow.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] ALSA: usb-audio: fix OOB write in snd_usbmidi_akai_output()
Date: Sun, 26 Jul 2026 16:45:00 +0900
Message-ID: <20260726074500.50145-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260726052040.41315-1-baul.lee@xbow.com>
References: <20260726052040.41315-1-baul.lee@xbow.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snd_usbmidi_akai_output() computes its fill-loop bound

	buf_end = ep->max_transfer - MAX_AKAI_SYSEX_LEN - 1;

as a signed int, so a small device-advertised bulk-OUT max_transfer
makes buf_end negative.  The loop guard then compares the u32
urb->transfer_buffer_length against that negative int: the usual
arithmetic conversion turns buf_end into a large unsigned value, so the
guard stays true and each iteration keeps appending SysEx framing and
payload bytes past the end of the URB transfer buffer, which is only
max_transfer bytes long.

A USB device that advertises a tiny bulk-OUT endpoint can therefore
trigger an attacker-length- and content-controlled heap out-of-bounds
write when a process writes to the created /dev/snd/midiC*D* node.

Return early when there is no room for even one SysEx, so the loop is
never entered with a bound that would wrap.  The loop is the last
statement of the function, so bailing out is equivalent to it not
running.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: 4434ade8c933 ("ALSA: usb-audio: add support for Akai MPD16")
Suggested-by: Takashi Iwai <tiwai@suse.de>
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Reported-by: Baul Lee <baul.lee@xbow.com>
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
v2: use an explicit "buf_end <= 0" early return instead of casting the
    loop guard to int, as suggested by Takashi Iwai. Verified with the
    reproducer under KASAN on v7.2-rc4: without the patch the kernel
    reports a slab-out-of-bounds write in snd_usbmidi_akai_output(),
    with it the same run is clean.

 sound/usb/midi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index d87e3f357cf7..f8996416c3be 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -797,6 +797,8 @@ static void snd_usbmidi_akai_output(struct snd_usb_midi_out_endpoint *ep,
 
 	msg = urb->transfer_buffer + urb->transfer_buffer_length;
 	buf_end = ep->max_transfer - MAX_AKAI_SYSEX_LEN - 1;
+	if (buf_end <= 0)
+		return;
 
 	/* only try adding more data when there's space for at least 1 SysEx */
 	while (urb->transfer_buffer_length < buf_end) {
-- 
2.50.1 (Apple Git-155)

