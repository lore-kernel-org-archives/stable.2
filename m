Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782333672B1
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 16:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418769; cv=none; b=dQDvjh5GhGcd3bFfwwAICAgaENu/OXsyjrTQ9UpuJr7YqcgSzizuBL7qD7YR58KfKfjfMGbwoSYXRDc//bRoWEfFvtOgeYuEg5zFRBwvG3MWXLHad1upLskghycyZ7jsR1U3/UlOamGSfxwMgrrFQOWGv8OGOTpBPql5ASPrebM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418769; c=relaxed/simple;
	bh=fSNP1XnbBVkQDPEAD6rmyl7bZT3ItwjLxIaY0fjY01M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JlgtIcFWTTb7HhlPzYKSjVDqplNmqC8vrE2nxse3Wx2XUvdujLBC/L5qYiLs38LjmWJH+tGhC07rdRMad/IIA/gP8DusVDeWek2CqP20pr+fKXw/lgfKCiGhzlxTXUDwkdqkc/lvLxB1KGaTPKq7BFYiXjKooQOved5YPIo9TQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=Wt3nhDoe; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="Wt3nhDoe"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-69d96e2d14eso3439628eaf.1
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 09:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1780418766; x=1781023566; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FRlpUFJfWetZyeCOPMGpDwRLgEf/QSZnNJVgiC74iY0=;
        b=Wt3nhDoe79AVzB/WYMJPu8mfbYLafYoGFnEsWtOR79aW0ynQpze/OdkfvEUiWSe5pm
         +lQMTKrJmDQXRp9DCirO2YZXjNnbhB+DpR5nloNo45MQkFiGg5r/Pgf2sSx+LlFfFhSm
         XUmnZFfGLYaC3bBxPJ+3MPoCjwHsNzfkS/ekQICT1BM+dfh5rs9WjaWqgSDxip7HXNd3
         c9l6uVPOZz6MtrUqfFrPADK4jYEbjrUZvmW7FJ0F6IGdkYViiSVb/TrJs90gWLiOFefO
         ELbf1tk822hmJo6MLrJL6FFafcn0J7IdQEXwZryzojqGpDnY+eYjlKPvRbajtSU/0IRm
         xbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780418766; x=1781023566;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRlpUFJfWetZyeCOPMGpDwRLgEf/QSZnNJVgiC74iY0=;
        b=Boaixd2EP0tQ2iG9FiGCbQpFsHoUYLStrTvQr/glQLiasa7ll48NazFR5yttjLgXNe
         W2R8cUdJR5JOQtcDA7MKvRqg4bbXvbmRThv+h+NHDoIYhMpuD1vo8IkB1NA628RyONEQ
         nFHGu52YcU4Q12Dle7c9jay6IKKAlmqBUDW6CR59XdVU1mLhb2bgvHvZoLr32AN0SnXW
         rOaccw92QJfUY8bEadA3o80lO+ArVafZnFvDT2Zvwm7rfJjTKlkcsg7osfJL77qZf8Yz
         mzP+0V1N+XbN3V0cnbl+RAOOVqjQtJLy8AYUDt5MEujHPj67oS5SISIFu9WtJk2Y6mP1
         5XDw==
X-Forwarded-Encrypted: i=1; AFNElJ+N+dLMhEv1XOSOAijkRWkyhE/AqosVb+1LRpY8A/9yT360vbBTLSWXSCMCoIAeEW0Gw+hFlgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1JiYF6apBEYpdTlj74BsPKCLdNxHveGYaPXp/UgGwrRHGZx4q
	ltTclPVgAgmb7xQLtKzJrc9hlKTh/bnty/zx2c5yhd9XFiiXkbyo35Buziz/qT2MPsM=
