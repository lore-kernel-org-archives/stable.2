Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA50C303A0D
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 04:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780373885; cv=none; b=GPuUtXE7YiNP0w5KMUna9XDt9hLc0xlDgy485JjUD8Jr6F+vDoJgCtp1Pxj79phLEeZPPZgpab5DVpSxZ/75w3VeiNzwtEfZojXoYVJFH6+ahgyfsKkNdTUzZiyF7XaWAc43aF+CS8Armrbo1FojtvRena89FS11uxb7jJYUl0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780373885; c=relaxed/simple;
	bh=wjsgzb5f0i2GceW55gjwOFYg1nJd8WVGttnpZFp2x0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kI6sD94dg+VvUaq8SBgudCfFXDeWV9nJEuSCU8Gr5guy6NxWvP1/2G81F9aoHO4qXh13+Vr3B7EYPKBnu6zcGK6N5uiDKwOK5wo87vih8Zdop3GV68LsIdF3a4R9a3/oeeaEwOm+Tc99P4OfF3ICA3tvd4Q0l8VAfOLee8kgpus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bfi79pRU; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bfi79pRU"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36b7b802299so742229a91.1
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 21:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780373883; x=1780978683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2u/sXbb1d4QFDg/pusKeKJpTffkT9R2yLxVJHbJkuC0=;
        b=Bfi79pRUi5AnVU56nuFRLOZ1FMBO9QkLBiL0S8EyQW+rRqAq1H/kQZMx62SKUzEJwo
         hkYCE872cXjy8ucmlBP9e9nZd1Rj/UxWowmaFscbgTBjYQNaRFyyJ+iu2r4clB61m8Dx
         QzSTFyztXjSvXH3sG3jVrGBmwfM2zVQX/QKH+4SJ04+8tjIgN3NpSyqFSapI8OoN7b0z
         I3Ucp6Swr8gtAdeyVZuwTM09IXAk32GQmlIDZEOHm8QqR1gSTs7gY0WEfliZ7tZg/OHa
         tLVAr+nBwkI+4gYJICNkhFG2Mi7XooDbk3z+Eue5V+KW58vyR+TxhG70CRhqfFxRSHir
         4MbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780373883; x=1780978683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2u/sXbb1d4QFDg/pusKeKJpTffkT9R2yLxVJHbJkuC0=;
        b=Q/wCZ+1BTkvs/jIHUi9Fux4c1n16apuURBVnsEGjo3ZiVrE239Y4fjn2Kc7TBULh1n
         CtqKGb6Hj5NvzGwB2Q45YgkSt3atcWHXU91skOr2L7j9BI5DG3tLvzsR1Pwl7zILPmkr
         gFghPUP+h2X4kw+P57UYEhZuOEgAXESMIuG9sM6kM6SDgQ8XX9stn8uKUfpOPxxc6yZZ
         dHrJSmj/iaDRDZoglF9i4+208Ax0840aPW1Jr4lutI9aiCniqp5f2PvtRIGbU+RQlRRp
         /MtezHqOyTNwJ1RDwyrW0BEkPOhEAtjlJwWzqZebu2kxmuQHbxQBrFd0clbxsJbCKw0I
         23ug==
X-Forwarded-Encrypted: i=1; AFNElJ+0unQwIlZ3vodF+agIQsZOx1uu9vrrbyRiuQBkhrIw2uyT3KN/Yq1lUO9+mQQQd6bLE1rBAO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrgPT90gguWX1ZSkxKRY+260czDEE4cwEYuDsC/LNiuKnINu93
	dqF8K53xnlH4QbePYcpb8d2y36IG/80LyfJ1fzRk4Sv1U1u0MRvwFb0o
