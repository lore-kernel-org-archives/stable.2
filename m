Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0905D10F2
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 07:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788073303; cv=none; b=Xv2kqAJAsg9g68qtQqCoiz5aBgAkNDzvxVpMOim0e9SVaZYb3aZrwF/85vXlzERA2iyKYs5J7I63jpF1iBzPN0fF2xtkcEUQNrX5jiMaoyskbl2A+8nPRBJ6NArdPQtJDMiEP326Tj/8hl2iBgnrv0jk+/7BihxJD77s8ZQ1T1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788073303; c=relaxed/simple;
	bh=TjYtPl/j554glQJWmPU/xoPlEoAnKmGzpt4JeYVoUIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOs6AZcx6GnXEEpDv8EbpT9Td+wEqIjovAyOtuX30L5jy25ZlUbV2ZlIEFOURXw3xrimGINCHVZ4Rn9cReTgfX9i9YralYVQEeRaN5YBaaeq9eCRsyabtufJk1yHbkGBYYz1ONkswZM3TWaRl7uuzH6POFwNg9LUwpT9Z6705Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MM/u22FK; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MM/u22FK"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-39266382df6so2050831a91.3
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 00:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788073301; x=1788678101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vaCVJ+LOOuM6dyxWqxk8vRI4Jf0X3ny9jaek/3um9y0=;
        b=MM/u22FKDMx/EgBjiHCtAup6iSOG07WdTURvJL8aEqp4Iv35E3wigyr/F1a/VCYf7C
         Re75m1iMMAA6ExATaLnHPp+em65YxPjm31pf2axswt91zGvidykTU0xYY6UJ/ruhJUvg
         78tPIG+5odHRY26V4sethKiTX8PXP4bsLU2eDcRB2EIGqcqMAXuASuUZhNm3z7Y6xIrM
         1sb++mIwuEPLNMbcTtG03AsQB3FhlAXF3ZS/94QaQjxa6yrFaVUj9N2UEwb45uFRFzRN
         ufJNvinnA6AU8HY6f9eDom/WNYtNCUpePYHwRERmUIQEyJquwtlrMBMpZbzYjTC/ibTi
         2RQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788073301; x=1788678101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vaCVJ+LOOuM6dyxWqxk8vRI4Jf0X3ny9jaek/3um9y0=;
        b=dD+u66bzMMozCVg8ETCAt3sBwNJmjSmwOcmFyeByWIr1ijAUqlSPJHlpe9ThctvzWu
         6mMdofwbTBg8R2RKP+ru8ap1h0afmEURX5yCskSxQns+gAahH61vuDl4JMMKVfsQmkXv
         JO+sCoRFTcl20tsrxwAQsQkHPG+qtG/GyBVZouQSW5gWFyMZfFmUuvDizHUx0amqgCQJ
         ydJtHdisrlqIjJDarX6xunMO1Jp/SsAPZx8QjH/L/7gwRIj+Qc8qlW/i+jCc9hPLfElX
         C6irJ21QDlIokh1JPvwxZYddb/iqmVxmbZWUPcvWRG+20M16TXln9nT57QsIPNXxemhK
         BKFQ==
X-Forwarded-Encrypted: i=1; AKwUvBwK03B3Y2Cvv3vW+gv0BwTeSPXqiJ6O2lyWHQZCBTVspZppE77Lnba4yOkPy6u/3Cl40i7OCqg=@vger.kernel.org
X-Gm-Message-State: AFuF++k/Tmzd25yJ/oLd4CcI/EUhDFHdZs+chBigYW0iH7H4kkCrKpdL
	gaHnknSOKfze/cu8DRoFWcY2k2vP5jxHSDaU9kkWAAEi6NiWgk0YLBZs
