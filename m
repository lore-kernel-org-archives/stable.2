Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD0C3F327D
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 08:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054028; cv=none; b=Mw/oSdC6buq67qM2BULD45m9XboeMWxGAoZXZUi2kQqh+B7LlXlQVQ6jQiqzGR1y8+2TZK6kMvdaaa4pISGZ9OdAVkt3ofTe6u9G4Li4RWuHToEuW2eK6ASE6Ri2pPo/0Q6ywpjqYXqsYXepYYROjLXkxODa7oAf9jHRIeSX9Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054028; c=relaxed/simple;
	bh=HOcRnjQ/78+UziIir9oKy8ANLOoA8o6bAT5N5PtLkpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JXcs5jYo3Pm3HQ+8n94Qv42OfFi5lJwK/00uJxOCheE05VyolMuTU58mU98V6ZJsfDNowCBRQqUdFX9rU1et6ZH82eQKZOvV31RC87D1CsCT9BS2THSsZWZpXS3rSotlHgDIowINfLV4BCRmzVa9QlDWdOqa6hS9uLkPbJT5uns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXfj5Hb2; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXfj5Hb2"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc4dbcf2b85so940536a12.3
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 01:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792054026; x=1792658826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IYttvjru9fKHemUV/qFF+L5++eupMPrrcmnwQVMAKQQ=;
        b=XXfj5Hb2/vHfMhAXzMo+GL7tEdt8m0i0jRrMwVGm/uZW3CXMZ1tkR7fu6O702RKbqi
         gMdkjMgOshedqjlYDUd2Gr3HCJ48G9pPFbui0mvE9CxVqraMqFRPRtRh6R3zxyu6iGTK
         IoNA9eCW+d7AXren7o61t30JJraJRIBBpLaGspOePTzWKYkCW8HCb7RWmG83yGjEHNGX
         Wb21weEyBin4oRkd/3Vxd8yjDHvv3HGRtEKv3alfBjGIiqXXYh4Uq8wZ7uSg3K4B52vn
         IarERUf5N+8vNo+oZBwkgC1KmiGwNq1oz98toBbg8FbS8ourPLbqlY1eZB7a7E2VnKyD
         9nZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792054026; x=1792658826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IYttvjru9fKHemUV/qFF+L5++eupMPrrcmnwQVMAKQQ=;
        b=Wc9RU4FMVr9OjQh7Das3c3Gcbzw+TWbPbNj3DjyGO5iWzn1vja2vvQjOIDMLZ29xYH
         qe+fA9Zei7au/693/TMIBAJPwmC/cNmfLVaJk3dBcnCaGxl/NvpB1iH3L49LtyJ/zObU
         ig2Nb1uJaYoQ8SB4eKlmFjV/mpBXMgFGhaHwccAgaVxjDU5cQmqj1Oh6hOubZHC81q57
         3uNyjjM+pxjTO/01YW+OT7U5xEhGEikNR5JhMGrnBuVACcEcEXAJ9eSXS4XsF7lN+Qvl
         zQAjLNBcem0Nnh/tINC7ZDWREKDej/2ldKgl0YsB19QcpqofdrzeRTZaT89zYdBTun59
         w6pQ==
X-Forwarded-Encrypted: i=1; AKwUvBxHqkEQcV9/xoXiVetCMymMI+MP57vtPf4ZcMcGbCLXuTs4jX7UYtn5ezO1+yxB7aGv8SFSKXE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhq4iifeUqlBG5KrEBLyJZqBeu//KCVqvDubpM8vCdvJmfcrOJ
	Z+3/6Oz3oS7hwwyg0xD+bFd9kKmK+5vh92WAgdH5774MzZHQday0H2/K
