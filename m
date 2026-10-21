Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583520;
	b=W6a9805kR63JFuSBGiaFY8YB9bc7t8n1OP4myWey1i9GJD8BQ2/WZxQ/xmI9eouKj28U
	 deN2NyJiifcnw3ojjqWJRFCPs+JXr2poPDmFwGVyfrhphDcy2mJrwiUpO+zEwgPfyvJ2C
	 /KK1/lM4m5+eWOTxwNFEuog7EGhy4e2Vs5LxFEHnAAI3jTsprgSSOSfMNJ4DmIIquL6K3
	 lK1ee3cPkI334JgEvPZXfpX9WCwGfi7oSEqt5s714y+W4fKAcpcEbaL4u1d88whhtnDZK
	 o6hb+BevSoJno9ZxRx7c17SdsSvWcuNPZnT9i2YEwaw47TJi7HPe0MbytZyqIShhmig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583520;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8+uhPZSAcrIBVQRFHA3AjpuARr+Y5uh4d7ju5klGlzE=;
	b=DsB/j+VVvqk6rZOm9MFzTWXwL0wYHFx2MUWhCVIV/wSH486bIgr7k3Kv51PktyDi8Zfq
	 AQyTm1yYePHyN1B99nXfbcNRJq1QYE77jIGqX5TPIp5CQ7W5XAJ+P9gvjpzqezqGqNj9U
	 cxafzylZraTchkl2ZfFRPnXvHcdrR/yP8RuYCb93bhSvS9qTG0/jNDEDEF/qCCLtEGG/s
	 8/mrcLgk5dtAXUB9BGqkbdoIB+z6CRZq6Y2HajDSbZuCoGbJnCllO+4vBT50oP5DdY+O7
	 psdViXyv5XuEEG2mD0R+KRS54SZc6GraO1Cn8/6MS5T5yJk9VesHEg1aIkm08brE9XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PaFMpquh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id C547D606A330;
	Wed, 21 Oct 2026 11:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PaFMpquh
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 225C41F000C4;
	Wed, 21 Oct 2026 11:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583519;
	bh=8+uhPZSAcrIBVQRFHA3AjpuARr+Y5uh4d7ju5klGlzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PaFMpquhWfs9AjCJcWqAxr2pJDk2EP+jvDiazGWfurMpt29HXvJzjzX7nLUWKWUa5
	 IJnwObm7CvlCikN3jQ1dfZk+K6LR8clGd4eVwfgFy29C8sNApPK4SLbopmXVzGXoBP
	 8TyqCZcJyY31lbOVdN+/XDKoGXtO86Wm8n186DB6gwRzSHD0WeRBRvrFvsHB6kendB
	 4fOTgyRFULJbSLyuE6i71lafZ1ICwBJC/GhXCWE5thyWUEjiKdFMrs4YyMTZS9SrQH
	 TAwW4dpwDPI7VArxk4+0szI+YM3JaBAh4imjcil/wk5gtOEW8vHWzAx/EYHXVD0Feq
	 M6BuzMdv5aaMQ==
Date: Wed, 21 Oct 2026 14:51:55 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: syzbot ci <syzbot+ci05eb01a9f28bbd7c@syzkaller.appspotmail.com>
Cc: corbet@lwn.net, dhowells@redhat.com, ebiggers@kernel.org,
	jannh@google.com, jmorris@namei.org, keyrings@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, paul@paul-moore.com,
	rdunlap@infradead.org, serge@hallyn.com, skhan@linuxfoundation.org,
	stable@vger.kernel.org, syzbot@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot ci] Re: KEYS: Return user session keyring on lookup
Message-ID: <atinW_xXMbDrG_0Y@kernel.org>
References: <20261019145624.309790-1-jarkko@kernel.org>
 <6ad875b6.e74039fe.1cb511.0000.GAE@google.com>
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
In-Reply-To: <6ad875b6.e74039fe.1cb511.0000.GAE@google.com>

