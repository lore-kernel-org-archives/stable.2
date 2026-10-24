Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792875324;
	b=eW+51H9wcBBCRuPced6q+7M8dL1TRTCCfp4DIL7FO5BbjWQZR1KT0FIpbFNKsVr849Kq
	 3L4Rs2fJUC818I0S39HD77/rMgahalaLNMPOD+rKbmQBj9caztFWWLPlHGl+KQEGSCDBR
	 V0Az3AZIyiisXsvkq5kUAwO15pmNXABcNCcKQpMZ3lmHooRb14bsJSlZDtU3w8j/ofKx1
	 h0vlJaMhMgfCmpoXSnzu4HSRna6mUC0DVEVEUnFRHn/LvlCq3lB0XVsakLVMy4kZuHHwk
	 KVLQ0rseGv708f20fKl03AUZ/3gmS8+eO6GbABwbzmfmJh8SgqtYm4XSVumbBhW6L6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792875324;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ve8WmCW8F4Rw5XzULuSdxjLcAQpU0NBVvl/d4u+KnPs=;
	b=ee81M5PvdoU7KUKJdPDfZnSARluAo9rZS2PSBGp83OnLtUJ9u5H5miJx3vXrBrDzXO9a
	 n13V74MfDfwZaKYIZhFWw3bB6bvBV3X2LExqQdtreVgtEgl2lKHnbJy5SJQJdIEke+ssQ
	 rnkis94rmdjXOUwnb2+452k5NxHRXp3PxkRRiyjtE/uuqLtfsmucOWQ+ISjJqoPZEOEyQ
	 3KxOv1ESDP0POiFHHTPFKSk9wqadhc3fZ5CodGiim2oES51C7P5xAf+sG9AuZJzfXH9gV
	 qQjUtowGQrAkSnbp97Gcg+gb0u6wbb6ha+tiQ8G+8bpL6nmB2pbdA+ZMcycmnPinQhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="K0MCJq2/";
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C4C606A31D
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 20:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60C4C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K0MCJq2/
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e09aa5264so1019758f8f.2
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 13:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792875323; x=1793480123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ve8WmCW8F4Rw5XzULuSdxjLcAQpU0NBVvl/d4u+KnPs=;
        b=K0MCJq2/or0s7v2cajYcC2plDUEAn1Ls2wm9tPSUUvWHqWvOe4XkO2yECI5t3bZbgf
         Dq4zmbMVpC1vZrhWnQ6Tuow+OhdHM5ExgOD95+F3y/+s6FDY43iu91Ei9Ly384RdLgjy
         Ro7scsjfFb9ljlQG0NvDvGATM3EdKD+QH5GJi+h0/bThDPNP9un/8wEMYuh1jxAwvKhB
         kauemy80VsUMMHiX97iR9Dmym9pQGya9zO/ngXTbEzHVl/g9undO8jaClzAANC8bkeae
         VvHeH7UjqsuBkZbTfcW4TPIxAFvJtAi5MWPmOCv0CqfF5rwRUUxOHpzHBN/RyXO4OhrG
         PRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792875323; x=1793480123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ve8WmCW8F4Rw5XzULuSdxjLcAQpU0NBVvl/d4u+KnPs=;
        b=R6Wg8asw4L802p2vf5Pj9UuPIgsb027gHO1d6EDXFPuaj8DRjUSlS2HOU+K09a/ZDS
         apxEDNkV5lZy9ci3Yo9lRkpffE7noI+sFpYTVBvBxBey5yZAbdKTkbbQaTXC2FfVjfPQ
         cARy/kIj7l0JHGZu+Qi5c+hncdPaZKPFyRzxfd07yTZXKQJvo3zxe43KpoYbxxan7SYC
         Nn53/ISIjkVtgzpc8dspKAYKPFWH2lAIPV/L9YJDqBlhADFL1HPfBJwd9SzdmT0XZK/S
         VmhvzIU+XurtYXtmX2woRfTY59/ckXYars6jNjfzoHp9k78Nfl84wqtXMPOENSjMOGJB
         ZJ8A==
X-Forwarded-Encrypted: i=1; AKwUvBztwIWp2O/BtbjXh29KxK3XXKfay2bP5UAr3Qq7xDEy7985VtZWcz7cnD4nQknI+NkowWFxOUE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfZeiniener8GsyxSmEOfYSK/wFMSvdefPFHAM2WBxY1XKMzTB
	+amE/ZvNSpTWoTBJ5SZzXNVaNyJBge1wk2z9reVWkU4j3tRF3KP+fGU=
X-Gm-Gg: AYBFou0r1RITuvbBPIds5AgrfsWZHEipc1C1vfKzKBYyyytdfdQ3rSt8DROP5tuG8qc
	uJqgvyitidXGcrF2YoaZx4vBX8DBGEjcIS4e/AtUmgFvsaFEjer8izTDg9+lGdTpWJNStIxoooR
	798yMKuPsI8duhtOfmNPxZ1gI5JpPYD3tkb9AoDAjj6nuzd/SWUzxsdybOzFvm6/rBUSrZAAwiU
	7+KywnJB6ufNkX+aD9lQ7xGs6PBwhMWLSU9XldxrkaA66jV5lExRvi95Tj3t8cwOlE4HpAE/bbT
	I3BEHTvqZ+A8faGreTej7Zx1Tm+fs26v7g0IjBaX+/G/h3jqr2fWx/6fMNac4zJ/x+46MewIcVX
	dyjPoZPIu9qBL/92LVbksczlykqBpehwCXPMb0fiYyEA+i0zcSEkm5fQShVBQCVuKdvvlmf7wv9
	qiPwHhldJak8c6NsXI1IxCqNFxAJQ24sA7WtWQjW3DHaKRqmjUR2gGcN5kA5nzjXFw4OvAMgsHD
	4ELe5zYl6XMUI9x7wJxmVYgBhzcUGDfVRN3Eox0aqCrpw==
X-Received: by 2002:a05:600c:198e:b0:4a2:84c:52f3 with SMTP id 5b1f17b1804b1-4a35ac9d1c2mr50560545e9.6.1792875322481;
        Sat, 24 Oct 2026 13:55:22 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd4ba7sm6202889f8f.33.2026.10.24.13.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 13:55:21 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Anssi Hannula <anssi.hannula@iki.fi>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] platform/x86: hp-wmi: validate WMI return buffer length
Date: Sat, 24 Oct 2026 20:55:19 +0000
Message-ID: <20261024205519.4029617-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

hp_wmi_perform_query() casts the WMI return buffer to struct
bios_return without first checking that the buffer is large enough.
If firmware returns a buffer shorter than sizeof(struct bios_return),
the subsequent subtraction on buffer.length underflows, causing
memcpy to copy a near-maximal number of bytes and crash the kernel.

Add a buffer length check before accessing the return data, matching
the validation already present in the sibling hp-bioscfg driver.

Fixes: c3021ea1beee ("hp-wmi: allow setting input and output buffer sizes separately")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/platform/x86/hp/hp-wmi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 615b4cf6fc451..81c0acc874f8e 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -697,6 +697,13 @@ static int hp_wmi_perform_query(int query, enum hp_wmi_command command,
 		goto out_free;
 	}
 
+	if (obj->buffer.length < sizeof(*bios_return)) {
+		pr_warn("query 0x%x returned undersized buffer (%u < %zu)\n",
+			query, obj->buffer.length, sizeof(*bios_return));
+		ret = -EINVAL;
+		goto out_free;
+	}
+
 	bios_return = (struct bios_return *)obj->buffer.pointer;
 	ret = bios_return->return_code;
 
-- 
2.47.3

