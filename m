Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794595844;
	b=mDZKL8BPb3YlXyO3nUlY5GKMpg8ji7l8yJYgyJ+ORvR4TJ7r0SPv+3GYgCezAk2nxoRB
	 si/SLWhYdW3k1v1y77OwlyVO4kIQbhaQ6OYRYlnNz6OWYUX+dPy1hS1+rxrgbuRHxwYgC
	 BvhTvaifW8PoJqZucEp90uAnJnJdGxQy2+7cDJfwG9ZTlGm/2iTjp4rbabY/TIbEZNAc/
	 fdZjx0bQfnvDIrDWjwCQr6P3aw/PEO6RgHalg4Cms6HtWvmuyqPD5TIydcZEYVacyAEm4
	 jlBdkGseMGsLC/DZ66LNlMdUfLHfmkeObLN527Al0bRVSxkNG12mP14YmujS14iue6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794595844;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Debian-User;
	bh=MgeHtv+mqNFsSO+P+3k/hTr/fpbYj2PhQuyDxZDnze4=;
	b=OTeSscUctWLVlXITlBggw+3u/2lDRORkfe9Oj5LVyyIv8Y6gjofMN0LA2yH/lZIr3a55
	 blBpQtBEdNfq/XOeRydIn7OBePEZPEWV+uJ1sSkXAOiDgHqZtBP1QnvfrFYe0bg7eNx0i
	 TOFmJ/aBv3Kdrg4OWcN2nXyTxpdAWnZ34+xs2BEUQ8QFucRMFJw2Gb/NihNeRbn+ipNjR
	 IwBP88LU2AFP3CUJltZqN/ZMEUZgfVUWjxAu95k4E9+mMXyaQKgavzO6XY5TT9t+/JdYj
	 EjcvBYMM+7G+y4JW8cs80UODo404vSf5bN4ZhjVlfDSDpiuXFw5XWJPK3cr6S/N5gsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=U3JNPpvc;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53838606A331;
	Fri, 13 Nov 2026 18:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53838606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=U3JNPpvc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MgeHtv+mqNFsSO+P+3k/hTr/fpbYj2PhQuyDxZDnze4=; b=U3JNPpvcUep03+7zABuvnn2XEn
	hGQA26NULGOfBIiX/buseMe874LrZTL0opH32KsrZ4zsiQAdkGWocO7BfXxvC345MZuMJzC/ZvWl5
	mWKOI5x03InGYASv8pdiMR5MrphjwxwaXoJfZWmsnav+1UYFN6P0YTByW3YyBylBpM8btTHDh/q+Q
	tJqccPCqLcDrzXiImNUAEc0YXclmuEvsj3rLkLWEQ+I9qoXnV50AxrRmwZVqEoauS44F17W3FUpH5
	gwUgUkCmLDc/UF2PHXL/ZtGhtDx/tkxn70MYBS75jNVEEQoP8XzB/8nPaiqH4JsLQzm83g8a/18RU
	90ZAxx4w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <carnil@debian.org>)
	id 1xRwM0-00Exf5-37;
	Fri, 13 Nov 2026 18:50:29 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 17FF9DC0390; Fri, 13 Nov 2026 19:50:28 +0100 (CET)
Date: Fri, 13 Nov 2026 19:50:28 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Mike Rapoport <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION 6.12.117] CPA detected W^X violation:
 0000000000000121 -> 0000000000000123 range: 0xffffffffc0477000 -
 0xffffffffc0477fff PFN 109c1f and WARNING at
 arch/x86/mm/pat/set_memory.c:665 __change_page_attr_set_clr+0xf62/0xfb0
Message-ID: <avdb9EPXBv2hRCzQ@eldamar.lan>
References: <avcG_ggetL8ArwAx@eldamar.lan>
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
In-Reply-To: <avcG_ggetL8ArwAx@eldamar.lan>
X-Debian-User: carnil

Hi,

