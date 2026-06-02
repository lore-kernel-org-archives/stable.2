Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7101D63F0
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 04:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780376085; cv=none; b=IrKmw8kLBGm3IBMwpKbeB60v5v8ONsxzNIJfaqOqK8+q4mOUKGvKg0WxOw3aVxof6bFzuvIxPIgY+u3hQGteNMdF8oID0NHMhvkndc0jOwEB8k5m1c9xkytOPxSuquc22iim7/NTMP5TvWk5Mf10RC3nKwrcAcKWwxs2LglIK2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780376085; c=relaxed/simple;
	bh=F/J40/uLzT55kaIdWbi2YD5mxcqTsDhSq3WO33n6WWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PoIlyDfmfJCRv7BOg3jSSkpWxCQ5QT0iUPAts9fC9Cohxf/HCLnp+O5iq7UKthItRviGLUjFSdMUpnlei86azB6fjiGypTU6E2zvv1ig6QXjQUxhM31k8JYPUXB83HCparxHwWn8TabOhrisrGuEgJ7CX1tQCoVY7sPEGSVxfQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvhArKGU; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvhArKGU"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36ba6f6e7b2so556192a91.0
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 21:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780376083; x=1780980883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUPCEysyO/nFB1tm/5cf30Ea+2yAuAV4zmzmM7aL4uE=;
        b=QvhArKGUkqWnwQbiU3vNq6oKtmUGal1E13L6z2ZrCPqX6HxvzZIfh0LI5GszhRJNMa
         06fcUCqVg7m60dKfYx8JiOHKB4nLj7NR7FfNaA0EFCJdVF3fSsA1qvNlAEv+0AkczrWg
         ihLmymrUcN+zZfguNeTfY0+yLv1UiPEZpcbaZGl10pbk+g2vB4yTddOPcpipkqKnXxT6
         bVSo4izz4yQ/oWqQ9vQ+Wke/SasX8FkiAwFqIyT4z0X6hLEH659JklC4du2PPaO/maJz
         kMEscxcGWukx339SLZiNE3eOLJld5yCfD1AYNvmj2nT10Y8ANlJDccXoFpQQuqziqnXJ
         gdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780376083; x=1780980883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YUPCEysyO/nFB1tm/5cf30Ea+2yAuAV4zmzmM7aL4uE=;
        b=rC3DePdyE2ThA1aOjv3PVmn3CVnJFFK0K3QIieXzIHeFDrXXCfiXb7mQF2r2SANbiW
         4cBl6fgbEaUa+Ttz78be4L6aKmxh6WQx6xw2/pWYUq2LBg8w0NE0SCLVX5uCciT+ZpjC
         I95U4mQXmo8vzzDc4i+v82yfrmETVTGVX9zgUZzcfv9y3RkhuYRsdgDiPMZaK6MozqdM
         QLIzcyQoOQdsFj/LIFxWkw6dsfefsRpQ7M9MrIsMADz90spqOh+fQRDw8LynAYeS29hG
         oXjTee5aO5y5dKfVpUwRr1sYWKpIHbb45/QPTL1xWwOPLZkkMjrHRtFJ9KSniXw2HHGR
         wlzA==
X-Forwarded-Encrypted: i=1; AFNElJ/ZFNwxnnQYLEURDxEP4VhyRDD3FydJjuB4EQXzqNnQU44ObOfcFFglvKQ5pl6Mtuyn7yrcS28=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH/rIG7MDjVUqjCVciFPP0+E7gTQ5ammPzXWv6fsWum6/rGXKG
	Lr6mNnrdRRdgahF/frxCRsVtictSqcas/dzSj9HOytA9UcuhON7onFo9
X-Gm-Gg: Acq92OHwmK8D3o/nTIAyK7wxKFmBkmZyLM+JKGL5V8wo5pZXX5b1ts8O9zdO/1aBngn
	16v1hy3b6W7KHxiHqYpENmyewnZcEXzYKydmpIBOgkCRCmGffqIvdXgvzF6U/iUhu6pzj+JUaXK
	sA9V2H03vV4ZzB0CtlECdjrU5BaoMCMbuL6pD5GbJ6NxOlf8WFGtTcxzAt9bOSGnQ52qL7X5pu2
	ufp9G7jJut1Jh8gCy6thYWXTnMDldMBE5F6PKoS/3NOPwvDtHH+c7MtvapjqeUoLrG60iw4dThw
	oams2sDxOZKvYaF+6Fgs9uey9/ZfgCkJ/B7as4pi1wlWWHFCH2jDP29MdWQTY81f6rvatPRfeA/
	6umSHyiw/1728pU8IOFXRiSLB+/xUhUxulPAABO3VNDV/irQIlJjrGeWXdyE2kn2/Tnpu8QAijq
	I2npG/QuZmuMcuxmrxu2XRqbk2AwM=
