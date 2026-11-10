Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794325293;
	b=fZLTeG+NGLzivHsdSW4fpg6h8DV1bO7Ix/NJHVvnbe+ONBW1oVzPtIk7Ke0z0nOr8zx0
	 lFVBgmsOpq50JWx6AKpLhLUt8yg/VOVCj3XeLsrQcIDfU7+gRngl/VFQR8M/3NzmahoSi
	 s+hF0K9lhyP3Yma4bYuaa+qJgC/znJV2LZA173wjDea3N/bIugBqfHVDYE7t1nuaMvth7
	 EYsVGmRc0GzTVgmtYySYb+gZOO7BUyZHs4g3FDjGeYeMvN0ORi/NHRAtkHXLC9EzqZe5E
	 J91Jgt/mXQ7eOhXj27Gvl8BU/5Wg8+tDYXs1MWwnYY5EByBeAEnr3ipKh/jjb/bToAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=sDaOEtmUA9SW2kk5s6sMwAYSmfuUpK+42EoUsqnGhNE=;
	b=ByJao3gWvgtuS9vEbmOaRxaES52DFjh9SASBJUiiCk4O77shH+OOMJugPQYP09pDm9LW
	 EEFocFbYwC6TYELMTg9K+5QHZMnUFFEk2bONoNHLUahcbN3wAgrgYm7A0g//O2NGSPfpf
	 dFLFgy3dcpCoZu/FRUVU73wTKsDn1G+hHCp1wcEvaqrhXBFyzikrKrbT5DM77pSfpUKcX
	 joFh7uxICgPd/rYxdmPEfxlS6Cp9i4D49TLmCqEfq7kE0EPUCJg4edM/vXTDEKrlodXFB
	 t/dM9HGpwz4KxFxKmPEQwFP2ZG/XwN5eEuVdmD4PNlBC99+K4YQTCJmsuCGxBAnfL8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hTTQLVhJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C597A60A3801
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C597A60A3801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hTTQLVhJ
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b56c428212so2917992a12.2
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 07:41:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794325291; cv=none;
        d=google.com; s=arc-20260327;
        b=Om3cBFS73tg7qHmayuqWUuOt5SM0MdBSKuxULzBqMtC9wmeMrK/4gFBVEfzhZ/FlPe
         K/LdWp/tL5hbtS44tjBrdo8dOLEVtxj0ksrHuVcfFwaqPpAVscjcS/xY7M/tnMSjEhp2
         yEFn27jLkNWM0JAa+tStzsbix7pCqBL6Wfh8/yS1hDT+ZUES83st/xuVYGVUQqsTkC76
         vJMmH43g7a9m2vBHab0TBr83itbO7Rgz5m2gAvNJD4x4SfN4u4Am5rDV6GE8oXYsmkuF
         jhC8ps3KFb2+gtORDrcxy+qLQwUf6xIqzGXKWA96Xp+WObWgmi/NnXvnxIGc3ctYO894
         yTvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sDaOEtmUA9SW2kk5s6sMwAYSmfuUpK+42EoUsqnGhNE=;
        fh=a3UD+BIoQvYDhcpihvLZI5xHdB6cT8fVj6vKTy+WTz8=;
        b=Rr/30dLi7LBe4x2DMeePSM6h+w3cWlsyiHh+OXBTKFDWiVPA7XU/3A+lX/TdSUGvOu
         NW8YoupBkTd1mxtzzYhpTTvWZc2fg8PWfgwFT+uPy2ECRL4GqwP1NxjoHEljvM8rti+4
         SWt/adyyScMVYZfx4Z+c9UGmKwqzqAiHUjMeyAfbGbTaXY+xGvjhpRpiS3rLmeMiZ6W5
         +oKmsqkCSC8gq0uC2lrZwsVpoRHuLNPTIueMUhQdzjDtUFMAEU2EKxPRTeAiZpL+x+gl
         VpkXZ4K51fk2HXcrEK7BhN2D0I4xrUSX3tEg3Cie+slULZlG/De6GOOaE74MlOirJGgC
         itUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794325291; x=1794930091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sDaOEtmUA9SW2kk5s6sMwAYSmfuUpK+42EoUsqnGhNE=;
        b=hTTQLVhJqWxpXgoJAd/yRKVKC3xKgQ62c0jgMpgh69adQHuT6sHFxZ+7FlabF0pqC4
         gkWzno+ZRY94vu4dKTeinaAqjO6gxI9jD2GRmOt3yYgYID6Yiz7WG6G/Pjf+naCLX1o2
         eK7X/m1Vv9RN5XfgYnbdYjpjkUXD1IircUh1zCwLKlEZzrj/D0hG/NYQwcTkFWNj9vu5
         LTYYDgFwVk4KZNhexasA+6B7PUtRA6hFm6g4csmIf0d2QanT29wMgSTWQKk0fVafzcEl
         IJN5jDXxs8k8bGjyDNxniJiUHVUBhicDOEfVfkGjF0NdoXwb7OcDBR/jspVdtcniJeqr
         ektQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794325291; x=1794930091;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sDaOEtmUA9SW2kk5s6sMwAYSmfuUpK+42EoUsqnGhNE=;
        b=LHBshd51M30aTU7iy8wKjsr9SZ195R9SqyGuCyz+SNcdRlQgPjbf1tsLML8wPmaCJJ
         6BJp1O9CYijYp5bNxNAYlBtjjOW8In2rFJCPHsqPu89uLg2wvRcQ5VCl4gozwBzObAV5
         euj1KIIKaxR2CWqIwv0Aapy5zucVPKxIO5WyLMdaNiN38soxB7U5M0pnbHF6+LLB2EcC
         4HkoC6Vl7l/IqEVn9xllJr1SjA1T8iv0t3jiCjw+MAe3gvGyyh3V3izXzbjOaSU2FsSo
         a8QqwHrPkKQn5a2I6CNur5rdHuCg7tN/LmwqIAiw6ja1+SpbMEoUSYxNK2X629hcfgyI
         V53A==
