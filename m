Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795210090;
	b=p7/DSR34bfXj/cWlMsvxFUxxuAE+4VIuUFax5yx2ueoERIhmKvvRUtRiRbSVsfrau7J3
	 bAYKOYL4a4AenIlZQboG6gDD0sr5j0vbeqTmC3VOOirCt26E1YZ3M3fz3IrrQ58EjDjG4
	 GgkHltzXYnscSoFQIcJIk0+LPw/MI2HTuhKtkjBEfmzjyqyvlfnINLz+GWKQjYUlzq/5I
	 qEnBzyW46A+HZOk3mq7dWyD8GL4E/FY/G2SBsVpj/lXYCP0treI6zEBTSailQGygQUHby
	 09fswh9esc7h5cK90MTwm4eYNYv+FfSBT12QjGR4Fr1NJcg/nC2pIVEmSgGhsZqTP5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210090;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=djWeAX1LeVmUiJ144ujbOmLsl/46HHhdv4BSJSqbZfY=;
	b=3HyV7DJZ8jVaWjEs1owXr6Rs0/8KljK9J7wcTmvtg+xwqqGWEMXbhMJ3ksJ/iPZegPvW
	 5ssMYvPdnZimAPtNLVB3k4b5GNCHAYvv4+rzDOb9J20FJtBVjkpm57WPNXdTpVI2UXJ/l
	 41SVwUukyqFag1BaAkJdFu4xAfxZha5plD2YHxxaCS23sWMjX5QD2mwkE02cjnvGBn49e
	 MmIK+b5FvJdkwkd2nKLunGBxhGXsFYlt2tAmsEtqm49SDnwhM6/z9VFQi2inaqLp0Xvi/
	 kX/IFDH3EC8DCD5+iOdEO3G4ARb7QzQv5UGPFmb/hGRiX2VZKh8gZidtdmw3pcmngYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Be6FxUvP;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A2D606A6A3
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 21:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2A2D606A6A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Be6FxUvP
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb5f0c5348so632885e9.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 13:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795210088; x=1795814888; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=djWeAX1LeVmUiJ144ujbOmLsl/46HHhdv4BSJSqbZfY=;
        b=Be6FxUvPoX7GO9DbG/L1PwSrJb1bWoAgimnvXCLJcHyXTjABEvlZqaXvx0p7gUIGHY
         wgQPSL0IzvwaW2Yg364amqbZH104TuVp0MQoIJ3cTjoQwIKd1bDIIOwmipk1MyPDqAfx
         SRn2cDCCEXNr0Er/UJTovDI+LFVihYGIIVVOeXmB7mAcazV3TNa7SCe1Vg0kPa2Uu+Gw
         xEYMcUg2CWB2tMEo9Cd+j0FmK1JAqhFw//abMJKLYg8E9WV2ToiWZOxE+OShe3tnqPlD
         +GjQn5F/JjU219eLfSfhTeVoQfQTzlhB5BE4wTA+z1Qbjxn7ucIFhashQy2DNtSpDL0G
         5tmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795210088; x=1795814888;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=djWeAX1LeVmUiJ144ujbOmLsl/46HHhdv4BSJSqbZfY=;
        b=1bOTm0Oef6R6OPkTj009gPIEylgLzXMpzecnyYUA+9B6iYabFGzWCQ6BkA7nnm/v2b
         +ZnCzoxuyAs04IGRKhYcx0Ls8Ap1J2+vpeGG6ymc63UcowEaUEqtuqBekEKYesTm7Nmq
         Ej0IBzoWn5eKXTEHbiP2QKoA2xdBJsB6yw1XedTbfD5QT+j/zl/+cddIEw4Eb1M4N/fW
         WB/3mhKlPbwJnRRX9OBpoP2LHu8ZWAEd0usdnJ6GzoykiC6keZqZn2xMtRerwMeRaK67
         YBxMFKKENLS3IQB5k6sLf3F1UypZwRFmAemVySLkX+OYAc/a1RS2o9CpO/RYqDQzRSOm
         2V/Q==
X-Forwarded-Encrypted: i=1; AL+hErFjp8CD36f7tK3eHiGM/ZhDXr1b9RbptJu2Xf2lXXxMCvN/kGhPs3reaIKdQ/w7yhyoRYAKhLA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BIRMr3cAZpjrqyVqTxAiOj7o6Vy0t/Gbmm0Usq+CRfnA2Trqn
	cyD4awMLTwEHE/L/LAh0mYy7KHLOhSoFe87z8OMQ+w9n6De8PHkz1Rt5e1x3c+HhDNg=
