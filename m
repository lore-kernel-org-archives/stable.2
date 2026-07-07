Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423B43F44F2
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421897; cv=none; b=H7Z1EC3agd0QDDQCp2QDsD+yIZlEkyjb+PIeXLbvnfoh9qfibZ6LWnXSZ4GCVpvP/ETUg2KBsRQHrDEHPDnEM5fBPtR9cRJQY13sAqqgZ3wdjGNvsCOg7Z4RXHNS83tPD8qzn9fyb15QRDIGuCYmVCR0/8f9Mn5+K2jSh5W/hRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421897; c=relaxed/simple;
	bh=P8gIYO8Be5GyRIeaQoKDFNwhdYjhH8ur+OsFkbOFxi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVDtOk5oS4OwOQNHAL9+lH8IAkTuCxp3o5FSgxy9P8SKDArWLd9cveNIgxsWjFG6Be3/NY8p/+Dk19S2MTLHI9iRhuSFEGLnfbJxbUu/H0MIYhRFkwDJeZG6LcfzpL/PATMcNOn7s283S2QtfxYLcWa0+LraOG4R/JZHJUTId6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAugUfq+; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAugUfq+"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca5b707b78aso64941a12.0
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 03:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783421895; x=1784026695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vTAOErkodfEqDL8pLtelOUXnkS/56cD3vo3IuTVepFA=;
        b=fAugUfq+oDcjbVek5xqlh4DG+f1Lx9bPjkVepzCce5NFTaXKQAinfzq49SGz1NGZJR
         027Zr6P1EfwXLfJEm4R5UcgrPeUfAWhU3pf98D/5vmGEfiU/b9vPuCIBt6PmCOnDKL5n
         M9vQxuAwfpmIMBbLodvAiKcNQwBjRZ4z4tWzJ6lkzfF60N4WGZt7FsLK//YcTeRCCWP8
         KkqsqqbXqCQEC+UGm41SQCn2l4Iuvn8h8TX1M4fgC7TVzBSFOCRH6FlsV2mZ8v0yMHST
         a1zbU7K/Y2nXRZIGmvyfvZ4UQfQT1w7W9IECuPuvet0Z0jBhGmLm8UiwRj2yUy9Te6Gp
         Ybzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783421895; x=1784026695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vTAOErkodfEqDL8pLtelOUXnkS/56cD3vo3IuTVepFA=;
        b=XS5g26EzmIP3C6r9k5s+L7tHOTjBxO5nVYUTo/PR4g5zqVKsTAwiep0G/kg2tkyvvM
         wEFJ02yJ15h0bWAZKRs24kVp/AsoyHukBQn9YnC0iuEi7yXnVKUjQTfJTUrmP9XWZ4+d
         WUtyFXPm/LfDrXgZioQa06b4r07XUPX3o62coQRCpcDFp7PHRNgE6ik+i5mD9PIL2t3g
         cIYMWRswx/ocEonLRgs21Ck0m7ZqIxZ/oUmESx1EqmQxp9ILJHcGdSHt6tyrwZcRe1bu
         CA9lv/kN+a472gHVTfLZ3Uz4HmNzrv/YeR41bgn6xrVrtWFQDVt821qk7FuxHM9fOdMn
         uN4g==
X-Forwarded-Encrypted: i=1; AHgh+RpUcOxMAb1vIzwgvk4tgZS3AZR/U0qKuyVY3EuLMD5wRAiG5htcirHQGgSnSZ+Qgx8eDA2u6L4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiK5ClZCQcm23JPVUSSCRKVTaUhbXc9FejCD8WVIBagyW+yn9P
	hkonS4l02ec9iMj5z1gz8mEHiHwkqzreHOHaNZXA0yTdFrj9Sq8w8CC9
X-Gm-Gg: AfdE7cnB5cVX53C/gVKCHCcqSDL9m6Plez7vsdBXiGTzygYQmwWN4elhvoc9O6hPQx/
	d4ShE7NaLmLfpfm3H8tm2y+vNFDp9oKYzfiXvnlGLY2JzJuq2Gffr88R50sp4Mk2TZk7reRBRRG
	742rLCD85lwGXf4q+QktyQdc3vmKfGy+2QTwAB5PgXWFiYbz0RcjzGttKjw6RnB0koS1CGlmnJx
	hxWJZ9/QZgFFa2ud3PtVnKj4Pe6Z9FJVoVoWvbjsPWfwGKwDevpSHsx/qlALoWJFZqCpNxkX/bv
	8ZO5rA7A7M6/OigbrLqarm+rNklGslTpGU9xp649VJDUmiUASTSYtvGiMSaIKpg/WSJNH3iwwrr
	YZA48iLL7K/CO7OSh47txO3Ru3ffNLV7sc4s3L4bbujCMbu2E7I8n6O8pobJ1PglO17Ay296qIt
	JrCX7H5+g=
X-Received: by 2002:a05:6a20:6f91:b0:3bf:bdb9:f611 with SMTP id adf61e73a8af0-3c03c661a00mr9815737637.5.1783421894592;
        Tue, 07 Jul 2026 03:58:14 -0700 (PDT)
Received: from kali ([122.162.146.188])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b658a99afsm7862340c88.0.2026.07.07.03.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 03:58:14 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH v4] ceph: fix OOB read in ceph_osdc_list_watchers via uncapped outdata_len
Date: Tue,  7 Jul 2026 06:57:27 -0400
Message-ID: <20260707105727.43352-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702114034.917507-13-amarkuze@redhat.com>
References: <20260702114034.917507-13-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The OSD reply header field op->payload_len is wire-controlled and is
copied directly into m->outdata_len[i] without any bounds check:

  m->outdata_len[i] = le32_to_cpu(op->payload_len);

