Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AAD2E719B
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 04:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791348443; cv=none; b=JUoktKd2vJU+kATT2Y8nBjR/Fir4B1nDOgK5V3bckMS8KykAXxkqG5hfDMP0pkbKiosmuSTNpicc6Jljg4IVWHvQ2DrD0x+ed3PR5SSKWYpy/g16lgL7UhfmrYT1fIzf1BTDOMRTgMg9e39ZvfhGOtotdepqra9oj5su5gbUu6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791348443; c=relaxed/simple;
	bh=9+se/HXIW7B0FFqwjoobD2i4/Ri/fyGpaUvygxtNHSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pS3iE6022yX+P+61XM+zTPa6qeNjZWQzsCGqantmOJ4y0+0IhEgPT550HnofTAbdDiA42jR1Er1tRByiuczjQLthLrrOqRg/x8xqBESLBLmuSt+LgH1eNk5mYrBaUFvxIUn10WzVzMQhnVMHmbGLzlkzgqJABb3wIdnmgCG7wDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EM5pts3X; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EM5pts3X"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso1090755f8f.1
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 21:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791348438; x=1791953238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eqc6mxaf3QovS0qWXiMMBe5aT88X2sI+XIt/8qYVFkU=;
        b=EM5pts3XWn9G/T27/Mma4gi1tfaVNnbX6fkWtIWFhZMmqgBZfMhrKcsXxxWYHHIQGe
         3mOPoRcgp8fd7GCAXzaJ6wzxVY7Ihy1XPjK3KZc8iaNiwHvwRrYFEBpHZgORAYnDGPQU
         w8MVyaCzn5F0uHVSrjCIG6VFHW+QI3l48i1k9rdq/QaY6DUMvRPCUPSWZ4YOLNqsXVkk
         GTj1f80XAoMYCdu89lEv08eYRmvQygZ5tGtAhXCuRZY4UOQZd+NsXorY7rTjpd8AMnvQ
         QI+91OtFsbV0RlDuxqJRWnQFOxh1aaX4lZcHSXeQ+10wW4ufoNdai9iFJZBVNv6LEqek
         umZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791348438; x=1791953238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eqc6mxaf3QovS0qWXiMMBe5aT88X2sI+XIt/8qYVFkU=;
        b=cIl2ExO8XGGQ11RGqEkGdz9IlRqqPd/nH2eNCLM9w1ZzGFvZOnyKyq5n0DQRVqRRaM
         2xA/GI9iGUbzRL1/p4epPzIW3tGYu6x+ucjmL89xbAgSpBOyVhFK2BJH79GnwTFLfiQe
         1fYuuZJPMOY+g9W5lryz55BDcR/zxZ2ytJK3+3+kU43BUBtqD/ZU7ZmViJjVJ1Va1NK7
         LIwvqghBJGTipVSyGMhnMkFzyeTvSgNS+iUp3smSPkr+yCypkdDsFTi34UXuLcmb1/A5
         AOkNh3mlrZX+iq0SeoXQorI5jG8zzfGqmzca9uyWMrFgQ3SziEPSQWArLeh2koGsBHLl
         saFg==
X-Forwarded-Encrypted: i=1; AKwUvBwqg5RGuO05SS/oLGMMXugnb9vhXUl3pk6R5DpiAH6azxo/npX8KV2LF2VB2MlHf4lot+ikoeo=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+8KVzBZAQ6S4QpfcHyxLWWS/yPGSpffr7bR9l9wmcc5cmArc2
	UY1366t8R0UxEJsP8cDUzLqjvy/Pzgd/U0lgtDq+Ww3cU1FlKKoIi2NK
X-Gm-Gg: AYBFou0KD/qSuq6nw2yVb6Dx9jaBK1IUO2O53PR3oeYpA46OSgUL3IwcEsbfGqpo3d9
	y4CvG3vDeUD28Suu37rPD14puhWDofMNPV+4R0Zz8JDOgIBd5sBbWjXHBXO0/SQ+6YMhiAmI+Gu
	QyJ7q4fRQC0qnCJB9YMbkIlOJNZuwabXiVtlCrfYE83IxZG+ya8waKwwvpLLTR0an40o+gjtDJu
	vKuondZY6yyP0HoB9qICYaLoEFeM3R9Av9bsUI44svfz4zG06t8qAU4rp+JjXhPbtv/xXoEp1Aa
	ewB6khqdh/JfHKUqSe4ZxxEPT/jGLVU2DbK3SvqnT0I8zqQpRhEHyVdi9GgEqu8GRiUh7r5+VWi
	HSyRbB82RkaCvIgN3yp74PYOoxg0WoC0ZEnd6DfIDPqcWWFemAqz6bwZLCHTCuSB6qqnuCx3zM/
	ugw+jPsO+lqncoPBXsBYIZ5uclXgpZnHFCmetoizHtzYjvFzr+iYx65jZ3Uuntv0Z9
X-Received: by 2002:a05:6000:26c6:b0:48c:6958:ad6b with SMTP id ffacd0b85a97d-48c72893c35mr1649780f8f.44.1791348438189;
        Tue, 06 Oct 2026 21:47:18 -0700 (PDT)
