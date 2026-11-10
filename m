Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318221;
	b=b/nnAyHzOyQgSiJKZ6RCwidb2vmARApV7QszfMbMXQQEYVsPJZtN00uNhSgjKzssj70s
	 QdOvkt6StFXmreugKfWkRiUFsvt1IF72r4Akz8ZSpGbhL9m/BE7rJcOcVCzRlzr59JufW
	 E2K3wN57XEiu7/il4ixHrErhdc8WN/MrFhDaITJv1vngNW5euLPsTGb77rvcJG+wYkNVU
	 2qIf3DZlf73OuMy/Gpk/UoV1Q3lW4nVzljcUNs9dzIaBsFpJDtYUAuZBh/poJhfTWDSVA
	 ez7emhwP0ijHH5RYqAVGSTwJLYJfyskOUZDhaUVhNRbLtAxHG/jr+BC8rYwzk/oYCng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318221;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=O/pJHAniufO7T+Qw3N8oZy2xDYQiP7/ckPKZfGD+HG0=;
	b=nUk45Nzmlr2aICGvT2PzeN8+drQbcfJsZSOfIBLLPXZ6iIgWW+WkjATT4FPFkzOSy4B+
	 1RExJkcNxcOPEWLyYvGl0tVxJzL87Ro6ub2fjmxnyEMpN/4k2uHJuB4gnFiLh2KYnJTn0
	 nfduS87ntxeYIyJ7zeSu+5eiY1Q356vzgftypWcAg6+WhetNDFGHRCbyUJSNygtMHAQrE
	 ijOA5qmiPI/DeDEKx52FKhuZGNR7GjUe3GKO1W/JrHuOmmJFKQiIRsvTdaoJybwIHURB+
	 hDqB04pzvAwtNaqo9ivDsh3IOA7KXwzOq3QiJxFwjbU8VkBi3I4LinK8ukOxK0fV2uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X35Ie0l6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A002606A331
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X35Ie0l6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E091F008A5
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318220;
	bh=O/pJHAniufO7T+Qw3N8oZy2xDYQiP7/ckPKZfGD+HG0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=X35Ie0l6xxvw4jnrTxdLHJi5zZXKxSS5FgGv1NVilkBAlR4KrJMIpS2P7mLKkb1Xt
	 DS0r8i0Q7z5BdtLQE5PXIh824UuNYowXk7WbYZJJkHuA0OUzodC8pI3ClQPZAf30aY
	 sZIuaUv4NrelZB8undh/sLPU6UwYhTT8m1ig9prMT33gh3ic3CgI0NfO/O8jKriGjY
	 j8uTR/5jLwEw+FWkSpG7TJq5qN88J0lK3QGTEOC5HFrY3eqn5l2E3b4z60QjA7kvMY
	 ISzQG0xl9PkNP6gwfmWjGTgrf+zK1hdaFsJAydCJt84EX3rVty54gIOR06D+KshCWR
	 avqEYshnjFd/g==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5be4fea434bso1964662e87.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:43:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErE61YPgyHr5GivN4yHOLLRUIlB56VG+dz57+2WGfEwQmSzCBguget9aO3baXi/Bft3g5cJc2Qg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9O/FmaDO7CLKogRBeiq5WlzeUUCSrSDq4r2qniYwHBn+8ZoA7g
	6LHIukaX4HclE+W4phm2RWGdKG1/1pymnM6GWTZxvLd1dOT0Cyz6CZdyi+cOuhVSe0oSTkHQWD2
	rhZmFXl0jT1REQeDUikXOqgiV2JkZAvM=
X-Received: by 2002:a05:6512:138f:b0:5be:409b:9456 with SMTP id
 2adb3069b0e04-5c156df0efcmr715179e87.34.1794318219335; Tue, 10 Nov 2026
 05:43:39 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103-em-rank-boost-separately-v2-1-5a13d1b38d37@oss.qualcomm.com>
 <CAJZ5v0hy1D7anTe=CXNXZyMNSN_yHh5hOt6B0bEHTEONRJFMhQ@mail.gmail.com>
 <3e7c3a82-6a99-4c2f-9568-2382ea77ba0e@oss.qualcomm.com> <1dadcd02-19b0-482b-b16d-293430227c5c@arm.com>
 <901516c9-d1be-4918-840e-e3617f2a1782@oss.qualcomm.com> <6b0ee061-38b9-413e-9a83-90446b484859@arm.com>
 <CAJZ5v0i8a98rjFdQ2Jhu_Xk=qCGiNafMfhzNs26cEJNCYB6Xdg@mail.gmail.com> <4f0c8581-a8fb-4bc4-82cc-d30f2f56d2ce@arm.com>
