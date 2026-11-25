Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795608659;
	b=gxKGinlt0SI5QKt+0g3R3N4syzyGU7tko0lSb7II6xwyu9z86nOlfAhTqRbA7PjhrsnL
	 eSxxc6LK/tAxh+rUCvUCLhjQRL2/C9M4neil3VUH6uUybmQCxmNpH6GpgaGV81OCbDNLG
	 Btux3FHy6HT3SDO8Bg8/YqZpWhYKNZ7HSA2AirCUX5V78dsNoA8/zb+WOhssUeEcB7n/D
	 GjxgqS8rRqAr/VZmMq+5z4Eooqvzf0/ZUADoqk3bOl6O1t+QUW6CQSEApP+waTJwFMu/t
	 Cjsml7EiY0h2Jmynhh5IJtEVNQ6oUFWRPRlYR1o1DwD04KwNzT2pZKzfboXiYEYI4Ag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608659;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=1N96GBecg+GfJe1n2xMgqcFN0Pfbl8aGDYu4m8D5IIM=;
	b=VDE1jjV4t43XZ6nzGCqmvfrvA7vQHDR47saHKi4PC9j6Ur0wLiW9voaszuBLvUmnoW08
	 pjesgC0rHQYz772EK8UL3bII89Pd/yKmfJ2Eoj6XLVk9XDiPtjpXQKBGhRl7ff5Ha0pcQ
	 e3bbwP1he35YAWSgYo/3NqkvpRHDGThjEtkRwn0Y9KZQA6KHl9tZFCvcHrid/ofDgcgWu
	 TWrFvgyNmwqfEJPtoh0TPjVMBNtRy6KJ6I4a9bk5ByhuzylPElkdx/W+atSiJUWJn0klc
	 BiIO8cXfAoYiV05bmjQ2Fb53BIS9p2QYI6bQiPZEm9bRYKiAx05jKtpkxhjBGLI7XYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l3w63dkW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.67
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5768606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5768606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l3w63dkW
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-5c158c4c15fso6983008e87.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 04:10:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795608657; cv=none;
        d=google.com; s=arc-20260327;
        b=Aj8DiXeH6NyB99Zl1zFnm/k4F6dgkMVgZBeljZlN1dJmw5rhr/9xvXvu1T8Dk/CbtV
         gzAfTTGyyUO+7/CjfXH1rG6/S0FZCNogox2utdZpJM9aRkgGHLMtUmVjIARJ90X3FuzU
         MRN36OSCo/rjSeZnxVAmmi2ESgQ9WK2juVvp45ldUlWSGI9OVJgtn2B/67UOGxjoYxNg
         tnGxowMXmieBUqcPF14MdBunXvMIDOyso+Ub6n9oRUXktyXZTb2ikW0v7HtI+I2Vbv5s
         +T2CAEjHbULrSMWNG5yZL1l9tH0otlhEeBvhERQ2aALxkuoWdVE34vjn7l3Y/OYV8CRg
         cDHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1N96GBecg+GfJe1n2xMgqcFN0Pfbl8aGDYu4m8D5IIM=;
        fh=nZ0fcKdg9FcfDWi02159big1q4EsrQGceHXpK7CShAo=;
        b=DA6ztWmHjdRJTR9SOc52b9GZ4/5TrMEZC43Lov9irsoIbRS/JRN0m7/0DiItH7AeOT
         YIrubobiWIq/XPfzEF/8l1vTkb61UE8rvjZnkcIXCWg/aYl22Y0/4ejNiBZV5zsQuNQf
         pg+7YVp5W8mR7gJNK1Mm6C/U9aly0q3fOwFwYVC3tMo6GvYpDDHg9lF1J8/WTVv+Uaqf
         D5etLXBljCd5hlRDdVS062pF8SHGPbifxBomoRRFnKIzT9XdmgohWVt9SoaCvL4kR98c
         CnM/BnqbGnvhT9kOYeLceiu07oqRlNWv9hOyO5NDuJI/98okVQvqZZ564ZettVpnQspn
         p0zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795608657; x=1796213457; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1N96GBecg+GfJe1n2xMgqcFN0Pfbl8aGDYu4m8D5IIM=;
        b=l3w63dkWTAYqvjFynZS4xnX29jt+TVSqB3Oz/76l7Ut4ant2iq1JBmVWrwsKayCB5S
         C691m1mTzUfYB9DIfcn+WJpmxlcLuB6Zby4PB5S0Fk+MIYiEPXjCF+t7EjEefNdA7rhv
         Mbovmphlm6yn/82ldH6BiwnmJV0kyZuP6eLFzgRPM8AWuKUKXgWLwkbNGMt3yFusLoTu
         bn2cxWzghlhAVpOdR6SgG21IlAltobxaY5wgK8FuezGi4dsKOzx5xebyWzbviUPpCqy8
         XSDBTL3cgYQ+EFredd8zR1RHXHEbEfkh2H+JhiI/2I509k4M5D89k6+AciY908cGKgfl
         FLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795608657; x=1796213457;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1N96GBecg+GfJe1n2xMgqcFN0Pfbl8aGDYu4m8D5IIM=;
        b=h7X02NU3L8vJuJjFE5XQg9ADoCbHHpOXH1JotWdUapQkCFISdsd+g4n7IqSjK8+7Ya
         ccqYTaSYNyXmFoMlD/2Ubp7j8APuTzVf9FWX5hB6DOAp7J3eAulsI/Pc56X3urIH59tK
         5j9+r1ek/iFDyEHLEs5kMV0cbelS7xm31faZB1mHT5Z2K7h5LDuxftU4JvftlN4tDPLt
         ooUd9XKGET5SDGNsDDAaODKgIJ+lmtzJ8ww+SqSMzXInNkrOzrnMYegSegNedO9Dfe/8
         zyq0pq5uisjQnPa2VXn06h2Jq3Z8dbFOB1+ftHI0gc6CtPckb9MRL8bsq7kmxH+fOge8
         w9xQ==
