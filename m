Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C5D2356D9
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 01:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780536007; cv=none; b=IaJDN6bPCjWWsQR5v0IZJt1vAWsS0fRYIr++W7TlFztZVzbuhdqp8iSVNgF4Ux4/4eCxoKW/1UMXAFg2/rOduYtHF8wRrE3Y+jdytkOhmO0LAUA3gmcAfuGhpjIRhWH9OgVsmRW8bCU6zjOV4u/AzFjKqXwnhhJ5yQPMayNALrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780536007; c=relaxed/simple;
	bh=//qG2YUy1igECfxzIiDXJ2RwgW/jHIcTxvGYWeK8tVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CG7l5QeMXOyO5J5u0yIXksNz+IkEs6eC3vuzXyV1+QeIdrjRKtjNgnwaK3/Z5msZ6bf937jdO0KbIh5C5PiV/vqXaS21SKJ+ytqoVvQVSh3mxI5Tt5Ctm4In9+UGG0r2Qpe/RhdLmyb/wqSYGWZ+fxz+5deFM+Iay64WDvrmj/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8lEQATQ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8lEQATQ"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36d98c9b596so79491a91.3
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 18:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780536004; x=1781140804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9znTJVSnmEmx0baqvaMhva1y3Nj5WbpC2YTtVwi/4is=;
        b=B8lEQATQHuNleplQu2g/KM7lLk1nZX+vE+ezT5BgobtoVFT6sGfyQieIFM90qLYd6u
         PnyXt0cmfdudypd2KCWh1TASwOi6G+hPrmDvqu1LbBRWvFV1Fxpxy/idJH6+9obK8AzM
         dqvVldz/kBso7L8eEQ7QNjVtSgzKuQI/G9vEdpo+ON3WBQfB3Yp26kTs/KMxaKLZIn0U
         OsH+qmj0j8hZkusQ1e7CAaFLjKuq/cw6nS8eIQ1kJCoFg796/Fv50gaKQHCqeRcT0zYO
         53MvQB37cUq0rUKrDZiDIZcrekdVN/sh/lOAreA8is9LRyekalM8uAZlfvefbE24ph+E
         gB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780536004; x=1781140804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9znTJVSnmEmx0baqvaMhva1y3Nj5WbpC2YTtVwi/4is=;
        b=PqL0hw9pvQPF7Ka5zdQfWAeK94BwoN7LZPhxhpR827xQyBoUBUgIDPgWDjVAZSVmVJ
         U4gLrVBm+0GAZdpXvc+C4JFR+9fAlGVrE215DUz/+Ie0L7jbiCRDhUTDb1OgzpayLG41
         XDCYCUGR2mupJquKqZo/7LILBBSvhex9zalKYCAIwXGCnRUYqA7G2kqADQXLMGoCfAc8
         HgXYsEPn6R81DG1iwTKtnfDdITzzbIJDb6tsqyf25KffCJazGjjjIugG6ENgOw01ySwP
         X5PaWVlqgQQvb535tpECc48jpkr8mAn1MSZNIvEp/BUUic7LEEHSkPvatMwRtTtPLK8v
         NQaQ==
X-Forwarded-Encrypted: i=1; AFNElJ/kL9CVEshM0J+wBnsD150sUTjBm1b6Hv+JRRMuCooN6JXVpNovmT5uSHSYzzhWfKll8TOKzog=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZXEx4WpUqrRtP6IssWbsSDCUMnSpInk4aJIQrf7U9uRFD6i+g
	DG7HLruuNLujI9dxHUZn6ftBqi+BuniGa5kS8Rz4wzeT2qmCPS1Trl3w