This value propagates unchecked to req->r_ops[0].outdata_len and is
then used to set the decode boundary in ceph_osdc_list_watchers():

  void *const end = p + req->r_ops[0].outdata_len;

The actual data allocation is always exactly one page:
  ceph_alloc_page_vector(1, GFP_NOIO)
  ceph_osd_data_pages_init(..., PAGE_SIZE, ...)

The messenger caps the copy to PAGE_SIZE bytes, but the decode window
end is set from the uncapped wire value. A malicious OSD can send
outdata_len=0x10000, causing _safe decoder boundary checks to pass
while the physical reads cross the slab allocation boundary.
KASAN report (kernel 7.0.0-rc7, QEMU/x86_64, KASLR disabled):

  ==================================================================
  BUG: KASAN: slab-out-of-bounds in ceph_oob2_init+0x23d/0xff0 [ceph_oob2_poc]
  Read of size 4 at addr ffff88800a229f9e by task insmod/57

  CPU: 0 UID: 0 PID: 57 Comm: insmod Tainted: G           O        7.0.0-rc7-g9c2abf69da83-dirty #15 PREEMPT(lazy)
  Tainted: [O]=OOT_MODULE
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x4d/0x70
   print_report+0x170/0x4f3
   kasan_report+0xda/0x110
   ceph_oob2_init+0x23d/0xff0 [ceph_oob2_poc]
   do_one_initcall+0x9a/0x3a0
   do_init_module+0x27c/0x790
   load_module+0x4a9a/0x6350
   init_module_from_file+0x15c/0x180
   idempotent_init_module+0x21f/0x750
   __x64_sys_finit_module+0xba/0x120
   do_syscall_64+0xe2/0x570
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  Allocated by task 57:
   kasan_save_stack+0x30/0x50
   kasan_save_track+0x14/0x30
   __kasan_kmalloc+0x7f/0x90
   ceph_oob2_init+0x44/0xff0 [ceph_oob2_poc]
   do_one_initcall+0x9a/0x3a0
   do_init_module+0x27c/0x790
   load_module+0x4a9a/0x6350
   init_module_from_file+0x15c/0x180
   idempotent_init_module+0x21f/0x750
   __x64_sys_finit_module+0xba/0x120
   do_syscall_64+0xe2/0x570
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  The buggy address belongs to the object at ffff88800a229000
   which belongs to the cache kmalloc-4k of size 4096
  The buggy address is located 3998 bytes inside of
   allocated 4000-byte region [ffff88800a229000, ffff88800a229fa0)

  Memory state around the buggy address:
   ffff88800a229e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   ffff88800a229f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  >ffff88800a229f80: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
                                 ^
   ffff88800a22a000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
   ffff88800a22a080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ==================================================================

  val=0xccccaaaa (OOB garbage from KASAN redzone)

Fix by introducing buf_len to hold the allocation size, using it in
both ceph_osd_data_pages_init() and the min_t() decode boundary cap,
so the two are guaranteed to stay in sync if the buffer size changes.
buf_len is declared as u32 to match the type of outdata_len used in
the min_t() expression.

Attacker model: a malicious or compromised OSD in a multi-tenant
Ceph deployment can trigger this against any client issuing
CEPH_OSD_OP_LIST_WATCHERS without further privileges beyond OSD
session establishment.

Fixes: a4ed38d7a180 ("libceph: support for CEPH_OSD_OP_LIST_WATCHERS")
Cc: stable@vger.kernel.org
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
v4: Rebase against current linux/master and ceph-testing/testing,
    confirmed clean git am -3 apply against both. No functional
    changes from Slava's reviewed v3.
v3: Change buf_len type from size_t to u32 to match outdata_len type
    in min_t(), per Viacheslav Dubeyko's review.
v2: Introduce buf_len variable instead of hardcoding PAGE_SIZE
    independently in ceph_osd_data_pages_init() and the min_t() cap,
    per Viacheslav Dubeyko's review.
---
 net/ceph/osd_client.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 2ff00070c..62bec6ad8 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -5060,6 +5060,7 @@ int ceph_osdc_list_watchers(struct ceph_osd_client *osdc,
 	struct ceph_osd_request *req;
 	struct page **pages;
 	int ret;
+	const u32 buf_len = PAGE_SIZE;
 
 	req = ceph_osdc_alloc_request(osdc, NULL, 1, false, GFP_NOIO);
 	if (!req)
@@ -5078,7 +5079,7 @@ int ceph_osdc_list_watchers(struct ceph_osd_client *osdc,
 	osd_req_op_init(req, 0, CEPH_OSD_OP_LIST_WATCHERS, 0);
 	ceph_osd_data_pages_init(osd_req_op_data(req, 0, list_watchers,
 						 response_data),
-				 pages, PAGE_SIZE, 0, false, true);
+				 pages, buf_len, 0, false, true);
 
 	ret = ceph_osdc_alloc_messages(req, GFP_NOIO);
 	if (ret)
@@ -5088,7 +5089,8 @@ int ceph_osdc_list_watchers(struct ceph_osd_client *osdc,
 	ret = ceph_osdc_wait_request(osdc, req);
 	if (ret >= 0) {
 		void *p = page_address(pages[0]);
-		void *const end = p + req->r_ops[0].outdata_len;
+		void *const end = p +
+			min_t(u32, req->r_ops[0].outdata_len, buf_len);
 
 		ret = decode_watchers(&p, end, watchers, num_watchers);
 	}
-- 
2.53.0

