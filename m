Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201920;
	b=GF6osu6x7X/jkE1wbcTt+nzIvfk4Yb2Ak8TXUOO3EyxkoC0XuycN7d8A2C/S46A+BwbX
	 Yo35JvdU2YGXqVBdM1tXsEV2DRubIyganfHcVr7T1O+IhL7FJvwKnruITKixvi4dngSzV
	 CQ0up+wMxOlCXsTpfvsL90pDwV/Q32iyInfVrMlROr8/zKw+37YCIPguijBOgmg5NU09Y
	 QBtMnh4vgO7raZn0hxkzUAKiYiL7E9zKAiffY6nNXHtieZo4vsgrbXjSAaOjEH0Y8ZGRc
	 h5B6y/43HNdtG4ljIe68ItysVyhKW8bkmXkuFIRlQN57vhz1TH8+AO4oOwj1dtDq51A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=MfI8h61e3YMKVrq2h3izbDkMZ/iPIC2DcSVnmxWaK38=;
	b=1DYI27RTHu/B2Wto5yJPN16G/vNAZThbUwob+aq8aMXnFRLX/hbgRuKXrwDJMzYiLzFR
	 S5Gu02SZrqffS37tH4cYTekrIYHNci+iLmGZqA41nAclNRQA72P1Kd0k8ZFX141Fz3M/S
	 o94QSnqlszA59zrOB2k4cx94zEHPoR3hxg9GTxaA8M9Kq+hjs88EWlaFKRzDk5Ssh/3kG
	 XvhYDyb2udoJaZrYugJbnswZ064wbqGgzSghzsihCNwx01bDNkit41jTx2h5x6rpAgQsV
	 THO1o8NyvtsMozax7Midxd2v2TFy1Yf0AV4WgMUol7QP6EhZvUDIFdCDp1N3kBX3zEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AS+HWRzV;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5954560A2639
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 19:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5954560A2639
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AS+HWRzV
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b4021b572dso932950a91.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795201910; x=1795806710; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MfI8h61e3YMKVrq2h3izbDkMZ/iPIC2DcSVnmxWaK38=;
        b=AS+HWRzV8TNC+o6UMnpbMf3MO+03DWGnm9XxWLlLJ5oNbpKebzojf0B/x2y0Lj0g9O
         vVxkrLDZz3SYkCkpS84UMY5Ln+nXfIFNl40EyDrREE5Nbir4Uqfq6y27HxdZvwxjil1A
         FS6UkJYPFtlGWPPNjiZDdtTg9gsbz4zvOAQKUzUG0KBAL1B/VMtfO7qY3pO1I0XRcy60
         7PfptsxDfy2IasrDsyObFTMl9LNTLnVGbcqWQOs+pDWB5ppVylqGxbo6Offesuxm2OM/
         BbJ0gu9GWwkchkCT/I1xaNtSLAd7F2oBcPUF30NJomnpcx0FW2aZDNJIhsbN3sNosX55
         FVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795201910; x=1795806710;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MfI8h61e3YMKVrq2h3izbDkMZ/iPIC2DcSVnmxWaK38=;
        b=PMMgJAX+WOIBiVPSAozNtevDSZspkDIHgqbVMk7Au88gpqzw/2ez64NpvPj2V1HJRE
         Fir2nhpk56Hqef2ig+61s77fV2Cq9+vmcRwCN8EJblb1729qoy8I8iYX15QG6IQCcpO3
         OuT8rbhBjGmplZOnsqfCkJVn2HNuZZuDurnAeGHj/QInzRfyrCbC6tX5o1gia2sFUmoW
         JIlp+/GRN46j5vpAJS+aDy9rtL4IvIzDb7QmFh3JmO0VneTM9cZQmYgscShng5LSne8X
         p0YegZg76NfZJ7kSn66lPZ8pd1eIsob36KltxUCIQ+OrK2anqW+93ZTF9fRkHY+wcBXq
         zitg==
