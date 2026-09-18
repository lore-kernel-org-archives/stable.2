Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DF0411F93
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 23:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789774819; cv=none; b=Eab9Q06llBcUrpEsXzS5CaHWxV6RRfdvmKtBWoBWoptwu/J9FgxPU8/WTjxusxVWBjcsP+6JEhEtjtL0BtG2r6UjWsEOcEDitqbTRuASAbW1Q6oEBLLtmtOHlN5QpD4PcRkELkAnsQXNbAYv8PYu+mbZnPZU8v+oxKxHndS/S9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789774819; c=relaxed/simple;
	bh=bYAj3zJU4/bhOKYqpiP9deo18jfkgkWwofMdpY9Zt9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jBqRfZBFWDJrzjM6JLJ08jplcZfa04AhJqe1lBORuoq1Dar6AJNVwYuWqbW7r+68rpVLMxPoHktJ5wHhajh25mfjiLlZkhXvayt5g6zxe+aXoCM0uMgU03M7Vzw8BB+OSLJNrQPUQFTEjIjplZbuNIILEWtxxmxKkQ4uwZalXzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=dtY+0Lnl; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="dtY+0Lnl"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396cccbba91so947969a91.1
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 16:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789774817; x=1790379617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QFXPOWlkcWbkw0VizSZPMIGc1O/sr7Ro7vwjf0xy78U=;
        b=dtY+0Lnl6GgHFEkuuJrdft4BBznq3MKJy44Cm7Hl+IviF0h07VX/v1ih2pbvFlJ3d8
         ZyAozFZXh94MxZKFhCfgoIS/Nx4Q/tPTXzDCpE/b6miWBc38Psfu4eECpfvI1yiaOEPJ
         2JMPYmxb2zCEoseV8lr+bDJAKfL7tr8xsC8/BVx7wXyIN9qByuvPJBVqLWbJxG0PsLGo
         O8q+IfjnSHY4TI36J1CnHZb2apZwytONBP8vLqdoLiQXzggCpnTuYoyERC1Se/nubD07
         ptEitp4Y/r7BnUyDW/TozI5dgKLbBSlycACTfPb5bVt7Frg3Wpb30sJHKj7su/DM+Gy6
         Iqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789774817; x=1790379617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QFXPOWlkcWbkw0VizSZPMIGc1O/sr7Ro7vwjf0xy78U=;
        b=d6kO/ItAHygmfrLnxfXrCxfEIZGiGucyXGppxfXlUpUCIy4/5wRIxSoBl07DoIPx3U
         qmh6SPPd2K9GXfXSYnBkIkPSUb+JEDJ/jG8hlwtMpTzIn6czpA3Mupfb33ty9Wa8BVu6
         wV+qyi0vD+Pe/OBzKPawxXg72sz8w6yUh0rrYCvk0Qjmcf+7q1y9c7RivuMaEY/dzceG
         unSomGMlZD3pcGXDqLzj+0dULMpjXUgxsDs9KUEpjQsNKKnzhEhbIS6k2XuneYy2tsom
         vP9B1vQXiQ5xlu3T1LqdMKWUg0vWy/9vC5kM53po/KqNZ4LX9QFdzN7k16Z0ST46GFBU
         /y+Q==
X-Forwarded-Encrypted: i=1; AKwUvBzhO0sROUbZUo1pmM2kn/VZJKP1Kqg6EhNIcI4jt+APqVQheDg72ctsOuZzby0GWyJIY77E8YQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nXDOujn9xSYCc5LQHVKm70VgIY8d4GK3+ChC+JjaOky+syKsBo
	dLdBjZ3Z394f0acq5LL+1CPiQ2ZG+AYAAyBOctLM4bXREVMihy05mLbvoXiWNoy/3g==
X-Gm-Gg: AYBFou3wM/33/iwu9tXz/X9UdPwEDNSApAuMb/Rl4ir9OhSYwY9L/HsNLkfjUfrsJif
	KUjVI2bDVYd/JRNQ8yTrICn+VxtXPItFE0QBo3sVIoUsbqcKZIiACPoD8XiMZkz3kVrEgdmJwzz
	gDJx7cSwXKc+sRoLxSlAqMuiuM2MdOt01kFELWFXdBEMlDvB+tbrBttU9020aJFCSly+S4K9S14
	3/FdpuOGDIIZx7UY64vUwNgwvOiE4zDHYztoNju9Cn8AXEuyIfTYczXS/NuX3JyaDi7kVNqYZgf
	IeNqddHZxWLvo3sesPUx620KI32Qq0PrQCS4on2dpZ5hEf1GkfBoMJQ88lFamMwOkDYWSlSZd59
	f5vyzYPLk6RyE5NfqNCqLnekLylPqCiGGPw2Ma3lp+KeG2iSJWYQlOZYy0NlHVnjqtjUG/AhOT/
	h5P9vZ4tORCM00rw7/R0OKRAv/gH9SgmYDH11YBk8RPavOsiQbLrHqME+Px6cJWUrFAGh7SHQOj
	hzu5TaKtpY0ClpX+RjM/OqXNGfoC4UEPTpTRQ==
