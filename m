Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794102263;
	b=kdR+pXLDZzVkL2z+q07gXzHPuSOR1A6ggqirZ6D2fNKTwdVTcIUr1ZOzjNfqZyy7pAIf
	 v4CtmGYET3mYlRodfBd/5HmcI4EzVS92cADGkMFzvg58H4bH8J0phldUrDfXTH/GckSOB
	 95ulTZ5aENGTQeouuu0mwoTJ/1xggDqovR0Yhzo2tJkW/KaczcBdLn81JIFhy2/QT3ydT
	 GabHzYC1bvNXbonryjT6Jj7jtqt5TMAbyjTYd792hLH1Y5ygZeac75zk5dvmmCXy9+LGR
	 PiThaPucSTsaAREms1PeACVdK2ZrrbDswzfS6yZO61rji5YIAGJCWK3sc/C9eoXUb2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794102263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=/ej/hUBV1NBOGVDMaP5rt4w8zmL+CLNc6ALzKVqxDRc=;
	b=rWAoPrJ4Xibn9kepY3RuJqigObYtyksaIL3OV/gOogIIqwLtsKyPya6mUarh0ohOqOTw
	 8kKd+48LzEUM6MTvWibLDwqyfEwvt1CpVypc29ShnblVUDTitYbxc+exw21i13NKyrpGW
	 kdP5RDIPM2XUiDWKaAIdZRXx4yKt3tx5qfXv4fjDiMJ+Yk25fyMQ1JUQ5yDAxI7E+jh6v
	 kvZ+XlPekhcVx+6yZeoP47LG3O+fpTU/l1CQkBKerbCFd5FKog5u1r5/wM7zNLeQbHT9N
	 R/u2ZLrEkm64inM6T1H850A6kADFU0z8FjymeIr0BUqJGhVpyv3nipx/rq4/CHutpNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cbIGgLLX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE6F606A330
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 01:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DE6F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cbIGgLLX
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36ca32a0faeso8110eec.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 17:44:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794102263; cv=none;
        d=google.com; s=arc-20260327;
        b=IqnmoB6o2Hoocp8nuYVGWrg821TSVUolm6EENghPAuR0fZy5bG6azh3TRlzv4jdCgv
         89iClY6Xh+zYRnttAa70TxpgRleOI0HrLHdM6h94aX4fCVlRv6pwP7i9TLYXIkY2Rs7r
         5S8cnIIuLlOJMJqXKJzXQ6Vl7lA8mQFgFETw1Ktx9dygrgsz1cNUVWNI5O4xWeNKhbzI
         uovP+/6/4aTNFmYaJFs0EkMU5lgYKjlKCQHABOFwnCZa7CDBEyVnsMK38dnNlcIKndRv
         xL6BonRYB1eLCEyltbHrujcybA3AdKJaJsaMvZVxNBBy9e73pHWdxyJebsr91zS43LN2
         SPYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/ej/hUBV1NBOGVDMaP5rt4w8zmL+CLNc6ALzKVqxDRc=;
        fh=9sbbNvrryxnb1RJxj440xWwXCOm/IHnrxblOfaY/0rg=;
        b=sL6LHpwqnu6cKA4upJB01Uybr/Nq9CY/XTKjENpb3Y4SkJ5fejcpchBiDTXAOTZ8W6
         RC6MN3D56Lp+LnIe2r9HQdNQ0NdvO85l8+hj0WpY0w3kUqC+iWMLnwcq8MOeZuWuuHck
         IJz6+Dh3YNWo40Zg6BaIRBP4r4oELdnApaFkG/deL0cNKSWORUB/kOPq/nC6p5kmink3
         ndiVP9/JLkhMyCZwEc2wJfEqGF/FS9DVBx8kmg+JGjg66pZlNTQrcpPY7v1PzoqnKb0o
         V/AFDa7dj9icZTorf121/6w92Bo8kfnxW4mMCyUWi/wq5zGm8+sdw9rbSFdlqLtESsyb
         wahA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794102263; x=1794707063; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/ej/hUBV1NBOGVDMaP5rt4w8zmL+CLNc6ALzKVqxDRc=;
        b=cbIGgLLXG2KRLPi7QiIVApc6PGg0pwg4gn+qxyUMVnHJ3Ous5ocE47XnA7aV+i6AkJ
         XPB4HNGRf+jjDc6bVkZ4vXFAOfa89gDKsiQvQFVBI3Zlpv74oBS/9Bgk0OeCSBxAz/Xe
         WGhA47loIodR9jFyZW/DdZ0EkRRhmo0ZEKySE+DTMqFQAbgLp2/Bb65SVOzkiWj7bvnw
         D8wKYrqzME/sambcS7TwI2eXKOc0nWAuTvT1ZzobFGfIUwJp+wjcm7gUKdxMlSvX6VA0
         3tW6dFHz1ld1nMsF1nrtTSFFc3OAOFU4qzGjMEQFYt65S262ES8EyJhntyk+5cGU+SAs
         +oLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794102263; x=1794707063;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ej/hUBV1NBOGVDMaP5rt4w8zmL+CLNc6ALzKVqxDRc=;
        b=d/IB4FWeoGY6Y+gfU7SCrp7zwIsH6zjYH8V3vbBm3K2J22jD34oH6JKnTB4FgtPXgG
         QLkTrjC8uKiSbaQW6Px2GSW1ZU/WovFHcFx1OzJkYfarAuZYC0C6bGOJ9HzSdIENKl0w
         ljHeZRsXqFWeCGpGfFlxPSaC39lYFd33fD5Jo1EMdhTiocb30sScFLkU5lenvxEdmPKW
         5kjaYEun5vzipeHV61Npo77e9cm0ODihwM/sDqgDkFYR2Mf/AuY8FTBvdM9Qpn8WBGeN
         AxtkIPP2oYNsuCSrsCabv+6MWM9TcuMHfut+K5DIoGNdhlSSLFiHERW8n+YqjTYyj8ln
         ZCpA==
