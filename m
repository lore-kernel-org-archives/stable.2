Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7093D353A6C
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649952; cv=none; b=Sjr71AXjE8Hew9EQqBPRqMgfwB+iI424tDk8FYt/fnBQ3rr42yHTJ3T+VUy5I4/yGnQruE4vdB6biMN/EH3TsnqaV/gLOc0xcbDDP77f2HGEcf6rnWuJ+oQARAIfR8XnfhpE0kX3AXI8dvnIR7bfMsRwxDFzdlt61L/Yq7lAacU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649952; c=relaxed/simple;
	bh=KHXxwjQQHJGC3rdcw3BEXBpYUiN5bwK/ZzaPSLKXR0I=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=fkm7RERjx1GlGPCEqPTQ8K2T+FhbuDgSGnxnzQTR6O5f21oIXBuOA/vbwDp4v1VK4aBfuNhHB9OBEjgm8zhWS8GE3hyEK3NoHoDQEKyIA1EY5wZ9uGujJXXbekaj1egrvnL+aFfkvv7vKgHFPkoRSjd4YiSb2f5/b24sYGxjn0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=UOlDy3gk; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="UOlDy3gk"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85a4329731cso654911b3a.3
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 05:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789649945; x=1790254745; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BNU5kAZlbPpD2JfSa69xrRfI+bWps5vyoItI/Esngvo=;
        b=UOlDy3gkZX0zGrpYU8NlM0A7BtFuEgzv9/H9NBHr0iNqbV2fwfI3Q1xajGFpgt5sMD
         vUzByJE0KOZeftjbRTgF/IO4GQ7vYniXhf15+dSlGwwc9OH/GipiC6SzKzHHXz5McAgH
         ATcCXsrX7j/R/UyMR4qAS7Zj0Rja8cmGbWNyyma4GoDPbMP7y9RpJKJUfJ8F1bY92xxi
         ZZ7gUTkNpywFedm9QG1ZkTQR0kuRq/lOP7KZGBIftM/aCBP9Ii1QLd1bIYtnJ2BNTboo
         BlBGjfTi+zOL1XHCBvZWM5bdpgwtjSCTrqBMzxDa5aIY+22BuNRUq9gDOvjBEETUv0WJ
         2Lug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789649945; x=1790254745;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BNU5kAZlbPpD2JfSa69xrRfI+bWps5vyoItI/Esngvo=;
        b=RHOWKAukarLxZDNJmlmtqw8P5rzf0tyHZy921R/z+2A6LLyItJKPIHOLcpIdw7i27S
         wJ5hRVZlUqCygKbpnjD1jwpmMhMIPhdC0JkxMHe/iKSlICOepEUIzS33W+0QR+lKZOP9
         iTrwiOsKXX90Y3c4/lqo2Sgun1zze4BpLRV4RC4WiG8Hyq8FOA4W87gL9Jo738VnhQ3O
         uc0t064jb4kOnygxuVVF1psssVgvn7E5PyBivceO/JSoyCcDAQ+Gdqh5FNp87sP/5+XL
         P7FyYFHUTm99HF4kKyI6Yt7UmDp6BLBJnxqCU/J9v5SNtgzpqss64FlihXm7RSXHVt8+
         epdQ==
X-Gm-Message-State: AFuF++kV40cPYQXslVY0kTDce9FHnWd5Wq0hypIysMpcLAyCA4Bnuiy+
	BpMsLJ4lIcKnH/aIbhhpJvE9mkIU6ISbm1Qt0EVqm4E2AX9VeBMXb7LyiPDViZI88rYXGJGkkEl
	iFyW8
