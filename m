Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794520877;
	b=Zki4rbtte0VQ8OjgNwnj8d4L0QOrOTyZAs7IMohvjdL/0nnFTAqGq88dtYTbvuL9xUmS
	 zTB1QdI0C6a9BKH+0HBJOqO/21n6j1uofJ1dQmavTTmuUxiAfTul9/xB1UvsFaYtARgXk
	 cwYaEy4d9qUILSKkEvWIDk6YTYN+rOBUvx93BhOeDd/O7Axe3Mfa/FJQft4fu4r1iJd+r
	 3QjstcQE5Nz1UpAWzTUD8F+kYHwUs1kpBKBe75KTH9Rg/rIHWw2eUT7zOxLHk0y8cUpEr
	 kyuuevf6vWnCEm+aQDexsOHJvRAn62TzrvnX/A9fZoV+ilvyx0Lel9Z7lma+S0MwUpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794520877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NPahPdj6bq+f1tXgN0owcrCGpqBtYrj35FRosbGsj3U=;
	b=at4IrEMYs8RiQu4IqaBQFOMD7B3+VSu4V+TIDWWZ2tiesQ1sHIVi7NfM+vAqtxpFAiry
	 aY6kIQElI1K6kyvkxMKsazZejo0rmxublxTBfWkEjaQSnj9v61FVRLrC+cVtl1D7vCQS1
	 HvFTRFjNtI/s9JG0m465kNygLFblx6Dpn/SfZB7y2AFT1IkRTaJwJljT4C8Mevd5DaVIk
	 lbbR9cxhgO1mVgDmTeBtPQDXDwQTs4FLLftkmIEMAT7DLJ5Kt4od6QObEz/csiKid1OAR
	 4PkU49DAEbQm1lPqns8//Yx5XaqILtRzc4lk9nj2e9XsRXZlstdnm2as8cDVmayIeEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=crBdnlNF;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF846606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 22:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF846606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=crBdnlNF
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5ec3561b07dso359206e0c.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 14:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794520876; x=1795125676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NPahPdj6bq+f1tXgN0owcrCGpqBtYrj35FRosbGsj3U=;
        b=crBdnlNFjY1CopAF5BSuM/Cf9DBpPovYPuQA2z7PeQVyJ+ri4LNxZmxMDPHLkjZzUX
         YXEzOIQeu6jOZ3Vfu257SgR28n2/o9WTUJCp4jX7AQ7CwJ6YZGCdqEvsESdYstOZwtr+
         y5FBcD9vtzU6ScBTuCmwItQBHhHS0Mioftcwxh5sxhRkxZMwdqZs32gy7TnOkO41Z//w
         b+DcVH8r8+7GAwFf+mxoEBW5G262Tu7m4NZhIR8eUceDPkfmewcP0wS9q2g4DVsAbEag
         6Foc7aCnro/jz9/AvCXbzQbLBsNZeaEuTlMbkY+C29++MTkwbwOd/h4YQrFCZBLAzoOZ
         o9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794520876; x=1795125676;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NPahPdj6bq+f1tXgN0owcrCGpqBtYrj35FRosbGsj3U=;
        b=jzMTmcAzDxLjiEsZ1L2QsD5BSLmGBXNMVc3ht4jGzRJzjVDLxkjKtx24hJX/I5Itiu
         PoWiJUb/GgiCHcABuuBuyL5JcEOG4NCPFZ1vd8eFgfayvJPaLwFbbogU1fd5nHQjPrf3
         TV2BlToNT1DiMHc4DcvEMmHCwc04sI09MSEPtNMDM2zswXwKzeh84+hIoNdSu16o9pK3
         cFnLUsvFwObLNnuu1gpmaimwA89Vj8RStQ5uQkPiYH+andZHcThz4o/e1bdUKqD1ZvDZ
         Q/C29vBBggt1t2LH6lva84nTGVxr/uch0Oj5eJ+ArNMVI3SlXeck4iPGBKv8I4ogPD0w
         SeGA==
X-Forwarded-Encrypted: i=1; AL+hErFk64F3owN+n+Gzha+PWr+TFfjsqCqscPzHIRoYDCO/413j7/hxpL1q5LLPav+rQhiIZGugxx0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vRM2aD2o/1e6FOs8Aai3cRCvGRsBaj58aBVyWNUZpt2JppNCe
	BKdNF87bTfR5BL5xnWKSe+aQlR5ZT4NCIg4DhDNBC8Ub09CtaHHVipi6
X-Gm-Gg: AYBFou033shek/p9K6rQRjXp/AGN8vw37D+UQiuwdQhIzUl7fS1gXwQoVOVSNS3siSa
	W+cVZFhHxlGKap5RMnIDIvHNZv7Yt5jNoMzR369mpC5ilBp+dfz7kwHaXaQ0gQb0dIyusvkAoL6
	MMdemN+xzcQy+iDInwbnSUt+qOD+zkfFdPcZ3+uAoXagE5V/WQ6TTN7WbGqE/XFsHTjHqNN4jFw
	zfUVm3sIpPHZuCFRcZ/ImqQWqfxB/1QG9DgOOz3YVjfiU0Vxc0Hnidfm4aFPNYw4AtxXKcFHuF7
	GLqSqaHEzYAGgQI338vjOQ3tS9MCN4vBvn27lp3EDCjT4axtWJkJ5qGTfPYQyP9nOGVN6RKf7Pm
	c/aG0AEecTPbI6CnLKxyQaUSydsEwPPSBRFjmNf3BsETVLMaoIQnYzq4OyVHAfPC90/02sFJ78I
	0k5C9MKGboOLiIOd52D2nqyw+4SldjvAAxGrW21BBa5TJEbd+z5qT2Tk85HoLOAygFIb3KTQTtW
	s+1e2UHA8K508Wq6t05/bR+2rFydNSQVv8L9QUaX9O5Tpbpm0KVDhfPlAcDcJKlpX84r2N3Yf2R
	prQJceWvvh3CqaVB/9pVAvO2uDkqtDsNjve01DVG45ntKUL7z84ygmfasDaTZVjUG/MsR42ANC2
	j5EbureLxImP1/qoblC2IVDXn5AIUBPuIxO4lnn4IGNdaUmndxswmuT8hA02Y+7M=
