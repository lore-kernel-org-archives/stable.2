Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256244;
	b=XL3ZCfQwU3U0NRgyMYLUpeXCb/hadEM8mCwSh7j0uYoE06gRLMPUzUzdhs64skq0lwM1
	 mC0OnAUDs8QWeOqKB/HLMBC+XZ5BRjp6Xdoosu1wrL+MiPTt3IeI1PXiNSdSZu352LBPj
	 SelTi4gzGhosRytg3itD0G8ry7Sz8+BUX2rp6U8QizJajBcANJ7IhoH/V0rNwjV8NCOHT
	 p+d/i0d/NtgFVlRTgz/6ufLY9tKYH1kN0RHYkwQ7XLnW14QhTOGtvUsdyodvPLrWVgz54
	 kY2kX7VJQVG6FniKMlmQCKHAPNZNIKJYEkCE+pGfXgzUsufbLRZUxpLhePiUmjwr0yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=+tMX62hpYm7986gg5n8urKNYmz9FWSZU4tmvG1SnovM=;
	b=cftt47hKiKztAyEv1xBOyxriifk3E9qmMfu+4HhKqZ9U1vb1LdGeQrCYIJLJXriygKnc
	 s492H6QXQ+Y7yNx5Dxq4P29NrMm0P8nI7icO2g3dwnp0XPGK0K9c8llHW+8qTnj0Q5Y/c
	 R5tT3c4xp1oUydAuwEX8FxzQgSub0TRLic7K2c8tiOsg3l6iawxI6M0/1vY+m6FZ4ozOp
	 wr9ipi4s1on604nvR9Ym2sx4/GSoTRjN2XmJznZXSzAwzOfzxfLzmBUbpjkjNMHkkT976
	 1n1Y2NNiOI+Z8mnhMBeq4Q2cm4dAjMxMvZrBZOe3WhGH+SjmqZLjGg/F0jGWUooPQRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=VEhyVY7K;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90961606A325
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 20:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90961606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=VEhyVY7K
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so15953565e9.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 12:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794256242; x=1794861042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+tMX62hpYm7986gg5n8urKNYmz9FWSZU4tmvG1SnovM=;
        b=VEhyVY7K42NAxTw8H2+GjeVz4ETJMueGbExtxQRoLg3PbImG65GKtXb+CzJOTr1zRS
         c/R5pZGxgciPVhJInqhITwICQVjnQsI6ez+h8kRKrSxOYe7qHB/26wEF4ujKkYKiC6Gy
         RTPYbtH2ePG5GJhLQsEGOCv9XjnmeiL+jBYMwfpP8c9U42loUfWhJiT60iBkjfyQgZKq
         1j2J/6oAbhvyWK6iHS73Vs/q1iF7C8E7xbcQ/w6tL8H8YCC0NdJ6pJtRosg//YNp4VB6
         efa1BS8wFx5YYiJtkxAfoLJxGeKWfEGsw6dQ51lGZuyOUZ/N/ksb0WtujasW3qct6ayq
         dS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794256242; x=1794861042;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+tMX62hpYm7986gg5n8urKNYmz9FWSZU4tmvG1SnovM=;
        b=IU7S4deKmf+TqodzCWcWJMMunc91vP7L3UqsJV1gUUBEbQ+r7GFJlcG1GrXYbUGJD+
         jexFek9Gan1/2uLkvIXzeClc3IaB4E/sbkWB30Kj+3ydId78hHSpD1/kfOqLzyZfbGc4
         3VeRNcElVBqSAnj7dVe+Onns69fBWvZwo2/5KHgV42+e0+74TFaqel0/5EOZaAScAF73
         UR0dvyEA55n3b91+Jbsd9FfjT5m3N+twopYXWKcuzWxmkzjhqiuT/aH9Outzfn8qI6dZ
         K9564OMsgLDUVujrmEAIIF5i47OhNvjopM8OxErJb4iEz2RB5kaGR+Qk4eaj/J1pFzAi
         9tWQ==
X-Forwarded-Encrypted: i=1; AL+hErERf4oH4DjH+eQO3AZ7rkCVv5gL8X3zsafimd89cxwljABjybXOV/MjAo31ZfmNv9yqIt/5X/k=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qurM2Df1QPaTPqvvYQe94YR4V3r/0yTS8D08UldHYRTit7Iy/
	Gg+OgJQ0ulZWV+yHcjxWdBqbceP4h1RpUY7+dPt3lknfe1yCCDvid/lizAFaD44ATkw=
