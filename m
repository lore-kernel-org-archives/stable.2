Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206753;
	b=4HslFUK9Wt841wBW1ZDcFhRNg+AU6n1QkOd7IfrVynl09CsiqEEaikB5qM6wuhjMjYlS
	 vOj9aPb9mKl2DHTogD8xxU+Jl3L/FShKpZQUb1AB4CUHwPW6MJm6C58/b15PSq1uEDVsd
	 fJBScceRr33fM1JK8w6VA3bm6N0KfrmUtTSTxIHdSiLbkG0VvrJy7iQClEUR9bM5O3kRV
	 l6C2k7D/yTzSlPP1Iul71m4wUymXElT6CV3ygUGNhk90088s2ov8v9lgS8/xLSqyuWkc+
	 PvpmRA78wYDLDI4ny6rpef7eep0N0b9luNp0P9T47fc6SILnliqn01xq4nE8xRKIlfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206753;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=VlSHawmaYo7XEDZt0W9ICjjdKVeHjZOaaru3Hu2UpII=;
	b=LVBS8gcgKbB40iYG9fdsp1CudvPiuwEqO6lpgdRbjxS2vf6rv+8ANB3A3ARFesu+d9WS
	 lTwviaeiagxvOZHg/tyYuNUl6kjecTxmuH1rTxGLdu+CXiREEA32ipAYGMRXFeGFGQW4U
	 M8eZh3OAWfWsgkwf1o+TY/Vu9R20r2/5iMIls/PPncSKPZLapMe4ZJVEjQNSealAYa0xe
	 jSRSx6aPhyDSWjhLwFIt0R0DByZGR1LCZx7XjZ7VUr/wrA0c0NBAFZrg7L2r0KmzEcISI
	 9FMjNcmKADTjaLWNnddfVKVRNSZDgfNTqxd04Q6Paq/hWcmza5PTqyIUKuqDoVHaazA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=NYigLMLl;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FB5606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 16:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08FB5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=NYigLMLl
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so1857838eec.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793206752; x=1793811552; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VlSHawmaYo7XEDZt0W9ICjjdKVeHjZOaaru3Hu2UpII=;
        b=NYigLMLlhpniNVmS5nkuy7gl7KzcT8iFa0KkjijHv+H7d7t704jyvN4Bjd/jXPGReP
         M0j+FAkNiixiTCuAtE4VmSDXuhIkYXGCzHavuxB37xhuu8vkDITf8z1Nl3jEVdwx4EZB
         M+KmRhfojBoOjLTz0haa8ia2zausIAdWVKswQ/yBZw8ro0ndqPCvLB+rmWTiCsEihp1w
         Gec0paZQr9AJLOg50fQmFNAcNv0b6dnjYa0devXdgXu1Xn+d5sDbybNBSeaeE3lvH/T7
         X4NbnxQVCI6qjoN/DHkVrDLdnXvq6mx/XL9pDXPrnl1LEzP1JohzytupoGejHzdTA87u
         fb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206752; x=1793811552;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VlSHawmaYo7XEDZt0W9ICjjdKVeHjZOaaru3Hu2UpII=;
        b=IrCd9MjOMz8AQYilNXm6pkFwNv/yLUekSATPTy2smmCYLNuuQjdK6yM2wMoTBKqrNc
         Jb1inj3ORt/HXav+vGr2opGIT4YZsg5Wme4qRBKkA+UQvCDAS7tsAFLZMEapoRX5d3/a
         sJysdoIiKp/u6zPAZKdsiv//aCIHUBdneA1ihGw0H8yS5mrsaMkkdlsVNeZSvjxywAtJ
         wX4AE0Mj1W5+54TTtYA29IXg/CWDMlhMYBbez1g11HrJJW9RSMrXLsyD6th0zAtF3cV+
         mZ0ODgBMUIC/f42TZ4idZHb+onwOpqTAIWKwTDFH3DEc3k+lyBTRl3foBcdmq/W0iSal
         ucVQ==
X-Gm-Message-State: AFq9FYJkAALrW1zYxO4r4VO7Hfcbyik+P6+EtYMnPzqnB0dHyEDFCUAV
	IZon9bKALeuTLx8aae97K+fMv+YCXkQZB9wdeN3+kg8mDqiaWzov9SoLeJEijr6WspY=
X-Gm-Gg: AYBFou3L7ok2vr/e19qNlT18/pP+Yz4Q3Etmt9Q0m3xz5MEmOJ0TJaAxQXNR3nPDm65
	+Tsm6WMGwoqMfu+Awh9JoOBeueMdORbM6F7hPGzYUvf0kFEYMwms33Z2yMejy4thoqmjZR+3bZf
	4RBJxC4O1tzPT4UMtJMGtT8JQoQpmuWLKYo/iieCtfxsghS0ohb7CS2/ERSv/3hZtz/+4PgRHnb
	Tg1XDnpnlEjz8hKNbtf7LAIYsXwVU+ZYrwu2cWE3cDgR1GY5weZsTfkYS/uYLYMi3Nzp1NaXr1L
	6MSS0aQO8N7JAe3U9wKe/Q2a/18jgkUo7kegVQAfyJIJ1Yg2j50ppg4hdhZCS/WauJ5mKw7iG5q
	KaICChbpF/gonaXH0VkgjYs+CIbdwlgj3YInoGTaNPAoevaj1blMIv2aE+CXBckoTFE2wTlxK7C
	1JAsiVFnYsaKPkFhiptCHBRqNmMuYKhFonhgXIQaPcjrCK+P+wzgEXn2OYMMQcDkszIWognNwn+
	cyhwSZ44wMc2IYww16kvcZ5VnzaUMv2k17rEz90HFGuhOXhhQQPt6T4XIg+u8qaE3wFa1S4Lz6g
	cMuYarDP/Lc4HrwgwP/Vkw==
