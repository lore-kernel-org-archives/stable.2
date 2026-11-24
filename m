Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.202.193.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554250;
	b=ZiqXeOzChfrf+RmhBSMSk7ftkssYGa5jvYBwgJhDqOu0W/FfhodNehcrEadn60odllba
	 B4LAz21EM57pyet0S5rvu4nZHPMtmdLVfKcjYtCMcpjknHWcuNR17PImweKsIgmxh7R0/
	 QphNEa6Hwe+HvTYzZq5SPL7436FuXmKc6yzV07Qk/ZFo6r6fdoTdOX+Wa2dRWgxY0yG18
	 fyI8NaOl2Eovl1mxoAOx1UQeHaTPNvk3tCwzSG3Cjtw9vL4smjD+rf+Yqu9Dk+64BqeMj
	 aelGYd04ddHD2Fpbvqx7Y2z5Pl8ViBgpAFKsrGV7GIsZvVWy0KT2dCM3fsSakxvg3Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554250;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Feedback-ID:
	 X-Pm-Original-To:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-MIME-Autoconverted;
	bh=f1LrI4F2sKsO306nzg/h2ovN7/3ZcOp7p0chdwD8VeA=;
	b=0lzYA4k8b3Zm3PhZ6wmB7KGUdXwXa5aENF3V9sBNAsszQsPRYAaRUs8nXIFIbguiKJDS
	 PrOvjbjZZlo9hfruQeodYo0lZRm4OisMqPoJ2fGNd5kmZsLW6PriTVKPjNI9OI+X4/kf+
	 YtFDbdUDowxU3o3Ny3HmZ4GkIQ1nzjVp+WB9yDSkhqIfdyx2ngxzUcTfBfn0x2kVCz6b9
	 2jIL4HJu/PPS2V5/+kz031PQX4hB56V/8eRYXlUmN4wVMVKf2Ez3gLuenFQYgHEjmKGJV
	 ztqdA2tSiJUBGnur5Bg/XzqlNcIjQCb9JcfjSZ42VLzY7Lbj6j3qugnTgMAWGzhcs0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	dkim=pass header.d=atomlin.com header.i=@atomlin.com header.a=rsa-sha256 header.s=purelymail2 header.b=bvY+kW9s;
	dkim=pass header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail2 header.b=NV3pbREF;
	arc=none smtp.remote-ip=34.202.193.197
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579FA606A32D
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 21:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 579FA606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=atomlin.com header.i=@atomlin.com header.a=rsa-sha256 header.s=purelymail2 header.b=bvY+kW9s;
	dkim=pass (2048-bit key, unprotected) header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail2 header.b=NV3pbREF
DKIM-Signature: a=rsa-sha256; b=bvY+kW9smQ/USSNTgGxUuIjv7MH+/vcE3aruhQ3qL5AJS471/M00i6PR9yIqof3dDsH+yvfsKhhymID5zTPUHJcso/W9qory1BilPTnB0rBdjzxUWmkFqakHISanXgAMu8xlEqQlEGpBfyOq+F3JUjIvSDrjVlfhOI8eb+WXYGoqIk9kGzQPAYeDHKIl4ehMndr4wpa4cw1IweczFimpUxNuTNy9QM9k20cfTPwt9QEO0Jh6xPyp76WsQkkWhqWWz8GDirX/FBIAgf0ndnqUbsGLF13YDOxFdB8xsMn7RqdBEQwJ72PAEMDftEk3BMbvjBWz1vwINeOn0ZJPVpYqpA==; s=purelymail2; d=atomlin.com; v=1; bh=LBTIbpSasOIttazXOXIKcClliW3GfeA4oLmDKjXQ628=; h=Received:Date:From:To:Subject:Message-ID;
DKIM-Signature: a=rsa-sha256; b=NV3pbREFn0LmAuGk5gPXW0P/M6HzawY5DFxLnmR/wb6GoOcr+7EseirwQ0rRCTKihZ/IxJ0vyjZ/9cGp/WP+ivzlS8+PBT++F6C3r9LRVdw4VwzVOwmmFiVSBwWNmBI6WzdYskgAkPx1WJglBNEhwvm0pWUFaSy0i9C9Wp6yOvzks3PK5hCGRPJBu0yiH88iGuFw4TLTBdwUXRgCXVip1Ikia+ZvzBTZf1/18lIw1dSEahWNxSPC3k7aMLkcPrcr20+h//Y/iVr+/Ms1rQonZu3INGQ5Kofcbj9dmLFMll+hfXO+RncjNtyS02XNqJ+Pal+NGYZqMoVPru4Ir73KxQ==; s=purelymail2; d=purelymail.com; v=1; bh=LBTIbpSasOIttazXOXIKcClliW3GfeA4oLmDKjXQ628=; h=Feedback-ID:Received:Date:From:To:Subject:Message-ID;
Feedback-ID: 1802931:67223:null:purelymail
X-Pm-Original-To: stable@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1233994586;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 24 Nov 2026 21:03:22 +0000 (UTC)
Date: Tue, 24 Nov 2026 16:03:21 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: axboe@kernel.dk, tom.leiming@gmail.com, hare@suse.de, dwagner@suse.de, 
	emilne@redhat.com, frederic@kernel.org, tj@kernel.org, sean@ashe.io, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5] blk-mq: dispatch kworker to housekeeping CPU when
 hctx cpumask is empty