X-Forwarded-Encrypted: i=1; AL+hErGxClKqeTtIW6cOWVEPIt65aJ77o+pL3r+xWZ9ox1614Mqszjd6X8PEjt5x3JuCzzlQl/4XZ1k=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gGpdLpRPOadibAFo2hgyliIOhBwfLTDLHDrXcESnuhc9DEQxc
	t+Vaye6eDGHZOOlg5j1R74L9T743xnuGsDWo8k+XJYpFdWW3iqCVqnTpZO27vnAmRh5H28AypgR
	nnA0xe0BSzokCWlw/n9J0sf52feSyxFWEhVOsjqQL7Sc8
X-Gm-Gg: AZFdTZc5mHMQd7XeStxZLRa0SvEa00U60e0ExDJdkCXiVXBv21plwwBspSKd8aNPgio
	MmjqKTt/uiFL7TRfuMLSPUSBww5pXEBpmZgqPk67txDhpoq6Wxs6vsejAx5w9rjxRIZe2jO5rRA
	PFDWTidCYXeqcwtqoEGSfj7e23+c66/KDBby+mJconwTtlIivKa0jvl7DwNATZ1V7hMHeNxGSIR
	T76bI4opGzNj/pYORU3hJSH49uSzmutk+WxNa1BjNdEmGYGNmyEoIriWh3coLiE0xlxsTTX13BR
	NG0MMWXxRKWlJuKKG/ZIAejOfrToKlBWH/+hHKXkrUSpBA2Xd50xktSn6+R8fCrutX7Y6Bl882d
	zrTfPo5oK/x6qzJwwzrgAIRdL+6jt3kSlnM9dEw==
X-Received: by 2002:a05:6512:234f:b0:5bf:d938:b80b with SMTP id
 2adb3069b0e04-5c1b7c42d5emr4912988e87.27.1795608656760; Wed, 25 Nov 2026
 04:10:56 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125074617.629026-1-bsdhenrymartin@gmail.com> <5f93ca8c-fe7c-45ec-9b88-4817d1b6a543@redhat.com>
In-Reply-To: <5f93ca8c-fe7c-45ec-9b88-4817d1b6a543@redhat.com>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Wed, 25 Nov 2026 20:10:45 +0800
X-Gm-Features: Aa3M54p_62Oh-dLFBbck65__MmZTYOkFdjzUBkAF1Y2sTJexzGy5dWx3cXJRTfM
Message-ID: <CAEnQdOrfsmhVfbznjSMf0YZhaiNVvt5WTqJAko6_QJ4toSCASA@mail.gmail.com>
Subject: Re: [PATCH net v3] ip_gre: fix stale header length after erspan
 version change
To: Paolo Abeni <pabeni@redhat.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, horms@kernel.org, 
	yanhaishuang@cmss.chinamobile.com, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is weird. The patch is broken, but it compiles successfully
> (on some slice of the CI) because the first chunk is applied without
> fuzz in the wrong context. Still causes CI build issues:

Hi Paolo,

Sorry for the noise -- I have fixed it locally and will send a v4.

Thanks,
Henry
