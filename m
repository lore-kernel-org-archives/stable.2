Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094880;
	b=4H77G8g5WvUul5bwcR+slUhYslm61XAvDHzk7kw4TgK9XVOP7/Un2dUkGxPPoRjo4z2Y
	 XrOeVIRt4DjCgIDO6XjmCjas6bSUHP8ud7GYVEMCy7ejH4WgyOAR/PBp2ccIOhA8r1F1/
	 V79FYd98/hDI2oHzpliwklmyA7wPO4Q/a1Qvyoo/iOkYob1XAOKz+GEZFuUx2PNsKCfkM
	 cacOQbZpd75iFUn9lmKCWSKyvwBIdFqvN9/iXf4EfU/6LvgExNFDmSHaURnFgWEw0acFM
	 5e3qMkANFXmdzDBp0wyRoN1w4dn9QPpSpF5fqmfTC88zvjnBJ+32A6Fg9T3R/XI72ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ipfBmA3cDTk5OYUp61WVnNo/Zii0SGp5r+OHgfJ85R4=;
	b=HngxRR1Q8K06+MjzJ6v9uA3+f7zbOSrY+bbWeaoFBbCBMvLHwlq8m8G6Ie2BYLO2OaxW
	 McX08tZX/LdDlR1fqTICOYcsf9wfnm28LZeRKGonBJGYlOW697y1Di2FFKiTA6jppP1jm
	 JAJ65Ly7fBdXSjnVmzi55Fk7iEeKI1Zb+KMH4FDT55mUu2Zdro1ln68m0qB2wgxYUfpfu
	 67IElWEfZhm6Y+qgpbkOipbZyjDasaGPFxJLDgVWNBH2qO15/zy1JJR0F8vfVJSt/XRZV
	 0c+XGJp57yTf4MXrNGA8E8ka16sD6YryZc3hJVRWK3zDKsXQpZj80moNfXP0hHFMJSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b="d/dMV9fH";
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4367C606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4367C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=d/dMV9fH
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so37461115e9.2
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 02:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793094879; x=1793699679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ipfBmA3cDTk5OYUp61WVnNo/Zii0SGp5r+OHgfJ85R4=;
        b=d/dMV9fHgQh1MVXWDT8iIQIwolMQDjth9gFydBAVFmHuCSPqPHx15xZo8X3l5ZOtRz
         Py5RWx3Cfxf1T+WdlFcud2UM/mgRKTYUou4YwIi690kBz9vh217jqPzeNRa73don2NPh
         7ULIKiPkcMgQr15lZYA63akmtICwa2o10FvVx7Qaxm9gsxgDD7DEj9j2NUAZMFSbCkgx
         9pXySLhdBC1gnZKY29/jjCHinCIUby86kN5TM0brIK7kHT3MivbM/P6NiRhjcgWFGru+
         sFzMvqoqmhWLRryy+LoT3KZPZGwe767HRACiMkzcvTZHQpAuArs6EmZCMTUO4hVLQSJm
         +wdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793094879; x=1793699679;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ipfBmA3cDTk5OYUp61WVnNo/Zii0SGp5r+OHgfJ85R4=;
        b=lnDgALDEvyFS+3CDYR23dwvsgPz+MIkuc9HUgsuJxVgH0HaJpcbqZDQ3AShWtJPfj5
         uCZnehWwQFOA+6DQ85QK425wm7gRP05NJEhWWlWkYUiB/6yN1GW/58utEWSWCnr/Mn7y
         CwdJlb22zrjKuM8aWbFc+q2tGuEBQbNpeMFy32JGKRfTtgYJhfnewUgTw+6XpqRnJppe
         ZGsfeE8yaJzm+YhidpomZUK8HZZOa+lese9BMSfI82wynK3FBiS0ZdrZ6VqJmrZ9Jz9I
         hYJws3EAuMLjowq23pPg/me/5fcuqdLbdPuK2KNYJuFPA76BwDwTbF8YLiWvbtWaRyRA
         uXog==
X-Forwarded-Encrypted: i=1; AKwUvBxF+WOG1G6xQCzo7N7J1pSGT1RiqP/rZKr9Wv/qOOqFTdTa7yZmy7NznGpNXXFH15PjPGthUiY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKe6TJJ5VoW/RW+yFqkOHcuwPKw0qjWxHhIYZA3SWawn2OkYOp9
	MOeMz8nNpblagEIoCumwHvekTf80WFyn3XZ87oP/uw8D3lZcB/2CPfud60gaVPSmD9HjcaPkBR8
	EL77K
X-Gm-Gg: AYBFou2pv/CpXiivx5Dbe/qi22Yq2XDQkEo6ZKyMRP3gEOmL61gwzeFAACCtnjooHQL
	x+m2Y8MXmy2QtlpvURys03KK0yFoXPKRTosXglpRal4CiGpoaY2NsQcdBpUDYY90uvPKqRsXFJW
	hwATDgUsWeBKH+zXjHuXJ3Hbr6047+8M2sisFpNo7CSW3HOxokgwLOFWfqhn6XNeabnE/Lme2E7
	0H+24DhhqerrBknCG59hF8Um4dYTT5tX2k6CDvoAWctvpi4vn4ZdfMyoCrqEledHUOeiYCFtWbm
	1A6Rb6ds00l+2lVftbflw9gKz7Z5LBpayE9cFPmdUuq9onYW6rjlQLMrdc+JhOU9E3kguwKIr/m
	cTlN85zcZHfHrnE4gu7+1GmWU6+/BvSVKjL8TKJFXHDAoQnxS4VgdnP628kCZLC932cup//sXL4
	l1E5rQrucoII2fBdIVMIiwg90DxcgN9VZ/1YXE5vrgNZJ1poTunp8HCKkCrg0HFBZFVT8fArHWK
	ei2tLkiWwkXKvqq1NkrDY/ow0D2jjg9mdsgZD64y+ErPLyXHHwM4CrQtpetGe3iUb3aflBHZLq0
	70+eCgyRbiBB+d4xUDk1xA==
X-Received: by 2002:a05:600c:1987:b0:4a1:6992:f861 with SMTP id 5b1f17b1804b1-4a35ac3a825mr183181415e9.1.1793094878673;
        Tue, 27 Oct 2026 02:54:38 -0700 (PDT)
Received: from ?IPV6:2001:a61:13a7:df01:6e79:f35a:ab88:b157? ([2001:a61:13a7:df01:6e79:f35a:ab88:b157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3bdbsm17868961f8f.19.2026.10.27.02.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 02:54:38 -0700 (PDT)
Message-ID: <09633215-e52b-42be-90d9-12fee5b8728e@suse.com>
Date: Tue, 27 Oct 2026 10:54:37 +0100
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
Subject: Re: [PATCH v2] usb: uas: ignore UAS for ASMT135x bridges (174c:55aa)
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>, linux-usb@vger.kernel.org
Cc: stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
 usb-storage@lists.one-eyed-alien.net, stable@vger.kernel.org
References: <20261013221944.41598-1-olivier.kaloudoff@gmail.com>
 <20261014105700.19433-1-olivier.kaloudoff@gmail.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20261014105700.19433-1-olivier.kaloudoff@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 14.10.26 12:57, Olivier Kaloudoff wrote:
> The ASMedia chip detection in uas_use_uas_driver() assumes that every
> device with idVendor/idProduct 174c:5106 or 174c:55aa reporting a
> config.MaxPower of 0 is an ASM1153 with working UAS.

have you tried the new quirk reducing the number of streams
being used?

	Regards
		Oliver

