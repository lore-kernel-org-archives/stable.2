Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313648;
	b=RL7ZbCSVwsOUECFicDT+fsinapj9FuXA1DuinD1GSYBJVm9X/Lj4c4c9WM617t2+mEZg
	 4tN4v2vImMik78EwIO8HYgMDJRPvNlhwG4dFuayaAHp9lt/pOU7kW3eaxp1QBkgWqKq2j
	 P3Dc9crpHdbAiGGCYCzYe/8U6TlGcr1Do/EnyNHkO3N5FtfJKS/ohdvrZ9lxbGwWCKAWS
	 WNyy0F8EiugFBUzPAt00rsWniTplI4isRlGAShWN5zOsVlOIgkPZ5J/Ge8SJaOuKVYvcf
	 aKpz4g6fdIMmIpMuv9xB49uXQKvCsF2w0wrPenYvJnNnQ6S8S6rt/RlM9pn0lzFp5VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313648;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=v26TLKrWvhVgWLQBFxdA5doS6zBCcx6klRRGMpDzDpQ=;
	b=CqrFYnc4tyiAM7liBHpZkFk2vD7zHukfUIAydaC6W8lqz4NNPPxlWZOUSnyjhrxbAdG1
	 UvcQfgjPCeB/nQqC9uULRtoBdDzl8hzGaxjBB1oX8LUhxYAcsYBxwMVDKVhZgF8fFZCZs
	 15bAUb27pr8fiW2r89m160v9DvhQYg8Ysuoknji4bogV+M0iZwcQRTeFwrkeMKrweYH+1
	 yNqhdjvpYD54RQTnddw5JZeO60qJZUaOplHQ/oTUicS2NBLlmptfWHDBlYhFj+gy82kwN
	 d4bTBLfqSKV8y+OJknSld+4ziC7YjhilUC5fZJm0oqkZ0kcAQzIpYly8rA7LQ0q9UuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HoGP2nR5;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AF6606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 22:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75AF6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HoGP2nR5
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso647525e9.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 15:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793313642; x=1793918442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v26TLKrWvhVgWLQBFxdA5doS6zBCcx6klRRGMpDzDpQ=;
        b=HoGP2nR5HnnMREdHMmKLvXlJ8MTuqKsOFRx/lsPQVihkPjTkdxtrbcPTGdJogArE++
         gS1jk7/zpISKJW3LOSu+IC6Xr4H+IEO/h11hg+rnVy1EEoEvHdz2n1YGscTVT5IJltWa
         Zo7bmfcQDSNDoeC4p8dmRgYgYkMZOnHEIEvbY5fywv1NhzyId/5XGTosysU25Ku8Zzq9
         CuMgQAAwBDMwqaUVvbdHwYlvfNq/rGLbQlAz0RzGxv7dr0tyxyLckapmeBee79gdzeBJ
         Z7KwK2wybM5BJviJt2alV9iPY36Nx4LHT8LgdHLflIoiDZNACbWhvL4gH5IRJjeEsJ2D
         Zz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793313642; x=1793918442;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v26TLKrWvhVgWLQBFxdA5doS6zBCcx6klRRGMpDzDpQ=;
        b=zkRJijErJot1Uwg7WF27cz2xoh9hMzTQOgIdqcLr/gDKbyRZNjPYZmI7bKg0h6ST+4
         /NklQ4pjuSPWg/N30vI5sDuEk/UDv4yFf9R7QfveiaI6WBzWWfsoMVHIl20pjVhePfMS
         SpUGiUm7fywo6H+0V9/PxpI72l9N3waFSDQ2jROX8g7Vo2y8czzkIEaH+xdzKrMWJDF7
         A942BP6JEfikBeSyTUxPE95/cJhmswqh7Gvr38/8pwI5ZuAGmZfri0B0/P8ZUJ/2zrOI
         m5DHEnkUD1fXJ4SjDePNhp7en4PRS3ipNwlFZR9WMQIz3rPTs7IksA1aqeBeZ8PjCg81
         RIIg==
X-Forwarded-Encrypted: i=1; AKwUvByn8MRn7UwFv8ek7b6jhPDeT/s0mgvtQQfZ0doHlqHIaDOGaK6PIaYf+1hG79NH7qfXaSEU5ME=@vger.kernel.org
X-Gm-Message-State: AFq9FYIABHs9Qdsur1aSKq9aYClkBV1gcKKumY6J0ALxscTkMZC8dQJQ
	ygmNWQKt4bMDKmJjUoFGnIujMjTUxSAgtWksFa1I0TPDVFaMSZn4RN+v
X-Gm-Gg: AYBFou1qaIPSd89uCDuBfDnT3CC5RftQ9Bw5/sb1CX8LxO7Kfc3uBio4DTRZiqqiEJf
	Bsg+SYzXsTKt8NR6Dv2I6FHen/zeaQ206BLs8WyaDsPBG2h8LWObgztKJ9jzE/4u44fJIB7rkjj
	Ej6OqNQHn8qmZNux7WzJ34RjBYWEatCjSEzQ+582juowMDDJuBiSqYQ6LUCn0rh2Mix2CvxFCbz
	4OErt1dvuQvopJVDs5j51SN+fdaEtZ2gVHWyDSOYVFP7fxrO89Nc51DL5Vssr3GyacLzNPCjt7Z
	Y+aahrWXp7YKtHFsjgfW65inShi1GCD1F8ciqjkmLyvn7O0tGMQ5vFf5aiP8BSuSXsp5jxxcLIB
	WJ15wlaFk40cvVZI+52nv1XAjCpbaVefHIiGMA6CB42gyzctPOXTjpP6Y5VulGww1FiP1gPr5V2
	y3WAOIXtkzfNsqgFhxpYKgakU/Bq5ytafpd1T9Fp1qKowmd2jA3jXYoWu9Rb5a6AJ7G2tkygX+m
	/csOU4P4wOQ9z5ln4W2wDwMI4jyaBPLnj3c3dO5yNqeNcWLj8dPyhIfEh9NPfu1CFP3C2NKghqR
	OENEPYtLUzuDTaBR2o1D1iptjH64ijiDEuPNY8g=
X-Received: by 2002:a05:600c:4e13:b0:49c:d019:70c5 with SMTP id 5b1f17b1804b1-4ac1228978cmr8730515e9.0.1793313641519;
        Thu, 29 Oct 2026 15:40:41 -0700 (PDT)
Received: from [192.168.18.21] ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ab69b54742sm91144645e9.15.2026.10.29.15.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 15:40:41 -0700 (PDT)
Message-ID: <14736869-57ed-43df-986b-8b24ea9772dc@gmail.com>
Date: Fri, 30 Oct 2026 01:40:39 +0300
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netdevsim: reject port addition and clean up ports
 after a failed reload
To: Mina Almasry <almasrymina@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abini <pabeni@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>,
 syzbot+88435e204734072bf39a@syzkaller.appspotmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261029145844.231018-1-omermetekaya0@gmail.com>
 <CAHS8izORg8OR8TyWBHmZsgFBtM3+qh7gXCJxifk1QGs13Q=ygw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?=C3=96mer_Mete_Kaya?= <omermetekaya0@gmail.com>
In-Reply-To: <CAHS8izORg8OR8TyWBHmZsgFBtM3+qh7gXCJxifk1QGs13Q=ygw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



> 
> net and CC stable for a netdev sim bug is extremely overkill. move to
> net-next with the AI-review comments fixed, if any. Thanks!
> 
Ah right, I thought I should put every bugfix to net. Thank you for
informing me.

Thanks!
Ömer
