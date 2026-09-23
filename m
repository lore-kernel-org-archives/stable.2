Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4FE530DEA
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 14:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172904; cv=none; b=UL58A/VzCyxzV5V+Z8/fcv0bw8JSpm0tq9ORkoQicwqghvT0QoJUw7G87fOSSpFNZNWppUkUrbUAw7CKZY8EVm9dzo0lMlhmnDHPHr9MRb/8gjOiRrOGdLOIRQ3of9EgcaEqipNnLfTakqMsnKUHMhawXHZHENS2u5iz21XBtaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172904; c=relaxed/simple;
	bh=N3GCVIZrRdfg15qsrTIp1feOBIWXoEyHYr48NgvemMo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=b4AtsLdcKlp3tJ26Nc4AABYNF/yffJHIwco1HHMCh6A+a7i30K/LPtet5iAOEFYhlIJSJpQT1osffcq8MfYSSei48yN06yYPqQkuWio2zIrp4nzYZYQlj3pMxbTXriDhFQjxJ7awzEAKvCTix/F5AVVCf6ycmc1RjZ1xSRkOWc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7H03XF9; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7H03XF9"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-86382f10801so6784787b3.1
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 07:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790172901; x=1790777701; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=g9HyKk9/ZWrL06gZRzKMTMxOAy/kc6dxzp/oTmEvNFo=;
        b=T7H03XF9yFeRy/uEOLdZgLRt5SYUUkEHFhBCrWe0FH/Y/+lufxOVqCIOJue0PUOMRf
         aORZk9ru2KgcNW5KNY/64CoNf1+jo2l32ci6lr9u0kJQqPvGNEWe64aE9JkUrDlTjF1Q
         gpGYe3MP3lyVivaLMidoz5KyO2uMqnt3CrEYeLeer4zLLnTMpFEJHpk7ikICOrA6zvFo
         4V7oxDYc5GyANw/90R9T7nvUxhEc0IbcTEw/D+EYzCftGYb+1vEvfgK8s89MLk5/EqoK
         zG6Yzl1AJ48i7sqvWvUs0yGEAjLVYuiFFUIUybmURiqnRy7/oJdbADcqfcz4qcPYsuQf
         a7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790172901; x=1790777701;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g9HyKk9/ZWrL06gZRzKMTMxOAy/kc6dxzp/oTmEvNFo=;
        b=G2O5TI0V+AmY9aDp8tUbiSoRvQupwsE9G4psVGvS9M+BvalY3IGesKUR7wof34XqVp
         omZZel4sF9K9LE1KQ+mUo+8WDlRG27Afgt+QFTCOjKnoKBpDu2xwyzNIwdK1Ib8xnQ0+
         nieBPr3sH7pGga7BlYG8W13n99UzULV+hJm7hfC/0no8xmVRUgB+yBQIV5nHqY8JHm2u
         s99N5TX63vIi98rBG18cf+ad90W/wrsI+hiBeF+hoEYxJfHjhR2L943D3gqGuHU8ZHF+
         /IU+Pii4NiXaPdCeuHEb9P63O354+bhwb9zyfC/Z4vYLuR4AbTrW9fPMvCeGEN6VC3tA
         FXFQ==
X-Forwarded-Encrypted: i=1; AKwUvBzLusKszox9shJrfG1INx+KQhXahOctYYa/rK+IPH9YHXPbIGzv4sVZo4Tx1O9evowfhREeWy4=@vger.kernel.org
X-Gm-Message-State: AFuF++m4sHzv9zdMExwOv3z/iBo01qB1UEu/c4LzD0LU0DFiwS7XX8CC
	+GsslVoMVJTnv/JoqMCOeXzJYPWHH8yjX1Ktli/yq7tb/lb9ViuokYY78WxnLw==
X-Gm-Gg: AYBFou1HSb+SoF9AmP1QdFmZHFIWTC/GVMY5zWPU+YqbCwFSeqO6PULknXG6sk1msez
	n3Fd8H4sEB+6GigrLNXJ3jFF8qCVhuG7Yf/x76QXmJ3EBnF6RCbIM6UQW7bwS66hCqHzP3v7u2Q
	r2Znrwjt60Zx3gNf+V+c+BCPDyYKu/FEQkaI5fw9rVRfXx+5eUMgiFh/G5C2kXWX4kK7BPHlAE5
	kdqULctqf4NntHjfDF1DQ+5cLnI0S+kbFIexkPGGx1Ou0C0qo+TUrrhti9OoFGkps+FZeSugjm4
	SDXaPeH+yeGNNwbvcNnKbtjO3deqh4t3ZyZLF+znPX0hF+ReHmhP40V10PQXIKZJStgInvCOKWr
	YVGpmubH/HlDd/7NFl7In/1Eh7/f9437kJFPjHK5CZWu6Sjt6yDYfjqd0IaQkOmjxqgqbyMvQYu
	/0cPs04uLYFR/9J8+HbBjjEhEwLKXAcZ56FDvpyK8jxDvyF2boNKYAijhwIR/Kxz1cJXqXbRn/r
	FTElZ1DbGhc3uf0T5jyzA3uC5V3zBpwSosIpQNCu1BtUCU5ugBYJuVpeXQFrTA=
