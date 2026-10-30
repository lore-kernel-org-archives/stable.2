Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381910;
	b=IaLlZsrWUeoEVjFT7dLHLRZgVK2GKwrhSJHT7luL2lC8eCXGDrjT80jkqeRUTa8VRA4m
	 rFnvzftvxD5SMght9DE5YXAu+DZXAeA/TWzYeTpt08RZgyOvQkDdEMVm+50tio5q86a/j
	 D/6AarK368WNI+oJd8B1g3ZHUPfgfbd9qoPFH6m2PKI2k98niwMvLXBz97eZSwdHnZCCF
	 D0u4cZ2QqDkmAklii1OsfYhvvWaIyF22YBeREHs1rIwIBhCBujOIQy1y6X7v+2CEzs52J
	 Ey+UiYhhplafvrfGFF/Eupi7Bg3LlhsmBlMfcTtCncHibwzTiRQ9sEUwHTwqMFZuRUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=EoW6Fc+Q4vJcb/scjylrIakaVWrk6eQ7R0akCKO3swU=;
	b=rJ63P4Q3iYxtC8eRZNIn7r2YTErbZilsiEYPa4HJRjfTMNK6XJNTc1quL3KZJBpYtHnt
	 4Ktm/rPnEMvYsqgNW8OVBHmhcYY841cy3KRY9Du3ELEi4PFzAdW9avSyPbfpCtrVaz60w
	 xrxkdcORdwKKejGMLr601h0/uDqC5qa+zV+8j6IK7ErWDtZTYrIk2DEXSuWrJr0PNeeiZ
	 X1b6GkknXrTC6A9ue0J+SjThwQWQ/wlgAHtxANJsZrD2I5nk5F0QEByfPgTKGWnSZ9YR1
	 ChV3KHXRZUb/f6Dv/ndcUuaiJC03tcsnlltidGspgGKGo7527V37PTqzmGEqBH911TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XQouLIkm;
	arc=none smtp.remote-ip=74.125.227.139
Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1444606A31D
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 17:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1444606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XQouLIkm
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-3ae1dca6bc0so630494a91.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793381909; x=1793986709; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EoW6Fc+Q4vJcb/scjylrIakaVWrk6eQ7R0akCKO3swU=;
        b=XQouLIkmjjIbQtl2AB5ZG9lylmU8nhd4x06gA5H3Dg2o8TGbD91XfJ8zmdKyg6WEQj
         VTNTE856maSNVLT4CiKfaa57Zz+4e/N4R97C4tNY2DtRLOk1rk2MuWOP8+U3aNgXOCjb
         KafuoeCTOUxvtpA8MWYS6qVuAftb+CkbJxUdu1/PamLvCNItdLQicYAfMAlKRTUUCRIg
         Ei7f8+u7lwtZbfXplmb1RS4Hj9pKU1NHpL9N7q+Tg0O+34P7ISWtTFYIu5rWgWhzd8Br
         8oulUFTKjxpAOWH4rKy45/MJHuihRSaaxDx6wfleMHOsocP6+xrjw4enObQ3iNxNq6wI
         +TYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793381909; x=1793986709;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EoW6Fc+Q4vJcb/scjylrIakaVWrk6eQ7R0akCKO3swU=;
        b=HJcrFCAc84v1F+KEYuTP2esVHQzY8RkFV6vDegCKCiYNB+/dXZA7QhOmFHlk0JTW+X
         vfP9YCW9/dbn6w9xiyVBfvfHGNFahXX+puiJWCU+N52YLeIYFW02ThdbxUDNkmqklwXo
         rcAagRekAP5lsLDiRijnKFpf0/vZHEyG4X24D9tpDYKiM8YCw/RqIv8qWH7Vpf54WD6m
         NprKIciWR92oADulyzCEbAxron1QXGXJJZOwNW+893ySRkl5opCJ9p3A3tyVz4MwULSU
         M8ss6c6JAYxndfb15bPI6ihR6mHH93ykFmLP2v+RW4/gu9qGfQL7OoPmeowx2AisGLHT
         YI9g==
