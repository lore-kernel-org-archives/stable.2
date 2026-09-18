Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A2D384CD6
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 22:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789772278; cv=none; b=Ime36K91QZm/4aumGmins2ysoRRRXMDcr1zb3XGBxpx4diMO8nWehAowLxDq+T5+RJuiryNq9kNDlkrJCdDm7GIIEhyTVN8AYEyVKj2Z3zUSYSDcRDc7e09X8sFDJxbURHKQ8w/KVVBATj3JsPcHh4ZBJ0xB9jw/CT0QA2gu4+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789772278; c=relaxed/simple;
	bh=SDegTO856SlGdHFm7r4VDNIsIR16qwMlpHmXx0pYHDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XEIiw0xMBG9CJnyPzhKnR56rb38u55uyh4EiFwTRlFYdeHCCYl907LHIdsEnB7sk9QBMviwJP2CZLrDTMkV4ITOzQ5PVX8VEv1JCkZcB/YFX+qiwQeXcVbeeTX2tGMWpGJIA8JsOLveHS1dP7jrCnwiiqu9tx7UdBt7vbZsB7cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=cV9erDuc; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="cV9erDuc"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd53691be5so11609915ad.1
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 15:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789772276; x=1790377076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d7XKncLmtrLW+hywq1xIiUEnkxPl1olvH1vFA4vdnOU=;
        b=cV9erDuc4zxcqh1hF08++t0iRUFfgZt68p5oVdnAAKlWfQvA27E1kpGkHyXk3fcbS4
         aDWxNo24MnYc+7LMf0OhGy+graf7hYhKyBYT7MPsE9QE/1mtAUTI38IwEF/Wy350GSnZ
         4jll6xrST79/bM5+zlo4prYRDo63tE7ZFn72Fn4f0fEdf02dizgY7aiFHmZGJrcA8Cj6
         DFWr82+W+xYSRevw4Z0UpcTfLn8zfYz8JaYGO4mzJklWGZPr2noa4xFg9SPl0BgurSqZ
         TS9Jq320D0IQ5sx7h0dR3KWvwU51pir+Xjn2ktI5X6EeC5xduYL+mQIv7CSjHvctanCG
         pTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789772276; x=1790377076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d7XKncLmtrLW+hywq1xIiUEnkxPl1olvH1vFA4vdnOU=;
        b=CwkdW5g2ADpmkvBTvOI9g7wk+h/+8JCxvWeauO458Ho+rdiXPHgB9wf/FvL9BN4K4s
         ws5zhvBMeUNE5NuwN/HUE8iad2sOaBtRodVLZETkbNXGGWKhzIfEOINmaxAefSy2p08g
         JGaIYGgzqOb3l1GFL2ejKPAYpRFwFgUmblZO/F2ZQ5+AIOUb/WznC5XycDnWEC1dJ8yT
         +jkTqclA9A/G84z2Ui1gR8UEz1vmc0xLxRVSgvZxeCVWJY4tNP1+tU/CtZOBzN4P0mVd
         7oJrj+vcJqulah/NtALGjnxte4XvvlICtgYVnsQay7Jo7reSiT8+EJMjXESDwVrsxLvL
         hCZA==
X-Forwarded-Encrypted: i=1; AKwUvBwQg2jokGLJzSfZJGxlg1lCpDFPP4vRNdbHUvWvGAt5Sesbj2xlzKGwemehY6TAj8ymI7XhzWg=@vger.kernel.org
X-Gm-Message-State: AFuF++mZCCeOYACoigW6I/iSnRng+lsXu87+ape/w3U79SsT27Ybaccf
	53RNjNPQ0AHEq6D2Yp2mcXcyxYJt0Ls9cvlqSFNXtLDUZtMMXk1y8D2ldsIdlcNPXw==
X-Gm-Gg: AYBFou3N+8HI41XlZNNG4GcBTr6iLyFTvpIpWf/AOPToR2ZK2+cisBTZVwtQUPtNPML
	Qmf8ihrSF7Bvxf65tFlijwAwAJmKdsallYxKBeN7lt3Y9qKoGroRjIeMs9zwHqD2vlCO922ArwL
	1zkLZujLIy9ncphKGLGizzJAsqAhO6qXfw8y4Upjm2nlJhrnUy+/wNn8aPCqBvP7ALBAOtAj1Z8
	HrHFbJ7FcmWIRG9Jdt32LIA59zmtsV3qymLzAkXfKX7W0Shm07U5PR0AfVfq5ACabOqD9eoKf8Y
	t/kgU0H8HtRB+BSZwYEdqI41U7sPcy68jBear+WX+fN+oeCjmTS6umyFbIIqCcZmuf3G1ZD6eiS
	jRw9lr7zCK374TIOJ91Bu/zY1ccq6XpQT3NdfML3f4fuj8KgXJ8YV741m2HFOLgt1Wgh1mHzETl
	EnTCS/a7KjZWKhc+XXF98rAuwvqgoLzMpxV0UTeGKbyn6RRVK1n2T3AT0HYHTUvNdAUVhO9eSVb
	nIVTlWLgQucsXji8LMfcwW4JEKqoizOTgQm1g==