Received: from beelink.. ([212.23.215.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c7202fa0bsm2836538f8f.3.2026.10.06.21.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 21:47:17 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: maaz.mombasawala@broadcom.com,
	zack.rusin@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org,
	christian.koenig@amd.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/vmwgfx: do not hand the embedded sg_table to the PRIME core [IGT full log - FIXED vmwgfx]
Date: Wed,  7 Oct 2026 01:47:07 -0300
Message-ID: <20261007044707.2171896-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DLX6J39ZERYJ.377I7R20BGISX@broadcom.com>
References: <DLX6J39ZERYJ.377I7R20BGISX@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

=== IGT FULL LOG - FIXED vmwgfx (kernel 7.3.0-rc4+) ===
=== Kernel commit: 6edd14dd67d76d39a518ad3bf1a98363690a5a62 ===

===== vmw_execution_buffer =====
IGT-Version: 2.6-NO-GIT (x86_64) (Linux: 7.3.0-rc4+ x86_64)
Using IGT_SRANDOM=1791339044 for randomisation
Opened device: /dev/dri/renderD128
Starting subtest: mob-create-map
Subtest mob-create-map: SUCCESS (0.000s)
Starting subtest: buffer-create
Subtest buffer-create: SUCCESS (0.000s)
Starting subtest: execution-buffer-submit-sync
Subtest execution-buffer-submit-sync: SUCCESS (0.032s)

===== vmw_mob_stress =====
IGT-Version: 2.6-NO-GIT (x86_64) (Linux: 7.3.0-rc4+ x86_64)
Using IGT_SRANDOM=1791339044 for randomisation
Opened device: /dev/dri/renderD128
Starting subtest: max_mob_mem_stress
[1812.758600] (vmw_mob_stress:579) igt_vmwgfx-CRITICAL: Test assertion failure function vmw_triangle_assert_values, file ../lib/igt_vmwgfx.c:1309:
[1812.758617] (vmw_mob_stress:579) igt_vmwgfx-CRITICAL: Failed assertion: out_pixel[0] == 127
[1812.758621] (vmw_mob_stress:579) igt_vmwgfx-CRITICAL: Last errno: 2, No such file or directory
[1812.758623] (vmw_mob_stress:579) igt_vmwgfx-CRITICAL: error: 128 != 127
Stack trace:
  #0 ../lib/igt_core.c:2146 __igt_fail_assert()
  #1 ../lib/igt_vmwgfx.c:1331 vmw_triangle_assert_values()
  #2 ../tests/vmwgfx/vmw_mob_stress.c:44 __igt_unique____real_main48()
  #3 ../tests/vmwgfx/vmw_mob_stress.c:48 main()
  #4 [__libc_init_first+0x8a]
  #5 [__libc_start_main+0x85]
  #6 [_start+0x21]
Subtest max_mob_mem_stress failed.
**** DEBUG ****
[1812.754433] (vmw_mob_stress:579) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1812.754493] (vmw_mob_stress:579) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1812.755365] (vmw_mob_stress:579) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1812.758600] (vmw_mob_stress:579) igt_vmwgfx-CRITICAL: Test assertion failure function vmw_triangle_assert_values, file ../lib/igt_vmwgfx.c:1309:
[1812.758617] (vmw_mob_stress:579) igt_vmwgfx-CRITICAL: Failed assertion: out_pixel[0] == 127
[1812.758621] (vmw_mob_stress:579) igt_vmwgfx-CRITICAL: Last errno: 2, No such file or directory
[1812.758623] (vmw_mob_stress:579) igt_vmwgfx-CRITICAL: error: 128 != 127
[1812.759007] (vmw_mob_stress:579) igt_core-INFO: Stack trace:
[1812.760091] (vmw_mob_stress:579) igt_core-INFO:   #0 ../lib/igt_core.c:2146 __igt_fail_assert()
[1812.760277] (vmw_mob_stress:579) igt_core-INFO:   #1 ../lib/igt_vmwgfx.c:1331 vmw_triangle_assert_values()
[1812.760409] (vmw_mob_stress:579) igt_core-INFO:   #2 ../tests/vmwgfx/vmw_mob_stress.c:44 __igt_unique____real_main48()
[1812.760416] (vmw_mob_stress:579) igt_core-INFO:   #3 ../tests/vmwgfx/vmw_mob_stress.c:48 main()
[1812.761941] (vmw_mob_stress:579) igt_core-INFO:   #4 [__libc_init_first+0x8a]
[1812.762251] (vmw_mob_stress:579) igt_core-INFO:   #5 [__libc_start_main+0x85]
[1812.762389] (vmw_mob_stress:579) igt_core-INFO:   #6 [_start+0x21]
****  END  ****
Subtest max_mob_mem_stress: FAIL (0.008s)

===== vmw_ref_count =====
IGT-Version: 2.6-NO-GIT (x86_64) (Linux: 7.3.0-rc4+ x86_64)
Using IGT_SRANDOM=1791339044 for randomisation
Opened device: /dev/dri/renderD128
Starting subtest: surface_prime_transfer_explicit_mob
Subtest surface_prime_transfer_explicit_mob: SUCCESS (0.000s)
Starting subtest: surface_prime_transfer_implicit_mob
Subtest surface_prime_transfer_implicit_mob: SUCCESS (0.000s)
Starting subtest: surface_prime_transfer_fd_dup
Subtest surface_prime_transfer_fd_dup: SUCCESS (0.000s)
Starting subtest: surface_prime_transfer_two_surfaces
Subtest surface_prime_transfer_two_surfaces: SUCCESS (0.000s)
Starting subtest: surface_prime_transfer_single_surface_multiple_handle
Subtest surface_prime_transfer_single_surface_multiple_handle: SUCCESS (0.000s)
Starting subtest: mob_repeated_unref
Subtest mob_repeated_unref: SUCCESS (0.000s)
Starting subtest: surface_repeated_unref
Subtest surface_repeated_unref: SUCCESS (0.000s)
Starting subtest: surface_alloc_ref_unref
Subtest surface_alloc_ref_unref: SUCCESS (0.000s)
Starting subtest: surface_buffer_ref
Subtest surface_buffer_ref: SUCCESS (0.001s)
Starting subtest: surface_prime_refs
Subtest surface_prime_refs: SUCCESS (0.001s)
Starting subtest: surface_buffer_prime_refs
Subtest surface_buffer_prime_refs: SUCCESS (0.001s)

===== vmw_surface_copy =====
IGT-Version: 2.6-NO-GIT (x86_64) (Linux: 7.3.0-rc4+ x86_64)
Using IGT_SRANDOM=1791339044 for randomisation
Opened device: /dev/dri/renderD128
Starting subtest: test_invalid_copies
vmw_ioctl_command error Invalid argument.
vmw_ioctl_command error Invalid argument.
Subtest test_invalid_copies: SUCCESS (0.049s)
Starting subtest: test_invalid_copies_3d
Subtest test_invalid_copies_3d: SUCCESS (0.001s)

===== vmw_tri =====
IGT-Version: 2.6-NO-GIT (x86_64) (Linux: 7.3.0-rc4+ x86_64)
Using IGT_SRANDOM=1791339044 for randomisation
Opened device: /dev/dri/renderD128
Starting subtest: tri
[1812.916602] (vmw_tri:588) igt_vmwgfx-CRITICAL: Test assertion failure function vmw_triangle_assert_values, file ../lib/igt_vmwgfx.c:1309:
[1812.916625] (vmw_tri:588) igt_vmwgfx-CRITICAL: Failed assertion: out_pixel[0] == 127
[1812.916629] (vmw_tri:588) igt_vmwgfx-CRITICAL: Last errno: 2, No such file or directory
[1812.916631] (vmw_tri:588) igt_vmwgfx-CRITICAL: error: 128 != 127
Stack trace:
  #0 ../lib/igt_core.c:2146 __igt_fail_assert()
  #1 ../lib/igt_vmwgfx.c:1331 vmw_triangle_assert_values()
  #2 ../tests/vmwgfx/vmw_tri.c:51 __igt_unique____real_main183()
  #3 ../tests/vmwgfx/vmw_tri.c:183 main()
  #4 [__libc_init_first+0x8a]
  #5 [__libc_start_main+0x85]
  #6 [_start+0x21]
