Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793763535;
	b=wMr82O//a1wBTMHhoUZG/RULERsx8Jaqxp1z1cXuu/89KM/xrGpsfQmHBSFMkCj1+JLv
	 OMXV31E4MEOowDjbhnDXZTr3rHcvgbNQ3ngw1xgHEygPHrsKoUapzDafFORcgUjUJ8I4s
	 iAOVYBAK752AP3wknNl/CEG9ocrlrclGk/jylJbBHFzdqGJ0tIwy4GdWzH95Isr/HksWt
	 O0VxMBNb7lLlbD0x/t5ao8AUW4tQRGHnhs5fhzonues8Y0W+u0XncIsfoqQt52fYNM+aT
	 0Hmxl4dvk8D4Y1T7Cfftb7EqGQ3lkKf3CaaOEE/oWWaIKS9+v9cx8Ah/DDy/Rd8KmjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793763535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=rvyyEItMjhpjcCiR5G2iyawMRAc8IGNvunoyBM1eU1k=;
	b=z/OpPEM8ColdQwtpldmOFD0USIYhbhaGEWgRgLP8s++ENc6ehYFDgYhC5DchTTmc8+hn
	 hGtLMeC4hMnf/l7Z7TovIgYNuhEMMBlS4ncd2TFH2N8jegDU4VyQ+krOKMh2lD4/5wKAe
	 Dh2Gexdr9Q8qcZETp4Y1WDLw+nrSOdyCrxepsvc3U52/0WRMPCuevBC+UWkzFtLREqWNN
	 7s82mrClibWI7Bqdgu8mkygWfgrDoFqQLI0yZlTk0cnrA6bR5rKTshhaYQq0RghJQHjkM
	 /NsCpgF0Yyel2qgG/xRAQ+nHV4aGO6atKddCcyH6r1O875hPUJ3nC+zRSwUsQHd49hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IMnGGHbZ;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194A0606A32C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 03:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 194A0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IMnGGHbZ
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35829219da8so1525195eec.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 19:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793763534; x=1794368334; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rvyyEItMjhpjcCiR5G2iyawMRAc8IGNvunoyBM1eU1k=;
        b=IMnGGHbZfzS4ZMXl77G8FzBSzJN04aU4eLBtXEhq2+SM14tDfaYWKhh4FUKDjtRN1m
         8pUDfwsP/9AEG+JbxPf7bWMErkI8kLMWHa6yJqshjWAjwwoOkWajG5XMDxrXrs1xbF3r
         dgcH9WRjJ+Ls85cyHl8GjtuQw+we8F0IOvFL67s/MVpuRJ5Tq7QwYJ6GWKzGTYYBrnh2
         QpL+mk1HCYGFhnhPXf3sPUWhs/FbqLyVStAk4oGTEyfH2DMGI7KrFY4BHXscStSUB5P5
         2sFhgObS9Qru4z9ZkapYnlJo1FaEmHXb36SAUivo6oEGOWOrIB/vE0HVinok4jg5WfXW
         62vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793763534; x=1794368334;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rvyyEItMjhpjcCiR5G2iyawMRAc8IGNvunoyBM1eU1k=;
        b=WMnW5EqFr/WsP+vMrEtOCWhvV6k3dMasECgPRciXA6NhRv0JzaKqm+kOCHCODFSiRz
         2aewxm3PEvttD7YEZylDFuhzjKJINQn+7J0fvQ38Xdl1IA7AfiEt8MIzB1b9LWJ8ZYkT
         4KkntoyKGE1RO146KXJdj/AKlnnorYs+fBFgz25Dwct+1u2kxg9wDpI9sFpapz79VMZJ
         yOKThcIBcFrGgxDvNZ1hvgHiZelhAuPtqC1Ke+v7XEZqdL07vhsMJbWuRC7Cdof0SNb3
         0L18tbWs1yKCpjZqRIK51r4ZS99DcdgMWIdWS77JIuPT+Lugv42uYbtMG7T6biQCZ586
         FAQQ==
X-Forwarded-Encrypted: i=1; AKwUvBykknBD2o8Bm4p4uy4IaErFXWNcmqfKSXtjx8F7rp6xeGJr6SwccrgFpesZNi6WeIguHqChuT4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9LCMf5/O3UjCkoV9UGhRCWZex++eztAtfOQKfgvwgz1/jrZWmb
	/To96n1I7m/jxz0W61/ox6l8TBpi2pMhg/Mr296gkeDqz/3j0r4Gaoi2xlyi6sHh
