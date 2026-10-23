Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792768008;
	b=KU+Ci99QPpQL8RkhKuytwXwAF+Ni1GB3xeyQpa98uP4RirAz0Qi260rDVGkAVN5e+OMw
	 0xPpaY37B2x64IYczbq2PUwtqGjec0LRjJ31rq1Sv0WTZBKdunHeZu1vsmlIHChhzP7h4
	 srNwiJye9ueR4vyxNPC6aeECkBm41KOAw3Qux4kmV6j5aXewREtVdM9Phe4kNMWEt7Ra3
	 amenKOutqp2lrcNSHEPA5cTPA4dY9Q1Y0D2Td4rpgC+pXMVfqM1v5DBTX6fZ2SyGCqY1k
	 4Ayx3PEGX2ZviSRaTx+ZZhluKpjrnCzjOAEHEQLbboYqrc0HbsfuvZ5PEb4cVXXMa9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zNW6XYlrtwS8sApdzcwbBz0IcIsSvhwmpXIKiapenBM=;
	b=TcMhx5fcwqBgXcV8QP/S5Aecgk5IjMpJ5adgtlcvPEpQXzRat7qvkyJ22CUXaFUcFkI3
	 haiGBb1ebHSkfaf/j6Mlau++OsXjXWsKnlhzBGih4HWK1Oi+veVwwJw9QPsjKz1c/6bqE
	 i1bjZ80Cs4UZc8Ds8qvs6UnOCSY7XrddepKfU663LPR4r3HDkJQKPqNMpUpKoxWvqZvUF
	 M6NgO53FCi4m70VajzZvZ3GiydtQQQyykk+IaxfgxpqY0rzPkmpk6O5GJ3cMhP9V3PObJ
	 +6hDjewGdryMZkxXQhLMO6mf3U+Z7YGr8rGT3WpuSxJdd93YSiALGku5cChxbVB0v8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KVJ9FXKu;
	arc=fail smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9602C606A31F
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 15:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9602C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KVJ9FXKu
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso9774a12.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:06:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792768006; cv=none;
        d=google.com; s=arc-20260327;
        b=jMnAYZWerKwAFDA8l5wEBIXbyOP6oEXo/l6ea5xKjP1AF97UKnSSauRytRnGY5/G+R
         pL+r03avDCdu7HSENUW/7a/uAVUPe+JLwhbGZtr5lVFaIFtJQEMSjtglZnz1OHEkRVIc
         +M9Pq88EFGM+mwiTa+KYjSZ8jmZiutjw9SrheF/bB1AxEMgL/QtNfTcJ3ey1kszVvDL2
         /0y64oTKAscLReRSyQ4FBlTonCBiJRhS0tCU7oN5nLB5oRgA4mniCloWziQfMn91VKaB
         Yo//RFIAw2J9+bsEpJ4veVWoHzhu6ohnYQrMVSsfWi1I7raj3xoj8JoTdlr1xxxH/9JJ
         vjBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zNW6XYlrtwS8sApdzcwbBz0IcIsSvhwmpXIKiapenBM=;
        fh=b+N+UpSU1wkEfG49drlOG4u99dV3P+7OeetL1p/AgIA=;
        b=kFntlTsyZxyksA7m04EnVG0r/I+e2NJUBiwFKn5gVVwdzJRH1w7Bk7e0Et+xx2N8GU
         YIR33XCMAHsa4jS9Go99VqoQC+NpsiXRt7iedwGHo7vmorOG31JXVL0wrHkKYYjlJkAW
         SgZJx4hOF1+cnEoJVRQnqS0fnui0GYorCkHaJn/I8M3OTgpnHFvX522cvEtQ5zcR74ie
         8APecHJC/PwBkLCAr92Bz1OFnUnGSwWyGR4wZhwmPQhtopvYl9C0GWzfVjR4WfdG5fEW
         Z9YZTEOREOT6A10TvlFLZCVavsjkbDdf7ez8sbjRPfNv/yMrPuoZe0e9N+RknTqLUXaq
         k6IA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792768006; x=1793372806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zNW6XYlrtwS8sApdzcwbBz0IcIsSvhwmpXIKiapenBM=;
        b=KVJ9FXKuxZw9511/Juyf4W9Ir2Z0uLB4exJreByU2W1txP0+Hq/3sBLO0/iYx2G7nK
         lyl6usjXdqPwD0cI1SmvOg4V1aylyH8Gh+SH8JlzdA/9/ZJZfnE06F3M1g+JlmTR6n4j
         ifn03DAI+dswyUbGsOHxei7RWVQsTJeoTJWvtHj0B57Nm6BkutYTrA5rS/hpTHxlOTVR
         BwRzz0ZKJjB4KnZ2a3ieSu2N60QZsTsTwgRfGKnOAHVttL08H/YlMmOgwo9r1nBjAcan
         XUM8S2YsyHtSYuB8sZ/a2+/N5QlVaB0Hi+kBiJqOIHYjVzMyIfU/ckwtLYk9Nz15a0V1
         l17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768006; x=1793372806;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zNW6XYlrtwS8sApdzcwbBz0IcIsSvhwmpXIKiapenBM=;
        b=zb/4PhAnVswgznO91PIk+IXWS8G2g4bArZN66YLqDmPVO4m1Bphtg+o34ksCLWynNs
         d7MKiMRCYJI8ga907JWMeUAGw82yUblJ7LCEcYnmEzOS2Y9Bz1r1scJcdeXnmkfc/6SW
         fptj/bV9EIeWJFnMl6NMBbRg+vRcAxfYcoV9f3dSdFza8+S1KyWelXar46Fbgnp7v/nj
         5kpkb1JGR8p759o4QHta3mAn27r6J1q5o0+huCbrkeuswLUTC+smWha4LPd+pHCY4iSb
         t7eOkc+GukFHOQOb0c6MD8Rgub/WaSwAH+eC8f17Zj9BVfWhFxmwAkgdN18zaoMtb+xh
         BJPA==
