Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795365724;
	b=hm9SZ/oCd8f7Tz9yQNt21N8zM5T7ODG+FJg+j/OTqJkrm+tbXpWjZ6ZQLu9x6Ouq0l7q
	 u/rQClm6+I9eGdRpuiWbZMb3oBgAcAOl2HtT9LDRkhxhJ+QZKN7nuPOKi59CE7gZebbtK
	 Q0C4qe3GeevxaZKmJt7oT5z1EI5m3SfQ3F6+1uH3Ybn5j1GyeNSqgg8xjgjF2H85xvcJk
	 VHQStmbO3Yj7S3tz721EeIuJNx1ZMT7JU+XmCfRjjeqer1PoMo+2tbs0BVR51bzik7EB0
	 ATii+PQB0eg0w0+8lX5RUguhUARewAeRiw5ql/Ke2vH44/U5FXjTI0JdjoPH6QHRLNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795365724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=r+azstJQBlGkRidMRHAdXxlGjDX4ypISpWhtS/MVgqA=;
	b=W8CrfY97ZGBc8TAYw4JUnwctq2zYqUGpesLwK7tb8Xn57lCGsqF9IBOZAzaZBCvFHspx
	 Qp3lGz6JCghluzXJu6V3Qxfs97+4hu4T+7Co5xcI9J9jcLXJxWSlCQY18pXkKMbKlwPLO
	 m0AI/NCCt08jvVXeeaSZPXtaYR3m5LUy70xNWgXA/DVayKhDciDBMgGZFnaTq59OUTWWm
	 qAjHDqRSRWbu+Uw0Nr7qos2b3eNehs5PgIHZXhRSCYWbOzoSqDuHw7wefSg+7/mW+2p2Z
	 8zncq5hGIVLmEIgiJrW5q+1VcMGFHdjC2NcVQcPEFhVx/48xdfjKXcKOwyYatdD/+eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=rU+Vj6Eq;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7196F606A68B
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 16:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7196F606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=rU+Vj6Eq
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c5126505cb3so322176866b.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 08:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1795365723; x=1795970523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r+azstJQBlGkRidMRHAdXxlGjDX4ypISpWhtS/MVgqA=;
        b=rU+Vj6EqFLZtq17OykikcbR7CZ6nQcRm1ZcCcBNJHmhIDgQPzzfDcfwqSEsJaQvm2M
         bflHZJdk+tdlUjnlKQXpl384X8OAE3gZS7irQnM0xo8AH/s/pAdzgYoTh29JnEb4oSD1
         9KTnTw6Hqdx1P4gJ30al01fFHP//Jhkixb2rjcBN5bYfFoOtj3kRePsZu2bSPauGIZOd
         JYRs+aNNx9/27liDqsDg9MW/M7gaCCr+DrX4+O09M/LZ80rvXmi2QCQYDEjCEFmUdMAT
         YlCmTEq1MBgKcmWELV9fDs22V0cy5L4dDzo4jrZ+kHWZPvwf8hBOliJ3VQP1MIpxgm6y
         pNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795365723; x=1795970523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r+azstJQBlGkRidMRHAdXxlGjDX4ypISpWhtS/MVgqA=;
        b=JTgJHCOG4cuScyk9TT+LkzSiQRuhwtZlwNf53nYYjQP6GhP8+cHJ5YNvbCJuKMN0HV
         yXnezsWIywr01KuuI6yhnP87oqYP0isSrwYNcHEiiscW8Y+fRbEX375mcpKGUhd1JyNw
         FFpYeMGtqevZn3Azkh6/AphiaZxyUJpliJJ+8175c7cdVR6Oq0lWKxBxh0/xjMiBQCoW
         gMoIYncrauJVNQ/2u/fBNOXxnHigl79a3bcjJ5HiRPd//r2uXAvR/S75OmOaje8TDqAC
         9rowAJ+IfZxYKFwkYZ/Go5ijiQqTuqJxPCw0uZrxMLXLja4hM/xFD9Fy2Saz4RqKxQBT
         CXrA==
X-Forwarded-Encrypted: i=1; AL+hErE6mwSBpbfiNtabJW0LtZnvgV1BnkbqmvYH5ehDhnr+hlCHVgmMvDbB04Y0sIzhQBco/oIzlMA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/PYejIrWZpLTftLv9sTC0vnXKj9hnTGDhKNC29x5x/2KydAc6s
	8Z4REX+Qc8HLd5isGgljFR3fbuaTj10E7BeJWJUFdRpNlb2dszrbqmN9bCPfroo3NQ==
