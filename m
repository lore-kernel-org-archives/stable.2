Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3C63845D9
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780419220; cv=none; b=b1eIFBIOp9cpQ0/+F7H2LtlnXqbD7hFllYlv+ZIhJPtTpc5ngcSCTb55lEBnvDk6EVcwSBB9K68twLZoGsQezO2nGz3NrZ9qEBI/8MtMKbiCpgOEn9a2uCWkAZoXPdnpqWjsWYXBlmJs66MT8u5Rxba5EQZ323GtF8Go6ga4FCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780419220; c=relaxed/simple;
	bh=iKCPs+wSa5lrYhxBuyd0KhvQmvJs0/Pw5s0l/8zfC5w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ltx8nlJ+jYHhkUN2twOg/vpKiCPjCivPk7E5wrqEL8Q9nixDsXZqonMwe2PIMw3ny/iFldzuJL3y0jF1Z5LpkvSQbt8h+VeiUQ6Z242Sf4qedw4wIOZwtZfoep4gU7HLtHFoNtGexX990eskkuEcSuCVmRkmjsVsogHdmtc46Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=A121rYVj; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="A121rYVj"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e615efd7d7so8717069a34.2
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 09:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1780419216; x=1781024016; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d354Uv2MU3X1Ggc+z6jYavsaIoozUFQzwD4VhA8Gv0I=;
        b=A121rYVjXKvjj5vFC0BA6rcZmpVpqkQ+sAzUmHK12tMkUcKDPoU9GJ4bGCUse5UqKn
         CeLmWivwgR53+h3hfkd7KWwiQGAREsBEyOD0MmYyE6cGlCTWzHPXyyBeISU29YCjFc8I
         cYCxeywi9eOLXlqiyGCvYCOr5ILt/zAaQviCE2GU1vDgCe8bDqJXbenB9NnS4K6rOIaN
         CXmVwCNZeTNkjawA4BPqAR9G7VAfe3AJ1oCm52mIfk/XmmHNZfYfX9v74NVCv+AT6eCY
         VTAyL5VLxFtKGLz2i1iHJLQWrdaL+/8dDmPoNUSUDGM91LoTXdS+Z6WluoZlMLq+0lT6
         TdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780419216; x=1781024016;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d354Uv2MU3X1Ggc+z6jYavsaIoozUFQzwD4VhA8Gv0I=;
        b=jDMrIlAcH1le2ZDHCvdll3o1pEbF3wnHvnxmDTXGb5YmeX4YK/zMPlOY+repbwS9Ji
         +NNrRXA7J4Dh1HK1Qpj4A9C93sA2RPKfDVPk2bs2oFlBPwmeMirWouoGH401cYSyPXHx
         u7LeLLTlYihcdG5J00cEH2u5VZ3qAN0p3na0rdkVAFngFaFs3mqeAKNzE1Uz3ErKYFsP
         HEQDMa4onmLe/PpEEoNTyTbx+qEUHaUXa5tfSHjPUpDXYmVCu5LJA6r0k9hEIR2UmDk1
         S31Fgq5UxiQWOqIwZO38LUyEDHlKAp07Y/rCq2liVYcyH6eyHfpE0ROGPK7kk2U29qPM
         FPww==
X-Forwarded-Encrypted: i=1; AFNElJ/q8ukEVLdvtdE0ThTcZP7b1a6mvs0afcBfNH0196DbmiJR9A4xsq2ektHFnixRm58rvcB1+Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwalmJRNecAFzNaHlY1sD4sDY8Syb0C3h4NNbSolQ8qXLtZI4Zw
	tBa4v0TOiAqOCUIMLIby0SpZHvbWXGNpJSWnefZwAAjYZXKD3PDQLzVQvObJjq3npuE=