Subtest tri failed.
**** DEBUG ****
[1812.907494] (vmw_tri:588) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(drm_fd)
[1812.907562] (vmw_tri:588) DEBUG: Test requirement passed: cid != SVGA3D_INVALID_ID
[1812.907571] (vmw_tri:588) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1812.907669] (vmw_tri:588) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1812.908847] (vmw_tri:588) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1812.916602] (vmw_tri:588) igt_vmwgfx-CRITICAL: Test assertion failure function vmw_triangle_assert_values, file ../lib/igt_vmwgfx.c:1309:
[1812.916625] (vmw_tri:588) igt_vmwgfx-CRITICAL: Failed assertion: out_pixel[0] == 127
[1812.916629] (vmw_tri:588) igt_vmwgfx-CRITICAL: Last errno: 2, No such file or directory
[1812.916631] (vmw_tri:588) igt_vmwgfx-CRITICAL: error: 128 != 127
[1812.917125] (vmw_tri:588) igt_core-INFO: Stack trace:
[1812.918079] (vmw_tri:588) igt_core-INFO:   #0 ../lib/igt_core.c:2146 __igt_fail_assert()
[1812.918265] (vmw_tri:588) igt_core-INFO:   #1 ../lib/igt_vmwgfx.c:1331 vmw_triangle_assert_values()
[1812.918410] (vmw_tri:588) igt_core-INFO:   #2 ../tests/vmwgfx/vmw_tri.c:51 __igt_unique____real_main183()
[1812.918442] (vmw_tri:588) igt_core-INFO:   #3 ../tests/vmwgfx/vmw_tri.c:183 main()
[1812.919944] (vmw_tri:588) igt_core-INFO:   #4 [__libc_init_first+0x8a]
[1812.920259] (vmw_tri:588) igt_core-INFO:   #5 [__libc_start_main+0x85]
[1812.920399] (vmw_tri:588) igt_core-INFO:   #6 [_start+0x21]
****  END  ****
Subtest tri: FAIL (0.013s)
Starting subtest: tri-no-sync-coherent
[1812.925114] (vmw_tri:588) igt_vmwgfx-CRITICAL: Test assertion failure function vmw_triangle_assert_values, file ../lib/igt_vmwgfx.c:1309:
[1812.925129] (vmw_tri:588) igt_vmwgfx-CRITICAL: Failed assertion: out_pixel[0] == 127
[1812.925132] (vmw_tri:588) igt_vmwgfx-CRITICAL: error: 128 != 127
Stack trace:
  #0 ../lib/igt_core.c:2146 __igt_fail_assert()
  #1 ../lib/igt_vmwgfx.c:1331 vmw_triangle_assert_values()
  #2 ../tests/vmwgfx/vmw_tri.c:172 __igt_unique____real_main183()
  #3 ../tests/vmwgfx/vmw_tri.c:183 main()
  #4 [__libc_init_first+0x8a]
  #5 [__libc_start_main+0x85]
  #6 [_start+0x21]
Subtest tri-no-sync-coherent failed.
**** DEBUG ****
[1812.920885] (vmw_tri:588) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(drm_fd)
[1812.920936] (vmw_tri:588) DEBUG: Test requirement passed: cid != SVGA3D_INVALID_ID
[1812.920937] (vmw_tri:588) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1812.920991] (vmw_tri:588) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1812.921887] (vmw_tri:588) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1812.921947] (vmw_tri:588) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1812.922284] (vmw_tri:588) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1812.925114] (vmw_tri:588) igt_vmwgfx-CRITICAL: Test assertion failure function vmw_triangle_assert_values, file ../lib/igt_vmwgfx.c:1309:
[1812.925129] (vmw_tri:588) igt_vmwgfx-CRITICAL: Failed assertion: out_pixel[0] == 127
[1812.925132] (vmw_tri:588) igt_vmwgfx-CRITICAL: error: 128 != 127
[1812.925466] (vmw_tri:588) igt_core-INFO: Stack trace:
[1812.926399] (vmw_tri:588) igt_core-INFO:   #0 ../lib/igt_core.c:2146 __igt_fail_assert()
[1812.926832] (vmw_tri:588) igt_core-INFO:   #1 ../lib/igt_vmwgfx.c:1331 vmw_triangle_assert_values()
[1812.926938] (vmw_tri:588) igt_core-INFO:   #2 ../tests/vmwgfx/vmw_tri.c:172 __igt_unique____real_main183()
[1812.926964] (vmw_tri:588) igt_core-INFO:   #3 ../tests/vmwgfx/vmw_tri.c:183 main()
[1812.927527] (vmw_tri:588) igt_core-INFO:   #4 [__libc_init_first+0x8a]
[1812.929069] (vmw_tri:588) igt_core-INFO:   #5 [__libc_start_main+0x85]
[1812.929202] (vmw_tri:588) igt_core-INFO:   #6 [_start+0x21]
****  END  ****
Subtest tri-no-sync-coherent: FAIL (0.009s)
Starting subtest: tri-2d
Subtest tri-2d: SUCCESS (0.005s)

===== vmw_prime =====
IGT-Version: 2.6-NO-GIT (x86_64) (Linux: 7.3.0-rc4+ x86_64)
Using IGT_SRANDOM=1791339044 for randomisation
Opened device: /dev/dri/card0
Opened device: /dev/dri/renderD128
Starting subtest: tri-map-gem
vmw_ioctl_surface_ref Failed
vmw_ioctl_command error Invalid argument.
vmw_ioctl_command error Invalid argument.
vmw_ioctl_fence_finish Failed
vmw_ioctl_command error Invalid argument.
vmw_ioctl_fence_finish Failed
vmw_ioctl_mob_map: Map failed.
[1813.009742] (vmw_prime:593) CRITICAL: Test assertion failure function draw_triangle_map_gem, file ../tests/vmwgfx/vmw_prime.c:123:
[1813.009744] (vmw_prime:593) CRITICAL: Failed assertion: save_status
Stack trace:
  #0 ../lib/igt_core.c:2146 __igt_fail_assert()
  #1 ../tests/vmwgfx/vmw_prime.c:500 __igt_unique____real_main508()
  #2 ../tests/vmwgfx/vmw_prime.c:508 main()
  #3 [__libc_init_first+0x8a]
  #4 [__libc_start_main+0x85]
  #5 [_start+0x21]
