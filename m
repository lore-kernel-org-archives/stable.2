Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535119;
	b=QY2XS4kM2qIZAWtSBNvfDRT3vy45LP37/GSpXpmA7LmRnT34SBXnedVMMWxX9RZ6xefM
	 wBosgbZoAZuBEJfmaepMrXOuZ2xw+A37yQIw+JIoisAYpUqIUGeaBpMYW5WhNv5u7gmzo
	 DycMqmQWaL6v9u4V7PZr6DZSTFPeGBFQo+vnJXc8O3uQPXuHAyDdPixdekvuaVN3W8V1O
	 dxu2Y+c9mEaofvPGuemt0vOUH0DMmRwBEzLt9GsgMp3BLZzB19y3TRH6WPd8PO0wp48Dj
	 HSA+aKbFJzMdQjx3l8zT17mUVcFsZvcrNVJipFh7ube4E5Ia6UAyL+bx0/fyo8Hvfmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fGnAXl9mAkM8+L7H53FV4IJ0uW8w/+sPQwCsSY5K0ME=;
	b=iyBLGkxJRwhJlAgM1hHyQVSER5Z1NYhFIvaydH5wWsI+xI4cCsXhbFlHrBf8vz1Xw7ER
	 h0rfbLqGE09aXaqPHXVCISmI4PNDscTodRIBuSTTUo+t4R8gQdSasdRRxyXqNKnZN4YKN
	 hqU8asYMSXdc/FLY/iggAC7HQV/VUk7+FCIfmg1Hf6zUo+yk0rajz0P/ulEUFG1kqFb2B
	 vR9GiGpxAgabv9X2HOAENR9WPg9BBind65GJmoGOG4QFS1ktn6VOyuaiDvCbsPJQFCFFz
	 qIpjYUgNwNTlOiW+HvZF2dSIUmHbxhdBQgUbH1FOqyOT2Y0nxhFElYaFmSFoR45q72g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0afrJRym;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE55606A323
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BE55606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0afrJRym
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a9f9473029so3519505b3a.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 07:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795535118; x=1796139918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fGnAXl9mAkM8+L7H53FV4IJ0uW8w/+sPQwCsSY5K0ME=;
        b=0afrJRymnEvSPq9raSIN79bW6rqNKweAzFUGMkjj84rWQ+xIXL+KA33tTUOZQV2xcA
         eHcNc5gmsXHLH1RxUPtdZc6MpyCsbIwFg3CjZg2FU6QuDQAkOPBXGv09TZy3plj+FLJK
         /jcrggGDqiobpdIORciyxOwufp/1PEBHif0hg+ph84Of30B7VU2iMGb0j9Wdlko/YdJW
         2YqAY85A351EClfDqmetEUQ0jmx7ILRr7eamwWxm4ML3tU4zFA5tVx/HzGZQbmuS1cvV
         qGz/ArVCmxivDlFi9PVMhj51+PZFG3nhQSm1lvBUz1hLZoLyPnKVhY3xezS9UVGfY4MJ
         y0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795535118; x=1796139918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fGnAXl9mAkM8+L7H53FV4IJ0uW8w/+sPQwCsSY5K0ME=;
        b=zsMgiUPHdwTDxK/EJ5IfMmW8BdBToRhLm1wDuD8atEyisNR0jRNyqs4ab2FZ2Dvy7c
         2f5wuMSIeIyXm8EUnReUroFHIdtg4cscaWpdizubPw5ibKUEBXW0WJIEz8kXSYZREkFU
         YeOmTBcJCluNEdLW0OUiL7fj2+iJyb7ti87lndo3Xvj0SWkGgDq74QbEOwqu11aHPgJS
         +cRlskLBJoPumgBdHLQqkOeNFjSMSoCo/X/YubOR9LQQ1o/kc7DVmMfN/79h6dvr8JfV
         IgFsFKWGRUziOKXOK+HhTspgD8K9pduzPY9rOu+cX3sXvTm8Mxp3QigeuaunFM88xoYV
         zphw==
