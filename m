Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B892DEA7B
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514701; cv=none; b=qNSgSS2AVtoLy1mLlI1HjfI44gF/Ci/xdXzyo47+JHjDVVHuuB8fEu0Kh6Hw1+UQ2EA4lDTAzvNQEoSm4l4V5qoAhuKD+cB3ZL/nK10TfSfQc+5f9EElecUZKFUyAa4pijj/M+1WvobfPZaJOrIdQPmJ02E8D7rZ2j0eYl9AotA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514701; c=relaxed/simple;
	bh=9Yzh38GRiodpjie4zcPRooc5jBJTJ/dzig1dvhms+IY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mxK9uT+B9IQwpPEQxy96R65Mh/nLwgKRRyrUVPEpdM2vZ/tqTjv7ml6Hz0Y5uPgOaYXvRkSEkvc2FCS06GqK4NvI4KOpviuNDHMxmLCZ/XDhwQGc/pA71S3t5mhkzZGoIR2SR8J+W37Ayj4Bo0JRYzrC0Rp6PSpsjj13i0PKupo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nA3kFAUf; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nA3kFAUf"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso985401b3a.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 09:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785514700; x=1786119500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TKjEK1gC87c9kIwXqKCw727kvsVZgAnx7reueDbTuj0=;
        b=nA3kFAUfNnWsWvjABU3qAPTa2LJKAgkKSsu6xI0ZOYvcntzGZ81szLCwl51kWs7uxl
         YwFO3cUVROsezXWdKL+9Fw30h+e6QgLl+lWb5R70DcWUD3X6QH5INo4AcOVXjkTUQBQT
         Wwr5kgaa9kWCEunaNoM6DGtwemBeMgQDw6UFVQPGDs9d8N11UIxHkCCzIZnRFoPQGWnh
         E5UpLt0RobFeAH/6QAxowKliQVUfd5wS7uevI9Aj124OpqDU7Nu0sn9xwYWOSonRbGDz
         gWP3EsYLKJOCCXYMWKAhvuL4/KbpWZZ3KjYNFyLrKrD/YBJjeRQbPFyX72zP2QLwtfsT
         6u5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785514700; x=1786119500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TKjEK1gC87c9kIwXqKCw727kvsVZgAnx7reueDbTuj0=;
        b=Jz5YO5WpUJSHZkdPRSfJLyxN1Na1X8lKErOZauytIFnROAGhTEg0eItBOrmoqOIv7F
         jlJiPDjjQTcZDZh7tOEZZblOAjrH//ljXUeMBv9FowSQ3BsGXoR4BD8oNdTHb8T9FqBJ
         I/vD0rxDu6EFK8GwpGnTv6Ov3tggsTaRlEWNt6Bo35MouM7vofGF2rUBrIis1CECOG2I
         WXrDAfUfgiL6kFfmCDgnBAYKcAk0vbkzxou2k+/bqbSl0Fk/6/ifLX7Rr1AjdfAm9tyw
         VUErLwWlISWe86oP3YY2ScCiVJcqSG1OvJJ6/avAMpB6djVwFudcRR1RU1d44aPIDQdX
         jfWg==
X-Forwarded-Encrypted: i=1; AHgh+Rpf/qCmBNBqZYlg0ktgfb6v3+v6JFMcckKoBERiBBafCDRxdf+jvFsjkfnKJcpuTmMj/XAwx10=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOFAt7ROlSxjyqJRmtIoeynv5jePJ/SlVNL9P8vPK1/yS5/taj
	/17YTpSmkF/xvgvS+IfREKMt452vw7rG/hByWXgqqPfPicXR6FrbsYo=
X-Gm-Gg: AR+sD13J6g/BIF1pMYECJIElVDp2/0Xv2Kf6xKT29NT9iMKJRU0Qe60IZ4CX6mcsJVn
	ugewe1gwL8LPMLCE8caFL8Ett3HNhURDQNMe2UOFgE46v40WhKSi0gJ2d36Ti9GIdOA+AhJqWqZ
	UuaMRhlaYimWiDdSuw2M5tGiYoM7e45ixSFn80itV7soZxBo5FPFL7T2bHW4qt+q5j5CpsrIbRG
	OGDIu9xe6gqzzd3rfwX3VCWV1E3zHlGfYdWmPT7s72clY+Gfh6pkxlUnSSAFRKFIAwFGOwxLf+S
	WFi5m8d+d+nQeiSYw5kU4kIktG901vIFoKFdP218wMgBQ9YkURka+EkhGF0UlFEzlDP4uOFKPOU
	a6X5XtrCleuqQ34JTBZUipk5zB3rxb1l2WuV7TFlx6pYI1BWXEiEEL7BFo55JOEhxjb4/CjlcO/
	7A76GfuK0jK0hv5yeWM2TKxMvJEl3AqacGiih5XieNNJEH6QfVp295V5pzR0DES0GGTTr+tS1eX
	uCuWKQy2nP77perHBDypI4rsIE22rgxtumnTbQL8zwB/StgTl9I9qdN0o21VXU3v/fyrVqEkN2v
	LmVZh3BFybNjPV329oiUEyU=
X-Received: by 2002:a05:6a00:4b02:b0:84e:cd14:aeba with SMTP id d2e1a72fcca58-84ee48123a3mr269712b3a.6.1785514699546;
        Fri, 31 Jul 2026 09:18:19 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc29e6f0sm647072b3a.39.2026.07.31.09.18.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Jul 2026 09:18:18 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH 1/2] tty: moxa: unwind tty driver if PCI registration fails
Date: Sat,  1 Aug 2026 01:18:08 +0900
Message-ID: <20260731161809.45066-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

moxa_init() registers the tty driver before registering the PCI driver.
If pci_register_driver() fails, module initialization returns without
unregistering the tty driver or dropping its reference. moxa_exit() is
not called after a failed module initialization.

Unregister the tty driver and drop its reference before returning the
PCI registration error.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: a784bf7c195f ("[PATCH] Char: moxa, pci probing")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/tty/moxa.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 1bb2376af85c..680b2dd65462 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -1172,8 +1172,11 @@ static int __init moxa_init(void)
 	}
 
 	retval = pci_register_driver(&moxa_pci_driver);
-	if (retval)
+	if (retval) {
 		printk(KERN_ERR "Can't register MOXA pci driver!\n");
+		tty_unregister_driver(moxaDriver);
+		tty_driver_kref_put(moxaDriver);
+	}
 
 	return retval;
 }
-- 
2.47.1
