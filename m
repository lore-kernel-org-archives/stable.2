Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206751;
	b=AoiAJAhWX/FoR1fhJGoDLyNFPJhn0WmyQQZdeCWC26cxT44YS8ab8ZbIcOEqkrgYezUi
	 23wOFDs9W2asSUHFaCkzkUSo5B8Q/FRGW+gVTU8a1IX5CFV3ImHQGR8q983l93PgqMKYh
	 wzjdZbgh7IXZUCxXlEydN6gblDspLyI8qftc7OiLoSYNguusrAG1xFtZvR4NCQKPYKtaF
	 eOuqwIrJSzC6OiBOSyt4ibx/MdxCvoI/3+cfHcS/Z0/i+YrQLJdILRfQ6wIIEysNbnx1t
	 OiNt9JsVPraZTBNHP6gipUU0qcozUgGOsh0ecugKcGLvHCQ5H5sWn58TYdVBg0dTGrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=dkBatwRsHVYlKoEFIicwAbqGhPoxG96VYe9Toe2i75I=;
	b=NrjCYJcfIw7hbeG/MrI6n/kEwIxlEr6DzAiHsj4+lQWdxYESr2zQYhW2pprj9RQo9La/
	 MdVQwtabPg6XG7nq4m8P0LbZSqZltEbbCEQDGK9GiksdCoUE8M5CUklpGvQ/+EjvRpNR7
	 vhX7auNiqPggxrCiNaCu4TBSfchbNmVlXC/o6xRi95ExtrAltjY1BVyYCHpKTWUErBKgP
	 PY5saFgYJLFLqt8z4zDVE6siVIy6oaShjsaVXnvyWAggZIqS49ejKXW8Pt3rCQhScPJde
	 3EthTwF+LGt5JLr2tKkn7oF8TRmB0lrJ5iKTOsB2B2VLbdtvVtopr0FMV94mmgNtc1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=gx+WJQdl;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64163606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 16:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64163606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=gx+WJQdl
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3550c917fd3so1729722eec.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793206750; x=1793811550; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dkBatwRsHVYlKoEFIicwAbqGhPoxG96VYe9Toe2i75I=;
        b=gx+WJQdlcjjJgzwXZAgoq7EVZqt5ad9Wyefnohuee0kJZkeCzefgzrvgyEN1WJ7i84
         9A9xkB3y5Xcwk3Pzyilc2n6+GYKPg1pKLs0pFNCGTpb8u2Qi6ACAtf6+j4de8nV5NZ3D
         vXdO/SN73m8RQDatv3kWrV8KgJnbjmz38f7H4tD+P6O1fPbOv2p/Da/O4JuuXNISL3LX
         wAHotl1ZDf+7cUFiGvTCFm2vSwZ5aeewd62NABpEiqGmmYmXdgva1j3AuLoAxkyZVPSr
         tqu3dCeaAhfxhCGyvYK5gWRGUXfbM9z42z4aj1cGM8AiS1bMHqJn9MdgEw1qjklMwldd
         Zwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206750; x=1793811550;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dkBatwRsHVYlKoEFIicwAbqGhPoxG96VYe9Toe2i75I=;
        b=YT+7lfmawUlscj+VIYABUW8frDOG4KIfAS2Po3ieFAPUkSzzqI12csjqY7lTVdAZGi
         rSjBHPBQTBIfmGrNwI+G5Ks7EibtF7N3E1WFUQF4WDJXPH4hRPptY5U719psueVh24I/
         Y75W/1atTVEkzvYYZ5hs0HA8gjLkxSqeIkBO7YeriigKhpaUfctvnnS4cQthcO0T4D+h
         kILckQVBjE7esxulxEpzIgouFH/SHhIJl4ShHjAY45S/sC3w5C0XBOlgIUPF7GZGLo9e
         PtI7MIE1vPpC/RBxO4ZWsawwOi8RL9BSxhndX3CGb/kRWiZwt1sZmZI8oVOq2q0UywPY
         tYWw==
X-Gm-Message-State: AFq9FYJAAjZZxmBAvOdTNnX92d7ddSBi27dMdbAU/LNHhl9UmBNMKCaT
	WV0oYEOfElxD6bNqhQiW+rHYI2vMiCj4BvLZ3ywN/i2Ge2s/sNfyBQugI8v54iWssKLKoMXaIQW
	PwWAi
