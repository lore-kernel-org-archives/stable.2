Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4469431F99E
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 05:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780981355; cv=none; b=S/lSb1bGAJpKkv/ivgQQDHP37Y9pZ1AcxR4XznqggfEY7IF4P0+QZdep7DzHx+s9FKZ85VCZuFzBIH06jTajjUhwzq2s8pDOTxZZNw/DvciCULGegjCL0TC9OkYKJRt1Uwu5JZWfkuw2BGVStDvAX5Bf6IxBgzDvvEP4rquD3Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780981355; c=relaxed/simple;
	bh=g20Pz9Ly9u4RxRdhYvhI6l0nb301p6HBXJV1FQw44bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRPwIJJaxhV2WlGaaepU7/YiACKnVUbAFoadSXxx/cfMwC1XbIBWreXVgxFPOFf+Shn0AuoomwQEOcNu6cH2BqgFZw7AlTlclpiuHrMJNpo6KwuQRKIhOzy0u4ACxZrNZ/hvgHe6pTBjckbFq8GWq9D9m9C7kVbRdiOC8MFA9VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFApFAn+; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFApFAn+"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36ba9f46338so467634a91.0
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 22:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780981353; x=1781586153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJQXimql7JJ+vTY6nyvO+rL2KwVBakav3Mk11pUE2pM=;
        b=eFApFAn+vBfUjrYD3hTMaCjphtmu8iLiuaqHjZjBAXzu4sBj/bpToCVGrP91aMsDDf
         Au71ciCpdaUCNLd7xQ9SIDQ7hJ0ma/28i/DahL2CyA3p1HaQq6rhxekCO0i/rT8eudmP
         fuKan19OZppbzKFxEByrKd8hy31SfKhzhdoTCCQLxkRdeDY6MLoIcrW4mSnDSPKbw/z/
         KwKh4BHAkEYLKZTr5LRYvXaZr922uhrICMrUh64seeVTgG04mlrRMb0ZmecQPqyHnhvt
         WjL14qsl8ZY1d7qtUHx1iP8sJhB3m26vmPfQiGMJMEP5j2zyD+YZHCuz2qtF6NE3CQLY
         oCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780981353; x=1781586153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KJQXimql7JJ+vTY6nyvO+rL2KwVBakav3Mk11pUE2pM=;
        b=oC1zOvlh+/jp8d34mn45eIO6Sm+ClmadFBDVl5RDA8AL9PgGwz9VcWnMPOsp8UYTpQ
         J71d9r/s67454yLpOmfgaPc9NKyVR0DPxyEtC9BSdukHnYelPilArbTpdqk73+JmQFLh
         ZCJYcIKNJFjo83uHgh9WbU+uZ5mxFHCzcUhRm38gwiZOy6ErClDB0f7K1kk9hecct2tN
         zhZF5bDiZ2RlIGoIKaEzht5/hAUx5lTED/ti3tUuiwqC5SPOYImpX1+gboTkRjYG76SM
         YkWR+HIbi3U5pSwfd+OoaP73G7jBnKz9mwzQyJboNo6V8oFSVMVxSp+1o14Wlsn6Im+U
         gsHw==
X-Forwarded-Encrypted: i=1; AFNElJ/lzvaqUqK62q9Ihk/8Pku6iH8FTNK3rTenVB7/L49fo4X80q2Ac2oAGxD8g3IFghtrkUjpXg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXCM5l/PHcTzInwnEF/BGtMlX6kZ9qB11kMxcsNYar6lxTZ+wS
	Mps3Es3Ttc2w09ndWfzTPzum+VNZnFx2i4UE4mcNMQiIhesrCpHfwRBHRoWft9V4
X-Gm-Gg: Acq92OGG2M4B2czRrdy7cN1FuzN5rJebxLY093Zynv7n3LkHFpDWq3c2DopolU7Nt9G
	xQ8gpYQZ+NawMM2g96aNaitC4G08GQRP08QVATLOhykZqAVyD+3rjq9imCWB2HeLHZLZtFhEbeb
	APOZfZJRCCZ3bCvvF0AsyGVYsvKkmqZFLt2KFaNlkcxk8xw6prsPkSaRhdQWJK3Onqtv+MJGQ0T
	StT+5TbOR4LJ6vHox4B88Qwlv9ZH65XoUJ/VYCcFzyzH7/jC36aeug/VmMFS5uO9XTHt2IBfcKL
	uh8z9hHVsDGsMbWiqi1qdFwkDumSKGGong45ZUicpGMslo9VEfjbErg1LV6XXvpwotmKv4Xjw1c
	5KaVDUSf0wn3YMvuYhFA09cBSqDJpxJGRUzPv7TwljBvBU0DL8GOWtzjokzCZaSJ04ypse+iXig
	5ekE3vqVqH+xqAAKid/sWRd0RQpPA=
X-Received: by 2002:a17:90b:4a08:b0:364:b4e7:6706 with SMTP id 98e67ed59e1d1-370ee351f7amr11371329a91.1.1780981353459;
        Mon, 08 Jun 2026 22:02:33 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828e21c8sm23330365b3a.49.2026.06.08.22.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 22:02:33 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: idryomov@gmail.com
Cc: Slava.Dubeyko@ibm.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] ceph: fix OOB read in ceph_osdc_list_watchers via uncapped outdata_len
Date: Tue,  9 Jun 2026 01:00:41 -0400
Message-ID: <20260609050042.1436568-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <27e15cffb5d346a19a45efc88a722a3d6abd5c7a.camel@dubeyko.com>
References: <27e15cffb5d346a19a45efc88a722a3d6abd5c7a.camel@dubeyko.com>
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
buf_len is declared as u32 to match the type of outdata_len used in
the min_t() expression.

Attacker model: a malicious or compromised OSD in a multi-tenant
Ceph deployment can trigger this against any client issuing
CEPH_OSD_OP_LIST_WATCHERS without further privileges beyond OSD
session establishment.

Fixes: a4ed38d7a180 ("libceph: support for CEPH_OSD_OP_LIST_WATCHERS")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
v3: Change buf_len type from size_t to u32 to match outdata_len type
    in min_t(), per Viacheslav Dubeyko's review.
v2: Introduce buf_len variable instead of hardcoding PAGE_SIZE
    independently in ceph_osd_data_pages_init() and the min_t() cap,
    per Viacheslav Dubeyko's review.
---
 net/ceph/osd_client.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index a67093cf4..5ad47d932 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -5063,6 +5063,7 @@ int ceph_osdc_list_watchers(struct ceph_osd_client *osdc,
 	struct ceph_osd_request *req;
 	struct page **pages;
 	int ret;
+	const u32 buf_len = PAGE_SIZE;
 
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

