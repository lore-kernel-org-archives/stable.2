Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795098265;
	b=iuIfBaaSLtDRI0hZK/s8NNJZ14+vrK6MWYAaTPzNEOsqPecSxd8PQbksH+0aszmID958
	 2vahKffIYMfCwyenIUU+Ca6WmSSMIHVX2C/eF50sPhsqQ5AI3Mm6hxDoC6XKD/5GtbiWS
	 CGJIH92bqDPZ7+gE6u6xwMfrpS3iZSyUxhqwpgdT41lcd4Wk67RKN7hB6v99UGlbBfCPE
	 IVAHMx6/ngcSr1kmeg8EyXI6yVZsvF/CzNqEqXfUTTf+0JicgHc8E7s9MTzS2UN53zN7Y
	 boX0ZY5z15CeByAmABjw7FWq/xGllMo2S36UcGElW5V1SUA8HQDkxBPgOCTN85jhmjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098265;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=o5n51x59sxtfs0bspBXfBjL3tD09TlDgiTXE1CgF8cY=;
	b=nlCWGLMpvOmo3xbwOXUtc9to7GxVgp7Bz4pJtRL52i5D0WIcZiQR4OQ3iqMq0Bj90F6W
	 P2eKo13hR8F1nN66KatpO1cS3YAzaLa24Lg3WVny1KLfSieTnu0a4BbTn/QDnSgIwQdYV
	 I/F9P/7kxJFKkS4oh/oMc/jcFyicB3YyJu7+3GCXqtLvrP2LvEs6sjaB5zdRbnUYNEpiq
	 prbimavXdJpeMSK+Ti4noThO1wDb9GZnyk0wh/vsRl0/pq8NwGlC1+0nVgjk9oBkLjgl0
	 /Rb0+bxn7dPQf5ZOu9KsaIJnW4Y1qDbV8yn64aiLtVCdldGgNFA1Rs6UO50XAmfR+3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=NATJwU+x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DAE606A320
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 14:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4DAE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=NATJwU+x
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-71ae5389c00so1579557eaf.2
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 06:24:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795098263; cv=none;
        d=google.com; s=arc-20260327;
        b=TK64K4mzxObfRtfUQlO3tWmpQ+Lg0o3B2qVQgOiDw4ZGBRr7IwqmdT9Hw1qHL54eTo
         WQy+D59k11LKkPz1P53cFsuLo6kcINDMhqV+e+4pGcOb1NKE5DR2uDC0EgGijg2Yueqi
         p7YpbrYMbl29rEjvFb1Dx/bP0nwRHy8zcdMCuCuXNNMAl7nTlhq72IG2Zn4jCLg55EQN
         Pp8vgR8SYwbFT7bZPd0dcA2nUwrCYmByLt2RBY1AvK2F5cAnvMNTXv0FngxX9HIKMQQd
         XoEvRR+HBIBtEYIegDk/lv9hDA8H+pPIMRlAWY9aAIykPpEJuVGr4Xw/mX9BfUqjrMY8
         9YUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=o5n51x59sxtfs0bspBXfBjL3tD09TlDgiTXE1CgF8cY=;
        fh=YcmjAtMDA21kj/kGVq4BaDc5TXcqsCISkfMtZmEnui4=;
        b=Qj7k5sRfUFdKMzrSdeQobOb5xltchGsMRjdqHbDXoZljcWpTm4ZB4NLXpqqCq889LZ
         TCa1n2ZLER7OYgvHa5nLu2EP+9MwKC+NKnsOs9FleDGR/0I6XpN0p6kKxx19JzYwUnt5
         Mvn0jkyKr9WVgqhE/Wgb7mK9zJLPYcGNqJ1m5ldPIkD56sy7wFTp2mSVtkfK+tPiObI1
         FbrTgwdG1K62IjWi2BME0p5INquMRHhgk/vTGuiTpCacHJOPbJwDQsDiYCwv8fsY9Neo
         AhC/eg1tkhFxR8jMnW6AnpCkWA1Cn3h0vdEIdVVuQ1RcNmiP0NXa85cfOCp3YWhgtMiM
         ntxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1795098263; x=1795703063; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o5n51x59sxtfs0bspBXfBjL3tD09TlDgiTXE1CgF8cY=;
        b=NATJwU+x+h6AHV7vGou4j3ono/Md2OV4luDyjboci7TCmuKFe4/+jUTzEY3qeCkODm
         Jdf0mQMp3pWUIR+H53ljsFJxs58GZf9hhs+iwv99yk3jycz0TeXgWLoDwKMIfxcxRYMB
         aT0BJ/j+lFkAIse5VR4AyGqJd4jHFMqWoNCrhm6ablapl8s8PLf0P2wtxBLs0QbAG+sv
         N/F5ZXOBR6H8/3yqRMYYyx3dSnlhN84oKjGPP6b8dTOYbpMs8wLrIsZWePuvE77uNeSz
         /Q3Db6GOZVszJ10GQIP7ssJz+DlMr6noBug64h7R9UqQta6VVtVJkumfxsHUQndEXdyq
         TBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795098263; x=1795703063;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o5n51x59sxtfs0bspBXfBjL3tD09TlDgiTXE1CgF8cY=;
        b=LEt9FMJUpnP9D4uddSQVJXpZ0yGsRTJNGRWx0II7C+DNQAEbGgIU1H32wChOeJ13n+
         itKX3GTMpkwH0ot/DIpJZSZsBXEmB9+0ugQ01CEr8Rjwsm/yhS9SbLbgz9/PYRLId+2R
         nsUeXmuyPvKu2L2t+BzzPcaU2iDUWw+z1IkGHBdV90r46pu7oqT/EoFFPhgTXIcsS1kQ
         9ABoJR95VhC+hgkiw8i7q8MM2FTBe/QtYcZo9QxSk9k47Y/4Mc780NayEPbMMpJQRG8C
         lxq6Ik8L4YAXDIuCPgz+y3RHrgjYqZFWQHmZq3rJ1BsBAI0huMYut8SdirRYVZDvmUuF
         phiA==
