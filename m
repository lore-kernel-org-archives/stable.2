Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794682230;
	b=qcBvyV6B3MDo1rpUAHMqWISkvJfbp9lEKJcBeCee0/v/HvfMUVWDp589kc1kr2WkTlvo
	 Lg8l1fdyluA6LHD3zg2h8sYTK5iT2Hz5BXTLk9Ox0hHQHKUFfptLa8DvQwzrmaHjCfQ18
	 iGy2CUY49+RfE11bCN6qwoDtos7hUkYnwqQbIkJ/lsTfHDQS62hcowHIG3ZrKP+DBg81l
	 FOSGSzgJ23lLLK146abgSmgtx2kCbmVSRrxekTU6dVpxX37VfDmrUIRDwgYMWX4l7YrUD
	 HcolQqqOGc3qInWL4WcwZg3rHmepngg5Ad28a2EiZHl9oEjATAW91qDX9yG6C5NqbsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794682230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=J7v9/YPEzjxZ/LGBEzvQ09s+gFXT8pS/d7xVKdjrCoE=;
	b=Y8az09Nl+DApn5O2iOTn5yks8vB/npiMWIqAc73FJtPU7tzOaX9pnETSmiu0jdnYZXBu
	 3Px4QzFb/No7HbHxFho7UYMkYxXIVo2mFKWWuJGvVYvyLaTJAKNl/gSVo+GEa5nwzoSKE
	 20M5FTbDKBiK2vZ22H8vorUa0RxxwdSlvHZR+c9VUIk++GPViY2bk9wSWrxTWK5rO/gc3
	 Tk+alX4keBleBo/0i24U/ZqzzE5/2Bvq7ic+Tnt2rBKV1uRw9Y2a2IQLuWRD4DLaWmaLG
	 7e1zphPIY4dtCg9KawZMr+Zx4kdAE+u+SQXu7rOAhmm7x0VaYHf6dBIu28V5XjSZ++w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GLhZMEfG;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BFF606A32D
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 18:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7BFF606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GLhZMEfG
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e977109392so11968695ad.0
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 10:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794682229; x=1795287029; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J7v9/YPEzjxZ/LGBEzvQ09s+gFXT8pS/d7xVKdjrCoE=;
        b=GLhZMEfGifRuC596AndpNsLBIA9hBtwq3Fl2rl3RpCiUBa8JAgBi68PRu+6UvL0g+9
         Xzpu5p86rL78arrOM1QXBYNA9uv/mQu8WneFiAYdgeLD3BArt1DXcWip0vvdIfwC1ddG
         0N7V1Ecf+4SbVcB6y4tQNetroGzQmR9Z6fFcA0F6Ilqp1eKHvae2lq5iaUBEk0SCv3fZ
         JsSK0yuswuP9WHl5IzYpDImD+QbhCfQvlc2i+GAF3wnXupHdatzhSaYbY7MO1Gbgv/tJ
         /1lWvvJ7uBAc0QGCLV5ij/aoOAMBqbIa9aK22/g81KNbLj5WqLzMp41HokYHr0zzbrFb
         IZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794682229; x=1795287029;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J7v9/YPEzjxZ/LGBEzvQ09s+gFXT8pS/d7xVKdjrCoE=;
        b=UaPmT6/q6vpJKzGalZ24jBtmJAj6DAXnO9WpsY82DIw2wKZ5mAzhBVLGBsM41/j3Eq
         0HRNHnu1Wg0fhOxQAHu2Wp4jjNeatmtD1DuhWHPRlrPWHfQkrb7/LqBQSeEtQUe+Xr/D
         zzgJb6s6PtQr7YaIJG1zLAbQNSuF6QjnSVeKIHF1xK4R/BdTK1RIXgSF7RbBZq9ThwOu
         BEK5nUunDx3+kf4EbBPbbhbXNiRCxg6dYa+OfgRVCan1Trcoax0mpawn9mxmQHX9Oycn
         CHZbY0P+rCQYMHv1D/ZDtjxIy0Ju/5sep3aIZt1g8krr4vkjWGaF6PX6HuY82rEPebm/
         4HiA==
X-Forwarded-Encrypted: i=1; AL+hErFB/Xsb4m2ptNhcQEY2JNOWDB9wn15xF2tXCnsOgkjXRIuE3KkWdTC4oBKQ2dovoUoR0kKrVnk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/D6AA18byJsCYd9mtGcMNhtNPZxdZi0b7SnTfCzn2zTe56d47u
	ZtIdT008lxuLzFhTpFawnWa2uTQyV9L6tyM3ka3N/vml9RyZRK8bGk6j14X2Tw==
