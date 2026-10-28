Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206747;
	b=zX4EdMBEPKBANDIBNP6hnXJr1MNaMXYbOyGafrn2Rfx5Z3PkvzSSZy6nYEaJV2Pnahrj
	 EQo0cC9OTCFobBo//gPVIxL6E+vBT5iiLrS1nIN6nLE3lzdPJTPGcdXMqeTxjiUnb0arm
	 wRgfAsHSw+KdkwOrH7BWrj3Ujt/GD37yLuhKShghJ/5BSMhJ6Ig1WA8f2DCjXcajTyLct
	 KbfYD2c0efv5Pdx+jm4Gidi2gvyC7Pst6QreH9SXVQ7SI2je3RFw8uWq/AgICx06AJmE4
	 YR/TC6Lj1wXheBF/zVaGE8121ufk0RI4yP1pYMjvklfzq0NxyL5AvWr5xErYgdpPMmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206747;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=0QmEvkChK37spu1VUsTWdmIof3MTFT0amdIT8WpeuEI=;
	b=NhRlmhrvCs+N+Im7LmIE+oR/9wSAheAtbreUbo7Ou8I2vmbGioVzEcLq8FoSuKuWe8ba
	 5zfRqC6rPUHky/qEX+dem558svxnGXjLFRlUqJrUtIrFRET9tQww3Fu+12K4F+/yVtk9f
	 28PSbzaM3iQb16Rd291JBFU7i+sXGYdnQ4jCUalYV7DIk65ZJjXvk+nXrwSuXv0ArgWKd
	 Vt3/tc620i+Pb9hzr6a3xv+jTVxKF4h7PNB4qXfvBe8xHG5mfDVymGpddAjqlhJoGMCqZ
	 I8TSC2bK6JtuIrgUDn0JGjd87y8/rTgNYOcQ/05parcEL9fES8pkmwRDBF2Rkjr93eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=hFWJ7P80;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2482A606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 16:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2482A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=hFWJ7P80
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso102613eec.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793206746; x=1793811546; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0QmEvkChK37spu1VUsTWdmIof3MTFT0amdIT8WpeuEI=;
        b=hFWJ7P80anfJUu1fpheKYYB2W6KaQwNhC89SsPapnLL9fjIyPhVStEWV7izb2k3rCt
         jDkgaWtQa2ovmPWBxO1LevfornrlRpwpRsMqDDyAmekD6KcbDHFu5rLHRxzkEx4ly9GG
         5dO5J5NzuAlrFXTsQ0cIw6rJLhaedWdWOMnAkGrpo6fJy9kn4HF/1Za4cx+7CQYNH6qT
         d1sqj1zVSTKn8+Y7184Iq5Yl3h6hChDvCvQSJevHXJc0U4tekoinNMPMrNJ7mMln6GbQ
         0ma8FS1KnG8sRn0+HZskpruOr+CbL/VPizjOs3bzzamrvR27VnPsROgeP+CJe8VKUIxJ
         cXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206746; x=1793811546;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0QmEvkChK37spu1VUsTWdmIof3MTFT0amdIT8WpeuEI=;
        b=ERzGrzWq8mBkKxtnxJdJfcEd5e6gU87HqfyVSKZA7+hIFgtx29eczeIEifulYQo5OF
         k+xTbA9H8lQOaMvOtnQWybUhlpCZLNLwgdQbNpKBDmMc6N0MpQJbABnoJ/R94IAcradA
         v8FSHknb9XndPapHqcatIRRTDEn1hTSPW++DCoPtx3LZlX/GVAGUnTrGoUXoFdtmhXiw
         amImhVTkdBLkQIG8Un09ynqD+Dxhioq4J+M6auYZ7kGDHoVcMMywp1dYVENb8wL+S6G5
         sKpKV0a/UgsaL7jPex8fQIaHrylDZK2UgwCyKZaA4Izj0nMfCKKOGVwvD+iD8102mmHF
         zEYA==
X-Gm-Message-State: AFq9FYLi+TL8jQQkQc7QVdkyd+qll2YiX49j5ME9WASYxsCpt7uHr/8a
	ONoZQXsRlIzhSb8cGf5LUDki8TstScoFLaKbNsLA5gN/+bMuUS80g2381nc6hBWU76RctQe+3aT
	RQRze
