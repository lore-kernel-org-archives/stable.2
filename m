Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795165261;
	b=y+SeCWTZGnzlzzkRbV37x3nUvhh3lb/L//A3zwm2/k2cbcqGptIDnQEnhqcx1SRbSUT1
	 K/q0MEYqnb9t2J/6QxgiIkZZNNPA8dgmu1WO5C39LJRKJZBdTZL8HiV+t9wo55q0QdPXq
	 fzqVqW+k9+vNDJYueSvoEjxNCw1PzjkLAdVvdEue13ynBCKMx3aq06PVfkrOmT9mEjLag
	 SURKXxawGRu3RhZCeZ74JZ/A5qPGujx2QZi4bms21PMLVA59U6iM152Pac90U3CV8Wvx6
	 tSWlpeavpnS5o7EvrBHkRqDlovaopsXKRI+d//iXfwdOrpZ0O+ln/I5GEbEtqaWHdbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795165261;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=PZieRENVmUX5OHXGvmzJIcsoS8CWVu3mfuhhXe7ha4o=;
	b=ae4we1x7Kty410Xvp4oq7oV4BsWujmtJEWVqn8T/RcCdqhEOzZ9xGyKnTcVZYAnB+QP6
	 BMJMRym4RmFF20bjdKhxTFkZe/PaKjAMYqmi+NBXeTYMzDgchf/jjjHLY4MjFmNAzYIX7
	 V9O5RaKXSsIwdnmOsmkSIqfgm6juMS6tavbB1u9R4YSniKRObjSzJ6bgqtWs6yrb4CFkz
	 u9gNqbTSA87SQQTBXFPOxsbk+JbFT8tQlPCXeRTZcwZoHHS5g7oGjO2WUQWYZO9rwpkXj
	 kD786K0jmuT3K8g8LdV5gl9acfAU1Ywsq3uiWxqhSHexUW6xtLlUm80EOnKZhRzWoaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=futuring-girl.com;
	spf=pass smtp.mailfrom=futuring-girl.com;
	dkim=pass header.d=futuring-girl.com header.i=@futuring-girl.com header.a=rsa-sha256 header.s=google header.b=Z8BgscY9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970D1606A320
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 09:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 970D1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.a=rsa-sha256 header.s=google header.b=Z8BgscY9
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4d581da0aaso82872266b.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 01:01:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795165259; cv=none;
        d=google.com; s=arc-20260327;
        b=bS40thwfNid66MuZ44EIYQxzorAMovnMU2b8Knrw1VYqGVjP62BDIWAwr1k+f4vfYH
         UErMFhTfEJ2fCAL6Gtw29UUL8eE7BzHGgMm22DfwP2Byozquz2ybaNbmyiL8Uvzhpx38
         LtR3IMNe9UGx6HA7zIszS0/y01a3v8GFYWbfKxeckpoqGBfPzEOCG9OhQySBxCbOJTAe
         qfRPnyJ3taYm+9r+RSTWg0SFQq3MftgyG7zhBzAPRgYQuodxXulWzhGFDx+nB1lWBoaU
         c4cQouklfyMQ0vTKeo4wEGDncjSAy0cwe02f01iYFfQ+W57Qkx3BZPFmrtlHVhFHYf6L
         qGfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PZieRENVmUX5OHXGvmzJIcsoS8CWVu3mfuhhXe7ha4o=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=X+7LEm3Ty+jXtmNLzaDlQplgkZrb/ybS7JDihQ596c9kInlNxY2PID4er3N+2QQ9Tb
         tCeGPF1ynj/VQbNaP9sTb3YnHnKOjxUzsIWjeOpokwNeAuCUvA9/SDNDry6ezDMlZuWL
         Mw+/MOu4xa5c24BO3N5Toa6MJYLOZvJph+6Xw6SjmYLrm14fynv0It3qgg1987HQYHu6
         lPPpE3PgMVed9TCutdK3Ox+grSf7o3X8QPzigcRfmYAmOYAEIq/vYUkRbKYn3qyCLcEg
         J0y4QSP+ab/GA1+tWBAAziXkYttAbnBPNn3GODe5JcL2H5EgtV3Amohvphpo6NvVNcYA
         /4sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1795165259; x=1795770059; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PZieRENVmUX5OHXGvmzJIcsoS8CWVu3mfuhhXe7ha4o=;
        b=Z8BgscY9/G3ijVbCwygY0Yd337nhLe18Bd+5uOZ3zsKqXXymvoeoIeywGgl6rlt8Wo
         OXbMS0NIKAcYL+f5s02X+TlFlXpNhe9ccM40x7CEyMqlTDXxytBSPFVFL1kI6+dZeKml
         /UbAc90eQaF3ip7q9UUc2GqCT05+qFsgfsV/j1YvsVAzanZqgz+SuKNLZNTxedQdLaFp
         jJR9GVfwADTrzuuUR2ELE6iMSNNO2pnaPoUqD+hmV0AOQeA2ZJqLaMdPT4rxWCfM6Rqg
         zZKbrixug+C9Z/vHTL+3hjeokbli7hhlhU782Ctq4gtFk7idNQEGpHQC/UNqgkABzCG0
         kSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795165259; x=1795770059;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PZieRENVmUX5OHXGvmzJIcsoS8CWVu3mfuhhXe7ha4o=;
        b=Mqb0lKwbp4NH9JqnGSreuo5wEMY+AD3Fz2RQwbcIWNoWBIQgFUfMuJtF/4VQloo9R9
         2WGirP82CyyyU2fxg3L5h855WTtdYR6qaC38zX+F9GMk17APrqko1lqrBn+afcALvdJ7
         TvnxRzQsrLZ9+Ubl8UHo+Wbuz+rDCRw4FUwMoJ+hvFGin1Kl61uV+wl7ee/GwsuheiN/
         Mfgn81ssybzsu2biw/JJoVtgBEsyS4L7CyFFDodZSgq3O97QvzTt4HfoHjTI27vLSeQU
         1vuDzWhLlavru5EYtj1KPRd6DjU2HenRp7gdTBpUhGXiCrTsB/GV4c9x+iCLNMXa4R30
         Y8DA==
