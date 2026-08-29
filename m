Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCD53911B2
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 12:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788005313; cv=pass; b=BToL17wNMKO1rM8ePDgc49jDMrnHdRl3RnNxrJhH5ZPuSN9qusRuEWvE+01Q15fuGZO2YDN+wyryjELAVUu4B6WFxKNMUeNUqMZLanjs8/vwwBglvUlE8qOsnlidaoDHQLhiRL7lZMfWwcglBeZbdsk7ZnzT8COuS1lmnfXJErw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788005313; c=relaxed/simple;
	bh=tQUKXlNTZncrUhNQmphCWATOb6CXmwvTT39QZmvWEM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecqLnwNlTuNKEjSBQbN/+q7BpcNH/raOm+9l9PavOFnyx7H/ySypAYjB/zZxfP2r4skcsuqeIzoRpAXGp9CgPEeZQEQtK5cF2UOGCgyerNGBJ9gKD5ySN9uxVVmhDyfHtT55NojoxlDopnvarDaw1fFLb+c+lIbHHNfj6GJJALU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=F53dUAkO; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="F53dUAkO"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a5e392b2b3so2961100a12.1
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 05:08:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788005307; cv=none;
        d=google.com; s=arc-20260327;
        b=WtHRyZijG/raop4kp1vmXINNQtNgouKMFHfzuJDGVQcM889aG42lIw56PCSlzPSGUa
         py/l0CbyjQ258Y0Adc6aYgfB0BluodAhAOydT5abOun3Fp8zlXdcMvmbDru5kPLrP21t
         iHhv5Gxqz7LhTBKP3chnMsPZS7ud6WgfZgfF/rTNTtMiYTpBMO2AOGMFaJZSGvuQS2xl
         GJ/5mpzpcmDU2ojDx2aM3JjIcJqo+qX32yaCPsN9XJmqDBt4tD+EydJiCCz2SIZQEnTn
         T+v7PlgnOGtEIhiaiD7p6E97JD+v0iGQpD5H180x3vDtp0Z5jsVsedpdiayaVO8qJ4X9
         A4Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0LNkmPbjXKyWzeW6QFwcfhv4j9OUYOYxh6NX4vDrFsg=;
        fh=Y/HAzRtlOQagX5fk1x7k2JaqKGKN/zdvNQYKQdbwwIE=;
        b=JtvhmUUQ0s4PzBdy1SWMHn3m163eA2wPoIpGXRhLJBRKpr0TNdqEQasY5fW8tRZuud
         vB2POhUD/A1LrABftIgoHNkPmaLhi8ribtjBa5c5ueRbHCLopkN0lkHLNPwSONlE6dwv
         8JWYiFbY4hTiJlnCAvKqQVt+1RV/Xan0ciJXEaUACdAsn/EnDQoErQlR7c8HxkM+TY3r
         KZoDaeTX19CUbFZF6fYYjAV933czQxFkokiMinB7ALegySZloESUEEX3nW6gzwenTwj5
         W+GZChvfuQBUvkSOsUCqkI0YQigz/E89UdjgFO/LX0Frg1rzHTHJxaptaBnYyccKE+oJ
         JCMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1788005307; x=1788610107; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0LNkmPbjXKyWzeW6QFwcfhv4j9OUYOYxh6NX4vDrFsg=;
        b=F53dUAkO3uSxoA6Fjc2RRtPzwCB1bntSF3dTYGk11BE8czIJ3nZUCzfVywT7Z9Gcnb
         8C9knq9tTjNLn+MatfDb3Q0tjvYjEwixQ3CeDzWgOnMS1BWfV/VskVH2U0JJ5ul7etXb
         QTIrGPSY7St/Wmk9T9joTr9dakvNV4n+eyeqX6ISWsWbubnSBETmyxTqKobHsaB6DtAK
         3brcMuZQBmLaUDMhPJySv81lNoXbfomeibz6HFCjQQ6SuNXc5EpeF3cpXW4XbEez8PPx
         ZEZ9eWELulMU2kpE9w7LoK2+mFp/uu99UbDsnbXC0Qh6xm/lK9Go0HAmX3CW1K5sn+FC
         aA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788005307; x=1788610107;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0LNkmPbjXKyWzeW6QFwcfhv4j9OUYOYxh6NX4vDrFsg=;
        b=NIywABPeZhvJooSbpNmITGjW9T27cTQ079ii7YOKP7KAaAq/77q13pO17NjBJoK6S9
         frBIEuJQPhfJ3gq0HdiYrIiABWiiOh1ZoymgCmnkrOfk2nkGpRkQhahdqq/4HSCVf3qo
         WUhsQzOlbbxRI4qQtJZf95qz7Vxnbp9evuKu4oHxdn+kQbhgEa9KkBsLQnVipv+KeU4D
         O+T+dVfQvBBuVvdaSGVF02TlHRha8Eq7/Tvf3nYuiiOfExIpjrmG/toCvHctrpmGo3eN
         F7jIsNOkcwa0gNor1vl67EcGGntSaGNsDLdfJRK/qqYFrbNrCTyV4B9hu3FW4OWb+TYv
         Ugog==