X-Received: by 2002:a17:902:ceca:b0:2ba:1e94:d03b with SMTP id d9443c01a7336-2c110925455mr9663925ad.6.1780376083027;
        Mon, 01 Jun 2026 21:54:43 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c109d21434sm15111445ad.14.2026.06.01.21.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 21:54:41 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: idryomov@gmail.com,
	Slava.Dubeyko@ibm.com
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH v3] ceph: fix OOB read in ceph_osdc_list_watchers via uncapped outdata_len
Date: Tue,  2 Jun 2026 00:54:32 -0400
Message-ID: <20260602045432.1038887-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <5b7d6b21f7c34661fc9430b828b4c5a3be6446b4.camel@ibm.com>
References: <5b7d6b21f7c34661fc9430b828b4c5a3be6446b4.camel@ibm.com>
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
   ? __pfx__raw_spin_lock_irqsave+0x10/0x10
   kasan_report+0xda/0x110
   ? ceph_oob2_init+0x23d/0xff0 [ceph_oob2_poc]
   ? ceph_oob2_init+0x23d/0xff0 [ceph_oob2_poc]
   ? __pfx_ceph_oob2_init+0x10/0x10 [ceph_oob2_poc]
   ceph_oob2_init+0x23d/0xff0 [ceph_oob2_poc]
   do_one_initcall+0x9a/0x3a0
   ? __pfx_do_one_initcall+0x10/0x10
   ? kasan_unpoison+0x44/0x70
   do_init_module+0x27c/0x790
   ? __pfx_do_init_module+0x10/0x10
   ? __kasan_slab_free+0x47/0x70
   ? kfree+0x15f/0x3b0
   load_module+0x4a9a/0x6350
   ? __pfx_load_module+0x10/0x10
   ? security_file_permission+0x24/0x50
   ? kernel_read_file+0x2ed/0x770
   ? init_module_from_file+0x15c/0x180
   init_module_from_file+0x15c/0x180
   ? __pfx_init_module_from_file+0x10/0x10
   ? tick_nohz_handler+0x2a3/0x640
   ? _raw_spin_lock+0x7e/0xd0
   idempotent_init_module+0x21f/0x750
   ? __pfx_idempotent_init_module+0x10/0x10
   ? fdget+0x4e/0x4a0
   ? fdget+0x4e/0x4a0
   __x64_sys_finit_module+0xba/0x120
   do_syscall_64+0xe2/0x570
   ? exc_page_fault+0x66/0xb0
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

Attacker model: a malicious or compromised OSD in a multi-tenant
Ceph deployment can trigger this against any client issuing
CEPH_OSD_OP_LIST_WATCHERS without further privileges beyond OSD
session establishment.

Fixes: a4ed38d7a180 ("libceph: support for CEPH_OSD_OP_LIST_WATCHERS")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
v3: Split overlong min_t() line to fit 80-column limit,
    per Viacheslav Dubeyko's review of v2.
v2: Introduce buf_len variable instead of hardcoding PAGE_SIZE
    independently in ceph_osd_data_pages_init() and the min_t() cap,
    per Viacheslav Dubeyko's review.
---
 net/ceph/osd_client.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index a67093cf4..0a55bc1f9 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -5063,6 +5063,7 @@ int ceph_osdc_list_watchers(struct ceph_osd_client *osdc,
 	struct ceph_osd_request *req;
 	struct page **pages;
 	int ret;
+	const size_t buf_len = PAGE_SIZE;
 
 	req = ceph_osdc_alloc_request(osdc, NULL, 1, false, GFP_NOIO);
 	if (!req)
@@ -5081,7 +5082,7 @@ int ceph_osdc_list_watchers(struct ceph_osd_client *osdc,
 	osd_req_op_init(req, 0, CEPH_OSD_OP_LIST_WATCHERS, 0);
 	ceph_osd_data_pages_init(osd_req_op_data(req, 0, list_watchers,
 						 response_data),
-				 pages, PAGE_SIZE, 0, false, true);
+				 pages, buf_len, 0, false, true);
 
 	ret = ceph_osdc_alloc_messages(req, GFP_NOIO);
 	if (ret)
@@ -5091,7 +5092,8 @@ int ceph_osdc_list_watchers(struct ceph_osd_client *osdc,
 	ret = ceph_osdc_wait_request(osdc, req);
 	if (ret >= 0) {
 		void *p = page_address(pages[0]);
-		void *const end = p + min_t(u32, req->r_ops[0].outdata_len, PAGE_SIZE);
+		void *const end = p +
+			min_t(u32, req->r_ops[0].outdata_len, buf_len);
 
 		ret = decode_watchers(&p, end, watchers, num_watchers);
 	}
-- 
2.53.0

