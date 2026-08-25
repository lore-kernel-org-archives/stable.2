Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEB93FAE19
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787655771; cv=pass; b=Q8P4h00J47CQ94i0Pkw3hltEpaxDebNamEQXV7aDtRwcWmTbZ3flruIlXU7EQf3mXPauPSdcsyiD7Ape/JBdemRCsTZ/fR3Zo00M1NYpz8k1wXTj6/PKpIgTmUqIfXPLqGjH7J/hED3Oy85kC9zUJdK97Oaacq8FWgq5WqNHUVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787655771; c=relaxed/simple;
	bh=O7oN+5ypnrgvnpz+DAdTMI/+5pdrmXGSddGlMOUk4ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXYRQO1CRbrdpcOBLriwgtQyTrOlfmaahqEcH1BI/3qyw9rRKj6FocXOafbj/PhmarUUJOs4uaS5+R8/4LwYPpmtlVeILRKdMetT4Sue8Mja4B3Ll4atu6UYHT+oS4LkvPtrNk5TBXl+0m4NgEWkagcPK0sU2npCwLv9BCLZgHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ADaEVmAo; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="ADaEVmAo"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84eb992a881so3502572b3a.2
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 04:02:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787655768; cv=none;
        d=google.com; s=arc-20260327;
        b=FgWNCRsbUEAtusGnEq969kTmjll7Y98M/IZEGB0L0jNZ3ZG4DmTDywSFG1oD9kLP4B
         +B+nYiKYlHC4b6uQGk2Xvnp8yh2ZB2zXFI5boGAJYvnGEGNqEv8nlPGt+Wx5hkaL5GTZ
         KNpR3OndcOTdPxOo0Bn4xlcN/ZJGfHTer4Kf2jr9Eejg3X3zd4MsipJxVI9FA6XtoHd4
         oH+sXIVk0yN1hIFAMEAYL2kNsF8zlQYVgushGAczWSiVlxsbsWVZ1jX4ILa1WVsHiJaj
         JO++7HUHcw2fdjcTwoCawOzsdCUcUhGPR6Zq2vMuNwnCajEJm/0Ca+CyBQKkTh2vbaJs
         AK5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wuxkasmS4758DhsbvfWN+PcQaFQqwlSEUUCXzsCOmhY=;
        fh=eWuzVIXAM5H54n+ZLvVjEUgtlY26brtnW0DbSGW4Q4g=;
        b=ls3sfnzOBE9eX07PBaknr+1oaTB+W01cvLjCScw11Lwj6yLcvewTIfdmdjE6HUcUW+
         Ni92KgKJxxc6Tk2k7pftc2li84DM0R4bizS1yTWtTEfubNV8kt5vk8RJBTtBLqLtJtYZ
         L9FhzsRuyiUpYtwzAkqyg9SuuYOC3MM6yceVEf+c4ugFWKDEEcBaPhEbBbs48SoaEeAI
         fWeD/J5fg80PWEnanVq4GYK44/9Fi/sOMVVxseHm1AYCRS/4KzAqP7kuRQPt6CE5eeR8
         Oz1KMPROOMbNOBJFFpWyLFC6zm0KwXIbsV6YjAQ/u21JIrmNJekdGMWut53F5oDwlVoA
         IYyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787655768; x=1788260568; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wuxkasmS4758DhsbvfWN+PcQaFQqwlSEUUCXzsCOmhY=;
        b=ADaEVmAoLzWdpkKNXOGCLOonT6xjw7BtMvGLVp1ZkwMFfLTkKDEDWidTIpzS6aJ93a
         IkBxPFYGiGkiSN7HcMcZghn4zqGeG+5jzvH4/BCqiehiBkLw1KTvWeLTLAbgLdEHYMC6
         2AVRKpSMKjmF+97j1EdL8dCy3ZwyWMuqR9qUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787655768; x=1788260568;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wuxkasmS4758DhsbvfWN+PcQaFQqwlSEUUCXzsCOmhY=;
        b=MJeJzy0CTsEfDTS3drZaeWxaMEg+zhPTooutghfvcgSUhnPmM9vDg0glj6cCFG42ZR
         qYhoP826AvQt5HysF6Te1PGgVPAunZPrIkJ6GYBpo3X+mfkOSalVIwOzeONqxOqrMXul
         ipU5b+45XuNZnIpjiSExeLcaLSrqhrp+BJrbh3oLV/peF3bs6KJT88uqwovHPbm6rLgk
         U5hBSKYKxJbwKLME7bJAVmJzpTwI0a1TL+DPvGauyd4Ze6fU2dRyC4f3wSdM05LWwmR1
         oQ3zC1WUnjGWt0O2FM43yOL56aLCw001Kc7VVKRcpoTl0Rb0oqMk5SQIzAIgxhgKG6+N
         8mIA==