X-Gm-Gg: AYBFou1AkKUiRgrp8NZq0zo0VDDXNMiYvIX4qKxtnKYeW7ATkR/p0I8e4XHztq0fPBN
	HvLh5h4ik57ipBNPDobOC30N0EDFHtOmcbW+R1146bIAqhB2kcRhSybuuFZZFI3cM1Uu10e965I
	wmnAJpos2DjkUXww6TmVYtfDa8cJ8eGoO9UfFalB6A4GWYyj6zSZ5MgT2kZpnPkz9SgmkcNqvE0
	ILVNNVHa/ECb2ZD7nJ0hTwqPFBDIGa4NqKooxdvAhmsgUqmyTQ5YoYUtYTp8KybFCmrwlgg/Ubx
	jQnYpLq1tze0ZNdCNwUqdW/iw95JrYnosuXuxSvne5GLqDr0ZuPOFKtWJGGUoipi/QjwpkjjV1Q
	88y7JGOophmsUMvp/5gonRqP7QLI3fyS30M3meghMzDiBn+4r1rMxNumQpADvD7BlDmCgm+J1Vg
	DCmwRhm2hnQWZnV8mzQ5rGlQ4mkMfFP9kNhm4BuMWqIQJN1DcTHGEQMlfr7J9xQEQe7nr745Mic
	urW6EiUepsUE/v4jGV11NTx22qMt2o0X1GSQWsYBYmuOe0i/oCxRBFObfehnBK4DIurjWAWlkWB
	UWeJOtYXt27ALi/j97ocrEcJ+n2+90jlwVt+tSllHylgM/cIzjOr0/EIyHbepkU7TwmR
X-Received: by 2002:a05:7300:f80e:b0:36c:98e5:a6c1 with SMTP id 5a478bee46e88-36c98e5ad0dmr4158661eec.19.1793763534132;
        Tue, 03 Nov 2026 19:38:54 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:88b4:22ec:d621:c1b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3981ff0sm3310812eec.24.2026.11.03.19.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 19:38:53 -0800 (PST)
Date: Tue, 03 Nov 2026 19:38:52 -0800
Message-ID: <8063a24bb9f75bb9096c947d8ffa7123@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Input: joydev - avoid signed overflow in the broken-axis correction
In-Reply-To: <20261103085514.431010-1-zhugl3@xiaopeng.com>
References: <20261103084135.426629-2-zhugl3@xiaopeng.com> <20261103085514.431010-1-zhugl3@xiaopeng.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Guanglei,

On Tue, Nov 03, 2026 at 04:55:14PM +0800, Guanglei Zhu wrote:
> The JS_CORR_BROKEN correction multiplies two user-controlled 32-bit
> values before shifting and clamping the result:
...
> -	case JS_CORR_BROKEN:
> -		value = value > corr->coef[0] ? (value < corr->coef[1] ? 0 :
> -			((corr->coef[3] * (value - corr->coef[1])) >> 14)) :
> -			((corr->coef[2] * (value - corr->coef[0])) >> 14);
> +	case JS_CORR_BROKEN: {
> +		s64 tmp = value > corr->coef[0] ?
> +			(value < corr->coef[1] ? 0 :
> +			 (s64)corr->coef[3] * ((s64)value - corr->coef[1])) :
> +			(s64)corr->coef[2] * ((s64)value - corr->coef[0]);
> +
> +		value = clamp_t(s64, tmp >> 14, -32767, 32767);
>  		break;
> +	}

Assigning to value and breaking out of the switch causes value to be
clamped a second time at the end of joydev_correct(). Also, pre-converting
value to s64 and replacing the nested ternary with if/else statements
avoids all the explicit (s64) casts and returns 0 immediately when the
input is in the deadzone:

static int joydev_correct(int value, struct js_corr *corr)
{
	s64 v64;

	switch (corr->type) {
	case JS_CORR_NONE:
		return clamp(value, -32767, 32767);

	case JS_CORR_BROKEN:
		v64 = value;
		if (value < corr->coef[0])
			v64 = (v64 - corr->coef[0]) * corr->coef[2];
		else if (value > corr->coef[0] && value > corr->coef[1])
			v64 = (v64 - corr->coef[1]) * corr->coef[3];
		else
			return 0;

		return clamp_val(v64 >> 14, -32767, 32767);

	default:
		return 0;
	}
}

Also, please note that the kernel builds with -fno-strict-overflow, so
signed overflow is defined as two's-complement wraparound rather than
compiler undefined behavior, and please drop Fixes and Cc: stable as
this only affects synthetic coefficients passed via JSIOCSCORR.

Thanks.

-- 
Dmitry