X-Gm-Gg: AYBFou3VvtMjs1luiPchwE6uX7nZW/AaXqA+CFkYH/Gte1sfvwxkMzPGqm4Z1sJ1+3m
	phMYSM8qYnel7KgszR1tWYIUF+cjRBb4qi9OHY+5Qx9APYGj04FCvCMjbKTx2NwWtjblwxK21lC
	JBAaSg56KmFRM3kaZ8OXnUbfGfRKNZEA5srEV4KYZyDj1BJmEdMk7eVSKq1TkZ97KV18EOD23Bm
	B/hNURHNsJq6wxrGXS2Sexv5hJALt2FLIsaxGvx+qI95gm5Pnuy/MncQk3P9UZxgzrXrlwzKfV/
	71WmDwggQyv83CfWuN3+Ej58PZlrwdv0k0dUlDxgdAvY/EF7AgHCMBKTNsOf1OGLGJnZ/jpJ+v7
	Lgm5ZVNy3kw+qEQuApBp7+bqnajL4AcMba4K0W4pgzJP+IR5xQ7tckQvHs4YQQjESed/NfvoE3+
	k97ITDAyaaUPJfVxpaAQRfTNJnuYZS9q1d+ufi9dlPXbotDTs9/SqDZIze8/X4+B5b9+hNArdxg
	g+sBaqmtuDwamRS+No1i3s2YCyMWEqM1CNDG/9+BYeiTX4jVHlSbwUw/eucjQgE+mjQfkLnAocV
	9DUH2UngHmsoHK1UYDqWXmM=
X-Received: by 2002:a05:600c:3d05:b0:4a3:598e:e7a8 with SMTP id 5b1f17b1804b1-4ba0230519amr6586835e9.4.1794256241974;
        Mon, 09 Nov 2026 12:30:41 -0800 (PST)
Received: from [172.16.0.229] ([159.196.52.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b16769b589sm831706a91.5.2026.11.09.12.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 12:30:41 -0800 (PST)
Message-ID: <70aa1a4e-895b-416f-a3cb-195af489b55e@suse.com>
Date: Tue, 10 Nov 2026 07:00:34 +1030
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
Subject: Re: [PATCH v2] btrfs: reject refs=0 subvolume without DEAD in
 SUBVOL_SYNC_WAIT
To: dsterba@suse.cz
Cc: Cheng Yongkang <teel4res@gmail.com>, David Sterba <dsterba@suse.com>,
 Chris Mason <mason@kernel.org>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261101062539.1744605-1-teel4res@gmail.com>
 <a92d223b-55fa-493e-821a-e5acc8afee08@suse.com>
 <b4962b1b-bc5e-4302-8456-73b9b8a6474b@suse.com>
 <20261109184712.GF4186782@twin.jikos.cz>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJq3ujyBQkUpLw5AAoJEMI9kfOh
 Jf6o8OIH/0mqW+TQM4m2x3hCsnK+oB4yJH1qnGvIhFF/Lhs48wI02sGh6/4aA0hkCDfd9LHQ
 +ci4FUepZ9y4VS01+oIExbg/8ytzGYTzLtb44jK2GBOBVSJkMiha6jp22XFt7WUkT/tvbreu
 WWdGsaJIRQaZChy7xsMI8lqQ2WdmluZJ4LT0wD3l/l6QU1ZseMGySebdY9sVOQEOJNV7Qj92
 /KOAFNmeZshV/qDI8Iw1RTs6TvLqCcqmlZLCmJkYSVhT1RonWRren8xIRcFEgMe004IDnt7V
 qdQhk/nhTS9x9MBAhMRl0TTE1VKDLvVALsud3iZLrmmtYvwPApzGJk052f0m28vOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJq3ukKBQkUzDspAAoJEMI9kfOhJf6o
 SNsH/1ysUWOKmzY0rGS3ZdS61QgqMGhSWD/EJ4UiPw+xO4l4+GtX0fOAqxqsmBKqje3vyhBa
 Z5o/1Y+gNiN+E6RBcSz4b1TAd78sQ2bvT5DWOvBjeeVxHdiuQMIn4S8xk5ZpySBw5ifjoiuL
 0M33UVtJOzM8yfAeL+d/Rp4leJw72SutjkLyZTG/gJIp4pJGD/kFHn24OLL0IxEcO0gOekNZ
 os5e1R6jAJ2ILk7+MDnvU8wXHcCiVzuDhJLI1tih1uUIE50muHQJWbYuVBbdJeu8WlIDDssx
 UOCxLylNG3gDXV5MhLubPTOpp9OiFc/XC37nvkgEcrlmlOFBv4/NJCbECpo=
In-Reply-To: <20261109184712.GF4186782@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/11/10 05:17, David Sterba 写道:
> On Sun, Nov 01, 2026 at 05:48:21PM +1030, Qu Wenruo wrote:
>> With that said, there are more problems with the ioctl.
>>
>> - No real user
>>     No one is utilizing BTRFS_SUBVOL_SYNC* flags. Btrfs-progs itself
>>     doesn't even bother it.
>>
>>     So all these fixes are very low priority, unless there are some wild
>>     programs utilizing this.
>>
>>     But even btrfs-progs doesn't utilize them, the possibility are very
>>     low.
> 
> Obviously the ioctl was added so progs 'subvol sync' can use it for
> non-root users. I started working on it but there's a problem with the
> behaviour change between the user types. Root has full access and
> reports the progress while with this ioctl there were some problems I
> don't remember. The ioctl was designed to emulate all modes that root
> can do so it should be possible to get 1:1 output.

Are you still planning to implement the full root-less subvolume wait in 
progs?

Or is this feature deprecated and we can eventually remove it to reduce 
LLM bug reports?