Subtest tri-map-gem failed.
**** DEBUG ****
[1812.968183] (vmw_prime:593) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1812.968228] (vmw_prime:593) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1813.009532] (vmw_prime:593) igt_vmwgfx-INFO: vmw_ioctl_command error Invalid argument.
[1813.009576] (vmw_prime:593) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1813.009612] (vmw_prime:593) igt_vmwgfx-INFO: vmw_ioctl_command error Invalid argument.
[1813.009659] (vmw_prime:593) igt_vmwgfx-INFO: vmw_ioctl_command error Invalid argument.
[1813.009742] (vmw_prime:593) CRITICAL: Test assertion failure function draw_triangle_map_gem, file ../tests/vmwgfx/vmw_prime.c:123:
[1813.009744] (vmw_prime:593) CRITICAL: Failed assertion: save_status
[1813.010076] (vmw_prime:593) igt_core-INFO: Stack trace:
[1813.011065] (vmw_prime:593) igt_core-INFO:   #0 ../lib/igt_core.c:2146 __igt_fail_assert()
[1813.011213] (vmw_prime:593) igt_core-INFO:   #1 ../tests/vmwgfx/vmw_prime.c:500 __igt_unique____real_main508()
[1813.011231] (vmw_prime:593) igt_core-INFO:   #2 ../tests/vmwgfx/vmw_prime.c:508 main()
[1813.012855] (vmw_prime:593) igt_core-INFO:   #3 [__libc_init_first+0x8a]
[1813.013162] (vmw_prime:593) igt_core-INFO:   #4 [__libc_start_main+0x85]
[1813.013308] (vmw_prime:593) igt_core-INFO:   #5 [_start+0x21]
****  END  ****
Subtest tri-map-gem: FAIL (0.046s)
Starting subtest: tri-map-dmabuf
vmw_ioctl_surface_ref Failed
vmw_ioctl_command error Invalid argument.
vmw_ioctl_command error Invalid argument.
vmw_ioctl_fence_finish Failed
vmw_ioctl_command error Invalid argument.
vmw_ioctl_fence_finish Failed
vmw_ioctl_mob_map: Map failed.
[1813.052296] (vmw_prime:593) CRITICAL: Test assertion failure function draw_triangle_map_dmabuf, file ../tests/vmwgfx/vmw_prime.c:160:
[1813.052298] (vmw_prime:593) CRITICAL: Failed assertion: save_status
[1813.052300] (vmw_prime:593) CRITICAL: Last errno: 22, Invalid argument
Stack trace:
  #0 ../lib/igt_core.c:2146 __igt_fail_assert()
  #1 ../tests/vmwgfx/vmw_prime.c:520 __igt_unique____real_main508()
  #2 ../tests/vmwgfx/vmw_prime.c:508 main()
  #3 [__libc_init_first+0x8a]
  #4 [__libc_start_main+0x85]
  #5 [_start+0x21]
Subtest tri-map-dmabuf failed.
**** DEBUG ****
[1813.014001] (vmw_prime:593) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1813.014040] (vmw_prime:593) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1813.052087] (vmw_prime:593) igt_vmwgfx-INFO: vmw_ioctl_command error Invalid argument.
[1813.052111] (vmw_prime:593) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1813.052200] (vmw_prime:593) igt_vmwgfx-INFO: vmw_ioctl_command error Invalid argument.
[1813.052245] (vmw_prime:593) igt_vmwgfx-INFO: vmw_ioctl_command error Invalid argument.
[1813.052296] (vmw_prime:593) CRITICAL: Test assertion failure function draw_triangle_map_dmabuf, file ../tests/vmwgfx/vmw_prime.c:160:
[1813.052298] (vmw_prime:593) CRITICAL: Failed assertion: save_status
[1813.052300] (vmw_prime:593) CRITICAL: Last errno: 22, Invalid argument
[1813.052581] (vmw_prime:593) igt_core-INFO: Stack trace:
[1813.053203] (vmw_prime:593) igt_core-INFO:   #0 ../lib/igt_core.c:2146 __igt_fail_assert()
[1813.053343] (vmw_prime:593) igt_core-INFO:   #1 ../tests/vmwgfx/vmw_prime.c:520 __igt_unique____real_main508()
[1813.053361] (vmw_prime:593) igt_core-INFO:   #2 ../tests/vmwgfx/vmw_prime.c:508 main()
[1813.053911] (vmw_prime:593) igt_core-INFO:   #3 [__libc_init_first+0x8a]
[1813.054225] (vmw_prime:593) igt_core-INFO:   #4 [__libc_start_main+0x85]
[1813.054351] (vmw_prime:593) igt_core-INFO:   #5 [_start+0x21]
****  END  ****
Subtest tri-map-dmabuf: FAIL (0.041s)
Starting subtest: draw-dumb-buffer
vmw_ioctl_surface_ref Failed
[1813.093153] (vmw_prime:593) CRITICAL: Test assertion failure function prepare_crtc_surface, file ../tests/vmwgfx/vmw_prime.c:250:
[1813.093156] (vmw_prime:593) CRITICAL: Failed assertion: (__kms_addfb(gpu->fb.fd, gpu->fb_surface->base.handle, gpu->fb.width, gpu->fb.height, gpu->fb.drm_format, gpu->fb.modifier, gpu->fb.strides, gpu->fb.offsets, gpu->fb.num_planes, 0, &gpu->fb.fb_id)) == 0
[1813.093158] (vmw_prime:593) CRITICAL: Last errno: 22, Invalid argument
Stack trace:
  #0 ../lib/igt_core.c:2146 __igt_fail_assert()
  #1 ../tests/vmwgfx/vmw_prime.c:242 __igt_unique____real_main508()
  #2 ../tests/vmwgfx/vmw_prime.c:508 main()
  #3 [__libc_init_first+0x8a]
  #4 [__libc_start_main+0x85]
  #5 [_start+0x21]
