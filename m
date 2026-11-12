Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794498641;
	b=n/fsZ7v47th/ORSExxfdp/896Rh/g6AlUtEgnvuVkBFH7LwUEGpYrZ+czqhs9i0xDB1K
	 ErkO9i6OCzZUvj+jSsJOhuOuloLt0ceegcwKfmidXQzGurGMBfPSrCdoyLy96kpPqddy5
	 f9TR7G3TcZ4o8o3kU/FMjplI/Nk/urRPkXC93xxSIK9G6HX0S4TS01YH3RuFKWN+GjV8x
	 wO1mjQchyjtkf8BRCBGgT37sZJcUpKD5rxVNBJsw/Lcsb7q8ndZHwYnooyE0F+n/9pKPg
	 ttBoQaKenvGhuXDyCiwml93qQ+IkWzCoEBzpbrui21fvq99OZIf0T5DlREbafDHPktQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498641;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1J5Kag5a9R9WjXv4Vm2podHkmWJUILcyb3bqAyrnJ/g=;
	b=IRo1I3VzYmwm+WatcNUNmSqx4M+mRTXiv956/u0ndU4MGYBqNOSok0D9C0amDiYxSiLl
	 XqsPXXknjgydDagVn7yNLxjl3XODA3jUW/RG73XOuChurtDL7pIrGdQTo8nsUPfsQpNOl
	 a9FmG/SBG9v8SeLlOFZBb2NJ/S4ng/4xQzYg0LH5L5btxahDtcRQ/MpqrteAU3NVS3D/C
	 xWEVedQX3yQt1XQSCXlZVO6JtWkGy/6gp350oksFuHpK3XWc2/liv4pq+oqJm2PCWTja4
	 3IxgTnPQ5XnNw2V1BFmty2nxMHpn3pQpPUgh1c/wYxkUBC2XtTPqEp1nWwNs5gk6bYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mp3SDaMN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DD6606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 15:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54DD6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mp3SDaMN
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-54492d8a988so282501cf.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 07:50:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794498639; cv=none;
        d=google.com; s=arc-20260327;
        b=CK9kXa0l/VLMfjvMsSqKnh90HoBuK0PMiEc4AJ2G2G6YbJ5oDCVA5vuJoNSIbPzwGi
         0GwmKIPns706MhQ96a5fW3xuBIj6PmYGYuWP3JAgFwTCae5SuYdseIx1fIh2phxvScDY
         yT1YkVExQ5TXVhDdrl0aWNfWtlh3nyLbk8EHIfDp4wHK+2qsldFrig/KJ/5CwRkN4Hku
         KIv0z+Kh5f40EWe8wUsm39SlzJeyRMVvvOrqvoMMOA6YJgkbzejDhfH7V9q0Wt00evjP
         +/ly9WU5v5x/q/LINEI0/T1P74lFWzpq3hixEM+8eI/R9BAwwyJmptlk8mMiPLHy5peN
         uQCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1J5Kag5a9R9WjXv4Vm2podHkmWJUILcyb3bqAyrnJ/g=;
        fh=Qx6dk10G0cVYkG433KCp0xm0gmlgksOFZs2amiimqh4=;
        b=Wlx3Elc5ozDVGL5gULIRP1rFnHSu15M8DX+/KkWYV6PtF4o+zzcFUXXeCaUCJ92TEg
         zp5uvHEPxbX5JElCV+N8kjNhrRvnV3Hv1i3KHZb1dv4sa7qpq2tUALUYGmwaie5qm9in
         hgWce2uWDwMEl1lyNWkCaenDHGVCDVbwyByT9/aMDzqoh4r0nD4pHxBveUVtHqsRYyEb
         snwYOBFRVzmRIH65aK9wwivOwnA1iISDkdx11c8l2vb6GS9G2gejctHnT3FkAxIGd6M6
         E5z2FNyxCUWz82tWjMyVaROZ1hzDiCMHo/GAdmT3wgKrApXQjiofHnrh7ukjia+PwnFg
         grRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794498639; x=1795103439; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1J5Kag5a9R9WjXv4Vm2podHkmWJUILcyb3bqAyrnJ/g=;
        b=mp3SDaMNkYr7EcFK2XDLWz+FCR7u62/Q0PQ7DbkSrGGm8vZx3BirTekN9Bz2w778JC
         0majZE+SgSCzdwzgyp+tOg+ObYfiF+LZn1nV4/zZJTpmgWTjNQH5UfKSI5owHUuQBeNo
         IsAltOhADi6WxE78meSP12d4P2OnAj8rsl47d+yGOfdYQoYzAGHHzQBnAGA79SZ7k9T9
         MB3D8se6s+zlcUfWxED0uqyHHcPVsFPZdRkm3gmwQ0H3d1dp8VzrknhqeSpaZlV7NCDd
         mCpDuf/0CMZlGqFf3dbicf4sABPgz4Rmr6Q183tOqoEjHKGxpPIpfIBeVYAMQ2Wv8Qve
         QnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794498639; x=1795103439;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1J5Kag5a9R9WjXv4Vm2podHkmWJUILcyb3bqAyrnJ/g=;
        b=vXc8hQImx7RDlLAyb/Oswdhxx8vWmElkExUcJ7R2clcAYI5hUYEBo19uMJ1gmdJXEs
         KfuYigCMjHqqBq/XYF2d2coDxh6YqaOR1C5EU9RqlEcvGsENV+ZIw8hbe2U9UuGXhJP7
         7D6wNkbm5sDnGHyi1pWMJaqj/inncVRs8eKSKCHcNWuGRYAoSMY/lMx/KEDCXqSSwXmw
         8lD7fge21CK4IuZ0U5vC4AMTOF97zw8qrNRJeSk3uJsM9XE1Y8TAR5wIbMcd4DSzrLGf
         lqDyaIConvIdliHYomJ3SfelUvbOuNEr1SxlYFMPOZht0TWmIovkcZwL3Ry5xmpOidwl
         09Vg==
