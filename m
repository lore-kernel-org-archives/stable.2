Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB9B3BE647
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790755164; cv=none; b=VW5ABWua8TLgLRGsn8+2jtcUUnz0301B64V+ZgoVFTmsP4sDQ5fne52ksDm+mPdG+cYGpusn7eMMU0bh5fiKjvuLCRZMlLDJXWNhWL44FnRDd+4NpUR1t4HWjrCcjP1yNb1oTAihkzPVNOEa1HJo9oZjCEeF24Ki6doz5s1+RrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790755164; c=relaxed/simple;
	bh=NI4deWyXYxlDZ5Psff3uegs1r20u4xH144iUxLKtfAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k4Bfu2d3OH7OGyOnwC5jewQ8jpZuMl/Es2vR7sZ7s/l8LBKjHdrPYI7Oa+GB9TVwMFVroncPAXURRHBiXtyUmst+9nr8CdbmEzyLAgkcQcqpcczwJrbmXpVxhbLinB+1WzBk3SPHgzm4di0p5WbMfdAwzN44dvJBUJSAp+LOLZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2eNdHxO; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2eNdHxO"
Received: by mail-pz2-f37.google.com with SMTP id d2e1a72fcca58-886ce63c1c5so163850b3a.0
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790755162; x=1791359962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vfbBhg1DcI7KV0DOQuXjyz/HcnuOmRxLvnIDKvsQamY=;
        b=X2eNdHxOz8hAbHiEVDXnjJ94ztLEUpz6coimQq6Drda5TD9sVliEdREHaU9Vk6jg/4
         xPZL0nJXhwbU5JtRvwiqbne1MTrX5S5PDe5xpl3+c0No1I3uanhc1AXSo4zgpfDNL3Ap
         1XEIbQbGoiaiXaFU+u+0YHjiRFfCpEC/G6t0MJAoDQqWOg60zHGer+ZtM6UeJ8s0XCk8
         RPIm0v+mtOuMS1Vm0smiIxYubQUWdt0nhrUP4E9mMk0S1gU+PKRVsZQ86kZHS7w7Q46z
         CLPDlHuj1pFVT8lZpttfeNEgvbBpRklOXxloDvDgCkxpCYT/bdmavf9Mop2p13gMGprq
         l1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790755162; x=1791359962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vfbBhg1DcI7KV0DOQuXjyz/HcnuOmRxLvnIDKvsQamY=;
        b=ZqIg3A/MUpWrkGZ3NJjearHVarpRkFfswGaMo2vs6TcNZ9EH/S9P8yBAVcqoilq6bK
         Q27fWzaDJ9PFyAnAfBMerPh6B7NRS2NnNkLqBfysKuGLzaaBIpGc0bSfmk8JwUfBHzCh
         hfvfGNaosTZBZIgWtJ/l+c8TIqGxEbIMoSXvgtnqdw8KOS9jox5r9WNUa9rPn5Bt8Xtm
         pBz+RoFqP0r4XukoK0x2Lf8RoC3d3MVAiZIdBUtrPqlw2ZI0d1K2+T/mPbT5PBZ5c7aN
         iwEGXiFnxolH+ql14DFEkMiep/CsxCEFNWHvExJJGbTvhZkwFnxFior3VmpG1jxza+fZ
         0JUQ==
X-Forwarded-Encrypted: i=1; AKwUvBz94OcD0fOMFDltaRtLBtuTO5nZqfbEHkjq537/YmkM5hDAggbktcZFqyr36Rbit4FfQZ8MwUE=@vger.kernel.org
X-Gm-Message-State: AFuF++mzEO+X4QrleRoguHV4T36cYZTqvxsQUQDirOWpfl41bKmvuiiC
	6oFsN00aSofyaWGAZkMjJmznHbn6kUWh8Oshv+Ao4BRcCfKXeV871hCd
