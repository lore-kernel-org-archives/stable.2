Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F54470EB6
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788856419; cv=none; b=da3o/jng4ITeYBaKIkqIFwJMaxHNhlCAcF8HhpaLCrA2bxesAFSoNUDsdwXap72gTqYlDeFbKbu4rBCGV3zfnB42VZ/wi7CPieZgaoBTAcDbq+TivX8dLWIt4m2znkm0Kx3R5E74FRcNuMtU9TU5tOWxUc2oQP20uUm36lWPTBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788856419; c=relaxed/simple;
	bh=b+yUE2Cu9t6bgWr6jFe2Fbs9YHe92jix0kyLW96Lbzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S0RQ2c3GgRrd9j7Q3QYdqX8GF1pH2Z9zXkv/ls60cVmxaewsZXnsPQ1e7a0hscLsi4eEvaPt3RfekjQS4ytMtiShH8Dz/BBODXdWYHXuKzG+2GpVjY/atCI5oqZDeEpFCV929Js1EitJ5wogj3FIDpmCbThdDAPQG1+Jjdb51wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=DvUiIqlx; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="DvUiIqlx"
Received: from mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:582e:0:640:200:0])
	by forward500a.mail.yandex.net (postfix) with ESMTPS id 17335C1BD5;
	Tue, 08 Sep 2026 11:33:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (smtp) with ESMTPSA id OXIkmCKhD4Y0-5mZJzuTo;
	Tue, 08 Sep 2026 11:33:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1788856405; bh=riAaQuUy9F4qB8vp4uuryQ/aWvnBsUXVEkhehkS4gaM=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=DvUiIqlxv8u/7eriXZCmt31lF3aLdUnEhrtJpfZG1ktLocy4ff7JbouBsgwsSUOtd
	 XPl5daCs8AI6wHfiWvpbTT8J4uzlPxv1ZacYnwo4xlAduJGW6z/+Mc/+8VJe2Os4cl
	 hTkfDyQEmgNcyh8WtLsZi29kstWMCYkNMcoyeTfU=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <4d08aef8-1774-4fac-801e-83f428ea4762@yandex.ru>
Date: Tue, 8 Sep 2026 11:33:24 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BSECURITY=5D_configfs=3A_symlink=282=29_vs_rmdir?=
 =?UTF-8?B?KDIpIHJhY2UgbGVhZHMgdG8gdXNl4oCRYWZ0ZXLigJFmcmVlIGluIGNyZWF0ZV9s?=
 =?UTF-8?B?aW5rKCksIENXReKAkTQxNg==?=
To: tms <2478511876@qq.com>, security <security@kernel.org>,
 "a.hindborg" <a.hindborg@kernel.org>, w <w@1wt.eu>
Cc: stable <stable@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>,
 "Vasileios Almpanis <vasilisalmpanis@gmail.com> Breno Leitao"
 <leitao@debian.org>
References: <tencent_CD249E7B6DC4AF1C16A646698A19CB899607@qq.com>
Content-Language: en-US
From: Dmitry Antipov <dmantipov@yandex.ru>
In-Reply-To: <tencent_CD249E7B6DC4AF1C16A646698A19CB899607@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/8/26 8:27 AM, 'tms' via syzkaller wrote:

> Subject: [SECURITY] configfs: symlink(2) vs rmdir(2) race leads to use‑after‑free in create_link(), CWE‑416
> 
> Hello configfs maintainers,
> 
> This report describes a use‑after‑free vulnerability (CWE‑416) in fs/configfs/symlink.c,
> triggered by racing symlink(2) and rmdir(2) syscalls.

To whom it may be interesting,

recent upstream fixes a7c1290eef60 ("configfs: pin the symlink target's dirent instead of chasing ->ci_dentry")
and f06c2d26d199 ("configfs: unhash the dentry before dropping the item in rmdir") still doesn't help with
https://syzkaller.appspot.com/bug?extid=b0996ac2197dd7420c3e, which looks like a weird configfs symlink-related
race as well. Running the only available C reproducer, the following crash may be observed:

