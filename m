Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795135865;
	b=0yvhhxmG0nAwXQa8mBsBMVp51HpPiVJJg3g+/AHtS5jlU5w6KDrGWAaay7BDE912mqUr
	 3K5ktDD2zJ2u1gnVyrJGAkfSso8gpjHC8NklG0ynP3wlXRKlw49rtMDhjT8XSkX3vr7qL
	 r9Npl4X4Qruq8KmZa4nqBBxwGFZrUzKwnpUkwxqL7C4sUfrmdGHL0WTUgdT8/9MQ9Gok5
	 2XMEJJBFU6+TvX/VPiwkygjJmSZ9KHQhEvpFcTww1elRh/kLt/cLZwrL7HHUOTSDFcbzf
	 L0pY2JYrXcQxwdLfIZTx7X2C6eufsl2s+KaGhoLbykkWobt8MZy0xMeESDa69QhZwAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795135865;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=04JSIZhHjKFEu/YxzRiw0+EhqATPIIfOkPMS5Z9474I=;
	b=LnGTng9Umrawz7oWn0yU11Zz0ZkssTXggU3NAIkrZkNMP91D2AstWFuwKd+HJRrY4GCl
	 HqroBpVaP2K5PCjs6KaXlVYtEb43YIzGXINCi24dWYHejcww93w+3Gu2HBRWoJJbvCmif
	 1pqmie7bfUkZZdvO4UJ4Wgd8k5/+Yc5oVsBtgX1jGggJagOfGrG7SqM3EDYZIy9JXEvMP
	 ajfcIg6gG5I1sDQASlyVl77X2r26J1KASF2XIZEpKlHNNVDtwwpydySID6C1OJt/7xvQM
	 kZ0f4oLSOctQZG+i/380K/SEOLkHkwXKJ+AzDMDHF/+hIQZM3p6B8z5A+G1u0e4UfJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hAPjT4Ft;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8FC606A325;
	Fri, 20 Nov 2026 00:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D8FC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hAPjT4Ft
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795135866; x=1826671866;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=PiQQ53VfPmAKE6LrwH/r/v6LsS18HY/qWJCCHOSzdls=;
  b=hAPjT4Ft5T2T3cnoVAdzwHTtPIuAQvTLiMvWqlklHjR9N5JI7oPa9yFn
   IlxuRkV2CXd3TCAhrbpexYKd3f/FF/YCEWSR1l82FadSuVs0pfzR+fcca
   KsFRMP3OI4nes808G6fD+ELDErtTnjJ4C80erPPzCm2uHM7lun00RyZRJ
   UvydMUExmbny4m/vW5mufvbw18RXTitSHTFqWPpvTvzW4XifseYcGMD5I
   oVR5e6T9Te+RpXXPmiB+cWnp0Nc4QbZUWShM5e5HxwD9BsUM5CzdlE5jO
   SoeNtZWbYzAtojJuljrrnGWbh/dRKmLcL33Of6GnBkOP4DaZuq5RcICEq
   A==;
X-CSE-ConnectionGUID: T4Q5rm6YQfy/XDVFepjGQA==
X-CSE-MsgGUID: an+bCtG4RUGF03bObRvI3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3891155"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3891155"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 16:51:05 -0800
X-CSE-ConnectionGUID: NfSyXI7OSyirTKo5cJZuig==
X-CSE-MsgGUID: YeiBLmiMThqLC+jjX7H3Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="10462099"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 16:51:01 -0800
Date: Fri, 20 Nov 2026 08:50:58 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Sinan Turunc <enscrpt@pm.me>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, keyrings@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, yi1.lai@intel.com
Subject: Re: [PATCH] keys: serialise instantiation against keyctl_chown_key
Message-ID: <202611192204.aa82996f-lkp@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261115121722.206-1-enscrpt@pm.me>


Hello,

kernel test robot noticed "WARNING:possible_circular_locking_dependency_detected" on:

commit: a22ea46d3e3ee6e7fbea90bd9b1ff61cdcdc96c1 ("[PATCH] keys: serialise instantiation against keyctl_chown_key")
url: https://github.com/intel-lab-lkp/linux/commits/Sinan-Turunc/keys-serialise-instantiation-against-keyctl_chown_key/20261115-121740
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 23c62304dde29abe92013d85910d03a77dada35d
patch link: https://lore.kernel.org/all/20261115121722.206-1-enscrpt@pm.me/
patch subject: [PATCH] keys: serialise instantiation against keyctl_chown_key