X-Gm-Gg: Acq92OH/Y0CaIbTPNTTEIW0C1TMB7XwgJRXeGA6DRO6jsEbgpXBEg4GkHn8MnsWRe3u
	kso+1FYAjjcd9CpR5hg/01HVyiJtj2ypia1w/7WgGpzvLSrY3PAxg6sJO7ygMUrTwV7rHLJOvZQ
	s6O6hWnat+ZOzg5AP9yNUpXkPnc17jFfntQ03LnIXw3ihRl0d3b0L68hhSblr/id2jjT3GmqYi9
	CZ4+Aa4WOSVYwUBoA3jKGu72JPv+n3KJuKqgmP+n3Rz2+w4TuPwGWhV/cS0ODweKPDACS545dcR
	S7rUvuELfax3lcQSsWD7Ozlw0zwMNNNSi8c7tJaEXeLPOK7wIXVbdNRgnktBIdZlFAgZLXqLhgL
	hdfKVP9PTVdrrvW6swz9GbOE/Sbj0yoEquBzgmow/UZDWGKJz6xkd5sAsXhFTHyQ1qvcvwruEf2
	bcc457N/YT7RIKnitowK3LjL98sfrMD44T9FMIp6NkY1uoTI+tKrCPPDHOTRb2TpOtfyABvBMym
	71JSVEu5JgydYGgTowaBBMT8IIhPhCPBYZK+ZMaiSrhY4Adyx92L1wUIL3KAGsMxN93KGU=