X-Forwarded-Encrypted: i=1; AKwUvBxz7XN5Jsdw3L042N0wwwht6EjII/T6WMSomhyGRBEw/mmTtvUL1EXuzN6bZME1p9LBi55AUcw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJg20qDmX94WmM8T6P3TPJpQp8H2BSoTN7FPkLUndLmikFDz3DE
	4YldBw/CTh/GO7LVQZW0ZhJO7WCqU6cstOqBDch586CYkPer0OSzVbZ5c62FKiTzQ1xf+unWJVD
	zf+k4FVra8BQQ9XnfjY1SAme4a+5WyH/uirP/PoBc
X-Gm-Gg: AYBFou0qMHZ+p7haoZl51y6eef/tLZ8dYoBsVvAd91cbtw4akQnDGCKC+2jCfQ6waK5
	l1aOKjcXCYtoG/2mMB7velj22SLPwMu1j3kaaRQOcF7g98EErp+3aNsn1AYcI6+4KryRkLT92Lx
	Q4UdiMSbfnlIbpCZLadjdVWHZatIgez5+FDxPqimyoHwquV+frWWfakGSQWNLGgUf1R6TJnHKe5
	e8Ik4AoYHOIgMv4x8u8UCoojPtPPa4eMFwQ4b70+wDKmBMIczzVKrGTEzPhqc3nF+Kmrd7SVuLr
	6lN/+0l5FgKa6tqDuUqoY8OxBjoav2murP+DeoxXuZvHW8yDzyu6qTvSp5/gplzwFoY3uucBDMV
	p93HjFTBakoqn3jJmUJbxNgsVfCsvsK+a2vtkKn+l6835/zIj5hlOXoD8VxZPp3BR4B19h400rD
	maXRWV+vxZZM7NzvnwG6cSXN8=
X-Received: by 2002:a05:6402:44d8:b0:6aa:babf:adeb with SMTP id
 4fb4d7f45d1cf-6b432d316bdmr68184a12.4.1792768005447; Fri, 23 Oct 2026
 08:06:45 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <tencent_31D2FFCCE76C50A695A1270151F825E90906@qq.com> <af2ec5b0-7c62-4c6e-a28d-33ed401020af@linux.dev>
In-Reply-To: <af2ec5b0-7c62-4c6e-a28d-33ed401020af@linux.dev>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 23 Oct 2026 11:06:22 -0400
X-Gm-Features: AclHuK-H_9kcDdlRg4oJIo1R46Cqrg9YXsq9lGWJiBUgtLV5WO5v6PEgZsMeA1Y
Message-ID: <CADVnQynhY17Romr6VvzAyq-9h1zQ8gd-+pfC+1qFtz8xRaqCYg@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: limit tcp_tso_rtt_log to a valid shift count
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Yingjie Wang <1075151112@qq.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kuniyu@google.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	rdunlap@infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 10:50=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
>
>
> On 10/23/26 10:40 PM, Yingjie Wang wrote:
> > tcp_tso_autosize() right-shifts the u32 returned by tcp_min_rtt() by
> > sysctl_tcp_tso_rtt_log. The sysctl uses proc_dou8vec_minmax() without
> > an upper bound, so it accepts values through 255. Values above 31 make
> > the shift undefined.
> >
> > A process with CAP_NET_ADMIN in the target network namespace can set th=
e
> > per-netns sysctl. With CONFIG_UBSAN_SHIFT=3Dy, setting it to 32 and sen=
ding
> > TCP data over loopback triggers:
> >
> >    UBSAN: shift-out-of-bounds in net/ipv4/tcp_output.c:2264:30
> >    shift exponent 32 is too large for 32-bit type 'unsigned int'
> >    Call Trace:
> >     __ubsan_handle_shift_out_of_bounds
> >     tcp_tso_segs
> >     tcp_write_xmit
> >     __tcp_push_pending_frames
> >     tcp_push
> >     tcp_sendmsg_locked
> >
> > Limit the sysctl to 31, the largest valid shift count for a u32, and
> > document the accepted range. Writes of larger values now fail with
> > -EINVAL.
> >
> > On a UBSAN/KASAN build of the net tree, values 0 and 31 remained
> > accepted, values 32 and 255 returned -EINVAL, and TCP traffic with the
> > valid boundary values produced no sanitizer diagnostics.
> >
> > Fixes: 65466904b015 ("tcp: adjust TSO packet sizes based on min_rtt")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yingjie Wang <1075151112@qq.com>
>
>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks!
neal
