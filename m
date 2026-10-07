Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E886A26E71F
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 04:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791348411; cv=none; b=XRRXiVZQvml2/0Aq8DsBv/kIQJx9gX33sJUTS5WuFzoegWTytZMTgB87sYjrjMtLBwkq3yftUC5lpwiKnTfTFnAjjVLer0wHKDJ1jxxaMm0JMvUr5FPl62j/WRvSBfn8Pk7S020Xe1oVxkH6oGjzbD9hotFznBoub60LBJPVJTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791348411; c=relaxed/simple;
	bh=ULtM/EDSkxgeufKgcVVFvOvcy5ZvEgu85u9jw4lKZjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uwi+0TizndLGa0G150HtKzBAnB8R/fCu8fZFIVfJiG8E8rR5kSuJVQh28Sx42CQrCR4HTGtZ8upAPbLdRNl/6JUAhiILGIQ4zcVauLWrYSkdnoldC00tgXvSHNBM3Hpcl33IXV8QozLqX/5zGtnAZ3goDsSbjVMt/0bhL0TyC+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bp4MoQCc; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bp4MoQCc"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a17baef589so9019175e9.0
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 21:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791348406; x=1791953206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nouk8+eWv33GH5dfBOte9xNDzv4xTLmcZ3dhjLsn4EY=;
        b=Bp4MoQCcuNC5ou0wtFImrikKXYTYCEaOaA3hYIN2haI8dw+mvgRdNFiR2U6FxuRq8G
         y1zHbhRMI2EUzEq4YXPUny3eJ0FPsny4F/wro6PmX4YQrgTOWPo5i1PQDwj2AzC6hzV2
         gTxkARuwZSD64CVjBvcA+NjmTY7ylzRb+wBkHGgc73Fm3XKuPEeIqD4Nl90aXIs/jMC1
         FDG+tnYlj6EigTwQIVplR+0S5yeQs2k6uMYXXi5m5OwTWeTYS9Q6FqAy9Anu161V1Eye
         5QIV7AiiFfVS/7Fb62x2B4UX7hCtkyoRK9XdDYj5lgJrkKSLZgftqMHgCXBGgQEw6Tv2
         uDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791348406; x=1791953206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nouk8+eWv33GH5dfBOte9xNDzv4xTLmcZ3dhjLsn4EY=;
        b=c8aVO3kwphGqma4er/RXNWx7FJ/9ZmOLwdpw7xKUTjpmiDiOXeayudfGl/THWsM0pY
         oX/vMDx6SUwWJoiiKB9p9/ZVJphJRBOYcvuwK3P4u6G4X0f1ORE/Ax8Qks3NT+dACcnZ
         abUvOf8gtcT9lD94a3Lsm3wh75RB6anQUF34E2nQkMZ9+AyxqQKDWqRSf2bAkgx46M43
         uJFPwFnTsCPB3h+RrpKaB2rRkObfIdGqMR+SMu5RASv6PrTediHxlNOib2rtS8SZWMIH
         uA6RDi9chhtMmlByc6ffJbzRdDm+ECTjFXYBwUyYAdLRxQkqMlZH0TyOPpn2OqjqKz1D
         OMzA==
X-Forwarded-Encrypted: i=1; AKwUvBwHWikJfYGiiInce++AQA3wPS2KLBu1ilVLn08hO5DhfD1PN+XQamiuDlCOK9tIyUgq61Hz6ns=@vger.kernel.org
X-Gm-Message-State: AFuF++nUV52je96af9ATtHZVyHIgVQsJjTjVNGlh+IJ11ccdA79TyaBM
	XSu+1NJOTNs5D/aoaEx8gCrtJxLrzGEaYybVjnfHfxfk4FAh7BI7lj2t
X-Gm-Gg: AYBFou0n/WBUus9e18FLmOckKiMZp93e/UDxO07uP7bhAp7QzEqkWKuIYsQsQoNry4/
	JzQoVws9HTlFKdPQZdcqtwCkI1rvKY3q02odVBW/5pHeEFKoU6q4ni/OeQYtvCEKul1OhcDKst1
	uTWHThZzp2Xvy86ll7Bx8+6RaN/k8/Q5zQstHDsUzYY6klZSd94sI+JNcwk/SNE8d4oXpStrABr
	Js0ixiUYUZW5q2j3ohJF0LLMKTneR837re+6mB/nfJ1Rmmm1jtY029YMLbUHQqkG42bUuv52kHa
	bQVmNCXNO/n/Tc4DWVUrNwB7nivKBuFNzYDZ2cI2znJYqD35i2+0Pgr+hy6mM6ejaxVltIBSn+v
	S8eXShCRb+fdWRM/pdSGlY/2je12KaerDgNLZsGQY00os+wba8dsCjAd+39UZsc9eC7rVcto8F1
	SbmsUMVMXdPyMtTz+vKUBaqYak9BRPoWHS9DhibxOPGkH2Wcq44vUb9+SIS59OrIQU6g==
X-Received: by 2002:a05:600c:8217:b0:4a1:74a1:7ecc with SMTP id 5b1f17b1804b1-4a1802dc728mr10704435e9.1.1791348405832;
        Tue, 06 Oct 2026 21:46:45 -0700 (PDT)
