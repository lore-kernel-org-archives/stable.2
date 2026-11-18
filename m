Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031673;
	b=Duzfo0zCdfld3VUm4FOr/+44Um2f5tWBHH/iVqRkFg0zIeMJAbA81aEjZbCIihWPABtV
	 F+kSrI18x1bbbO+jNyPRM8TYSl1AeF+Y3K92KTAFxooWen2Z9/oE2153EY5DNvq0QsOT6
	 0bFDCrgcQerdJB8U1ODtWDbhSH50eUqAtXgO2dTxqE7+zIQPm+GH/0PFPsdOMD4V+kk0v
	 tzUNiW+MJTPEtJR9eNSoTuPYSPmPWaCWQ7K3sZnNBTtik2hW/rjl/8MZb4D4Y/d5VU67L
	 Zg85rG3PuIoWSjQ5b/Bv9uzwbWOmKm1Zr7YBPUMt37XpSgTiNQDfNAMtAQt/tFAiusw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=i0RPIOg/N02GB/FO0QU0LL8vtzFon8FGCvQcjRptq9c=;
	b=OHmGtEYGJcTKzZ5b5kZZjtDRigSTYfRToA8pR7otvd2bOvlviVVNxG3ApzDToHIwGXbs
	 sz4D90QUuRibhG0fDIXz/05y9TJnZUrsN4A1m0ZnD3ymXpPKO/Dj27c6XoValg9z3TIel
	 yFtyQSlhexmH1cKcXZDUlVI+8bwdzCOoAyH/la6oNBoQuf8e1u8VY5jTjrhqXRTiLH1Bi
	 9ZnmI2RKoz0WlJQu+MZ42PLxTbhk4CzBE1h7qHe/P3/cj6N2rx5DwkA+hDSfjD2IFyGGC
	 qVIAdM5DxAFUjT8K/58boY/Sam/Ll6XMWkymVHqi1bUUmfd2g4sddKm7Vwt4Qkr57FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PnPN+RH7;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5E160A2605
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 19:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E5E160A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PnPN+RH7
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93f2f2edb19so130328285a.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795031672; x=1795636472; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i0RPIOg/N02GB/FO0QU0LL8vtzFon8FGCvQcjRptq9c=;
        b=PnPN+RH7pQhbikZJA14mX7rLaH9sPH/vIyKWSDAL6vqRccPUOJmxW/1r1Ov0fvnJRk
         QlNITGKipLAp/5DDZUwCG9FCGzOW1P6G2CeDeicU8evPwE3mtIcozIb+Yhvoz4uPiiH+
         S2gQ008I7WL3vXFUeitwiudL2Q0j1w8UzepE9inLHPto6z6IDwaQ18445qFpKiMJx0Hh
         YYcRNn9fzNtSz0dzyq1VdvisPJsyRgMiy+G21H+0N4qotuyAWqshXUqUmb/2KKji2KO0
         1H5RBxB352BulL3ICkR/MaXmzD0fy5PSi6P0ZD4mtQ0i/E6Dlko3bcqdg5cTQWRMzn6N
         Kv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795031672; x=1795636472;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i0RPIOg/N02GB/FO0QU0LL8vtzFon8FGCvQcjRptq9c=;
        b=qU4TpDXUmGpX5SAFywtx+VSJX+DzIYl9FEJna3A70AUbzCm0BpjUPzVLLGgfSl9/UC
         OH5wTVOwUTCH6xo3YCHr91fwn1CYjYk0Td1rSO4dnaczeSRgDCnFEVkuwXHLixTG8GZo
         +/D1mhZuOmA6CsbgArdM4WGRXhXLxFIOEeL4Z8LYl2P4fNsVWCXCRheODWIf8EgvJMv9
         m4fa+aRyEqJFpjTfZbl0NqvsqDD127goNH+y3+qczjGWvu+oBR8apQW6K08XoG66FNfG
         piQbL5Fqx/KY2N9LtGCq5x94bqGJbW0Hjt/HqxXZ58gG05apvof9fiMYPgWDRRTHXk/k
         mK9A==
X-Forwarded-Encrypted: i=1; AL+hErHxm4/2/xj2ti8Pv3jHpm4M8f/XijqinvoimVWqROQ5GnhSIi1wJM+RITkeyGbrk7f/GOE91Xo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9LWRRc+kLaTXxPJUgyxXUOWdipXuAfi1BySTrYBsAhBba1ZZI8
	GhmYVRRiKqB1ZvH2CfUeJKz+R2d3X3iV/8yYB2IMZokswzr+F1+IVYUU
