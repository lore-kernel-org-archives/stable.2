Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6543438A7
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 07:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784099350; cv=none; b=bnz9Bg4LWZ9oZ0y6euLx9VaOa8DesxfU5+8xasTTQtZqbj+vxn2oFEw34wGGZIKCEoOsjbuCaYlHm1n0EKb/xQJH79yJhO6eOwhfBO1xJZYHIB9kU5PDG+p542mmo+tWbQNFD01xo10ZTiwfoFFMj6pGhi+hr4zjsEzqTuROegQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784099350; c=relaxed/simple;
	bh=7v6dMHg7QRy+mNTrsC2NjZRxBa+V2XyO37670IsPnKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ff8bcqfDqe/O1e4aZpOQoGKPhm0lQ62wKQhO/3Af2mgJvlp1wYHDZHKaW2yNMa02Co7hK89iHi0fiYyehTebLNHV5z+6j/a400/AgK0nIaCRQwJNz/i2sHpmRwO+hAqtFdrgjRskwL1ikBd/nwZmLc9P3Jl5oVmo9T+bY9oUG2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZExIMrst; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZExIMrst"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38511175ad3so4210808a91.2
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 00:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784099348; x=1784704148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RDReZvwu+WACe5u1eyzBGtlH44IHKUVUwf0bKZ4XQFc=;
        b=ZExIMrstgwr6lKCmn41WLkIID3FhssFkHUtH5S2nGTfzIteLA9PjH+DbNvOVDZ25fS
         7WHxi9Dc51V5zI0akUAJDs07mGk5TU+mP05fPtLCvIFfbSPZvwFm3qEJNpbLCfoOVEvw
         Lrv+TqvB7NzCjcf3CBZUSrJMeNAQlBBKWgMYHYvuHdovhmxWCghBuheYg57Tc3Pf6SUC
         va8WR5MVgZ4UQnScuNFrmy71DFtSPnuXogBsjgLYg8XLuH57DPW3cqEbUramhDxgRGc3
         6lJduU/hfR5IzvJcMyfcy+wxEdZqQ+5B2fohY1HSk0zqIVCqSMBiBl5asBGhncy1oWEI
         UA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784099348; x=1784704148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RDReZvwu+WACe5u1eyzBGtlH44IHKUVUwf0bKZ4XQFc=;
        b=Y9PcXijvmyukazYwNGGaZ3d3IydpuoMz6QpYCWWpmp70gC1Xr6d5BYyHRi2PPVu2FW
         ymQRo9frlXbeRbkXoa1B5hxuZ3hSDaFck2h7iZN1DBrE2qYZxaL2SpeLgdUHuxXkF3ij
         9WqwFDPtORqIc0XW42rX9Ap11pMGmWs6nfZmCofJtKDaexilLLgMFDCn+MChNJ5e9UxS
         LWI2ux2fSdsJ1bH2WF1bEE9i3zWNy33paKvemHw3DbhhAS4QNFKriS0kb1332yRiadSA
         yJ72H6fX3uOMAHeucmtXlhS0oPfaHExOMiGeDha8XPezUADaSkEv29NXWLiSTJNvB4yt
         F7QQ==
X-Forwarded-Encrypted: i=1; AHgh+RoPivwBbWVzxapewE748Bli1A+Kmh34f58mJPJDHt17Q3Nx2VajJZvEBPyqWyAf4JQb5uvsY6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUSqOV8BKdYgWl9tcD7vRyK3QNQguzjFZS6/571gp1LWxv6nE9
	TkjAk/aZPseD1gpP0R769IL1itA1CJ0+6dBaFnsA5o8WzmAYuHYLVNDm5GvUWa9XYwhtGg==
X-Gm-Gg: AfdE7cmBKNw4+s45sqa68wUN3nQH/1tdgrBuME2qmQEebux/ys53W20FyjEMlErEtEH
	SxlSU7R+fbHYrxdoPgWgSEx05O/Kx3+2qVnJ21JWn7v26gMnVoNIwZ1klbyBQ41leT+tN6vYZhn
	Gf5AeD/v7gfCPcsJ2UYyQr4wqvbZjDILItQ52JFYtgAUjVl68s4zn1gARfbK4HaN0Rne+CVDZXC
	EhdHU8v+F0pJEgb0BePk1pRy4P7AGMuvBsb+ICVgfocdQ6i65VjY9CAM99e/uVbdeYiu+xXJS5f
	K7aWjDMNb27zrt4MRmAq5Vh9inRHsVdcA8B9gAptLtesI09HubHV0xZVF+iCPhdwlu7aEfPC9sj
	NcquCxk2jKE3cTthdDXRed86kqmTFoMsT0rOGB4sNVsz0JF8FQp2i5rwgqEsekzM3+4y6Tpo3SU
	eOPGywsMCtRA==
X-Received: by 2002:a17:90b:35c6:b0:381:2684:519c with SMTP id 98e67ed59e1d1-38e1ae5fcb0mr4594484a91.6.1784099348089;
        Wed, 15 Jul 2026 00:09:08 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e174442f6sm2621595a91.10.2026.07.15.00.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 00:09:07 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] intel_th: fix MSC output device reference leak
Date: Wed, 15 Jul 2026 15:08:51 +0800
Message-ID: <20260715070851.2077965-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_th_output_open() looks up the output device with
bus_find_device_by_devt(), which returns the device with a reference that
must be dropped after use.

commit 95fc36a234da ("intel_th: fix device leak on output open()")
attempted to drop the reference from intel_th_output_release(). However,
a successful open replaces file->f_op with the output driver file
operations before returning, so close runs the output driver release
callback instead.

For MSC outputs, close runs intel_th_msc_release(), which only removes
the per-file iterator and does not drop the device reference taken by
intel_th_output_open(). Consequently, every successful MSC output open
leaks one device reference.

Drop the device reference from intel_th_msc_release(), which is the
release path actually used for MSC output files. Remove the now-unused
intel_th_output_release() callback from intel_th_output_fops.

Fixes: 95fc36a234da ("intel_th: fix device leak on output open()")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v3:
  - Remove the unused intel_th_output_release() callback as suggested by
    Johan Hovold.

v2:
  - Add Cc stable.
  - No code changes.

 drivers/hwtracing/intel_th/core.c | 10 ----------
 drivers/hwtracing/intel_th/msu.c  |  2 ++
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 3924e63e2eee..56acf31546da 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -843,18 +843,8 @@ static int intel_th_output_open(struct inode *inode, struct file *file)
 	return err;
 }
 
-static int intel_th_output_release(struct inode *inode, struct file *file)
-{
-	struct intel_th_device *thdev = file->private_data;
-
-	put_device(&thdev->dev);
-
-	return 0;
-}
-
 static const struct file_operations intel_th_output_fops = {
 	.open	= intel_th_output_open,
-	.release = intel_th_output_release,
 	.llseek	= noop_llseek,
 };
 
diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index a82cf74f39ad..84d99d7b1d20 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -1490,8 +1490,10 @@ static int intel_th_msc_release(struct inode *inode, struct file *file)
 {
 	struct msc_iter *iter = file->private_data;
 	struct msc *msc = iter->msc;
+	struct intel_th_device *thdev = msc->thdev;
 
 	msc_iter_remove(iter, msc);
+	put_device(&thdev->dev);
 
 	return 0;
 }
-- 
2.43.0