Received: from beelink.. ([212.23.215.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f557bcbsm48733715e9.9.2026.10.06.21.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 21:46:45 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: maaz.mombasawala@broadcom.com,
	zack.rusin@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org,
	christian.koenig@amd.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/vmwgfx: do not hand the embedded sg_table to the PRIME core [IGT full log - UNFIXED vmwgfx]
Date: Wed,  7 Oct 2026 01:46:25 -0300
Message-ID: <20261007044625.2168137-1-qwe.aldo@gmail.com>
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

=== IGT FULL LOG - UNFIXED vmwgfx (kernel 7.3.0-rc4+) ===
=== Kernel commit: 6edd14dd67d76d39a518ad3bf1a98363690a5a62 ===

===== vmw_execution_buffer =====
IGT-Version: 2.6-NO-GIT (x86_64) (Linux: 7.3.0-rc4+ x86_64)
Using IGT_SRANDOM=1791339031 for randomisation
Opened device: /dev/dri/renderD128
Starting subtest: mob-create-map
Subtest mob-create-map: SUCCESS (0.000s)
Starting subtest: buffer-create
Subtest buffer-create: SUCCESS (0.000s)
Starting subtest: execution-buffer-submit-sync
Subtest execution-buffer-submit-sync: SUCCESS (0.043s)

===== vmw_mob_stress =====
IGT-Version: 2.6-NO-GIT (x86_64) (Linux: 7.3.0-rc4+ x86_64)
Using IGT_SRANDOM=1791339031 for randomisation
Opened device: /dev/dri/renderD128
Starting subtest: max_mob_mem_stress
[1800.110260] (vmw_mob_stress:507) igt_vmwgfx-CRITICAL: Test assertion failure function vmw_triangle_assert_values, file ../lib/igt_vmwgfx.c:1309:
[1800.110277] (vmw_mob_stress:507) igt_vmwgfx-CRITICAL: Failed assertion: out_pixel[0] == 127
[1800.110281] (vmw_mob_stress:507) igt_vmwgfx-CRITICAL: Last errno: 2, No such file or directory
[1800.110282] (vmw_mob_stress:507) igt_vmwgfx-CRITICAL: error: 128 != 127
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
[1800.102037] (vmw_mob_stress:507) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1800.102095] (vmw_mob_stress:507) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1800.103017] (vmw_mob_stress:507) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1800.110260] (vmw_mob_stress:507) igt_vmwgfx-CRITICAL: Test assertion failure function vmw_triangle_assert_values, file ../lib/igt_vmwgfx.c:1309:
[1800.110277] (vmw_mob_stress:507) igt_vmwgfx-CRITICAL: Failed assertion: out_pixel[0] == 127
[1800.110281] (vmw_mob_stress:507) igt_vmwgfx-CRITICAL: Last errno: 2, No such file or directory
[1800.110282] (vmw_mob_stress:507) igt_vmwgfx-CRITICAL: error: 128 != 127
[1800.110679] (vmw_mob_stress:507) igt_core-INFO: Stack trace:
[1800.112293] (vmw_mob_stress:507) igt_core-INFO:   #0 ../lib/igt_core.c:2146 __igt_fail_assert()
[1800.112541] (vmw_mob_stress:507) igt_core-INFO:   #1 ../lib/igt_vmwgfx.c:1331 vmw_triangle_assert_values()
[1800.112658] (vmw_mob_stress:507) igt_core-INFO:   #2 ../tests/vmwgfx/vmw_mob_stress.c:44 __igt_unique____real_main48()
[1800.112666] (vmw_mob_stress:507) igt_core-INFO:   #3 ../tests/vmwgfx/vmw_mob_stress.c:48 main()
[1800.114232] (vmw_mob_stress:507) igt_core-INFO:   #4 [__libc_init_first+0x8a]
[1800.114588] (vmw_mob_stress:507) igt_core-INFO:   #5 [__libc_start_main+0x85]
[1800.114710] (vmw_mob_stress:507) igt_core-INFO:   #6 [_start+0x21]
****  END  ****
Subtest max_mob_mem_stress: FAIL (0.013s)

===== vmw_ref_count =====
IGT-Version: 2.6-NO-GIT (x86_64) (Linux: 7.3.0-rc4+ x86_64)
Using IGT_SRANDOM=1791339031 for randomisation
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
Subtest surface_buffer_prime_refs: SUCCESS (0.002s)

===== vmw_surface_copy =====
IGT-Version: 2.6-NO-GIT (x86_64) (Linux: 7.3.0-rc4+ x86_64)
Using IGT_SRANDOM=1791339031 for randomisation
Opened device: /dev/dri/renderD128
Starting subtest: test_invalid_copies
vmw_ioctl_command error Invalid argument.
vmw_ioctl_command error Invalid argument.
Subtest test_invalid_copies: SUCCESS (0.044s)
Starting subtest: test_invalid_copies_3d
Subtest test_invalid_copies_3d: SUCCESS (0.002s)