X-Gm-Gg: AYBFou1cWxNj6tSbJ1TZ5x01iV4uf0wxLDwzUf+Fju2RIcfJwYGX2PbrHfdWXaAhxp8
	GkjGyGkLsbyOgZ89S1pTpaO1cu7cNR9I+pSLKGUgqA0216f4Y6Oc6NBnrAuCYyFafuEW7F6fwq0
	Eu+sjBytrIKdZK9+RiklCczlGwyZ0UTK7uT3ewbbK5ISGh2aQY8oxfz88ceo4UkPUwb7YBVqIM6
	J1sDKdljcKcK5kRvpsO3wfyDv5y+K9K/Td0tOpaVNko5u7kB3FHLvX6arYObJI2vq89ucEBVM3A
	o3AvnZcZXoiwAFyGG18oeFGzqJCv/61R33lJAFHFDw/1kSB4U+B5/mrowO2bPV8Ie2K05vAusHY
	pMFFa2icY8eOeIwcDHx4G2PM7cXe9U/HvC9A+Gn+qsbh/Az5V5sxugB6i+xEEuQlQmRtaeyHsmz
	lZswMywa9YPZjumbhCY9+gnGSkWQIw+S35iO/xb8OYdGblR9ZhVx/D4Aoq/lCAQTCnND1A9q46A
	WvW2UCDyKAcOseZOKCjelI9gj8hWQyktwHYoym0TZYrVsBKi4ZkxS6uk9YNwhNtXAA0D4A1rfDq
	NTmokcNU2TXb77RsUwei9rcTdSzRjGM4jF+Mog8VI6Oe0UhDMo+r/16wfw==
X-Received: by 2002:a05:620a:7084:b0:947:9060:7efb with SMTP id af79cd13be357-94999574d09mr635823285a.18.1795031671725;
        Wed, 18 Nov 2026 11:54:31 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b7475b8sm257960785a.18.2026.11.18.11.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 11:54:31 -0800 (PST)
Message-ID: <c7f0c78a-47c1-4dfb-bf21-808e25f05611@gmail.com>
Date: Wed, 18 Nov 2026 11:54:28 -0800
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
Subject: Re: [PATCH 6.18 0000/2151] 6.18.65-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261118150121.603863898@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261118150121.603863898@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/26 06:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.65 release.
> There are 2151 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 20 Nov 2026 14:55:45 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.65-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf fails to build with:

util/annotate-data.c: In function 'global_var__collect':
util/annotate-data.c:765:30: warning: implicit declaration of function 
'die_get_type_die'; did you mean 'die_get_typename'? 
[-Wimplicit-function-declaration]
   765 |                         if (!die_get_type_die(dwarf, 
pos->die_off, pos->die_tag,
       |                              ^~~~~~~~~~~~~~~~
       |                              die_get_typename
util/annotate-data.c:765:71: error: 'struct die_var_type' has no member 
named 'die_tag'
   765 |                         if (!die_get_type_die(dwarf, 
pos->die_off, pos->die_tag,
       | 
       ^~
util/annotate-data.c:766:50: error: 'struct die_var_type' has no member 
named 'from_alt'
   766 |                                               pos->from_alt, 
&type_die))
       |                                                  ^~
util/annotate-data.c:777:44: error: 'struct die_var_type' has no member 
named 'from_alt'
   777 |                                         pos->from_alt);
       |                                            ^~
util/annotate-data.c: In function 'get_global_var_type':
util/annotate-data.c:835:26: warning: implicit declaration of function 
'die_same_file' [-Wimplicit-function-declaration]
   835 |                         !die_same_file(cu_die, type_die));
       |                          ^~~~~~~~~~~~~
util/annotate-data.c: In function 'update_var_state':
util/annotate-data.c:873:42: error: 'struct die_var_type' has no member 
named 'die_tag'
   873 |                                       var->die_tag, 
var->from_alt, &mem_die))
       |                                          ^~
util/annotate-data.c:873:56: error: 'struct die_var_type' has no member 
named 'from_alt'
   873 |                                       var->die_tag, 
var->from_alt, &mem_die))
       |                                                        ^~

-- 
Florian
