Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706D53B9D8C
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 05:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783489222; cv=none; b=QJGEaGC99U+ewMZuSejzXEG/jOQ1pWkP3nwSnTeXURCNoBoCYRDjNqIDF49E+JXffb8u+BgNz4dVe+BV4ymOsuR+jO4FIdSmsQVwGsyvNXhPgooh5C+IZY+AF2q3us0/08cVgfNTrSWWRgFqiNF7kdISB/q+B5csniovDq64rw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783489222; c=relaxed/simple;
	bh=gIr0SaX2K90EVt0U62Oqc43cEgL46YyDy/5w6EFjS58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCQLbHY2P22hwrgo7RkOLQfsEa0Fjl6VQdIQFwGjib+02TCx0pvY+CU36mDYOVX4TY+zdbNVT7k3GxcIJZG3c0N/zRPgsQ3IU3egFgWzgt2+BFoCOsYKpkOUDt//l2dTsraZUvHyLbS9FG1prUc77IMjrdmhF6nYQBtbGK+DQ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQz1643k; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQz1643k"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-381d656c36eso29132a91.1
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 22:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783489221; x=1784094021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=afD53h7FGemsl3jdOrrWX1SceigfQwiiF8iZ9/aRxdw=;
        b=YQz1643kFZ0HRyHi6hSPszRqBMvhb8lVP0dhZRQBOGdFeze/enBTPuzO2pBHXaA+Vr
         gdkE7sMOZgaGVClnfQgkKTlCXl6o6FrxRmLR4H+FrjxqjvEPvLRWx/65mi0l1PXhqp+D
         E2dS6fQvIl3bAwKNV3gJLzIFgYxGaPVl+sq72kVV3qWeNxcPJEkhDLL3U2Ur6exBau/+
         dTZm7Jk8ZgbLeEDyh9SwCqFVJU70y+Daf2QKzMfPTjdwHOugmLFZW4WQ1jKDQFL/Tv6d
         H+AukQkdszPLxym1qVQxNOyxbc3juld0Lz7EDn6iQT3VFL5QS7Ruif0shQnoskJwHpYK
         GHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783489221; x=1784094021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=afD53h7FGemsl3jdOrrWX1SceigfQwiiF8iZ9/aRxdw=;
        b=dKlmxqb5aj7bfehXxyEzgigf/AoBDDamzX3BoXIAnOh48GgN0a4BBO+axjrwXmNrnG
         oAlnltdh+hhrx/do6/b/YHSnZGfbuTplL3KGcTR/aHsjpxj6CdKbH7YOM14hmaG+g/ht
         sKyNmF371DqngmNTyXenC4i2u+6IiXRiu6vUpzhOTBZJc9GHnrKkHW1nXAbESTPHL9iz
         5jxkx3lIo7AbCOwe7Qa30L1KxyHlXHkvi3wlsnjp6QAveEWdsPiwcEnrBhCUM4/cxLJh
         mLXgE3+thYWq4SBMSUuUZIET/PqC97T4gETdBGeIqBTMEs+Plu5ux8rMbyC2gChsIGZ8
         rGOg==
X-Forwarded-Encrypted: i=1; AHgh+RqbN5V4weQ8OSTAl/r5+s560HcuHF7nQ8z4brNm6Rulv+jDhxJHzhX4zlNm5EdKxQ2UfAb6fCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw74IwoQ5fz6BJhapRayRyYoxwyhvLU5nXLJmvNgRcE3UmEu1Ca
	E6o4r8ure48bqea63sOUJ92TCxCxMnW72FKkFKursqd7UZ8lIF6C896VEVZylQ==
X-Gm-Gg: AfdE7cmV0z2A5fEyTxbqlGr2TLbzt0q6d9961t52xMmfbQHsXleu11ds8yjIggWqUeC
	NFYAq3cmCjPLhElzcsnouP2fbrNlK67DUSrY4ngDGxTXix0Vqwqg48agFnzcOiH/wmeqnZ9Y4wE
	pG3UeWTo0dOLjSVhHm7tMVKGpM+YkFL8NK/zZDc72ac1rfu9V/FIxDAQOBuzy7amjWJRRYohmIM
	cRiUp9uNqChS7BOpCP1/4KNl7JA2EpE858pnGEKKyhi5Kvlhz4z1XdHagKDAMgkRF6M6OdPfqYH
	6MG1CMC3Da1gcJHUH/vpst061bduOImE8q7NKU4eYS9/+NqB4I1uVWLGGf6ls2pKMP6W5oQiLkZ
	9wfpwvROavll9PTN3/o65omOsm65Ot1diy0OanIApXdM1MR9F12jHAY2BhEtnQ1QdfppkDDtfmU
	wQilRqeH5OPR2SzZHwkQ==
X-Received: by 2002:a17:90a:c106:b0:37f:f00b:bda6 with SMTP id 98e67ed59e1d1-3893d81c80emr1043876a91.0.1783489220587;
        Tue, 07 Jul 2026 22:40:20 -0700 (PDT)