X-Gm-Message-State: APuU4Z+ih/ahOouG6mhM/bti1yHs2+MvSVnFUSO1/SLi/SfcuDMrXgga
	/U23iiWospVQbcrrmUyaofN0i1oQ7JJWEl49fVpipnkHn1ytoi8GNUr1nFk9Og8p0cFT9JcH6Im
	9oLTYpfZ0NA+hNQtnJ4xlFuM1eVMbH68=
X-Gm-Gg: AYBFou0E2ueCMGvNZs+myTSpj2p17pYtXS5Rzp/uuYO0wTSnMjxkbBhzk/bbeqEMppt
	LKOYF5+e1jb9k0rzSfZVreOnxPmheyzLwDDsdulfZmftINLBO/0svpFq8UwBOhCsPMMhHCx2RIP
	rdLTESPO36w70sy+Zf3pO3/r+L/MnyEA1WcRS0Y+Cnly8068YGge7kku9iBHBgPqambJzg5X8Xb
	Muc0RqM9HNGzZJGZ/SOax2x8VdlSjI5fHmRaP7hdTMM2/YJelE0a9MPg/JJ92Glk5yza9EMvkN7
	BXfAzUCnF6P4JeIZZl9o5jTnfA7bgrOQ74jz/20ZB2VqSy7fc40tWv8py+zRM+YJk3v1rSXagMR
	zowLNOesxl26dnVdWaug3Tjispn6VFGxCAsAc67AwrUXGalNGCfHeLDkw1ptR7HFKLnIL65rZQp
	0uggEDHZL8KwaEdy4jWtqtd00Zj+cM1EUOZ7KpGWajuwHjYOCSL7HnhJerckTlx/SHRcDiLLRyA
	eubkLRrDm/1D0n/tyzXpBRRnw+0VnS3+Od3
X-Received: by 2002:a05:7301:6e8c:b0:36c:a1bc:6114 with SMTP id
 5a478bee46e88-37250050596mr1795949eec.0.1794102262529; Sat, 07 Nov 2026
 17:44:22 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107134957.653319350@linuxfoundation.org> <20261107135011.630471081@linuxfoundation.org>
In-Reply-To: <20261107135011.630471081@linuxfoundation.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 8 Nov 2026 02:44:07 +0100
X-Gm-Features: AclHuK9nmE6X3XMNIv0YfpIZ8wppVgI9hnqEEIeGEre_LeP13ZN6imhA9BOOMSI
Message-ID: <CANiq72kgADu2_hr0iK3E2+8HjBNww_b-w0K0_3Su9hCeLiMeYA@mail.gmail.com>
Subject: Re: [PATCH 6.12 0505/1536] rust: allow `clippy::as_underscore` in the
 generated bindings
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	John Hubbard <jhubbard@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 3:23=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> [ sashal: Added only the as_underscore lint allow, omitting the unrelated=
 cast_lossless/ptr_as_ptr/ref_as_ptr context lines missing from this tree. =
]

I guess this means the other lints (from the context) were not added,
which is what I would expect, i.e. the upstream one was only about
`as_underscore` (but I checked because it sounded as if somehow the
original patch had more added).

So it looks fine, thanks!

Cheers,
Miguel