Subtest draw-dumb-buffer failed.
**** DEBUG ****
[1813.054730] (vmw_prime:593) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(drm_fd)
[1813.054777] (vmw_prime:593) igt_kms-DEBUG: display: Virtual-1: set_crtc(A)
[1813.054837] (vmw_prime:593) igt_kms-DEBUG: display: Virtual-1: Selecting CRTC A
[1813.054850] (vmw_prime:593) igt_fb-DEBUG: igt_create_fb_with_bo_size(width=1280, height=800, format=XR24(0x34325258), modifier=0x0, size=0)
[1813.054914] (vmw_prime:593) igt_fb-DEBUG: igt_create_fb_with_bo_size(handle=2, pitch=5120)
[1813.054917] (vmw_prime:593) ioctl_wrappers-DEBUG: Test requirement passed: igt_has_fb_modifiers(fd)
[1813.054959] (vmw_prime:593) igt_fb-DEBUG: Test requirement passed: cairo_surface_status(fb->cairo_surface) == CAIRO_STATUS_SUCCESS
[1813.093153] (vmw_prime:593) CRITICAL: Test assertion failure function prepare_crtc_surface, file ../tests/vmwgfx/vmw_prime.c:250:
[1813.093156] (vmw_prime:593) CRITICAL: Failed assertion: (__kms_addfb(gpu->fb.fd, gpu->fb_surface->base.handle, gpu->fb.width, gpu->fb.height, gpu->fb.drm_format, gpu->fb.modifier, gpu->fb.strides, gpu->fb.offsets, gpu->fb.num_planes, 0, &gpu->fb.fb_id)) == 0
[1813.093158] (vmw_prime:593) CRITICAL: Last errno: 22, Invalid argument
[1813.093417] (vmw_prime:593) igt_core-INFO: Stack trace:
[1813.094067] (vmw_prime:593) igt_core-INFO:   #0 ../lib/igt_core.c:2146 __igt_fail_assert()
[1813.094204] (vmw_prime:593) igt_core-INFO:   #1 ../tests/vmwgfx/vmw_prime.c:242 __igt_unique____real_main508()
[1813.094222] (vmw_prime:593) igt_core-INFO:   #2 ../tests/vmwgfx/vmw_prime.c:508 main()
[1813.094804] (vmw_prime:593) igt_core-INFO:   #3 [__libc_init_first+0x8a]
[1813.095127] (vmw_prime:593) igt_core-INFO:   #4 [__libc_start_main+0x85]
[1813.095286] (vmw_prime:593) igt_core-INFO:   #5 [_start+0x21]
****  END  ****
Subtest draw-dumb-buffer: FAIL (0.041s)
Starting subtest: buffer-surface-fb-sharing-sync-readback
[1813.100669] (vmw_prime:593) igt_pipe_crc-CRITICAL: Test assertion failure function igt_pipe_crc_start, file ../lib/igt_pipe_crc.c:416:
[1813.100685] (vmw_prime:593) igt_pipe_crc-CRITICAL: Failed assertion: write(pipe_crc->ctl_fd, src, strlen(src)) == strlen(src)
[1813.100687] (vmw_prime:593) igt_pipe_crc-CRITICAL: Last errno: 22, Invalid argument
[1813.100689] (vmw_prime:593) igt_pipe_crc-CRITICAL: error: -1 != 4
Stack trace:
  #0 ../lib/igt_core.c:2146 __igt_fail_assert()
  #1 ../lib/igt_pipe_crc.c:422 igt_pipe_crc_start()
  #2 ../lib/igt_pipe_crc.c:627 igt_pipe_crc_collect_crc()
  #3 ../tests/vmwgfx/vmw_prime.c:307 draw_triangle_3d()
  #4 ../tests/vmwgfx/vmw_prime.c:545 __igt_unique____real_main508()
  #5 ../tests/vmwgfx/vmw_prime.c:508 main()
  #6 [__libc_init_first+0x8a]
  #7 [__libc_start_main+0x85]
  #8 [_start+0x21]