Message-ID: <b7vpfd7x6mqmxlu2kqpdzx4oeyxvak7tiit7xslkjdrqblcoh4@aujkhfpmwqnh>
References: <20261121235203.811792-1-atomlin@atomlin.com>
 <CAAofZF5D+ycbtMxsnUgZjhUbfD+_ZD6kYyci95OTdXug_aw-dQ@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAAofZF5D+ycbtMxsnUgZjhUbfD+_ZD6kYyci95OTdXug_aw-dQ@mail.gmail.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On Mon, Nov 23, 2026 at 11:47:47AM +0100, Marco Crivellari wrote:
> Hi Aaron,

Hi Marco,

>=20
> On Sun, Nov 22, 2026 at 12:52=E2=80=AFAM Aaron Tomlin <atomlin@atomlin.co=
m> wrote:
> >
> > [...] In real-time environments, an active SCHED_FIFO workload will
> > starve this SCHED_NORMAL worker and stall hardware dispatch, whilst als=
o
> > introducing unwanted latency jitter on nohz_full cores, defeating that
> > commit's original objective.
>=20
> I would phrase this differently. cpu_is_isolated() checks HK_TYPE_DOMAIN,
> so the jitter argument holds only when the nohz_full CPU is also
> domain isolated (isolcpus=3Ddomain or an isolated cpuset partition). With
> nohz_full alone, or isolcpus=3Dnohz without domain, this patch does not
> apply and the behavior is unchanged.

Agreed, that distinction is much clearer. Since both commit a46c27026da1
and blk_mq_hctx_unbound_cpu() test cpu_is_isolated() (HK_TYPE_DOMAIN), CPUs
configured solely with nohz_full=3D or isolcpus=3Dnohz without domain isola=
tion
(or an isolated cpuset partition) remain unaffected. I will reword the
commit log in the next iteration to clarify that this applies specifically
to domain-isolated CPUs (including when combined with nohz_full).

>=20
> > +static inline int blk_mq_hctx_unbound_cpu(void)
> > +{
> > +#ifdef CONFIG_CPU_ISOLATION
> > +       if (static_branch_unlikely(&housekeeping_overridden)) {
> > +               int cpu;
> > +
> > +               guard(preempt)();
> > +               if (!cpu_is_isolated(raw_smp_processor_id()))
> > +                       return WORK_CPU_UNBOUND;
>=20
> Since preemption is disabled by guard(preempt)(), you can use
> smp_processor_id() here instead of raw_smp_processor_id().

Oops! raw_smp_processor_id() was a leftover from v4 before guard(preempt)()
was moved ahead of cpu_is_isolated(). I will switch to smp_processor_id()
in the next iteration.

Thank you for the review!

Kind regards,
--=20
Aaron Tomlin