in testcase: trinity
version: trinity-x86_64-216a8b36b-1_20261116
with following parameters:

	runtime: 300s
	group: group-02
	nr_groups: 5


config: x86_64-randconfig-121-20251020
compiler: gcc-14
test machine: qemu-system-x86_64 -enable-kvm -cpu Haswell-noTSX,enforce -smp 4 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202611192204.aa82996f-lkp@intel.com


[  227.133561][ T1501] WARNING: possible circular locking dependency detected
[  227.137692][ T1501] 7.4.0-rc2-00717-ga22ea46d3e3e #1 Not tainted 
[  227.138989][ T1501] ------------------------------------------------------
[  227.140436][ T1501] trinity-c3/1501 is trying to acquire lock:
[  227.141691][ T1501] ffffffff838679e0 (keyring_serialise_link_lock){+.+.}-{4:4}, at: __key_move_lock (keys/keyring.c:1305) 
[  227.143815][ T1501] [  227.143815][ T1501] but task is already holding lock:
[  227.143815][ T1501]
[  227.143815][ T1501] but task is already holding lock:
[  227.143815][ T1501]
[  227.143815][ T1501] but task is already holding lock:
[  227.145340][ T1501] ffff88812a091e08 (&type->lock_class/1){+.+.}-{4:4}, at: __key_move_lock (keys/keyring.c:1298) 
[  227.147290][ T1501] 
[  227.147290][ T1501] which lock already depends on the new lock.
[  227.147290][ T1501]
[  227.147290][ T1501] which lock already depends on the new lock.
[  227.147290][ T1501]
[  227.147290][ T1501] which lock already depends on the new lock.
[  227.147290][ T1501]
[  227.149447][ T1501]
[  227.149447][ T1501] the existing dependency chain (in reverse order) is:
[  227.149447][ T1501]
[  227.149447][ T1501] the existing dependency chain (in reverse order) is:
[  227.149447][ T1501]
[  227.149447][ T1501] the existing dependency chain (in reverse order) is:
[  227.151296][ T1501]
[  227.151296][ T1501] -> #2 (&type->lock_class/1){+.+.}-{4:4}:
[  227.151296][ T1501]
[  227.151296][ T1501] -> #2 (&type->lock_class/1){+.+.}-{4:4}:
[  227.151296][ T1501]
[  227.151296][ T1501] -> #2 (&type->lock_class/1){+.+.}-{4:4}:
[  227.152939][ T1501]        validate_chain (locking/lockdep.c:3328 locking/lockdep.c:3952)
[  227.154012][ T1501]        __lock_acquire (locking/lockdep.c:5288)
[  227.155085][ T1501]        lock_acquire (trace/events/lock.h:23 (discriminator 1) locking/lockdep.c:5905 (discriminator 1))
[  227.156219][ T1501]        lock_acquire (locking/lockdep.c:5907)
[  227.157219][ T1501]        down_write_nested (locking/rwsem.c:1757 (discriminator 1))
[  227.158300][ T1501]        __key_instantiate_and_link (keys/key.c:451)
[  227.159581][ T1501]        key_instantiate_and_link (keys/key.c:549)
[  227.160804][ T1501]        keyring_alloc (keys/keyring.c:541)
[  227.161819][ T1501]        blacklist_init (blacklist.c:337)
[  227.162888][ T1501]        do_one_initcall (main.c:1419)
[  227.163950][ T1501]        do_initcalls (main.c:1481 (discriminator 1) main.c:1497 (discriminator 1))
[  227.164975][ T1501]        kernel_init_freeable (main.c:1517 main.c:1732)
[  227.166136][ T1501]        kernel_init (main.c:1622)
[  227.167132][ T1501]        ret_from_fork (x86/kernel/process.c:158)
[  227.168163][ T1501]        ret_from_fork_asm (x86/entry/entry_64.S:245)
[  227.169265][ T1501]
[  227.169265][ T1501] -> #1 (key_construction_mutex){+.+.}-{4:4}:
[  227.169265][ T1501]
[  227.169265][ T1501] -> #1 (key_construction_mutex){+.+.}-{4:4}:
[  227.169265][ T1501]
[  227.169265][ T1501] -> #1 (key_construction_mutex){+.+.}-{4:4}:
[  227.170969][ T1501]        validate_chain (locking/lockdep.c:3328 locking/lockdep.c:3952)
[  227.172036][ T1501]        __lock_acquire (locking/lockdep.c:5288)
[  227.173115][ T1501]        lock_acquire (trace/events/lock.h:23 (discriminator 1) locking/lockdep.c:5905 (discriminator 1))
[  227.189495][ T1501]        lock_acquire (locking/lockdep.c:5907)
[  227.191295][ T1501]        __mutex_lock (locking/mutex.c:646 locking/mutex.c:821)
[  227.193002][ T1501]        mutex_lock_nested (locking/mutex.c:874 (discriminator 1))
[  227.194980][ T1501]        __key_instantiate_and_link (keys/key.c:443)
[  227.197215][ T1501]        key_instantiate_and_link (keys/key.c:549)
[  227.199432][ T1501]        keyring_alloc (keys/keyring.c:541)
[  227.201173][ T1501]        look_up_user_keyrings (keys/process_keys.c:116)
[  227.202572][ T1501]        init_root_keyring (keys/process_keys.c:1044)
[  227.217442][ T1501]        do_one_initcall (main.c:1419)
[  227.219309][ T1501]        do_initcalls (main.c:1481 (discriminator 1) main.c:1497 (discriminator 1))
[  227.221127][ T1501]        kernel_init_freeable (main.c:1517 main.c:1732)
[  227.223114][ T1501]        kernel_init (main.c:1622)
[  227.224834][ T1501]        ret_from_fork (x86/kernel/process.c:158)
[  227.226598][ T1501]        ret_from_fork_asm (x86/entry/entry_64.S:245)
[  227.228485][ T1501]
[  227.228485][ T1501] -> #0 (keyring_serialise_link_lock){+.+.}-{4:4}:
[  227.228485][ T1501]
[  227.228485][ T1501] -> #0 (keyring_serialise_link_lock){+.+.}-{4:4}:
[  227.228485][ T1501]
[  227.228485][ T1501] -> #0 (keyring_serialise_link_lock){+.+.}-{4:4}:
[  227.231311][ T1501]        check_noncircular (locking/lockdep.c:2219)
[  227.233160][ T1501]        check_prev_add (locking/lockdep.c:3209)
[  227.235032][ T1501]        validate_chain (locking/lockdep.c:3328 locking/lockdep.c:3952)
[  227.236844][ T1501]        __lock_acquire (locking/lockdep.c:5288)
[  227.238525][ T1501]        lock_acquire (trace/events/lock.h:23 (discriminator 1) locking/lockdep.c:5905 (discriminator 1))
[  227.240157][ T1501]        lock_acquire (locking/lockdep.c:5907)
[  227.241603][ T1501]        __mutex_lock (locking/mutex.c:646 locking/mutex.c:821)
[  227.242975][ T1501]        mutex_lock_nested (locking/mutex.c:874 (discriminator 1))
[  227.244070][ T1501]        __key_move_lock (keys/keyring.c:1305)
[  227.245152][ T1501]        key_move (keys/keyring.c:1634)
[  227.246096][ T1501]        keyctl_keyring_move (keys/keyctl.c:618 (discriminator 3))
[  227.247227][ T1501]        __do_sys_keyctl (keys/keyctl.c:2023)
[  227.248314][ T1501]        __x64_sys_keyctl (keys/keyctl.c:1885 keys/keyctl.c:1885)
[  227.249389][ T1501]        x64_sys_call (kbuild/obj/consumer/x86_64-randconfig-121-20251020/./arch/x86/include/generated/asm/syscalls_64.h:251)
[  227.250447][ T1501]        do_syscall_64 (x86/entry/syscall_64.c:61 x86/entry/syscall_64.c:89)
[  227.251533][ T1501]        entry_SYSCALL_64_after_hwframe (x86/entry/entry_64.S:121)
[  227.252848][ T1501]
[  227.252848][ T1501] other info that might help us debug this:
[  227.252848][ T1501]
[  227.252848][ T1501] other info that might help us debug this:
[  227.252848][ T1501]
[  227.252848][ T1501] other info that might help us debug this:
[  227.252848][ T1501]
[  227.255005][ T1501] Chain exists of:
[  227.255005][ T1501]   keyring_serialise_link_lock --> key_construction_mutex --> &type->lock_class/1
[  227.255005][ T1501]


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20261119/202611192204.aa82996f-lkp@intel.com


--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