Received: from kali ([122.162.146.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118ee6080dsm3245416eec.17.2026.07.07.22.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 22:40:19 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Subject: [PATCH v4] ceph: fix OOB read in decode_watchers() via missing bounds check
Date: Wed,  8 Jul 2026 01:39:41 -0400
Message-ID: <20260708053941.90316-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702114034.917507-12-amarkuze@redhat.com>
References: <20260702114034.917507-12-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ceph_start_decoding() validates that struct_len bytes remain in the
buffer after the encoding header, but accepts struct_len=0 as valid:
ceph_decode_need(p, end, 0, bad) always passes. When a malicious or
compromised OSD sends an obj_list_watch_response_t reply with
struct_len=0, ceph_start_decoding() returns success with p == end,
leaving zero bytes guaranteed for subsequent reads.

The immediately following ceph_decode_32(p) in decode_watchers() has
no preceding bounds check. With p == end this is a 4-byte read past
the validated buffer boundary. The garbage value is then passed
directly to kzalloc_objs() as the watcher count.

The sibling function decode_watcher() already uses the safe variants
(ceph_decode_copy_safe, ceph_decode_64_safe, ceph_decode_skip_32)
after its own ceph_start_decoding() call. decode_watchers() is the
only site that uses the bare variant, confirming an oversight.

Fix by replacing ceph_decode_32(p) with ceph_decode_32_safe(p, end,
*num_watchers, bad), consistent with the established pattern.

KASAN report (kernel 7.0.0-rc7, QEMU/x86_64, KASLR disabled):

  [   72.047085] ceph_oob_poc: buf=ffff8880085936c8 end=ffff8880085936ce
  [   72.048685] ceph_oob_poc: ceph_start_decoding OK: struct_v=1
  struct_len=0 p==end: 1
  [   72.049477] ceph_oob_poc: triggering OOB read past slab boundary...
  [   72.050699] ==================================================
  [   72.051427] BUG: KASAN: slab-out-of-bounds in
  ceph_oob_init+0x128/0xff0 [ceph_oob_poc]
  [   72.051427] Read of size 4 at addr ffff8880085936ce by task insmod/61
  [   72.051427] CPU: 0 UID: 0 PID: 61 Comm: insmod Tainted: G O
  [   72.051427]  7.0.0-rc7-g9c2abf69da83-dirty #14 PREEMPT(lazy)
  [   72.051427] Call Trace:
  [   72.051427]  dump_stack_lvl+0x4d/0x70
  [   72.051427]  print_report+0x170/0x4f3
  [   72.051427]  kasan_report+0xda/0x110
  [   72.051427]  kasan_check_range+0x125/0x200
  [   72.051427]  ceph_oob_init+0x128/0xff0 [ceph_oob_poc]
  [   72.051427]  do_one_initcall+0x9a/0x310
  [   72.051427]  do_init_module+0x186/0x410
  [   72.051427]  load_module+0x2ba7/0x2e50
  [   72.051427]  init_module_from_file+0x15c/0x180
  [   72.051427]  idempotent_init_module+0x19f/0x430
  [   72.051427]  __x64_sys_finit_module+0x78/0xc0
  [   72.051427]  do_syscall_64+0xe2/0x570
  [   72.051427]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  [   72.051427] The buggy address belongs to the object at ffff8880085936c8
  [   72.051427]  which belongs to the cache kmalloc-8 of size 8
  [   72.051427] The buggy address is located 0 bytes to the right of
  [   72.051427]  allocated 6-byte region [ffff8880085936c8, ffff8880085936ce)
  [   72.051427] Memory state around the buggy address:
  [   72.051427] >ffff888008593680: fc fc fc fc fc fc fc fc fc 06 fc fc fc fc fc fc
  [   72.051427]                                               ^
  [   72.051427] ==================================================
  [   72.129720] ceph_oob_poc: num_watchers=3435973836 (OOB garbage)

0xCCCCCCCC (3435973836) is KASAN redzone poison, confirming the read
landed in the slab redzone immediately past the 6-byte allocation.

Attacker model: a malicious or compromised OSD in a multi-tenant Ceph
deployment (e.g. cloud) can trigger this against any kernel client
that calls CEPH_OSD_OP_LIST_WATCHERS, without any further privileges
beyond OSD session establishment.

Fixes: a4ed38d7a180 ("libceph: support for CEPH_OSD_OP_LIST_WATCHERS")
Cc: stable@vger.kernel.org
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
v4: Rebase against current linux/master and ceph-testing/testing.
    No functional changes from Slava's reviewed v3.
v3: Rename error label e_inval -> bad per Slava Dubeyko's review.
v2: Correct commit message; retracted overstated impact claims,
    verified with follow-up KASAN harness.
---
 net/ceph/osd_client.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 2ff00070c..2cdac81a6 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -5030,7 +5030,7 @@ static int decode_watchers(void **p, void *end,
 	if (ret)
 		return ret;
 
-	*num_watchers = ceph_decode_32(p);
+	ceph_decode_32_safe(p, end, *num_watchers, bad);
 	*watchers = kzalloc_objs(**watchers, *num_watchers, GFP_NOIO);
 	if (!*watchers)
 		return -ENOMEM;
@@ -5044,6 +5044,8 @@ static int decode_watchers(void **p, void *end,
 	}
 
 	return 0;
+bad:
+	return -EINVAL;
 }
 
 /*
-- 
2.53.0