X-Forwarded-Encrypted: i=1; AHgh+RrB9fYjF4VOWjYvBTxPbeMub5AFD18aeSyfUbCY70ibz+of8a8HORIIXMgKLLEz4ThnP+8MeFs=@vger.kernel.org
X-Gm-Message-State: AFuF++krQLmbdjitSUV7y1sEjwu/tISBUxChD934gYsbXK8q5Hp6AlzV
	Es9oUs0t9xIHVm1jR/3VHY6JaZkdkfPfF6q61/48KZ30N0LsJklBcIkNth1IJEfTzNM8+eyttry
	21JI7UzopX/vF3fPLnvc1vetbt/uIOOkVM8OJ2l6l
X-Gm-Gg: AR+sD13IwsZVHGlvf48DGADRFxBfen7162aQ0/53fUCZ334h7rtjpi6vM5fc5Ru7b8G
	+4JqvK1BpR4+cOiDF0LgieFRTdbF8IfESk7TueFohPUnzdFLW9dTjU4ymiZfUOT6RW1f+tXpdRW
	J2RBXeNrl+8KE6gsH1MmmI7DqKrE720ZWXmkxWWUdLky60Ynl5Jan3sgD+tAx2QAGRYETDhzLBa
	tLi451CvVc9yer7/KnNt1VO6yYKAEKBFvH1lHs3Ejor4edu108MEUb0XRFnKh9SlH0oNrlGEyg5
	uqSeHdWwQA3LL+iA6gj02fnNV7Vr++NoFAFg/ysWPxRdmA==
X-Received: by 2002:a05:6a00:420c:b0:845:dfef:75b8 with SMTP id
 d2e1a72fcca58-8523c9972damr11759279b3a.15.1787655767497; Tue, 25 Aug 2026
 04:02:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822195509.112717-1-jhs@mojatatu.com> <20260822195509.112717-2-jhs@mojatatu.com>
 <CANn89iKYg5YzY1QhU7D8mETW6avf4K-yoCwPNGiSrxRhdswbCg@mail.gmail.com> <CAM0EoM=bNoXFP5ub9gBopJ_-1GxSB68s65pZGvYjGwifuOsBTA@mail.gmail.com>
In-Reply-To: <CAM0EoM=bNoXFP5ub9gBopJ_-1GxSB68s65pZGvYjGwifuOsBTA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 25 Aug 2026 07:02:32 -0400
X-Gm-Features: AcwNN1VdJsI5lGXQ9Qej1pldtXtix4LTgC7bWChSobF7rmBsTQFAw5hreuWVIPI
Message-ID: <CAM0EoMkYJZFsb13B_gxMQCmQBKpV3BpqKwETgAJBAAVAyU06VA@mail.gmail.com>
Subject: Re: [PATCH net v3 1/6] net/sched: fq: add overflow bounds to quantum
 and initial quantum
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: multipart/mixed; boundary="00000000000000cee30659dd0bc1"