In-Reply-To: <4f0c8581-a8fb-4bc4-82cc-d30f2f56d2ce@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 10 Nov 2026 14:43:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iX8wYDUo9uUjkqkKq1tpLAu7iaZk+iQzWGigNAqfrsNg@mail.gmail.com>
X-Gm-Features: AclHuK-pcwwNwXj_L6iW3-vvSkvrQjC7ziz7J5YFE42wW0pgOcr3E-9SlUnpCf4
Message-ID: <CAJZ5v0iX8wYDUo9uUjkqkKq1tpLAu7iaZk+iQzWGigNAqfrsNg@mail.gmail.com>
Subject: Re: [PATCH v2] PM: EM: Exclude boost frequencies from inefficiency ranking
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Guo Chen <guo.chen@oss.qualcomm.com>, Vincent Donnefort <vincent.donnefort@arm.com>, 
	Matthias Kaehlcke <mka@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, xin.liu@oss.qualcomm.com, aiqun.yu@oss.qualcomm.com, 
	tengfei.fan@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 2:11=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Hi Rafael,
>
> On 11/10/26 12:15, Rafael J. Wysocki (Intel) wrote:
> > On Tue, Nov 10, 2026 at 10:58=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.c=
om> wrote:
>
> [snip]
>
>
> >>
> >> That's fine, please continue.
> >
> > I have a couple of questions though.
> >
> > First, why is the ondemand governor mentioned in the changelog?  In
> > the mainline, the ondemand governor cannot work with EAS, so it
> > shouldn't matter for this issue, should it?
>
> The ondemand is affected by the EM setup code and set 'inefficient'
> flags for some OPPs. The EM is also present for cooling devices
> and can work w/o EAS and schedutil, w/ just ondemand governor.
>
> Because EM marks the OPPs kind of 'globally' as inefficient, then
> they become CPUFREQ_INEFFICIENT_FREQ entries in the CPUfreq fwk.
> In the EM code we have:
> cpufreq_table_set_inefficient(policy, table[i].frequency);

So maybe this is the one that needs to be fixed?  What about simply
skipping boost frequencies in it?

> Then ondemand check for CPUFREQ_RELATION_HE will skip them and
> pass to __cpufreq_driver_target() with that flags as well.

Thanks for explaining and all of that needs to be said in the patch changel=
og.

> >
> > Second, why is the issue regarded as a defect in the code and not in
> > the energy model?  Arguably, boost frequencies should be more costly
> > than the non-boost ones.  At least the idea behind the boost is making
> > higher-cost OPPs temporarily available.  If they are sustainable,
> > treating them as boost OPPs is rather pointless.
>
> IMHO it was a bug in the commit mentioned in this patch fix tag.
> It is affecting more than just EAS or EM, since the EM is working with
> all generic code and all cpufreq governors.

To be precise, the EM initialization may affect cpufreq in general
because inefficient frequencies are used for CPU cooling.  Fair
enough, but I'm not talking about this.

I'm talking about a reason for giving boost frequencies lower or equal
cost relative to non-boost frequencies in the energy model because
this doesn't make sense to me TBH.

And I get that such energy models were there before the commit in
question and now they are not working properly, but IMO they are
broken, not that commit.

> >
> > TBH, I'm too comfortable with looking at cpufreq frequency from within
> > the EM code.  If that needs to be done, something is amiss at the
> > design level.
>
> I think this edge case is special, as I described above.
>
> I'm happy to hear your view on this EM influence to some global
> setting in cpufreq. Maybe it was too far to establish this
> 'inefficiency' flags in there for many usage?

There's nothing wrong with using the information from the energy
model, when available, to amend cpufreq, but the patch goes the other
way around: It tries to amend the energy model with information taken
from cpufreq (in order to avoid making mistakes later when amending
cpufreq with the energy model information).

I think that cpufreq should simply refuse to set
CPUFREQ_INEFFICIENT_FREQ for boost frequencies.  Wouldn't that work?
