Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B959F534466
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220791; cv=pass; b=Dh0eyzTqlx9PWhjuK5mVil+6p+6zXgFM7N6cPWMESLBaKByGQMymqOJdHkQKP5o4astozXwLhDKlbY7mybVj+HKjVcEBZJ9HoC+yDksdUgX01h8m3gN4MsKTkAdbvrigicaLA40DdR1mxujG0Vym1fTYWrHbE0fpWLxQQTMWZfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220791; c=relaxed/simple;
	bh=Iyy/EbW0PV9CgJFXeNSzqijmw9jKbQl0yvOdKn8dVN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOrZ2jBszJMjSy2Z3ghovZuSoyBF/cPIMlgKaFAnwz2Q4+GiL9B6FRH8FlfWXzv2vlCKFvL/YvGj2sGeQAAEG6OsGp4lWYcwxmaVhAVrFP9dL+DTbDyMgKyp3wlsR3n7t7otX87VLWld6Y0Krfl5Dkbw+PDYG6C++o62ZjDCnMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gE8JLIr7; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gE8JLIr7"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso1387990a12.3
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 10:19:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791220789; cv=none;
        d=google.com; s=arc-20260327;
        b=EKipDAtXZhVfmbsFcR7ucRmbmYN+DY6KGlUaIFh9vce4Y++CoiF7Xc9n6lkKrApLzE
         UcJJzWDa91QAe9qrJEToc6dyNNXKeHXXsk0SmHKmSEsR0KnCmtiqe496hsPha0wHSrUT
         NPk7gwbGuiAe0yeE0z72m9ZiKJkTHwLH1M1MxoNLCUOkaJvKoZ2NGWq12beMWmUQC4Mt
         bWAzLHzftPnv/u/iHw981F6QLQOdWBvt9WRSurity6dFuRU+BlTXrIzauWAjAJ9OkHSe
         VZweEyx6p9m8gfSZaD29pv/2yd+rYTA+VNUy8t1UybzTwYL4uKIh98BBe9LDVXDvAoah
         Y6ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kZaUwiZFto6aopJ87je3gAd8sYajiTqXcqFYb3kLz6E=;
        fh=U7Y97keqYPqWKxjivEhBOup+sYYU8JzN7iDJTTC0fqE=;
        b=bVeX5kp79uI983K1oo4o1cdfU/2lEP1M0p+kpGAAWvYmpOJaH02QkEREj1GaMCI0iK
         LUeCycIFkc6ZrFU+dWO+yvsTsQb11koOYOPR93QTECPZ2R8K4pHd9Z8b4I6JZA4ldgNi
         U9uhITkSUV05fNGT2Hd4YAlPeBGiQA2x5Arf4TrWdl24MlXw0O4Y5a3DcjOW375euujg
         1aHfcGQbDMjN5lxgnVfDPC0+xURbfS0I0AHj8qhkPdjAaX5TZWBFymIzaay2gvnSzHXc
         2x7Snqi/0PLaX66fvmklmXCqattjHitE38wZpWyjndkmrVKnm7zAqTVzE7SpZDrFHU/U
         63nQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791220789; x=1791825589; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kZaUwiZFto6aopJ87je3gAd8sYajiTqXcqFYb3kLz6E=;
        b=gE8JLIr7W6DAIA2P/MDRVo2hmbxwnbtXbOE3gq2W5rAmpUVaJBoVaVt94axWAYNIrw
         x90UBYGBiEorg40G5/vkF3/Ui2+UEFjI5rsIlrBBcPFU/DCVKvLb3lCXf0FjRZbutzA4
         Rnv8+MKrtnkziCBFsmFRkAnq/FrDGrr4d7bxmnuGfATx6pj076+7qVqdw56HcC16t2WB
         I+eNJr3ikBf5QaXFPSxcTjFSKfjeu8ks1VVeut3gYUjnwVFgSUrV0rI18/ifY2rLt/MK
         MrZpuQpB85gJJdBs50UXgW0rOj3j78mzHK5jNGxKDgUDroqFwfN+RLAi+Tg/tb4mtDeU
         oM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791220789; x=1791825589;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kZaUwiZFto6aopJ87je3gAd8sYajiTqXcqFYb3kLz6E=;
        b=EkFnjZuK98ecclkNj8/C9Z5NjHt2QnVsfU7ThUCBQtP0nEzl50rtZofR2YQXFRQDZr
         5rB6tNFpLzMSqdibiS0aijVoD/vcDZqhGP85fuymtARUuYZ1G71vZUJNjA5PBFMbQvPJ
         nMkwXovOlvw4ckKvq77eCxhTeyNhHOC6cd9dQBNlbjTt+28GifOwMLxTsu6ZQftNMuD5
         VUbivJRsWKl6LpsXLY5kWuMDU1EGkfRXP9e4mJKbb/gb11Lh2NiudNdbNZ3IZZp8DJP4
         yv6JECM0llzG73PjvtM5z3oH9F9H45VHnNRwTMdoq1dFkPPjX2yHnhOOiC8nfEvXDeoZ
         +A2g==