# ./repro-b0996ac2197dd7420c3e
[+] configfs mounted or already busy.
[+] nvmet subsystem found.
[+] Created subsys1 successfully.
[   63.160495][ T5885] ==================================================================
[   63.160509][ T5885] BUG: KASAN: slab-use-after-free in config_item_put+0x26/0x90
[   63.160554][ T5885] Write of size 4 at addr ffff888024d724b4 by task repro-b0996ac21/5885
[   63.160561][ T5885]
[   63.160569][ T5885] CPU: 5 UID: 0 PID: 5885 Comm: repro-b0996ac21 Tainted: G        W           7.3.0-rc2+ #9 PREEMPT(full)
[   63.160579][ T5885] Tainted: [W]=WARN
[   63.160581][ T5885] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-10.fc44 06/10/2025
[   63.160586][ T5885] Call Trace:
[   63.160589][ T5885]  <TASK>
[   63.160593][ T5885]  dump_stack_lvl+0xe8/0x150
[   63.160605][ T5885]  print_address_description+0x55/0x1e0
[   63.160615][ T5885]  print_report+0x58/0x70
[   63.160621][ T5885]  ? config_item_put+0x26/0x90
[   63.160628][ T5885]  kasan_report+0xa5/0xe0
[   63.160637][ T5885]  ? config_item_put+0x26/0x90
[   63.160644][ T5885]  kasan_check_range+0x264/0x2c0
[   63.160651][ T5885]  config_item_put+0x26/0x90
[   63.160657][ T5885]  configfs_symlink+0x58f/0x1080
[   63.160664][ T5885]  ? inode_permission+0x2b8/0x5f0
[   63.160673][ T5885]  vfs_symlink+0x159/0x470
[   63.160680][ T5885]  filename_symlinkat+0x112/0x330
[   63.160687][ T5885]  __se_sys_symlinkat+0x4e/0x2b0
[   63.160693][ T5885]  do_syscall_64+0x166/0x520
[   63.160710][ T5885]  ? trace_irq_disable+0x3b/0x140
[   63.160723][ T5885]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   63.160730][ T5885]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   63.160737][ T5885] RIP: 0033:0x7f62bc800fa9
[   63.160744][ T5885] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f 1e 0d 00 f7 d8 64 89 01 48
[   63.160750][ T5885] RSP: 002b:00007f62b96f7e88 EFLAGS: 00000246 ORIG_RAX: 000000000000010a
[   63.160759][ T5885] RAX: ffffffffffffffda RBX: 00007f62b96f8cdc RCX: 00007f62bc800fa9
[   63.160764][ T5885] RDX: 00000000004008d8 RSI: 00000000ffffff9c RDI: 0000000000400910
[   63.160768][ T5885] RBP: 0000000000000000 R08: 00007f62b96f86c0 R09: 00007f62b96f86c0
[   63.160772][ T5885] R10: 00007f62b96f86c0 R11: 0000000000000246 R12: ffffffffffffff88
[   63.160777][ T5885] R13: 0000000000000010 R14: 00007ffee1c31da0 R15: 00007f62b8ef8000
[   63.160783][ T5885]  </TASK>
[   63.160785][ T5885]
[   63.160787][ T5885] Allocated by task 5882 on cpu 6 at 63.159725s:
[   63.160793][ T5885]  kasan_save_track+0x30/0x90
[   63.160799][ T5885]  __kasan_kmalloc+0x93/0xb0
[   63.160804][ T5885]  __kmalloc_cache_noprof+0x334/0x640
[   63.160810][ T5885]  nvmet_ports_make+0x93/0xdd0
[   63.160820][ T5885]  configfs_mkdir+0x4e2/0x930
[   63.160826][ T5885]  vfs_mkdir+0x33a/0x6f0
[   63.160831][ T5885]  filename_mkdirat+0x172/0x3a0
[   63.160836][ T5885]  __se_sys_mkdir+0x34/0x150
[   63.160841][ T5885]  do_syscall_64+0x166/0x520
[   63.160847][ T5885]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   63.160852][ T5885]
[   63.160853][ T5885] Freed by task 5882 on cpu 6 at 63.160484s:
[   63.160858][ T5885]  kasan_save_track+0x30/0x90
[   63.160863][ T5885]  kasan_save_free_info+0x40/0x50
[   63.160870][ T5885]  __kasan_slab_free+0x5c/0x80
[   63.160875][ T5885]  kfree+0x1d5/0x660
[   63.160883][ T5885]  config_item_release+0x13a/0x2d0
[   63.160890][ T5885]  configfs_rmdir+0x87c/0x940
[   63.160895][ T5885]  vfs_rmdir+0x23a/0x690
[   63.160900][ T5885]  filename_rmdir+0x1c8/0x420
[   63.160905][ T5885]  __se_sys_rmdir+0x2e/0x140
[   63.160911][ T5885]  do_syscall_64+0x166/0x520
[   63.160916][ T5885]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

etc.

Dmitry