X-Gm-Gg: Acq92OGU9u6qF378W2JPjd6r5MlFAU/3Uo7QwgCbZt7LgcI04OTOv6zI94BpEsJnIro
	j+xYRsTmDpKpLoD93rWgxg2M7b+fsQYTPAo1FbNHf67Bpfb5tJF/mfDjUfZ7aTrZlENQroucvry
	xlXejgCGTbXEI85LWi3SzRm0sfQYV4XpZKxrWBlN9p8fgYJrSHlqEhWKPlqGfD3FGxVc5xsj1JO
	E7E6wWgITK7rsMWTlgWZis1l8RbChNAXGm6qO8gHTEx1cZTg0gmA5LgXw7BMcKYJUonp+VBfcBh
	LugUY9jmHC3EroPOA7Oc6lxUe8+ZHtSOyYIzJah19l8dK03Kat0FfGqSgGe44tLySVC3i6Gn5Jv
	fIfzKfiGVLXX78oVRqKnYltpFteMCTAQPiJe8ATkUQmSDqa6X8/LIUdNKaRhk7bLVPhiH/MhdKx
	vqlyAQ+3PC2JQP2+4bKfqQzEYeP60Q
X-Received: by 2002:a17:90b:2e06:b0:36a:c208:7e63 with SMTP id 98e67ed59e1d1-36ddbe58149mr994830a91.8.1780373882806;
        Mon, 01 Jun 2026 21:18:02 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36dd91c8687sm1167910a91.8.2026.06.01.21.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 21:18:02 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: idryomov@gmail.com
Cc: Slava.Dubeyko@ibm.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH v3] ceph: fix two unsafe bare decodes in decode_lockers()
Date: Tue,  2 Jun 2026 00:17:35 -0400
Message-ID: <20260602041735.1023057-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <202605310022.LGyGb8eD-lkp@intel.com>
References: <202605310022.LGyGb8eD-lkp@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

decode_lockers() in cls_lock_client.c contains two bare decode operations
that allow a malicious or compromised OSD to trigger slab-out-of-bounds
reads:

1. ceph_decode_32(p) at the num_lockers field has no preceding bounds
   check. ceph_start_decoding() accepts struct_len=0 as valid -- the
   internal ceph_decode_need(p, end, 0, bad) always passes -- so when an
   OSD sends struct_len=0, ceph_start_decoding() returns success with
   p == end. The immediately following bare ceph_decode_32(p) then reads
   4 bytes past the validated buffer boundary. The garbage value is
   passed directly to kzalloc_objs() as the locker count.

   The sibling function decode_watchers() in osd_client.c already uses
   ceph_decode_32_safe() after its own ceph_start_decoding() call.
   decode_lockers() was the only site using the bare variant.

2. ceph_decode_8(p) after the decode_locker() loop has no preceding
   bounds check. If an OSD crafts num_lockers such that the loop
   advances p exactly to end, the subsequent bare ceph_decode_8(p) reads
   one byte past the validated buffer boundary. The result is passed
   directly into *type, which is used as a lock type discriminator by
   callers, giving an OSD-controlled one-byte OOB read with direct
   influence over the lock type field.

Fix both by replacing bare operations with their safe variants:
  ceph_decode_32(p) -> ceph_decode_32_safe(p, end, *num_lockers,
                                           err_inval)
  ceph_decode_8(p)  -> ceph_decode_8_safe(p, end, *type,
                                          err_free_lockers)

The goto targets differ intentionally:
  err_inval: is a new label returning -EINVAL directly. It is used for
  the pre-allocation failure path where *lockers is not yet allocated
  and must not be passed to ceph_free_lockers().

  err_free_lockers: is the existing label. It is used for the
  post-allocation failure path where *lockers is allocated and must
  be freed.

ret is set to -EINVAL before ceph_decode_8_safe() so that
err_free_lockers returns the correct error code on bounds violation.
Without this, err_free_lockers would return a stale ret value (0 from
the successful decode_locker() loop), silently swallowing the error.

-EINVAL is correct for both failure paths. The data received from the
OSD is structurally malformed. -ENOMEM would misrepresent the failure
class to callers and to stable@ backporters triaging error paths.

