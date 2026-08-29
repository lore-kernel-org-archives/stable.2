Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05D1220F2A
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 09:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787996930; cv=none; b=NuH3cLRUblIIWYnR5WJneIEzZUfgY6fkFDpxzdIthCBr7CqdH0PUlT7KN9ByokrGSksoI3ab1SgUpll6No2SikvSUCAKeVfl2SYMEv+E4lJptbt8mxqwPp4g/dFDkuK3Shg7Pfm15FcYv6rvfWWavd+bQWWZWCvTrYH/BQ0qIeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787996930; c=relaxed/simple;
	bh=4NaOSnad3ovSdHyfMpXrqbIZhtmfgN/COGu0UHmwoHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JOxczBLLxX7c8UpZZHiYvTNFpxX51a83p1jfSdzoY946qkeK+6l+VUFq/U7r6l+csIg6gl2WA87ZStDFNif51SwWoQHOMjPdPwIWJjbdT2V+k6IMywoJMHIPAZKeqIsedmKDP2nJd2geYCj4Ykn75x4imyA7RqWR5/K9uBkavO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbrMLDRW; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbrMLDRW"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a5e392b2b3so2850944a12.1
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 02:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787996927; x=1788601727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vr48OlihL3z/Xr4r4Y0Vtz7OZXseZdEoR3eobBbUMjA=;
        b=lbrMLDRWCYi4qxA381CMQ+ksTp55hmazEvRHuXeq+SOih+vW7HZzBXceDkKAziU147
         4M+/Y82yZ2Bcd65EycYGqaNicX0UjNgSPBnLoHJ1xURRC9BIfKiJmMo3ED4QPY47oIMK
         svlZM6XN60xwOY4gLrj1xcAsp+6yGLfnNOrRQ0yUqdel/hMY9gV/ZbaabmlrI2uGqbgt
         ab3jKkcnY8KFKZ3QIkfgKofLUSvx7ppiKKH4t0Ax6mvxbInh9XH6DYjiIV7LT+X5tlxx
         dyFvQWh0Lv07FsdZFIYfkToLQQOPRrxF5I0JUBC8sfENHStuGCaX6X5/iVjQ0/ofD08M
         fK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787996927; x=1788601727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vr48OlihL3z/Xr4r4Y0Vtz7OZXseZdEoR3eobBbUMjA=;
        b=CSEOYInNXpBkZjoUdXgLQj0DDhWUmg11XEtq1iZjGJn9+lFuTyvJLpRncn5/gGdQhE
         xJ8BH2h/MAKkCDPMqQcUmtfedwJz3Ekwj5Qvc+pNQN4QCKBdvhnw9xDql/SXD6+7Nd/c
         ZUCzHbIDkK6GXn/9UOD5BnUctMJlNZO81KuaNcY8uWuLLAWNQL0GinIjUNpamaPnguB/
         04LeGzZEAiTB7UTb9Uu1yC3rZCVuTeg6p0g8KXDdoeJ6RrcPhm57lkWkY5ugk+UY+bOz
         /G7nBlYJppYBRuYpQxphUuFmAjeQXekA++Vk76jfzkXDVP4QlRV3FBO6FcSEVp5ZdCzG
         Z0Fg==
X-Forwarded-Encrypted: i=1; AHgh+RrNp/wj3c/CUu2nlYjTYmimX7AOqfYYIjHnXNIYYZgLkPRpFQ41OSYiE9t3GtseFd22YMn24w0=@vger.kernel.org
X-Gm-Message-State: AFuF++m/MvkRVc3K5Ltem2NbvVQjssWIqqNiHskoprFzsxcYqCuHE2Gm
	kYuMmgDCw3XiMoj+9me05gUtiSr5cfHCdnYRhaJmcBocipZAaEL7TRCV
X-Gm-Gg: AR+sD10L33xlgUkahdzEC7+cy8yzfDq7SxSyicr18LpET1Sph03L22vz2gI9FaJApyX
	9ps5slNLOgVL4rc7wVz2W0c/NG9e6mcqs/6w6IuJLFeXY9PO+nP6y570lGiNdxfJTzZHHMkGftp
	ybkF4m7c6yVF8EP0qfBGU9yGFsEIIgEiC7E/Pff7P4BNYzgLxJ/6BVzCwARz47Z9I85T+xEACN8
	YYhcaRXr7KMiXXzpzjdjoUcZH4G4204CP2zcmCs+Zg6rtdotpVnq7BN+yiX0HdHqcOkCviUpqFx
	so5/hrOZxNOvnB8S6zV99yflFbTzgBREF6LHoh1bvsVTEZW5/Pqb8oO3vaLSINq1shthge7duII
	3iy++Pm9nArSp8U8JVIuKlWxZM9lemYvdqHomQUiYkF5VMlWSYE5PaV1X4j3BcCdAO5qE1gxv4M
	5Scj7cobERxvscPt0bcp3WGXdQL/DJCiew22G3Fd0ztr67T8ws6BYZz5LPceVy0kioB37qDq6ry
	UISfRaavNG2WQ+cUeERATj6kIzuy6rH3ZJK+GQ=
