Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC51C3ACA74
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244381; cv=pass; b=sNaGnHmYGynlZflNF78Es4ryf9PXqc7QFcuk+88LsGmcRzvOUtQINyDbGy0LKv7uRKpXH7iG23llg52s9k9h06PhOnhFolI/uUpy1Tm6bCI9M2assl0u2aMX3e3UJQtLbJwHq8YL1nlGZ1Ungwer8qONEf12VQc3rLeJBLMhFo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244381; c=relaxed/simple;
	bh=5PitEWE4LVtxfe2H74Csmay5+z32OyTcksU82m9HLNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loMfqzjbUjDi371wrHeAkynVwG2HPwm6UUwUPMKQbGkIB/rE8QTpuMkCQSLWuT898FKiNlihSsd85kPBNDN4VyjGIJ0W/x7+JoH8YfW+ZQvxkUEMS8UO1uexrhyZ9BodI04w9eWnqelq0OEzmzziXXXtOADhT67QF0cON9F9zxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=vm8X+TPL; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="vm8X+TPL"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84861fc51f5so3063217b3a.1
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 06:12:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785244378; cv=none;
        d=google.com; s=arc-20260327;
        b=l1sAgEwVFLqj2oaZ4n4VQvDy58GZQ8E32I8dLRRHQsOed5uSn5VJPScgX+Pq5HH9hk
         1AvDoFo0I0uq2OHH+6V7hI6kl+39FlxerV9lwjkST6zPP2HDMivUHF4x4oC546GfJLaN
         W2hIiOJgugYtY1j2bo2KUrpE5ZKYq8D/IlSPfmbpzQizIkrp0nUPN+kUKwGbUHtU5pQJ
         gX63zrk2te14P+J1iVHdiLu0Ufuqs8bLPumapKXe/fTJa9POBznX+uOoSt3IQtOAp2+1
         PYbM1PbBnsIqNk0GdRbM+eRamCt7ap8ot15RNBR/8/h0aK8ds4cvR6vUxMpaUlqTRT7H
         GuaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RsLXOGn4ljM01hXnayTxvwBZ9s73EJ6kvuoyVSlCNSo=;
        fh=YPIL/Fy96MoE78xP/AVh6Ye+kLepDNBvmEz3vChO59U=;
        b=Rh5YMIHm9sI7q/6smg5eTxQYBxzzg7AgDR+Y6aXvX0UuEWzPMzvFDD/qVwx5fO+cjE
         u0W2zYZqsnSInFx+b8VGr5rOQO0HIEob59kgMNp/CoBK6Sy6w4UhZdjyrdRxV6ILe5gZ
         Z9RaIR2MmqYkE3FCtywCqfUaN9eaMc/HLoWNj0adK/2MWkaCCJDPe3t7BfdZhK5azvbk
         luPArdcetEUNglsYVC2rRcFa0GW8KNy24dxsMT2j004hk5vhB3YfosrYsUcKBHo7RuHk
         mF2+hcAyrVsxXtb3vNSdO8aqZHwJ/t9jV2drJkr+rEbb5creXPY514qVhRZ5R2V4VKZD
         MrNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1785244378; x=1785849178; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RsLXOGn4ljM01hXnayTxvwBZ9s73EJ6kvuoyVSlCNSo=;
        b=vm8X+TPLZX/3TMm28ETsCWOl5VAAoKsjNxJ9TIXREX9djlK6gGGmiPebH4NWCjI67E
         WfRzVTe6JOswBNUbRinkHhIgltaSlDrIJohacJHIJeCU9BykVu37FJ01fKaiKiv7pZpv
         r0ePSGWhQT8rOxC2qgiLjcgqRBsrudY1bHjPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785244378; x=1785849178;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RsLXOGn4ljM01hXnayTxvwBZ9s73EJ6kvuoyVSlCNSo=;
        b=lcQ6nWQERyGiAPTEXt5aPUJ+43JZN4s6uUXd7gW+bZx82i4XyjIxrfDG5oYxTXzVB4
         pDWescEJ9r8RWY2FOxWpmk4PRj5C5DO+Wsv+mSKFGBi5SV5zChxw4y5mUFXI3AvRUU2S
         u6sDkEZoANqxZoCJIi1ZPXTaV/GPe1JaDvL3RyrdtKJ02cT4p0YKlRDgFTVkfU1+KJ2+
         dP8aZFI6FDhouh/hsOAillLAHWvSUgR809LQGyZ4Za80oEZt7bLZPfAXSiAmAuVI7Zdg
         xbLdV+oG5fUQevP/t0lkrJZL8Lp11k2LaIn4i6NKBMprLQi32ePazVRoJWBVy06VJwlc
         qnEw==
