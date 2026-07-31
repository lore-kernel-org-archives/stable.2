Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95D438D3E6
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514680; cv=none; b=RZcBerpGYJLwwu0EcJ3mhflNA3eCv09fB52t1ndFPEZr2Dj/0bhuMIU1C6MLoDdcl1wqZ5WBflk1ENLYee6AND2bnk4QIu0za19bgq3J7hRQ4K5J7Mj/lJTcKJpyjgm5Yu3p8SgmLO6LF4jZXGXUE5SohPRAUiyMsy/bkTmaa5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514680; c=relaxed/simple;
	bh=XiHTps66n/ucoodnksehaJ774Zj8/m6/5WilQKWcYtA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=onJXAUT8NdHWxZvFV3d3O00fPt/0YDrpvj8XGP/V/1dW8xEdFjQXmo4PNOGz1AOSYjh3vxfbBxcOTdG+gWJsRf6YcL1iYKvRrRycQ1XXJViTGDiWqPKfU78t5cobNp3x22zBBoMAzsK8DJNx/qnWtJndkBZ2a5yQk8xJbFInR4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oo5UZn3+; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oo5UZn3+"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so1157412a91.3
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 09:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785514676; x=1786119476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3fpbCGUKoDP5+AiSkirbnxfIufZXR99E39vUIbtAqi4=;
        b=Oo5UZn3+s/Clcl35L0i27lCyCVRQs4rNgvsX4jWn9B63BU4Cfiev6E38xXtaotn24V
         klPvlLCVASNsz/qWHRKdPaqj0WfSfn2xjfRsxY/FFpRdcLa+5ukWSVAazMZaw3DxyuB7
         lKAkF65rucM2QX3nEbKQm4WcVZ/ZYmWxRwrYy7HWM6hhJv/VFMAEyvjz8EMU6jRYBtW0
         W1gwnQMgu70yTMMXnAnKnIYBapLvWDM1hPcEA9Y7dbe2nVR9WD+M1qDIP7XH1bKz6YP+
         fNPnEfSm4y/nV5ytL9oXlALzUHKnTLO58RnV/1iLFx+1quqwKbXCUZkrswXfELG/af9S
         fhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785514676; x=1786119476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3fpbCGUKoDP5+AiSkirbnxfIufZXR99E39vUIbtAqi4=;
        b=EGbUZ+gSqSTXCKGbqf1M95WuE3vTYDBWo3eLdwtXCc2We5QMEzsabn+W5rQ4y3Ah5A
         pyWDreEj1WcOk1WIVV5wN7KDKuGy1WIyGUFb2vm6rTPvG8mmDOTG1I0Nm2kpe3zv2ocX
         PESqzzGQ8QJ6n7NkWgt2sHWtIvm4iByrOaPDRWlB39qvEuNto2gskS3N7HaxCSe7uzBq
         ljFS+aDXU1IPxsSbV3iA0wa6B6C5VbuXot9CY425rz6v3pTO9R4p076HY7bLZaOuym2Q
         3UrIdq45rIT2fA0Eg2x+8GZiTNt66LDRMKPJOnQtttIyv7l27t+ycmGCc3swBBuiFIIY
         WqGg==
X-Forwarded-Encrypted: i=1; AHgh+RrQNGvFHGKYvMPAdhfoJTS4tB9DDZwwKZMJJJ8dwydc7VUnKp6p6OEoHdWzbC4pNhwocjkJYjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmqyH3NNVPDw3BfuL8ti9UNcMCyurXQUyfkG1omJq62FNwgk1x
	5ZorBTVXXFv9G0StnxMOhKr4TMZyMQd4G2+oTkY8CN70V43sa+ktZ5U=