X-Gm-Gg: AYBFou0ETuagEOyUJvnTn/vA73hW28ttIXZ0jgTEgfdmAdB1KmhKpfO50Ea7nCMDqpD
	40vvogj450QoZ/i4fb9R2haFfFT0Xtb8meh3/1CdcZZe4+kAUhwXD/W5XM1N7NqMuvLwqJ4/Q0m
	DDbDlDwk03rkfy4BZGiyAhENNmLIUeUXXaq4wFfl9ZsL5EwNTueUmSkehu9MBLgJcVgYoCj+SN2
	xprXRR4JWkBLHbeVYTRY76zdl/lyg7VqWZG1YmKIJcUl7pOF2FbIYOKfoKKiZhv9zwlsVML5dn4
	d9os+AenJKvgP19QvhQ3d02vyFDPw8sGtAJjNpCycSd4k/4YENgk0YKMcBTWMFS9u6ADOi7bLS/
	FViVkxI3wyNdh/kJpe2BOm37GdUy8rJPuTo9thc7dfPNZfvY6ycCBYlbWdozempqdryle9oqvga
	XulaWTF5DEC2pqTNgQ/z07YXn0NKfINBn1l/qh+rVQ/QOgQFPHu7+GCUru6543C3+Rwvmiu4y15
	ht8DYO5SlmS8Dkb7z0T9TcTjTthue/vdDjcw2utB5SYq11yJnDk29qTV+YVvCKZM29ug6juGsny
	zz6TNu2XbB4Nop3RqFLxkA==
X-Received: by 2002:a05:7301:53c5:b0:359:2edc:e1d8 with SMTP id 5a478bee46e88-36a202bc380mr3554269eec.5.1793206745675;
        Wed, 28 Oct 2026 09:59:05 -0700 (PDT)
Received: from 4cb1f8191411 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2390929asm9810361eec.12.2026.10.28.09.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
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
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-5=2E15=2Ey=3A_=28build=29in_expan?=
 =?utf-8?q?sion_of_macro_=E2=80=98guard=E2=80=99_in_kernel/pid=5Fnamespace?=
 =?utf-8?q?=2Eo_=28kernel/pid=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 28 Oct 2026 16:59:05 -0000
Message-ID: <179320674431.41040.17815790876356165304@kernelci.org>

New build issue found on stable-rc/linux-5.15.y:

---
in expansion of macro ‘guard’ in kernel/pid_namespace.o (kernel/pid_namespace.c) [logspec:kbuild,kbuild.compiler.note]
---

Log excerpt:
=====================================================
kernel/pid_namespace.c:216:9: note: in expansion of macro ‘guard’
  216 |         guard(no_notify_signal)();
      |         ^~~~~
kernel/pid_namespace.c:216:9: error: cleanup argument not a function
  CC      mm/process_vm_access.o
./include/linux/cleanup.h:87:17: error: implicit declaration of function ‘class_no_notify_signal_constructor’ [-Werror=implicit-function-declaration]
   87 |                 class_##_name##_constructor
      |                 ^~~~~~
./include/linux/cleanup.h:109:9: note: in expansion of macro ‘CLASS’
  109 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
kernel/pid_namespace.c:216:9: note: in expansion of macro ‘guard’
  216 |         guard(no_notify_signal)();
      |         ^~~~~
./include/linux/cleanup.h:86:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
   86 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
      |         ^~~~~~
./include/linux/cleanup.h:109:9: note: in expansion of macro ‘CLASS’
  109 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
kernel/pid_namespace.c:216:9: note: in expansion of macro ‘guard’
  216 |         guard(no_notify_signal)();
      |         ^~~~~
./include/linux/compiler-gcc.h:42:45: warning: unused variable ‘__UNIQUE_ID_guard360’ [-Wunused-variable]
   42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
      |                                             ^~~~~~~~~~~~
./include/linux/cleanup.h:86:27: note: in definition of macro ‘CLASS’
   86 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
      |                           ^~~
././include/linux/compiler_types.h:60:22: note: in expansion of macro ‘___PASTE’
   60 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler-gcc.h:42:29: note: in expansion of macro ‘__PASTE’
   42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
      |                             ^~~~~~~
././include/linux/compiler_types.h:60:22: note: in expansion of macro ‘___PASTE’
   60 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler-gcc.h:42:37: note: in expansion of macro ‘__PASTE’
   42 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
      |                                     ^~~~~~~
./include/linux/cleanup.h:109:22: note: in expansion of macro ‘__UNIQUE_ID’
  109 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~
kernel/pid_namespace.c:216:9: note: in expansion of macro ‘guard’
  216 |         guard(no_notify_signal)();
      |         ^~~~~
cc1: some warnings being treated as errors

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:7479fbf682050c315966a9be6710f6fed3bca141
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  d13d47e9d31a6bab5dce791c8491d672dbb24627

# Builds where the incident occurred:

## 32r2el_defconfig on (mips):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-mips-32r2el_defconfig-6ae2280a5c0836a8c2f03e39/.config
- dashboard: https://d.kernelci.org/build/maestro:6ae2280a5c0836a8c2f03e39

#kernelci issue maestro:7479fbf682050c315966a9be6710f6fed3bca141

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