X-Forwarded-Encrypted: i=1; AKwUvBxHzoywEs/vauI+rah1BZeqTxN2aHHnXYy6amQj4sW7kZGLvN+GQQ8xLpT7jBJLA2m2WH266QA=@vger.kernel.org
X-Gm-Message-State: AFuF++lgfPc7bKdXPiC8Co4yl5m9xy4fCXjprgL4h08FrhtHBHF49GZH
	KnJbHYiTHYlg0kexYZpGohtsJcfzzKCwRNd1AaU7sTzHAKmmhVw6x1LI3S4cYqr9qYSI+TxJoXL
	djP+UsNgUCDlcEhFnF3jMvYp8dgJUaBdCEJHloJXqe+reTzusHeYRzM4=
X-Gm-Gg: AYBFou0m9cxccwmw7f2prZm/9pKgBzQoy1Qe9IvRfiOQtOeX6Bs4sR/o9Mvrp/yItPd
	qzYoxRgVZuz1kRewF6nl412Q6g8CNV8776m2xtshEYn1A0Fl2vFdJNkGv3zDGzWk+kUhPGD+3Jb
	BrQartVEqtin8GxNRTTTtyn8h19nMPX0pzQOoEYgbZbfv+APcnilwGtvCD0m9XFbqRljTmQvXgn
	c69Mw/uTzPVFzeFNNmye4EWXd5FSbuHm4PfBrkQ91QRBVjZ/PdoiLDQ8wfToTMuv0YzAzoT8bTw
	24EcdPc/hdIuBY0XUF9MpV+2Zb8YvzlmZRdmQMgwBoYaQw==
X-Received: by 2002:a05:6402:2713:b0:6a1:b515:d2b9 with SMTP id
 4fb4d7f45d1cf-6a60d3ae3b7mr8744947a12.14.1788005306552; Sat, 29 Aug 2026
 05:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828-b4-ceph-fix-null-oldest-snapc-new-v1-1-dd0e57179f9e@clyso.com>
In-Reply-To: <20260828-b4-ceph-fix-null-oldest-snapc-new-v1-1-dd0e57179f9e@clyso.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Sat, 29 Aug 2026 05:08:12 -0700
X-Gm-Features: AcwNN1VVOJQiL89hwmTYVakk7YqfTBg1vr0ykT3FaDiL-XUJI7L2Cspuog2strY
Message-ID: <CAOJNxR+t91Dy9JH9BXpZ1jMZXJw7uq4c-=udVWo3L7g2Z0OXWA@mail.gmail.com>
Subject: Re: [PATCH] ceph: handle a NULL oldest snap context in writeback
To: xiubo.li@clyso.com
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There is a bug in V1 and I will send the V2.

Thanks.

