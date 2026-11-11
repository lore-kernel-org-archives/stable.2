Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411911;
	b=XEgQaVwHdmLtFLHqusLTG7uGOWTzwMlWI5OCTiX0hKE72WgL1+6SjCt0AL9gfaqV1fVf
	 533uwAFscw/vQWHuUNfvw/54bB/Zs4gHi6IhtR1MVWvkMAChwuoIDXMdACxW8cqGJ0ta0
	 hO126MwCCVtZ3fEr9P2KuZP0RBoDHnwiBvkhlzKLCiPJ0pNzddQSngfHzfZUDrvf4aDla
	 RXfJAixXsN+lGHHl1wVA9gtI33TGuckaI5egSbcIfu8se2O9vI1WPQsMA2C5dxocNtire
	 GGrvuLMCXirWScam1S6c+YoCcGmQdIAnrb3RA9ZFd8lakApy8+ej2wjPoyZQZLnD6hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411911;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YVhpQdien6ClW81XRhljqG17Ko+dXVxzUCRkvlPhS+s=;
	b=bMInNWakhstuzmhHv1bNuB4A7fTP+dHnUxWJrrOlLU4am32BflfFJ3DtPxC6BzbZq5rR
	 9TDaxJoTAlhwYi2MCuS+12tBowZrhzOzU+Bf6kAFp6UkSpHs5YHuDNOtIHbiY+KiusthD
	 +uIL5ORiiRDar+FkRsOyOfGeKif4Nqcf33i4RHauZCzFMMy5lZMTXHpnO9Fotd+panxoR
	 mjfmjGjngBMHrEwODKe669Xg+FCWvSGx34jqeWFzTo9NSX7Wt6o6z1UhhYRd2616/Mjbt
	 usiQD9qOv15B7rfMfv9KuW+2ysrNlWbRtf3f56GnaSh2hmj7QyU/VA6islMHybK8YWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N7eQiWBs;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13135606A880
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13135606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N7eQiWBs
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-943e8d35f74so285326085a.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 07:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794411910; x=1795016710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YVhpQdien6ClW81XRhljqG17Ko+dXVxzUCRkvlPhS+s=;
        b=N7eQiWBsJoz1GfZmtmTsNRAJN0A0bODBk5+JYy/c6BAIKZtPkUFoZcR5hLaK99LX8k
         4cgCEbC96C8iztbsYDb5TaCLcBYM+qk5o1DOMTWUEwqJQ6cP9R5xjwcQwD3NbtHOGY+R
         iGFVbU8TTiAQSDckgLgYaudMbdpLrQuoKRHKXqZEdVoWC6Q1P3zZ6Xo8X4/dykwBirEA
         9ypnR8aucL2ziH0x27HJF2utvhazPfgE9y+sCxn//cwWah0NQGhuAUJ2L969gCy/iTGG
         vi0c/MzCQuFwyby+cIIz8Gg59mOaEVwG8R/KSSpknhkS0BN+Y+Bb9AL6mpcP329cScTc
         xXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794411910; x=1795016710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YVhpQdien6ClW81XRhljqG17Ko+dXVxzUCRkvlPhS+s=;
        b=maddH3j30BHTVeRb01SdBYgH8vy93Una2spzNr4KVtoMxlf7Oj6mOUb3N1vstmv8uo
         53R2Z1bTodLxNF8AU+gtB/z6p8I36Gr+ftrW6+d8cLWiCnZPUMd/gDVMFRE8C4G3Wm/w
         g2OJi1AGXuyl83+Ur4gBcWwmwsJOUWrj/MDzVYVbw+dhCZ8QZTYGwWP1WlC/lNknwxO9
         D9bAsyQ3ZOrnBw09+aPzcwUb6XXqBrwSD7T3X5yAzZU4zwoEeSiFr4Jx+FogGrDVS8qZ
         j6WdEYavonFy4VChxrDI17ivGFJz9i0cOCRyuodbf9WWwEclFNBo+whE9LkpWHTGEatF
         2lLA==
X-Forwarded-Encrypted: i=1; AL+hErFPDsAa63ORamFaeIE8sC243so7rHKXs9C5PVG0rPCJv+Os2gvds7Z8PrzrrXnzIUZ5LgLq+dM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8k9Hg0CwW9oVQf448BShvIPUGE4B+WNH45v9pK+KV/PdtlFTn
	P6i9Cg6NeY3uhp0LZcoNfclSUNkTZSz4uyWJbcPkaxeT/UJC4F6t0GbE
