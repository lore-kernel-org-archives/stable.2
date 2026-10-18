Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFBB47012F
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792328730; cv=none; b=VIlYp64pi7Drg+2OkZVUwL0/95Z7Ofepz+lALr8vqepnXvfZeZnRDcZGDZsgBESGvKL3fx1iKCbs8/vwCcRe8IS/1m4qtdcn92bOYB8hhZh1hTQEc6/7tHZ/Xya+TkyIgijmB/a7QC079u2Grt8ns7Q6ZZ8N6QXV/hUzYj1joME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792328730; c=relaxed/simple;
	bh=n1jnmiWZbd5NOkRkak7b15IAghD30omJjqx47zPf7yA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ry3OHvueyc4jYzJVT754sMP1plnE/GjIZEhZmNLXpoCnEwxg6mlnP1XPgmBnuRVOY6+cU5MFREUzSmqh7HaiFwQafBIuj0RVRWJ/XPg///wSf8/w9AGGwYe4XH8j4xrWfqdteYi5snk28eJUoOJVkHvUEOc5QK7GR8QLDWyfG80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iw514KFi; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iw514KFi"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so670125a12.1
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 06:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792328727; x=1792933527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c2uZEWy5t34eHwZsR2/5So5/B2QP3xF0LaMRdc7gRHU=;
        b=Iw514KFio+gKpjfziR6TOguvm7oIpT6b/l6iJLSWnNYoyKqtrobujtCkTf9OIQdOWU
         9cnfbXTf6eu6+ei6aSFQFOCc6xFsBqhqSbEG1RT+j0x1yvn4ddeXfYzGepQopydjXTGl
         RNCyMcG4Ne4VWlIolfANliZqUr+gR90CTZE3qMHHNrpxMYded43I+fTm9Pt4VbnnN0dF
         3mpRYPqVUdgXnW3WrYeLLrLBPMxfhvfGEwTy5GuYyQMcUdwj5x+39lb4s3Sv6LNu9wrM
         cqle20YXslWWQxinr3V21DgDb5koApZQDcdUqSLZeh+9XEc/a3cFfJW4Q6Z635g8APmw
         l5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792328727; x=1792933527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c2uZEWy5t34eHwZsR2/5So5/B2QP3xF0LaMRdc7gRHU=;
        b=PwJO+1jEbtFrzKOp+YAwol+xeJJ2je3U0MbtHLPAJvgo8+AUo889RdE2BrScwQGObs
         OZDYiCQuFPMeRXc424DrFVuINiyXrtw4+QExi6pEY4X63M/yqpBlWK9jZ3Z/Z+L/DQa6
         SMTOcb5U/q6Zz6nVQm7S6eJxyV1hoVYAm7SzN7sJkTuDKNMObuCpqRavylmaQ1b4A6bz
         sjt097mxSyEs06tslju+EZPy8sKTGbT3VM4j6aFixJ7jPkniRgcJe/znduUCDq69bi6P
         J1IJlmtnOUY8tXYehN4OgU34WsHh/1gxeLfRA6vG5toicqtRp8a98L90PWrDzGjiw3eI
         F0sg==
X-Forwarded-Encrypted: i=1; AKwUvByadKLPZIcLZMJ26w090+BepQBCIjpiwtLf+suQT89Gik5oiFdMZ9b+xnessS8Ckac2Ko3MTrw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxG65D1+Nj85TyLteNhM3D9MQwJVa+leelxWvhfC0E2deAmGo3
	ajZKybqKk3jqz8KtYU9ogbRcMKbCPmbhMDmzWR3zJ+2tmxdhAYkdTl4B
X-Gm-Gg: AYBFou2fjieuJsWOhaKmhcR7JON0C6ccQARDd2X/PlnRkrz35OPtqBcknuEW27PG6Co
	03OcB0F3IVMCntLqJePMoLa0n9+XOmGefXvwJ9ErkeHKc1xuO7BqsBzP7x1zl04j9MGd+33xpLq
	sGsTFdKvbU5Lcoi2BA9CnbJFmBwPF/5f+MGgkHYvnzgINvAxs3b54UrcZ4AFM5Z1+FCwpXYNg7S
	nX2ydkoKhs7w+wAvQZ+4GRgf+jpInOv8lGSWZHOpJJ/I0QPI/v4VzE4qnuZU4tGtwtkQ7L+e3T3
	LjAcFg5DFruDi7r0okXJBeYHRjolVdAaMkR9zItLf/bRKtiqKJgwqBYVaVWtNtNDz4R76y2wTV2
	xr5Hl/vbfIh/xlFvf9k/+8vr/X5Ldg4gtSWXLN7jYJkyoSinFAl/lpPlhXaRZg42JkJyKsVzoC3
	qkJaJ3EtN087hkt+KNeuKUhnVLBJ0oi7aI6I3+87MBuSfqKFMkhWI7fpTxMVBJ/cFxPhoA63ZtS
	oYoH1efZHTBr1MlTz3V5gGzgwuW18oG3uPRFIa60kpsYPvEB9BU+XoCSWuxOnDnCqVf59dCHL5E
	fKriXqZ5V5KUn7AKB5yXQZYZn4khkGotyh6aTJKkar22Zr5U
X-Received: by 2002:a17:90b:4c92:b0:3a6:f6b0:30ce with SMTP id 98e67ed59e1d1-3acef55d641mr3055223a91.36.1792328727152;
        Sun, 18 Oct 2026 06:05:27 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc49c263asm11415222a91.17.2026.10.18.06.05.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 06:05:26 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: f_mass_storage: take filesem in nofua store to fix backing-file UAF