X-Forwarded-Encrypted: i=1; AL+hErGrvyCIFEeDZCRm47sLyh6jHncv49k1tfn/ag8lmqRZhvMKF3gsMO9++V2Vxw36Su7F0l+QS5U=@vger.kernel.org
X-Gm-Message-State: APuU4Z840x4LiYX9/NedkcG8GMgQ/UOIuXumBYboEW+HuIMPAuX53OQ/
	76FAg4M3c07Q9LeDhCnOz/72WzB7UsxhU4SXxMFNWmzZr9QWOEnI5yg=
X-Gm-Gg: AZFdTZdjHBRa3JaNjzScSsYDLY9YqIcgwZfYmgaDO6MzjeH93D+BSqQS00Ol/bhS8kY
	re8Y/QTMjPamRHWqs5+Dk4bIqlmSFZgl/0djbJcGkmaz7Ib3Nm1LMdQ/TpTf8sc5Idt9uI0gok0
	hJuiICLmGZDrmngw51daF0fTA1jWwTa+/RoU7SfTn3qC+f7vOi+FmIcDCNrezNVuYQoT2STbXEa
	ykFvHn9UR82XqNLFBMHo6a98se0ojDQlseAZBPlriaDKaCK8zIlt3jOf6HhXax7BO1aAvmPfdzs
	ssHHZJIaKyKdakk47Qo52POy6qnEVOjCJDCeNHIdyivKm5YmgajzztDwgM2Xlh+vUFgjo0CSLfd
	yP61spdI68Qe1UlkMFUG4RX+P87lWV+WDgIL5nLQmOtRAGkk7g5RkwV6ccWMawzncN3RhKa1mdq
	MlU5BK4Qli+IxVO+3LsKU1tIK5tt5IoMF1q4li4EIUp0EkIzKBiA7wkhAVzKoM8tSlZtI4AOZfJ
	wy5fNPua0HHgOlI/SlcikB0z15U7ERmNkiH7AbXb/ZPmG1uTzRdIpJ9JQX4h2bTOsvIg6jD0Had
	7QSRXTgBUggCjh7PDUsveqo8kGAxyF/eceNPzdKR7d4O9r9AVkZWB/KGvG8TTl2K+CzE
X-Received: by 2002:a05:6a00:a117:b0:8bf:ef6e:1eb5 with SMTP id d2e1a72fcca58-8c87d022919mr12535440b3a.43.1795535117471;
        Tue, 24 Nov 2026 07:45:17 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2002:639c:5da8:85f0:b5f6:2eae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872951febsm7338465b3a.14.2026.11.24.07.45.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 07:45:17 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>
Cc: Yige Jiang <yigejiang86@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] firmware: sysfb: Clear the device pointer on registration failure
Date: Tue, 24 Nov 2026 23:45:11 +0800
Message-ID: <confirmed-20261105-25-a16124b5ff57@gmail.com>
X-Mailer: git-send-email 2.50.1
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

sysfb_init() stores the legacy framebuffer device in the file-scope pd
pointer before adding its data and registering it. If either operation
fails, the error path drops the allocation reference but leaves pd set.
A later sysfb_disable() then passes this stale pointer to
platform_device_unregister().

Clear pd after releasing the failed device, while disable_lock is still
held. This makes sysfb_unregister() skip it just as it skips an absent
or already unregistered framebuffer.

Fixes: bde376e9de3c ("firmware: sysfb: Add sysfb_disable() helper function")
Cc: stable@vger.kernel.org
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
AI assistance was used for analysis and patch preparation.

Based on next-20261104 (8b7179210b22).
Compile-tested: x86_64, GCC 14.2.0, W=1, drivers/firmware/sysfb.o;
baseline and patched objects built with no warnings.
Static source review; no hardware, boot, or KASAN test was performed.

 drivers/firmware/sysfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
index 8833582c188301afb4a9c9dbdf969828ab9449f6..9cd660a509da939c28e93956d7b6420c794048c1 100644
--- a/drivers/firmware/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -214,6 +214,7 @@ static __init int sysfb_init(void)
 	goto put_device;
 err:
 	platform_device_put(pd);
+	pd = NULL;
 put_device:
 	put_device(parent);
 unlock_mutex:

base-commit: 8b7179210b22f8e48a82c5ceacb9d56a9c4cfec4