X-Gm-Gg: Acq92OFg/DukMxaMDpzLY+HHGJMeIG+nq1xqBJQpYhti/EcTkdjbqtE0Dn/2DOVUYuq
	1cnSRw+kZjRAzExEKDEkpxJQXNgT3QcDqhFw0y+M7gybmj1s4LSYfvnHc+KNFMbTuD7PQ/cmoMZ
	noayReshqPBxtF83yXIiC9BWs7UQ7151HKpOfqsSS92MOQv0D7H8yxH7sxVQOC1un9IGvN4s7Xy
	pUjikz7v4LzY32pGtmJaV/XqMNuny+oYYsrBgnzqwC8yWgQiACjhJEADH4pKmvMAZlh8/ojDVtX
	VVVI3MvyrUGiBoIexlb4+qgWAzcUEO0n6yx+BywgPEZ6Al+4owrl9s9rb4kk4CkkcBg38AlNEnu
	RKocpNjH+RqfE1uOmalF2+YOPUfa7d1l4GrZ3Z40JtKzUXU1lQDbS01V6P4FeBbaNVpOcQ9JC49
	e533jxXfnQ26P70ln8ihgPASwStC8nFNam4bxEaqMn1EHERxFxL+GzT2bjRMKbu7LgQLOtoR9bv
	6xAfjIAHEqwKSWwgj42xS/khGs3BUUu24INk2aFKfkASV2alEQHjn4S7Ur9cAJhLQRsJGZj8p3k
	+wqNDA==
