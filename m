Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322788;
	b=NDrMpxiPRt1J5dsIWyJMMcgyz0hCyiJFBJc66TA7DIgJFuVgm6wsAtf+H4L7WAL2H1Uu
	 h65I858JhQwcqndfqYY/y/TBT0iCYQrwiA60Dnl4pYmfJYCtL3FxDVmTIIp58dCEb/QqU
	 wX8Pqy1Rjz9AjskgTolkSHNKe2+ud1QkPJakafDEJw+t31w77d71ZjGl8t3Sl0/fYVSqa
	 2RdH+lrq/fZbScEMhiZI3sL4bf+FKvfuLAnCoOsAdQ3my+gXZkXnCMmXJwlev5ow44RSH
	 bxVda/bouABIxlx1J53Du5j2akYM+H5xF/nN5znSZg8iBv9lz9CvSKNGa9pmDPeBSTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322788;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=h0LczxNhe2INpVH2bQ3JXBuCJHEblX00fBP9hcj/J7I=;
	b=W1tUGqQgOx+OwIQuNwVBAKVuyU9qUs7s+grM0U1u2x59Y3CIfXgTEIZ9TxIlqOIhusJ4
	 gDTsFgma6fcW88SE+Iy4aZU9EA/Dt0F6mbq6wSSs/+yIqiQo8jt5F4TaUiR9yclmAsB1O
	 SNufGGUKo3vlkb6LZs45gVzIwZJxzKQ4I2G6H9Z6XsjN5VpT4fISPTyQS6GFTkdICL5Ty
	 MuMG6x7ci31oLNBKG62rjorY/7iwGqo6b+CzcjG21ox5uZ4d/TGWu9GTF6P4WfW+NFa7/
	 XoiLYO0UeUEJbk6m+Yof4WO5RFxtJpTWUsR3MOuqj/BenT6Ynxy1RvTjeqoD0wrRocg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2awIJCw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A4860A2615
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2awIJCw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0EF1F008BD
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322787;
	bh=h0LczxNhe2INpVH2bQ3JXBuCJHEblX00fBP9hcj/J7I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=l2awIJCwTRRXicuS6YrLpPlY32zWKzf6vIr9WNUrKkxa85h52Y/mcceBNq6PTDtTb
	 BcmsPiKKcuHnKYYpR3OxvSLAw2jpZGwqT/kZmwpekO3A6naBOzVp4cAwIYjtkL08YJ
	 M/CJjB+46fWvuPIgqukT0su9EwhX0KJR5YGXhWwPA1woHq5gY0S0A7SYAlys/gW/Fa
	 jcDqQYCFFp12SFRBz/RyGo87fKe9Duk4d2MTe5krDr7O4YCL6lFC3mmYJzPnziYMXs
	 KLsGVDvt3FrVD1VWJYxar7H0g72v7X+L/xd4mTIhAlSkZnV92H5jww8uuiCQVSlVCr
	 +uA0/QOa3BgFw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5be47aa555cso1875705e87.3
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:59:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF98bFK03phS8gVcWq6tdSzHE19YZILoNLek+tatWAuMWRVeI6sZ4uWYuELVzs8y5C3OUpiRNM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8V5aVqHgTOa9EPgGsubDLrdnPYfy/Z8KX1fBWtLAdOLyfzG9z/
	r249Nvg8sFzRBDf1mptmThjmHOR6rO6kXHowgLrWOhGvhI3FpOKLZ7wMwjoq5j71wiv0MRrtKNH
	rzFHM7nJsdjpw9YGyDMqvoNVWTUREIu0=
X-Received: by 2002:a05:6512:3d0d:b0:5c1:595f:2a6e with SMTP id
 2adb3069b0e04-5c1595f2b5cmr698809e87.30.1794322786034; Tue, 10 Nov 2026
 06:59:46 -0800 (PST)
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
 <CAJZ5v0i8a98rjFdQ2Jhu_Xk=qCGiNafMfhzNs26cEJNCYB6Xdg@mail.gmail.com>
 <4f0c8581-a8fb-4bc4-82cc-d30f2f56d2ce@arm.com> <CAJZ5v0iX8wYDUo9uUjkqkKq1tpLAu7iaZk+iQzWGigNAqfrsNg@mail.gmail.com>
 <bb99aa3f-fd15-4bdd-9319-ccedffc281c8@arm.com> <ec04f795-6cc6-444a-bbee-70c7982932e3@oss.qualcomm.com>
In-Reply-To: <ec04f795-6cc6-444a-bbee-70c7982932e3@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 10 Nov 2026 15:59:33 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0js0pbcKRp-cNVu_aPstT4meF-u_z012Q-AA=pvvOY=qA@mail.gmail.com>
X-Gm-Features: AclHuK8W-dhV82kUyxdWYbr0P3AitD7sWmEuASvUUYFVlAvNk8CDoyLVSXQQdO0
Message-ID: <CAJZ5v0js0pbcKRp-cNVu_aPstT4meF-u_z012Q-AA=pvvOY=qA@mail.gmail.com>
Subject: Re: [PATCH v2] PM: EM: Exclude boost frequencies from inefficiency ranking
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Guo Chen <guo.chen@oss.qualcomm.com>, 
	Vincent Donnefort <vincent.donnefort@arm.com>, Matthias Kaehlcke <mka@chromium.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	xin.liu@oss.qualcomm.com, aiqun.yu@oss.qualcomm.com, 
	tengfei.fan@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 3:56=E2=80=AFPM Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> On 11/10/2026 10:05 PM, Lukasz Luba wrote:
