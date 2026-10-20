Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792463463;
	b=C2LFePDb0TjiVqPc4nDITxz/vyNgsahDbL5GrO52w8ucUGcudWygIPBvroIkpgAylkYB
	 B/81VxgSLAccLRUCgijhfN98GiGcOEGDh2i5xdxxCvebpjnOmD31iDn1sjZUOmreFv56f
	 Dz91M0aYcdaSUtVRIPNEgpahs/E04GPZZ9xZemWbjc+l+7ZBd3R2Qn31/nw1QVFvYFgbk
	 RBPM3tbrTGyP9dWfViM7cXD7bLhPyzoficorqMXkbLWXSRJljoSE2NDFLpRJ5HpT0qNrp
	 i0cwaqL5286XBFoo6Gsxls5WoX1/Q573fJhbsblXt6p0hU+SNfwVLrJSpznbm72DSlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792463463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=z/vG9lhLAbzBSmalPB1KRTByeJKg03MlRPENHQr0Oec=;
	b=JN11VMJcQd1g34khmEaV1BJqO5K21YrVICTis6argUriT0B6UuGHriqtbLCWkLuOSp7+
	 cFN7ocPDHoNTVE2ODkK5qhEAHaVdnRueCnFGsjQngTuVNTZbjyeOqOw95SRByHcpCkYwY
	 A4zgbrtc+GEEsXLlnsIVfnHM0f4tnBpg2olEgKThZLylVEnp+90a9mixhyAqBntzjT8mt
	 iAJz+OQ7CKqpc/tukL6GByxcOeXlMixexJQu32rsde4eN1eFCcwAOD6bakJ1bxIwGkgAB
	 uWIbY46O0b95Pf0t0kgtjOFk6ZaFFGC9OeP1jsuKI9hfQhWt/mu6FPhHc/87n+6sMmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LpDGRBHf;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1632606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 02:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1632606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LpDGRBHf
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd69954c755so143201a12.3
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 19:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792463462; x=1793068262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z/vG9lhLAbzBSmalPB1KRTByeJKg03MlRPENHQr0Oec=;
        b=LpDGRBHf3uON9gQ8I+QVqgkXFmokcdnBMj4m4DQ/DJ1wgHVjlOGmFAhWgqsTqllLPP
         G690Hq38eN3HAqRcu2xRHmsrescQzYCo1GHaFqvtquCZnwhcDlqUkdhzDAetYhhITviV
         9ApAQU1RC2YqB6WQqP1dM9AI+Gm/AZZfv+Roy280B3FVgRi5HmaDzYg7k7YRxPdu1u0x
         +5vlI7KgqOq+j2zCEZAdeMMN3/5bY/KBvVHPWGUJpDLxqHQ3GDizZatgnD1G6f+6Rca9
         3zvfGCMbncwZ3hb3TZrw4FClqZhnmipyzY8+3Y7UIT7515vSA0UByN8CLkNOMLiiws5S
         Aygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792463462; x=1793068262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z/vG9lhLAbzBSmalPB1KRTByeJKg03MlRPENHQr0Oec=;
        b=ifG4yTum/cSdM4Bvc2P4G6L8aChUBExgUwCx11xnrOhr/YeuO8CrbZ3aQzBvKztZAe
         LvAMgn5Lr3B9t9XNgAxaSP7klRM6fAJT8VaVfzuQ+VhnN2q7eKofZN9j0eJCi0FMU7Pd
         16xqSEtlQlT8UREd/Ae0axX0tU/jjkyF+KkP0OG+Zv0WbEfCWVOJ+U2J560Fi8misDvh
         EJgCNIGcq0n49cPI+WRXHC+7xCK++PZEuT0E35Gn+plzQdlDXovMYvhtTmoiD5rUkKDC
         a1Rp4iTV3WMFTrYOWYMlEVjD9+iZqe+/ldEqj3fY/vg00vpf8ywZQRfA6eFfnuiNY7hG
         0j0A==
X-Forwarded-Encrypted: i=1; AKwUvBzrMQSFT3S8JqKvV0QcyusyRjN34JLl0no+krVgBEZrq1msD1XRjyJzdtpKz/tCfo/gAedO8FE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLScoAn1Bnr8QVaaODa9MTZ/STiSSbJTLk58KsdaqQyYGK92NF9
	QBCw/mL0ws05REg4ZWD1OcsUsnPLwcQUEMBAPA8roBLFcnnB6BXvk6pH
X-Gm-Gg: AYBFou16v5lcTSP+VCGJQX3By3iGfZ/sC2i0uuVVX4tCOh/qTZNew9qLP79Aa/RHrrk
	6xGNLGxYJuK/bWiMiX/yueJZ+K+lVL7PZ3j+gs6IIoRDgo4VpQ2bF5PjDqGBFZZEEYv4SrgIecy
	AOuksJlOEirqHF0PziRZU6qqLry5XWpb4eXFSNf0q/7p59L91VLTGsFUSSTZFCTEA6Nmoa+0eSa
	KmgkioQ8gYhlIPcbbezeWUrZVs02+LvVU2e7Fil2b5NrRh+LqVQMBSomm+ruljltRPZxj9Iq0r7
	A7pFvSPmb72yZbAxb+TgiCxiRHi9oScUSPjx+5CBV/if7qf8EgDTIqN2Mph71Rn6q/4s6j1od2E
	zvh7H496JzcypoR6yRwNuduMqsKgGSlEU1oP+K9D0W8VSSpVfyUQ0Qgr0DjxSQ2lXRdxHdvzBZc
	LzjRBCn0fi7KBXkDCjvv2Edmv1ctYP7nLVyaxP7FQS+79tu5pc6SUykwiME9tn1dcvhcieb9vO3
	djpZmk4a1lFBL/TrMyS0/p1T96t1xb1VsR2kBCxZtmj0H0SgCbmRa5WfsOkp0VQdCXq7JEGklPm
	E1dhvVFIboz2+SgheaJ2lGTwW4MycbwOGo14696VUlxWlDFezzioFXr6aBb0