KASAN report for bug 1 (kernel 7.0.0-rc7, QEMU/x86_64, KASLR disabled):
  ==================================================================
  BUG: KASAN: slab-out-of-bounds in ceph_oob3_init+0x251/0xff0 [ceph_oob3_poc]
  Read of size 4 at addr ffff88800a29b76e by task insmod/58

  CPU: 0 UID: 0 PID: 58 Comm: insmod Tainted: G           O        7.0.0-rc7-g9c2abf69da83-dirty #15 PREEMPT(lazy)
  Tainted: [O]=OOT_MODULE
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x4d/0x70
   print_report+0x170/0x4f3
   kasan_report+0xda/0x110
   ceph_oob3_init+0x251/0xff0 [ceph_oob3_poc]
   do_one_initcall+0x9a/0x3a0
   do_init_module+0x27c/0x790
   load_module+0x4a9a/0x6350
   init_module_from_file+0x15c/0x180
   idempotent_init_module+0x21f/0x750
   __x64_sys_finit_module+0xba/0x120
   do_syscall_64+0xe2/0x570
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  Allocated by task 58:
   kasan_save_stack+0x30/0x50
   kasan_save_track+0x14/0x30
   __kasan_kmalloc+0x7f/0x90
   ceph_oob3_init+0x4d/0xff0 [ceph_oob3_poc]
   do_one_initcall+0x9a/0x3a0
   do_init_module+0x27c/0x790
   load_module+0x4a9a/0x6350
   init_module_from_file+0x15c/0x180
   idempotent_init_module+0x21f/0x750
   __x64_sys_finit_module+0xba/0x120
   do_syscall_64+0xe2/0x570
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  The buggy address belongs to the object at ffff88800a29a000
   which belongs to the cache kmalloc-8k of size 8192
  The buggy address is located 5998 bytes inside of
   allocated 6000-byte region [ffff88800a29a000, ffff88800a29b770)

  Memory state around the buggy address:
   ffff88800a29b600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   ffff88800a29b680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  >ffff88800a29b700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc
                                                               ^
   ffff88800a29b780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ==================================================================

  num_lockers=0xccccaaaa (OOB garbage from KASAN redzone)

Bug 2 (ceph_decode_8) follows from the identical precondition. A
dedicated PoC is available on request.

Attacker model: a malicious or compromised OSD in a multi-tenant Ceph
deployment can trigger this against any kernel client that issues the
lock.get_info class method (e.g. during RBD exclusive lock acquisition)
without any further privileges beyond OSD session establishment.

Fixes: d4ed4a530562 ("libceph: support for lock.lock_info")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
v3: Combine both fixes (ceph_decode_32 and ceph_decode_8) into a single
    patch per Viacheslav Dubeyko's review. Set ret = -EINVAL before
    ceph_decode_8_safe() so err_free_lockers returns the correct error
    code, not stale ret (caught by Dan Carpenter / smatch). Clarify
    err_inval vs err_free_lockers goto selection rationale and
    -EINVAL justification.
---
 net/ceph/cls_lock_client.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ceph/cls_lock_client.c b/net/ceph/cls_lock_client.c
index c6956f1df..4e6a6d3e4 100644
--- a/net/ceph/cls_lock_client.c
+++ b/net/ceph/cls_lock_client.c
@@ -299,7 +299,7 @@ static int decode_lockers(void **p, void *end, u8 *type, char **tag,
 	if (ret)
 		return ret;
 
-	*num_lockers = ceph_decode_32(p);
+	ceph_decode_32_safe(p, end, *num_lockers, err_inval);
 	*lockers = kzalloc_objs(**lockers, *num_lockers, GFP_NOIO);
 	if (!*lockers)
 		return -ENOMEM;
@@ -310,7 +310,8 @@ static int decode_lockers(void **p, void *end, u8 *type, char **tag,
 			goto err_free_lockers;
 	}
 
-	*type = ceph_decode_8(p);
+	ret = -EINVAL;
+	ceph_decode_8_safe(p, end, *type, err_free_lockers);
 	s = ceph_extract_encoded_string(p, end, NULL, GFP_NOIO);
 	if (IS_ERR(s)) {
 		ret = PTR_ERR(s);
@@ -320,6 +321,8 @@ static int decode_lockers(void **p, void *end, u8 *type, char **tag,
 	*tag = s;
 	return 0;
 
+err_inval:
+	return -EINVAL;
 err_free_lockers:
 	ceph_free_lockers(*lockers, *num_lockers);
 	return ret;
-- 
2.53.0