X-Gm-Message-State: APuU4Z+3jgFzH4al/diURtLHEGGuHcc1yfgI7tB5UJkAWidxlvgDNLC8
	5MvnTHkDW2hHq1GemZfZ9gNt6WTXQ0DO1udjFRxuGs4sKme5VgJ9ex2n5N2vZTPy9EwFVjfz4DS
	vWe7DtKF1JdhB1zZ3LxVVJwgoANp07XcfPQXUNRhziLyU5pv7z6v/g3c=
X-Gm-Gg: AZFdTZd2LWANteGoASaWheNm9dOKm/fjxZghmNYaxB6EHRn6uUH1/RsDPGCVxFurB6i
	oB0lUazAYPZjvDDysoTHA5DzpofxfhZN0Wszg1GZsqkHNzkIZHhnINfR+Imjaah4QbRPuS/APuK
	ThWolJDeZKo2WfxH8PmzmLTUE6HuUxf+aB03wqfTggT86VGMQByDuTv2azb31UtSODU4OZERYU5
	8h+uWOelIMMROAqjEkqdBcCJdYox7Y0o5sqy0Pc9xrFJ2wQFkjllRKEgwpeU+sV2fR8vZRBe3w6
	9QkVrP0Bse3WUImLBK0Ekj+iUKiiVCXq15FMXyTp7XRK5Xonrfgudr0Z+46tZuaeYW+V3B6AWaF
	gGr8bdWTGAeA/p8GvvQ7ZYOYaVoLTF5It1VSV
X-Received: by 2002:a17:907:2d9f:b0:c50:f0f9:ad74 with SMTP id
 a640c23a62f3a-c513a99aa4fmr235834066b.9.1795165257779; Fri, 20 Nov 2026
 01:00:57 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120055248.913352689@linuxfoundation.org>
In-Reply-To: <20261120055248.913352689@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 20 Nov 2026 18:00:41 +0900
X-Gm-Features: Aa3M54rlZA_OBwjiZKWCvnO1fS0Oy5SCnCxiMl_HpsSggZDP4dM965l7S2Cnigk
Message-ID: <CAKL4bV6kN20uHLeG=ZV3FHe2HghsA-yRp3+YgCVgTvGybek5Hw@mail.gmail.com>
Subject: Re: [PATCH 7.3 0000/2642] 7.3.6-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Fri, Nov 20, 2026 at 3:04=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.3.6 release.
> There are 2642 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 22 Nov 2026 05:44:39 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.3.6-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.3.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Linux version 7.3.6-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.3.6-rc2rv-gd6a022cc5dc8
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.2.1 20260810, GNU ld (GNU
Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Fri Nov 20 17:29:14 JST 2026

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
