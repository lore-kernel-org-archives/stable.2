Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792770928;
	b=mkvZuvpnNSTkGf8VU+FOjaEarjTwy67gAP2x6sU58U+fM3JgCpSbKPR3OBubM9F6vC4o
	 H30CU5gphfCC0mBxl7TKVDTrujBtKJ2ARHdfA11nLOxMce6vYed6MoNNYf05mTxTB+dSH
	 j2ipd1VgLmj8790hFUe7VyAqUSPk+r2/tcVRobf0X5y3k4fderP0Q0V6KeDqE72Im+lPZ
	 JnmJG8UQ901mh3qN/c/gkpgR0/ouF4JZNJlZI2sIYwe+grrcja9utZSlaPIC8gWE5O3Qg
	 Y0l2+uSW42VIsIb1vzF7O64YMNWcveUaMVcF1xcyXn+ps7WYeLl392ca7aO6pghNjeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770928;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=obYDQLkkHXiggm2S/jFGDF/Bvg5EgjJRLjpcUkuTCJI=;
	b=H6hFv3P8QqcXxcxMLjfyVAKaY0UtlSs8Pbr0X8GcE+VdyA4cp+tHUMhGngvumj8yw9Bm
	 1QGCZk5LojQkIylQFgERtEEV+vQL9UhWE1DHjcfJ69wCjylZI9WiZYFbwv4H2GdwBpSO0
	 F4xrAVUAt4QsAkozLH6v2Bxf7DO1YoLxXaavuRIz/XpQnlzW2kfi1ZnqC2y9Cqx8JX00B
	 WcfgZHr2VtBzXdCtlPRiKYoBrkJHoHYNUMLE8wVCyefOqMJZnnBW2yVkKg1x5D+4US7zo
	 s1i6Z2VCL3m5XbsaiJ6gK8ALlwD4TI8NZx7TMK/OoBl97v9Nr/BJsHvdL8Sj/ADLm0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AU76ctpS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD51606A31E
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AU76ctpS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688251F031E0
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 15:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792770927;
	bh=obYDQLkkHXiggm2S/jFGDF/Bvg5EgjJRLjpcUkuTCJI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AU76ctpS+cWgn4fHG70gLMmrsKI5n07WctHHaxtbOgD3IveSc4cpmGOUCyZkf5l3T
	 MNOT9tMBRaxpFSAEgX04bdQxmCjbrbrmf7AApk4iZe+PmMxyT+rOB1/zVPdf/XxD+e
	 sJz9jxZAa+mAORrzsEbyoOlNzGp3CCr5QJFgb8i7pJw7hZvMXzCJFzxq8+vC4KYMFn
	 1S4CmJz7SMCR8X/DquHqLcaUHDHVu0YhY5AcxxtZZm/Cnkbu2bCy0q2uJCMny0Enom
	 MvBHjJ2DV6PcEFzWXBMiAdQ2o4aureDuOyFdI2s1o3B6O9trxJZW3LQyV8VzKvg/8a
	 CD9UQWPHx6rZQ==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6dde81a6820so727655eaf.2
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:55:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByjdI37UyWPtD2pKEfjfjPX9dZKpaaqS+Rc5oz3OQugAGfl59J9t2KtxMVCcnDakRTzyXR/oqo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIpSIVWyx1USAeiL6g3lhO1OMkxeVxgzzSfgedOmQVfvowqsO5N
	usE/oEn8aKyHuiHgJVdQMMJv2NKkqC/o6bdrGyxp1hltTN/OfzLOCKJ9pkTw7wx7L12IxeZa8Mq
	/0KNj7j0ehK3nIGFdYXH5Ymz9AnThHXs=
X-Received: by 2002:a05:6820:f025:b0:70a:4973:e475 with SMTP id
 006d021491bc7-70b887ef9femr1819515eaf.9.1792770926558; Fri, 23 Oct 2026
 08:55:26 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <tencent_31D2FFCCE76C50A695A1270151F825E90906@qq.com>
 <af2ec5b0-7c62-4c6e-a28d-33ed401020af@linux.dev> <CADVnQynhY17Romr6VvzAyq-9h1zQ8gd-+pfC+1qFtz8xRaqCYg@mail.gmail.com>
In-Reply-To: <CADVnQynhY17Romr6VvzAyq-9h1zQ8gd-+pfC+1qFtz8xRaqCYg@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 23 Oct 2026 17:55:14 +0200
X-Gmail-Original-Message-ID: <CAL4WiipvuqdDerVR9AZ6H4kaPvoSEoe-2s1P4RWeB6FwCfbBxA@mail.gmail.com>
X-Gm-Features: AclHuK_AOyMxLdHlROqLvyZU8YQki78OcLExqwM0QO9VP0-Jx78XGF_CcLHcZd4
Message-ID: <CAL4WiipvuqdDerVR9AZ6H4kaPvoSEoe-2s1P4RWeB6FwCfbBxA@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: limit tcp_tso_rtt_log to a valid shift count
To: Neal Cardwell <ncardwell@google.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, Yingjie Wang <1075151112@qq.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kuniyu@google.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	rdunlap@infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 23 oct. 2026 =C3=A0 17:06, Neal Cardwell <ncardwell@google.com> a =
=C3=A9crit :
>
> On Fri, Oct 23, 2026 at 10:50=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux=
.dev> wrote:
> >
> >
> > On 10/23/26 10:40 PM, Yingjie Wang wrote:
> > > tcp_tso_autosize() right-shifts the u32 returned by tcp_min_rtt() by
> > > sysctl_tcp_tso_rtt_log. The sysctl uses proc_dou8vec_minmax() without
> > > an upper bound, so it accepts values through 255. Values above 31 mak=
e
> > > the shift undefined.
> > >
> > > A process with CAP_NET_ADMIN in the target network namespace can set =
the
> > > per-netns sysctl. With CONFIG_UBSAN_SHIFT=3Dy, setting it to 32 and s=
ending
> > > TCP data over loopback triggers:
> > >
> > >    UBSAN: shift-out-of-bounds in net/ipv4/tcp_output.c:2264:30
> > >    shift exponent 32 is too large for 32-bit type 'unsigned int'
> > >    Call Trace:
> > >     __ubsan_handle_shift_out_of_bounds
> > >     tcp_tso_segs
> > >     tcp_write_xmit
> > >     __tcp_push_pending_frames
> > >     tcp_push
> > >     tcp_sendmsg_locked
> > >
> > > Limit the sysctl to 31, the largest valid shift count for a u32, and
> > > document the accepted range. Writes of larger values now fail with
> > > -EINVAL.
> > >
> > > On a UBSAN/KASAN build of the net tree, values 0 and 31 remained
> > > accepted, values 32 and 255 returned -EINVAL, and TCP traffic with th=
e
> > > valid boundary values produced no sanitizer diagnostics.
> > >
> > > Fixes: 65466904b015 ("tcp: adjust TSO packet sizes based on min_rtt")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Yingjie Wang <1075151112@qq.com>
> >
> >
> > Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>
> Reviewed-by: Neal Cardwell <ncardwell@google.com>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