X-Received: by 2002:a05:693c:6010:b0:35d:8c3a:38a8 with SMTP id 5a478bee46e88-36a20404e36mr4699944eec.39.1793206751820;
        Wed, 28 Oct 2026 09:59:11 -0700 (PDT)
Received: from 4cb1f8191411 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a26d59f0fsm5790587eec.6.2026.10.28.09.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:59:11 -0700 (PDT)
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
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-5=2E10=2Ey=3A_=28build=29in_expan?=
 =?utf-8?q?sion_of_macro_=E2=80=98guard=E2=80=99_in_kernel/pid=5Fnamespace?=
 =?utf-8?q?=2Eo_=28kernel/pid=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 28 Oct 2026 16:59:10 -0000
Message-ID: <179320675050.41040.3191823208169159471@kernelci.org>

New build issue found on stable-rc/linux-5.10.y:

---
in expansion of macro ‘guard’ in kernel/pid_namespace.o (kernel/pid_namespace.c) [logspec:kbuild,kbuild.compiler.note]
---

Log excerpt:
=====================================================
kernel/pid_namespace.c:223:9: note: in expansion of macro ‘guard’
  223 |         guard(no_notify_signal)();
      |         ^~~~~
kernel/pid_namespace.c:223:9: error: cleanup argument not a function
./include/linux/cleanup.h:87:17: error: implicit declaration of function ‘class_no_notify_signal_constructor’ [-Werror=implicit-function-declaration]
   87 |                 class_##_name##_constructor
      |                 ^~~~~~
./include/linux/cleanup.h:109:9: note: in expansion of macro ‘CLASS’
  109 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
kernel/pid_namespace.c:223:9: note: in expansion of macro ‘guard’
  223 |         guard(no_notify_signal)();
      |         ^~~~~
./include/linux/cleanup.h:86:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
   86 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
      |         ^~~~~~
./include/linux/cleanup.h:109:9: note: in expansion of macro ‘CLASS’
  109 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
kernel/pid_namespace.c:223:9: note: in expansion of macro ‘guard’
  223 |         guard(no_notify_signal)();
      |         ^~~~~
./include/linux/compiler-gcc.h:53:45: warning: unused variable ‘__UNIQUE_ID_guard358’ [-Wunused-variable]
   53 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
      |                                             ^~~~~~~~~~~~
./include/linux/cleanup.h:86:27: note: in definition of macro ‘CLASS’
   86 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
      |                           ^~~
././include/linux/compiler_types.h:60:22: note: in expansion of macro ‘___PASTE’
   60 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler-gcc.h:53:29: note: in expansion of macro ‘__PASTE’
   53 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
      |                             ^~~~~~~
././include/linux/compiler_types.h:60:22: note: in expansion of macro ‘___PASTE’
   60 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler-gcc.h:53:37: note: in expansion of macro ‘__PASTE’
   53 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
      |                                     ^~~~~~~
./include/linux/cleanup.h:109:22: note: in expansion of macro ‘__UNIQUE_ID’
  109 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~
kernel/pid_namespace.c:223:9: note: in expansion of macro ‘guard’
  223 |         guard(no_notify_signal)();
      |         ^~~~~
cc1: some warnings being treated as errors

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:b1ac6697b6a1172acf4d8d904aa3e6f82f634ccd
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  e17af63756fb767cf17408cbe3233fd11517e769

# Builds where the incident occurred:

## 32r2el_defconfig on (mips):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-mips-32r2el_defconfig-6ae227515c0836a8c2f02ce0/.config
- dashboard: https://d.kernelci.org/build/maestro:6ae227515c0836a8c2f02ce0

## defconfig on (riscv):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6ae227595c0836a8c2f02e68

## defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y on (arm64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm64-chromebook-6ae226d75c0836a8c2f0247b/.config
- dashboard: https://d.kernelci.org/build/maestro:6ae226d75c0836a8c2f0247b

## defconfig+netdev+nfs-root-boot on (arm64):
- compiler: gcc-15
- config: https://files.kernelci.org/kbuild-gcc-15-arm64-nfsboot-6ae227285c0836a8c2f02be6/.config
- dashboard: https://d.kernelci.org/build/maestro:6ae227285c0836a8c2f02be6

## defconfig+netdev+nfs-root-boot+kselftest on (arm64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm64-nfsboot-6ae227245c0836a8c2f02be3/.config
- dashboard: https://d.kernelci.org/build/maestro:6ae227245c0836a8c2f02be3

## defconfig+netdev+nfs-root-boot+ltp on (arm64):
- compiler: gcc-15
- config: https://files.kernelci.org/kbuild-gcc-15-arm64-nfsboot-ltp-6ae2272c5c0836a8c2f02bf0/.config
- dashboard: https://d.kernelci.org/build/maestro:6ae2272c5c0836a8c2f02bf0

## i386_defconfig+kselftest on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-kselftest-6ae2274c5c0836a8c2f02cbd/.config
- dashboard: https://d.kernelci.org/build/maestro:6ae2274c5c0836a8c2f02cbd

## multi_v5_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6ae2270b5c0836a8c2f02a74

#kernelci issue maestro:b1ac6697b6a1172acf4d8d904aa3e6f82f634ccd

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
