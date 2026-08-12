Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0B42EEE88
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 19:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786562248; cv=pass; b=mAt7eACwVdEBGihyfX1/K7IepumJm7OJLn4OByyChuA/O8fuN+X5smb0x0t0iHZ3oED/Bk68yUv1l0ewK0Fth24YDMryS56yIxnz/RbTTb0xpe6i2/alCblmCGSys2TH9ZfZt0wLakZUzBC0B211YgAn/1UHz2bA3fo306DIDhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786562248; c=relaxed/simple;
	bh=GE+pZVBaGeA2Aorau2SIuuGm8ldgpj+3sqb2tUwmmP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzMBJIww/pLl4us7wErWdZ53UeI2pMmEt0HY2ArT3aVIgzy4TNe8qGASl75lloQpgELU2dn+OBLsUf6ZoUPghqeKqqMkr2pOak/EsOAp/zNwvjC8HPNRX6VjdHNmCVedKJd8TQMw8kBsaySs8jQLyxwZz/+41Tpr1tktVH18mU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FY1el8St; arc=pass smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FY1el8St"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5bfaa014978so619945e0c.3
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 12:17:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786562246; cv=none;
        d=google.com; s=arc-20260327;
        b=oLIyKz3owNiSnsopuWy+cyUoUUnyzCkAnuSqqZyqYDb/MREkTssd4aRQN5LeevSG6D
         NyDj/xA1dqP1tgYqUoflFRby76Lp4wtK7/4GJZZTq6nba3wnXEr5wej1f/5+/lGmN/OH
         hxnaypOxUqbdUqEYryFckCvsLTTq2P5UFJOzu18eQhAGjVULNVdlGYD8/dEZd67euRP1
         pnACnTRwFEJs9DRJdWklC6kw/tEue/VfEp5+/TrKBbhy+IFk7+vVxNgQPZRbe7dtF5Wz
         izXYnewCobZ936MGLk7HeIuhlqKbNUt9j/7lR9N92teT8samBwuqbbI9n9lmOpaLn9kH
         V+PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9IJgfP06pkKdnYvRNbHSDnTVvYPGVcSokXdpWpUNLMc=;
        fh=frfTh7m4r8VqhDu3wE2jBo3Ky5qsDrHmcGe9q1/6GBc=;
        b=Pwi8G/exsBO/d/bmTOb7y7B1nQmcouG7f4LWStYbkJ4x53DdrtV4WICzb8bdGjYlMK
         DasSG+OYet8wlRR0UjySQO4jCIGzhvXaSIfo25fpj95IHk/UFnyHjpgBhSTv+MVXx5f2
         RZFiGQv7g5O/r0l/xR+WeN9D4BxOQ2iets4zWPwWzZkVepxa8pbNeOvpmpuoILBQueDv
         kSX8RMhJ7O/j9gcb13oyK6aQaefCokL+90zFnYyxQb3mk0ZW2p6s1X0GKZ0x3Ao6b7bM
         OPBfK3RXcZcN+mecBL299E0I7fTjP6eJEH/fUn4gyoyUYtpucgKA4v5g0vLV+1ecaBsv
         TJQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786562246; x=1787167046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9IJgfP06pkKdnYvRNbHSDnTVvYPGVcSokXdpWpUNLMc=;
        b=FY1el8StIGShvIFR7JVS+vyw/Ir9EPEry43lAk34ivelNoMiXMGJYrXluS/kicly1G
         dwegHLwc1rlVTfSOzE+oTkq1eWz2qvWFBi15FKZWJIAcMH5qsFpSv9ilty8Bk5sAje/y
         KkpXkCPRC9dcEOJpW4m6USfKtrL16lVWKcWckc9o5Xrp5/f7InoARAclV/yAbOFX9MN3
         WvaMBcvUxf3mhsYmaItUXifSIdYrfvacVjJeTSQTW6V4/jEDIO/vSgPi4Qu7IXcUHipc
         ylUjADPmxC5yMnYJPYmhM5dgogLGcx3iAMns6bUE+GAFQfCs1u6RBaiAoDJooH4A6nJq
         VVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786562246; x=1787167046;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9IJgfP06pkKdnYvRNbHSDnTVvYPGVcSokXdpWpUNLMc=;
        b=nIcK4WqIaZJmyS4oLwVnJm2olG/wFlBzCoe6NXABF1h0QU6OjrCsk3aruIK4v4z5vG
         7tMoktR7H+igo6ospB4Y2UKJeOTClTY3aGXQ0ud05YlPKyBRNNUwfPGuIenCP7DZ48ni
         jjiFjzUeuRr/OLygQ9bVJZAqkNWIPbGVAuFAuuyNkQpKk1hkBBpctNNrh2aWz1Kv2gI+
         VCjJJfWDuncLqQVK2EEx4xwmfXxSxdl8x0sq16GoR9R2mNsxSfOD81BTvvjWZwfjkbdM
         Cw3ralPLlm1TjUU3McwXHUF7EGOnk4BGk4BCcxFB5JsFY8cs7+5qrzTMSzbAijxZ7aoH
         1AQA==
