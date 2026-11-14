Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794678574;
	b=P0k95USqzyKXWUCgiiefhPQkVq+qlxbFyAa+SAmmACPsd+pY9Lwabuf5S1vzIt/Qlqw/
	 /NJjjHCiKpvwteOJB8VKJIi+huGMcl9dKbSm4aev0Q4RFJvSxkkoB/TmXenPyDRnG26hP
	 rOUsWfpeQvBy6hMC9KT6wRqD93b7V+3PyBMivDfI7c7gVrBYWi3wTPoljE6vfgYzaIZTl
	 1WNYY99KRfo/IzXfTAWhBqnK4vIuMrQ7II0cSRRpvDcWAvfe/ViX+jD3J11wQNK2EzG6V
	 DYn4iMnFKC1bZ1DVxHpy5rkCtCnWJARsQtdD1U8P2rXwl6U7xoqvs2sxDtzdwlA4SfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794678574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9R09EBO85yEAu2wLYOFxIwiGkMThX542L/v6PDwTZg8=;
	b=qWLnESpy2KbpHGjxl4igYH8JKqjsNXVl3ZA+DfM7ahCA8cUCM+FZoNJGsBrmrpU2429Q
	 gV51w39yBCFFX8NM+BVoFq5SWrbh+LmL4dl2aBnBSyQEluahx/xXz6Oj72qL+6rZdMUkQ
	 I3q8rkbl3FKlcbOvsOVewjO6FLLFLFhSn+lLW1DdDWF3jAI47Z+76g5OP/O4MTDAYLvTE
	 Y/ysRzoXXln+eTgqApnwn/TV8Jh89In5WKw7TPNQcE/rsjkNBIUPvdAsKOyjf1XJxgeNV
	 sa1r3uDrlGUmlOXOWdCZ9QdDShxtaHHMl8ZPJxHThfQ6hscNe5vuviMo8x/9wO69YYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CLCz7127;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9C0606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 17:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F9C0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CLCz7127
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4919a880834so995377f8f.0
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 09:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794678573; x=1795283373; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9R09EBO85yEAu2wLYOFxIwiGkMThX542L/v6PDwTZg8=;
        b=CLCz7127R0ADKRCNZV1Xd/7yL75XewT7Nl6X33+OYYwwyu713kQlMFo/4eiShsUV6g
         x9MUEiVIERNfgDq0ca18nbaJ0wfrBqnI2JszxRYt9Oqz72iqyQ33QWtwz6U5IBZ9Aw99
         ZWCZFIK5oY5URStKUN6V70mkrxxGNSLlsNKE3/I5PNLQVICGW710Nj4Q8fJjkQ75BBRw
         DnbR1p2wy7GqEB6UIC0xWq/6H+qFHgma9JrlmIEyzIKVMJkfwofCinTpBMVQrmuBaUTx
         /4g4M1H9pZkYQSd0ny8vjATLvgQfOkjabcZOIpt6BKoSr5pG0OfNr+E9YAfHWtXsCAK9
         Rpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794678573; x=1795283373;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9R09EBO85yEAu2wLYOFxIwiGkMThX542L/v6PDwTZg8=;
        b=ErFiWHrTY36JJJgxkGIs3ZFaew2wRQa57o7NvQvxn3jih21ntL/ZSaGjXhJ7K30STR
         GII+hT2j3zaZ5hVV0/2opPhqny5LAx4UQvwNkRjBKYo5hXorxI4u33qmMSxNXhFx8asx
         L9rb0Bd0ePMlyRiA9nYf33//wOFc2iLrkLaosMVCb2W7IFYIkQZhqtA8/ipqoI/geZea
         E7zRgj2JNycpTdimwt3+ncT78rTfLqBZ5C7mzIvLIrYhT6jkfCfIMlqEEvvEadNu+ESY
         9LlXFA7ZhQBbq+VHLpRYx/3wNwPD5fwi41/2a96YfXjz/25vho2UeImMa+GtMEZ1YUap
         9hJg==