On Fri, 28 Aug 2026 at 00:20, Xiubo Li via B4 Relay
<devnull+xiubo.li.clyso.com@kernel.org> wrote:
>
> From: Xiubo Li <xiubo.li@clyso.com>
>
> get_oldest_context() returns NULL when the inode has no dirty capsnaps
> and no head writeback references.  That is a legal return value that
> context_is_writeable_or_written() handles explicitly, but
> ceph_find_incompatible() and write_folio_nounlock() dereference the
> returned pointer without checking:
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000008
>   #PF: supervisor read access in kernel mode
>   ...
>   RIP: 0010:ceph_find_incompatible+0x75/0x1d0 [ceph]
>
> Skip the sequence comparison when there is no oldest context: with no
> dirty accounting there is nothing for the folio's snap context to
> conflict with and the folio is writable.  In write_folio_nounlock()
> also fill the writeback ctl with the inode's current size and truncate
> state in that case, since get_oldest_context() only fills it on the
> capsnap and head paths and the uninitialized ctl would otherwise be
> used for the EOF check and the OSD request.
>
> Fixes: 80e755fedebc ("ceph: allow writeback of snapped pages older than '=
oldest' snapc")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> ---
> I can reproduce this 100% with my test script.
>
> The detail call trace:
>
> <4>[  967.890589] RIP: 0010:ceph_find_incompatible+0x75/0x1d0 [ceph]
>   <4>[  967.890606] Code: 41 5c 41 5d c3 cc cc cc cc 49 39 9c 24 10 08 00=
 00 0f 84 e0 00 00 00 31 f6 4c 89 e7 31 d2 e8 e2 a5 ff ff 48 8b 73 08 48 89=
 c7 <48> 39 70 08 0f 82 ca 00 00 00 e8 8c 92 fc ff 66 90 48 89 ef e8 62
>   <4>[  967.890608] RSP: 0000:ffffcdb64d5c7878 EFLAGS: 00010292
>   <4>[  967.890610] RAX: 0000000000000000 RBX: ffff8d5e414e6ec0 RCX: ffff=
8d5e5d239088
>   <4>[  967.890611] RDX: 0000000000000003 RSI: 0000000000000001 RDI: 0000=
000000000000
>   <4>[  967.890612] RBP: fffffbb08ce01d80 R08: ffffffffb1e031c0 R09: 0000=
00008ae38e38
>   <4>[  967.890620] R10: 000000000000000a R11: ffff8d5e5d238000 R12: ffff=
8d601d0c2a00
>   <4>[  967.890621] R13: ffff8d5e515c0000 R14: ffff8d5e4b686300 R15: 0000=
000000000001
>   <4>[  967.890622] FS:  00007f4a83fff6c0(0000) GS:ffff8d61f9904000(0000)=
 knlGS:0000000000000000
>   <4>[  967.890624] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   <4>[  967.890625] CR2: 0000000000000008 CR3: 00000001083c9005 CR4: 0000=
000000772ef0
>   <4>[  967.890628] PKRU: 55555554
>   <6>[  967.890630] note: mdsc_stress[8609] exited with irqs disabled
>   <1>[  968.049600] BUG: kernel NULL pointer dereference, address: 000000=
0000000008
>   <1>[  968.049611] #PF: supervisor read access in kernel mode
>   <1>[  968.049652] #PF: error_code(0x0000) - not-present page
>   <6>[  968.049654] PGD 10f6b5067 P4D 10f6b5067 PUD 112491067 PMD 0
>   <4>[  968.049659] Oops: Oops: 0000 [#24] SMP NOPTI
>   <4>[  968.049665] CPU: 2 UID: 0 PID: 8613 Comm: mdsc_stress Tainted: G =
     D W           7.2.0-rc7-lockdep+ #13 PREEMPT(lazy)
>   <4>[  968.049668] Tainted: [D]=3DDIE, [W]=3DWARN
>   <4>[  968.049670] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), B=
IOS 1.17.0-10.fc44 06/10/2025
>   <4>[  968.049671] RIP: 0010:ceph_find_incompatible+0x75/0x1d0 [ceph]
>   <4>[  968.049700] Code: 41 5c 41 5d c3 cc cc cc cc 49 39 9c 24 10 08 00=
 00 0f 84 e0 00 00 00 31 f6 4c 89 e7 31 d2 e8 e2 a5 ff ff 48 8b 73 08 48 89=
 c7 <48> 39 70 08 0f 82 ca 00 00 00 e8 8c 92 fc ff 66 90 48 89 ef e8 62
>   <4>[  968.049701] RSP: 0018:ffffcdb64d5bf9b8 EFLAGS: 00010292
>   <4>[  968.049702] RAX: 0000000000000000 RBX: ffff8d5e414e6ec0 RCX: 0000=
000000000000
>   <4>[  968.049704] RDX: ffffffffc0b5c30a RSI: 0000000000000001 RDI: 0000=
000000000000
>   <4>[  968.049704] RBP: fffffbb08c6dcf80 R08: 0000000000000001 R09: 0000=
000000000000
>   <4>[  968.049705] R10: ffff8d5e5d23b940 R11: 0000000000000000 R12: ffff=
8d6005c35400
>   <4>[  968.049706] R13: ffff8d5e515c0000 R14: ffff8d5e5a52d980 R15: 0000=
000000000001
>   <4>[  968.049707] FS:  00007f4a81ffb6c0(0000) GS:ffff8d61f7d04000(0000)=
 knlGS:0000000000000000
>   <4>[  968.049708] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   <4>[  968.049709] CR2: 0000000000000008 CR3: 00000001083c9005 CR4: 0000=
000000772ef0
>   <4>[  968.049713] PKRU: 55555554
>   <4>[  968.049714] Call Trace:
>   <4>[  968.049715]  <TASK>
>   <4>[  968.049718]  ceph_netfs_check_write_begin+0x38/0x1f0 [ceph]
>   <4>[  968.049730]  ? __filemap_get_folio_mpol+0x26d/0x4e0
>   <4>[  968.049738]  netfs_write_begin+0x7d/0x480 [netfs]
>   <4>[  968.049756]  ceph_write_begin+0x2b/0x60 [ceph]
>   <4>[  968.049768]  generic_perform_write+0x166/0x2e0
>   <4>[  968.049771]  ceph_write_iter+0x72b/0xa20 [ceph]
>   <4>[  968.049782]  ? lock_acquire+0x11a/0x140
>   <4>[  968.049787]  vfs_write+0x276/0x690
>   <4>[  968.049792]  ksys_write+0x81/0x110
>   <4>[  968.049794]  do_syscall_64+0xf4/0x660
>   <4>[  968.049799]  ? trace_hardirqs_on_prepare+0xc6/0xe0
>   <4>[  968.049802]  ? lockdep_sys_exit+0x20/0xa0
>   <4>[  968.049804]  ? do_syscall_64+0x1d9/0x660
>   <4>[  968.049805]  ? lock_acquire+0x11a/0x140
>   <4>[  968.049807]  ? lock_acquire+0x11a/0x140
>   <4>[  968.049808]  ? lock_acquire+0x11a/0x140
>   <4>[  968.049809]  ? lock_acquire+0x11a/0x140
>   <4>[  968.049817]  ? lock_release+0xee/0x110
>   <4>[  968.049818]  ? lock_acquire+0x11a/0x140
>   <4>[  968.049820]  ? lock_release+0xee/0x110
>   <4>[  968.049821]  ? kmem_cache_free+0x322/0x570
>   <4>[  968.049826]  ? trace_hardirqs_on_prepare+0xc6/0xe0
>   <4>[  968.049827]  ? lockdep_sys_exit+0x20/0xa0
>   <4>[  968.049828]  ? do_syscall_64+0x1d9/0x660
>   <4>[  968.049829]  ? ksys_write+0xe6/0x110
>   <4>[  968.049831]  ? lock_release+0xee/0x110
>   <4>[  968.049832]  ? __task_pid_nr_ns+0xba/0x250
>   <4>[  968.049838]  ? trace_hardirqs_on_prepare+0xc6/0xe0
>   <4>[  968.049838]  ? lockdep_sys_exit+0x20/0xa0
>   <4>[  968.049840]  ? do_syscall_64+0x1d9/0x660
>   <4>[  968.049841]  ? trace_hardirqs_on_prepare+0xc6/0xe0
>   <4>[  968.049842]  ? trace_hardirqs_on+0x18/0xf0
>   <4>[  968.049842]  ? lockdep_sys_exit+0x20/0xa0
>   <4>[  968.049848]  ? do_syscall_64+0x1d9/0x660
>   <4>[  968.049849]  ? do_syscall_64+0xab/0x660
>   <4>[  968.049850]  ? exc_page_fault+0x155/0x2c0
>   <4>[  968.049852]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   <4>[  968.049855] RIP: 0033:0x7f4a9aa61412
>   <4>[  968.049858] Code: 08 0f 85 71 41 ff ff 49 89 fb 48 89 f0 48 89 d7=
 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f=
 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 55 bf 01 00
>   <4>[  968.049859] RSP: 002b:00007f4a81ff7b78 EFLAGS: 00000246 ORIG_RAX:=
 0000000000000001
>   <4>[  968.049861] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000=
7f4a9aa61412
>   <4>[  968.049861] RDX: 0000000000000001 RSI: 0000000000404553 RDI: 0000=
00000000001c
>   <4>[  968.049862] RBP: 00007f4a81ff7ba0 R08: 0000000000000000 R09: 0000=
000000000000
>   <4>[  968.049863] R10: 0000000000000000 R11: 0000000000000246 R12: 0000=
000000432e50
>   <4>[  968.049864] R13: 00000000005e3014 R14: 0000000000000011 R15: 0000=
000000432e40
>   <4>[  968.049866]  </TASK>
>   <4>[  968.049866] Modules linked in: ceph libceph krb5 netfs xsk_diag v=
sock_diag uinput snd_seq_dummy snd_hrtimer rfkill nf_conntrack_netbios_ns n=
f_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_re=
ject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_=
nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables qrtr sunrpc intel_=
rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_core pmt=
_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_pmc_pwrm=
_telemetry intel_vsec kvm_intel kvm snd_hda_codec_generic irqbypass snd_hda=
_intel rapl snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi =
snd_hwdep snd_seq iTCO_wdt snd_seq_device intel_pmc_bxt snd_pcm i2c_i801 sn=
d_timer pcspkr i2c_smbus snd lpc_ich virtio_balloon soundcore joydev zram l=
z4hc_compress vmw_vsock_virtio_transport vmw_vsock_virtio_transport_common =
vsock virtio_net net_failover virtio_gpu failover virtio_dma_buf serio_raw =
i2c_dev qemu_fw_cfg virti
>  ofs fuse
>   <4>[  968.049929] CR2: 0000000000000008
>   <4>[  968.049932] ---[ end trace 0000000000000000 ]---
> ---
>  fs/ceph/addr.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 534a7a377b2f..38db91459440 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -769,7 +769,7 @@ static int write_folio_nounlock(struct folio *folio,
>                 return 0;
>         }
>         oldest =3D get_oldest_context(inode, &ceph_wbc, snapc);
> -       if (snapc->seq > oldest->seq) {
> +       if (oldest && snapc->seq > oldest->seq) {
>                 doutc(cl, "%llx.%llx folio %p snapc %p not writeable - no=
op\n",
>                       ceph_vinop(inode), folio, snapc);
>                 /* we should only noop if called by kswapd */
> @@ -780,6 +780,21 @@ static int write_folio_nounlock(struct folio *folio,
>         }
>         ceph_put_snap_context(oldest);
>
> +       if (!oldest) {
> +               /*
> +                * No dirty capsnap and no head writeback refs: there is
> +                * nothing to conflict with and the folio is writable.
> +                * Fill in the ctl as for the head context, since
> +                * get_oldest_context() only does so on the capsnap and
> +                * head paths.
> +                */
> +               ceph_wbc.i_size =3D i_size_read(inode);
> +               ceph_wbc.truncate_size =3D ci->i_truncate_size;
> +               ceph_wbc.truncate_seq =3D ci->i_truncate_seq;
> +               ceph_wbc.size_stable =3D false;
> +               ceph_wbc.head_snapc =3D true;
> +       }
> +
>         /* is this a partial page at end of file? */
>         if (page_off >=3D ceph_wbc.i_size) {
>                 doutc(cl, "%llx.%llx folio at %lu beyond eof %llu\n",
> @@ -1869,7 +1884,7 @@ ceph_find_incompatible(struct folio *folio)
>                  * context!  is it writeable now?
>                  */
>                 oldest =3D get_oldest_context(inode, NULL, NULL);
> -               if (snapc->seq > oldest->seq) {
> +               if (oldest && snapc->seq > oldest->seq) {
>                         /* not writeable -- return it for the caller to d=
eal with */
>                         ceph_put_snap_context(oldest);
>                         doutc(cl, " %llx.%llx folio %p snapc %p not curre=
nt or oldest\n",
>
> ---
> base-commit: dee30ce1286a0d18b14545ecac345e4cf4a80511
> change-id: 20260827-b4-ceph-fix-null-oldest-snapc-new-6788eb74e401
>
> Best regards,
> --
> Xiubo Li <xiubo.li@clyso.com>
>
>