X-Received: by 2002:a17:90a:e7cd:b0:39e:4c81:6c5f with SMTP id 98e67ed59e1d1-39e54d5ca0emr7917972a91.26.1789774816934;
        Fri, 18 Sep 2026 16:40:16 -0700 (PDT)
Received: from p1.. (209-147-138-4.nat.asu.edu. [209.147.138.4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55cef9bsm1609458c88.10.2026.09.18.16.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 16:40:16 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	co+be8fa7ea6f77fdce@bugs.sh,
	stable@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH] ALSA: line6: reject oversized playback packets
Date: Fri, 18 Sep 2026 16:40:14 -0700
Message-ID: <20260918234014.1318325-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each playback URB is handed a slice of out.buffer that is exactly
LINE6_ISO_PACKETS * max_packet_size_out bytes, sized from the OUT
endpoint, but the number of bytes written into that slice is never
compared against it.

submit_audio_out_urb() takes the frame count from prev_fsize, which
audio_in_callback() derived from the *IN* endpoint's received packet
length, and rescales it with the playback frame size; when prev_fsize is
still zero it synthesizes a length from the sample rate instead.  On a
device declaring a large IN wMaxPacketSize and a small OUT
wMaxPacketSize, the resulting memcpy(), or the memset() when the
playback stream is idle, runs past its slice and, as the reproducer
below shows, beyond the allocation.

usb_submit_urb() is not a backstop.  max_packet_size_out comes from
usb_maxpacket(), which returns only the low 11 bits of wMaxPacketSize,
while USB core validates a high-speed isochronous length against that
base scaled by usb_endpoint_maxp_mult().  A length of up to three times
the allocated slice is therefore accepted, and even a rejected URB is
only rejected after the write.

Reject a packet that does not fit the slice the driver allocated for it.
Clamping it instead would silently shorten the capture-derived rate
feedback and desynchronize the two streams.

  BUG: KASAN: slab-out-of-bounds in submit_audio_out_urb (sound/usb/line6/playback.c:229)
  Write of size 1024 at addr ffff888100bbd400 by task kworker/1:2/5002
  Workqueue: events line6_startup_work
  Call Trace:
   __asan_memcpy (mm/kasan/shadow.c:106)
   submit_audio_out_urb (sound/usb/line6/playback.c:229)
   line6_submit_audio_out_all_urbs (sound/usb/line6/playback.c:291)
   line6_stream_start (sound/usb/line6/pcm.c:194)
   line6_pcm_acquire (sound/usb/line6/pcm.c:337)
   line6_startup_work (sound/usb/line6/driver.c:728)
   process_one_work (kernel/workqueue.c:3396)
   worker_thread (kernel/workqueue.c:3479 kernel/workqueue.c:3560)
   kthread (kernel/kthread.c:436)
   ret_from_fork (arch/x86/kernel/process.c:158)
   ret_from_fork_asm (arch/x86/entry/entry_64.S:245)

  The buggy address belongs to the object at ffff888100bbd400
   which belongs to the cache kmalloc-256 of size 256
  The buggy address is located 0 bytes inside of
   allocated 256-byte region [ffff888100bbd400, ffff888100bbd500)

Cc: stable@vger.kernel.org
Fixes: 7a0f55aeeb8f ("ALSA: line6: Support assymetrical in/out configurations")
Reported-by: <co+be8fa7ea6f77fdce@bugs.sh>
Assisted-by: LLM
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 sound/usb/line6/playback.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index 7ebaf125f969..aa6ddf8746a0 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -182,6 +182,13 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 
 		fsize *= bytes_per_frame;
 
+		if (fsize > line6pcm->max_packet_size_out) {
+			dev_err(line6pcm->line6->ifcdev,
+				"playback packet too large: %d > %d\n",
+				fsize, line6pcm->max_packet_size_out);
+			return -EMSGSIZE;
+		}
+
 		fout->offset = urb_size;
 		fout->length = fsize;
 		urb_size += fsize;
-- 
2.43.0

