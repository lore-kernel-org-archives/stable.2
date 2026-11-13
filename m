Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597772;
	b=4W1OClLyi8JulbWaG5FPzsvkChinuPaTmeKG0g7duCfKStch38++pCeXOEz+2Jsk18oR
	 HWlxzqXSePrzKyMQqjmpXc5qamZmZMLxABdCzySKlM4t66Uznr34n85gvTYEFxfSWd5F4
	 rdhGj+c5rbcQTiKtX2+HkkD3uyfeto/p5nm16aCDVjjSW99JwC3Ul6qnlwCOsBLrlGJ+m
	 G3cRbdiSa+mw31qpD1H/nsdWzMa6U6om/QIP5qP7Dp6MLAgrTqj/B3nqSG3QOc4jmD/Cb
	 eiIX9nMWxS3yoU+Ri60fIwqJ3Ea14spil7gXkC17R14PO0rj+fHU8PKVxYVflOV7FGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597772;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=hG1EB293hxr3Jgg2QdT4ZHxs80rfcC0WBpvazP602rI=;
	b=YuqSZYh5dJ84+o6L1x+amm765lbLDH/t28T/2wJWE/8C1RD9cNVZaPJoEHnfj3+O6zB3
	 6CvKy3y0wAbjmwkB6bu70oFFGij3YihWpejjTH+K1UaQSWewxBYFL3j5bc36l9+eDg3aR
	 Q2yz4mLiuDBQVi5b+p/qetfkJVX/uD2tbgMY6vAX9+tEHfiHx/y2cyD1IX6GMR/UIqZUc
	 aDjF6aaMx61ACfjvIrCvfZKE+Ep1j94ImWO+1bd2T57vgSb3RkiJwVguP8IdQouTDgOCk
	 XtRj3dk4qxWruqW7/FDEp0VS9meqeZBR6/m12unMwf/Mke5fHNcgIFWV0KzuyA/gW+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YHabU7Om;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1A2606A336
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D1A2606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YHabU7Om
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so764203b3a.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 11:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794597771; x=1795202571; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hG1EB293hxr3Jgg2QdT4ZHxs80rfcC0WBpvazP602rI=;
        b=YHabU7Omftu3FhVQ7LIw5wOHLJ2zWV9rZoxp4VsZ6gZ1NUrAtNBjyNE55BVLGWVpCl
         x0NObRNP3TA8Kez5zn5gD2QojUceNcb+yasw4i6Hux+5mMmxV81X7prFEGJng9ZSbme/
         fJflg1FDC6Ex7z8M1V/6BEX2pY9vgpa5jO3sudYMd1rnsZRN/AE2GRzY7LaX4+sev5Yc
         j3lKVREvcd6zeoi8qSwmY+JIWIZPGahFN9iRmKq9qROXXjfaYtxJ7xxo4SWDFPY9Gmob
         rK6GHieNhieFYHsTjxum9PCjtPe5Zb/j06sXj+Fi8Oo8r9KhEaEPcvsPp0SxkDZMLSAy
         GKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794597772; x=1795202572;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hG1EB293hxr3Jgg2QdT4ZHxs80rfcC0WBpvazP602rI=;
        b=OnQiAyLtWZ7B4ADEToMtFvs4Pf/6jZa9Bxm1phhZ+8CeUCMbEh6bdPZsZ4Huh/EelR
         IIZmU2NfLyIz+vSYvg0Cdx8yXmq8pw7/tqR4prQc223dMXuE+VSoXYD0CnPgexU1c3Fo
         dqbe+wnxg6rZStxaLThEBbZ1mSI9i7uenF9YEeHD9ldAOy3lKLB8qyK4D/mVyCyNQ6hv
         kKOYeM0GTQ50D6RK3FFwHEB13FlWbelLLjZFgu4hrHgCXRp3JBmIV3jo4ebLApw+e6XK
         QmHlFWbH00ZMq8CASnuPZYImOh/tG8u+mSaIRAgNRD0Yw0gvu6z2vD2CD1djn4N7xEWp
         9HCQ==
X-Forwarded-Encrypted: i=1; AL+hErHuAu0niUE36oLd8lESfeEEJnHamEZ0oOP0Er5vF6hpj8zFD507rDDtdzE1jwFt4X47IeBo3S0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+j96RWneLqVTnyWR21smezMVdZYLeHmTSDHlFp+0BBycBy1YJY
	3NgfSNkuPNiFUm3mkrZ3HuZvFDwsw/f+L5dj+1sZKLEZ+CCtNAHXSZNK
X-Gm-Gg: AYBFou335G2dGdiTz9/xHuEKHh36Bl0AQBVpaDKEb4ijA0Lp1FbCNkD/Lz13wXrSE5/
	Q+3noCRacbSyKBcJXoky7/GAQzZERbcEasMLtSLcsoIBtZsl8xYk89fCM8inTDu60AWP9c75T5M
	OIReRKO+d6JgRRqjmej+Kld9Z8RbSGu7Pu6Zm1hS74OzMzFwOmVDPbOWOV6yc7v8G7MRQVzGOCv
	unsLzVAjEQMFsDBAlUTsNYnPGWwJoIfQ30myOekmfOmT4/7AlaoJkX4B8j27lKE9ZredtuOxfcQ
	m5kWR69GnAJj5ViR+uYEZi89FIoGsZfTPbEF0kRxJB31YMuS98651rEIiY8sebf1HK9h3jCMtzP
	kjwsDwwRk6sq27GWlLYZyNgSrbhwM15BdtP9jdsL7wIhm1hiytLPErpqa02hyUeUIdCtvj+TVkD
	EStbwXNsO2i5QPss6C/4ublT+qXYfIEP6ggVx/JAopjTPQiFFSEHEIYFgJPUs/nWt9EIM8xGRIL
	xi90RHGF12Fh1vaeXvFAj5b6e1FdrYm/zUSzvs9Sq1b54+uRI4dvBMksIxbBYz53zETRf1e4jZM
	dswPXxhxuomrW+ejfyyLFhI7nOYmIK/qUZuZPVgsgcFPz7Ji6QdStyVhBPo8T+7M1jkJqJ+RuWC
	MMA==
X-Received: by 2002:a05:6a00:b49:b0:8b5:ffa4:d618 with SMTP id d2e1a72fcca58-8beb6b771d3mr3233331b3a.43.1794597771515;
        Fri, 13 Nov 2026 11:22:51 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed1d6207fsm1601457b3a.32.2026.11.13.11.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 11:22:50 -0800 (PST)
Message-ID: <36d38251-994a-471b-94b7-d1356326355c@gmail.com>
Date: Fri, 13 Nov 2026 11:22:48 -0800
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
Subject: Re: [PATCH 6.12 000/670] 6.12.118-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261113153811.177190860@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261113153811.177190860@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/26 07:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.118 release.
> There are 670 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 Nov 2026 15:36:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.118-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
