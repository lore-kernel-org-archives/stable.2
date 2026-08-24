Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8711389E1A;
	Mon, 24 Aug 2026 19:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787600340; cv=pass; b=G1+rqOIxXOmW3cQkkpGYkHGzQGX2fdbcr0Dx1fu/isd8W3GiRsJ++fcaW6SBAuFh8EjV4daYNYDr4NumZxV2PrSdLI3+1r2JXwHKq2YKfpUKcEOor/495CLClgmnG+JD1WXU+Pq16UVwaAJ6XcFCrkzV0cDTV21gLhc4mbIxYek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787600340; c=relaxed/simple;
	bh=zzC8oxef0Rad3VUGNVQApZrnjMMdjct48pTQxhspTJk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hze4st7tUyTuWoxb4MpUd/whtClY2EJWmA5i8k6LI0aPXuACKAheY55gTHgnnyhOh9QgGfcZXaJtZVV2GbqPsIv52GXT2ZNM9LuhTH2yA/71LgQ/e9b/XaCBjaBWXj0stdAm4yW5ouLiTM1qU9D2ca9KhZrA8B3qNUWCBkhoQUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=aAJSd/92; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="aAJSd/92"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:4:f011::d101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hTLnG29LNz49PwS;
	Mon, 24 Aug 2026 22:38:42 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1787600323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=52dnpwtEE19lOL9jeUDX35kTacMoZBiJyBPEYtV+t18=;
	b=aAJSd/92mY2VhG9u5LvmnWKVmQXbcOTKyOAnjG5XgpdKzfYYANvLDgFBQKpa6aNruTSOCg
	SbyoeDSS1N+5ylFmgRIOkAb3fbTPAm9UvrSiJjRThuG093Sg/5CLh84SbRX1zD8Cl3njN6
	lmMmelu8FfsYfbVM2duZC8NsDGRacZpgj8fH/L/qBlEfKGNdFujq8gb3MaWyfKviVrx5PI
	/F9W0GFUg/z7+jEefnH8JWI0mZHShUXUz4I7Ykx+w3tzKSjPOpmKmBvIEe1oaDtYlhpRiO
	iuZAU2vMC0gWXChE7VUZuILjMhFDBVGSNAtIwEVGV8kKWbUG7mrJnzPeE2Qp8w==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1787600323;
	b=UMApMQUKiFc+OSKfsKYrFnkRXjE8eAiTkgAINFfMGaJJ7F2AXngEbV5hXedoGcpU8X43XN
	Vm4PP3gCAQq/mWgbZ6/OMXOazT/ZgkjYjf4bTvuRoTjrZRQIxRuzal/tlmE7vJfetPFMeW
	RDG/IN0UWF7Q/uMWYgYtnXDdbUtXymTRmMQ1+HsG8YMuJoYlztLVUeg4NF02m8KossFPgU
	J1G8JzHELWFVq+CzkjgGh2tekw6D9CaiwPYd2ZX3AS/XpJMlpFmuJwPAoYi6diUwQvKhc1
	3QVAdhOfsqdIOi70O4B5iiPCD2s84l8EzstxfpkWiJrXneyouIU4bW4VooTWew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1787600323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=52dnpwtEE19lOL9jeUDX35kTacMoZBiJyBPEYtV+t18=;
	b=fE+KmZ/UnZy4/20M8eCr7a+eAYIUMeRAM142gkF97CNfFCO2Emb8v8+an4mbpEdkrnfSiH
	4A9Qz6Y3BnMrnk65PprgTYoQUqX2FMbgK34jRwKtmZwiuDez82JAUcU8zOxbdDPNXpU3fX
	skkx5k/F9zvpvS6g0NCS8hYT2Y4ZlGYCowBIaykB5L2mD0+TOZYIMl/5nsgieMbskavF+m
	3wBkOQ/ZkQPEEmRkpps3Slys6ZblhXKw+suoiJC2cnyCCBiXf2qqFyf90s0B4WRA/YdcZK
	iH9BlKH4MZy+wSY4q5PL/TEentvvPI+B3400kVt34fsUv4St7y/Z2078lJWxrA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <5e76a95e934e451e7006db28827c2d64af5a88be.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: RFCOMM: serialize security confirmation
 handling
From: Pauli Virtanen <pav@iki.fi>
To: patchwork-bot+bluetooth@kernel.org, Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Mon, 24 Aug 2026 22:38:40 +0300
In-Reply-To: <178759021163.3014491.6954824460297136867.git-patchwork-notify@kernel.org>
References: <20260822164341.3750491-1-nicoyip.dev@gmail.com>
	 <178759021163.3014491.6954824460297136867.git-patchwork-notify@kernel.org>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ma, 2026-08-24 kello 16:50 +0000, patchwork-bot+bluetooth@kernel.org