Subtest buffer-surface-fb-sharing-sync-readback failed.
**** DEBUG ****
[1813.096322] (vmw_prime:593) igt_kms-DEBUG: display: Virtual-1: set_crtc(A)
[1813.096375] (vmw_prime:593) igt_kms-DEBUG: display: Virtual-1: Selecting CRTC A
[1813.096389] (vmw_prime:593) igt_fb-DEBUG: igt_create_fb_with_bo_size(width=1280, height=800, format=XR24(0x34325258), modifier=0x0, size=0)
[1813.096550] (vmw_prime:593) igt_fb-DEBUG: igt_create_fb_with_bo_size(handle=3, pitch=5120)
[1813.096553] (vmw_prime:593) ioctl_wrappers-DEBUG: Test requirement passed: igt_has_fb_modifiers(fd)
[1813.096576] (vmw_prime:593) igt_fb-DEBUG: Test requirement passed: cairo_surface_status(fb->cairo_surface) == CAIRO_STATUS_SUCCESS
[1813.099306] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.099307] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.099309] (vmw_prime:593) igt_kms-DEBUG: display: A.0: plane_set_fb(113)
[1813.099311] (vmw_prime:593) igt_kms-DEBUG: display: A.0: plane_set_size (1280x800)
[1813.099312] (vmw_prime:593) igt_kms-DEBUG: display: A.0: fb_set_position(0,0)
[1813.099313] (vmw_prime:593) igt_kms-DEBUG: display: A.0: fb_set_size(1280x800)
[1813.099316] (vmw_prime:593) igt_kms-DEBUG: display: commit {
[1813.099351] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.099352] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.099354] (vmw_prime:593) igt_kms-DEBUG: display:     Virtual-1: SetCrtc pipe A, fb 113, src (0, 0), mode 1280x800
[1813.099665] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.099668] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.099669] (vmw_prime:593) igt_kms-DEBUG: display:     SetCursor pipe A, disabling
[1813.099712] (vmw_prime:593) igt_kms-DEBUG: display:     MoveCursor pipe A, (0, 0)
[1813.099762] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.099763] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.099765] (vmw_prime:593) igt_kms-DEBUG: display:     SetCrtc pipe B, disabling
[1813.099796] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.099797] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.099797] (vmw_prime:593) igt_kms-DEBUG: display:     SetCursor pipe B, disabling
[1813.099814] (vmw_prime:593) igt_kms-DEBUG: display:     MoveCursor pipe B, (0, 0)
[1813.099848] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.099849] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.099850] (vmw_prime:593) igt_kms-DEBUG: display:     SetCrtc pipe C, disabling
[1813.099875] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.099876] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.099876] (vmw_prime:593) igt_kms-DEBUG: display:     SetCursor pipe C, disabling
[1813.099896] (vmw_prime:593) igt_kms-DEBUG: display:     MoveCursor pipe C, (0, 0)
[1813.099929] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.099929] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.099930] (vmw_prime:593) igt_kms-DEBUG: display:     SetCrtc pipe D, disabling
[1813.099954] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.099955] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.099955] (vmw_prime:593) igt_kms-DEBUG: display:     SetCursor pipe D, disabling
[1813.100141] (vmw_prime:593) igt_kms-DEBUG: display:     MoveCursor pipe D, (0, 0)
[1813.100175] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.100175] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.100176] (vmw_prime:593) igt_kms-DEBUG: display:     SetCrtc pipe E, disabling
[1813.100199] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.100200] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.100201] (vmw_prime:593) igt_kms-DEBUG: display:     SetCursor pipe E, disabling
[1813.100216] (vmw_prime:593) igt_kms-DEBUG: display:     MoveCursor pipe E, (0, 0)
[1813.100252] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.100252] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.100253] (vmw_prime:593) igt_kms-DEBUG: display:     SetCrtc pipe F, disabling
[1813.100277] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.100278] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.100278] (vmw_prime:593) igt_kms-DEBUG: display:     SetCursor pipe F, disabling
[1813.100299] (vmw_prime:593) igt_kms-DEBUG: display:     MoveCursor pipe F, (0, 0)
[1813.100333] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.100334] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.100335] (vmw_prime:593) igt_kms-DEBUG: display:     SetCrtc pipe G, disabling
[1813.100359] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.100360] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.100360] (vmw_prime:593) igt_kms-DEBUG: display:     SetCursor pipe G, disabling
[1813.100376] (vmw_prime:593) igt_kms-DEBUG: display:     MoveCursor pipe G, (0, 0)
[1813.100409] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.100409] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.100410] (vmw_prime:593) igt_kms-DEBUG: display:     SetCrtc pipe H, disabling
[1813.100457] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.100458] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.100459] (vmw_prime:593) igt_kms-DEBUG: display:     SetCursor pipe H, disabling
[1813.100478] (vmw_prime:593) igt_kms-DEBUG: display:     MoveCursor pipe H, (0, 0)
[1813.100497] (vmw_prime:593) igt_kms-DEBUG: display: }
[1813.100669] (vmw_prime:593) igt_pipe_crc-CRITICAL: Test assertion failure function igt_pipe_crc_start, file ../lib/igt_pipe_crc.c:416:
[1813.100685] (vmw_prime:593) igt_pipe_crc-CRITICAL: Failed assertion: write(pipe_crc->ctl_fd, src, strlen(src)) == strlen(src)
[1813.100687] (vmw_prime:593) igt_pipe_crc-CRITICAL: Last errno: 22, Invalid argument
[1813.100689] (vmw_prime:593) igt_pipe_crc-CRITICAL: error: -1 != 4
[1813.100982] (vmw_prime:593) igt_core-INFO: Stack trace:
[1813.101587] (vmw_prime:593) igt_core-INFO:   #0 ../lib/igt_core.c:2146 __igt_fail_assert()
[1813.101705] (vmw_prime:593) igt_core-INFO:   #1 ../lib/igt_pipe_crc.c:422 igt_pipe_crc_start()
[1813.101768] (vmw_prime:593) igt_core-INFO:   #2 ../lib/igt_pipe_crc.c:627 igt_pipe_crc_collect_crc()
[1813.101901] (vmw_prime:593) igt_core-INFO:   #3 ../tests/vmwgfx/vmw_prime.c:307 draw_triangle_3d()
[1813.101917] (vmw_prime:593) igt_core-INFO:   #4 ../tests/vmwgfx/vmw_prime.c:545 __igt_unique____real_main508()
[1813.101921] (vmw_prime:593) igt_core-INFO:   #5 ../tests/vmwgfx/vmw_prime.c:508 main()
[1813.102482] (vmw_prime:593) igt_core-INFO:   #6 [__libc_init_first+0x8a]
[1813.102807] (vmw_prime:593) igt_core-INFO:   #7 [__libc_start_main+0x85]
[1813.102930] (vmw_prime:593) igt_core-INFO:   #8 [_start+0x21]
****  END  ****
Subtest buffer-surface-fb-sharing-sync-readback: FAIL (0.007s)
Starting subtest: buffer-surface-fb-sharing-sync
[1813.106531] (vmw_prime:593) igt_pipe_crc-CRITICAL: Test assertion failure function igt_pipe_crc_start, file ../lib/igt_pipe_crc.c:416:
[1813.106544] (vmw_prime:593) igt_pipe_crc-CRITICAL: Failed assertion: write(pipe_crc->ctl_fd, src, strlen(src)) == strlen(src)
[1813.106547] (vmw_prime:593) igt_pipe_crc-CRITICAL: Last errno: 22, Invalid argument
[1813.106549] (vmw_prime:593) igt_pipe_crc-CRITICAL: error: -1 != 4
Stack trace:
  #0 ../lib/igt_core.c:2146 __igt_fail_assert()
  #1 ../lib/igt_pipe_crc.c:422 igt_pipe_crc_start()
  #2 ../lib/igt_pipe_crc.c:627 igt_pipe_crc_collect_crc()
  #3 ../tests/vmwgfx/vmw_prime.c:307 draw_triangle_3d()
  #4 ../tests/vmwgfx/vmw_prime.c:552 __igt_unique____real_main508()
  #5 ../tests/vmwgfx/vmw_prime.c:508 main()
  #6 [__libc_init_first+0x8a]
  #7 [__libc_start_main+0x85]
  #8 [_start+0x21]