X-Forwarded-Encrypted: i=1; AHgh+RpavDtr8dUHKRjEd4FVQCB9oEKXIG47O4rxKHmqGEieGZz4jFGr1YZCB6PfQJ60ZViI0zt/yO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoIFjEKuIeF5BVYGYU2Ncze7iwllG0g9+GyxvIidXBownhdJdo
	XPf6hGU+zIZcBLueybN9v42BM1siC6HPUDSjkneQzmgb4I89VDpygppWTmiq8LnfZLny+ktRiUI
	ZxuOpHR+7lPFugxjF9sGGWSetM6TfYEz9v+m8LSOu
X-Gm-Gg: AR+sD13cUy+gzb20bGYijSTJr5i0ii0+OmbDPio/poJzosNcLQ8Vg3BJg5DctXiFWoT
	hl3zKJoM2OHf2+WaQt2Xmqa/6AbCg2LYLt+A+l3KkFoZj5Xi1rKXl+ZIIMP6q1lt0gmuMIMqSuT
	VU1/ddM9jhFc4XHgGgvUlsf/K2WDy8xbiQJBa5ysgf5oJ8EXM7IuV85G5qt2zp9gbLKIWSBSpBO
	SON2m5Fq6X0r8Pue91F/9je+f/Zmd8LxHs4q0fQYeUw0cQyZGJf4b2b4VmGo0nIpje5cgR1Yv9W
	MeEEZNCVRfgWKNtlFYKsxxYyf/Y9xtptflRaNLYn0CSLGQ==
X-Received: by 2002:a05:6a00:21cd:b0:848:2f71:b657 with SMTP id
 d2e1a72fcca58-84e9337dd1dmr2417946b3a.66.1785244377878; Tue, 28 Jul 2026
 06:12:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723105210.817079-1-jhs@mojatatu.com> <3914dd5c-77c8-4f96-8bfc-986f0a00f722@redhat.com>
 <CAM0EoMn6sLJ_OMXY8-B4RE3r9XunFB=OkHbYJ-c-VBpADyO29Q@mail.gmail.com> <da0313c5-1060-49fb-a1a3-72197eda4d8e@redhat.com>
In-Reply-To: <da0313c5-1060-49fb-a1a3-72197eda4d8e@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 28 Jul 2026 09:12:46 -0400
X-Gm-Features: AUfX_mw1XP2-NPHioV06gzDgV5xM2e-PWrTVRmgQN5cosWlyvmNYVqUKt_wf0gg
Message-ID: <CAM0EoMkRMOBmrGW3fAcxxhTxcLaP44zr4m5Ds8G2VFT1CissNA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net/sched: cls_route: fix fastmap use-after-free
 on filter
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, john.fastabend@gmail.com, 
	jiri@resnulli.us, zdi-disclosures@trendmicro.com, sh.kalluri129@gmail.com, 
	victor@mojatatu.com, security@kernel.org, stable@vger.kernel.org, 
	Santosh Kalluri <santosh.kalluri129@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000fb3b0b0657ab9857"

