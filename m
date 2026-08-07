Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F0E330B32
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 04:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786077501; cv=none; b=jwCUnAxPDvV8TV5/fDMVsd5IYBhc1VObz5dsyMnQb54R88kej7kmrDm0XeQDMT3bhhb0HGh+OKPyxXTxEaLA37vYwdNRfEsusEFF2udu9sbDB+eVsl7TTw/CpzwuP+8aZQCnwy74I/9+ugz1XcAaaPkS1E50aka1wcTaEOIof/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786077501; c=relaxed/simple;
	bh=c2eJmS6Fidv7OQwOFciceAX1dEuewckWJWc+sV7tPN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DHFEHvfDjEDkr4MU3mfo/+9ESQWQnIhpFNdhmUvgzscXy+jHNdKesrKocExM95Xh6KOttdMxF3Fc5+8yiCH/O73wZziBm3kcKHL9tsXqEzw4u5a/xyOhmDZxBIS67Ec9JupYKbeL7rXEwOVMz/zfNfqW7UVMmf8R0/g/Q7c/GtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DriXPxRR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DriXPxRR"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cf52d15d88so27968805ad.2
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 21:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786077499; x=1786682299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OApPi/aBpyIH8HD0zKAoJ3Rb4TUBRhQUqTZcuTXFIYw=;
        b=DriXPxRR25QIAiZxJUvKBtEBiG9Viz8SAvEWMVyc4WvX3wptR2w6KynyU9cmlDaVHp
         dxjMsermDzK1US/Uca5lkvgj5PuiNyqgS/7bsbbgH+WQKiAhduT51eueELDYCMIMmZeN
         owX/bIVpn8HMvieMc2kfmiqbbsE7E193QTwCScSXybFulRDcl7nAQQ/GJHj/12RMw6Tb
         JSEOXRgPi1Vsdtw20TLXUa7RNuQanPF+SMf6yCHFqLMTxMvsLLmhHRj2gy6LdfRNP8Wc
         v67jteEzlRzpx5vQoNlJDKm6EtXyu+NW7F5i23+qUvpqBX2n1L4J9d8cGDBYvWNlFNg2
         mlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786077499; x=1786682299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OApPi/aBpyIH8HD0zKAoJ3Rb4TUBRhQUqTZcuTXFIYw=;
        b=AfSpppu6qmyV7gGGM2uaDdBymV5vt1Qb9fx9gM8vT4/1bWRpbPngW7u2mtWuOTeV9v
         v4cqVsv68XxarCh7ik5AIxr6qnBr2j3FpN4lv78cFMd8foQiAM/rVDNCqJSaPa3WeBIH
         gU3II18Icr5L+a376JgEDVU+Xri7GF3HJuTi2P/cKXevaZC0aeSG4tLMMZ+/amYizZNB
         57iz9i+cvxuawmFOYufjOf+10MORiIfoYfNiG/PtdLGRLgIVQ1IvF3h7fy4OIRNP63+Z
         4WTDdsxqLUMR4QOGg11ZRfXLiTIP8btzdL///NrymAixqEI/JVewK8VC3DxG6S6Zw01r
         gUIw==
X-Forwarded-Encrypted: i=1; AHgh+RrWWcVBXeH5BF6xg905gAMi8Ma9hdQW1UbVlT0xU5Nu5/WYhX57F498DpxjZxP/YMjn9NZdcdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzylvace9OEr4MuZEApwKdLIig6w6blnYexlOImI9kcybneWDn5
	fztC3D1WvutOnpeEPIzcW3bUNAFjdl37cYgPjvyMHLXvHFCUW1jNr70+eXdOxA==