===== vmw_tri =====
IGT-Version: 2.6-NO-GIT (x86_64) (Linux: 7.3.0-rc4+ x86_64)
Using IGT_SRANDOM=1791339031 for randomisation
Opened device: /dev/dri/renderD128
Starting subtest: tri
[1800.277574] (vmw_tri:518) igt_vmwgfx-CRITICAL: Test assertion failure function vmw_triangle_assert_values, file ../lib/igt_vmwgfx.c:1309:
[1800.277594] (vmw_tri:518) igt_vmwgfx-CRITICAL: Failed assertion: out_pixel[0] == 127
[1800.277600] (vmw_tri:518) igt_vmwgfx-CRITICAL: Last errno: 2, No such file or directory
[1800.277602] (vmw_tri:518) igt_vmwgfx-CRITICAL: error: 128 != 127
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
[1800.267736] (vmw_tri:518) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(drm_fd)
[1800.267853] (vmw_tri:518) DEBUG: Test requirement passed: cid != SVGA3D_INVALID_ID
[1800.267866] (vmw_tri:518) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1800.268076] (vmw_tri:518) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1800.268947] (vmw_tri:518) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1800.277574] (vmw_tri:518) igt_vmwgfx-CRITICAL: Test assertion failure function vmw_triangle_assert_values, file ../lib/igt_vmwgfx.c:1309:
[1800.277594] (vmw_tri:518) igt_vmwgfx-CRITICAL: Failed assertion: out_pixel[0] == 127
[1800.277600] (vmw_tri:518) igt_vmwgfx-CRITICAL: Last errno: 2, No such file or directory
[1800.277602] (vmw_tri:518) igt_vmwgfx-CRITICAL: error: 128 != 127
[1800.278185] (vmw_tri:518) igt_core-INFO: Stack trace:
[1800.279302] (vmw_tri:518) igt_core-INFO:   #0 ../lib/igt_core.c:2146 __igt_fail_assert()
[1800.280572] (vmw_tri:518) igt_core-INFO:   #1 ../lib/igt_vmwgfx.c:1331 vmw_triangle_assert_values()
[1800.280931] (vmw_tri:518) igt_core-INFO:   #2 ../tests/vmwgfx/vmw_tri.c:51 __igt_unique____real_main183()
[1800.280954] (vmw_tri:518) igt_core-INFO:   #3 ../tests/vmwgfx/vmw_tri.c:183 main()
[1800.282657] (vmw_tri:518) igt_core-INFO:   #4 [__libc_init_first+0x8a]
[1800.283135] (vmw_tri:518) igt_core-INFO:   #5 [__libc_start_main+0x85]
[1800.283402] (vmw_tri:518) igt_core-INFO:   #6 [_start+0x21]
****  END  ****
Subtest tri: FAIL (0.016s)
Starting subtest: tri-no-sync-coherent
[1800.289286] (vmw_tri:518) igt_vmwgfx-CRITICAL: Test assertion failure function vmw_triangle_assert_values, file ../lib/igt_vmwgfx.c:1309:
[1800.289302] (vmw_tri:518) igt_vmwgfx-CRITICAL: Failed assertion: out_pixel[0] == 127
[1800.289305] (vmw_tri:518) igt_vmwgfx-CRITICAL: error: 128 != 127
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
[1800.284354] (vmw_tri:518) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(drm_fd)
[1800.284451] (vmw_tri:518) DEBUG: Test requirement passed: cid != SVGA3D_INVALID_ID
[1800.284455] (vmw_tri:518) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1800.284564] (vmw_tri:518) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1800.285413] (vmw_tri:518) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1800.285515] (vmw_tri:518) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1800.285813] (vmw_tri:518) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1800.289286] (vmw_tri:518) igt_vmwgfx-CRITICAL: Test assertion failure function vmw_triangle_assert_values, file ../lib/igt_vmwgfx.c:1309:
[1800.289302] (vmw_tri:518) igt_vmwgfx-CRITICAL: Failed assertion: out_pixel[0] == 127
[1800.289305] (vmw_tri:518) igt_vmwgfx-CRITICAL: error: 128 != 127
[1800.289723] (vmw_tri:518) igt_core-INFO: Stack trace:
[1800.290521] (vmw_tri:518) igt_core-INFO:   #0 ../lib/igt_core.c:2146 __igt_fail_assert()
[1800.290812] (vmw_tri:518) igt_core-INFO:   #1 ../lib/igt_vmwgfx.c:1331 vmw_triangle_assert_values()
[1800.291011] (vmw_tri:518) igt_core-INFO:   #2 ../tests/vmwgfx/vmw_tri.c:172 __igt_unique____real_main183()
[1800.291034] (vmw_tri:518) igt_core-INFO:   #3 ../tests/vmwgfx/vmw_tri.c:183 main()
[1800.291750] (vmw_tri:518) igt_core-INFO:   #4 [__libc_init_first+0x8a]
[1800.292262] (vmw_tri:518) igt_core-INFO:   #5 [__libc_start_main+0x85]
[1800.292468] (vmw_tri:518) igt_core-INFO:   #6 [_start+0x21]
****  END  ****
Subtest tri-no-sync-coherent: FAIL (0.008s)
Starting subtest: tri-2d
Subtest tri-2d: SUCCESS (0.003s)

===== vmw_prime =====
IGT-Version: 2.6-NO-GIT (x86_64) (Linux: 7.3.0-rc4+ x86_64)
Using IGT_SRANDOM=1791339031 for randomisation
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
[1800.369142] (vmw_prime:522) CRITICAL: Test assertion failure function draw_triangle_map_gem, file ../tests/vmwgfx/vmw_prime.c:123:
[1800.369155] (vmw_prime:522) CRITICAL: Failed assertion: save_status
Stack trace:
  #0 ../lib/igt_core.c:2146 __igt_fail_assert()
  #1 ../tests/vmwgfx/vmw_prime.c:500 __igt_unique____real_main508()
  #2 ../tests/vmwgfx/vmw_prime.c:508 main()
  #3 [__libc_init_first+0x8a]
  #4 [__libc_start_main+0x85]
  #5 [_start+0x21]
Subtest tri-map-gem failed.
**** DEBUG ****
[1800.332062] (vmw_prime:522) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1800.332112] (vmw_prime:522) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1800.368843] (vmw_prime:522) igt_vmwgfx-INFO: vmw_ioctl_command error Invalid argument.
[1800.368884] (vmw_prime:522) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1800.368936] (vmw_prime:522) igt_vmwgfx-INFO: vmw_ioctl_command error Invalid argument.
[1800.369032] (vmw_prime:522) igt_vmwgfx-INFO: vmw_ioctl_command error Invalid argument.
[1800.369142] (vmw_prime:522) CRITICAL: Test assertion failure function draw_triangle_map_gem, file ../tests/vmwgfx/vmw_prime.c:123:
[1800.369155] (vmw_prime:522) CRITICAL: Failed assertion: save_status
[1800.369553] (vmw_prime:522) igt_core-INFO: Stack trace:
[1800.370663] (vmw_prime:522) igt_core-INFO:   #0 ../lib/igt_core.c:2146 __igt_fail_assert()
[1800.370823] (vmw_prime:522) igt_core-INFO:   #1 ../tests/vmwgfx/vmw_prime.c:500 __igt_unique____real_main508()
[1800.370850] (vmw_prime:522) igt_core-INFO:   #2 ../tests/vmwgfx/vmw_prime.c:508 main()
[1800.372483] (vmw_prime:522) igt_core-INFO:   #3 [__libc_init_first+0x8a]
[1800.372843] (vmw_prime:522) igt_core-INFO:   #4 [__libc_start_main+0x85]
[1800.372951] (vmw_prime:522) igt_core-INFO:   #5 [_start+0x21]
****  END  ****
Subtest tri-map-gem: FAIL (0.041s)
Starting subtest: tri-map-dmabuf
vmw_ioctl_surface_ref Failed
vmw_ioctl_command error Invalid argument.
vmw_ioctl_command error Invalid argument.
vmw_ioctl_fence_finish Failed
vmw_ioctl_command error Invalid argument.
vmw_ioctl_fence_finish Failed
vmw_ioctl_mob_map: Map failed.
[1800.411443] (vmw_prime:522) CRITICAL: Test assertion failure function draw_triangle_map_dmabuf, file ../tests/vmwgfx/vmw_prime.c:160:
[1800.411445] (vmw_prime:522) CRITICAL: Failed assertion: save_status
[1800.411446] (vmw_prime:522) CRITICAL: Last errno: 22, Invalid argument
Stack trace:
  #0 ../lib/igt_core.c:2146 __igt_fail_assert()
  #1 ../tests/vmwgfx/vmw_prime.c:520 __igt_unique____real_main508()
  #2 ../tests/vmwgfx/vmw_prime.c:508 main()
  #3 [__libc_init_first+0x8a]
  #4 [__libc_start_main+0x85]
  #5 [_start+0x21]