X-Forwarded-Encrypted: i=1; AL+hErHw4yue0dMr3zeDKbzlwHYe+fFqLf5DWBaJ5yfLrAoamzovwnlcT/Ss0FqdTxlWL+9PQcKz/o0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/TUAOfdV65aleUBxJXfBKBvkfw3SQJuCnJMiY5U4M8+05o43+
	6y2jjdJmp1fGen+b4qoh0SIgQl4GDktwDfoBq3Gs8KiKmfhGccaLDABqxg0EDcdSBLcttN3vZjg
	R+u3zzq0kyAzkmKBYM/cWMx0O9qo6OhanoEAqmehSDQ==
X-Gm-Gg: AYBFou33lEU56akzcqx0ZDyMeDCwegKis1ibNE6jfAWOx9WE5H9uKHFSVYmkmsM6oPv
	3wRPq9vJCp6UbcQF9rP6r/lD89qGInKO5B/8wGxZDpe5wW2GQ2rJ7w8MMc6+l7dYmOJB0t5oHwZ
	7RqmlpuY/3cQRXnQtowLlmbkdnz0/YB7AOLyVcGHoZliPOjpeYf27Xk0J9AfvnK5+jN29dJIPyg
	qlYavhM2ugI31Yu4SigNfvytuiDbYSaeso1HAiyh6geD+a+7vE1WOmLjQVNOR/qHDPFyIkMuHLp
	fH/8TrwJzHkF9uyV0nYb4v+Y2hBLx98fw08wGIMD3Fm2SGQzrqDc95Uc0WkaKSk3pGTCuQ86jGh
	KbNq6ZjOLYm4sUI6SjrHvKs+qsE+xn0qA+Xb5crLWE/zR2H/ULhT7q3e+gMAZ1weNG92JOzbtpr
	KtJKqsHHYeGA==
X-Received: by 2002:a05:6820:1355:b0:71b:193f:2eb1 with SMTP id
 006d021491bc7-71b193f3492mr4490832eaf.1.1795098263194; Thu, 19 Nov 2026
 06:24:23 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119133032.2015656-4-sst@poczta.fm> <9a5a1487a4676381f4c3d98cb5a22f50e2f54d9d4ec7947891c889b64ac12693@mail.kernel.org>
In-Reply-To: <9a5a1487a4676381f4c3d98cb5a22f50e2f54d9d4ec7947891c889b64ac12693@mail.kernel.org>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Thu, 19 Nov 2026 14:24:12 +0000
X-Gm-Features: Aa3M54pU7ZbLxGTK6OUaJJJ5wSY671yMAwh7XMSPppG-d1bHhduINP_cjWCI05s
Message-ID: <CAG4wq-favnH37jS2=a-aJwBgQOuW=KTsM-vJWp73PNDfFq4=ZA@mail.gmail.com>
Subject: Re: [PATCH v7 bpf 3/5] veth: use the frame mem type when running XDP
 on an xdp_frame
To: bot+bpf-ci@kernel.org
Cc: sst@poczta.fm, ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, maciej.fijalkowski@intel.com, 
	tavip@google.com, toke@redhat.com, aleksander.lobakin@intel.com, 
	ilias.apalodimas@linaro.org, lorenzo@kernel.org, magnus.karlsson@intel.com, 
	ihor.solodrai@linux.dev, edumazet@kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, memxor@gmail.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org, 
	martin.lau@kernel.org, mason@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Nov 2026 13:54:58 +0000, bot+bpf-ci@kernel.org wrote:
> Is this Fixes: tag pointing at the right commit?
>
> 718a18a0c8a6 only reworks the skb path (veth_xdp_rcv_skb() and
> veth_convert_skb_to_xdp_buff()), and does not touch veth_xdp_rcv_one(),
> which is the only function this patch changes.

I think the AI is wrong here. Before 718a18a0c8a6, veth copied a
non-linear skb into one linear page, so no frame with frags could reach
veth_xdp_rcv_one(). Either way, 718a18a0c8a6 and bf25146a5595 are both
in v5.18-rc1, so the choice makes no difference for stable.

Cheers,
Tianyi