X-Forwarded-Encrypted: i=1; AL+hErHoi41IpHUCUvvSdPy2lzizjlftmodplFEr8l6H2gl9j50YxiSqxcz5FvLiqCL6fBtkrhRngt0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+nrsbrHDE8DRN/y2i3aXvsveNsGaaKCAQ2rWJyIIJYyFZfMLOc
	9yQQ9dJschzZ64yvaXVEBDlfCeFJ/EK5UIw5/K4rMEjyUwPc+A2viQg53f3UfNV7DLk0vCnprqB
	gVl+gzsHqYM5udkxfDeRd4p/vDensAEF0Szt+yx2P
X-Gm-Gg: AYBFou1B2OyN2RfDfOn2hxlBIM14LlOnsDdzv0abYvVRgu9NlPmevKUNkPthCkYsulY
	V4XUNhYUL1eA98oDVDMw3ohQzKh6wtidM7CQcWqv5TLkeYTv9QK3Law1AVV8BPICzLgG+QzPhL/
	RJOPLyGfs008UCxGypdT8G/HCfdqag9nZBcNjMBfTKNHhci55kqKaKI3cVBbLtDR3zvrV08d3Lo
	4bwCjEBSYK9SyU4To59Dye0bDJrQ8FJb47XKuzjiQt4SaJ7TsEZ6am3KX5vkVUxXWSVv3Li8NKB
	EoUv78TTj46gLi52pVN1i53Fv5QBqCANqT46R0+mVCKxxsqVTbW3IgHhQkFMxxee996d37sU+dT
	m2PMxOGIrJ+MdvFZ5YnUuUgqNvScsMwyxFFiObVH/9f0QP42B0KeBM8ldJCMm22F3SbjkmF8FR0
	TRuyM3QwTicYfqr2cVMvfbA0O8MA==