kirjoitti:
> Hello:
>=20
> This patch was applied to bluetooth/bluetooth-next.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>=20
> On Sun, 23 Aug 2026 00:43:41 +0800 you wrote:
> > rfcomm_security_cfm() looks up a session on session_list and then walks
> > its DLC list without holding rfcomm_mutex. Since RFCOMM session teardow=
n
> > uses rfcomm_mutex, krfcommd can close and free the same session and DLC=
s
> > concurrently:
> >=20
> >   hci_rx_work                    krfcommd
> >=20
> > [...]
>=20
> Here is the summary with links:
>   - Bluetooth: RFCOMM: serialize security confirmation handling
>     https://git.kernel.org/bluetooth/bluetooth-next/c/40c621391de9
>=20
> You are awesome, thank you!

I'm a bit too late now, but Sashiko report had some valid concerns
about lock ordering in this one:
https://sashiko.dev/#/patchset/20260822164341.3750491-1-nicoyip.dev%40gmail=
.com

Running both BlueZ l2cap-tester and rfcomm-tester (so lockdep sees more
paths) in same boot you get lockdep splat.

Not immediately clear that a real deadlock could be triggered, but
lockdep thinks the ordering is now inconsistent.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
7.2.0-rc6-01463-gfe3897b4ab57 #994 Not tainted
------------------------------------------------------
rfcomm-tester/364 is trying to acquire lock:
ffff8880027d40b0 (&hdev->lock){+.+.}-{4:4}, at: l2cap_chan_connect (net/blu=
etooth/l2cap_core.c:7271)

but task is already holding lock:
ffffffff99499f58 (rfcomm_mutex){+.+.}-{4:4}, at: rfcomm_dlc_open (net/bluet=
ooth/rfcomm/core.c:426)

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (rfcomm_mutex){+.+.}-{4:4}:
__mutex_lock (kernel/locking/mutex.c:646)
rfcomm_security_cfm (net/bluetooth/rfcomm/core.c:2222)
hci_auth_complete_evt (./include/net/bluetooth/hci_core.h:2246 net/bluetoot=
h/hci_event.c:3554)
hci_event_packet (net/bluetooth/hci_event.c:7887)
hci_rx_work (net/bluetooth/hci_core.c:4041)
process_scheduled_works (kernel/workqueue.c:3322)
worker_thread (kernel/workqueue.c:3486)
kthread (kernel/kthread.c:436)
ret_from_fork (arch/x86/kernel/process.c:158)
ret_from_fork_asm (arch/x86/entry/entry_64.S:245)

-> #1 (hci_cb_list_lock){+.+.}-{4:4}:
__mutex_lock (kernel/locking/mutex.c:646)
hci_remote_ext_features_evt (./include/net/bluetooth/hci_core.h:2207 net/bl=
uetooth/hci_event.c:5030)
hci_event_packet (net/bluetooth/hci_event.c:7887)
hci_rx_work (net/bluetooth/hci_core.c:4041)
process_scheduled_works (kernel/workqueue.c:3322)
worker_thread (kernel/workqueue.c:3486)
kthread (kernel/kthread.c:436)
ret_from_fork (arch/x86/kernel/process.c:158)
ret_from_fork_asm (arch/x86/entry/entry_64.S:245)

-> #0 (&hdev->lock){+.+.}-{4:4}:
__lock_acquire (kernel/locking/lockdep.c:3165)
lock_acquire (kernel/locking/lockdep.c:5868)
__mutex_lock (kernel/locking/mutex.c:646)
l2cap_chan_connect (net/bluetooth/l2cap_core.c:7271)
l2cap_sock_connect (net/bluetooth/l2cap_sock.c:255)
kernel_connect (net/socket.c:3726)
rfcomm_dlc_open (net/bluetooth/rfcomm/core.c:808)
rfcomm_sock_connect (net/bluetooth/rfcomm/sock.c:421)
__sys_connect (net/socket.c:2135)
__x64_sys_connect (net/socket.c:2160 net/socket.c:2157 net/socket.c:2157)
do_syscall_64 (arch/x86/entry/syscall_64.c:63)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

other info that might help us debug this:

Chain exists of:
&hdev->lock --> hci_cb_list_lock --> rfcomm_mutex

Possible unsafe locking scenario:

CPU0                    CPU1
----                    ----
lock(rfcomm_mutex);
                        lock(hci_cb_list_lock);
                        lock(rfcomm_mutex);
lock(&hdev->lock);