--000000000000fb3b0b0657ab9857
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 9:05=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/28/26 2:37 PM, Jamal Hadi Salim wrote:
> > On Tue, Jul 28, 2026 at 6:34=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >>
> >> On 7/23/26 12:52 PM, Jamal Hadi Salim wrote:
> >>> diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
> >>> index bd6f945bd388..700f878fc3cd 100644
> >>> --- a/net/sched/cls_route.c
> >>> +++ b/net/sched/cls_route.c
> >>> @@ -297,16 +297,29 @@ static void route4_destroy(struct tcf_proto *tp=
, bool rtnl_held,
> >>>                                       next =3D rtnl_dereference(f->ne=
xt);
> >>>                                       RCU_INIT_POINTER(b->ht[h2], nex=
t);
> >>>                                       tcf_unbind_filter(tp, &f->res);
> >>> -                                     if (tcf_exts_get_net(&f->exts))
> >>> -                                             route4_queue_work(f);
> >>> -                                     else
> >>> -                                             __route4_delete_filter(=
f);
> >>> +                                     /* Always defer the free.  The =
direct
> >>> +                                      * __route4_delete_filter() pat=
h has no
> >>> +                                      * grace period and races with =
readers
> >>> +                                      * that cached f in the fastmap=
.
> >>> +                                      */
> >>> +                                     tcf_exts_get_net(&f->exts);
> >>> +                                     route4_queue_work(f);
> >>
> >> Sashiko fears the above would be race prone:
> >>
> >> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260723105210.817=
079-1-jhs%40mojatatu.com
> >>
> >
> > That was fixed in v2. Is there something i can do next time (message
> > patchwork?) to not waste your time looking at an older version?
>
> Usually the tool properly updates the old revision status, but sometimes
> it fails do to that.
>
> Double checking that the old revision is marked as superseded in PW
> after posting the new one could help.
>
> >>>                               }
> >>>                       }
> >>>                       RCU_INIT_POINTER(head->table[h1], NULL);
> >>>                       kfree_rcu(b, rcu);
> >>>               }
> >>>       }
> >>> +
> >>> +     /* All filters are unlinked; no new reader can find them on the
> >>> +      * chain.  Wait for in-flight readers that may still hold a fil=
ter
> >>> +      * pointer and have published it into the fastmap after we unli=
nked.
> >>> +      * Then flush the stale entries while head is still valid under
> >>> +      * RTNL, matching the route4_delete() pattern.
> >>> +      */
> >>> +     synchronize_rcu();
> >>> +     route4_reset_fastmap(head);
> >>
> >> This really looks like quite a big hammer.
> >
> > It is.
> > I viewed  it as bug fix to original intent of 1109c00547fc - that
> > commit even though had the intent of protecting the fast map as as
> > well (based on the wording of comment i saw).
> > If performance is a big concern: another approach that maybe worth
> > considering is to totally remove the fastpath. It maybe more
> > performant than imposing the rcus.
>
> Given the amount of effort involved in rtnl lock contention reduction, I
> think it would be great if we could avoid the synchronize_rcu(), if it
> does not block the fix for an unreasonable amount of time.
>
> >> Since there is already a
> >> synchronization point for both reader and write while acquiring the
> >> fastmap_lock, I'm wondering if something alike the following could wor=
k ?!?
> >> (completely untested!!!):
> >>
> >
> > Your approach has some holes, example misses the most dangerous part -
> > destroy(), etc
> > I will mull over it and see if it can be fixed to handle all the
> > issues. I think it's possible i just need to put time to
> > validate/test.
> I would appreciate that, thanks!

See attached. Untested (compiles) -  addresses my destroy() concern
eaerlier _i think_ (unless something pops up in testing)


cheers,
jamal
> Paolo
>

--000000000000fb3b0b0657ab9857
Content-Type: application/octet-stream; name=patch-paolo-mod
Content-Disposition: attachment; filename=patch-paolo-mod
Content-Transfer-Encoding: base64
Content-ID: <f_ms4odzmu0>
X-Attachment-Id: f_ms4odzmu0