X-Received: by 2002:a05:622a:c14:b0:532:8423:1e78 with SMTP id
 d75a77b69052e-55990231239mr18865281cf.10.1794498638566; Thu, 12 Nov 2026
 07:50:38 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110112546.261415-1-hao.ge@linux.dev> <20261110112546.261415-2-hao.ge@linux.dev>
 <CAJuCfpHjSZhPPpRudAdrDPzz8dGK=Mx62CYCNoO4MC9OhnGd=A@mail.gmail.com> <aa6caf61-a4a1-4c51-aae7-ebb767f3430c@linux.dev>
In-Reply-To: <aa6caf61-a4a1-4c51-aae7-ebb767f3430c@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 12 Nov 2026 07:50:27 -0800
X-Gm-Features: AclHuK8tTrX5dxrTUPnpF2OR-DhefKyRTvk3c3hlnhcxw9TdWFm-p4sWJVSI-pQ
Message-ID: <CAJuCfpEC-YR7NrX_J4U-eyP-2T=E02OKKEO0eSjFMzja+BFLww@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] mm/kmsan: undo the shadow mapping when the origin
 mapping fails
To: Hao Ge <hao.ge@linux.dev>
Cc: Uladzislau Rezki <urezki@gmail.com>, Dev Jain <dev.jain@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 11:49=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> Hi Suren
>
> On 2026/11/12 05:03, Suren Baghdasaryan wrote:
> > On Tue, Nov 10, 2026 at 11:24=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrot=
e:
> >>
> >> kmsan_vmap_pages_range_noflush() first maps the shadow pages and then
> >> the origin pages. If the second mapping fails, the first one is left
> >> mapped, and the callers do not roll it back. The next vmap of the
> >> same metadata range hits the stale PTEs again and fails with a
> >> WARN_ON() and -EBUSY in vmap_pages_pte_range().
> >>
> >> Undo the shadow mapping on that error path, the same way
> >> kmsan_ioremap_page_range() cleans up after a partial failure.
> >> __vunmap_range_noflush() only clears the PTEs; nothing has touched
> >> the shadow mapping, so no TLB flush is needed.
> >>
> >> Fixes: 47ebd0310e89 ("mm: kmsan: handle alloc failures in kmsan_vmap_p=
ages_range_noflush()")
> >> Cc: stable@vger.kernel.org
> >> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> >> Reviewed-by: Dev Jain <dev.jain@arm.com>
> >> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> >> ---
> >>  mm/kmsan/shadow.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
> >> index 0c88d89bf0d6..2166086d3dc3 100644
> >> --- a/mm/kmsan/shadow.c
> >> +++ b/mm/kmsan/shadow.c
> >> @@ -258,6 +258,10 @@ int kmsan_vmap_pages_range_noflush(unsigned long =
start, unsigned long end,
> >>                                             o_pages, page_shift);
> >>         kmsan_leave_runtime();
> >>         if (mapped) {
> >> +               /* Undo the shadow mapping set up above. */
> >> +               kmsan_enter_runtime();
> >> +               __vunmap_range_noflush(shadow_start, shadow_end);
> >
> > Sorry, there is a problem here. You introduce "can_resched" check to
> > avoid calling cond_resched() later in the series (in patch #7), but at
> > this point __vunmap_range_noflush() can be called with GFP flags which
> > do not allow blocking. Before recent Ulad's change called "kmsan:
> > remove hard-coded GFP_KERNEL flags" this function was called only with
> > GPF_KERNEL but now that's not the case. I think you can move
> > introduction of can_resched flag into this patch.
>
> Agree. I just went back and looked at Ulad's b186a94227b7 ("kmsan:
> remove hard-coded GFP_KERNEL flags").
>
> So will do next version. But perhaps it is better to make it a separate
> prep patch in the same series? Because besides this call site, the other
> places that call __vunmap_range_noflush() need to be changed as well.

Agree. Moving that into a separate patch at the beginning of the
series with its own changelog and explanation would be cleaner.

>
> Thanks
> Best Regards
> Hao
>
> >
> >> +               kmsan_leave_runtime();
> >>                 err =3D mapped;
> >>                 goto ret;
> >>         }
> >> --
> >> 2.25.1
> >>
