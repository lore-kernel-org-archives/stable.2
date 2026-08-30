Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5421F3BA2
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 07:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788075223; cv=none; b=ZG0opdWkBuMhMvcXiPRET//pYyNv/WKeJKD4AL0OqNONJAqoK0nqC1PzbmnFbPx0ho1sp51EYY+hy4Cx+HjrU/qdd32lbDJgVO6sprY1ij83zjIw2ajDrRtFCKYp1gUBxw5GCgkwxYnbgq0p+K0RSy1CCi5fDcTpVaBr2qMOLQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788075223; c=relaxed/simple;
	bh=U41QKWCb5wZVT5AgkRyZK+w6MKjpL9Tu8ac+zzjqQUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZDod7EzFo5MTrcI7w2iTMIJxrBxkN1/3RA5TmwM0x5b/7AwLDAepLtN7x+KHuNTyV21Rw0PxqZX2awx5wq8tdLUA23cAJSiKxMdPxFj6lst/muF2rYAZWurqEj6YH7L1ZVNDLfj29H7ywloOXgWnLaQNMWm7GR/GYcCQDEPc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bT0hYlFS; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bT0hYlFS"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ca7c1176317so2050714a12.1
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 00:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788075221; x=1788680021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5hgvVg90KPg9PlOfVqdnTJqeAsOm9vQLV6x0bJ/G+8U=;
        b=bT0hYlFSkrmlQQSf7CERb2qkBx7IMOV25+c7Q5DEStmuuc/tT+BwOR4n91aMdVza+B
         s10wPY/67LVo59mo7y56DXSfN0h1ZpgwVdaT2OILKNW+swoVuGQ7nrwRFfimoH/Kj4yU
         pCPBM6vK+EQ18oG22YlDKj3OVgVGqGnWP+P9v7kegmnhxLF8xN/tS3VrHbr/IVu+mQrN
         yn+hxFxCJ/8mXRAsQLhCq8lNXXdal27sSkXG4ShUAEDbJox97//da3knloAd4cc4Xx5r
         shDJ2D2C2nlYK6UaO7DNkK3d77V1DD+Bd4z8JkLqp1rHk9NV58hY16ZDzG4lp5+WcH9K
         4IAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788075221; x=1788680021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5hgvVg90KPg9PlOfVqdnTJqeAsOm9vQLV6x0bJ/G+8U=;
        b=XycAZ1yoVFt/yBcK9XH5pBo6JkzdKopluOumUXmgewYdr+Tt/3ZD5qlRG2yfdDaiHa
         iCPXoO0jwSXzavayvegf2DbQahbsmmyEyQ9x4iIq8FJPZAbhbZCOVubctlZDDGCZyUkg
         oXPFC2afk+JFgBIj6uWBfAim2zscId5ykefDWwsMqmmMiMS6p1/Sne4gYbb5pPXTJJid
         go7bYcWiY+pvRcdTYZNxY7A0BEXNXqm9JIAXMksMB3apypsqOySZ8Y+lHdHgJ4FCYLVO
         vcq4s9vUt+z3qiFwmvpPFAMBgsutyBR2cnfuzFmLGbcapNBYaQcCYcdS7p5n0H9aBgtT
         +Crg==
X-Forwarded-Encrypted: i=1; AHgh+Rq6oWD8TRpbEQNSZzYZ7nvO5sexMOwuBs8Gph+lmL72XnczKPpCES3F+7dGmVrM/yJNsEXNwdY=@vger.kernel.org
X-Gm-Message-State: AFuF++mX+BMKKGxJ9Jdso06OQYjZMfSHE0ektvPIf3EHNd4KZ1KrOlFp
	9Ls8Jd2i7BIH8Eayr+r2mExLKVoN+aVAjssA6I8ptl7tQYzbSNNUTkaw
X-Gm-Gg: AR+sD13qGqmlN3Yl0o9rmx1+YPXxSvpbabu1J7Ji4VGLVq+OqZbSrSqf3iDwUHdUO/y
	LvoHcOgYXyTYICUIYApq4vuF22eRQRs08wDoTcQ/3Ll63FSA9MLWJTUeZ/V50DHZutf9UYOGBh0
	juAhQQIem80m212Kempua8/L/DU2ey+vrqP9yoITsNQYq9KFd8FkDE/ngNXhtrvIUNsaWoF2v/P
	PAh6spMBeqcNpaseho54flLIrSJw2JCK9ZxFiGFGpkZN4WIpP13a6ZbDKOz85amT94pd3cEhSAx
	H5xG98hbpeuTv2WSC/xiv7llYjaK218CUOAzxFSYVl8csQRlO5EBTjH84KRVnCMB3uX/z4h80uH
	97g1Hz+eFNTg9UtmfF+sENiWhSCwBfd10ZHWOfKr1Q5E3C18rE4Qivbj2DAN0xUhuE9mEf4LyC1
	CYILOTMko+YDKazSVMABR820Z/o48Z+CsjpWH6xJQ+aWn5tTRkAe5SrEOOzHmYZZO6B8dRPZKgu
	tC9dEN669jTPRUgECc9SvbKyGrVYG2/x4StNC6bcN5TrDqaL+6f6LV682Z/Z62hl3Xl2aYsq2cn
	GqVUfYaNXxQFb1ltYVim5hmGWp5M2a3x5xlWQnWD/qLVOvwLERj+/u9TBvNHAl25XKV8NFSWymj
	uurCHpNbgMCY0zjRhKNSMA8RYYK2P6ef1yJPcFdXGWMlFrzgKJiQWoXwGOvGQZduPxnsP6J+AuY
	ak+p6tN+w=
X-Received: by 2002:a05:6a20:43a2:b0:3cc:f008:8125 with SMTP id adf61e73a8af0-3d265a3d2a2mr28366450637.1.1788075220885;
        Sun, 30 Aug 2026 00:33:40 -0700 (PDT)
Received: from HEXER.localdomain ([175.157.17.45])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e41837c6sm17293131c88.11.2026.08.30.00.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 00:33:40 -0700 (PDT)
From: Kanishka De Silva <kpskanna1915@gmail.com>
To: greg@kroah.com,
	tom.leiming@gmail.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	security@kernel.org,
	stable@vger.kernel.org,
	Kanishka De Silva <kpskanna1915@gmail.com>
Subject: [PATCH v2] ublk: clear VM_MAYWRITE on read-only ublk char device mmap
Date: Sun, 30 Aug 2026 13:03:31 +0530
Message-ID: <20260830073331.634-1-kpskanna1915@gmail.com>
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
Reviewed-by: Ming Lei <tom.leiming@gmail.com>
---
v2: Cc linux-block@vger.kernel.org and Jens Axboe per get_maintainer.pl
    (Greg KH). Added Reviewed-by from Ming Lei. No code change.

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