X-Gm-Gg: AR+sD13yCUy2VGo8Iu4nE354ariKqIlOTJIYUFcQeHga1lMdQLxFCJ0r62rAKT/SnU5
	d7Guwy9ad4VIqpeec4NsnErZk3ym8xq5vLvHrf3tdjQEXm/LbdSCglZIArijVvzWuF7ZJG+61EQ
	9AD9rNBn2+zKndFxE+he+FUB/DZ/Pv2xfKqBFqmJW2G0bYswoKFpiwPltCFGpD0rFMxHzR6h4MW
	N+bdK4ZDEMZPRqm8UhG1UypLPNBBv0XC64LjXNyjYvmZ3rhqTy7rqaGOMHA5AhxZ9AelRXgzhSz
	1l/cZOt2YULEZd3m10LiWGuNzO+t/X/rIUB0vPplx2SL2jHnbe12nRWWgrK65yyxHW9fZcUnmij
	scKSCek/4GdZRk96UlmoPqkiiw7H1ywGlaqWloxWiATSeqwnjlGXK3g5J1JktGO41e9cKBXwACT
	3cx64lVmz6Ak0AnsGUU+WLA8E+ggBSMLvEJEAEho5+/d+laqiygWMtXAB2Mbzhtwd8eg==
X-Received: by 2002:a17:90b:520a:b0:38f:efed:5445 with SMTP id 98e67ed59e1d1-3903c54adafmr20909787a91.4.1786077498756;
        Thu, 06 Aug 2026 21:38:18 -0700 (PDT)
Received: from Default ([2409:40f4:102d:3eaf:6f2d:c1cd:a882:e082])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bec2ec20sm2749192eec.28.2026.08.06.21.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 21:38:18 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: linux-usb@vger.kernel.org
Cc: valentina.manea.m@gmail.com,
	shuah@kernel.org,
	i@zenithal.me,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+af76b01c9a0f0ab60fb0@syzkaller.appspotmail.com,
	Jeffin Philip <jeffinphilip14@gmail.com>
Subject: [PATCH v2] usbip: usbip_host: fix null pointer dereference in
Date: Fri,  7 Aug 2026 10:07:59 +0530
Message-ID: <20260807043759.12218-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rebind_store calls do_rebind which dereferences udev without
checking if it is NULL. If busid is registered using match_busid
but the device is never bound to the driver or it is never present
in the first place, it triggers a null pointer dereference when we
attempt to rebind the device. Fix this by checking explicitly for
udev first and returning -ENODEV if udev is NULL. Add usb_get_dev
in addition to the null check to get a reference to udev to prevent
udev from becoming NULL after the check. Drop the reference after
using it in do_rebind().

Reported-by: syzbot+af76b01c9a0f0ab60fb0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=af76b01c9a0f0ab60fb0
Fixes: 4bfb141bc013 ("usbip: usbip_host: fix to hold parent lock for device_attach() calls")
Cc: stable@vger.kernel.org
Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
---
Changes in v2:
 - Addressed concerns raised by the maintainer in v1 discussion
   - Added usb_get_dev() to get a reference to udev preventing
     it from becoming null after the null check. Drop the reference
     after using it in do_rebind()
---
 drivers/usb/usbip/stub_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
index 79110a69d697..c911626427dc 100644
--- a/drivers/usb/usbip/stub_main.c
+++ b/drivers/usb/usbip/stub_main.c
@@ -256,12 +256,21 @@ static ssize_t rebind_store(struct device_driver *dev, const char *buf,
 	if (!bid)
 		return -ENODEV;
 
+	if (!bid->udev) {
+		put_busid_priv(bid);
+		return -ENODEV;
+	}
+
+	/* get a reference to udev to prevent it from becoming NULL */
+	usb_get_dev(bid->udev);
 	/* mark the device for deletion so probe ignores it during rescan */
 	bid->status = STUB_BUSID_OTHER;
 	/* release the busid lock */
 	put_busid_priv(bid);
 
 	ret = do_rebind((char *) buf, bid);
+	/* we finished using udev and don't need the reference anymore, drop it */
+	usb_put_dev(bid->udev);
 	if (ret < 0)
 		return ret;
 
-- 
2.55.0