X-Gm-Gg: AYBFou2kaqyboBa9v18CotTgbOlJlU/PjLTt4dRqKxwxhqMYZNW4v3//pLRWbp0uyjQ
	2/LWAjFu1LGItGPu+xDJPdrS2k55CIurU03bBqIZk0raMviqix4+VdHf5zT2wgz+P66GlJA7zTl
	dbFeVP0DEEKfPcC/WbFJL07sJOcdBqjMFlQmF429Pyc9UHfy288myebfBpVVpLvCPNpw+pxZQz3
	V0bzExMxGWj4lVqfv6m57jBc4RZH+7tkCiWJu1XeZkCc0hB8qteGDeRAGp/o3MQbvjAHf3Vf5iS
	kGkWqSTwApIz4CAtdi3hfRduOCq/HjWillPEoRe2CJbMb1lEaKoQgS6KUjaFEPA1c4QbGTTAvlJ
	Qba77Gfbg92Q3Df1HDm3W5v/fPwQw0OCARADhO4eE65Dezb11UWbP6i0bo35NSetAcWA2dgPqQ2
	KJtipUjAT9EQcv4a/GxG6473HtZaOVkRmAZcd8OdnILIW89way0/4Oi6Ln7bpaHUBORn9vignbG
	+wiDmzs575V/x8YZFMv6B93OK3/ZEx3HnF00H5wS7hWKTY4vWqIWwfl/kbLrPbQkfx4ZglvfjKM
	mUjg2OrjRSJ3NrYAy8/qQA==
X-Received: by 2002:a05:7301:fa0e:b0:351:1e2e:da4d with SMTP id 5a478bee46e88-36a203d417emr5591250eec.23.1793206750240;
        Wed, 28 Oct 2026 09:59:10 -0700 (PDT)
Received: from 4cb1f8191411 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239644efsm12365732eec.23.2026.10.28.09.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:59:09 -0700 (PDT)
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
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build)use of undeclared
 identifier
 'class_no_notify_signal_t'; did you me...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 28 Oct 2026 16:59:09 -0000
Message-ID: <179320674863.41040.17225916501746250426@kernelci.org>

New build issue found on stable-rc/linux-5.10.y:

---
use of undeclared identifier 'class_no_notify_signal_t'; did you mean 'clear_notify_signal'? in kernel/pid_namespace.o (kernel/pid_namespace.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/kernel/pid_namespace.c:223:2: error: use of undeclared identifier 'class_no_notify_signal_t'; did you mean 'clear_notify_signal'?
  223 |         guard(no_notify_signal)();
      |         ^
/tmp/kci/linux/include/linux/cleanup.h:109:2: note: expanded from macro 'guard'
  109 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^
/tmp/kci/linux/include/linux/cleanup.h:86:2: note: expanded from macro 'CLASS'
   86 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
      |         ^
<scratch space>:122:1: note: expanded from here
  122 | class_no_notify_signal_t
      | ^
/tmp/kci/linux/include/linux/sched/signal.h:352:20: note: 'clear_notify_signal' declared here
  352 | static inline void clear_notify_signal(void)
      |                    ^
/tmp/kci/linux/kernel/pid_namespace.c:223:2: error: expected ';' after expression
  223 |         guard(no_notify_signal)();
      |         ^
/tmp/kci/linux/include/linux/cleanup.h:109:15: note: expanded from macro 'guard'
  109 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^
/tmp/kci/linux/include/linux/compiler-clang.h:30:29: note: expanded from macro '__UNIQUE_ID'
   30 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
      |                             ^
/tmp/kci/linux/include/linux/compiler_types.h:60:22: note: expanded from macro '__PASTE'
   60 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^
/tmp/kci/linux/include/linux/compiler_types.h:59:23: note: expanded from macro '___PASTE'
   59 | #define ___PASTE(a,b) a##b
      |                       ^
<scratch space>:120:1: note: expanded from here
  120 | __UNIQUE_ID_guard268
      | ^
/tmp/kci/linux/kernel/pid_namespace.c:223:2: error: use of undeclared identifier '__UNIQUE_ID_guard268'
  223 |         guard(no_notify_signal)();
      |         ^~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/include/linux/cleanup.h:109:15: note: expanded from macro 'guard'
  109 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~~~~~~~~
/tmp/kci/linux/include/linux/compiler-clang.h:30:29: note: expanded from macro '__UNIQUE_ID'
   30 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/include/linux/compiler_types.h:60:22: note: expanded from macro '__PASTE'
   60 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~~~~~~
/tmp/kci/linux/include/linux/compiler_types.h:59:23: note: expanded from macro '___PASTE'
   59 | #define ___PASTE(a,b) a##b
      |                       ^~~~
<scratch space>:120:1: note: expanded from here
  120 | __UNIQUE_ID_guard268
      | ^~~~~~~~~~~~~~~~~~~~
3 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:bdd59dec8c493ee17bbfc1ddf8b117ce3cd6aa8c
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  e17af63756fb767cf17408cbe3233fd11517e769

# Builds where the incident occurred:

## x86_64_defconfig on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6ae226ea5c0836a8c2f024eb

#kernelci issue maestro:bdd59dec8c493ee17bbfc1ddf8b117ce3cd6aa8c

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
