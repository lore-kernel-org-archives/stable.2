Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [46.38.247.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F9A1A6816;
	Fri,  3 Jul 2026 06:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.247.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060461; cv=none; b=dUIO/qaF0bGO6Bp9jKDkl0DZ5zPVOd0QmVBh6NPK1VOmonh3Q73IYKV/LRTPConrvurbN7r3JDwP9+7fRbH0dg4sg0kD76sQjHL1V/PQgC+IzWOUcWuu8gPvLjDDciBLNZx0SdGhT7W26VUifFR9e1BRJt0NN+rPAgwonNmq8A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060461; c=relaxed/simple;
	bh=wquMac3iXj0ao4VbxcoVDw1jeCiQnyRzUPYephGxJWI=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=HnttalywxptoH/xKs/xMWP6ftA1iQ+Om0/qoSYS7jm+bu5pIpQ4i1wIBd0LCH2bLTM2SpLjNJd2YE49G1hSKIklnymUoDGj8S0hnFBBWPYb4OXUvxDmCkSrP3AyYRG2qFKL9N2vdPMC171Z5u8KDs6VwmayLMDSDqIG5Rn1q4LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=jO+neQFa; arc=none smtp.client-ip=46.38.247.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="jO+neQFa"
Received: from mors-relay-8404.netcup.net (localhost [127.0.0.1])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4gs3r35lNTz87WN;
	Fri,  3 Jul 2026 08:34:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1783060451;
	bh=wquMac3iXj0ao4VbxcoVDw1jeCiQnyRzUPYephGxJWI=;
	h=Date:From:To:Cc:Subject:From;
	b=jO+neQFag7qS8Cgf8KU1wj+x/nI53fFdkKDx2K8wqjmvGTh7jm1rGT15FxgM09CWL
	 KT/1vzPjkCpWSEWIyDOBHn9+xkbPCWaWj2L074CoeXe4vP5Z89olWEj9vUqtU0n6n7
	 siMKD/UVZpHP3Z1C5JRpGbtvhnCa3CgbbRUKr7Xrucp0sXePPaIdyDTnYKLNwnEYX5
	 gI4WKp/0rWO3R7+61Z5srPavtLa3eU3f9HYt8Zw5JR9zZX293rIvlfaBtJU7ZZAZDs
	 ld4vsP+ngYqwswTfWq4winj3H6cJZS0YJvHxq7t/CfovPF4YxeheQVNPxjRuX74K33
	 Xp50OszJwfVmw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4gs3r352PZz4y3R;
	Fri,  3 Jul 2026 08:34:11 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gs3r30D8pz8sbF;
	Fri,  3 Jul 2026 08:34:10 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id A9DAC5F9DD;
	Fri,  3 Jul 2026 08:34:09 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <7ea1c4a0-d38f-413b-993b-7846b2b7debd@leemhuis.info>
Date: Fri, 3 Jul 2026 08:34:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
To: Chris Lu <chris.lu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
 linux-mediatek <linux-mediatek@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-bluetooth <linux-bluetooth@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: btmtk: regression in 6.6.142: NULL pointer dereference in
 btmtk_usb_hci_wmt_sync during resume from S4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178306045006.2570955.4688252285094479308@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: A9DAC5F9DD
X-NC-CID: VbNHS0oX1QXCKViIOo6Fnmu8ywTSde/sFR4qjOaanBJLN0ZeUKo=

Hi Chris & Sean! I noticed a report about a regression with btmtk that
happens in 6.6.y series. This strictly speaking is the domain of the
stable team, but maybe you want to take a look nevertheless:

https://bugzilla.kernel.org/show_bug.cgi?id=221696

To quote:
"""
I have a problem that appeared in the 6.6.y series recently, I believe
in or around f0457842215438786e2e205ad06a4fbb8ab63cd0, although I
haven't bisected. The problem did not exist in 6.6.140 but does exist in
6.6.142 and 6.6.143.

The problem — during resume from hibernation (platform S4) I see this
NULL pointer dereference in the kernel log:

BUG: kernel NULL pointer dereference, address: 0000000000000219
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] SMP
CPU: 7 PID: 214 Comm: kworker/u33:0 Not tainted 6.6.143-gentoo #1
Hardware name: Framework Laptop 16 (AMD Ryzen 7040 Series)/FRANMZCP09,
BIOS 04.03 12/22/2025
Workqueue: hci0 hci_power_on
RIP: 0010:__pm_runtime_resume+0x15/0x80
Code: 55 fe ff ff 83 e0 02 45 31 e4 e9 45 fd ff ff 66 0f 1f 44 00 00 f3
0f 1e fa 41 54 55 53 48 89 fb 48 83 ec…
RSP: 0018:ffffc90004a37c18 EFLAGS: 00010246
RAX: ffff88810bdcd4f8 RBX: 0000000000000050 RCX: 0000000000000000
RDX: 0000000000000035 RSI: 0000000000000004 RDI: 0000000000000050
RBP: 0000000000000035 R08: ffff888fdfde6bd0 R09: ffff888101338a40
R10: 0000000000000001 R11: 0000000000000040 R12: ffff888101338a40
R13: ffffc90004a37cc0 R14: 000000000000003a R15: ffffc90004a37cb4
FS:  0000000000000000(0000) GS:ffff888fdfdc0000(0000) knlGS:0000000000000000
GS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000219 CR3: 0000000003e11000 CR4: 0000000000750ee0
PKRU: 55555554
Call Trace:
 <TASK>
 usb_autopm_get_interface+0x1a/0x50
 btmtk_usb_hci_wmt_sync+0xb8/0x480
 ? btmtk_usb_wmt_recv+0x240/0x240
 btmtk_setup_firmware_79xx+0x1a4/0x360
 btusb_mtk_setup+0x45b/0x690
 hci_dev_open_sync+0xdd/0xa40
 ? try_to_wake_up+0x235/0x510
 hci_power_on+0x69/0x2b0
 ? lock_timer_base+0x6a/0x90
 process_one_work+0x154/0x2f0
 ? process_one_work+0x2f0/0x2f0
 worker_thread+0x18b/0x310
 kthread+0xe0/0x110
 ? kthread_complete_and_exit+0x30/0x30
 ret_from_fork+0x2c/0x40
 ? kthread_complete_and_exit+0x30/0x30
 ret_from_frok_asm+0x11/0x20
 </TASK>
CR2: 0000000000000219
---[ end trace 0000000000000000 ]---

The BUG dump appears while the system is waiting for me to enter my LUKS
passphrase — i.e., *before* the initramfs writes the swap device
major:minor to /sys/power/resume to initiate resume from hibernation.

I am still running kernel 6.6.140 in my current session. In other words,
a 6.6.143 kernel is booting to resume a suspended session that is
running a 6.6.140 kernel.
"""

This does not happen in mainline -- apparently it is fixed by
"Bluetooth: btmtk: move btusb_mtk_[setup, shutdown] to btmtk.c"

Ciao, Thorsten