X-Received: by 2002:a05:6122:2906:b0:5ea:c3bc:c54b with SMTP id 71dfb90a1353d-5ee34a512c0mr136619e0c.3.1794520875632;
        Thu, 12 Nov 2026 14:01:15 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34e32f83sm214802e0c.6.2026.11.12.14.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:01:15 -0800 (PST)
Date: Thu, 12 Nov 2026 17:01:14 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: KhaiWenTan <khai.wen.tan@linux.intel.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Song Yoong Siang <yoong.siang.song@intel.com>, 
 Looi Hong Aun <hong.aun.looi@intel.com>, 
 KhaiWenTan <khai.wen.tan@intel.com>
Message-ID: <willemdebruijn.kernel.2721e06a6436@gmail.com>
In-Reply-To: <20261111053728.2611070-1-khai.wen.tan@linux.intel.com>
References: <20261111053728.2611070-1-khai.wen.tan@linux.intel.com>
Subject: Re: [PATCH net 1/1] af_packet: Fix wrong timestamps in tcpdump
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

KhaiWenTan wrote:
> From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> 
> Since commit 97dc7cd92ac6 ("ptp: Support late timestamp determination"),
> timestamps may need to be retrieved with input from the driver
> .ndo_get_tstamp(). Support was missing from mmap'ed AF_PACKET sockets.
> 
> The problem was noticed using the igc driver, that since commit
> 069b142f5819 ("igc: Add support for PTP .getcyclesx64()") has migrated to
> use .ndo_get_tstamp() that timestamps were wrong on the receiving side,
> when using tcpdump.
> 
> Fixes: 069b142f5819 ("igc: Add support for PTP .getcyclesx64()")a

Fixes: 97dc7cd92ac6 ("ptp: Support late timestamp determination")

> Cc: stable@vger.kernel.org
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>
> ---
>  net/packet/af_packet.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index cf6429f09477..7197236c8a3b 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -456,15 +456,20 @@ static int __packet_get_status(const struct packet_sock *po, void *frame)
>  	}
>  }
>  
> -static __u32 tpacket_get_timestamp(struct sk_buff *skb, struct timespec64 *ts,
> -				   unsigned int flags)
> +static __u32 tpacket_get_timestamp(struct net_device *dev, struct sk_buff *skb,
> +				   struct timespec64 *ts, unsigned int flags,
> +				   unsigned int sk_tsflags)
>  {
>  	struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
>  
> -	if (shhwtstamps &&
> -	    (flags & SOF_TIMESTAMPING_RAW_HARDWARE) &&
> -	    ktime_to_timespec64_cond(shhwtstamps->hwtstamp, ts))
> -		return TP_STATUS_TS_RAW_HARDWARE;
> +	bool cycles = sk_tsflags & SOF_TIMESTAMPING_BIND_PHC;

nit: whitespace line between variable declarations

> +
> +	if (shhwtstamps && shhwtstamps->hwtstamp &&
> +	    (flags & SOF_TIMESTAMPING_RAW_HARDWARE)) {
> +		ktime_t tstamp = netdev_get_tstamp(dev, shhwtstamps, cycles);

Does this call need to be conditional on SKBTX_HW_TSTAMP_NETDEV, to
interpret the union as netdev_data?

like get_timestamp, resolve the orig_dev.

> +
> +		return ktime_to_timespec64_cond(tstamp, ts) ? TP_STATUS_TS_RAW_HARDWARE : 0;
> +	}
>  
>  	if ((flags & SOF_TIMESTAMPING_SOFTWARE) &&
>  	    ktime_to_timespec64_cond(skb_tstamp(skb), ts))
> @@ -476,11 +481,16 @@ static __u32 tpacket_get_timestamp(struct sk_buff *skb, struct timespec64 *ts,
>  static __u32 __packet_set_timestamp(struct packet_sock *po, void *frame,
>  				    struct sk_buff *skb)
>  {
> +	struct net_device *dev = skb->dev;

validate skb->dev != NULL

> +	unsigned int sk_tsflags;
>  	union tpacket_uhdr h;
>  	struct timespec64 ts;
>  	__u32 ts_status;
>  
> -	if (!(ts_status = tpacket_get_timestamp(skb, &ts, READ_ONCE(po->tp_tstamp))))
> +	sk_tsflags = READ_ONCE(po->sk.sk_tsflags);
> +	ts_status = tpacket_get_timestamp(dev, skb, &ts, READ_ONCE(po->tp_tstamp), sk_tsflags);
> +
> +	if (!(ts_status))
>  		return 0;
>  
>  	h.raw = frame;
> @@ -2424,9 +2434,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  	/* Always timestamp; prefer an existing software timestamp taken
>  	 * closer to the time of capture.
>  	 */
> -	ts_status = tpacket_get_timestamp(skb, &ts,
> +	ts_status = tpacket_get_timestamp(dev, skb, &ts,
>  					  READ_ONCE(po->tp_tstamp) |
> -					  SOF_TIMESTAMPING_SOFTWARE);
> +					  SOF_TIMESTAMPING_SOFTWARE,
> +					  READ_ONCE(sk->sk_tsflags));
>  	if (!ts_status)
>  		ktime_get_real_ts64(&ts);
>  
> -- 
> 2.34.1
> 