> >
> >
> > On 11/10/26 13:43, Rafael J. Wysocki (Intel) wrote:
> >> On Tue, Nov 10, 2026 at 2:11=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.c=
om> wrote:
> >>>
> >>> Hi Rafael,
> >>>
> >>> On 11/10/26 12:15, Rafael J. Wysocki (Intel) wrote:
> >>>> On Tue, Nov 10, 2026 at 10:58=E2=80=AFAM Lukasz Luba <lukasz.luba@ar=
m.com>
> >>>> wrote:
> >>>
> >>> [snip]
> >>>
> >>>
> >>>>>
> >>>>> That's fine, please continue.
> >>>>
> >>>> I have a couple of questions though.
> >>>>
> >>>> First, why is the ondemand governor mentioned in the changelog?  In
> >>>> the mainline, the ondemand governor cannot work with EAS, so it
> >>>> shouldn't matter for this issue, should it?
> >>>
> >>> The ondemand is affected by the EM setup code and set 'inefficient'
> >>> flags for some OPPs. The EM is also present for cooling devices
> >>> and can work w/o EAS and schedutil, w/ just ondemand governor.
> >>>
> >>> Because EM marks the OPPs kind of 'globally' as inefficient, then
> >>> they become CPUFREQ_INEFFICIENT_FREQ entries in the CPUfreq fwk.
> >>> In the EM code we have:
> >>> cpufreq_table_set_inefficient(policy, table[i].frequency);
> >>
> >> So maybe this is the one that needs to be fixed?  What about simply
> >> skipping boost frequencies in it?
> >>
> >>> Then ondemand check for CPUFREQ_RELATION_HE will skip them and
> >>> pass to __cpufreq_driver_target() with that flags as well.
> >>
> >> Thanks for explaining and all of that needs to be said in the patch
> >> changelog.
> >>
> >>>>
> >>>> Second, why is the issue regarded as a defect in the code and not in
> >>>> the energy model?  Arguably, boost frequencies should be more costly
> >>>> than the non-boost ones.  At least the idea behind the boost is maki=
ng
> >>>> higher-cost OPPs temporarily available.  If they are sustainable,
> >>>> treating them as boost OPPs is rather pointless.
> >>>
> >>> IMHO it was a bug in the commit mentioned in this patch fix tag.
> >>> It is affecting more than just EAS or EM, since the EM is working wit=
h
> >>> all generic code and all cpufreq governors.
> >>
> >> To be precise, the EM initialization may affect cpufreq in general
> >> because inefficient frequencies are used for CPU cooling.  Fair
> >> enough, but I'm not talking about this.
> >>
> >> I'm talking about a reason for giving boost frequencies lower or equal
> >> cost relative to non-boost frequencies in the energy model because
> >> this doesn't make sense to me TBH.
> >>
> >> And I get that such energy models were there before the commit in
> >> question and now they are not working properly, but IMO they are
> >> broken, not that commit.
> >>
> >>>>
> >>>> TBH, I'm too comfortable with looking at cpufreq frequency from with=
in
> >>>> the EM code.  If that needs to be done, something is amiss at the
> >>>> design level.
> >>>
> >>> I think this edge case is special, as I described above.
> >>>
> >>> I'm happy to hear your view on this EM influence to some global
> >>> setting in cpufreq. Maybe it was too far to establish this
> >>> 'inefficiency' flags in there for many usage?
> >>
> >> There's nothing wrong with using the information from the energy
> >> model, when available, to amend cpufreq, but the patch goes the other
> >> way around: It tries to amend the energy model with information taken
> >> from cpufreq (in order to avoid making mistakes later when amending
> >> cpufreq with the energy model information).
> >>
> >> I think that cpufreq should simply refuse to set
> >> CPUFREQ_INEFFICIENT_FREQ for boost frequencies.  Wouldn't that work?
> >
> > I see your point now, about the direction. Yes, you're right.
> >
> > Since we are taking the information about 'boost' from the
> > cpufreq, then refusing to set OPPs inefficient in the first
> > place makes more sense.
> >
> >
>
> I also agree this should be fixed in cpufreq rather than by feeding
> cpufreq information into the EM. However, refusing
> CPUFREQ_INEFFICIENT_FREQ for boost frequencies seems not help the
> example in the changelog, because the frequency marked as inefficient
> there is 4.0 GHz, which is not a boost one. The problem is not specific
> to boost either: with 3.9 GHz, 4.0 GHz, 4.1 GHz and a 4.2 GHz boost OPP
> at costs C - d, C, C and C + d, 4.0 GHz is rightly inefficient, but if
> policy->max is capped at 4.0 GHz by scaling_max_freq, thermal or QoS,
> RELATION_HE for 4.0 GHz still resolves to 3.9 GHz. I think the lookup
> should not skip an inefficient frequency when the next efficient
> frequency above it is beyond the max limit, which can be done in
> cpufreq_frequency_table_target() without touching the EM or looking at
> boost flags.

Good point.