Subtest tri-map-dmabuf failed.
**** DEBUG ****
[1800.373580] (vmw_prime:522) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1800.373616] (vmw_prime:522) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1800.411278] (vmw_prime:522) igt_vmwgfx-INFO: vmw_ioctl_command error Invalid argument.
[1800.411306] (vmw_prime:522) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(fd)
[1800.411353] (vmw_prime:522) igt_vmwgfx-INFO: vmw_ioctl_command error Invalid argument.
[1800.411397] (vmw_prime:522) igt_vmwgfx-INFO: vmw_ioctl_command error Invalid argument.
[1800.411443] (vmw_prime:522) CRITICAL: Test assertion failure function draw_triangle_map_dmabuf, file ../tests/vmwgfx/vmw_prime.c:160:
[1800.411445] (vmw_prime:522) CRITICAL: Failed assertion: save_status
[1800.411446] (vmw_prime:522) CRITICAL: Last errno: 22, Invalid argument
[1800.411830] (vmw_prime:522) igt_core-INFO: Stack trace:
[1800.412547] (vmw_prime:522) igt_core-INFO:   #0 ../lib/igt_core.c:2146 __igt_fail_assert()
[1800.412779] (vmw_prime:522) igt_core-INFO:   #1 ../tests/vmwgfx/vmw_prime.c:520 __igt_unique____real_main508()
[1800.412861] (vmw_prime:522) igt_core-INFO:   #2 ../tests/vmwgfx/vmw_prime.c:508 main()
[1800.413482] (vmw_prime:522) igt_core-INFO:   #3 [__libc_init_first+0x8a]
[1800.413798] (vmw_prime:522) igt_core-INFO:   #4 [__libc_start_main+0x85]
[1800.413953] (vmw_prime:522) igt_core-INFO:   #5 [_start+0x21]
****  END  ****
Subtest tri-map-dmabuf: FAIL (0.041s)
Starting subtest: draw-dumb-buffer
vmw_ioctl_surface_ref Failed
[1800.448784] (vmw_prime:522) CRITICAL: Test assertion failure function prepare_crtc_surface, file ../tests/vmwgfx/vmw_prime.c:250:
[1800.448787] (vmw_prime:522) CRITICAL: Failed assertion: (__kms_addfb(gpu->fb.fd, gpu->fb_surface->base.handle, gpu->fb.width, gpu->fb.height, gpu->fb.drm_format, gpu->fb.modifier, gpu->fb.strides, gpu->fb.offsets, gpu->fb.num_planes, 0, &gpu->fb.fb_id)) == 0
[1800.448789] (vmw_prime:522) CRITICAL: Last errno: 22, Invalid argument
Stack trace:
  #0 ../lib/igt_core.c:2146 __igt_fail_assert()
  #1 ../tests/vmwgfx/vmw_prime.c:242 __igt_unique____real_main508()
  #2 ../tests/vmwgfx/vmw_prime.c:508 main()
  #3 [__libc_init_first+0x8a]
  #4 [__libc_start_main+0x85]
  #5 [_start+0x21]
