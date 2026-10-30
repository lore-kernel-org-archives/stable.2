Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793359942;
	b=BRHGPOkn72W2VGtIo9nimKKNUKetpDpDGMIUND2KfibKgKgZL2ml+n1HSe27Ex48Ds42
	 Ue0Npi2dEdeOVjZJ8pvMGLH8jVQkO3dciuB26rtkikyy/QkyuTX4+7/0vMXhCMjtnGqp+
	 cRcv54HjDeji1oLEVRs7FxVfYddoVVkNKky7Bxnq3j7rwiE1R8HDvWox1/KwNy3f1NA2G
	 qsA0eEsgXsPnG2tT8O4PSppqPH4izQ+/ghbn1QdcGjfkgZnIGYXt3Uwiq8GLTicjYE5yz
	 rszC5eSi9hCDiFv+JU0adgNQzPD9m5/MnMBs+u4WW7Wk2FfbEyFN7NzmWMSIp/W2OUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793359942;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=bCRXJOfL1rF+9fr+UKD9RmwMJVlMYUb3ngXZoi9U2Uw=;
	b=oTMMTAYamEx4n8F/xlEQVnIvWRXIZ2t6A+swyez7ROvZT3lvvRNOpM9TsP2JYKuERjMA
	 XJgMV1JFKqjmHiahiN06s1nh/F5Ldr9Y80VgZG7Xm8wTcWLU4wXcBpldp1O/viibUHsoe
	 xxMcWifKQDQaCyBkNCaKfqRvTi0XZsEnYxtVWwESKIjCFxzOSf4758J8ekkeY5oL1yi0N
	 K7mVUV8uSpfpW39rktwxeBnhOSLZvrv0M0JUu8+IbrPdOsQYxBLNGL5aiWrPxSRC5Ce+W
	 yDcBLiDNPTrFtxC5sKaaGaPPgFM/A05/Zf+4f72sNOq2rejUnKw49B7Do5QD2H2tnTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=w03xlHOL;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA63606A325
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 11:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCA63606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=w03xlHOL
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so3162625e9.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 04:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793359940; x=1793964740; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bCRXJOfL1rF+9fr+UKD9RmwMJVlMYUb3ngXZoi9U2Uw=;
        b=w03xlHOLF/X/r9/Qy7G4IHunwOFbxWFcuqCTaRy9YMih0FbCwFskjFyoQpFFKP/ylq
         g+ofcPtcLkburnrrfM2FkhCJb1Oi9InixLTIUp1KY3PbN739V6VmVuLwJfuj/Tki4Mqr
         rXjZHmvo3Qv/spuhAb3y0KfY6MDNUh4kk7fpeF74S2aJ1y8q+EB6sGQYjE4z1/ozFLWJ
         Gl1xbJKkgjS+ODriXEY/Vxkt2R4CGCLh82iHmVipcsj9o27kcqhF8i+KPyuP+S07aZbo
         aQh8yA+RmmEwum73ufUgZWDuXjO055n7E55+UIMNVLoOudSa8jG6nrkQus0/HGQi3uLs
         S0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793359940; x=1793964740;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bCRXJOfL1rF+9fr+UKD9RmwMJVlMYUb3ngXZoi9U2Uw=;
        b=0Zymvr55vN/SYRdwq5xwxIvPEWjZ13RIKdl7mhkgTM2V3RZBaMyrxT7+gd+DTP+QiQ
         aK1hwFTC4NUO23c1WcKrAJRhvOHo8efeeShsqehB5mFftvlxJInAQ99ToCtW/uutIYVV
         qt9vtHElTmksWGmTtQrarvZMY08jDALIpittHiA12N1TWgDNwG309EHjCT4+3hgjNGxK
         w8v7qQRwEPQk/op1TjC4x0kUATtiTN5fQD7gXb0F6mYt8H8gLmxCW7WBQTH7WoOrvL9g
         O7gaVGD2Ua5kMH/ynA1IsAHC7dsSCHZAsGezYLouIewaFStGLaNiq51WdrByenNS3tFf
         VXXw==
X-Gm-Message-State: AFq9FYJtm0zIZWHp+TlmIRHfDNJDdamomssZAiAGxPMd9K08HvSPHvEY
	p6ilVX+LhDRUQvca09qOTctL02IfAYBF7zqcl7srk3izTdJKXx7gjwgR4EW5UgdGDoOef6aaByU
	9bPhd9QY=
X-Gm-Gg: AYBFou0bjMgatwkMAOm6OW5axsRm6ktZjEDYaQaJsV6vmpHdYJWc0QwW92WYkULigTg
	Q2y37X+ipk7umbSbK04jniwfFknkAX7sZISeehFApcJfXm+wp+s6jor96sK3P1QRYgjnJSqwnzb
	wIqDKpzDl+eJWjRzNKj0ij3HD2STVh7It9n6CjYB9lQxXOjikWeq5oT/adIEIi2s93e9Ma4uy6f
	Kjz6dB1loLrzBu21Js0xMTCqLh2zjkbN7R2WZNaVEBYV0vq0N0+0RX214RrkGwUe2mOoIMwAGAX
	RqIBnxu7kMYpYDv3qYy3CZRgxJKvecAJAtmkZXuF1piEEAlSJRK+enVyUCazg5mFZv16P3igtnw
	LjEbcdooGD5RH0CrgWr7Cog8n/+FIk6TDV5MePLlmob6avpNE3eB9rpXSfHNxrFWrpbbQefjyFa
	ZCg7iD6k5CrDE+Oj7rE3dy4wKDAkTGIrhPdKFLrqDvinFhUuu83tlyOPoiUrcaYzlyrLWKs4rqk
	8t0B3SPAVfrq3Egs/s2tnKs2FRA9nH7a21QCo6aTY0uelwGIEhrYzXoXaF+PwN5+pleT/2S1qkJ
	Ou0uBtAzKBLl/lkFSfay7hbxxnJ04m/sFQ==
X-Received: by 2002:a05:600c:4fd4:b0:4a1:e250:b191 with SMTP id 5b1f17b1804b1-4ac180f2ff3mr40702125e9.17.1793359940297;
        Fri, 30 Oct 2026 04:32:20 -0700 (PDT)
Received: from draszik.lan ([109.255.181.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa813d295csm133071965e9.7.2026.10.30.04.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:32:19 -0700 (PDT)
Message-ID: <3e4f24686842918a3a340cab4a7cbeb7540b8a1e.camel@linaro.org>
Subject: Re: [PATCH 6.12.y] kbuild: link-vmlinux.sh: improve detection of
 third pass requirement
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus
 <tudor.ambarus@linaro.org>, Juan Yescas	 <jyescas@google.com>,
 linux-kbuild@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 kernel-team@android.com
Date: Fri, 30 Oct 2026 11:34:34 +0000
In-Reply-To: <20261030-linux-kallsyms-fix-6-12-v1-1-9c43c892de04@linaro.org>
References: <20261030-linux-kallsyms-fix-6-12-v1-1-9c43c892de04@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9+build1 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, 2026-10-30 at 11:29 +0000, Andr=C3=A9 Draszik wrote:
> xxUpstream 14b8b4bf2d7b cherry-picks cleanly onto 7.2; please apply it to
> the stable 7.2 tree as well.

Forgot to remove this stray comment from the v6.18 version. Please ignore
this line.


A.