X-Forwarded-Encrypted: i=1; AHgh+Rqh2tJFoKuL2jNCLjlv4nUoBmqGTmB9kh7El4twdruMjIZDLPh93EohR8VL78K5+YFbnz7fNUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMDZ50O3kjy49OelF3rCIVA1Y4Yn/Xvpy6G7XBMhfKxZyarnwg
	lnBcXzdMn/TbUjynNX1AsG79rru1IQCu6jHwvTKNscECKHZ8jutNlZ81uQKzZxhGrITsdM1RC/X
	sk3cRXD4CHGo/I5YnvbkUraOuwk32UCs=
X-Gm-Gg: AR+sD11WRVc1rDS9W3v57k499kqU9WLo9C+TfkrHjJBxHuHU9EZiVu9gEHZPetVzamr
	PIgIWJ3XBxfYDZ5c/0PX0ZZh/kZQGrGT8LyhxhDbOLvNN/xe7vbvLTq2ItrI4C58UTs+5fXrlLJ
	UxCtolLBQnxkvqxkA9OZSSpq1hrYBJI0C3SMHbnnFc31abOFF2hrhLMAlbagNK4koBN1r2qB+5e
	r4T14zvoiG9IKlUcGERYDj6srtNIWsqQ7Cy0PhpZ0YTibvSDISJglNptcRLoV879A41MjSY609+
	EKxGyHuYEgzTH0dbL8QmyZT5l1XXtjZlbwHAfUw8YThbJwmFgQlDs+R8t35MQGCea9G8nB5R7At
	/MoB4hQlHdOuI
X-Received: by 2002:a05:6122:3309:b0:573:a779:62cf with SMTP id
 71dfb90a1353d-5c579a7dc17mr95903e0c.7.1786562245673; Wed, 12 Aug 2026
 12:17:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702114034.917507-13-amarkuze@redhat.com> <20260707105727.43352-1-jhapavitra98@gmail.com>
In-Reply-To: <20260707105727.43352-1-jhapavitra98@gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 12 Aug 2026 21:17:11 +0200
X-Gm-Features: AUfX_mygzHGTKZ0Z1inB3vDeL-aCreazIlygazBl_5d8j5_NrRSdzXCnIz-H7tE
Message-ID: <CAOi1vP-UKO91iPY-3uNspJ5W7bYowqCdg5_GiJnOLWo8f3Q0eQ@mail.gmail.com>
Subject: Re: [PATCH v4] ceph: fix OOB read in ceph_osdc_list_watchers via
 uncapped outdata_len
To: Pavitra Jha <jhapavitra98@gmail.com>
Cc: amarkuze@redhat.com, slava@dubeyko.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 12:58=E2=80=AFPM Pavitra Jha <jhapavitra98@gmail.com=
> wrote:
>
> The OSD reply header field op->payload_len is wire-controlled and is
> copied directly into m->outdata_len[i] without any bounds check:
>
>   m->outdata_len[i] =3D le32_to_cpu(op->payload_len);
>
> This value propagates unchecked to req->r_ops[0].outdata_len and is

Hi Pavitra,

IIRC it's not completely unchecked: if the sum of m.outdata_len values
for all OSD ops in the request doesn't match msg->hdr.data_len,
handle_reply() should fail and hence ceph_osdc_wait_request() in
ceph_osdc_list_watchers() too.

> then used to set the decode boundary in ceph_osdc_list_watchers():
>
>   void *const end =3D p + req->r_ops[0].outdata_len;
>
> The actual data allocation is always exactly one page:
>   ceph_alloc_page_vector(1, GFP_NOIO)
>   ceph_osd_data_pages_init(..., PAGE_SIZE, ...)
>
> The messenger caps the copy to PAGE_SIZE bytes, but the decode window
> end is set from the uncapped wire value. A malicious OSD can send

I don't think the messenger ever silently caps anything (or at least it
shouldn't).  The messenger wants to read exactly msg->hdr.data_len bytes
off the wire and if the underlying buffers aren't big enough the message
gets discarded.

> outdata_len=3D0x10000, causing _safe decoder boundary checks to pass
> while the physical reads cross the slab allocation boundary.
> KASAN report (kernel 7.0.0-rc7, QEMU/x86_64, KASLR disabled):

Could you please elaborate on what fields were set to what values and
what payload was injected and fed to decode_watchers() because it for
sure wasn't just outdata_len set to 0x10000.

Thanks,

                Ilya