X-Forwarded-Encrypted: i=1; AL+hErHUYtqzsnRQ5fzEEyKvpSwRhAB7ye2Xbg65ZygW0EdnAj8gJcBQa6TS9C+QwVNCUazLsSROUoI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ChhoBZWYu91oT7LUGDNpqW6ou16BRVWG1tRTK2tIbgqIXj+0V
	fbFHb9wK1nnrM21g8+m/CacDY/1p6wjtKxB7p246SmSkxRUeLirl3kNe
X-Gm-Gg: AYBFou2w9hLev3hWN6UYXtZ2WS4WAlKJuHw9G7nZYHIMwJWcN83ulqXHAnEL6UzKVQd
	Efp9nGABAQFViQgHRGFbFmICZvzdPkIziio/4kYqXkWOZ0U39F/TdNdzqugZ3NkbIjqJbAOqfZ5
	mzXrFAB0xM5n7Vlsx5qWGK2m7FSDQDrnS+9N2N2lWuUmluzmEz4yXQkccI8In6G3wY1cl97pqPF
	ir6WXLxh4f3RLj5hjyQco/lNH13CrlPmhd9T3Bc8QLvNK2581KJoe1mskccf0i3a+d8U+Mu53wS
	Vydk+1VcYgd76UCueAPWZWyahaQkXHsghNUCfrbklz3GwWhd61jdsqKvTUvLGeoWCqhcPkLeGUZ
	5uFwt7F/41AwBSLv/vUKqSdleimAUqBbE5hMH6kqveqn3YHezOYz1mSeJgLYNIXS2iGqK5O/S4B
	i9KX6OlVDwC1aQL1wNaQC7jadkAwY9i82gTi7ijFwPaYzYSpoBkjKhwlA5r7vLlgXi7ANx8j+RC
	qfMLTNx81l+z5ysWlsU0WVJCF2QoazjcTvlnJkv/rTfS85S8xRkWEOEH4wt24ji5uRX8Nrh3mi6
	RuRL4j5Vj7m2uig9U9cMJ0nZIXd8STI2BqwBBArl38V9PhLNCTgNzuIa/leQNRXbQpjFXE6FyyC
	ySYo0LnHAS640a98uClHyAn7MIXMl1e1ZM9VS3R+f1p69snYqPkZWPcV0tbCFHRhKeKCO9F6mbd
	C5jjL178+uEzJCwCK/ANAKvoG+86ZTQBnHxMNNeJ1TAj0Nq1hj6FqDxrzQQF6qDTzLRq0z5rnLU
	F4Vk9Wj7v7VmX3BYRVc9EWujdzGxx8R8CXVLrOyisLpH4WgpQ==
X-Received: by 2002:a05:6000:184d:b0:48e:e98:8b64 with SMTP id ffacd0b85a97d-49c70ed94d3mr14656470f8f.19.1794678572558;
        Sat, 14 Nov 2026 09:49:32 -0800 (PST)