X-Gm-Gg: AYBFou3Xosl7zD0aUfRufqhN5nPocjhwss01NEhTYkvCfVSSLddcGmEmAbFCKuccew7
	KZ8XIIt8cYfDLsIm5l9I9aoY8FYRZadfLJcAxPmZGrXDbvcLSWSyhwXYiOD6Dsa6k+LOcF5KTlx
	7nkHehr4VcMJ5BXBy+qS2Evk0tto+b/Njs61WEvrmY26lmv1/1QPwr6M4QT5I1crRA7oWVq1R68
	IK11ucmoahHSEKuCHNLAv3H2ZfUlSLmGTJorenQUcBlMrv60pVWUlOyB4f03y26GLIZUxJo8TUf
	PKeLY9VuRpN0oDtuDWUMnmwRAGAy8uHxW2apjWy+BGul6IW6KUiZXJ48eSGDb4BDxSepKQulDYp
	vyTAsmqGwC7RpV+SW4sQf5FwRRHrCoTp8GRovqrSQ0eUiUaKpiJRX4PjfrG9raAlWBI1+Hw63Oe
	Wm0sHac+pzIGgM3H5A6OWoj3RucnaS/PhRx52KVJFnFJf7dJxh3UQ3khIHasBgOsLaJUh3MNbN8
	RD9QAIr6UymjqbwxbmczZX6i0PUuA/yHPi8Wt2abmgZCmvWEXybpTChios/x+qNMBh+xPuNneVq
	/0aAWLsapg==
X-Received: by 2002:a05:6a00:1da0:b0:874:705d:f656 with SMTP id d2e1a72fcca58-8874ba252a9mr413795b3a.36.1790755162269;
        Wed, 30 Sep 2026 00:59:22 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88725d684ccsm403996b3a.40.2026.09.30.00.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:59:21 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
	Felipe Balbi <balbi@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v4] usb: gadget: f_printer: bound PNP string copy length in printer_func_setup()
Date: Wed, 30 Sep 2026 07:59:20 +0000
Message-ID: <20260930075920.483189-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In printer_func_setup(), when processing a GET_DEVICE_ID class setup
request, the IEEE-1284 PNP string length value = strlen(*dev->pnp_string)
is copied into buf without checking wLength (the host's requested buffer
size):

  value = strlen(*dev->pnp_string);
  memcpy(buf + 2, *dev->pnp_string, value);

When the host issues a GET_DEVICE_ID request with wLength smaller than
value + 2, memcpy() writes past the end of the transfer buffer, triggering
a slab out-of-bounds heap buffer overflow in printer_func_setup():

  BUG: KASAN: slab-out-of-bounds in printer_func_setup+0x280/0x450
  Write of size 3074 at addr ffff8880024f8000 by task init/1
  Call Trace:
   <TASK>
   dump_stack_lvl+0x70/0xa0
   print_report+0x153/0x4c6
   kasan_report+0xf1/0x120
   __asan_memcpy+0x3c/0x60
   printer_func_setup+0x280/0x450

Bound the PNP string copy length using min_t(u16, wLength, strlen() + 2) in
printer_func_setup() so memcpy() never exceeds wLength.

Tested in QEMU against Linux 7.3.0-rc3 with KASAN enabled by binding
f_printer with a 3074-byte PNP string and issuing a GET_DEVICE_ID setup
request with wLength = 64: on the unfixed kernel this triggers a KASAN
slab-out-of-bounds write, whereas on the fixed kernel value is bounded to
wLength and 0 KASAN faults occur.

Fixes: b185f01a9ab7 ("usb: gadget: printer: factor out f_printer")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v4:
- Re-target fix strictly to bound memcpy() size against wLength in
  GET_DEVICE_ID handling in printer_func_setup().

 drivers/usb/gadget/function/f_printer.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index a27792966287..f8726e3d849f 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -1033,9 +1033,13 @@ static int printer_func_setup(struct usb_function *f,
 			if (!*dev->pnp_string) {
 				value = 0;
 				break;
 			}
-			value = strlen(*dev->pnp_string);
-			buf[0] = (value >> 8) & 0xFF;
-			buf[1] = value & 0xFF;
-			memcpy(buf + 2, *dev->pnp_string, value);
+			value = min_t(u16, wLength, strlen(*dev->pnp_string) + 2);
+			if (value >= 2) {
+				u16 length = value - 2;
+
+				buf[0] = (length >> 8) & 0xFF;
+				buf[1] = length & 0xFF;
+				memcpy(buf + 2, *dev->pnp_string, length);
+			}
 			DBG(dev, "1284 PNP String: %x %s\n", value,
 			    *dev->pnp_string);
 			break;
-- 
2.47.3