X-Gm-Gg: AYBFou1tyMU7A7zFIMAAbZJYGA0lJH3k5LLpi1QnwO9q1NioxBXbtAzEvCp/w+/rtUV
	qamgjWtiuFz47Z8VlpN7lZETctbFBRPcUHFkMmft0ZTaB0KrUMAfiXBd0BR4RWfNfKjvreC6aYZ
	tgu+nsXBE2XsxPNlYEEI16GGFjXni8lE7GyziDsiqbwyXdF22JqTXrswaUaQ8YrINxoCcUBpuSS
	bwLtzYfBEdC4Iky/U6kzvt7E4FEchyOxyta22FrB1pAGZmm51YjSBxEEMKUokfSXECFqOaf3rwD
	q18Rmd0I4Xajvpncm5o3/LHNP0l6CXqHRPDvlIKZQJD0bJjR6KOvyRY+eo3KwGkADKscxzAz42H
	h8YeSJgPbjxduHMcRTVx2NU+arw9zCATeobF+zqArSyTgLZla52RTcQ0hfrRatu+xnPeRikfzsf
	ibMNHoGUReuhZgeqW+PNm9Hs61lbcyDnrE1ON5+qk8NSOuKkRawEtUNdNNiixZAtIF4kukKGZfk
	oe8NuaUHGpAt4jcYyCHAb28tfz7kikdjWwgpmm+tpS8g/F/0yTxg/5mocXIpUiY1hyI08qaFbYT
	/F5/bAFszPXOZke2lqMEFzTBT0UhaKVn/yyJFQvL1HTGteUM
X-Received: by 2002:a05:6a21:490d:b0:3cd:7ba2:e669 with SMTP id adf61e73a8af0-3e16bb71b3amr16357663637.10.1792054025821;
        Thu, 15 Oct 2026 01:47:05 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd635c57517sm900574a12.13.2026.10.15.01.47.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 01:47:05 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>
Subject: [PATCH] usb: gadget: f_printer: fix pnp_string use-after-free on reconfigure
Date: Thu, 15 Oct 2026 18:46:58 +1000
Message-ID: <20261015084658.70918-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f_printer_opts_pnp_string_store() replaces opts->pnp_string with
kfree(old) + kstrndup(new) under opts->lock only, with no opts->refcnt
guard, so the IEEE-1284 ID string can be changed while the function is
bound and the gadget is enumerated.

printer_func_setup() answers the host GET_DEVICE_ID class request from
(soft)irq context and reads the string with no lock:

	value = strlen(*dev->pnp_string);
	...
	memcpy(buf + 2, *dev->pnp_string, value);

dev->pnp_string points at &opts->pnp_string, so a concurrent configfs
write that frees the old string races the setup read -> use-after-free.

KASAN, a configfs writer racing a host GET_DEVICE_ID (reproduced over
dummy_hcd):

  BUG: KASAN: slab-use-after-free in strlen+0xe/0x40
  Read of size 1 at addr ffff888005036000 by task swapper/1/0
  Call Trace:
   <IRQ>
   strlen+0xe/0x40
   printer_func_setup+0x410/0x890
   composite_setup+0x67e/0x4690
   configfs_composite_setup+0xbb/0xd0
   dummy_timer+0x1934/0x1e40
   __hrtimer_run_queues+0x1b6/0x410
   hrtimer_run_softirq+0x13a/0x260
  Allocated by task 3486:
   kstrndup+0xb2/0x130
   f_printer_opts_pnp_string_store+0x3f/0xf0
   configfs_write_iter+0x1a7/0x250
   vfs_write+0x5df/0x940
   ksys_write+0xfd/0x1e0

The setup path runs in atomic context and cannot take opts->lock, so
serialize by refusing to change pnp_string while the function is
instantiated, exactly as the sibling f_printer_opts_q_len_store() already
does for q_len.  While the function is bound the string is then stable
for the lifetime of the live reader; it can still be changed when the
function is not linked into a gadget.

Fixes: 24b7ba2f88e0 ("usb: gadget: function: fix dangling pnp_string in f_printer.c")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
Tested-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/usb/gadget/function/f_printer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index 1111111..2222222 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -1269,6 +1269,11 @@ static ssize_t f_printer_opts_pnp_string_store(struct config_item *item,

 	mutex_lock(&opts->lock);

+	if (opts->refcnt) {
+		result = -EBUSY;
+		goto unlock;
+	}
+
 	new_pnp = kstrndup(page, len, GFP_KERNEL);
 	if (!new_pnp) {
 		result = -ENOMEM;
--
2.43.0
