Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D606B33DED5
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 05:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785043248; cv=none; b=P1N5F81nYxUCd18Vaq8RJjW2Q+Nnt6w4X/0yLXbCJTcY9uiX8jJMkCFBG2Kg+vYzFq1WZ1RUap17Z8FO+TJ0fHwGQYL5kR4m95Xj0vQMxELj/oCdUP0o/btZ0REyd+uDhQnksFQiDtNF/Bm7GVmNafr++jxwcVjQNvhwR3OSGIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785043248; c=relaxed/simple;
	bh=HtSMDMGI928jH0NujTOiD8AsQWsclVnx98DBnmttboM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yxl3xrvePJ1SdKe8qWswvi3zSJH9HlAfIMxNDAJlapa+EOphIhzl4qyLC+b151BCy3QC23P1M2c+Knrgh0Uv0BUZ8Erk7A2JdEtIthXIPC3emsf7jRIpnQh52t6CdtPsfo3levovwyhhZkq6fz50c7k5DaS9IgFxYv9md7xbFWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=kMBxVfB0; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="kMBxVfB0"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-381216921aaso1601922a91.1
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 22:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785043245; x=1785648045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8sCzrleFi3CRNOPw7//ouvrV2R9yWRR8I1g1qxqgqEw=;
        b=kMBxVfB0sAOI6HFADDOJDeKnHlNiBxGvzjepLDJmrn/8Gd12oKb6t2CTdpJOf7s5hT
         oxImNEWEbuPYw9VRED732tWTZ4/q1KKML10+8Xc2fsZ9BhoS1X+ohu5gNvixFrbcARWq
         IhPK7lcnrcB0Sh5Av0yZFAqyx3E6olDfZR0fcrxF0EaQ4T7SasUuUN6NgMXmj2mjTall
         GCHj7n/UHKa2XRz2UgweGBRHG50QkLoVCB+akuyjiXA647nOx/9Ev+5K+Tj9+JdBigwb
         eOL8aSujWkxwL6X1OfJHEfj1r0Ecv8L9MWGW/oTc3/bL6tupHibd7VxMvIenuntxpY+z
         o9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785043245; x=1785648045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8sCzrleFi3CRNOPw7//ouvrV2R9yWRR8I1g1qxqgqEw=;
        b=O/QUsGMYDuP3271ZQVkY9igDbHmhBRJTwNPIWXccN2hvhcJguITCE3ObkGvX1WYHaF
         xUn89sD6GDWH1g+80tRl/XNckAVbl41xi2joS0sXbIdT+pvrutp3U6xTvRgCh5plhQ/S
         C48OZawm+HlbD4qU6nXpPtroVOgyu61lPk5gJ9z9bpaNX9gTXZWDQgXV1G8u8WlURSMv
         muztzlM3UPDKH2c2Gv0ZxWyQ/gINXMTQ7J8yP+qsugYHBhPa7dxEEHypVAUJZgxH17+n
         u8j7wfouAeRm09oD6ELLMGYtwNCO26jjBk0NwDuHRoyVtAZqfVtEXouO5d1/6XIAWLC1
         LHTA==
X-Forwarded-Encrypted: i=1; AHgh+Rr/ilMXyuvxnX2lpxb0Cq1u1Mm3uxsyRfsLKayBHTVge9RPZU6wKTTgpH0q8oL2CJqa3Ilssps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhOp/l6Qu9Bh5FUlykUhL8Nay9BjSYhjFmeofUzaJF5w/cTaMe
	G27dtKI7WyoRDcHaXsoYKYKDv1YDC5mDQDbaXmut5vgVQEpWC1s8xElDJfKUbszlY/Y=
X-Gm-Gg: AR+sD12hnB4rPVyaO+s88gwbiB++siyjm2halZb/nO0Hxx57cDnWYoPrKYNY1QZ18wZ
	IvJrbgkZHEVTZ0RLYdV6k0KzJZ+wYovw3Dhxo784ARN7A1Q66rsIofTVDnzgxcM0s1HIIKl4vUZ
	NpiEHHmyEzRkwNU/se10pCEwzavGanoffIEyohi+2YAQf9fJDS9zELp+WvMlQJNZO9aGkrLi3bF
	CL9vR+0wcJA1L1D0ygC4rZTJWlAGG1xMHYwvVkpxRkGpsCAT1kSmKkSyXA3ACgj9LsiEgGZOauE
	8cmrhbY7n/D9QfxznZ8OjBehz5EOuNelB8j11LMk+IQuEYarWle+2lJhFAMvE1S+8C6ZqvAbxr+
	EVaBHsL1mIW7B2wifH3r/h62YJWNlxHDVUJbFa3hd9KsWuES+Q7H4zixW3oAoF3Zfpx8LJeKb0y
	7rVE/I8OrYu/0LfOgCHxYNpqLRs0i61guoCcDlB/6qAldSxVH9nQbG3NqD4Kpy
X-Received: by 2002:a17:90b:37c6:b0:37f:c97a:939f with SMTP id 98e67ed59e1d1-38f293cd1d0mr3812316a91.7.1785043244728;
        Sat, 25 Jul 2026 22:20:44 -0700 (PDT)
Received: from localhost.localdomain ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f292ae889sm1469435a91.1.2026.07.25.22.20.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Jul 2026 22:20:44 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com,
	clemens@ladisch.de,
	perex@perex.cz,
	federico.kirschbaum@xbow.com,
	Baul Lee <baul.lee@xbow.com>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: fix OOB write in snd_usbmidi_akai_output()
Date: Sun, 26 Jul 2026 14:20:40 +0900
Message-ID: <20260726052040.41315-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
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

Perform the comparison in signed arithmetic so that a negative buf_end
stops the loop instead of wrapping to a huge unsigned bound.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: 4434ade8c933 ("ALSA: usb-audio: add support for Akai MPD16")
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Reported-by: Baul Lee <baul.lee@xbow.com>
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 sound/usb/midi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index d87e3f357cf7..cc7df77632a1 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -799,7 +799,7 @@ static void snd_usbmidi_akai_output(struct snd_usb_midi_out_endpoint *ep,
 	buf_end = ep->max_transfer - MAX_AKAI_SYSEX_LEN - 1;
 
 	/* only try adding more data when there's space for at least 1 SysEx */
-	while (urb->transfer_buffer_length < buf_end) {
+	while ((int)urb->transfer_buffer_length < buf_end) {
 		count = snd_rawmidi_transmit_peek(substream,
 						  tmp, MAX_AKAI_SYSEX_LEN);
 		if (!count) {
-- 
2.50.1 (Apple Git-155)

