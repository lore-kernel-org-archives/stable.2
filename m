Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785784;
	b=tyvGanxH6Ld30jj6nS0Ec5yrdRNORQyGQb7eRogGaksJCOLoNBm1KuhVR04nSoneY7kn
	 eqRAB4xS9AnvWACv5+sNCaLrYsNrovv2Uk/auNn8mhRfreuylpcIQWbte2gIc7dg0JfSp
	 8SoD/gBN6V9C+vUVyGSfzdx6dyIvYKprPxHqeQcPuH9cHt3AT9N1EuStzRsXhBmwW+TsB
	 o9Tl7Wn75Q0cvggcKeSUtOH5KKUVZFtrX/HZpl4fQP3onspib3QGjGEjivPHFntruQbIP
	 gWSYbjHj+O8o2pUgpYIeLx2taGbGjfDG8YpgBEoVGGbsIMpuSdyzJbWeDRZ8okF0dlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785784;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DRU19x392dk4YaX+zmFXG4/lfFvDr2W7dOw0AY8YH3I=;
	b=RH/EkL8EqbT/qudNCvIf5UkcEVVMaW+ZBh/vyCixieL9BWYPG8kphHINSot9p0FDheSk
	 s709/lTk/hnMjHz+ppipwCxwOsyV1vAq9bbr/OUhdkcmwLN+k5clHicIbnfbnPlnGM8+R
	 n7PRYF4zCKmsXYTujLLWjGTdo/SEFz6ccqutAbcuNNbUuMZozPiC1QZDbUWC7QzxfHL2a
	 eA/Mwg3QemqHVHICcCdCKVsWs7OsaoUp6EVRXMCYWmBg0bGoP/dWcH8bKWsDaHpUE4u4q
	 1PYK+b9JzAHZwAy8kk1LwB4FMCxePEmMQ5kQzHN1TsF5WZoT0CxBbaOjDe5iwI0RlZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QC3iBoIR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B240C606A328;
	Fri, 23 Oct 2026 20:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QC3iBoIR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FFC1F01828;
	Fri, 23 Oct 2026 20:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792785783;
	bh=DRU19x392dk4YaX+zmFXG4/lfFvDr2W7dOw0AY8YH3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QC3iBoIRnEhiQkrxvASWaOxaymxcAUMwstwM7t4VRSmjwfpvBG1O+Hf8hPG7VeIfp
	 2zuUacARE44eHoHDepmhJq5SrhzApP9rbrneonwQRB2+hpbpnDisa/JUqMipCrTfon
	 uuZp706JbFtjKxdbZyccHCnwVvHHyHer/02TvA9gTBSOPeMvGOsa5ccna4wK74QrKV
	 ubap30kyxDSXvEbrbPhwWKaSFDtVnTVnT2gBAvm8F63Zj1XImb6eMuPKrmc4yQniDN
	 jPM3Vw3xg3yiWH0Csk8IJDhNglphgna1Nnqlo4vBa4R66/a3MEMZ8F/NzazJfPx0e8
	 FbR41bcWd33pw==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	kuba@kernel.org,
	linux-hams@vger.kernel.org,
	Bernard Pidoux <bernard.f6bvp@gmail.com>
Subject: Re: [stable request] ROSE memory-safety fixes for 7.0.y and earlier (merged out-of-tree in linux-netdev/mod-orphan)
Date: Fri, 23 Oct 2026 16:02:44 -0400
Message-ID: <2026-10-23-1-daily-reply-0008-rose-ax25-netrom-suite-bounce@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAFAa3YDU2LnSiBH+2Rk455hky58fW=6_NeO3bWC_=GYmb9M0vg@mail.gmail.com>
References: <CAFAa3YDU2LnSiBH+2Rk455hky58fW=6_NeO3bWC_=GYmb9M0vg@mail.gmail.com>
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

> [PATCH 6.12.y 02/26] netrom: linearize and validate lengths in nr_rx_frame()
>
> +		/* nr_state1_machine() reads the window size at byte 20 */
> +		if (frametype == NR_CONNACK &&
> +		    skb->len < NR_NETWORK_LEN + NR_TRANSPORT_LEN + 1) {
> +			sock_put(sk);
> +			return 0;
> +		}

This check ignores the flag nibble, so it also drops CONNACK|CHOKE (0x82)
refusals. __nr_transmit_reply() builds those as 20-byte frames
(skb_put(NR_NETWORK_LEN + NR_TRANSPORT_LEN)), so a refused connect() no
longer gets ECONNREFUSED and times out after the T1/N2 retries, and CHOKE
resets of state 2 and 3 circuits are lost. nr_state1_machine() only reads
the window byte for a plain CONNACK.

-- 
Thanks,
Sasha