Subtest buffer-surface-fb-sharing-sync failed.
**** DEBUG ****
[1813.103307] (vmw_prime:593) igt_kms-DEBUG: display: Virtual-1: set_crtc(A)
[1813.103351] (vmw_prime:593) igt_kms-DEBUG: display: Virtual-1: Selecting CRTC A
[1813.103361] (vmw_prime:593) igt_fb-DEBUG: igt_create_fb_with_bo_size(width=1280, height=800, format=XR24(0x34325258), modifier=0x0, size=0)
[1813.103455] (vmw_prime:593) igt_fb-DEBUG: igt_create_fb_with_bo_size(handle=4, pitch=5120)
[1813.103457] (vmw_prime:593) ioctl_wrappers-DEBUG: Test requirement passed: igt_has_fb_modifiers(fd)
[1813.103481] (vmw_prime:593) igt_fb-DEBUG: Test requirement passed: cairo_surface_status(fb->cairo_surface) == CAIRO_STATUS_SUCCESS
[1813.106221] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.106222] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.106223] (vmw_prime:593) igt_kms-DEBUG: display: A.0: plane_set_fb(114)
[1813.106224] (vmw_prime:593) igt_kms-DEBUG: display: A.0: plane_set_size (1280x800)
[1813.106224] (vmw_prime:593) igt_kms-DEBUG: display: A.0: fb_set_position(0,0)
[1813.106225] (vmw_prime:593) igt_kms-DEBUG: display: A.0: fb_set_size(1280x800)
[1813.106227] (vmw_prime:593) igt_kms-DEBUG: display: commit {
[1813.106228] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.106228] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.106229] (vmw_prime:593) igt_kms-DEBUG: display:     Virtual-1: SetCrtc pipe A, fb 114, src (0, 0), mode 1280x800
[1813.106399] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.106400] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.106401] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.106401] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.106402] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.106403] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.106404] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.106404] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.106405] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.106405] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.106406] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.106406] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.106407] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.106407] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.106408] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.106409] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.106409] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.106410] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.106411] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.106412] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.106413] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.106413] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.106414] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.106414] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.106415] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.106415] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.106416] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.106416] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.106418] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.106418] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.106419] (vmw_prime:593) igt_kms-DEBUG: display: }
[1813.106531] (vmw_prime:593) igt_pipe_crc-CRITICAL: Test assertion failure function igt_pipe_crc_start, file ../lib/igt_pipe_crc.c:416:
[1813.106544] (vmw_prime:593) igt_pipe_crc-CRITICAL: Failed assertion: write(pipe_crc->ctl_fd, src, strlen(src)) == strlen(src)
[1813.106547] (vmw_prime:593) igt_pipe_crc-CRITICAL: Last errno: 22, Invalid argument
[1813.106549] (vmw_prime:593) igt_pipe_crc-CRITICAL: error: -1 != 4
[1813.106808] (vmw_prime:593) igt_core-INFO: Stack trace:
[1813.107348] (vmw_prime:593) igt_core-INFO:   #0 ../lib/igt_core.c:2146 __igt_fail_assert()
[1813.107488] (vmw_prime:593) igt_core-INFO:   #1 ../lib/igt_pipe_crc.c:422 igt_pipe_crc_start()
[1813.107546] (vmw_prime:593) igt_core-INFO:   #2 ../lib/igt_pipe_crc.c:627 igt_pipe_crc_collect_crc()
[1813.107896] (vmw_prime:593) igt_core-INFO:   #3 ../tests/vmwgfx/vmw_prime.c:307 draw_triangle_3d()
[1813.107933] (vmw_prime:593) igt_core-INFO:   #4 ../tests/vmwgfx/vmw_prime.c:552 __igt_unique____real_main508()
[1813.107946] (vmw_prime:593) igt_core-INFO:   #5 ../tests/vmwgfx/vmw_prime.c:508 main()
[1813.108807] (vmw_prime:593) igt_core-INFO:   #6 [__libc_init_first+0x8a]
[1813.109133] (vmw_prime:593) igt_core-INFO:   #7 [__libc_start_main+0x85]
[1813.109257] (vmw_prime:593) igt_core-INFO:   #8 [_start+0x21]
****  END  ****
Subtest buffer-surface-fb-sharing-sync: FAIL (0.006s)
Starting subtest: buffer-surface-fb-sharing
[1813.117148] (vmw_prime:593) igt_pipe_crc-CRITICAL: Test assertion failure function igt_pipe_crc_start, file ../lib/igt_pipe_crc.c:416:
[1813.117160] (vmw_prime:593) igt_pipe_crc-CRITICAL: Failed assertion: write(pipe_crc->ctl_fd, src, strlen(src)) == strlen(src)
[1813.117163] (vmw_prime:593) igt_pipe_crc-CRITICAL: Last errno: 22, Invalid argument
[1813.117164] (vmw_prime:593) igt_pipe_crc-CRITICAL: error: -1 != 4
Stack trace:
  #0 ../lib/igt_core.c:2146 __igt_fail_assert()
  #1 ../lib/igt_pipe_crc.c:422 igt_pipe_crc_start()
  #2 ../lib/igt_pipe_crc.c:627 igt_pipe_crc_collect_crc()
  #3 ../tests/vmwgfx/vmw_prime.c:307 draw_triangle_3d()
  #4 ../tests/vmwgfx/vmw_prime.c:557 __igt_unique____real_main508()
  #5 ../tests/vmwgfx/vmw_prime.c:508 main()
  #6 [__libc_init_first+0x8a]
  #7 [__libc_start_main+0x85]
  #8 [_start+0x21]
Subtest buffer-surface-fb-sharing failed.
**** DEBUG ****
[1813.109649] (vmw_prime:593) igt_kms-DEBUG: display: Virtual-1: set_crtc(A)
[1813.109692] (vmw_prime:593) igt_kms-DEBUG: display: Virtual-1: Selecting CRTC A
[1813.109702] (vmw_prime:593) igt_fb-DEBUG: igt_create_fb_with_bo_size(width=1280, height=800, format=XR24(0x34325258), modifier=0x0, size=0)
[1813.109822] (vmw_prime:593) igt_fb-DEBUG: igt_create_fb_with_bo_size(handle=5, pitch=5120)
[1813.109824] (vmw_prime:593) ioctl_wrappers-DEBUG: Test requirement passed: igt_has_fb_modifiers(fd)
[1813.109846] (vmw_prime:593) igt_fb-DEBUG: Test requirement passed: cairo_surface_status(fb->cairo_surface) == CAIRO_STATUS_SUCCESS
[1813.116870] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.116872] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.116872] (vmw_prime:593) igt_kms-DEBUG: display: A.0: plane_set_fb(115)
[1813.116873] (vmw_prime:593) igt_kms-DEBUG: display: A.0: plane_set_size (1280x800)
[1813.116875] (vmw_prime:593) igt_kms-DEBUG: display: A.0: fb_set_position(0,0)
[1813.116875] (vmw_prime:593) igt_kms-DEBUG: display: A.0: fb_set_size(1280x800)
[1813.116876] (vmw_prime:593) igt_kms-DEBUG: display: commit {
[1813.116877] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.116878] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.116878] (vmw_prime:593) igt_kms-DEBUG: display:     Virtual-1: SetCrtc pipe A, fb 115, src (0, 0), mode 1280x800
[1813.117048] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.117049] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.117050] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.117051] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.117051] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.117052] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.117053] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.117053] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.117054] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.117055] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.117055] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.117056] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.117057] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.117057] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.117058] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.117058] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.117059] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.117059] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.117060] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.117060] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.117062] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.117062] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.117063] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.117063] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.117063] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.117064] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.117065] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.117065] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.117066] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1813.117066] (vmw_prime:593) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1813.117067] (vmw_prime:593) igt_kms-DEBUG: display: }
[1813.117148] (vmw_prime:593) igt_pipe_crc-CRITICAL: Test assertion failure function igt_pipe_crc_start, file ../lib/igt_pipe_crc.c:416:
[1813.117160] (vmw_prime:593) igt_pipe_crc-CRITICAL: Failed assertion: write(pipe_crc->ctl_fd, src, strlen(src)) == strlen(src)
[1813.117163] (vmw_prime:593) igt_pipe_crc-CRITICAL: Last errno: 22, Invalid argument
[1813.117164] (vmw_prime:593) igt_pipe_crc-CRITICAL: error: -1 != 4
[1813.117417] (vmw_prime:593) igt_core-INFO: Stack trace:
[1813.117947] (vmw_prime:593) igt_core-INFO:   #0 ../lib/igt_core.c:2146 __igt_fail_assert()
[1813.118041] (vmw_prime:593) igt_core-INFO:   #1 ../lib/igt_pipe_crc.c:422 igt_pipe_crc_start()
[1813.118085] (vmw_prime:593) igt_core-INFO:   #2 ../lib/igt_pipe_crc.c:627 igt_pipe_crc_collect_crc()
[1813.118199] (vmw_prime:593) igt_core-INFO:   #3 ../tests/vmwgfx/vmw_prime.c:307 draw_triangle_3d()
[1813.118203] (vmw_prime:593) igt_core-INFO:   #4 ../tests/vmwgfx/vmw_prime.c:557 __igt_unique____real_main508()
[1813.118209] (vmw_prime:593) igt_core-INFO:   #5 ../tests/vmwgfx/vmw_prime.c:508 main()
[1813.118737] (vmw_prime:593) igt_core-INFO:   #6 [__libc_init_first+0x8a]
[1813.119016] (vmw_prime:593) igt_core-INFO:   #7 [__libc_start_main+0x85]
[1813.119146] (vmw_prime:593) igt_core-INFO:   #8 [_start+0x21]
****  END  ****
Subtest buffer-surface-fb-sharing: FAIL (0.010s)
Opened device: /dev/dri/card1
Starting subtest: basic-vgem
Subtest basic-vgem: SUCCESS (0.001s)