X-Forwarded-Encrypted: i=1; AKwUvBzZiS65Q+woosGvfXygUhCiy7zacbgacHl3a8knPe6OnNUC7pnAscHjIEnDudmfqwvIwgMzZcg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLzF9nvDCHWWGBgKVMX5D2zI8h3B1oyOnDAWe2h9/8vMi1Yfqik
	ZYXZjud01fwt7rA9uIDB2iWsWUwNT8K7nIP+YX/1Mf8jeSHhrbGzm/ieQitiqKP1orPlCw==
X-Gm-Gg: AYBFou1T8aqhYL90an5chLSPhs8jteNoBflKRT8GGoC6RDpfBxHF3JgiOiVbhYQZTV0
	yDpBaHZK6g5Y7zGNHAY0ZPGnDb4AAgfmASaIaKVYxSkITq+Ib3gm7yMgiDAEyLmJvd8PaiQqE6O
	jbVdTs6JqX2SZv3Pobvw8Y3eMt7Yo0NEgzEt1NxHf1lGK+BrHk2Q4dNa6u2KL9PixPKyDfhq0FX
	IKtzA9xaBWsQlopTIzFIgetbXvrDM45EPHbkDjLXmOcCaRBzk6cHsd+VoB4B2mXFMbknc99mjxD
	jDky2ji9a5MDLguasELcMo2YnddvznsINJHmG7mdDocdZhOo7D7C/38c5LEgwBLKAGVWeZbd3QB
	suInWqaTcVhuhNbhyHFVZDGDzpYnoRj3EtHfXAWbo7nlciWFasEZjlEJpYEzJWmMOI9Fl7Rg5xg
	ytJ4ISxpHJMN7ykd8rnRMtyRu3LGUewxwqbClRfmB6cgugqhjJ5zNoNU/8XwXY4HgcNEDr/QKNO
	SrA6qWB9RxsrRvb0JfU4Ygri8GaMwFoky1tPOptFOHwJji1S7TCnyCy7pHzLiS9sW6eRlbnD1kI
	YjnUzca28xCRZcK6pfuBo8IvQ9NIP5HmWSxdiNkEoqCHkg==
X-Received: by 2002:a17:90b:5868:b0:3ac:945c:7f69 with SMTP id 98e67ed59e1d1-3ae8980a25bmr2636860a91.66.1793381909231;
        Fri, 30 Oct 2026 10:38:29 -0700 (PDT)
Received: from [192.168.43.2] ([119.234.99.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae84596e3bsm4964258a91.9.2026.10.30.10.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:38:28 -0700 (PDT)
From: Zhou Qiuyue <n0ps1edzz@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, David S. Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Hangbin Liu <hangbin.liu@linux.dev>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject:
 Re: [PATCH net v2] ipv6: raw: fix use-after-free in rawv6_send_hdrinc()
Date: Sat, 31 Oct 2026 01:38:22 +0800
Message-ID: <179338190237.9376.13820542101227461550@gmail.com>
In-Reply-To: <20261030160532.4832d994@pumpkin>
References:
 <20261026044808.613-1-n0ps1edzz@gmail.com> <20261030160532.4832d994@pumpkin>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thanks, David.

Yes, in the redirect case it passes the old rt->dst.dev, while skb->dst
has already been replaced. That changes the NF_HOOK outdev, so it
probably belongs in a separate fix.

A bare rt6i_idev or dst.dev pointer looks unsafe, since dropping the old
route drops the refs they rely on. An explicit hold/put could replace the
RCU lock, but adds per-packet refs, and doesn't avoid the deferred route
free. As far as I can tell, that uses the embedded dst rcu_head; the
temporary rt6 in this path comes from the existing HDRINCL lookup, and v2
doesn't add a new alloc/free there.

I'll test moving the RCU read lock before l3mdev_ip6_out().
