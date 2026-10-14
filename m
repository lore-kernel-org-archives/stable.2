Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C03C4F4024
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975501; cv=none; b=KUOlHWUmaeectKBnKyX05GEcgTOkFvr1KkKJNFAbSTJcetyn5g64Pl3P4ZplaP+qG/TFfoOFa7tjy/pWgbXUw9Gq49kyWdgnUk19iXiu9DpGcjW/j8uccX0Np6Cd8bWV8sOeYXu60IKnozwQox42R/hOf+yeh9dhP2uBebcaD0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975501; c=relaxed/simple;
	bh=AYIDLdC4DIa4bszf3iy6sh5ar7HaFoLMBfW1KLJXpGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3y5nK/y1Hmc3+4j7qv8IjVz2jdG8d8+xJZe6RCeHcqw0GySkCOLVn7kuTW3o8gzEghyvmnulDq8UFjvQwbPT8XDibYYKQjjnVWJUsOrlDM5CRMAJ65putg/p6Mm4Fe330WjXvKzYuKhtbO6e1LYP/GQ61xFwnzpQRa/VfhjO2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhBcN/Oe; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhBcN/Oe"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-486e8faff03so1713120f8f.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 03:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791975498; x=1792580298; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iKUolQ563+eS2F7rnauHIL/AVP3xpqqaVjfXFTcZMvQ=;
        b=UhBcN/OeU7HbgtJ9rMrncrxMdRguMNgfb/s0D8JLzLmPTVjMuyO1cumZEOX/jlzpC3
         WTYnWNxsjWhK2ApOcaY0zVruQYAA0XGpMG1iMCpSTi86xdAnyD6INSJQm1N8G7H0SY3y
         DE1FBrMM5aQml1gde2JiatjT681py3PYHeAqzXsZ+ebeqU3b7npiZ+7fBs2bceoRwF1t
         O2UkLABGNVKqUxrt42GanPLkTDHobGGaqzzpV2vRQBTRIiYvF+/NWs2QyBf9gU4DV0of
         1fz9P9oQ7RIWco9QMmA1fwxbGuhFSACj/OJ/ydfl29zJ0xXU0QK5KOLXuZzWjb09x2xo
         3hCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791975498; x=1792580298;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iKUolQ563+eS2F7rnauHIL/AVP3xpqqaVjfXFTcZMvQ=;
        b=hvC3evIpLrTytg4MhZuiblUzdEhlQoGZufT0MCtWqqU3cjtOPuGc6eMXr4qBkvh3G7
         2NmZ+4UZn/XL7CGEbP9fpdCrmgKBqhmH+AbHPd1vlqfMAbjIQ58HWBX4lCudj8mmNAFK
         EFW2j45+FHrSN073r0OPctO7C/8xNA2G59dpMTqfasmAFa3NdI86gSuc5py0KOKGpHqN
         nLx5eMCZeFvGks76+K0SjIa7uFcZbV9K/TG/NpSo5m8LYT00BR5m67x8NnlooFlevuN6
         tgzGiMC4hu34H3AleCGr7/Fae6sJ+bdsVx2F4ky6j2YqXJDFa1+yq2XJhknoPr0jQ9z6
         IpmA==
X-Forwarded-Encrypted: i=1; AKwUvBz27Yh+P0i1AgcZppjVI+gVO7rSTKQuoTg/jcKOLwKrUQbWKdm1Jlh5zwqMfXkOrNYDr2A2A7w=@vger.kernel.org
X-Gm-Message-State: AFq9FYL2T9rbQD/OvPZXHYn8vj6drfHBpH6SMyO4wxEgk9XsALt0EgGu
	qRRUbjd5gSqKBCOXnbaZ9//oo2ry7KwoGntZNTjxpFiqlPOLPMkTg+q0