>
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   BUG: KASAN: slab-out-of-bounds in ceph_oob2_init+0x23d/0xff0 [ceph_oob2=
_poc]
>   Read of size 4 at addr ffff88800a229f9e by task insmod/57
>
>   CPU: 0 UID: 0 PID: 57 Comm: insmod Tainted: G           O        7.0.0-=
rc7-g9c2abf69da83-dirty #15 PREEMPT(lazy)
>   Tainted: [O]=3DOOT_MODULE
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debi=
an-1.17.0-1 04/01/2014
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x4d/0x70
>    print_report+0x170/0x4f3
>    kasan_report+0xda/0x110
>    ceph_oob2_init+0x23d/0xff0 [ceph_oob2_poc]
>    do_one_initcall+0x9a/0x3a0
>    do_init_module+0x27c/0x790
>    load_module+0x4a9a/0x6350
>    init_module_from_file+0x15c/0x180
>    idempotent_init_module+0x21f/0x750
>    __x64_sys_finit_module+0xba/0x120
>    do_syscall_64+0xe2/0x570
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>   Allocated by task 57:
>    kasan_save_stack+0x30/0x50
>    kasan_save_track+0x14/0x30
>    __kasan_kmalloc+0x7f/0x90
>    ceph_oob2_init+0x44/0xff0 [ceph_oob2_poc]
>    do_one_initcall+0x9a/0x3a0
>    do_init_module+0x27c/0x790
>    load_module+0x4a9a/0x6350
>    init_module_from_file+0x15c/0x180
>    idempotent_init_module+0x21f/0x750
>    __x64_sys_finit_module+0xba/0x120
>    do_syscall_64+0xe2/0x570
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>   The buggy address belongs to the object at ffff88800a229000
>    which belongs to the cache kmalloc-4k of size 4096
>   The buggy address is located 3998 bytes inside of
>    allocated 4000-byte region [ffff88800a229000, ffff88800a229fa0)
>
>   Memory state around the buggy address:
>    ffff88800a229e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    ffff88800a229f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   >ffff88800a229f80: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
>                                  ^
>    ffff88800a22a000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>    ffff88800a22a080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   val=3D0xccccaaaa (OOB garbage from KASAN redzone)
>
> Fix by introducing buf_len to hold the allocation size, using it in
> both ceph_osd_data_pages_init() and the min_t() decode boundary cap,
> so the two are guaranteed to stay in sync if the buffer size changes.
> buf_len is declared as u32 to match the type of outdata_len used in
> the min_t() expression.
>
> Attacker model: a malicious or compromised OSD in a multi-tenant
> Ceph deployment can trigger this against any client issuing
> CEPH_OSD_OP_LIST_WATCHERS without further privileges beyond OSD
> session establishment.
>
> Fixes: a4ed38d7a180 ("libceph: support for CEPH_OSD_OP_LIST_WATCHERS")
> Cc: stable@vger.kernel.org
> Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
> Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
> ---
> v4: Rebase against current linux/master and ceph-testing/testing,
>     confirmed clean git am -3 apply against both. No functional
>     changes from Slava's reviewed v3.
> v3: Change buf_len type from size_t to u32 to match outdata_len type
>     in min_t(), per Viacheslav Dubeyko's review.
> v2: Introduce buf_len variable instead of hardcoding PAGE_SIZE
>     independently in ceph_osd_data_pages_init() and the min_t() cap,
>     per Viacheslav Dubeyko's review.
> ---
>  net/ceph/osd_client.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 2ff00070c..62bec6ad8 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -5060,6 +5060,7 @@ int ceph_osdc_list_watchers(struct ceph_osd_client =
*osdc,
>         struct ceph_osd_request *req;
>         struct page **pages;
>         int ret;
> +       const u32 buf_len =3D PAGE_SIZE;
>
>         req =3D ceph_osdc_alloc_request(osdc, NULL, 1, false, GFP_NOIO);
>         if (!req)
> @@ -5078,7 +5079,7 @@ int ceph_osdc_list_watchers(struct ceph_osd_client =
*osdc,
>         osd_req_op_init(req, 0, CEPH_OSD_OP_LIST_WATCHERS, 0);
>         ceph_osd_data_pages_init(osd_req_op_data(req, 0, list_watchers,
>                                                  response_data),
> -                                pages, PAGE_SIZE, 0, false, true);
> +                                pages, buf_len, 0, false, true);
>
>         ret =3D ceph_osdc_alloc_messages(req, GFP_NOIO);
>         if (ret)
> @@ -5088,7 +5089,8 @@ int ceph_osdc_list_watchers(struct ceph_osd_client =
*osdc,
>         ret =3D ceph_osdc_wait_request(osdc, req);
>         if (ret >=3D 0) {
>                 void *p =3D page_address(pages[0]);
> -               void *const end =3D p + req->r_ops[0].outdata_len;
> +               void *const end =3D p +
> +                       min_t(u32, req->r_ops[0].outdata_len, buf_len);
>
>                 ret =3D decode_watchers(&p, end, watchers, num_watchers);
>         }
> --
> 2.53.0
>