X-Gm-Gg: AYBFou2xhameAvwfN4/Wm1LOwsvgAaiAz84HxZ4kcQIxQggNCS5CFgFaFm3NpSmHZK7
	r1O8cmgZ0LMPHeG9hkSfR1sAcyhIq6m5Pf0MoxMuhgRbbrDM+/4etWcew/ow3U2vaaqEfSTVO/Q
	vV02t2POh50NirMgXShEdg5xb9MrufgCl1ayNmAKnpaO1QrX71nnRNsSozPcFv3aVv+hwdECQ+s
	EXlRUo3tYb+IiPjG9KjOAmCf2Bx8VOCncTL3qEli6sTXeBSCelNfxq/z4cztgPIAAiayDcCLF4O
	Sl1oYyQHI/WPNmGuNhfOcQy3iRP43vwIIR+br4Uurfm1lz0crXxjLvG8qopIQMRKtYHiq45Jyy2
	QZya4tVD0/tM3MnBfof+jFS8uJ5PPhYTA/hTCT+aRetMq9jleQCwSnYCBzVhCGaM8ak8ruW9IoE
	P+uUqh/H8M29UQLPvBDJVj6r8IcF7xQSMgYjYuhqJXpxOYw6xEuTVc5f+1P+5K/V+umpCv8gSMc
	Raey1Yy4DtIUOVt6jVSVXPJoh3wmLVahlfiyt12cX4RK6ty7MAgaDB0XK90b0+gwqAhv4VlRija
	wy+tQlqlXHgbQU1uhuW+akIs1TXiTe/ZR30mCpGUIsAtVRUw7gHPft0o9c+sNsKWHMyOat/hETq
	zaH8bto/2CY+Q4VzcdVqC
X-Received: by 2002:a05:620a:1a02:b0:945:f275:76fb with SMTP id af79cd13be357-947b002ccbbmr439213085a.42.1794411909629;
        Wed, 11 Nov 2026 07:45:09 -0800 (PST)
Received: from linux.. ([8.34.174.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7f2edesm510783885a.40.2026.11.11.07.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:45:08 -0800 (PST)
From: Changyul Lee <lcy8047@gmail.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changyul Lee <lcy8047@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: typec: Check the alternate mode ID allocation
Date: Wed, 11 Nov 2026 10:45:03 -0500
Message-ID: <20261111154503.3621477-1-lcy8047@gmail.com>
X-Mailer: git-send-email 2.43.0
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

typec_register_altmode() stores the return value of altmode_id_get()
in an unsigned int without checking it. When ida_alloc() fails, the
error code becomes the ID, and the alternate mode is registered under
a name such as "port0-partner.4294967284". A second failure on the same
partner then fails with a duplicate name:

  [    0.423055] sysfs: cannot create duplicate filename '/devices/platform/altfail/typec/port0/port0-partner/port0-partner.4294967284'

Return the error when the ID allocation fails.

Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
Cc: stable@vger.kernel.org
Signed-off-by: Changyul Lee <lcy8047@gmail.com>
---
Changes in v2:
- Add Cc: stable@vger.kernel.org

v1: https://lore.kernel.org/all/20261111041446.3072716-1-lcy8047@gmail.com/

Found with a static analysis tool we are developing.

Reproduced in QEMU (x86_64) with a test module that registers a port,
a partner and 63 partner alternate modes, and then two more with
failslab (task-filter) making ida_alloc() fail with -ENOMEM. Without
this patch, the first of the two is registered as
"port0-partner.4294967284" and the second fails with -EEXIST and the
error above. With it, both return -ENOMEM. Same result in three runs
each.

 drivers/usb/typec/class.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 54c7810b563b..29fb13ca9f28 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -641,11 +641,14 @@ typec_register_altmode(struct device *parent,
 		       const struct typec_altmode_desc *desc,
 		       const struct device_type *type)
 {
-	unsigned int id = altmode_id_get(parent);
+	int id = altmode_id_get(parent);
 	bool is_port = is_typec_port(parent);
 	struct altmode *alt;
 	int ret;
 
+	if (id < 0)
+		return ERR_PTR(id);
+
 	alt = kzalloc_obj(*alt);
 	if (!alt) {
 		altmode_id_remove(parent, id);

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.43.0