X-Gm-Gg: AZFdTZfghsDlGHIjbdeMHoqyt+oxOJuLq1/0+xUI0SOVfJ2NSyxAu47cESQM4nbMooR
	l1tzQC1S7DALErXpc24MYocuupUPKUqWRqgreh0Hln1nSa6i+mZyRUorbdbWalYLG2gA9DBumrc
	aAs8A4CY0J9SchovjWBXP0aTsxtPu3et64Lk1Y79/UYDA8M/VJIdR4DaPD7DYDlsdqbIcBcxjX8
	XQpRzLMHgOVJBFj+nDMR4HoOEJ8QqbwIjSXYn0vkY29XjcUj67bXvbWsGIspRH96m43iNiSIJX5
	FdC9KHFROgAjW39Ph6iVIIZw/yKMQtFty4iRIKorNlSWgKNC6hcKvaUgUtLjzrOqildgCF5i1Eo
	g+OoO/pVGya3WZte/CAJSuMGmXUHLxsqRiOqYQcu0XkG0Te9Uhe/FCZ9m2qDIh5e72u0jtjdO8Q
	fTAi6hY1iSnyIYXdW+ebN9zP/wm9ejTyhap7hI9Mff2SXlyyXueg+awOZY5nxyjDHmjGNWTtpCm
	xmlkhVRtZWraulVd0uUyprIrqIMrQMwGEK4DMTj7lMTtDNPCdwtRM3ASH6PrhhZFg/HTXimMDly
	Tvn9C4Kf08Smn7JiyNoAm2Hw/Mt43T2cJPOwH31EuZ915nDfTOcyH8lUariisv3NwWXkd5B4CgO
	HhzcX+yzdMgMDfwv+BSf8v1vHRtvRIe2G27e0AsYUY6rYYjGuPQdCl7mgot7Kj+hkDtUxhDNPsh
	Zmd7+UGBz98usjS2+Hmoli5W1si8Rt4CEpbsvVMFE/T4dzLgSlXBPRx1+VZhlFD51oKHUQVgZMU
	ewo6Fy2yOoitAg2Bdrwlr2KXQJnhB14K98JLfSEAN26nX163qdqjLTAPzs9Vv0p1x20pQyXmUgq
	3Y8QwrRJJi4p44mKkzjbkV5jilqw04yJLKsb5N1wuqnrzjEmABENbP9JuM9PpEgB2z0EYqWt5cD
	iO6Z7hFwV167Fuf68thct
X-Received: by 2002:a17:906:3b04:b0:c29:3c97:c994 with SMTP id a640c23a62f3a-c513ab47f35mr594973966b.35.1795365722856;
        Sun, 22 Nov 2026 08:42:02 -0800 (PST)
Received: from Desktop.tail070c67.ts.net (p200300f247136100ed9c1e497de323a4.dip0.t-ipconnect.de. [2003:f2:4713:6100:ed9c:1e49:7de3:23a4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afed51asm319489466b.76.2026.11.22.08.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 08:42:02 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	stable@vger.kernel.org,
	hassansultan@google.com
Subject: Re: [PATCH net v2 2/2] net: gso: fall back to skb_segment when fraglist cannot satisfy checksum
Date: Sun, 22 Nov 2026 17:42:04 +0100
Message-ID: <20261122164204.4058652-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120044733.222627-3-willemdebruijn.kernel@gmail.com>
References: <20261120044733.222627-1-willemdebruijn.kernel@gmail.com> <20261120044733.222627-3-willemdebruijn.kernel@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Willem de Bruijn wrote:
> 1. Outer tunnel checksums. __skb_udp_tunnel_segment() and
>    gre_gso_segment() compute these with gso_make_checksum(), which
>    reads stale SKB_GSO_CB() state, and needs an inner payload sum that
>    skb_segment_list() does not compute.

Patch 2/5 of my "ipmr: forward GSO multicast packets" v6 changes the
same three conditions for this case. With this series on net, the case
from 2/5 (TCP from a local udpcsum VXLAN device, CHECKSUM_PARTIAL
aggregates, forwarded with rx-gro-list on) leaves no wrong outer
checksum, 3 of 3 cases in 2 runs, so 2/5 is not needed on top of it.
The other four patches apply unchanged on top of this series.

https://lore.kernel.org/netdev/cover.1795295554.git.julius@bairaktaris.de/

> +	/* Tunnel headers and outer checksums are not rebuilt */
> +	if (skb->encapsulation || skb_tnl_header_len(skb))
> +		return false;

1/5 is still needed: the fraglist branches of
tcp4/tcp6/udp4/udp6_gro_complete() leave inner_transport_header unset
for qdisc_pkt_len_segs_init() and skb_gso_transport_seglen(). VXLAN
forwarded with rx-gro-list on, 20 cases of 1000 packets, 2 runs: 34 to
241 reach the receiver with this series, and with 1/5 and 3/5-5/5 on
top every packet the router received, with valid checksums.

Is v7 without 2/5, based on net once this series is applied, how you
want the two combined?

Julius