X-Received: by 2002:a4a:e90a:0:b0:69c:2c20:ddbc with SMTP id 006d021491bc7-69e467424dbmr344191eaf.0.1780419216326;
        Tue, 02 Jun 2026 09:53:36 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:7a3e:ac53:80f8:78b4? ([2600:1700:6476:1430:7a3e:ac53:80f8:78b4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e464743f8sm233186eaf.15.2026.06.02.09.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 09:53:35 -0700 (PDT)
Message-ID: <27e15cffb5d346a19a45efc88a722a3d6abd5c7a.camel@dubeyko.com>
Subject: Re: [PATCH v3] ceph: fix OOB read in ceph_osdc_list_watchers via
 uncapped outdata_len
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Pavitra Jha <jhapavitra98@gmail.com>, idryomov@gmail.com, 
	Slava.Dubeyko@ibm.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Tue, 02 Jun 2026 09:53:34 -0700
In-Reply-To: <20260602045432.1038887-1-jhapavitra98@gmail.com>
References: <5b7d6b21f7c34661fc9430b828b4c5a3be6446b4.camel@ibm.com>
	 <20260602045432.1038887-1-jhapavitra98@gmail.com>
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

On Tue, 2026-06-02 at 00:54 -0400, Pavitra Jha wrote:
> The OSD reply header field op->payload_len is wire-controlled and is
> copied directly into m->outdata_len[i] without any bounds check:
>=20
> =C2=A0 m->outdata_len[i] =3D le32_to_cpu(op->payload_len);
>=20
> This value propagates unchecked to req->r_ops[0].outdata_len and is
> then used to set the decode boundary in ceph_osdc_list_watchers():
>=20
> =C2=A0 void *const end =3D p + req->r_ops[0].outdata_len;
>=20
> The actual data allocation is always exactly one page:
> =C2=A0 ceph_alloc_page_vector(1, GFP_NOIO)
> =C2=A0 ceph_osd_data_pages_init(..., PAGE_SIZE, ...)
>=20
> The messenger caps the copy to PAGE_SIZE bytes, but the decode window
> end is set from the uncapped wire value. A malicious OSD can send
> outdata_len=3D0x10000, causing _safe decoder boundary checks to pass
> while the physical reads cross the slab allocation boundary.
>=20
> KASAN report (kernel 7.0.0-rc7, QEMU/x86_64, KASLR disabled):
>=20
> =C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =C2=A0 BUG: KASAN: slab-out-of-bounds in ceph_oob2_init+0x23d/0xff0
> [ceph_oob2_poc]
> =C2=A0 Read of size 4 at addr ffff88800a229f9e by task insmod/57
>=20
> =C2=A0 CPU: 0 UID: 0 PID: 57 Comm: insmod Tainted: G=C2=A0=C2=A0=C2=A0=C2=
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
> =C2=A0=C2=A0 ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> =C2=A0=C2=A0 kasan_report+0xda/0x110
> =C2=A0=C2=A0 ? ceph_oob2_init+0x23d/0xff0 [ceph_oob2_poc]
> =C2=A0=C2=A0 ? ceph_oob2_init+0x23d/0xff0 [ceph_oob2_poc]
> =C2=A0=C2=A0 ? __pfx_ceph_oob2_init+0x10/0x10 [ceph_oob2_poc]
> =C2=A0=C2=A0 ceph_oob2_init+0x23d/0xff0 [ceph_oob2_poc]
> =C2=A0=C2=A0 do_one_initcall+0x9a/0x3a0
> =C2=A0=C2=A0 ? __pfx_do_one_initcall+0x10/0x10
> =C2=A0=C2=A0 ? kasan_unpoison+0x44/0x70
> =C2=A0=C2=A0 do_init_module+0x27c/0x790
> =C2=A0=C2=A0 ? __pfx_do_init_module+0x10/0x10
> =C2=A0=C2=A0 ? __kasan_slab_free+0x47/0x70
> =C2=A0=C2=A0 ? kfree+0x15f/0x3b0
> =C2=A0=C2=A0 load_module+0x4a9a/0x6350
> =C2=A0=C2=A0 ? __pfx_load_module+0x10/0x10
> =C2=A0=C2=A0 ? security_file_permission+0x24/0x50
> =C2=A0=C2=A0 ? kernel_read_file+0x2ed/0x770
> =C2=A0=C2=A0 ? init_module_from_file+0x15c/0x180
> =C2=A0=C2=A0 init_module_from_file+0x15c/0x180
> =C2=A0=C2=A0 ? __pfx_init_module_from_file+0x10/0x10
> =C2=A0=C2=A0 ? tick_nohz_handler+0x2a3/0x640
> =C2=A0=C2=A0 ? _raw_spin_lock+0x7e/0xd0
> =C2=A0=C2=A0 idempotent_init_module+0x21f/0x750
> =C2=A0=C2=A0 ? __pfx_idempotent_init_module+0x10/0x10
> =C2=A0=C2=A0 ? fdget+0x4e/0x4a0
> =C2=A0=C2=A0 ? fdget+0x4e/0x4a0
> =C2=A0=C2=A0 __x64_sys_finit_module+0xba/0x120
> =C2=A0=C2=A0 do_syscall_64+0xe2/0x570
> =C2=A0=C2=A0 ? exc_page_fault+0x66/0xb0
> =C2=A0=C2=A0 entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> =C2=A0 Allocated by task 57:
> =C2=A0=C2=A0 kasan_save_stack+0x30/0x50
> =C2=A0=C2=A0 kasan_save_track+0x14/0x30
> =C2=A0=C2=A0 __kasan_kmalloc+0x7f/0x90
> =C2=A0=C2=A0 ceph_oob2_init+0x44/0xff0 [ceph_oob2_poc]
> =C2=A0=C2=A0 do_one_initcall+0x9a/0x3a0
> =C2=A0=C2=A0 do_init_module+0x27c/0x790
> =C2=A0=C2=A0 load_module+0x4a9a/0x6350
> =C2=A0=C2=A0 init_module_from_file+0x15c/0x180
> =C2=A0=C2=A0 idempotent_init_module+0x21f/0x750
> =C2=A0=C2=A0 __x64_sys_finit_module+0xba/0x120
> =C2=A0=C2=A0 do_syscall_64+0xe2/0x570
> =C2=A0=C2=A0 entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> =C2=A0 The buggy address belongs to the object at ffff88800a229000
> =C2=A0=C2=A0 which belongs to the cache kmalloc-4k of size 4096
> =C2=A0 The buggy address is located 3998 bytes inside of
> =C2=A0=C2=A0 allocated 4000-byte region [ffff88800a229000, ffff88800a229f=
a0)
>=20
> =C2=A0 Memory state around the buggy address:
> =C2=A0=C2=A0 ffff88800a229e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00
> =C2=A0=C2=A0 ffff88800a229f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00
> =C2=A0 >ffff88800a229f80: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> =C2=A0=C2=A0 ffff88800a22a000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc
> =C2=A0=C2=A0 ffff88800a22a080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc
> =C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> =C2=A0 val=3D0xccccaaaa (OOB garbage from KASAN redzone)
>=20
> Fix by introducing buf_len to hold the allocation size, using it in
> both ceph_osd_data_pages_init() and the min_t() decode boundary cap,
> so the two are guaranteed to stay in sync if the buffer size changes.
>=20
> Attacker model: a malicious or compromised OSD in a multi-tenant
> Ceph deployment can trigger this against any client issuing
> CEPH_OSD_OP_LIST_WATCHERS without further privileges beyond OSD
> session establishment.
>=20
> Fixes: a4ed38d7a180 ("libceph: support for
> CEPH_OSD_OP_LIST_WATCHERS")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
> ---
> v3: Split overlong min_t() line to fit 80-column limit,
> =C2=A0=C2=A0=C2=A0 per Viacheslav Dubeyko's review of v2.
> v2: Introduce buf_len variable instead of hardcoding PAGE_SIZE
> =C2=A0=C2=A0=C2=A0 independently in ceph_osd_data_pages_init() and the mi=
n_t() cap,
> =C2=A0=C2=A0=C2=A0 per Viacheslav Dubeyko's review.
> ---
> =C2=A0net/ceph/osd_client.c | 6 ++++--
> =C2=A01 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index a67093cf4..0a55bc1f9 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -5063,6 +5063,7 @@ int ceph_osdc_list_watchers(struct
> ceph_osd_client *osdc,
> =C2=A0	struct ceph_osd_request *req;
> =C2=A0	struct page **pages;
> =C2=A0	int ret;
> +	const size_t buf_len =3D PAGE_SIZE;
> =C2=A0
> =C2=A0	req =3D ceph_osdc_alloc_request(osdc, NULL, 1, false,
> GFP_NOIO);
> =C2=A0	if (!req)
> @@ -5081,7 +5082,7 @@ int ceph_osdc_list_watchers(struct
> ceph_osd_client *osdc,
> =C2=A0	osd_req_op_init(req, 0, CEPH_OSD_OP_LIST_WATCHERS, 0);
> =C2=A0	ceph_osd_data_pages_init(osd_req_op_data(req, 0,
> list_watchers,
> =C2=A0						 response_data),
> -				 pages, PAGE_SIZE, 0, false, true);
> +				 pages, buf_len, 0, false, true);
> =C2=A0
> =C2=A0	ret =3D ceph_osdc_alloc_messages(req, GFP_NOIO);
> =C2=A0	if (ret)
> @@ -5091,7 +5092,8 @@ int ceph_osdc_list_watchers(struct
> ceph_osd_client *osdc,
> =C2=A0	ret =3D ceph_osdc_wait_request(osdc, req);
> =C2=A0	if (ret >=3D 0) {
> =C2=A0		void *p =3D page_address(pages[0]);
> -		void *const end =3D p + min_t(u32, req-
> >r_ops[0].outdata_len, PAGE_SIZE);
> +		void *const end =3D p +
> +			min_t(u32, req->r_ops[0].outdata_len,
> buf_len);

Now, min_t() worries me slightly because req->r_ops[0].outdata_len is
u32 data type, but buf_len is size_t. Could we have the same data type
for both variables?

Thanks,
Slava.

> =C2=A0
> =C2=A0		ret =3D decode_watchers(&p, end, watchers,
> num_watchers);
> =C2=A0	}