X-Received: by 2002:a05:690c:dd6:b0:87e:645c:182b with SMTP id 00721157ae682-8a45e272eccmr13879387b3.26.1790172900809;
        Wed, 23 Sep 2026 07:15:00 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a4614827cesm10025697b3.7.2026.09.23.07.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:15:00 -0700 (PDT)
Date: Wed, 23 Sep 2026 10:14:59 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Dairui Zhang <zhangdairui@gmail.com>, 
 netdev@vger.kernel.org
Cc: Dairui Zhang <zhangdairui@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.270294ef6da64@gmail.com>
In-Reply-To: <20260923050101.1510064-1-zhangdairui@gmail.com>
References: <20260923050101.1510064-1-zhangdairui@gmail.com>
Subject: Re: [PATCH net v2] af_packet: fix integer overflow in
 prb_calc_retire_blk_tmo()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Dairui Zhang wrote:
> prb_calc_retire_blk_tmo() computes in 32-bit int arithmetic:
> 
>         mbits = (blk_size_in_bytes * 8) / (1024 * 1024);
> 
> If I'm reading the validation right, tp_block_size is user
> controlled and packet_set_ring() only rejects values that are <= 0
> as int or not page aligned, so a 256MiB block goes right through
> (and alloc_one_pg_vec_page() even has a vzalloc fallback for it).
> 0x10000000 * 8 wraps to INT_MIN, and on a NIC reporting 1 Gbps
> (div == 1) the function ends up returning -2047.
> 
> The condition is actually (8 * size) mod 2^32 >= 2^31 && div == 1,
> so the trigger set is [256,512), [768,1024), [1280,1536) and
> [1792,2048) MiB. Other sizes wrap to non-negative values and faster
> links divide the unsigned value back below 2^31, which is why this
> doesn't blow up for everyone.
> 
> What makes it fatal is what happens next in init_prb_bdqc():
> 
>         p1->interval_ktime = ms_to_ktime(prb_calc_retire_blk_tmo(...));
>         hrtimer_start(&p1->retire_blk_timer, p1->interval_ktime,
>                       HRTIMER_MODE_REL_SOFT);
> 
> A negative relative timeout expires immediately. The callback
> unconditionally returns HRTIMER_RESTART, and hrtimer_forward() turns
> the negative interval into hrtimer_resolution:
> 
>         if (interval < hrtimer_resolution)
>                 interval = hrtimer_resolution;
> 
> So the SOFT timer re-fires at the maximum rate forever, holding
> sk_receive_queue.lock each pass. One CPU spins in softirq until the
> socket is closed. Repeat with more rings and the machine is gone.
> 
> The overflow itself is ancient - it was introduced together with
> TPACKET_V3 in f6fb8f100b80 ("af-packet: TPACKET_V3 flexible buffer
> implementation."). Its effect prior to f7460d2989fa ("net:
> af_packet: Use hrtimer to do the retire operation", v6.18) was not
> as clear-cut, though: the return value was stored into an unsigned
> short retire_blk_tov, so a negative result was truncated, and a
> 0-jiffy delay loop could be programmed as well. Neither is nearly
> as detrimental as the immediate maximum-rate spin the hrtimer
> conversion turned it into.
> 
> (Unrelated to CVE-2019-20812 - that one was the ethtool failure path
> returning 0, which now returns DEFAULT_PRB_RETIRE_TOV.)
> 
> Reproducer, needs CAP_NET_RAW (a --network host container has it by
> default) and a 1 Gbps NIC (QEMU e1000 works):
> 
>         int fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
>         bind(fd, ...);
>         int v = TPACKET_V3;
>         setsockopt(fd, SOL_PACKET, PACKET_VERSION, &v, sizeof(v));
>         struct tpacket_req3 req = {
>                 .tp_block_size = 0x10000000,
>                 .tp_block_nr = 1,
>                 .tp_frame_size = 2048,
>                 .tp_frame_nr = 0x10000000 / 2048,
>                 .tp_retire_blk_tov = 0,
>         };
>         setsockopt(fd, SOL_PACKET, PACKET_RX_RING, &req, sizeof(req));
> 
> Compute in 64 bits instead. The operands are already bounded by the
> existing validation, so nothing else changes. If you'd prefer a
> different fix, just say so and I'll respin.
> 
> Fixes: f6fb8f100b80 ("af-packet: TPACKET_V3 flexible buffer implementation.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dairui Zhang <zhangdairui@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