Date: Sun, 18 Oct 2026 23:05:19 +1000
Message-ID: <20261018130519.65850-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fsg_store_nofua() syncs the LUN's backing file when switching from async
to sync mode:

	if (!nofua && curlun->nofua)
		fsg_lun_fsync_sub(curlun);

fsg_lun_fsync_sub() dereferences curlun->filp (vfs_fsync(filp)). Unlike
every other store that touches the backing file -- fsg_store_ro() and
fsg_store_cdrom() (down_read), fsg_store_file() (down_write) --
fsg_store_nofua() holds no filesem while doing so.

A concurrent close of the backing file runs under down_write(filesem) and
does fput(curlun->filp) in fsg_lun_close() (fsg_store_file() with an empty
path, the SCSI START_STOP eject in do_start_stop(), or forced_eject), so
it can free the file while fsg_store_nofua() is dereferencing it:

	BUG: KASAN: slab-use-after-free in vfs_fsync+0x20/0xe0
	 vfs_fsync+0x20/0xe0
	 fsg_lun_fsync_sub+0xa0/0xd0
	 fsg_store_nofua+0x138/0x160
	 configfs_write_iter+0x1a7/0x250
	 vfs_write+0x5df/0x940
	Allocated by task 3459:
	 fsg_store_file+0x150/0x1f0
	 configfs_write_iter+0x1a7/0x250
	Freed by task 3459:
	 __fput+0x456/0x6c0
	 __fput_deferred+0x10d/0x330
	 fsg_store_file+0x9e/0x1f0
	 configfs_write_iter+0x1a7/0x250

Take filesem for read around the fsync in fsg_store_nofua(), as the sibling
stores do, so the backing file cannot be closed underneath it.

Reproduced on a mass_storage gadget over dummy_hcd by writing lun.N/nofua
(1 then 0) from one task while another task rewrites and clears lun.N/file.

Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/usb/gadget/function/f_mass_storage.c | 6 ++++--
 drivers/usb/gadget/function/storage_common.c | 5 ++++-
 drivers/usb/gadget/function/storage_common.h | 3 ++-
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index 0000001..0000002 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -2663,8 +2663,9 @@
 			   const char *buf, size_t count)
 {
 	struct fsg_lun		*curlun = fsg_lun_from_dev(dev);
+	struct rw_semaphore	*filesem = dev_get_drvdata(dev);
 
-	return fsg_store_nofua(curlun, buf, count);
+	return fsg_store_nofua(curlun, filesem, buf, count);
 }
 
 static ssize_t file_store(struct device *dev, struct device_attribute *attr,
@@ -3239,7 +3240,10 @@
 static ssize_t fsg_lun_opts_nofua_store(struct config_item *item,
 				       const char *page, size_t len)
 {
-	return fsg_store_nofua(to_fsg_lun_opts(item)->lun, page, len);
+	struct fsg_lun_opts *opts = to_fsg_lun_opts(item);
+	struct fsg_opts *fsg_opts = to_fsg_opts(opts->group.cg_item.ci_parent);
+
+	return fsg_store_nofua(opts->lun, &fsg_opts->common->filesem, page, len);
 }
 
 CONFIGFS_ATTR(fsg_lun_opts_, nofua);
diff --git a/drivers/usb/gadget/function/storage_common.c b/drivers/usb/gadget/function/storage_common.c
index 0000003..0000004 100644
--- a/drivers/usb/gadget/function/storage_common.c
+++ b/drivers/usb/gadget/function/storage_common.c
@@ -415,7 +415,8 @@
 }
 EXPORT_SYMBOL_GPL(fsg_store_ro);
 
-ssize_t fsg_store_nofua(struct fsg_lun *curlun, const char *buf, size_t count)
+ssize_t fsg_store_nofua(struct fsg_lun *curlun, struct rw_semaphore *filesem,
+			const char *buf, size_t count)
 {
 	bool		nofua;
 	int		ret;
@@ -424,11 +425,13 @@
 	if (ret)
 		return ret;
 
+	down_read(filesem);
 	/* Sync data when switching from async mode to sync */
 	if (!nofua && curlun->nofua)
 		fsg_lun_fsync_sub(curlun);
 
 	curlun->nofua = nofua;
+	up_read(filesem);
 
 	return count;
 }
diff --git a/drivers/usb/gadget/function/storage_common.h b/drivers/usb/gadget/function/storage_common.h
index 0000005..0000006 100644
--- a/drivers/usb/gadget/function/storage_common.h
+++ b/drivers/usb/gadget/function/storage_common.h
@@ -210,7 +210,8 @@
 ssize_t fsg_show_removable(struct fsg_lun *curlun, char *buf);
 ssize_t fsg_store_ro(struct fsg_lun *curlun, struct rw_semaphore *filesem,
 		     const char *buf, size_t count);
-ssize_t fsg_store_nofua(struct fsg_lun *curlun, const char *buf, size_t count);
+ssize_t fsg_store_nofua(struct fsg_lun *curlun, struct rw_semaphore *filesem,
+			const char *buf, size_t count);
 ssize_t fsg_store_file(struct fsg_lun *curlun, struct rw_semaphore *filesem,
 		       const char *buf, size_t count);
 ssize_t fsg_store_cdrom(struct fsg_lun *curlun, struct rw_semaphore *filesem,