X-Gm-Gg: AYBFou2vc3Ju6EfFIiyefIOtFWINczBtLILxGbpsl0SqS5WZsC1DroFkkH3wfOrB/Bq
	LDH7t2Lkqr3v6cqYrbfnkwEMX6K4RIJ0T6eK1EvBUEGL85fVuRrhMpj4hFTNB/DphdhuWMtA0On
	6L8g1upIwncX32pmh6IOjXmxeaxO2rq+Ouoly/uKYoHS78oxD5IWThQbtsQTpk7E42dV+3z4ODq
	bgOYnTMeFaoPhZxAPeWKMI/BcvCKLn5NHHsPyVlBf67aXvZwodz5PLPsCSVQAcLBHkpJacLac4O
	ct3Av6QYptKUFESYd5fHDiopMCI7nDxFOZcHPAPZldXRDubsJJBnLF+pakchbmwG7d9qMSnSZNw
	QmOYxuFlBBvd2RKMWImY9hY+SZJHervgu0EB8CchbJxwPnJXTXm6olmVl1PEYehXcxfpfrkrlua
	envVxqfcXMxs2MGwoF2RrJpPJp/Sylxu1GPATTNOdhXP2pbE9iigu8bepz2ayHT+g1wgsKXIPkI
	BKG/lHfakQYoAeLv+aQxr6WE1U32+0DpDRkJ+VevI9H0Zm73OMonakeRt7jR2SXSEg7xcaRnSZx
	J1Tlqrc4kCA2JE5CXama2MS4//wKc51WrA3a5xBIiWFZLPp2jToM9Hsfv/XCgMy6cx5ah/ymFk7
	dByqC1j7vpIsxvSz3A2vA0F/DqorEZGD2Xw==
X-Received: by 2002:a17:902:db04:b0:2ed:2b43:483c with SMTP id d9443c01a7336-2ee0dc2a5bfmr60623615ad.38.1794682228921;
        Sat, 14 Nov 2026 10:50:28 -0800 (PST)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f75c980sm22473765ad.25.2026.11.14.10.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 10:50:26 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Nov 2026 18:50:24 +0000
Message-Id: <DMV5R4A5D4UE.CX5X9T3GM3GL@gmail.com>
Cc: "Michal Luczaj" <mhal@rbox.co>, <virtualization@lists.linux.dev>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net v6 0/2] vsock/bpf: fix recvmsg deadlock and
 zero-length, OOB, errqueue reads
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <jrmmhm.kernel@eldare.de>, "Stefano Garzarella" <sgarzare@redhat.com>,
 "Bobby Eshleman" <bobbyeshleman@meta.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261114-kbh3-1-022-fix-v2-v6-0-96b6029bbffa@eldare.de>
In-Reply-To: <20261114-kbh3-1-022-fix-v2-v6-0-96b6029bbffa@eldare.de>

On Sat Nov 14, 2026 at 11:59 AM UTC, Jerome Mohm via B4 Relay wrote:
> On a vsock socket in a sockmap, a blocking recv() deadlocks with the
> virtio delivery worker and stops all vsock rx on that worker, and
> zero-length, MSG_OOB and MSG_ERRQUEUE reads spin with the lock held,
> wait, or consume stream bytes. Both come from the commit that added
> sockmap support. Patch 1 hands those reads to __vsock_recvmsg(), and
> patch 2 releases the lock around the wait and makes the wait loop.
>
> The deadlock and the MSG_ERRQUEUE case were found with the help of
> Anthropic's Claude, with Stefano adding the stream-byte part; the other
> cases come from the netdev Sashiko reviews and Alexei. The reproducers
> are available on request.
>
> Changes in v6:
> - Split into two patches, the zero-length, MSG_OOB and MSG_ERRQUEUE
>   early return first, as Stefano preferred; the deadlock fix does not
>   need it. This is the reverse of the v3 and v4 order, and 2/2 no
>   longer argues for one patch.
> - 2/2: check the transport in the wait loop before the data, so a
>   reader that wakes after a failed connect() has dropped the transport
>   no longer calls the data check, which warns (netdev Sashiko review).
>   I check the transport instead of swapping the two tests because
>   hv_sock reports the peer's FIN from its has_data() callback. The
>   WARN_ON_ONCE() at the top of vsock_bpf_recvmsg() is unchanged.
> - 2/2: reword the comment above vsock_rx_done() (Sashiko).
> - 2/2: leave Sashiko's signal-and-timeout point as is: such a reader
>   gets -EAGAIN where a native one gets -EINTR (see my v5 reply).
> - Rebase onto current net.
> - Link to v5: https://patch.msgid.link/20261109-kbh3-1-022-fix-v2-v5-1-4d=
9af04f0fad@eldare.de

thanks. lgtm.
