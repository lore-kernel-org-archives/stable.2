Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BECE185B48
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 05:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785042974; cv=none; b=qKUGGUArONncBHluPhVOelVzweDw7AzlGU4+tUBR1Qw52GVWo2gXxIFBbrZf786mcD1gU4bCN+Lrv/qLKCio3NLqfb56a5bbx7qieQnEcxZtoTurakgBH9RHGONEj3kTlbMq8fPqsEq+D6UxflGl6BqDWXDqnkiGscjTzhLJYvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785042974; c=relaxed/simple;
	bh=FSsKpjSjDS1jjsCPMaaxnqzvzutlum7BEe2Cs6H2UFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mRPM2qkykZMXVJcX65QzVoBpVstxJICscg9xd9R3MftkKJc8KHIXelo3qPNnfZSSgU8Xl50pTqHWK/jQhcA3/I+g1md6kIhEX8Ly4WUjpmfCb2iYhmeqs6xtRN5XStb6JIZqfhBC9/0C5s9yhDc+R//H4HciuZW83wuslFiHtOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=jrFVbfy+; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="jrFVbfy+"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso2031541a91.2
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 22:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785042973; x=1785647773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MR44RvrBLwtM26YzEUTXBxK1nPlOeDDDz3ordz0nwuw=;
        b=jrFVbfy+/+7RmC0a98Aetrkvr9dTv/KdRbiG8SNBeZP4hNz2d3ryw/GFxXnBs4NREr
         aqoaTgIJNjUEA+JsnCt4Rtvvskk/iofXU9L5I4AGYXKLpmArtNQvkfCooIgZh1KR6lyQ
         P5arXYQpdMl5xdwej5YBgeDi/opzYK8TBjI0GeEG2GQghdoIIZ6mGygoHR85Qy/HyMOg
         T62SABt3umQ5uZxqnA9cSaTifgCoH+xKeJx+Jz0gIBHKFbbowNEPuGKTQyIzAINNi3i/
         33ERB0lmOp+oDaisDNQ8y+yxIGk3CrcoZlOdb6OO2tKTUt05DAPxysehg+qEjOv7at1k
         bkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785042973; x=1785647773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MR44RvrBLwtM26YzEUTXBxK1nPlOeDDDz3ordz0nwuw=;
        b=UyvTy7DKDBJdIcjHvr7cPPIiI/rWf4qrXj7FbFFxZjGZmNb11BLHhfQQLNZoQa6yKd
         ytNON/dcNNZzpgQVZBOLYn4XLjSErqU4U46BnQzG8cNAlBWSaYCqck0E4Ic1rzYDdqLL
         LsTG0TVwYK6WRq0qwtD8K5KPpy44nVMwCM9jS1LFaQyHBZIczcBqTiAeDvi8R1ZiW+rJ
         19djZvLL/AsgH80yiUCEG8kAbLZOXC5NXuCGE6n/ocy+Col6WcMmIeYKdS5zvuhGih03
         iB7UcnGwsEogLlbNDCkbvvNlhr9Xm5YNYjWZIGyrwlEr1gIB1FsL/JpDdOVihGKTuigw
         /xvA==
X-Forwarded-Encrypted: i=1; AHgh+RoYCKW0RPbRZEDCf2e7EBv9SvUbRsPVwNmHG2R9EeuIS3D1bg/9Bp6GzEvD+sMGlEruxnYoggo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzigfOCdXN//zTUZ/eK/9fszBytL1NRS6du76BLx64llhcmLaWQ
	O5OLJAaP35x8frgzNjbh63mOaCxVuyjch8mv8zDU8mPGurkALxUkf7jN17JuykZcQYQ=
