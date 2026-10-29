Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793288868;
	b=xDKEPOxKYAfXfPm5ydshoro9UqxH1NbrfmGdtT+0JukHX7CFERJga3e/mRHyYCcP2oxO
	 xthB2QZPgQ3MTUkC98KUn1KdjmQJcMNRyNsJ0j0d64gODNOZ0c8HCK5kOsdx41EPYwqaC
	 dce1zDaCHwkb5m8ncaZjH/2+3dKtQyEr6AR+Hsv+Rc3BXyBWmaAlFkp7164CPSfGHjjuy
	 3N9HtQedMtmRY2G7f1nJ2cXMl8RdBbE7oiZJWCjlArqu8JY8Gjbo0I79Cokdb+BvAckr9
	 3emqEkxw3xYulPn0R+SstzB7ViSJVe1vLUwBEdPn7/tu7asLq7RfDVXZ7J86Lvn7xdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793288868;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=H4ycqpfgZiGJ+RxRGCxitL2+CHZwQ6ss7LXiaKzsngQ=;
	b=atAo5BNAvhC0rEvRbYiux2pS8wgb0YnIdzWKBv6ZU/Ui42dNZDWAWk00lRf87m4g/mr9
	 mytiRsKXYtLOSRYaMxHf1poNOF8c4saGLJctmuWYO6DJUkdWklPVQ5b0/EanGMYzliUyr
	 1EWF2LeZLiFb/NoIAO1Dzq29gn+zurKlyCNy992h5DAMixnvS6NNdxsq128/2H7gmbqm5
	 Gh52J3USlXdIzN884U0MJK1zC7+AUAbVyov2/rriiu+F2E7W4WQx5bGVErBTBXTTqduyO
	 LTNljSOxiMX4qT9a/GHnbu2JLLg6LRdzPZ62/znSbP6WwRsAxwZawzQcLOVCUfrrCVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=VnRXHPfi;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA29606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 15:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEA29606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=VnRXHPfi
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b4bd3d98bfso850104a12.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 08:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1793288866; x=1793893666; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H4ycqpfgZiGJ+RxRGCxitL2+CHZwQ6ss7LXiaKzsngQ=;
        b=VnRXHPfibvPg0GfqszpAulWOh1rYDt+FC6k+McKwpDLTJtQtw+4u3F5Fz0DzGvSlAr
         1jOi5PGy3JuOOT8wNqwh3qcRrkMr6CS3jBKxdahmQtHFdEXTi6uxY2+2+mni4RVb1ZhO
         Qb/FBl7IEbaSmf9co/b9zFnJcyg8JBvy+IwFDSI2LipHSslrYM1XiFy7B9sHvX8CXm83
         mj88zxoYLCHXJR7J2AgksQ43ENCQyZKWfnSWTjMtl2fFVQpEKS+oLcCakg18fG2JYw38
         FmZOmB9AJPYLsy4NclUPIr41Cvq5tRofiK5WNKn5r3ThUkgFBJvWlAl0h6G62NIcZn3t
         nmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793288866; x=1793893666;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H4ycqpfgZiGJ+RxRGCxitL2+CHZwQ6ss7LXiaKzsngQ=;
        b=oAQYWgDY/dQOes8hUmyvDG53Iz3lisKP8e3C64/67j5/C146M4TcIJXxB/RdPVDyjr
         omfJicAa+f2S5rwEGFdfKKyemN3fk6Rec8XfuyYN6uNPP2CkW9/u82/7WdS7pNRBzw9B
         v0jsj61u8DCh4z5UDy9TJEcPjEQ3QbvQh4eZX47Elc/2uFPdOrlYTgf+/jlGgAAcssbG
         Xwy2DGqvb5OYSCL1nuxe55HKXkeOztV8GRS1pjOXYJmmC102kuljnPtnZYGCSmleVtsl
         cCHkJO8VWfpTMWxhpmyYgQPdpXiwf/tIqw30sfZaMFcNhD6DkvWbBpPkbDO1/q+1OhrB
         YefA==
X-Forwarded-Encrypted: i=1; AKwUvBwtXVPFlUHDS/KAJh5xMSt+c4txH9B/bpu8QLN9PAeqWdPKpw6AEY903A/yLDI8OomTYdJ+vM0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAAidTISc8oxn3aULulQbr6NtDStiYdyTvcrpuSK+N4xZShrOQ
	rJdTDR5Cmnsa5v9C9dCwsgS4woyQu6go35WIe9yFVjKXjE3eWqMT+Ek=
X-Gm-Gg: AYBFou3pqdHg5QJCab632iUbGwcY3UY4M9syWyuHodmZYBVAWF4eSikPvToHT0n9R0g
	9b6jHlkiZiBUsJN2/9U83fdWAhPpAgtl9m5topV2XmFj9ey7yKSrF7Vd3xPnE7OBZ7L9TdDRzMV
	05H8omVYUWL05msa8E4bL765Dv1IacCbH84dAmCkpu9Vdq972EFI/HzuG9Gr3jFlT0QhTM5n4+J
	LKt12mOujRjjUMLsip3rpqXqOad51rBaJSNH9sbyk10Pquh4gPHk6azTh3ZvnfmYcN4vaIys0XZ
	L2OYzvHvArBusr7/zgu50vAsJRX1jy3XQ5zGywaJhU4LuMFFxKApq6SJOvp41BuVWS5g6g5rYUd
	DCOLZzTXVdneABf13uazPqW+vS5/QP4UA79S1mps+nIbSAyhZQE1tl9C3sBRfTC4IIc3DMLaWAB
	FMhdXLMmQSPHF6eQszyCKvdIlk87vWiMDyN3pyWyaREBMFK+o3R5XcibsSQ8dIPdPwqW+WC+HPt
	AIfyMrsEwBSlX8U6VahEbvfJNL6KCWx3P+0pexgYkvca0VkCg8/NxSs8Ze7KgCIUmJTb021BIhM
	oiS/8AyUxtJ1riAcoVnScz0TvVESBTUaCrL8CbGzErliAj/8l7sr3v3YEmfZEILvYDIH+BRc6WO
	J4e7TPA==
X-Received: by 2002:a17:907:6d29:b0:c2e:3f49:df04 with SMTP id a640c23a62f3a-c49bdb68d6dmr521364766b.1.1793288865850;
        Thu, 29 Oct 2026 08:47:45 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac3f1.dip0.t-ipconnect.de. [91.42.195.241])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4ca27a05f3sm6802066b.81.2026.10.29.08.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 08:47:45 -0700 (PDT)
Message-ID: <f16d1c32-8b05-4046-909d-ab7c9da92464@googlemail.com>
Date: Thu, 29 Oct 2026 16:47:44 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 0000/1879] 6.1.191-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261029073135.159947193@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261029073135.159947193@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 29.10.2026 um 08:33 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.191 release.
> There are 1879 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Just like rc1, rc2 builds, boots and works fine on my 2-socket Ivy Bridge Xeon E5-2697v2 server. No dmesg oddities or 
regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com