=== New IGT subtest (vmw_prime_sgtable) with dmesg ===

IGT-Version: 2.6-NO-GIT (x86_64) (Linux: 7.3.0-rc4+ x86_64)
Using IGT_SRANDOM=1791345857 for randomisation
Starting subtest: sgtable-invalid-free
Subtest sgtable-invalid-free: SUCCESS (0.001s)
=== DMESG AFTER FIXED TEST (cleared before) ===
[   34.274292] Console: switching to colour dummy device 80x25
[   34.274341] [IGT] vmw_prime_sgtable: executing
[   34.284281] [IGT] vmw_prime_sgtable: starting subtest sgtable-invalid-free
[   34.284814] ------------[ cut here ]------------
[   34.284821] Command buffer error.
[   34.284824] WARNING: vmwgfx_cmdbuf.c:403 at vmw_cmdbuf_ctx_process+0x1bb/0x7a0 [vmwgfx], CPU#0: irq/16-vmwgfx/328
[   34.284884] [IGT] vmw_prime_sgtable: finished subtest sgtable-invalid-free, SUCCESS
[   34.288247] Modules linked in: vgem(OE) drm_shmem_helper(OE) vmwgfx(OE) drm_client_lib(OE) drm_ttm_helper(OE) ttm(OE) drm_kms_helper(OE) e1000(E)
[   34.289491] CPU: 0 UID: 0 PID: 328 Comm: irq/16-vmwgfx Tainted: G           OE       7.3.0-rc4+ #17 PREEMPT(lazy) 
[   34.290495] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   34.291008] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/17/2026
[   34.292043] RIP: 0010:vmw_cmdbuf_ctx_process+0x1bb/0x7a0 [vmwgfx]
[   34.292663] Code: 30 01 83 fd 04 0f 84 56 03 00 00 0f 87 3d 02 00 00 83 fd 01 0f 84 27 02 00 00 83 fd 03 0f 85 12 02 00 00 48 8d 3d 55 65 e3 ff <67> 48 0f b9 3a 4c 89 f0 48 c1 e8 03 80 3c 18 00 0f 85 91 04 00 00
[   34.294411] RSP: 0018:ffff8881025efbd8 EFLAGS: 00010246
[   34.294894] RAX: ffff888119b73870 RBX: dffffc0000000000 RCX: 0000000000000000
[   34.295562] RDX: 1ffff1102336e748 RSI: 0000000000000246 RDI: ffffffffc0150a60
[   34.296246] RBP: 0000000000000003 R08: 0000000000000000 R09: ffffed10204bdf69
[   34.296891] R10: 0000000000000003 R11: ffff8881f7243858 R12: ffff8881077cfe00
[   34.297548] R13: ffff8881077cfc00 R14: ffff8881077cfe08 R15: ffff8881077cfe18
[   34.298198] FS:  0000000000000000(0000) GS:ffff888253a0a000(0000) knlGS:0000000000000000
[   34.298923] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   34.299475] CR2: 00005570bddc1690 CR3: 0000000105e8c006 CR4: 0000000000770ef0
[   34.300174] PKRU: 55555554
[   34.300454] Call Trace:
[   34.300699]  <TASK>
[   34.300915]  vmw_cmdbuf_man_process+0xe1/0x2b0 [vmwgfx]
[   34.301417]  ? __pfx_vmw_cmdbuf_man_process+0x10/0x10 [vmwgfx]
[   34.301970]  ? _raw_spin_lock+0x81/0xe0
[   34.302340]  ? __pfx__raw_spin_lock+0x10/0x10
[   34.302750]  ? __pfx___schedule+0x10/0x10
[   34.303126]  vmw_cmdbuf_irqthread+0x21/0x30 [vmwgfx]
[   34.303628]  vmw_thread_fn+0xcb/0xf0 [vmwgfx]
[   34.304075]  ? __pfx_vmw_thread_fn+0x10/0x10 [vmwgfx]
[   34.304565]  irq_thread_fn+0x87/0x150
[   34.304916]  irq_thread+0x394/0x600
[   34.305262]  ? __pfx_irq_thread_fn+0x10/0x10
[   34.305673]  ? __pfx_irq_thread+0x10/0x10
[   34.306057]  ? __pfx_irq_thread_dtor+0x10/0x10
[   34.306484]  ? __kthread_parkme+0x8d/0x170
[   34.306868]  ? __pfx_irq_thread+0x10/0x10
[   34.307248]  ? __pfx_irq_thread+0x10/0x10
[   34.307658]  kthread+0x325/0x420
[   34.307980]  ? recalc_sigpending+0x15d/0x1e0
[   34.308399]  ? __pfx_kthread+0x10/0x10
[   34.308753]  ret_from_fork+0x3de/0x770
[   34.309110]  ? __pfx_ret_from_fork+0x10/0x10
[   34.309530]  ? __switch_to+0x3ad/0xd80
[   34.309894]  ? __pfx_kthread+0x10/0x10
[   34.310264]  ret_from_fork_asm+0x1a/0x30
[   34.310653]  </TASK>
[   34.310876] ---[ end trace 0000000000000000 ]---
[   34.311666] [IGT] vmw_prime_sgtable: exiting, ret=0
[   34.312097] Console: switching to colour frame buffer device 160x50
=== END ===