X-Gm-Gg: AR+sD12ejrf/VW568EF9Z0xLbxU6vQZ9SkQ/rNlKF760279Y5qlhK93Hf9qJHNYgtBY
	NzS185/RgjtRVc+x83SQnlg7DWs7k6OX0HC5FOcIOuh4RiN3WE3A4ygZkGAzb//Ju6JuITBTNh4
	3/+OwwC0+blyrqc8I8mVAKYjk6yTAGdc088e0mRfMmXsiKsi8+ufDnV+e9JmKwP2jZISYcvN2OC
	4Z0YfuGOTJFUE+ZB9Sk2Z7tQ+PyY2nFKgCcC6P9MiR2Fc3yQQpE4lhwu3oZ7c30pRBDXJ9CM02Z
	lox4WjhyBgvORXR1pQdXNsMUEiOWWZBgNbMLEf6nDm3b/3KIKVyCa6LOmD5C7y/4fpXU5gMBqoR
	g0xJ3g+FGta7ptyMg6kcySfrezgb5il+zaD9G4DgvwAM592kIVtyiPX5wxVGQTybzex6WvsRnkB
	LIKdpviCODmleptn+aXcfugT1vVl20YyOoMkeTFRTDhdTJ3MXeyqKLkgRWdmtn
X-Received: by 2002:a17:90b:258e:b0:37f:9ce1:cda4 with SMTP id 98e67ed59e1d1-38f29641b23mr3989545a91.26.1785042972540;
        Sat, 25 Jul 2026 22:16:12 -0700 (PDT)
Received: from localhost.localdomain ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f21759950sm1366693a91.0.2026.07.25.22.16.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Jul 2026 22:16:11 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: linux-sound@vger.kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	federico.kirschbaum@xbow.com,
	Baul Lee <baul.lee@xbow.com>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: fix use-after-free in ump_to_endpoint()
Date: Sun, 26 Jul 2026 14:13:37 +0900
Message-ID: <20260726051337.41124-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

create_midi2_ump() registers a card-owned snd_ump_endpoint and stores a
back-pointer to its per-interface snd_usb_midi2_ump object in
ump->private_data, but it never installs an ump->private_free hook and
never clears that pointer.

If a later step of snd_usb_midi_v2_create() fails, its error path calls
free_all_midi2_umps(), which kfree()s the snd_usb_midi2_ump object while
the already-registered endpoint keeps pointing at it.  The created
/dev/snd/umpC*D* node stays exposed, so the first operation of any UMP
open, ump_to_endpoint(), dereferences the dangling ump->private_data and
reads rmidi->eps[dir] out of freed memory.

A malicious USB MIDI 2.0 device that makes creation fail after the
endpoint is registered can thus trigger a slab use-after-free read on a
subsequent open of the UMP node.

Clear the endpoint's back-pointer before freeing the object, and let
ump_to_endpoint() tolerate a NULL private_data so the open/close/trigger
callbacks fail cleanly (their callers already handle a NULL endpoint)
instead of dereferencing a stale pointer.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: ff49d1df79ae ("ALSA: usb-audio: USB MIDI 2.0 UMP support")
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Reported-by: Baul Lee <baul.lee@xbow.com>
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 sound/usb/midi2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/usb/midi2.c b/sound/usb/midi2.c
index 3ec633291772..83980fb83ac8 100644
--- a/sound/usb/midi2.c
+++ b/sound/usb/midi2.c
@@ -329,7 +329,7 @@ ump_to_endpoint(struct snd_ump_endpoint *ump, int dir)
 {
 	struct snd_usb_midi2_ump *rmidi = ump->private_data;
 
-	return rmidi->eps[dir];
+	return rmidi ? rmidi->eps[dir] : NULL;
 }
 
 /* ump open callback */
@@ -685,6 +685,8 @@ static void free_all_midi2_umps(struct snd_usb_midi2_interface *umidi)
 		rmidi = list_first_entry(&umidi->rawmidi_list,
 					 struct snd_usb_midi2_ump, list);
 		list_del(&rmidi->list);
+		if (rmidi->ump)
+			rmidi->ump->private_data = NULL;
 		kfree(rmidi);
 	}
 }
-- 
2.50.1 (Apple Git-155)

