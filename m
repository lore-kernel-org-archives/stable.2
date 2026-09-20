Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51B9470425
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789924048; cv=none; b=WRUvEHaLBfZF3M9vYSlhK1f2CWeKlaPhJPOKTmNZFEjm+k4nnl8Gm3y1nWgdo+xnM3atgoR06r10b3aTLoCEtvw74gn32koKujQ1xWjmeXhawEv5/fXwBG8ce24vs7pR6HgON2ini/VRJrf5XRUJQCRBiQUt7j0KKbS3jjfdWH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789924048; c=relaxed/simple;
	bh=MoNEDcWdGlP7UcyCq8wXBRR56spV4f4PPUO0eUL2OZE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ctVGSCGo5Uim86XuucXYv0lN8Dwen61IGDEMSz/F+oyh9kLnzz3YPtH47Ab7+ssTlOSK6zYq2VzWqQklTN9I7dVgec3KywCZLWZ8v1NYrpPYEhQ/ry9hnpCxaF9GNNkGzkfKCkyOl/lHE94pdne3hu5DMv255T/PAN39Z2EPm48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxbYk8Rs; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxbYk8Rs"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-3a02902dce2so524264a91.1
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 10:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789924046; x=1790528846; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+5OXkFTl19euajO1h3c9jy1KZ0WClYAUhVVTBNP2yF4=;
        b=YxbYk8RstqpNoQLxSV22rHj2WD/9cVINT6vI6PCf3oDmUoVKamqBQMaITd6AMf88zW
         +WmYeNe6xhJyLXwgGa6owSWwffxx4malxAJX6EA0iQyCCoQk0f12JSMk4cygi1+vHALH
         ISbQsG/471I0i6Pyxu59MVm33urf6afCcopbGmfOwlZN1GPazdMyUSnUvQw6ob9EzVsU
         kqw87eLGW250yl3z0Z0Hl1idiuFfetYTFeiYJ1bXPP6iWQeyLvngAy8ag0xFPqVX2fXb
         Yb7oyGHZ5YMP6A4OIs3U3TsuiSYRS7TUs1lU955TL3Cob3eDECtyDjzqYXXfdApXH8Nw
         VVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789924046; x=1790528846;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+5OXkFTl19euajO1h3c9jy1KZ0WClYAUhVVTBNP2yF4=;
        b=e2iLknj82N6pWKC7BnzyTAlEQbjhGXo1j2SO9ksvzqblw36isn3KdaaaF/zzxw35Vp
         AkAIBc3SluAgX5fQEHKynC+d0iUMFQeXINT5FKPAdc5Cr1g6VkL3JQc5thUFlegmdxn6
         sLKtFUdCDhQ72plymSfR1eNbTy8fGc4WtBp75WmuJ4crnC5CgndSIN2dgQwvLuOVKM/+
         /trNlm6N/ldVRU80cv/KmyXdepRtcWQKGJIVykTurjV7oddeMoJUazsTemsvmyl6XefZ
         cBPQjilhbTSfeD7Rh5q/1rtk1aa1kKZ8KBM165/nYdTWi4byq0FmaPo5Ju9I1NADBrsF
         0luA==
X-Forwarded-Encrypted: i=1; AKwUvBx0KOSfdVin8tnz1ZWEHtQV33KiUI6nA7ZPnRaL2zq7PiRBpmYNzbS4D0EHdSqGpLl1g1Uz9s0=@vger.kernel.org
X-Gm-Message-State: AFuF++mWR4Fw5JaE2UjC/hrP/Lnx+udNoHPBPzl6cnZ8qTwKORywqwxB
	cPQOZUctMx3LgCJ5LkLt+TZUp61JV5aAJ/8KmnVLxEAa4lJSYEbK2xPt
X-Gm-Gg: AYBFou39MFRbw8NMkqSv/qVFyMHMHQOpuyVhABw+LJFGWzsIm2yTLDc6X6QCdI0Pebl
	JcpI97gjyWF8TPU7yy7pwHoG7hAUa3EGcN1Im/RjhE9HulCm8R4euokBdFGtjp5XRKOVK4B9tT3
	EC7CfE1l07x9r54LSMY9gRs3ciN3VI/YBLQ25kb7TqFS64LLV6cUOaTuysnmZUkTMwJToGZIg6F
	WBQoa3S2oFFFvkZnzxmRbBuouo3JGRiTpF3cDwawYMFad1hUv/aZIi/g/svzCdKJXx5dHGISbwa
	LCxNt9eWZOqRaRnaoz+ihs/ahrha0GVcPZbH3LV/KP3jdVZlq9Ko+vE5YgHQ63vdl7sTPseMWvr
	XecZ1AuUtyrHTPslS2LKQfSF9hqp8U9YxH40UTrJBCJrdzO0WBsChcGztAtRpmIIpaBw3LedVns
	dWzz7mMQyWjuOJIgTyaC0jqUriwk1cg/sY2doqTpXc4xxhOeGJ1LyGPsy73TkFHi0H7ZTVEuugd
	jYdLYOWCKGU87rYOpYwRr9Gn5nkRHgwK5L1WKeyrksuYiPRjlTdNlw1RRnGuWmUMjgWyQVMU0Nn
	8JOD
X-Received: by 2002:a17:90b:2b43:b0:39e:1ff0:331b with SMTP id 98e67ed59e1d1-39e54d37ad0mr12487465a91.2.1789924045869;
        Sun, 20 Sep 2026 10:07:25 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a02900f84fsm8679011a91.2.2026.09.20.10.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2026 10:07:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 20 Sep 2026 17:07:24 +0000
Message-Id: <DLKB4AJ21W5Y.VSMC8ZB4EK9@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Peter
 Oskolkov" <posk@google.com>, "Xiang Mei" <xmei5@asu.edu>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] bpf: propagate cb_access from freplace programs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Weiming Shi" <bestswngs@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>
X-Mailer: aerc 0.17.0
References: <20260920163211.795547-1-bestswngs@gmail.com>
 <20260920163211.795547-2-bestswngs@gmail.com>
In-Reply-To: <20260920163211.795547-2-bestswngs@gmail.com>

On Sun Sep 20, 2026 at 4:32 PM UTC, Weiming Shi wrote:
> =20
>  struct bpf_prog {
>  	u16			pages;		/* Number of allocated pages */
> +	bool			cb_access;	/* Is control block accessed? */
>  	u32			jited:1,	/* Is our filter JIT'ed? */
>  				jit_requested:1,/* archs need to JIT the prog */
>  				jit_required:1,	/* program strictly requires JIT compiler */
>  				gpl_compatible:1, /* Is filter GPL compatible? */
> -				cb_access:1,	/* Is control block accessed? */

No. keep the signle bit.