--00000000000000cee30659dd0bc1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 6:43=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Tue, Aug 25, 2026 at 6:03=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Sat, Aug 22, 2026 at 9:55=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > fq_init() computes quantum =3D 2 * psched_mtu() and initial_quantum =
=3D 10 *
> > > psched_mtu() with no overflow check. A device with a huge MTU (e.g. d=
ummy
> > > with max_mtu =3D=3D 0 accepting MTU 2147483634) makes psched_mtu() re=
turn
> > > 0x80000000; the 2 * and 10 * multiplications wrap to 0 in 32-bit
> > > arithmetic, so q->quantum =3D=3D 0. Then in fq_dequeue() the credit-r=
efill
> > > loop adds 0 to f->credit (which stays <=3D 0) and goto begin loops
> > > forever under the qdisc lock, creating a soft lockup.
> > >
> > > Clamp psched_mtu() to [1, 1 << 20] before multiplying so the product
> > > cannot wrap, then cap the result at 1 << 20, matching the bound alrea=
dy
> > > enforced on TCA_FQ_QUANTUM in fq_change().
> > >
> > > Conditions to recreate the bug: a device whose MTU (plus
> > > hard_header_len) is large enough that 2 * psched_mtu() wraps (e.g. a
> > > dummy device with max_mtu =3D=3D 0 accepting MTU 2147483634). Require=
s
> > > CAP_NET_ADMIN in a user namespace.
> > >
> > > Fixes: afe4fd062416 ("pkt_sched: fq: Fair Queue packet scheduler")
> > > Reported-by: vega@nebusec.ai
> > > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > ---
> > >  net/sched/sch_fq.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > > index 7cae082a9847..8a071c35b869 100644
> > > --- a/net/sched/sch_fq.c
> > > +++ b/net/sched/sch_fq.c
> > > @@ -1222,12 +1222,14 @@ static int fq_init(struct Qdisc *sch, struct =
nlattr *opt,
> > >                    struct netlink_ext_ack *extack)
> > >  {
> > >         struct fq_sched_data *q =3D qdisc_priv(sch);
> > > +       u32 mtu;
> > >         int i, err;
> > >
> > >         sch->limit              =3D 10000;
> > >         q->flow_plimit          =3D 100;
> > > -       q->quantum              =3D 2 * psched_mtu(qdisc_dev(sch));
> > > -       q->initial_quantum      =3D 10 * psched_mtu(qdisc_dev(sch));
> > > +       mtu =3D clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
> > > +       q->quantum              =3D min_t(u32, 2 * mtu, 1 << 20);
> > > +       q->initial_quantum      =3D min_t(u32, 10 * mtu, 1 << 20);
> > >         q->flow_refill_delay    =3D msecs_to_jiffies(40);
> > >         q->flow_max_rate        =3D ~0UL;
> > >         q->time_next_delayed_flow =3D ~0ULL;
> >
> > Note that after FQ qdisc has been created, it can be changed, and
> > fq_change() and/or iq_range
> > need to be fixed.
>
> Right. TCA_FQ_QUANTUM is already bounded to (0, 1<<20] in fq_change(),
> but TCA_FQ_INITIAL_QUANTUM goes through iq_range which has .max =3D
> INT_MAX =E2=80=94 so fq_change() accepts values up to INT_MAX while init =
now
> clamps to 1<<20.
>
> I'll fold that into the follow-up patch I'm preparing for the
> fq_pie_change()/sfq_change() 256-floor gaps Paolo flagged =E2=80=94 same
> pattern (init clamped, change path not). Narrowing iq_range.max to
> 1<<20 will reject at parse time, matching the init clamp.
>

Something like attached - untested. Sigh, i think i had what you are
asking for in v2 but lost it in translation to v3.

cheers,
jamal


> cheers,
> jamal

--00000000000000cee30659dd0bc1
Content-Type: application/octet-stream; name=p1
Content-Disposition: attachment; filename=p1
Content-Transfer-Encoding: base64
Content-ID: <f_mt8k2syy0>
X-Attachment-Id: f_mt8k2syy0

ZGlmZiAtLWdpdCBhL25ldC9zY2hlZC9zY2hfZnEuYyBiL25ldC9zY2hlZC9zY2hfZnEuYwppbmRl
eCA2MTQ0YjU2ODZmMTMuLmFiOGU3YzZhZTIwMyAxMDA2NDQKLS0tIGEvbmV0L3NjaGVkL3NjaF9m
cS5jCisrKyBiL25ldC9zY2hlZC9zY2hfZnEuYwpAQCAtOTgwLDcgKzk4MCw3IEBAIHN0YXRpYyBp
bnQgZnFfcmVzaXplKHN0cnVjdCBRZGlzYyAqc2NoLCB1MzIgbG9nKQogfQogCiBzdGF0aWMgY29u
c3Qgc3RydWN0IG5ldGxpbmtfcmFuZ2VfdmFsaWRhdGlvbiBpcV9yYW5nZSA9IHsKLQkubWF4ID0g
SU5UX01BWCwKKwkubWF4ID0gMSA8PCAyMCwKIH07CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgbmxh
X3BvbGljeSBmcV9wb2xpY3lbVENBX0ZRX01BWCArIDFdID0gewpkaWZmIC0tZ2l0IGEvbmV0L3Nj
aGVkL3NjaF9mcV9waWUuYyBiL25ldC9zY2hlZC9zY2hfZnFfcGllLmMKaW5kZXggYjI3ZDk1NDE4
NzA3Li41OTgyODQ3ZGY4ZjggMTAwNjQ0Ci0tLSBhL25ldC9zY2hlZC9zY2hfZnFfcGllLmMKKysr
IGIvbmV0L3NjaGVkL3NjaF9mcV9waWUuYwpAQCAtMzQxLDcgKzM0MSw4IEBAIHN0YXRpYyBpbnQg
ZnFfcGllX2NoYW5nZShzdHJ1Y3QgUWRpc2MgKnNjaCwgc3RydWN0IG5sYXR0ciAqb3B0LAogCQkJ
ICAgbmxhX2dldF91MzIodGJbVENBX0ZRX1BJRV9CRVRBXSkpOwogCiAJaWYgKHRiW1RDQV9GUV9Q
SUVfUVVBTlRVTV0pCi0JCVdSSVRFX09OQ0UocS0+cXVhbnR1bSwgbmxhX2dldF91MzIodGJbVENB
X0ZRX1BJRV9RVUFOVFVNXSkpOworCQlXUklURV9PTkNFKHEtPnF1YW50dW0sCisJCQkgICBtYXgo
MjU2VSwgbmxhX2dldF91MzIodGJbVENBX0ZRX1BJRV9RVUFOVFVNXSkpKTsKIAogCWlmICh0YltU
Q0FfRlFfUElFX01FTU9SWV9MSU1JVF0pCiAJCVdSSVRFX09OQ0UocS0+bWVtb3J5X2xpbWl0LApk
aWZmIC0tZ2l0IGEvbmV0L3NjaGVkL3NjaF9zZnEuYyBiL25ldC9zY2hlZC9zY2hfc2ZxLmMKaW5k
ZXggMTg3ZDNlZDU3OGYyLi45MzJhNzZiY2Y4MDggMTAwNjQ0Ci0tLSBhL25ldC9zY2hlZC9zY2hf
c2ZxLmMKKysrIGIvbmV0L3NjaGVkL3NjaF9zZnEuYwpAQCAtNjg4LDcgKzY4OCw3IEBAIHN0YXRp
YyBpbnQgc2ZxX2NoYW5nZShzdHJ1Y3QgUWRpc2MgKnNjaCwgc3RydWN0IG5sYXR0ciAqb3B0LAog
CiAJLyogdXBkYXRlIGFuZCB2YWxpZGF0ZSBjb25maWd1cmF0aW9uICovCiAJaWYgKGN0bC0+cXVh
bnR1bSkKLQkJcXVhbnR1bSA9IGN0bC0+cXVhbnR1bTsKKwkJcXVhbnR1bSA9IG1heCgyNTZVLCBj
dGwtPnF1YW50dW0pOwogCWlmIChjdGwtPmZsb3dzKQogCQltYXhmbG93cyA9IG1pbl90KHUzMiwg
Y3RsLT5mbG93cywgU0ZRX01BWF9GTE9XUyk7CiAJaWYgKGN0bC0+ZGl2aXNvcikgewotLSAKMi40
My4wCgo=
--00000000000000cee30659dd0bc1--