X-Forwarded-Encrypted: i=1; AKwUvBzL+NW/iKPprBGcpTdYw+/+tuzcgeQJdlFi/fgVEx8vMu0Coy0nVPwvFsPnPiUeJNs98+8HjzY=@vger.kernel.org
X-Gm-Message-State: AFuF++kY4Zx5IliFpIE0IKql/bLcqXSifzk4/x21HkOaKcmPoUC+JA/j
	ePTJEWs3f8+lBjb9wwgBCEA9gmav2DRCAfANQM7lAIUnn5tvmzNmUsOTESXCqYWk8L+aYBpK2XJ
	z6WOGdmPVpSUlEgg8CLZdRN3SlANwh0k=
X-Gm-Gg: AYBFou0aq77VuPXMkVfwK4KWCrI5Snf64lPI/mrBrmHaH5oL17n1KXSIwPhv0wG9uJY
	j+YQoyBh2HJaETyMOfi+xAVvhSyn7xhWzUg95nAqhWhbcsc+4x+7KXithvwLLrkMzsRK39sj+h8
	ItHTpAmUcK9pdZuCQeVA3C2c0xqfInSIL9hz+z5/xrURU4W5gF60sqIUPnWwROYJJiyqelB2Aij
	uGA7K29x8DsJQ9P+pqV6RsZVA6t5lMTTtmpCpMl52ecpEYrVmNn5TvVsJ/spLls9qRUfwty7g0x
	4Sw2uwXBEVTDEPVXQQvB9LaxBSv476kZJXDdGr9CE4J81MI7D6/aXA7SCw5HpKd44typUkOYbLI
	TQFyIGp2n5NyfcoErXdVjU/TvsqfZJO3bsgIt/DgSnpPTo7X3Nb3tUmQ=
X-Received: by 2002:a05:6a20:394a:b0:3dd:a197:edfb with SMTP id
 adf61e73a8af0-3e0d6cbdc69mr7529764637.74.1791220789033; Mon, 05 Oct 2026
 10:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930044611.204739-1-benquike@gmail.com> <20261005170632.GB83879@horms.kernel.org>
In-Reply-To: <20261005170632.GB83879@horms.kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 5 Oct 2026 13:19:37 -0400
X-Gm-Features: AclHuK-lyDkgT7D3dyZG9byu4tcMRkf70JRI3r14isoIqeQu9dgZ6L1lP-o_t_Y
Message-ID: <CADvbK_eAWQbGs7EUogG3kZDgpX_9bzrR-okU_6cAobcyp_SbtQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] sctp: copy zeroed stats to user in
 sctp_getsockopt_pr_streamstatus() when !streamoute
To: Simon Horman <horms@kernel.org>
Cc: Hui Peng <benquike@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vlad Yasevich <vyasevich@gmail.com>, Neil Horman <nhorman@tuxdriver.com>, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 1:06=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Wed, Sep 30, 2026 at 04:46:11AM +0000, Hui Peng wrote:
> > When an SCTP stream output extension structure (streamoute) has not yet
> > been allocated, sctp_getsockopt_pr_streamstatus() sets the local stack
> > variables params.sprstat_abandoned_unsent =3D 0 and
> > params.sprstat_abandoned_sent =3D 0, but then immediately jumps to 'out=
:',
> > bypassing copy_to_user(). As a result, when an uninitialized user buffe=
r
> > is passed to getsockopt(SCTP_PR_STREAM_STATUS), the kernel returns
> > success (0) without copying the zeroed stats back to user space, leavin=
g
> > uninitialized data in the user buffer.
> >
> > Refactor the !streamoute check into an if-else chain so that when
> > streamoute is NULL, params is zeroed and falls through to copy_to_user(=
),
> > copying the zeroed stats to user space and setting retval =3D 0 once be=
fore
> > returning.
> >
> > Tested in QEMU against Linux 7.3.0-rc3 using an uninitialized
> > sctp_prstatus user struct passed to getsockopt(SCTP_PR_STREAM_STATUS) o=
n a
> > freshly created stream: on the unfixed kernel the user struct contains
> > uninitialized stack garbage; whereas with this fix applied, getsockopt(=
)
> > copies zeroed stats into user space and returns 0.
> >
> > Fixes: 28b7eab0f910 ("sctp: add SCTP_PR_STREAM_STATUS getsockopt")
>
> The hash cited above does not seem to exist.
> I suggest that the appropriate fixes tag is as you had for v1:
>
> Fixes: 28b7eab0f910 ("sctp: add SCTP_PR_STREAM_STATUS getsockopt")
>
> Also, the patch should probably be targeted at net, again as you had for =
v1.
> I realised that Paolo suggested net-next, without a Fixes tag. But I
> believe the premise of that suggestion was that he felt this was not a bu=
g fix.
> However, Xin responded stating he thought it was, and I expect that carri=
es,
> especially when combined with the updated patch description you have
> supplied in v2.
>
> Please treat the above as FYI at this point.
> I do not expect a repost is required at this time.
>
Thanks Simon,

Yes, the fixes tag should be the one in v1:

Fixes: f952be79cebd ("sctp: introduce struct sctp_stream_out_ext")

> > Cc: stable@vger.kernel.org
> > Reviewed-by: Xin Long <lucien.xin@gmail.com>
> > Assisted-by: LLM
> > Signed-off-by: Hui Peng <benquike@gmail.com>
> > ---
> > Changes in v2:
> > - Re-target subject tag to [PATCH net-next v2].
> > - Remove redundant retval =3D 0 assignment in !streamoute block and fal=
l
> >   through to copy_to_user() as suggested by Paolo Abeni and Xin Long.
>
> ...