On Wed, Oct 21, 2026 at 01:20:06AM -0700, syzbot ci wrote:
> syzbot ci has tested the following series
> 
> [v2] KEYS: Return user session keyring on lookup
> https://lore.kernel.org/all/20261019145624.309790-1-jarkko@kernel.org
> * [PATCH v2 1/2] KEYS: Return user session keyring on lookup
> * [PATCH v2 2/2] KEYS: Reject keyring creation with overridden credentials
> 
> and found the following issue:
> general protection fault in keyctl_session_to_parent
> 
> Full report is available here:
> https://ci.syzbot.org/series/7566814a-52ba-4f0b-b506-d7adf67fda29
> 
> ***
> 
> general protection fault in keyctl_session_to_parent
> 
> tree:      linux-next
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next
> base:      17a7501b9612a52b38bc57e33c7b64636d438bc0
> arch:      amd64
> compiler:  Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
> config:    https://ci.syzbot.org/builds/eee373c7-f447-49cf-a350-83830580c7b2/config
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc000000001b: 0000 [#1] SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
> CPU: 0 UID: 0 PID: 5730 Comm: syz.0.6 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> RIP: 0010:keyctl_session_to_parent+0x825/0xa30
> Code: 35 3b fd e9 fe fa ff ff e8 38 35 3b fd e9 f4 fa ff ff e8 2e 35 3b fd 48 8b 54 24 20 48 81 c2 d8 00 00 00 48 89 d0 48 c1 e8 03 <0f> b6 04 18 84 c0 0f 85 b2 01 00 00 8b 2a 89 ef 8b 5c 24 1c 89 de
> RSP: 0018:ffffc9000621fc70 EFLAGS: 00010006
> RAX: 000000000000001b RBX: dffffc0000000000 RCX: ffff88810b603c00
> RDX: 00000000000000d8 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
> R10: dffffc0000000000 R11: fffff52000c43f7c R12: ffff88811a010000
> R13: 0000000000000000 R14: ffff88810c2631a8 R15: 0000000000000000
> FS:  00007f7f2068b6c0(0000) GS:ffff88818c4bf000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f7f2068aff8 CR3: 000000010cae8000 CR4: 00000000000006f0
> Call Trace:
>  <TASK>
>  __se_sys_keyctl+0x780/0x9d0
>  do_syscall_64+0x166/0x520
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f7f1f79f559
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f7f2068b028 EFLAGS: 00000246 ORIG_RAX: 00000000000000fa
> RAX: ffffffffffffffda RBX: 00007f7f1fa26270 RCX: 00007f7f1f79f559
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000012
> RBP: 00007f7f1f836b20 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f7f1fa26308 R14: 00007f7f1fa26270 R15: 00007ffe789f59b8
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:keyctl_session_to_parent+0x825/0xa30
> Code: 35 3b fd e9 fe fa ff ff e8 38 35 3b fd e9 f4 fa ff ff e8 2e 35 3b fd 48 8b 54 24 20 48 81 c2 d8 00 00 00 48 89 d0 48 c1 e8 03 <0f> b6 04 18 84 c0 0f 85 b2 01 00 00 8b 2a 89 ef 8b 5c 24 1c 89 de
> RSP: 0018:ffffc9000621fc70 EFLAGS: 00010006
> RAX: 000000000000001b RBX: dffffc0000000000 RCX: ffff88810b603c00
> RDX: 00000000000000d8 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
> R10: dffffc0000000000 R11: fffff52000c43f7c R12: ffff88811a010000
> R13: 0000000000000000 R14: ffff88810c2631a8 R15: 0000000000000000
> FS:  00007f7f2068b6c0(0000) GS:ffff88818c4bf000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f7f2068aff8 CR3: 000000010cae8000 CR4: 00000000000006f0
> 
> 
> ***
> 
> If these findings have caused you to resend the series or submit a
> separate fix, please add the following tag to your commit message:
>   Tested-by: syzbot@syzkaller.appspotmail.com
> 
> ---
> This report is generated by a bot. It may contain errors.
> syzbot ci engineers can be reached at syzkaller@googlegroups.com.
> 
> To test a fix for this bug, please reply with `#syz test`
> (on a separate line) and attach the patch to the email.
> 
> Notes:
> - The patch will be applied on top of the tested series (as an
>   incremental fix).
> - To test a new version of the whole series, please send it directly
>   to syzbot@lists.linux.dev.
> - Arguments like custom git repos and branches are not supported.

This helps, I save this to my TODO-folder (no time to address this
week).

Br, Jarkko