X-Gm-Gg: AYBFou11Nc5u10tjYO6cBNuymCzKZWEAgc4rEx0NWMpn+7DPCICcUz+ozOWFZuL2Dne
	06sSLAVDbMB+viZ3TuIawhuk0WkJepScgFsxMBgMqv2Sit3/iS73Bio8DQKaaqMshQfAind7lWJ
	OYFgCaZp/+rpCQz4TRJ/aYpkClf6qSvpCS/SpKgTjjP7MH0ojFieeKXUgzOj/kctzlOKFsOE/kD
	BmR3tPgrauzLXMT6A+SPngK0NhJKhCqGxyESzXd77ofzGEN+ZUxnUdEznwMjTWJ919XOTuMKSA9
	UF3hxtNsokWQLNP4lHgGoEIxbyp31iIplIKDVFpyVfW0u4SkOVtEVm6rx1GU7Qb01WBzDg1lfQ1
	B4mo7/2gWYLgywhsZH1LfgGvxeXoyygWpnAt0Gr5Jkf1ifworg48rihEG9/l1ZiTl9NDJqOTnPe
	tka1tLJMv2bwOaJPuCBWuRJqzCIB81D7nWzRUicXRIZI+ooGX+Q7/UOeFY3J1WqbEbE9oOiIcah
	u84ZlXhK/BcHiW3BVpt8L2SVy7N/vLLdGqtUWUXIDjQnx4qSneGAE8/atKKh1UcubJuuPZwZXcN
	gNVnv/+9mEbOcoOnziOhjq3R8NpTR0QyauTM2YMpy6UZODiKPJV+nLsOA2QifskwRmrlmcej3Do
	hj0M4waCbbsnQvHqT/f3MQlHkxVoDLRh7DxhN8KOD0o/jFrF9Q8IS5C0CQ9tvaeKMvVvY4jQYUr
	wn+DeP
X-Received: by 2002:a05:6000:2505:b0:485:8a47:5b91 with SMTP id ffacd0b85a97d-48dbacf6fc4mr27045803f8f.46.1791975497516;
        Wed, 14 Oct 2026 03:58:17 -0700 (PDT)
Received: from localhost.localdomain ([37.167.102.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bd777fsm10285694f8f.57.2026.10.14.03.58.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 03:58:17 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: linux-usb@vger.kernel.org
Cc: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	usb-storage@lists.one-eyed-alien.net,
	Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: uas: ignore UAS for ASMT135x bridges (174c:55aa)
Date: Wed, 14 Oct 2026 12:57:00 +0200
Message-ID: <20261014105700.19433-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261013221944.41598-1-olivier.kaloudoff@gmail.com>
References: <20261013221944.41598-1-olivier.kaloudoff@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

    scsi 3:0:0:0: Direct-Access  ASMT  ASMT135x  0  PQ: 0 ANSI: 6
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

Since 174c:55aa is shared across several ASMedia bridges and enclosure
rebrandings, distinguish the ASMT135x by its product string — the same
approach used for the HIKSEMI MD202 check a few lines below.  The
product strings of working bridges using the same id ("ASM1053E",
"ASM1153", "ASM1153E", "ASM1351", vendor rebrands such as "YZWY_TECH")
do not contain "ASMT135", so the match is safe.

Verified on an ORICO enclosure (iManufacturer "ASMT", iProduct
"ASMT135x", bcdDevice 1.00) attached through an Alpine Ridge TB3 dock:
with the equivalent usb-storage quirks parameter (174c:55aa:u) the
device is completely stable.

Cc: stable@vger.kernel.org
Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
---
v2: fix the comment block: added lines were missing the leading
    tab, breaking the *-alignment with the rest of the block.
    Apologies — the v1 diff was mangled by my editor before sending.

 drivers/usb/storage/uas-detect.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/storage/uas-detect.h b/drivers/usb/storage/uas-detect.h
index 4d3b49e5b87a..d8dc77015992 100644
--- a/drivers/usb/storage/uas-detect.h
+++ b/drivers/usb/storage/uas-detect.h
@@ -78,6 +78,8 @@ static int uas_use_uas_driver(struct usb_interface *intf,
 	 * ASM1051 - with broken (*) uas support
 	 * ASM1053 - with working uas support, but problems with large xfers
 	 * ASM1153 - with working uas support
+	 * ASMT135x - broken uas support, shares the ASM1153 MaxPower == 0
+	 *            signature, identify it by its product string
 	 *
 	 * Devices with these chips re-use a number of device-ids over the
 	 * entire line, so the device-id is useless to determine if we're
@@ -99,7 +101,10 @@ static int uas_use_uas_driver(struct usb_interface *intf,
 			(le16_to_cpu(udev->descriptor.idProduct) == 0x5106 ||
 			 le16_to_cpu(udev->descriptor.idProduct) == 0x55aa)) {
 		if (udev->actconfig->desc.bMaxPower == 0) {
-			/* ASM1153, do nothing */
+			if (udev->product && strstr(udev->product, "ASMT135"))
+				/* ASMT135x, broken uas */
+				flags |= US_FL_IGNORE_UAS;
+			/* else ASM1153, do nothing */
 		} else if (udev->speed < USB_SPEED_SUPER) {
 			/* No streams info, assume ASM1051 */
 			flags |= US_FL_IGNORE_UAS;
-- 
2.47.3