X-Gm-Gg: AZFdTZeVEL1EF1t7Ghx9yOGTkDzxGPjttUrBhKmbJIsB5R6h3Gh+lxpHZWfgEs/osTL
	Thl5/+XLnomTpt56X9ldPqcJ5P7t7m3+zmVw37o09hPKWbdiicEjDeXtPn5slHgQ4BaftUIk8Vl
	3azou3R9srFVHJ+GttKa8FAGINrfy/hQYTFOURRNps2JZsv+vt1blZjkLj895uP/1uI3odMPf+p
	+hH/KqoxPmlf3i23WQ2F4OcoM1VT1OiU8mQi43OgbzaO/DwRa9QVe3MuMDiHckvFbnmmuzL6yw+
	nhQvdSf3uCNsoH0zmwLEk2Fjo2ZiL7lS5fNRnGcEvQqSF6wErZJz1rugO851xPZH5H7Q22AO6MR
	BQqSo4ClxUdYon4BRdH0U9k/3OLoFygIQPN483b8ZMV6z/s8VL86io4qQYf80q/Ti7cEEXTmDlZ
	oLkYWiZW8pb/g6uHzvduxvU9OSHa7IxkqyWpt4mw7Jz92CeC73Gs4GPThKT2ndoTluQ1ZygBnLL
	7PCc3LgaurySWvLs1JF+QiCPM2HcQrR6oGfwZu1bJLWzh7Xr/AdltVRl7HQ2Q1dzWX2sI/4Ax03
	ywi7uhLDLIHHaEci7h9fiy5ct1dMWZz0WCr8PkJln6m3TaMrevzFMfniv661AFMjethzHr926aY
	3JL6VOGJ/mDmlpOxZ8K0dlw7qWONuNl3zT8QMjVAQM9zyS3BzuBkmsXqEQVmqEXdn+Afe+OeIVj
	IYZifnqWhn+z4Lm8ZoNsOqSbgSA0YuVCmVcy7zTnMxqlWcOqA=
X-Received: by 2002:a05:6000:4308:b0:48e:6651:d82b with SMTP id ffacd0b85a97d-4abae12d0acmr10655671f8f.2.1795210087424;
        Fri, 20 Nov 2026 13:28:07 -0800 (PST)
Received: from ?IPV6:2a02:3100:65ed:8fc:216e:bbeb:a7f9:ea1d? (dynamic-2a02-3100-65ed-08fc-216e-bbeb-a7f9-ea1d.310.pool.telefonica.de. [2a02:3100:65ed:8fc:216e:bbeb:a7f9:ea1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b205443sm7919950f8f.39.2026.11.20.13.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 13:28:06 -0800 (PST)
Message-ID: <967fd174-41f5-4ff8-834c-19483dcb342e@gmail.com>
Date: Fri, 20 Nov 2026 22:28:04 +0100
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
Subject: Re: [PATCH net v10 1/4] net: hsr: keep GRO disabled on HSR/PRP ports
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 shuah@kernel.org, kees@kernel.org, petr.wozniak@gmail.com,
 qingfang.deng@linux.dev, fmaurer@redhat.com, luka.gejak@linux.dev,
 bigeasy@linutronix.de, xiaoliang.yang_1@nxp.com, skhawaja@google.com,
 liuhangbin@gmail.com, stable@vger.kernel.org, sdf.kernel@gmail.com,
 lukma@denx.de, fmancera@suse.de, danishanwar@ti.com
References: <20261117141922.20-2-xiexinet@gmail.com>
 <179514132000.3136.2415655157145361596@kernel.org>
Content-Language: en-GB
From: Xin Xie <xiexinet@gmail.com>
Autocrypt: addr=xiexinet@gmail.com; keydata=
 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
 sNySbH3veZ/55EtlXA==
In-Reply-To: <179514132000.3136.2415655157145361596@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/11/2026 03:22, netdev-bot+sashiko@kernel.org wrote:
> So the SET reply says GRO is wanted but not active. A later
> ETHTOOL_MSG_FEATURES_GET then reads dev->wanted_features in
> features_prepare_data() and shows GRO as not wanted.

This is intended, and the commit message says so: a GRO request on a
member is dropped, not kept pending. While GRO stays off,
ETHTOOL_SFEATURES returns no ETHTOOL_F_WISH and the netlink SET reply
shows the bit as not applied. A later GET reads the stored request,
which no longer has GRO; a SET reply and a GET can already differ in
the same way for a bit outside hw_features.

> Could the request stay in wanted_features, with only the computed
> features masked here?

Masking only the computed features is what v7 did, and it breaks veth,
which adds and deletes its NAPI instances according to wanted_features;
the commit message names the two failures. Changing veth is a separate
matter and not part of this fix.

-- 
Xin