X-Received: by 2002:a05:6a20:9e0e:b0:3e1:d72f:1587 with SMTP id adf61e73a8af0-3e26bda45bfmr1140976637.34.1792463462139;
        Mon, 19 Oct 2026 19:31:02 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89febdc2209sm3958456b3a.33.2026.10.19.19.30.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 19:31:00 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: gadget: f_mass_storage: take filesem in nofua store to fix backing-file UAF
Date: Tue, 20 Oct 2026 12:30:50 +1000
Message-ID: <20261020023050.87701-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261018130519.65850-1-yuz08559@gmail.com>
References: <20261018130519.65850-1-yuz08559@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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

Hold filesem for read around the fsync in fsg_store_nofua() so the backing
file cannot be closed underneath it. The lock is only needed when the
fsync actually runs, so it is taken only in that branch.

Reproduced on a mass_storage gadget over dummy_hcd by writing lun.N/nofua
(1 then 0) from one task while another task rewrites and clears lun.N/file.

Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
v2:
 - Use guard(rwsem_read) instead of a bare down_read()/up_read() pair
   (Greg KH).
 - Take filesem only inside the branch that actually calls
   fsg_lun_fsync_sub(), not around the whole function / the
   curlun->nofua assignment, since the lock is only needed for the sync
   (Alan Stern).

v1: https://lore.kernel.org/all/20261018130519.65850-1-yuz08559@gmail.com/

 drivers/usb/gadget/function/f_mass_storage.c | 8 ++++++--
 drivers/usb/gadget/function/storage_common.c | 7 +++++--
 drivers/usb/gadget/function/storage_common.h | 3 ++-
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index b7b06cb..6712566 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -2663,8 +2663,9 @@ static ssize_t nofua_store(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
 	struct fsg_lun		*curlun = fsg_lun_from_dev(dev);
+	struct rw_semaphore	*filesem = dev_get_drvdata(dev);
 
-	return fsg_store_nofua(curlun, buf, count);
+	return fsg_store_nofua(curlun, filesem, buf, count);
 }
 
 static ssize_t file_store(struct device *dev, struct device_attribute *attr,
@@ -3239,7 +3240,10 @@ static ssize_t fsg_lun_opts_nofua_show(struct config_item *item, char *page)
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
index 75831f2..51a70f2 100644
--- a/drivers/usb/gadget/function/storage_common.c
+++ b/drivers/usb/gadget/function/storage_common.c
@@ -415,7 +415,8 @@ ssize_t fsg_store_ro(struct fsg_lun *curlun, struct rw_semaphore *filesem,
 }
 EXPORT_SYMBOL_GPL(fsg_store_ro);
 
-ssize_t fsg_store_nofua(struct fsg_lun *curlun, const char *buf, size_t count)
+ssize_t fsg_store_nofua(struct fsg_lun *curlun, struct rw_semaphore *filesem,
+			const char *buf, size_t count)
 {
 	bool		nofua;
 	int		ret;
@@ -425,8 +426,10 @@ ssize_t fsg_store_nofua(struct fsg_lun *curlun, const char *buf, size_t count)
 		return ret;
 
 	/* Sync data when switching from async mode to sync */
-	if (!nofua && curlun->nofua)
+	if (!nofua && curlun->nofua) {
+		guard(rwsem_read)(filesem);
 		fsg_lun_fsync_sub(curlun);
+	}
 
 	curlun->nofua = nofua;
 
diff --git a/drivers/usb/gadget/function/storage_common.h b/drivers/usb/gadget/function/storage_common.h
index 11ac785..347a86b 100644
--- a/drivers/usb/gadget/function/storage_common.h
+++ b/drivers/usb/gadget/function/storage_common.h
@@ -210,7 +210,8 @@ ssize_t fsg_show_cdrom(struct fsg_lun *curlun, char *buf);
 ssize_t fsg_show_removable(struct fsg_lun *curlun, char *buf);
 ssize_t fsg_store_ro(struct fsg_lun *curlun, struct rw_semaphore *filesem,
 		     const char *buf, size_t count);
-ssize_t fsg_store_nofua(struct fsg_lun *curlun, const char *buf, size_t count);
+ssize_t fsg_store_nofua(struct fsg_lun *curlun, struct rw_semaphore *filesem,
+			const char *buf, size_t count);
 ssize_t fsg_store_file(struct fsg_lun *curlun, struct rw_semaphore *filesem,
 		       const char *buf, size_t count);
 ssize_t fsg_store_cdrom(struct fsg_lun *curlun, struct rw_semaphore *filesem,
-- 
2.43.0