ZGlmZiAtLWdpdCBhL25ldC9zY2hlZC9jbHNfcm91dGUuYyBiL25ldC9zY2hlZC9jbHNfcm91dGUu
YwppbmRleCBiZDZmOTQ1YmQzODguLmM2OGFjOThmMjA0NyAxMDA2NDQKLS0tIGEvbmV0L3NjaGVk
L2Nsc19yb3V0ZS5jCisrKyBiL25ldC9zY2hlZC9jbHNfcm91dGUuYwpAQCAtNTIsNiArNTIsNyBA
QCBzdHJ1Y3Qgcm91dGU0X2ZpbHRlciB7CiAJc3RydWN0IHRjZl9yZXN1bHQJcmVzOwogCXN0cnVj
dCB0Y2ZfZXh0cwkJZXh0czsKIAl1MzIJCQloYW5kbGU7CisJYm9vbAkJCWR5aW5nOwogCXN0cnVj
dCByb3V0ZTRfYnVja2V0CSpia3Q7CiAJc3RydWN0IHRjZl9wcm90bwkqdHA7CiAJc3RydWN0IHJj
dV93b3JrCQlyd29yazsKQEAgLTY2LDkgKzY3LDExIEBAIHN0YXRpYyBpbmxpbmUgaW50IHJvdXRl
NF9mYXN0bWFwX2hhc2godTMyIGlkLCBpbnQgaWlmKQogCiBzdGF0aWMgREVGSU5FX1NQSU5MT0NL
KGZhc3RtYXBfbG9jayk7CiBzdGF0aWMgdm9pZAotcm91dGU0X3Jlc2V0X2Zhc3RtYXAoc3RydWN0
IHJvdXRlNF9oZWFkICpoZWFkKQorcm91dGU0X3Jlc2V0X2Zhc3RtYXAoc3RydWN0IHJvdXRlNF9o
ZWFkICpoZWFkLCBzdHJ1Y3Qgcm91dGU0X2ZpbHRlciAqZikKIHsKIAlzcGluX2xvY2tfYmgoJmZh
c3RtYXBfbG9jayk7CisJaWYgKGYpCisJCWYtPmR5aW5nID0gdHJ1ZTsKIAltZW1zZXQoaGVhZC0+
ZmFzdG1hcCwgMCwgc2l6ZW9mKGhlYWQtPmZhc3RtYXApKTsKIAlzcGluX3VubG9ja19iaCgmZmFz
dG1hcF9sb2NrKTsKIH0KQEAgLTgxLDkgKzg0LDExIEBAIHJvdXRlNF9zZXRfZmFzdG1hcChzdHJ1
Y3Qgcm91dGU0X2hlYWQgKmhlYWQsIHUzMiBpZCwgaW50IGlpZiwKIAogCS8qIGZhc3RtYXAgdXBk
YXRlcyBtdXN0IGxvb2sgYXRvbWljIHRvIGFsaW5nIGlkLCBpZmYsIGZpbHRlciAqLwogCXNwaW5f
bG9ja19iaCgmZmFzdG1hcF9sb2NrKTsKLQloZWFkLT5mYXN0bWFwW2hdLmlkID0gaWQ7Ci0JaGVh
ZC0+ZmFzdG1hcFtoXS5paWYgPSBpaWY7Ci0JaGVhZC0+ZmFzdG1hcFtoXS5maWx0ZXIgPSBmOwor
CWlmIChmID09IFJPVVRFNF9GQUlMVVJFIHx8ICFmLT5keWluZykgeworCQloZWFkLT5mYXN0bWFw
W2hdLmlkID0gaWQ7CisJCWhlYWQtPmZhc3RtYXBbaF0uaWlmID0gaWlmOworCQloZWFkLT5mYXN0
bWFwW2hdLmZpbHRlciA9IGY7CisJfQogCXNwaW5fdW5sb2NrX2JoKCZmYXN0bWFwX2xvY2spOwog
fQogCkBAIC0yOTcsNiArMzAyLDEzIEBAIHN0YXRpYyB2b2lkIHJvdXRlNF9kZXN0cm95KHN0cnVj
dCB0Y2ZfcHJvdG8gKnRwLCBib29sIHJ0bmxfaGVsZCwKIAkJCQkJbmV4dCA9IHJ0bmxfZGVyZWZl
cmVuY2UoZi0+bmV4dCk7CiAJCQkJCVJDVV9JTklUX1BPSU5URVIoYi0+aHRbaDJdLCBuZXh0KTsK
IAkJCQkJdGNmX3VuYmluZF9maWx0ZXIodHAsICZmLT5yZXMpOworCQkJCQkvKiBNYXJrIHRoZSBm
aWx0ZXIgZHlpbmcgdW5kZXIgZmFzdG1hcF9sb2NrIHNvCisJCQkJCSAqIGFueSBpbi1mbGlnaHQg
cmVhZGVyIHRoYXQgc3RpbGwgaG9sZHMgaXQKKwkJCQkJICogd2lsbCBza2lwIHRoZSByZXB1Ymxp
c2ggaW4gcm91dGU0X3NldF9mYXN0bWFwKCkuCisJCQkJCSAqLworCQkJCQlzcGluX2xvY2tfYmgo
JmZhc3RtYXBfbG9jayk7CisJCQkJCWYtPmR5aW5nID0gdHJ1ZTsKKwkJCQkJc3Bpbl91bmxvY2tf
YmgoJmZhc3RtYXBfbG9jayk7CiAJCQkJCWlmICh0Y2ZfZXh0c19nZXRfbmV0KCZmLT5leHRzKSkK
IAkJCQkJCXJvdXRlNF9xdWV1ZV93b3JrKGYpOwogCQkJCQllbHNlCkBAIC0zMDcsNiArMzE5LDE2
IEBAIHN0YXRpYyB2b2lkIHJvdXRlNF9kZXN0cm95KHN0cnVjdCB0Y2ZfcHJvdG8gKnRwLCBib29s
IHJ0bmxfaGVsZCwKIAkJCWtmcmVlX3JjdShiLCByY3UpOwogCQl9CiAJfQorCisJLyogQWxsIGZp
bHRlcnMgYXJlIHVubGlua2VkIGFuZCBtYXJrZWQgZHlpbmcsIHNvIG5vIGluLWZsaWdodAorCSAq
IHJlYWRlciBjYW4gcmVwdWJsaXNoIGEgc3RhbGUgZW50cnkgYWZ0ZXIgdGhpcyByZXNldC4KKwkg
Ki8KKwlyb3V0ZTRfcmVzZXRfZmFzdG1hcChoZWFkLCBOVUxMKTsKIAlrZnJlZV9yY3UoaGVhZCwg
cmN1KTsKIH0KIApAQCAtMzM4LDcgKzM2MCw3IEBAIHN0YXRpYyBpbnQgcm91dGU0X2RlbGV0ZShz
dHJ1Y3QgdGNmX3Byb3RvICp0cCwgdm9pZCAqYXJnLCBib29sICpsYXN0LAogCQkJICogbm90aWNl
IHdlIHVubGluaydkIHRoZSBmaWx0ZXIgc28gd2UgY2FuJ3QgZ2V0IGl0CiAJCQkgKiBiYWNrIGlu
IHRoZSBmYXN0bWFwLgogCQkJICovCi0JCQlyb3V0ZTRfcmVzZXRfZmFzdG1hcChoZWFkKTsKKwkJ
CXJvdXRlNF9yZXNldF9mYXN0bWFwKGhlYWQsIGYpOwogCiAJCQkvKiBEZWxldGUgaXQgKi8KIAkJ
CXRjZl91bmJpbmRfZmlsdGVyKHRwLCAmZi0+cmVzKTsKQEAgLTU1OCw3ICs1ODAsNyBAQCBzdGF0
aWMgaW50IHJvdXRlNF9jaGFuZ2Uoc3RydWN0IG5ldCAqbmV0LCBzdHJ1Y3Qgc2tfYnVmZiAqaW5f
c2tiLAogCQl9CiAJfQogCi0Jcm91dGU0X3Jlc2V0X2Zhc3RtYXAoaGVhZCk7CisJcm91dGU0X3Jl
c2V0X2Zhc3RtYXAoaGVhZCwgZm9sZCk7CiAJKmFyZyA9IGY7CiAJaWYgKGZvbGQpIHsKIAkJdGNm
X3VuYmluZF9maWx0ZXIodHAsICZmb2xkLT5yZXMpOwo=
--000000000000fb3b0b0657ab9857--