X-Gm-Gg: Acq92OGYYOeYfA1RBBrjcpMjbmofWkmjH5Qs1eeYBizxVgBGjUf6p9LMaF2bjuxuqpD
	vBfv4NZvi1QGTTe0p1ZGp1h93m1hCiaUb+OvsXwayeXaWqtOPeXgyU4oFcp9BBJlWGFowKGL66e
	P0kD88xN4tW/5E+wnkZ1yQINkTBpOva9UOyAUr3ZKekJGe8WEYBCXNopHRI5GIL84K6d78p7Q1Q
	DprpQURXXHmXztlBdPfPN+8o32Z+d6riw35hAgGsIu6/gAHJSiipKFPxE9P9OEl3bGiROybzxjn
	DTCTNfOSYZLH7yp2HZfbct3DeuXku6unSThBP2ZCV3hfYI0NWQOfkTdkilidYXh88ySC4zq5KEE
	/uyPsvOOsJjlOOwb7Erf8HTbrwycQVD/aND8EDRw1QdM7DVLtve6A6w+1JEtYxsWlK3UdhUXXcR
	KfV97s14mvRFAJhTzFffRRdrhLniGSmIbVw1dsmko=
X-Received: by 2002:a17:90b:4a82:b0:368:b4a5:c4dd with SMTP id 98e67ed59e1d1-36e2eedddc0mr5329918a91.2.1780536004040;
        Wed, 03 Jun 2026 18:20:04 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf8284dsm1123335a91.4.2026.06.03.18.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 18:20:03 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: samsun1006219@gmail.com,
	djwong@kernel.org,
	hch@infradead.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] iomap: avoid potential null folio->mapping deref during error reporting
Date: Wed,  3 Jun 2026 18:18:58 -0700
Message-ID: <20260604011858.2297561-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a buffered read fails, iomap_finish_folio_read() reports the error
with fserror_report_io(folio->mapping->host, ...). This is called after
ifs->read_bytes_pending has been decremented by the bytes attempted to
be read.

For a folio split across multiple read completions, the folio is only
guaranteed to stay locked while read_bytes_pending > 0. Once
iomap_finish_folio_read() decrements read_bytes_pending, another
in-flight read can complete and end the read on the folio, which unlocks
it. This allows truncate logic to run and detach the folio (set
folio->mapping to NULL). The error reporting path then can dereference a
NULL folio->mapping. As reported by Sam Sun, this is the race that can
occur:

CPU0: failed completion      CPU1: final completion     CPU2: truncate
-----------------------      ----------------------     --------------
read_bytes_pending -= len
finished = false
/* preempted before
   fserror_report_io() */
			     read_bytes_pending -= len
			     finished = true
			     folio_end_read()
							truncate clears
							folio->mapping
fserror_report_io(
  folio->mapping->host, ...)
	      ^ NULL deref

Fix this by reporting the error first before decrementing
ifs->read_bytes_pending.

Fixes: a9d573ee88af ("iomap: report file I/O errors to the VFS")
Cc: stable@vger.kernel.org
Reported-by: Sam Sun <samsun1006219@gmail.com>
Closes: https://lore.kernel.org/linux-fsdevel/CAEkJfYPhWdd59RKmuNLJg-bkypHz7xiOwaWyNVu3A8CUqQCnvg@mail.gmail.com/
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d7b648421a70..d55b936e6986 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -400,6 +400,11 @@ void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
 	bool uptodate = !error;
 	bool finished = true;
 
+	if (error)
+		fserror_report_io(folio->mapping->host, FSERR_BUFFERED_READ,
+				  folio_pos(folio) + off, len, error,
+				  GFP_ATOMIC);
+
 	if (ifs) {
 		unsigned long flags;
 
@@ -411,11 +416,6 @@ void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
 		spin_unlock_irqrestore(&ifs->state_lock, flags);
 	}
 
-	if (error)
-		fserror_report_io(folio->mapping->host, FSERR_BUFFERED_READ,
-				  folio_pos(folio) + off, len, error,
-				  GFP_ATOMIC);
-
 	if (finished)
 		folio_end_read(folio, uptodate);
 }
-- 
2.52.0