*** DEADLOCK ***

1 lock held by rfcomm-tester/364:
#0: ffffffff99499f58 (rfcomm_mutex){+.+.}-{4:4}, at: rfcomm_dlc_open (net/b=
luetooth/rfcomm/core.c:426)

stack backtrace:
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-10.fc44 06/=
10/2025
Call Trace:
<TASK>
print_circular_bug (kernel/locking/lockdep.c:2043)
check_noncircular (kernel/locking/lockdep.c:2175)
__lock_acquire (kernel/locking/lockdep.c:3165)
? stack_trace_save (kernel/stacktrace.c:122)
? add_lock_to_list (./include/linux/find.h:391 kernel/locking/lockdep.c:140=
3 kernel/locking/lockdep.c:1434)
? __lock_acquire (kernel/locking/lockdep.c:191 kernel/locking/lockdep.c:391=
2 kernel/locking/lockdep.c:5237)
lock_acquire (kernel/locking/lockdep.c:5868)
? l2cap_chan_connect (net/bluetooth/l2cap_core.c:7271)
__mutex_lock (kernel/locking/mutex.c:646)
? l2cap_chan_connect (net/bluetooth/l2cap_core.c:7271)
? lock_acquire (kernel/locking/lockdep.c:5868)
? hci_get_route (net/bluetooth/hci_conn.c:1331)
? lock_release (kernel/locking/lockdep.c:5350)
? hci_get_route (net/bluetooth/hci_conn.c:1379)
? l2cap_chan_connect (net/bluetooth/l2cap_core.c:7271)
l2cap_chan_connect (net/bluetooth/l2cap_core.c:7271)
? l2cap_sock_connect (net/bluetooth/l2cap_sock.c:193)
l2cap_sock_connect (net/bluetooth/l2cap_sock.c:255)
kernel_connect (net/socket.c:3726)
rfcomm_dlc_open (net/bluetooth/rfcomm/core.c:808)
rfcomm_sock_connect (net/bluetooth/rfcomm/sock.c:421)
? __pfx_rfcomm_sock_connect (net/bluetooth/rfcomm/sock.c:?)
__sys_connect (net/socket.c:2135)
__x64_sys_connect (net/socket.c:2160 net/socket.c:2157 net/socket.c:2157)
do_syscall_64 (arch/x86/entry/syscall_64.c:63)
? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
? trace_hardirqs_off (./include/trace/events/preemptirq.h:36)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
RIP: 0033:0x7f2b9c05854e
Code: 4d 89 d8 e8 b4 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 =
f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 8=
3 fa 08 75 e7 e8 03 ff ff ff 0f 1f 00 f3 0f 1e fa
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	4d 89 d8             	mov    %r11,%r8
   3:	e8 b4 bd 00 00       	call   0xbdbc
   8:	4c 8b 5d f8          	mov    -0x8(%rbp),%r11
   c:	41 8b 93 08 03 00 00 	mov    0x308(%r11),%edx
  13:	59                   	pop    %rcx
  14:	5e                   	pop    %rsi
  15:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
  19:	74 11                	je     0x2c
  1b:	c9                   	leave
  1c:	c3                   	ret
  1d:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  24:	48 8b 45 10          	mov    0x10(%rbp),%rax
  28:	0f 05                	syscall
  2a:*	c9                   	leave		<-- trapping instruction
  2b:	c3                   	ret
  2c:	83 e2 39             	and    $0x39,%edx
  2f:	83 fa 08             	cmp    $0x8,%edx
  32:	75 e7                	jne    0x1b
  34:	e8 03 ff ff ff       	call   0xffffffffffffff3c
  39:	0f 1f 00             	nopl   (%rax)
  3c:	f3 0f 1e fa          	endbr64

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	c9                   	leave
   1:	c3                   	ret
   2:	83 e2 39             	and    $0x39,%edx
   5:	83 fa 08             	cmp    $0x8,%edx
   8:	75 e7                	jne    0xfffffffffffffff1
   a:	e8 03 ff ff ff       	call   0xffffffffffffff12
   f:	0f 1f 00             	nopl   (%rax)
  12:	f3 0f 1e fa          	endbr64
RSP: 002b:00007fff41018e50 EFLAGS: 00000202 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00000000004fbee0 RCX: 00007f2b9c05854e
RDX: 000000000000000a RSI: 00007b2b99ad7e60 RDI: 000000000000000d
RBP: 00007fff41018e60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007b2b99ad7e40
R13: 00007b2b99ad7e60 R14: 000000000000000d R15: 00007b8b9ade0140
</TASK>


--=20
Pauli Virtanen