X-Received: by 2002:a17:903:2349:b0:2dd:c100:9432 with SMTP id d9443c01a7336-2ddc1009bbdmr13766535ad.48.1789772275799;
        Fri, 18 Sep 2026 15:57:55 -0700 (PDT)
Received: from p1.. (209-147-138-4.nat.asu.edu. [209.147.138.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331d55cfsm1899941eec.30.2026.09.18.15.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 15:57:55 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: clemens@ladisch.de,
	linux-sound@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz
Cc: co+24304d323d28f156@bugs.sh,
	stable@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH] ALSA: ua101: reject mismatched capture/playback packet sizes
Date: Fri, 18 Sep 2026 15:57:53 -0700
Message-ID: <20260918225753.1278505-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

detect_usb_format() cross-checks bSubframeSize, bBitResolution and
tSamFreq between the capture and playback interfaces, but never relates
the two endpoints' wMaxPacketSize and bNrChannels.  Each playback URB
gets a buffer of ua->playback.max_packet_bytes, while the number of
bytes written into it is derived from the capture stream:
capture_urb_complete() computes frames from the received capture packet
and capture.frame_bytes, and start_usb_playback() and playback_work()
multiply that by playback.frame_bytes.

A device declaring a large capture wMaxPacketSize with few capture
channels and a small playback wMaxPacketSize with many playback channels
therefore memset()s and memcpy()s past the end of the playback buffer,
in open() of the PCM node the driver registers during probe.
usb_submit_urb() rejects the over-long iso_frame_desc[0].length with
-EMSGSIZE, but only after the write.

Reject such descriptors at probe time.  Genuine UA-101/UA-1000 hardware
declares proportional packet sizes and is unaffected.

  BUG: KASAN: slab-out-of-bounds in start_usb_playback (sound/usb/misc/ua101.c:586)
  Write of size 2048 at addr ffff8881098f3c00 by task exploit/5021
  Call Trace:
   __asan_memset (mm/kasan/shadow.c:84)
   start_usb_playback (sound/usb/misc/ua101.c:586)
   playback_pcm_open (sound/usb/misc/ua101.c:679)
   snd_pcm_open_substream (sound/core/pcm_native.c:2829)
   snd_pcm_open (sound/core/pcm_native.c:2865 sound/core/pcm_native.c:2932)
   snd_pcm_playback_open (sound/core/pcm_native.c:2891)
   snd_open (sound/core/sound.c:166)
   chrdev_open (fs/char_dev.c:411)
   do_dentry_open (fs/open.c:996)
   vfs_open (fs/open.c:1101)
   path_openat (fs/namei.c:4837 fs/namei.c:5000)
   do_file_open (fs/namei.c:5029)
   do_sys_openat2 (fs/open.c:1417)
   __x64_sys_openat (fs/open.c:1423 fs/open.c:1439 fs/open.c:1434)
   do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

  The buggy address belongs to the object at ffff8881098f3c00
   which belongs to the cache kmalloc-192 of size 192
  The buggy address is located 0 bytes inside of
   allocated 168-byte region [ffff8881098f3c00, ffff8881098f3ca8)

Cc: stable@vger.kernel.org
Fixes: 63978ab3e3e9 ("sound: add Edirol UA-101 support")
Reported-by: <co+24304d323d28f156@bugs.sh>
Assisted-by: LLM
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 sound/usb/misc/ua101.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/usb/misc/ua101.c b/sound/usb/misc/ua101.c
index b9a62e94e06c..2f0f4233380c 100644
--- a/sound/usb/misc/ua101.c
+++ b/sound/usb/misc/ua101.c
@@ -1002,6 +1002,15 @@ static int detect_usb_format(struct ua101 *ua)
 	}
 	ua->playback.usb_pipe = usb_sndisocpipe(ua->dev, usb_endpoint_num(epd));
 	ua->playback.max_packet_bytes = usb_endpoint_maxp(epd);
+
+	if (ua->capture.max_packet_bytes / ua->capture.frame_bytes *
+	    ua->playback.frame_bytes > ua->playback.max_packet_bytes) {
+		dev_err(&ua->dev->dev,
+			"playback packet size %u too small for %u capture frames\n",
+			ua->playback.max_packet_bytes,
+			ua->capture.max_packet_bytes / ua->capture.frame_bytes);
+		return -ENXIO;
+	}
 	return 0;
 }
 
-- 
2.43.0