X-Gm-Gg: AYBFou37whrHLJ7km74PgMggrUQuTMLofq6vrrLzsJzETEjn/xGDz8udbOY36ZEJlq3
	PtD/wmHHdf4jYIabBYe7v3TuQbDPjDDyvISjX5qKymsI6H50frtVkfqCqDodRL5BzUtFxnrifOM
	yIBrPwBkkP65XMfC5vrGW710HRNNbHZxUcET5p1pL1J867Mv9Sbl6ZTFaAGN3wBj5JnKjIL1F6U
	WJi2os6zCqCaksg69H9FgVp/divoPaOcceZ9x0DA8zRCI6HR7WoTbxo7LK17mE7yZfmb9LFx9oY
	XKRSXNodvp70Gz6Qp0JqudaeqOofmFuoc9viijYXdl8SHZYC3v0qbO4ggGBS2A6peuOl5628V4k
	lUvQm8RrbIi+cyjnm/xwFOow3eeOoOPN4YL4ISwVTahoqvudkR9oua2cvsx57jvb1vsaSYeLs4L
	nRYbDZ0cETKh7vwGn7ImAz/z85FuiwbVnp8Uo6hDHp7h+5N8JdJGAwkIgYGR+j+87OG90kMYef4
	IYaqirfMp2Y18Dj4WjqdCZFIKwKaKEguwOgkLyTOxd9j7TcCCAyzmF597euNqXLCSb1RzuJqfZZ
	dHvuhh20rA8GdASVB5vIFc1c9P5ecHD0pJ/fGWx6Pjb0VjUZuvPNt1y6V0rPVgAZo9+isTKzjrI
	ZKHi+qRjcArO4tyMEEco8EaQCL3AtCbxAVPb3hbc4Ze5QP2GyFbOIHQ+NnPkMnpE+aEoX1wCzUh
	kIlxriSEo=
X-Received: by 2002:a17:90b:6c5:b0:38e:bbf1:de3f with SMTP id 98e67ed59e1d1-396d0f9d0famr31991593a91.12.1788073301303;
        Sun, 30 Aug 2026 00:01:41 -0700 (PDT)
Received: from HEXER.localdomain ([175.157.17.45])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0bf8a13sm30220400c88.0.2026.08.30.00.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 00:01:40 -0700 (PDT)
From: Kanishka De Silva <kpskanna1915@gmail.com>
To: greg@kroah.com
Cc: tom.leiming@gmail.com,
	security@kernel.org,
	stable@vger.kernel.org,
	Kanishka De Silva <kpskanna1915@gmail.com>
Subject: [PATCH] ublk: clear VM_MAYWRITE on read-only ublk char device mmap
Date: Sun, 30 Aug 2026 12:31:33 +0530
Message-ID: <20260830070133.559-1-kpskanna1915@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083055-isotope-broiler-88e5@gregkh>
References: <2026083055-isotope-broiler-88e5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_ch_mmap() rejects mmap requests with VM_WRITE set, but never
clears VM_MAYWRITE on the resulting read-only mapping. This allows
a userspace daemon to mmap the per-queue command buffer PROT_READ,
then upgrade it to PROT_WRITE via mprotect(), since VM_MAYWRITE was
never cleared.

The command buffer holds struct ublksrv_io_desc entries that are
kernel-written ABI; a writable mapping lets an unprivileged daemon
process corrupt fields such as addr, op_flags, nr_sectors, and
start_sector.

Same bug class as the drm/panthor and drm/vc4 VM_MAYWRITE fixes, and
the 2026-08-13 ptp/vmclock fix (a5edadbae57e).

Verified via mprotect() PoC: before the fix, a PROT_READ mapping can
be upgraded to PROT_READ|PROT_WRITE and a write into the command
buffer corrupts io_desc fields (confirmed under KASAN). After the
fix, mprotect() returns -EACCES.

Fixes: 3fee8d7599e1 ("ublk_drv: add io_uring based userspace block driver")
Cc: stable@vger.kernel.org
Signed-off-by: Kanishka De Silva <kpskanna1915@gmail.com>
---
 drivers/block/ublk_drv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6c5bec7..e5ba07d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2653,6 +2653,12 @@ static int ublk_ch_mmap(struct file *filp, struct vm_area_struct *vma)
 	if (vma->vm_flags & VM_WRITE)
 		return -EPERM;
 
+	/*
+	 * The per-queue command buffer is kernel-written ABI; prevent
+	 * the daemon from upgrading to writable via mprotect().
+	 */
+	vm_flags_clear(vma, VM_MAYWRITE);
+
 	end = UBLKSRV_CMD_BUF_OFFSET + ub->dev_info.nr_hw_queues * max_sz;
 	if (phys_off < UBLKSRV_CMD_BUF_OFFSET || phys_off >= end)
 		return -EINVAL;
-- 
2.53.0