Received: from localhost.localdomain ([2a0d:e487:413f:168f:fdf6:7a1f:cf13:6d8c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49dc430fa15sm6038203f8f.13.2026.11.14.09.49.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 09:49:32 -0800 (PST)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: linux-usb@vger.kernel.org
Cc: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	oneukum@suse.com,
	usb-storage@lists.one-eyed-alien.net,
	stable@vger.kernel.org,
	Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Subject: [PATCH v4] usb: uas: ignore UAS for ASMT135x bridges (174c:55aa)
Date: Sat, 14 Nov 2026 18:49:29 +0100
Message-ID: <20261114174929.53871-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

The ASMedia chip detection in uas_use_uas_driver() assumes that every
device with idVendor/idProduct 174c:5106 or 174c:55aa reporting a
config.MaxPower of 0 is an ASM1153 with working UAS.

ASMT135x bridges (iProduct "ASMT135x") share the same 174c:55aa id and
also report MaxPower == 0, so they take the "ASM1153, do nothing"
path — but their UAS implementation is broken:

- The first READ(16) issued by sd probing times out after 30 s;
  enumeration only completes after a uas_eh_abort_handler plus a full
  uas_eh_host_reset_handler cycle:

    scsi 3:0:0:0: Direct-Access  ASMT     ASMT135x        0  PQ: 0 ANSI: 6
    sd 3:0:0:0: [sdb] tag#26 uas_eh_abort_handler 0 uas-tag 1 inflight: CMD IN
    sd 3:0:0:0: [sdb] tag#26 CDB: Read(16) 88 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
    scsi host3: uas_eh_host_reset_handler start
    usb 6-2: reset SuperSpeed USB device number 2 using xhci_hcd
    scsi host3: uas_eh_host_reset_handler success

- Under concurrent load the bridge stalls: all inflight commands (20+
  UAS tags in the captured incident, mixed READ(16)/WRITE(16)) hit the
  30 s UAS timeout in the same event, forcing repeated abort/reset
  cycles and eventually a USB disconnect.  Writes dropped mid-flight
  during these resets returned zeros to the filesystem (observed as
  XFS metadata corruption on the mounted volume).

- Sequential-write throughput is ~45 MiB/s under UAS versus ~136 MiB/s
  after disabling UAS (usb-storage BOT mode), which is fully stable:
  several tens of GiB written without a single error.

- Bulk reads of healthy LBA ranges do work under UAS (~190 MiB/s, no
  errors); the failure pattern is command-timeout at enumeration and
  under queue depth / write load, not a broken transfer path.

An extended soak was also run at maintainer request: the device was
rebound to uas and pushed with ~640 GiB of mixed I/O over ~2h45
(randrw/seqwrite at queue depths 8-32, disk util ~100%).  Result: zero
uas_eh events; the queue-depth wedge did not reproduce on demand.  The
enumeration stall did reproduce once more at the first UAS probe and
self-recovered via host reset.  Per the maintainer, an inconclusive
load test still warrants the blacklist given the filesystem-loss risk.

Since 174c:55aa is shared across several ASMedia bridges and enclosure
rebrandings, distinguish the ASMT135x by its product string — the same
approach used for the HIKSEMI MD202 check a few lines below.  The
product strings of working bridges using the same id ("ASM1053E",
"ASM1153", "ASM1153E", "ASM1351", vendor rebrands such as "YZWY_TECH")
do not contain "ASMT135", so the match is safe.

Verified on an ORICO C10 enclosure (iManufacturer "ASMT", iProduct
"ASMT135x", bcdDevice 1.00, stock firmware) attached through an Alpine
Ridge TB3 dock: with the equivalent usb-storage quirks parameter
(174c:55aa:u) the device is completely stable.

Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
---
v4: resend at maintainer request (Oliver Neukum will ack); documented
    the extended UAS soak results in the commit message.
v3: add braces around the if-body (per Greg KH).
v2: fix the comment block: added lines were missing the leading
    tab, breaking the *-alignment with the rest of the block.

 drivers/usb/storage/uas-detect.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/storage/uas-detect.h b/drivers/usb/storage/uas-detect.h
index 4d3b49e5b..523a17cf0 100644
--- a/drivers/usb/storage/uas-detect.h
+++ b/drivers/usb/storage/uas-detect.h
@@ -78,6 +78,8 @@ static int uas_use_uas_driver(struct usb_interface *intf,
         * ASM1051 - with broken (*) uas support
         * ASM1053 - with working uas support, but problems with large xfers
         * ASM1153 - with working uas support
+        * ASMT135x - broken uas support, shares the ASM1153 MaxPower == 0
+        *            signature, identify it by its product string
         *
         * Devices with these chips re-use a number of device-ids over the
         * entire line, so the device-id is useless to determine if we're
@@ -99,7 +101,11 @@ static int uas_use_uas_driver(struct usb_interface *intf,
                        (le16_to_cpu(udev->descriptor.idProduct) == 0x5106 ||
                         le16_to_cpu(udev->descriptor.idProduct) == 0x55aa)) {
                if (udev->actconfig->desc.bMaxPower == 0) {
-                       /* ASM1153, do nothing */
+                       if (udev->product && strstr(udev->product, "ASMT135")) {
+                               /* ASMT135x, broken uas */
+                               flags |= US_FL_IGNORE_UAS;
+                       }
+                       /* else ASM1153, do nothing */
                } else if (udev->speed < USB_SPEED_SUPER) {
                        /* No streams info, assume ASM1051 */
                        flags |= US_FL_IGNORE_UAS;
-- 
2.47.3