Subtest draw-dumb-buffer failed.
**** DEBUG ****
[1800.414404] (vmw_prime:522) igt_vmwgfx-DEBUG: Test requirement passed: vmw_supports_3d(drm_fd)
[1800.414451] (vmw_prime:522) igt_kms-DEBUG: display: Virtual-1: set_crtc(A)
[1800.414506] (vmw_prime:522) igt_kms-DEBUG: display: Virtual-1: Selecting CRTC A
[1800.414524] (vmw_prime:522) igt_fb-DEBUG: igt_create_fb_with_bo_size(width=1280, height=800, format=XR24(0x34325258), modifier=0x0, size=0)
[1800.414611] (vmw_prime:522) igt_fb-DEBUG: igt_create_fb_with_bo_size(handle=2, pitch=5120)
[1800.414615] (vmw_prime:522) ioctl_wrappers-DEBUG: Test requirement passed: igt_has_fb_modifiers(fd)
[1800.414661] (vmw_prime:522) igt_fb-DEBUG: Test requirement passed: cairo_surface_status(fb->cairo_surface) == CAIRO_STATUS_SUCCESS
[1800.448784] (vmw_prime:522) CRITICAL: Test assertion failure function prepare_crtc_surface, file ../tests/vmwgfx/vmw_prime.c:250:
[1800.448787] (vmw_prime:522) CRITICAL: Failed assertion: (__kms_addfb(gpu->fb.fd, gpu->fb_surface->base.handle, gpu->fb.width, gpu->fb.height, gpu->fb.drm_format, gpu->fb.modifier, gpu->fb.strides, gpu->fb.offsets, gpu->fb.num_planes, 0, &gpu->fb.fb_id)) == 0
[1800.448789] (vmw_prime:522) CRITICAL: Last errno: 22, Invalid argument
[1800.449070] (vmw_prime:522) igt_core-INFO: Stack trace:
[1800.449652] (vmw_prime:522) igt_core-INFO:   #0 ../lib/igt_core.c:2146 __igt_fail_assert()
[1800.449777] (vmw_prime:522) igt_core-INFO:   #1 ../tests/vmwgfx/vmw_prime.c:242 __igt_unique____real_main508()
[1800.449784] (vmw_prime:522) igt_core-INFO:   #2 ../tests/vmwgfx/vmw_prime.c:508 main()
[1800.450320] (vmw_prime:522) igt_core-INFO:   #3 [__libc_init_first+0x8a]
[1800.450639] (vmw_prime:522) igt_core-INFO:   #4 [__libc_start_main+0x85]
[1800.450758] (vmw_prime:522) igt_core-INFO:   #5 [_start+0x21]
****  END  ****
Subtest draw-dumb-buffer: FAIL (0.037s)
Starting subtest: buffer-surface-fb-sharing-sync-readback
[1800.455256] (vmw_prime:522) igt_pipe_crc-CRITICAL: Test assertion failure function igt_pipe_crc_start, file ../lib/igt_pipe_crc.c:416:
[1800.455270] (vmw_prime:522) igt_pipe_crc-CRITICAL: Failed assertion: write(pipe_crc->ctl_fd, src, strlen(src)) == strlen(src)
[1800.455272] (vmw_prime:522) igt_pipe_crc-CRITICAL: Last errno: 22, Invalid argument
[1800.455273] (vmw_prime:522) igt_pipe_crc-CRITICAL: error: -1 != 4
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
[1800.451402] (vmw_prime:522) igt_kms-DEBUG: display: Virtual-1: set_crtc(A)
[1800.451462] (vmw_prime:522) igt_kms-DEBUG: display: Virtual-1: Selecting CRTC A
[1800.451475] (vmw_prime:522) igt_fb-DEBUG: igt_create_fb_with_bo_size(width=1280, height=800, format=XR24(0x34325258), modifier=0x0, size=0)
[1800.451619] (vmw_prime:522) igt_fb-DEBUG: igt_create_fb_with_bo_size(handle=3, pitch=5120)
[1800.451622] (vmw_prime:522) ioctl_wrappers-DEBUG: Test requirement passed: igt_has_fb_modifiers(fd)
[1800.451645] (vmw_prime:522) igt_fb-DEBUG: Test requirement passed: cairo_surface_status(fb->cairo_surface) == CAIRO_STATUS_SUCCESS
[1800.454258] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.454259] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.454261] (vmw_prime:522) igt_kms-DEBUG: display: A.0: plane_set_fb(113)
[1800.454263] (vmw_prime:522) igt_kms-DEBUG: display: A.0: plane_set_size (1280x800)
[1800.454264] (vmw_prime:522) igt_kms-DEBUG: display: A.0: fb_set_position(0,0)
[1800.454265] (vmw_prime:522) igt_kms-DEBUG: display: A.0: fb_set_size(1280x800)
[1800.454268] (vmw_prime:522) igt_kms-DEBUG: display: commit {
[1800.454305] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.454306] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.454306] (vmw_prime:522) igt_kms-DEBUG: display:     Virtual-1: SetCrtc pipe A, fb 113, src (0, 0), mode 1280x800
[1800.454546] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.454548] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.454548] (vmw_prime:522) igt_kms-DEBUG: display:     SetCursor pipe A, disabling
[1800.454579] (vmw_prime:522) igt_kms-DEBUG: display:     MoveCursor pipe A, (0, 0)
[1800.454622] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.454623] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.454623] (vmw_prime:522) igt_kms-DEBUG: display:     SetCrtc pipe B, disabling
[1800.454653] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.454653] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.454654] (vmw_prime:522) igt_kms-DEBUG: display:     SetCursor pipe B, disabling
[1800.454671] (vmw_prime:522) igt_kms-DEBUG: display:     MoveCursor pipe B, (0, 0)
[1800.454704] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.454705] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.454705] (vmw_prime:522) igt_kms-DEBUG: display:     SetCrtc pipe C, disabling
[1800.454730] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.454731] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.454731] (vmw_prime:522) igt_kms-DEBUG: display:     SetCursor pipe C, disabling
[1800.454747] (vmw_prime:522) igt_kms-DEBUG: display:     MoveCursor pipe C, (0, 0)
[1800.454779] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.454780] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.454780] (vmw_prime:522) igt_kms-DEBUG: display:     SetCrtc pipe D, disabling
[1800.454807] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.454807] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.454808] (vmw_prime:522) igt_kms-DEBUG: display:     SetCursor pipe D, disabling
[1800.454825] (vmw_prime:522) igt_kms-DEBUG: display:     MoveCursor pipe D, (0, 0)
[1800.454857] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.454858] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.454858] (vmw_prime:522) igt_kms-DEBUG: display:     SetCrtc pipe E, disabling
[1800.454881] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.454882] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.454882] (vmw_prime:522) igt_kms-DEBUG: display:     SetCursor pipe E, disabling
[1800.454898] (vmw_prime:522) igt_kms-DEBUG: display:     MoveCursor pipe E, (0, 0)
[1800.454930] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.454931] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.454931] (vmw_prime:522) igt_kms-DEBUG: display:     SetCrtc pipe F, disabling
[1800.454954] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.454954] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.454955] (vmw_prime:522) igt_kms-DEBUG: display:     SetCursor pipe F, disabling
[1800.454970] (vmw_prime:522) igt_kms-DEBUG: display:     MoveCursor pipe F, (0, 0)
[1800.455004] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.455004] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.455005] (vmw_prime:522) igt_kms-DEBUG: display:     SetCrtc pipe G, disabling
[1800.455026] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.455027] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.455027] (vmw_prime:522) igt_kms-DEBUG: display:     SetCursor pipe G, disabling
[1800.455042] (vmw_prime:522) igt_kms-DEBUG: display:     MoveCursor pipe G, (0, 0)
[1800.455074] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.455074] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.455075] (vmw_prime:522) igt_kms-DEBUG: display:     SetCrtc pipe H, disabling
[1800.455099] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.455100] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.455100] (vmw_prime:522) igt_kms-DEBUG: display:     SetCursor pipe H, disabling
[1800.455118] (vmw_prime:522) igt_kms-DEBUG: display:     MoveCursor pipe H, (0, 0)
[1800.455134] (vmw_prime:522) igt_kms-DEBUG: display: }
[1800.455256] (vmw_prime:522) igt_pipe_crc-CRITICAL: Test assertion failure function igt_pipe_crc_start, file ../lib/igt_pipe_crc.c:416:
[1800.455270] (vmw_prime:522) igt_pipe_crc-CRITICAL: Failed assertion: write(pipe_crc->ctl_fd, src, strlen(src)) == strlen(src)
[1800.455272] (vmw_prime:522) igt_pipe_crc-CRITICAL: Last errno: 22, Invalid argument
[1800.455273] (vmw_prime:522) igt_pipe_crc-CRITICAL: error: -1 != 4
[1800.455557] (vmw_prime:522) igt_core-INFO: Stack trace:
[1800.456377] (vmw_prime:522) igt_core-INFO:   #0 ../lib/igt_core.c:2146 __igt_fail_assert()
[1800.456490] (vmw_prime:522) igt_core-INFO:   #1 ../lib/igt_pipe_crc.c:422 igt_pipe_crc_start()
[1800.456556] (vmw_prime:522) igt_core-INFO:   #2 ../lib/igt_pipe_crc.c:627 igt_pipe_crc_collect_crc()
[1800.456738] (vmw_prime:522) igt_core-INFO:   #3 ../tests/vmwgfx/vmw_prime.c:307 draw_triangle_3d()
[1800.456757] (vmw_prime:522) igt_core-INFO:   #4 ../tests/vmwgfx/vmw_prime.c:545 __igt_unique____real_main508()
[1800.456762] (vmw_prime:522) igt_core-INFO:   #5 ../tests/vmwgfx/vmw_prime.c:508 main()
[1800.457374] (vmw_prime:522) igt_core-INFO:   #6 [__libc_init_first+0x8a]
[1800.457744] (vmw_prime:522) igt_core-INFO:   #7 [__libc_start_main+0x85]
[1800.457884] (vmw_prime:522) igt_core-INFO:   #8 [_start+0x21]
****  END  ****
Subtest buffer-surface-fb-sharing-sync-readback: FAIL (0.007s)
Starting subtest: buffer-surface-fb-sharing-sync
[1800.461596] (vmw_prime:522) igt_pipe_crc-CRITICAL: Test assertion failure function igt_pipe_crc_start, file ../lib/igt_pipe_crc.c:416:
[1800.461608] (vmw_prime:522) igt_pipe_crc-CRITICAL: Failed assertion: write(pipe_crc->ctl_fd, src, strlen(src)) == strlen(src)
[1800.461611] (vmw_prime:522) igt_pipe_crc-CRITICAL: Last errno: 22, Invalid argument
[1800.461612] (vmw_prime:522) igt_pipe_crc-CRITICAL: error: -1 != 4
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
[1800.458295] (vmw_prime:522) igt_kms-DEBUG: display: Virtual-1: set_crtc(A)
[1800.458353] (vmw_prime:522) igt_kms-DEBUG: display: Virtual-1: Selecting CRTC A
[1800.458365] (vmw_prime:522) igt_fb-DEBUG: igt_create_fb_with_bo_size(width=1280, height=800, format=XR24(0x34325258), modifier=0x0, size=0)
[1800.458474] (vmw_prime:522) igt_fb-DEBUG: igt_create_fb_with_bo_size(handle=4, pitch=5120)
[1800.458477] (vmw_prime:522) ioctl_wrappers-DEBUG: Test requirement passed: igt_has_fb_modifiers(fd)
[1800.458509] (vmw_prime:522) igt_fb-DEBUG: Test requirement passed: cairo_surface_status(fb->cairo_surface) == CAIRO_STATUS_SUCCESS
[1800.461286] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.461287] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.461288] (vmw_prime:522) igt_kms-DEBUG: display: A.0: plane_set_fb(114)
[1800.461289] (vmw_prime:522) igt_kms-DEBUG: display: A.0: plane_set_size (1280x800)
[1800.461290] (vmw_prime:522) igt_kms-DEBUG: display: A.0: fb_set_position(0,0)
[1800.461291] (vmw_prime:522) igt_kms-DEBUG: display: A.0: fb_set_size(1280x800)
[1800.461292] (vmw_prime:522) igt_kms-DEBUG: display: commit {
[1800.461292] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.461293] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.461294] (vmw_prime:522) igt_kms-DEBUG: display:     Virtual-1: SetCrtc pipe A, fb 114, src (0, 0), mode 1280x800
[1800.461498] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.461499] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.461500] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.461501] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.461502] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.461502] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.461503] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.461503] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.461505] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.461505] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.461506] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.461506] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.461507] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.461507] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.461508] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.461508] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.461509] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.461509] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.461510] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.461510] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.461511] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.461512] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.461512] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.461513] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.461513] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.461514] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.461514] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.461515] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.461515] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.461516] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.461516] (vmw_prime:522) igt_kms-DEBUG: display: }
[1800.461596] (vmw_prime:522) igt_pipe_crc-CRITICAL: Test assertion failure function igt_pipe_crc_start, file ../lib/igt_pipe_crc.c:416:
[1800.461608] (vmw_prime:522) igt_pipe_crc-CRITICAL: Failed assertion: write(pipe_crc->ctl_fd, src, strlen(src)) == strlen(src)
[1800.461611] (vmw_prime:522) igt_pipe_crc-CRITICAL: Last errno: 22, Invalid argument
[1800.461612] (vmw_prime:522) igt_pipe_crc-CRITICAL: error: -1 != 4
[1800.461902] (vmw_prime:522) igt_core-INFO: Stack trace:
[1800.462479] (vmw_prime:522) igt_core-INFO:   #0 ../lib/igt_core.c:2146 __igt_fail_assert()
[1800.462588] (vmw_prime:522) igt_core-INFO:   #1 ../lib/igt_pipe_crc.c:422 igt_pipe_crc_start()
[1800.462652] (vmw_prime:522) igt_core-INFO:   #2 ../lib/igt_pipe_crc.c:627 igt_pipe_crc_collect_crc()
[1800.462811] (vmw_prime:522) igt_core-INFO:   #3 ../tests/vmwgfx/vmw_prime.c:307 draw_triangle_3d()
[1800.462827] (vmw_prime:522) igt_core-INFO:   #4 ../tests/vmwgfx/vmw_prime.c:552 __igt_unique____real_main508()
[1800.462833] (vmw_prime:522) igt_core-INFO:   #5 ../tests/vmwgfx/vmw_prime.c:508 main()
[1800.463376] (vmw_prime:522) igt_core-INFO:   #6 [__libc_init_first+0x8a]
[1800.463875] (vmw_prime:522) igt_core-INFO:   #7 [__libc_start_main+0x85]
[1800.464036] (vmw_prime:522) igt_core-INFO:   #8 [_start+0x21]
****  END  ****
Subtest buffer-surface-fb-sharing-sync: FAIL (0.006s)
Starting subtest: buffer-surface-fb-sharing
[1800.467715] (vmw_prime:522) igt_pipe_crc-CRITICAL: Test assertion failure function igt_pipe_crc_start, file ../lib/igt_pipe_crc.c:416:
[1800.467727] (vmw_prime:522) igt_pipe_crc-CRITICAL: Failed assertion: write(pipe_crc->ctl_fd, src, strlen(src)) == strlen(src)
[1800.467729] (vmw_prime:522) igt_pipe_crc-CRITICAL: Last errno: 22, Invalid argument
[1800.467730] (vmw_prime:522) igt_pipe_crc-CRITICAL: error: -1 != 4
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
[1800.464501] (vmw_prime:522) igt_kms-DEBUG: display: Virtual-1: set_crtc(A)
[1800.464547] (vmw_prime:522) igt_kms-DEBUG: display: Virtual-1: Selecting CRTC A
[1800.464558] (vmw_prime:522) igt_fb-DEBUG: igt_create_fb_with_bo_size(width=1280, height=800, format=XR24(0x34325258), modifier=0x0, size=0)
[1800.464654] (vmw_prime:522) igt_fb-DEBUG: igt_create_fb_with_bo_size(handle=5, pitch=5120)
[1800.464657] (vmw_prime:522) ioctl_wrappers-DEBUG: Test requirement passed: igt_has_fb_modifiers(fd)
[1800.464680] (vmw_prime:522) igt_fb-DEBUG: Test requirement passed: cairo_surface_status(fb->cairo_surface) == CAIRO_STATUS_SUCCESS
[1800.467412] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.467414] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.467414] (vmw_prime:522) igt_kms-DEBUG: display: A.0: plane_set_fb(115)
[1800.467415] (vmw_prime:522) igt_kms-DEBUG: display: A.0: plane_set_size (1280x800)
[1800.467416] (vmw_prime:522) igt_kms-DEBUG: display: A.0: fb_set_position(0,0)
[1800.467417] (vmw_prime:522) igt_kms-DEBUG: display: A.0: fb_set_size(1280x800)
[1800.467418] (vmw_prime:522) igt_kms-DEBUG: display: commit {
[1800.467419] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.467420] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.467420] (vmw_prime:522) igt_kms-DEBUG: display:     Virtual-1: SetCrtc pipe A, fb 115, src (0, 0), mode 1280x800
[1800.467617] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.467619] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.467620] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.467620] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.467621] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.467621] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.467623] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.467623] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.467624] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.467624] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.467625] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.467625] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.467626] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.467627] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.467627] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.467628] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.467628] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.467629] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.467630] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.467630] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.467631] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.467632] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.467632] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.467633] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.467634] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.467634] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.467635] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.467635] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.467636] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: plane_idx >= 0 && plane_idx < crtc->n_planes
[1800.467636] (vmw_prime:522) igt_kms-DEBUG: Test requirement passed: crtc->planes[plane_idx].type == plane_type
[1800.467637] (vmw_prime:522) igt_kms-DEBUG: display: }
[1800.467715] (vmw_prime:522) igt_pipe_crc-CRITICAL: Test assertion failure function igt_pipe_crc_start, file ../lib/igt_pipe_crc.c:416:
[1800.467727] (vmw_prime:522) igt_pipe_crc-CRITICAL: Failed assertion: write(pipe_crc->ctl_fd, src, strlen(src)) == strlen(src)
[1800.467729] (vmw_prime:522) igt_pipe_crc-CRITICAL: Last errno: 22, Invalid argument
[1800.467730] (vmw_prime:522) igt_pipe_crc-CRITICAL: error: -1 != 4
[1800.467980] (vmw_prime:522) igt_core-INFO: Stack trace:
[1800.468502] (vmw_prime:522) igt_core-INFO:   #0 ../lib/igt_core.c:2146 __igt_fail_assert()
[1800.468585] (vmw_prime:522) igt_core-INFO:   #1 ../lib/igt_pipe_crc.c:422 igt_pipe_crc_start()
[1800.468631] (vmw_prime:522) igt_core-INFO:   #2 ../lib/igt_pipe_crc.c:627 igt_pipe_crc_collect_crc()
[1800.468749] (vmw_prime:522) igt_core-INFO:   #3 ../tests/vmwgfx/vmw_prime.c:307 draw_triangle_3d()
[1800.468753] (vmw_prime:522) igt_core-INFO:   #4 ../tests/vmwgfx/vmw_prime.c:557 __igt_unique____real_main508()
[1800.468759] (vmw_prime:522) igt_core-INFO:   #5 ../tests/vmwgfx/vmw_prime.c:508 main()
[1800.469291] (vmw_prime:522) igt_core-INFO:   #6 [__libc_init_first+0x8a]
[1800.469635] (vmw_prime:522) igt_core-INFO:   #7 [__libc_start_main+0x85]
[1800.469772] (vmw_prime:522) igt_core-INFO:   #8 [_start+0x21]
****  END  ****
Subtest buffer-surface-fb-sharing: FAIL (0.006s)
Opened device: /dev/dri/card1
Starting subtest: basic-vgem
Subtest basic-vgem: SUCCESS (0.001s)