X-Gm-Gg: AR+sD12NqJfq5DUGB7idtk05ryO/nqwJjcLMCFW6JUKDokevurGfQ5PL3Fto55UnHy/
	dJZRB2KBE83E/0PxM/ZN6JqjuwYjO+vdBIQV7pwWXPagHyFJ3kt03qqH5WIJXQVu7W5Smpj9WYD
	x26b0OfemTb7axBH+w8AWjEtj37cHiJG7uXnm/sqEcEMLfY5xEpuRGWJ2i3hzqisjbmVlL/Myq/
	NccewMUNuRpo2antEyreRYODMNPELFuQLUrSvV9KeOCj5CCjyey/IBe+muyO2YuGMKiPUxB3dlI
	8bf50I2xfpCsP0y2lvjs4prMKmuz/spaZ2BaZX2Mpoj0+TQ/6WRgG4lh3ZWA0bv3HhZQn/KZiSW
	Elnnxdjd7gr+34dcwml8ct8EuVhV65leDDymWOMPgNAd4m3vtE4fM8Iu4JBxoVaiMz6LPQQMkUJ
	gLz3k7uCWWQ2YL+s6MBc7H0ZBupQwFT9jNARi4R1PwHKofgccR6QHcMYhtWOjBK3mwPd5te/VSZ
	P0afOqf4j80l0IqPMtBGq0lqh0pwXcYQvwQupCHtlq1O548/P340zQFRIwp0KAsDI20DbwUB4Mg
	rmhYDJmLaMjubtNbrWPH3CQ=
X-Received: by 2002:a17:90b:5824:b0:381:9028:5945 with SMTP id 98e67ed59e1d1-38fbc43a847mr445709a91.14.1785514676249;
        Fri, 31 Jul 2026 09:17:56 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2ce1778sm923096a91.15.2026.07.31.09.17.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Jul 2026 09:17:55 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] net: 8390: pcnet_cs: release PCMCIA window on setup_shmem_window() error
Date: Sat,  1 Aug 2026 01:17:40 +0900
Message-ID: <20260731161740.44955-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

setup_shmem_window() acquires a PCMCIA memory window with
pcmcia_request_window() and only releases it on the buffer-verification
failure path. If pcmcia_map_mem_page() or the subsequent ioremap()
fails, the function jumps straight to the "failed" label, which returns
without calling pcmcia_release_window(). The requested window is leaked.

This is reachable in practice: pcnet_config() treats a
setup_shmem_window() failure as non-fatal and falls back to
setup_dma_config(), so probe can continue and even succeed while the
requested shared-memory window is left allocated.

Route the post-request error paths through a new "release" label that
calls pcmcia_release_window() before returning, and fold the existing
buffer-verification cleanup into it. iounmap() is still performed before
the release where an ioremap() mapping exists, preserving the original
teardown order. The pcmcia_request_window() failure path still returns
directly, as no window is held there.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/ethernet/8390/pcnet_cs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/8390/pcnet_cs.c b/drivers/net/ethernet/8390/pcnet_cs.c
index 19f9c5db3f3b..e2081d493749 100644
--- a/drivers/net/ethernet/8390/pcnet_cs.c
+++ b/drivers/net/ethernet/8390/pcnet_cs.c
@@ -1434,14 +1434,14 @@ static int setup_shmem_window(struct pcmcia_device *link, int start_pg,
     offset -= offset % window_size;
     ret = pcmcia_map_mem_page(link, link->resource[3], offset);
     if (ret)
-	    goto failed;
+	goto release;
 
     /* Try scribbling on the buffer */
     info->base = ioremap(link->resource[3]->start,
 			resource_size(link->resource[3]));
     if (unlikely(!info->base)) {
 	    ret = -ENOMEM;
-	    goto failed;
+	goto release;
     }
 
     for (i = 0; i < (TX_PAGES<<8); i += 2)
@@ -1452,9 +1452,8 @@ static int setup_shmem_window(struct pcmcia_device *link, int start_pg,
     pcnet_reset_8390(dev);
     if (i != (TX_PAGES<<8)) {
 	iounmap(info->base);
-	pcmcia_release_window(link, link->resource[3]);
 	info->base = NULL;
-	goto failed;
+	goto release;
     }
 
     ei_status.mem = info->base + offset;
@@ -1475,6 +1474,8 @@ static int setup_shmem_window(struct pcmcia_device *link, int start_pg,
     info->flags |= USE_SHMEM;
     return 0;
 
+release:
+	pcmcia_release_window(link, link->resource[3]);
 failed:
     return 1;
 }
-- 
2.47.1