X-Forwarded-Encrypted: i=1; AL+hErHMjjSRoNbnUp/Gnsa7lF3IPT6a42/fzHGF7WackRTgtZY/CRZwi+8m9uudz34GwNhec5ZFukY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nyL+S4AT39z3+7kkm2agVl/wWsRWOHyV1mQmvBkjhRRBhypQK
	8zNql5Vla2bQVsrclTj63jWJKn0uhbU2BFDb/RydSmr0rIbDTTHUcbi0qrdNbw==
X-Gm-Gg: AZFdTZetjJ5Sx8DqulzC8sLDfshlwNV72zLBG+GqGtDifOchtkixwSPzeURGI3JFXrq
	rq/LAzxEIEOdhkhzXrNp1UQyzyYq79wds6HNxLUNcszt7iG6aPlqbIWAEU0EqzNRf0xen9B6wQ0
	xV0F8JaXK/JQlbKuF+LKjG6e/kHz1eYhYbkAKluxoofLvJmiX6ARsedHyRFt2L/lHij3Mybk16a
	xW2pZLhBoRe0t+QhMpmJk9I+HiPw6RiwidAqo1lz/RaLB+Kl47Y+z6MLAcwA+ZXx710mX16tGUp
	HxLn6sQavLuoqqbMQvkl1iNR3mKfmdTqJ5abihC4yTVtozBH9e1s1iy8hLiMGRNQhsbxX4X8kvs
	iZkKxKzhOuoGpaV4TKwKGGRVPB7EeMEPzNMow4jo9YuRkb1mM50BVmqFmvu4LxVgap9++qqvyEE
	VN7kwo+/itofkQWqeSbURswI1pUXB76n6Iq8VQv8Tr1lrGB0n5y36idZOl8S8YvLyaBVj2WTVwV
	+M8qwF4f+WQ2ob95dVTqIJhlVREUjbrppnzpQPwGM/ypnkj2bNONMSTh50HFNGBBEH7ASTQoxO3
	vFAz3Espilo0ekpi4M3UIOcKiihfCv1z8UobwIOHGKzy9ErHoer3OnhgM53glr1+2U7P+WcNcwd
	KoWj0OqriVFug8y+4GOQERd66RQYcXONRVg==
X-Received: by 2002:a17:90b:39a7:b0:3ab:a3ee:33ad with SMTP id 98e67ed59e1d1-3b41c8d95f0mr3666281a91.22.1795201909486;
        Fri, 20 Nov 2026 11:11:49 -0800 (PST)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d639fdsm8522514a91.10.2026.11.20.11.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 11:11:49 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Nov 2026 19:11:48 +0000
Message-Id: <DN09YRKU82D1.1QHV2CIFW2C6H@gmail.com>
Cc: "Steffen Klassert" <steffen.klassert@secunet.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Willem de Bruijn" <willemb@google.com>,
 "Simon Horman" <horms@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Martin KaFai Lau" <martin.lau@kernel.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Eyal Birger" <eyal.birger@gmail.com>,
 <ipsec@lists.linux.dev>, <bpf@vger.kernel.org>, <stable@vger.kernel.org>,
 "Jiri Pirko" <jiri@resnulli.us>, "Victor Nogueira" <victor@mojatatu.com>
Subject: Re: [PATCH net] net: xfrm: interface: restore dst_orig on every
 xfrm interface
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jamal Hadi Salim" <jhs@mojatatu.com>, <netdev@vger.kernel.org>
In-Reply-To: <CORE-5IQX.v1.r0.20261120050801-1@mojatatu.com>
References: <CORE-5IQX.v1.r0.20261120050801-1@mojatatu.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, Nov 20, 2026 at 06:08 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> with skb_dst_drop() before the route is installed. The helper allocates a
> metadata dst per skb instead of a per-cpu one, so the route it records
> belongs to that skb and is released with it; the per-cpu allocation is no
> longer used and goes away.

kmalloc per packet should be ok here. xfrm_bundle_create() allocates a dst
per packet already.
It also fixes the route leak, the double put and the if_id mixup
that Hanxiang reported on Oct 29.

Reported-by: Hanxiang Xu <xuhx@hust.edu.cn>
Closes: https://lore.kernel.org/bpf/48129353.1960c.1a1859496bc.Coremail.xuhx@hust.edu.cn/
Acked-by: Alexei Starovoitov <ast@kernel.org>