X-Gm-Gg: AYBFou1aDKO9fFe+FwPfais3a6K5xKj0SjWB0EI8j5FyTmCkRhm2NoVcYyAE5608C7O
	RpgcZ4ExITbmFm8xp2GeiuNK7jHUJ2UlQWI3r/UvBPQb1bAxd3MmdQ/9K1WjbKTAgpsajzEWsIZ
	bs2/VgRKAROM0CsT8vRoe8U3vxd0vw+/S4hOIixts0hlYATL87A2GIJAYxE2vO8ewoDWMBCSjMP
	KcCmnwYWc/xIoelhsHIdExLTmSa010bZvXlFBYtTzPsUHd1i/Jt5v46WAdPUnl2WqpUA/LkZyZL
	mO0t0GMSgNDacF+VCU7mau6cFWU1T+8o7rbZCnCUbD2FjFHgwmGSbs8un5eVx19uxOVE6aSYzPC
	3nP0Lp+BWlATxCdS5IszdIRvByyOAPbS/d36+Wl4kfbY8apLompcl4V/dwBaEZkWB8K+1UQWvCF
	iVPxn6EkB9kyS6XEBbbuSoYm+we6jm93pZkb77gffUGVi3TXZ4MbggwmCpM8ejyOndFqab6Dp3V
	4Y=
X-Received: by 2002:a05:6a21:7104:b0:3dd:85aa:d26b with SMTP id adf61e73a8af0-3dd85aad5bcmr419930637.35.1789649944842;
        Thu, 17 Sep 2026 05:59:04 -0700 (PDT)
Received: from ec7b70f3a45c ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5aee8b0sm32288814eec.23.2026.09.17.05.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 05:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build)implicit declaration of
 function
 'is_core_idle' [-Werror=implicit-f...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 17 Sep 2026 12:59:04 -0000
Message-ID: <178964994370.141985.11043353739859044931@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
implicit declaration of function 'is_core_idle' [-Werror=implicit-function-declaration] in kernel/sched/fair.o (kernel/sched/fair.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
kernel/sched/fair.c:9912:53: error: implicit declaration of function 'is_core_idle' [-Werror=implicit-function-declaration]
 9912 |         env->dst_core_idle = !sched_smt_active() || is_core_idle(env->dst_cpu);
      |                                                     ^~~~~~~~~~~~
  CC      arch/arc/kernel/sys.o
  AR      init/built-in.a
  CC      fs/notify/dnotify/dnotify.o
  CC      fs/notify/inotify/inotify_fsnotify.o
  CC      ipc/util.o
  CC      ipc/msgutil.o
  CC      kernel/printk/printk_safe.o
  CC      mm/mm_init.o
  CC      arch/arc/kernel/troubleshoot.o
  CC      fs/notify/inotify/inotify_user.o
  AR      fs/notify/dnotify/built-in.a
  AR      fs/notify/fanotify/built-in.a
  CC      fs/notify/fsnotify.o
  CC      ipc/msg.o
  CC      kernel/printk/printk_ringbuffer.o
  CC      mm/percpu.o
  CC      arch/arc/kernel/stacktrace.o
  CC      fs/notify/notification.o
  CC      kernel/printk/sysctl.o
  CC      arch/arc/kernel/disasm.o
  AR      fs/notify/inotify/built-in.a
  AS      arch/arc/kernel/entry-arcv2.o
  CC      arch/arc/kernel/intc-arcv2.o
  CC      arch/arc/kernel/module.o
  AR      kernel/printk/built-in.a
  CC      kernel/irq/irqdesc.o
  CC      fs/notify/group.o
  CC      ipc/sem.o
  CC      kernel/irq/handle.o
  CC      arch/arc/kernel/smp.o
cc1: some warnings being treated as errors

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:37d77388893f88dbbbb0f8ec9cbefe28107cd03e
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  25d942d40190013b993a85e00b5a84db4cb99b31

# Builds where the incident occurred:

## haps_hs_smp_defconfig on (arc):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arc-haps_hs_smp_defconfig-6aabdbc2fc1857a999dea728/.config
- dashboard: https://d.kernelci.org/build/maestro:6aabdbc2fc1857a999dea728

#kernelci issue maestro:37d77388893f88dbbbb0f8ec9cbefe28107cd03e

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