X-Gm-Message-State: APuU4Z8ZTSRzM1r7D1nQP5Ba/U4fKH0HeORnVKGlTmx/jdBNW3/atcLY
	RBTgQTqVmPWx2gqOt9PHrdsNRdLMLDGe6kJXSL6/76Pe67/7ZniT4AMzg3iynBUpoKfZKP2RU1L
	3n0rAE7kcOd4Aa99Lv100BdRDGePXiBU=
X-Gm-Gg: AYBFou2yOFArH9DH8N8OlcBKxe6bgSoSTnFanHPeJWvBdoHF5lrJyjOBIffVDn/Jwg9
	gl/XKdJ/YhaXHvwdaEACU+OLk4nt5QzzsTenRbl4eKCq+pEhOnzhXxk8KNUEKrqeGgrL5Qjo32t
	ihkWhDvUhNC1hstFTJv2EVszQrzeueIMKJuyuiNB3nifa3S4FueXM+BasPwH/oS6FUUR4vq8vqz
	OtcC6kgtNaimSe6me2LE6qo08EPntAx8rOyuERmxImdDgIeKwNcWLv6t3ftRJ5FtQfDE+B8/Nrn
	nA8eSwH/cOPFuzj/KHKXjcvMBUU5v8tLdwZ7Zha02/mDPeLROC8TOAeQGRu+z3AWlNjqsz+Q6eq
	nb/rAHv+WW0EyODmX1hGm7HGlBYrbMKIenI3jf/wuzluMn2flzB3KYJQmYgTSM1i0IqieuQ==
X-Received: by 2002:a17:907:5cc:b0:c40:231:6ea1 with SMTP id
 a640c23a62f3a-c504959d8afmr262842166b.43.1794325290979; Tue, 10 Nov 2026
 07:41:30 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107052836-failed-6.6-669bb5af15d4@kernel.org>
 <20261110032904.180619-1-sashal@kernel.org> <CAOQ4uxi7xkQiYtjQNuso0MC6KGGpwGbd+xST5NQ_aYOtaoAixg@mail.gmail.com>
 <20261110152402.2141028-2-sashal@kernel.org>
In-Reply-To: <20261110152402.2141028-2-sashal@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 10 Nov 2026 16:41:19 +0100
X-Gm-Features: AclHuK9dEoBHEXsoXwjPKzfLikFNIN-y-Skm3C5Y5GMEwxg6s49WaOu112dznV8
Message-ID: <CAOQ4uxhZL=uKo2xENubKOtpfz+O0JDxC_qxZYg541OJO1nCgkw@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] fs: make sure to call fsnotify_inoderemove() only
 once when inode is dead
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Daehyeon Ko <4ncienth@gmail.com>, Jan Kara <jack@suse.cz>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 4:24=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> On Tue, Nov 10, 2026 at 09:10:17AM +0100, Amir Goldstein wrote:
> > Please drop this patch from all stable kernels or apply only together
> > with the followup fix.
>
> For 7.3, 6.18 and 6.12 the backport tooling picked a522dd871024 together =
with
> 669bb5af15d4. Both were added to those queues in the same commit, a522dd8=
71024
> sits after 669bb5af15d4 in each series, and both are in the current 7.3.4=
-rc1,
> 6.18.63-rc1 and 6.12.117-rc1.
>
> The 6.6.y backport you replied to was a manual one after the patch failed=
 to
> apply.

OK so the problem was a missing upstream check in the manual apply process,
which is what I was trying to point out.

> a522dd871024 won't apply to it as-is, so I'm holding the 6.6.y backport
> until there is a matching backport of a522dd871024.

FWIW IMO it is not so important to invest in this specific backport.

Thanks,
Amir.