X-Received: by 2002:a05:6820:2617:b0:69e:3e6b:c05 with SMTP id 006d021491bc7-69e46afafafmr139512eaf.57.1780418766367;
        Tue, 02 Jun 2026 09:46:06 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:7a3e:ac53:80f8:78b4? ([2600:1700:6476:1430:7a3e:ac53:80f8:78b4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e4623cc02sm231170eaf.4.2026.06.02.09.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 09:46:05 -0700 (PDT)
Message-ID: <4ccfc603834a26aff3a56141a882d2ecbd518806.camel@dubeyko.com>
Subject: Re: [PATCH v3] ceph: fix two unsafe bare decodes in decode_lockers()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Pavitra Jha <jhapavitra98@gmail.com>, idryomov@gmail.com
Cc: Slava.Dubeyko@ibm.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 02 Jun 2026 09:46:04 -0700
In-Reply-To: <20260602041735.1023057-1-jhapavitra98@gmail.com>
References: <202605310022.LGyGb8eD-lkp@intel.com>
	 <20260602041735.1023057-1-jhapavitra98@gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-06-02 at 00:17 -0400, Pavitra Jha wrote:
> decode_lockers() in cls_lock_client.c contains two bare decode
> operations
> that allow a malicious or compromised OSD to trigger slab-out-of-
> bounds
> reads:
>=20
> 1. ceph_decode_32(p) at the num_lockers field has no preceding bounds
> =C2=A0=C2=A0 check. ceph_start_decoding() accepts struct_len=3D0 as valid=
 -- the
> =C2=A0=C2=A0 internal ceph_decode_need(p, end, 0, bad) always passes -- s=
o when
> an
> =C2=A0=C2=A0 OSD sends struct_len=3D0, ceph_start_decoding() returns succ=
ess with
> =C2=A0=C2=A0 p =3D=3D end. The immediately following bare ceph_decode_32(=
p) then
> reads
> =C2=A0=C2=A0 4 bytes past the validated buffer boundary. The garbage valu=
e is
> =C2=A0=C2=A0 passed directly to kzalloc_objs() as the locker count.
>=20
> =C2=A0=C2=A0 The sibling function decode_watchers() in osd_client.c alrea=
dy
> uses
> =C2=A0=C2=A0 ceph_decode_32_safe() after its own ceph_start_decoding() ca=
ll.
> =C2=A0=C2=A0 decode_lockers() was the only site using the bare variant.
>=20
> 2. ceph_decode_8(p) after the decode_locker() loop has no preceding
> =C2=A0=C2=A0 bounds check. If an OSD crafts num_lockers such that the loo=
p
> =C2=A0=C2=A0 advances p exactly to end, the subsequent bare ceph_decode_8=
(p)
> reads
> =C2=A0=C2=A0 one byte past the validated buffer boundary. The result is p=
assed
> =C2=A0=C2=A0 directly into *type, which is used as a lock type discrimina=
tor by
> =C2=A0=C2=A0 callers, giving an OSD-controlled one-byte OOB read with dir=
ect
> =C2=A0=C2=A0 influence over the lock type field.
>=20
> Fix both by replacing bare operations with their safe variants:
> =C2=A0 ceph_decode_32(p) -> ceph_decode_32_safe(p, end, *num_lockers,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err_inval)
> =C2=A0 ceph_decode_8(p)=C2=A0 -> ceph_decode_8_safe(p, end, *type,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 err_free_lockers)
>=20
> The goto targets differ intentionally:
> =C2=A0 err_inval: is a new label returning -EINVAL directly. It is used
> for
> =C2=A0 the pre-allocation failure path where *lockers is not yet allocate=
d
> =C2=A0 and must not be passed to ceph_free_lockers().
>=20
> =C2=A0 err_free_lockers: is the existing label. It is used for the
> =C2=A0 post-allocation failure path where *lockers is allocated and must
> =C2=A0 be freed.
>=20
> ret is set to -EINVAL before ceph_decode_8_safe() so that
> err_free_lockers returns the correct error code on bounds violation.
> Without this, err_free_lockers would return a stale ret value (0 from
> the successful decode_locker() loop), silently swallowing the error.
>=20
> -EINVAL is correct for both failure paths. The data received from the
> OSD is structurally malformed. -ENOMEM would misrepresent the failure
> class to callers and to stable@ backporters triaging error paths.
>=20
> KASAN report for bug 1 (kernel 7.0.0-rc7, QEMU/x86_64, KASLR
> disabled):
> =C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =C2=A0 BUG: KASAN: slab-out-of-bounds in ceph_oob3_init+0x251/0xff0
> [ceph_oob3_poc]
> =C2=A0 Read of size 4 at addr ffff88800a29b76e by task insmod/58
>=20
> =C2=A0 CPU: 0 UID: 0 PID: 58 Comm: insmod Tainted: G=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 O=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0
> 7.0.0-rc7-g9c2abf69da83-dirty #15 PREEMPT(lazy)
> =C2=A0 Tainted: [O]=3DOOT_MODULE
> =C2=A0 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0=
-
> debian-1.17.0-1 04/01/2014
> =C2=A0 Call Trace:
> =C2=A0=C2=A0 <TASK>
> =C2=A0=C2=A0 dump_stack_lvl+0x4d/0x70
> =C2=A0=C2=A0 print_report+0x170/0x4f3
> =C2=A0=C2=A0 kasan_report+0xda/0x110
> =C2=A0=C2=A0 ceph_oob3_init+0x251/0xff0 [ceph_oob3_poc]
> =C2=A0=C2=A0 do_one_initcall+0x9a/0x3a0
> =C2=A0=C2=A0 do_init_module+0x27c/0x790
> =C2=A0=C2=A0 load_module+0x4a9a/0x6350
> =C2=A0=C2=A0 init_module_from_file+0x15c/0x180
> =C2=A0=C2=A0 idempotent_init_module+0x21f/0x750
> =C2=A0=C2=A0 __x64_sys_finit_module+0xba/0x120
> =C2=A0=C2=A0 do_syscall_64+0xe2/0x570
> =C2=A0=C2=A0 entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> =C2=A0 Allocated by task 58:
> =C2=A0=C2=A0 kasan_save_stack+0x30/0x50
> =C2=A0=C2=A0 kasan_save_track+0x14/0x30
> =C2=A0=C2=A0 __kasan_kmalloc+0x7f/0x90
> =C2=A0=C2=A0 ceph_oob3_init+0x4d/0xff0 [ceph_oob3_poc]
> =C2=A0=C2=A0 do_one_initcall+0x9a/0x3a0
> =C2=A0=C2=A0 do_init_module+0x27c/0x790
> =C2=A0=C2=A0 load_module+0x4a9a/0x6350
> =C2=A0=C2=A0 init_module_from_file+0x15c/0x180
> =C2=A0=C2=A0 idempotent_init_module+0x21f/0x750
> =C2=A0=C2=A0 __x64_sys_finit_module+0xba/0x120
> =C2=A0=C2=A0 do_syscall_64+0xe2/0x570
> =C2=A0=C2=A0 entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> =C2=A0 The buggy address belongs to the object at ffff88800a29a000
> =C2=A0=C2=A0 which belongs to the cache kmalloc-8k of size 8192
> =C2=A0 The buggy address is located 5998 bytes inside of
> =C2=A0=C2=A0 allocated 6000-byte region [ffff88800a29a000, ffff88800a29b7=
70)
>=20
> =C2=A0 Memory state around the buggy address:
> =C2=A0=C2=A0 ffff88800a29b600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00
> =C2=A0=C2=A0 ffff88800a29b680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00
> =C2=A0 >ffff88800a29b700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ^
> =C2=A0=C2=A0 ffff88800a29b780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc
> =C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> =C2=A0 num_lockers=3D0xccccaaaa (OOB garbage from KASAN redzone)
>=20
> Bug 2 (ceph_decode_8) follows from the identical precondition. A
> dedicated PoC is available on request.
>=20
> Attacker model: a malicious or compromised OSD in a multi-tenant Ceph
> deployment can trigger this against any kernel client that issues the
> lock.get_info class method (e.g. during RBD exclusive lock
> acquisition)
> without any further privileges beyond OSD session establishment.
>=20
> Fixes: d4ed4a530562 ("libceph: support for lock.lock_info")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
> ---
> v3: Combine both fixes (ceph_decode_32 and ceph_decode_8) into a
> single
> =C2=A0=C2=A0=C2=A0 patch per Viacheslav Dubeyko's review. Set ret =3D -EI=
NVAL before
> =C2=A0=C2=A0=C2=A0 ceph_decode_8_safe() so err_free_lockers returns the c=
orrect
> error
> =C2=A0=C2=A0=C2=A0 code, not stale ret (caught by Dan Carpenter / smatch)=
. Clarify
> =C2=A0=C2=A0=C2=A0 err_inval vs err_free_lockers goto selection rationale=
 and
> =C2=A0=C2=A0=C2=A0 -EINVAL justification.
> ---
> =C2=A0net/ceph/cls_lock_client.c | 7 +++++--
> =C2=A01 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/ceph/cls_lock_client.c b/net/ceph/cls_lock_client.c
> index c6956f1df..4e6a6d3e4 100644
> --- a/net/ceph/cls_lock_client.c
> +++ b/net/ceph/cls_lock_client.c
> @@ -299,7 +299,7 @@ static int decode_lockers(void **p, void *end, u8
> *type, char **tag,
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	*num_lockers =3D ceph_decode_32(p);
> +	ceph_decode_32_safe(p, end, *num_lockers, err_inval);
> =C2=A0	*lockers =3D kzalloc_objs(**lockers, *num_lockers, GFP_NOIO);
> =C2=A0	if (!*lockers)
> =C2=A0		return -ENOMEM;
> @@ -310,7 +310,8 @@ static int decode_lockers(void **p, void *end, u8
> *type, char **tag,
> =C2=A0			goto err_free_lockers;
> =C2=A0	}
> =C2=A0
> -	*type =3D ceph_decode_8(p);
> +	ret =3D -EINVAL;
> +	ceph_decode_8_safe(p, end, *type, err_free_lockers);
> =C2=A0	s =3D ceph_extract_encoded_string(p, end, NULL, GFP_NOIO);
> =C2=A0	if (IS_ERR(s)) {
> =C2=A0		ret =3D PTR_ERR(s);
> @@ -320,6 +321,8 @@ static int decode_lockers(void **p, void *end, u8
> *type, char **tag,
> =C2=A0	*tag =3D s;
> =C2=A0	return 0;
> =C2=A0
> +err_inval:
> +	return -EINVAL;
> =C2=A0err_free_lockers:
> =C2=A0	ceph_free_lockers(*lockers, *num_lockers);
> =C2=A0	return ret;

Looks good.

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.