=== New IGT subtest (vmw_prime_sgtable) with dmesg ===

Rebooting with UNFIXED...
alive
VM up
=== IGT TESTCASE: UNFIXED vmwgfx  ===
IGT-Version: 2.6-NO-GIT (x86_64) (Linux: 7.3.0-rc4+ x86_64)
Using IGT_SRANDOM=1791343583 for randomisation
Starting subtest: sgtable-invalid-free
Subtest sgtable-invalid-free: SUCCESS (0.001s)
=== FULL DMESG AFTER TEST ===
[ 6355.323263] Console: switching to colour dummy device 80x25
[ 6355.323331] [IGT] vmw_prime_sgtable: executing
[ 6355.327240] [IGT] vmw_prime_sgtable: starting subtest sgtable-invalid-free
[ 6355.328534] [IGT] vmw_prime_sgtable: finished subtest sgtable-invalid-free, SUCCESS
[ 6355.329152] [IGT] vmw_prime_sgtable: exiting, ret=0
[ 6355.329600] Console: switching to colour frame buffer device 160x50
[ 6355.331267] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#4] SMP KASAN NOPTI
[ 6355.332337] KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
[ 6355.333074] CPU: 1 UID: 0 PID: 812 Comm: kworker/u23:1 Tainted: G    B D W  OE       7.3.0-rc4+ #17 PREEMPT(lazy) 
[ 6355.334054] Tainted: [B]=BAD_PAGE, [D]=DIE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[ 6355.334824] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/17/2026
[ 6355.335839] Workqueue: ttm ttm_bo_delayed_delete [ttm]
[ 6355.336350] RIP: 0010:dma_direct_unmap_sg+0xb9/0x870
[ 6355.336838] Code: 85 ca 04 00 00 48 8b 43 20 48 89 c3 48 83 e3 fc a8 01 48 0f 44 dd 45 39 ef 0f 84 48 02 00 00 48 8d 7b 1c 48 89 f8 48 c1 e8 03 <42> 0f b6 14 20 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85
[ 6355.338548] RSP: 0018:ffff8881060d7b38 EFLAGS: 00010207
[ 6355.339053] RAX: 0000000000000003 RBX: 0000000000000000 RCX: ffffed102071c469
[ 6355.339733] RDX: 1ffff1102071c469 RSI: ffff8881038e2348 RDI: 000000000000001c
[ 6355.340415] RBP: ffff88810c9f436c R08: 0000000000000000 R09: ffffed102071c47b
[ 6355.341096] R10: ffff8881038e20d0 R11: 00000000cc4dc460 R12: dffffc0000000000
[ 6355.341780] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
[ 6355.342455] FS:  0000000000000000(0000) GS:ffff88826ac8a000(0000) knlGS:0000000000000000
[ 6355.343212] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6355.343737] CR2: 00005583d8efb1c8 CR3: 0000000120cdb006 CR4: 0000000000770ef0
[ 6355.344396] PKRU: 55555554
[ 6355.344663] Call Trace:
[ 6355.344904]  <TASK>
[ 6355.345118]  ? kasan_save_track+0x10/0x30
[ 6355.345504]  ? dma_unmap_sg_attrs+0x73/0x2c0
[ 6355.345905]  vmw_ttm_unmap_dma+0x164/0x290 [vmwgfx]
[ 6355.346373]  vmw_ttm_unpopulate+0xcd/0x120 [vmwgfx]
[ 6355.347169]  ttm_tt_unpopulate+0xa0/0x2a0 [ttm]
[ 6355.347943]  ? _raw_spin_lock_irqsave+0x92/0xf0
[ 6355.348699]  ttm_bo_cleanup_memtype_use+0xe5/0x1e0 [ttm]
[ 6355.349519]  ttm_bo_delayed_delete+0x68/0xf0 [ttm]
[ 6355.350305]  process_one_work+0x738/0x11a0
[ 6355.351017]  ? move_linked_works+0x12c/0x2a0
[ 6355.351761]  ? __pfx_process_one_work+0x10/0x10
[ 6355.352517]  ? _raw_spin_lock_irq+0x87/0xf0
[ 6355.353218]  ? __pfx_ttm_bo_delayed_delete+0x10/0x10 [ttm]
[ 6355.354051]  ? assign_work+0x122/0x3e0
[ 6355.354732]  worker_thread+0x53a/0xf50
[ 6355.355432]  ? __pfx_worker_thread+0x10/0x10
[ 6355.356153]  kthread+0x325/0x420
[ 6355.356788]  ? recalc_sigpending+0x15d/0x1e0
[ 6355.357517]  ? __pfx_kthread+0x10/0x10
[ 6355.358185]  ret_from_fork+0x3de/0x770
[ 6355.358855]  ? __pfx_ret_from_fork+0x10/0x10
[ 6355.359580]  ? __switch_to+0x3ad/0xd80
[ 6355.360238]  ? __pfx_kthread+0x10/0x10
[ 6355.360894]  ret_from_fork_asm+0x1a/0x30
[ 6355.361569]  </TASK>
[ 6355.362087] Modules linked in: vmwgfx(OE) drm_client_lib(OE) drm_ttm_helper(OE) ttm(OE) vgem(OE) drm_shmem_helper(OE) drm_kms_helper(OE) e1000(E) [last unloaded: ttm(OE)]
[ 6355.364125] ---[ end trace 0000000000000000 ]---
[ 6355.368262] RIP: 0010:dma_direct_unmap_sg+0xb9/0x870
[ 6355.368662] Code: 85 ca 04 00 00 48 8b 43 20 48 89 c3 48 83 e3 fc a8 01 48 0f 44 dd 45 39 ef 0f 84 48 02 00 00 48 8d 7b 1c 48 89 f8 48 c1 e8 03 <42> 0f b6 14 20 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85
[ 6355.369377] RSP: 0018:ffff88810ac77b38 EFLAGS: 00010207
[ 6355.370112] RAX: 0000000000000003 RBX: 0000000000000000 RCX: ffffed102071c469
[ 6355.370452] RDX: 1ffff1102071c469 RSI: ffff8881038e2348 RDI: 000000000000001c
[ 6355.370757] RBP: ffff88810af3996c R08: 0000000000000000 R09: ffffed102071c47b
[ 6355.371124] R10: ffff8881038e20d0 R11: 00000000cc4dc460 R12: dffffc0000000000
[ 6355.371467] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
[ 6355.371800] FS:  0000000000000000(0000) GS:ffff88826ad8a000(0000) knlGS:0000000000000000
[ 6355.372092] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6355.372412] CR2: 00007f84493510a0 CR3: 0000000174c50006 CR4: 0000000000770ef0
[ 6355.372709] PKRU: 55555554