On Fri, Nov 13, 2026 at 01:47:58PM +0100, Salvatore Bonaccorso wrote:
> Hi
> 
> While updating from 6.12.116 to 6.12.117 on one system the following
> warning is seen:
> 
> [    0.991048] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [    0.992476] Run /init as init process
> [    0.993426]   with arguments:
> [    0.993428]     /init
> [    0.993428]   with environment:
> [    0.993429]     HOME=/
> [    0.993429]     TERM=linux
> [    1.091378] ------------[ cut here ]------------
> [    1.092538] CPA detected W^X violation: 0000000000000121 -> 0000000000000123 range: 0xffffffffc0477000 - 0x
> ffffffffc0477fff PFN 109c1f
> [    1.093994] WARNING: CPU: 5 PID: 222 at arch/x86/mm/pat/set_memory.c:665 __change_page_attr_set_clr+0xf62/0xfb0
> [    1.095730] Modules linked in:
> [    1.097101] CPU: 5 UID: 0 PID: 222 Comm: (udev-worker) Not tainted 6.12.117+deb13-amd64 #1  Debian 6.12.117-1
> [    1.098671] Hardware name: LENOVO 20XXS1FU00/20XXS1FU00, BIOS N32ETA2W (1.78 ) 07/23/2026
> [    1.100096] RIP: 0010:__change_page_attr_set_clr+0xf62/0xfb0
> [    1.101357] Code: 09 ea e9 19 fa ff ff 48 8b 4c 24 10 49 89 d9 4c 89 d6 48 89 54 24 08 48 c7 c7 38 43 95 a6 c6 05 d1 fd d7 01 01 e8 9e 76 01 00 <0f> 0b 48 8b 54 24 08 e9 22 fc ff ff 80 3d ba fd d7 01 00 0f 85 15
> [    1.102928] RSP: 0018:ffffd02d40557648 EFLAGS: 00010286
> [    1.104241] RAX: 0000000000000000 RBX: 0000000000109c1f RCX: 0000000000000003
> [    1.105561] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000001
> [    1.107204] RBP: 0000000109c1f121 R08: 0000000000000000 R09: ffffd02d405574c8
> [    1.108503] R10: ffffffffa70b43a8 R11: 0000000000000003 R12: 0000000000000001
> [    1.109816] R13: 0000000109c1f121 R14: 0000000000000001 R15: ffffffffc0477000
> [    1.111556] FS:  00007fcf08a6b980(0000) GS:ffff88c4bf680000(0000) knlGS:0000000000000000
> [    1.112888] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.114279] CR2: 000055cf7979a138 CR3: 000000014061e006 CR4: 0000000000f70ef0
> [    1.115600] PKRU: 55555554
> [    1.116935] Call Trace:
> [    1.118345]  <TASK>
> [    1.119677]  ? __purge_vmap_area_lazy+0x13c/0x320
> [    1.120979]  ? _vm_unmap_aliases+0x217/0x260
> [    1.122392]  change_page_attr_set_clr+0x104/0x1a0
> [    1.123702]  set_memory_rw+0x28/0x40
> [    1.125019]  apply_retpolines+0x19c/0x4c0
> [    1.126404]  module_finalize+0x209/0x3e0
> [    1.127690]  ? add_kallsyms+0x293/0x310
> [    1.128985]  load_module+0x17f1/0x1e90
> [    1.130318]  ? init_module_from_file+0x89/0xe0
> [    1.131586]  init_module_from_file+0x89/0xe0
> [    1.132873]  idempotent_init_module+0x11e/0x310
> [    1.134175]  __x64_sys_finit_module+0x5e/0xb0
> [    1.135433]  do_syscall_64+0x87/0x1b0
> [    1.136706]  ? vfs_read+0x24d/0x370
> [    1.137967]  ? __x64_sys_pread64+0x98/0xd0
> [    1.139652]  ? arch_exit_to_user_mode_prepare.isra.0+0x16/0xa0
> [    1.140905]  ? syscall_exit_to_user_mode+0x37/0x1b0
> [    1.142172]  ? do_syscall_64+0x93/0x1b0
> [    1.143402]  ? __count_memcg_events+0x53/0xf0
> [    1.144644]  ? count_memcg_events.constprop.0+0x1a/0x30
> [    1.145859]  ? handle_mm_fault+0x1bb/0x2c0
> [    1.147452]  ? do_user_addr_fault+0x367/0x650
> [    1.148626]  ? clear_bhb_loop+0x70/0xc0
> [    1.149809]  ? clear_bhb_loop+0x70/0xc0
> [    1.151303]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    1.152445] RIP: 0033:0x7fcf095cf4f9
> [    1.153586] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e7 68 0d 00 f7 d8 64 89 01 48
> [    1.155067] RSP: 002b:00007fffd10634a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [    1.156238] RAX: ffffffffffffffda RBX: 000055cf79783110 RCX: 00007fcf095cf4f9
> [    1.157419] RDX: 0000000000000004 RSI: 00007fcf07cf944d RDI: 0000000000000010
> [    1.158766] RBP: 0000000000000004 R08: 0000000000000000 R09: 000055cf79763ba0
> [    1.159927] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fcf07cf944d
> [    1.161090] R13: 0000000000020000 R14: 000055cf79784bc0 R15: 0000000000000000
> [    1.162318]  </TASK>
> [    1.163460] ---[ end trace 0000000000000000 ]---
> 
> I'm attaching for comparison as well the log from 6.12.116 which does
> not show any CPA detected W^X violation message, while the 6.12.117
> shows it twice, with one WARNING.

One followup to this. Reverting 

Fixes: 091c44b2d3c3 ("x86/mm/pat: Use pr_warn() for early W^X warnings")
Fixes: 11d1ba991c07 ("x86/mm/pat: Fix effective RW computation in lookup_address_in_pgd_attr()")

"fixes" the problem.

Testing 6.12.118-rc1 which is on review does not change nothing, but
that is not surprising as I think there are no changes in that area.

On the other hand though testing 7.3.5-rc1 which is currently under
review only logs:

[    0.096682] CPA detected W^X violation: 8000000000000123 -> 0000000000000123 range: 0xffffffffc0200000 - 0xffffffffc0200fff PFN 100800

but no WARNING anymore.

Regards,
Salvatore