X-Received: by 2002:a17:907:c1f:b0:c21:757:1bb4 with SMTP id a640c23a62f3a-c25571d8ff6mr949921466b.16.1787996926837;
        Sat, 29 Aug 2026 02:48:46 -0700 (PDT)
Received: from Lenovo (public-gprs210891.centertel.pl. [46.134.163.12])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255ee28596sm190811766b.20.2026.08.29.02.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 02:48:46 -0700 (PDT)
From: Marcin Dawid <mdawid@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	"Jiakai Xu" <xujiakai24@mails.ucas.ac.cn>,
	"Sasha Levin" <sashal@kernel.org>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [REGRESSION] 6.12.y: s2idle hangs after 171ef40fce41 ("PM: sleep: Use complete() in device_pm_sleep_init()")
Date: Sat, 29 Aug 2026 11:47:47 +0200
Message-ID: <20260829094750.574649-1-mdawid@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

My ThinkPad P16v stopped suspending after a kernel update. I bisected
the problem to commit 171ef40fce41 ("PM: sleep: Use complete() in
device_pm_sleep_init()"), the 6.12.y backport of mainline commit
3855941f1e40. Reverting this commit fixes the problem.

#regzbot introduced: 171ef40fce41b13f5115d988c45997e94113c7ab

Symptoms:
When I close the lid my laptop does not go to sleep and its fans
keep running. If I open the lid, the screen stays black and the laptop does
not respond. I must do a hard reset. Only the lid triggers this. Calling
"systemctl suspend" with the lid open works.

In every hang, the kernel log ends like this, here on 6.12.105:

  [   94.290011] PM: suspend entry (s2idle)
  [   94.296689] Filesystems sync: 0.004 seconds

This is the last output visible in the journal.

System:
Manjaro Linux (rolling release), x86_64, systemd 261
Lenovo ThinkPad P16v Gen 1 (21FE0011PB)
AMD Ryzen 7 PRO 7840HS w/ Radeon 780M Graphics
BIOS N3VET59W (1.59), 05/13/2025
2x NVMe, WiFi Qualcomm QCNFA765 (ath11k_pci), USB4/Thunderbolt
/sys/power/mem_sleep: [s2idle]   (the laptop does not support S3)

Affected versions:

  6.12.y: last working 6.12.96 -> first bad 6.12.97

I only see the hang on 6.12.y. I also tested 6.18.45, 7.1.8 and mainline
7.2, which carry the same commit and the laptop suspends normally on all
three (see the table below).

The latest 6.12.107 still has the commit and no fix or revert. I tested it
and it hangs the same way.

Reproducing the problem:
I bisected stable branch between 6.12.96 (good) and 6.12.103 (bad).
Every tested kernel was built from the kernel.org stable tree using
config based on the Manjaro 6.12.96 (trimmed with make localmodconfig
and updated with make olddefconfig).

  171ef40fce41b13f5115d988c45997e94113c7ab is the first bad commit
  PM: sleep: Use complete() in device_pm_sleep_init()
  [ Upstream commit 3855941f1e4069182c895d5093c5fa589f5b38bd ]

Bisect log:
git bisect start
# status: waiting for both 'good' and 'bad' commits
# bad: [25c09b42358e73e1476e517b296edb6344f2e4bd] Linux 6.12.103
git bisect bad 25c09b42358e73e1476e517b296edb6344f2e4bd
# status: waiting for 'good' commit(s), 'bad' commit known
# good: [6d15a1029d425b15c59463910ebdccc4afe760d6] Linux 6.12.96
git bisect good 6d15a1029d425b15c59463910ebdccc4afe760d6
# bad: [afb45d1142b3031f408c0505d1c3e89edc68fb49] iio: adc: ad7380: select REGMAP
git bisect bad afb45d1142b3031f408c0505d1c3e89edc68fb49
# bad: [29c801cbd8ad1a27adef6a325cc5a1e6ef275a97] selftest/mm: register existing mapping with userfaultfd in hugetlb-mremap
git bisect bad 29c801cbd8ad1a27adef6a325cc5a1e6ef275a97
# bad: [eb7cb798e563b3f3b3baeb9cc6f7455764267e50] IB/mlx5: Properly support implicit ODP rereg_mr
git bisect bad eb7cb798e563b3f3b3baeb9cc6f7455764267e50
# good: [5d52b6dc6fd0640e355877e8370b21eb84dc13e0] sysfs: clamp show() return value in sysfs_kf_read()
git bisect good 5d52b6dc6fd0640e355877e8370b21eb84dc13e0
# bad: [fa766e5e53ad389d6ec810783f5d5367010f9412] media: qcom: venus: drop extra padding in NV12 raw size calculation
git bisect bad fa766e5e53ad389d6ec810783f5d5367010f9412
# bad: [962eae1f30e57ac8e6e20a8b862e269145dc6d9a] driver core: Guard deferred probe timeout extension with delayed_work_pending()
git bisect bad 962eae1f30e57ac8e6e20a8b862e269145dc6d9a
# good: [16723523c74f90d487df270ae4dad263542aab26] cpufreq: conservative: Simplify frequency limit handling
git bisect good 16723523c74f90d487df270ae4dad263542aab26
# good: [7d9fbee252f84de3e6947a40eec01481c9d8afbb] RDMA/hns: Fix log flood after cmd_mbox failure
git bisect good 7d9fbee252f84de3e6947a40eec01481c9d8afbb
# bad: [7670a3a6ccaf6f081c474338d204461c67d9e126] MIPS: DEC: Remove do_IRQ() call indirection
git bisect bad 7670a3a6ccaf6f081c474338d204461c67d9e126
# bad: [171ef40fce41b13f5115d988c45997e94113c7ab] PM: sleep: Use complete() in device_pm_sleep_init()
git bisect bad 171ef40fce41b13f5115d988c45997e94113c7ab
# good: [5452b60cb1db44cf507aa9b85ab51901ed593c6c] RDMA/counter: Fix incorrect port index in rdma_counter_init() error cleanup
git bisect good 5452b60cb1db44cf507aa9b85ab51901ed593c6c
# first 'bad' commit: [171ef40fce41b13f5115d988c45997e94113c7ab] PM: sleep: Use complete() in device_pm_sleep_init()

What I tested:
All tests were done on the same machine, on AC power, by closing and
opening the lid. One cycle means that the laptop went to sleep and woke
up. The numbers come from the system journal:

  6.12.96 Manjaro, before the commit       works  - 48 cycles over 29 days
  6.12.103 (with the commit)               hangs  - first attempt after boot
  6.12.103 with the commit reverted        works  - 5 cycles in one boot
  6.12.103 /sys/power/pm_async set to 0    works  - 11 cycles in one boot
  6.12.104 Manjaro                         hangs  - first attempt after boot
  6.12.105 (with the commit)               hangs  - first attempt after boot
  6.12.105 with the commit reverted        works  - 10 cycles in one boot
  6.12.105 /sys/power/pm_async set to 0    works  - 11 cycles in one boot
  6.12.107 (with the commit)               hangs  - first attempt after boot
  6.18.45 Manjaro                          works  - 7 cycles over 2 boots
  7.1.8 Manjaro                            works  - 12 cycles over 5 boots
  7.2 mainline, built from source          works  - 11 cycles over 5 boots

Every hang happened on the first suspend attempt after boot and never after
a successful cycle.

Setting /sys/power/pm_async to 0 is a workaround I found. The original bad
kernel suspends normally with this flag set to 0. I have used this
workaround without failures.

Changing /sys/power/pm_async back to 1 on a running system did not
immediately reproduce the problem. I did this on 6.12.105 and after 11
successful cycles with pm_async=0 the next 3 cycles also worked. The first
suspend attempt hung again after reboot.

With the commit reverted, 6.12.105 logs this when I close the lid:

  [  154.523353] PM: suspend entry (s2idle)
  [  154.530033] Filesystems sync: 0.003 seconds
  [  155.273772] Freezing user space processes
  [...]
  [  155.273951] PM: Some devices failed to suspend, or early wake event detected
  [... device resume messages ...]
  [  155.290012] PM: suspend exit
  [  155.290087] PM: suspend entry (s2idle)
  [  156.163505] Filesystems sync: 0.004 seconds
  [... no error this time; the laptop enters s2idle and later resumes ...]
  [  156.223357] PM: suspend exit

With the commit present, the same 6.12.105 stops at the "Filesystems sync"
line:

  [   94.290011] PM: suspend entry (s2idle)
  [   94.296689] Filesystems sync: 0.004 seconds

6.18.45, 7.1.8 and mainline 7.2 contain the same change and log the same
failed first attempt, but their second attempt suspends normally.

Calling "systemctl suspend" with the lid open succeeds on the first
attempt on 6.12.105 with the commit, never logs "Some devices failed to
suspend" and did not hang in 18 cycles over 7 boots.

My local settings:
Kernel command line:
  BOOT_IMAGE=/boot/vmlinuz-6.12-x86_64
  root=UUID=985b52ba-a61a-41f8-ab5c-fad209ce7c44 rw zswap.enabled=0
  resume=UUID=9f557da2-d7c5-4623-83c0-3ea696bb1b3c udev.log_priority=3
Module options:
  thinkpad_acpi fan_control=1
Other:
  /sys/power/disk set to "shutdown", vm.swappiness=100, vm.page-cluster=0,
  CoolerControl daemon, a local systemd unit that reloads ath11k_pci
  after resume


I can test patches or collect more information if needed.

Regards,
Marcin Dawid
