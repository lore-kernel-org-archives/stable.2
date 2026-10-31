Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793453155;
	b=MYjZBqmQzbWx9W/YTHQacnvo+dupFBdYAzdiVcpytDKb5aytbVJgJrSvb+wi653WP0XK
	 1IdVsVvThWtfcZzUTBdY/BYTULApTj6s18qsV+URpJHmKfCHKT5OwfattSHISBjSVamZ1
	 w8vty7GfIBd13SOT7TP6db8eH1yUVM6DBd4/esh8fLizdvzyXOA1++f00zyXRpSHXeRd8
	 eMlHLxwTSR1NPGaaski0rwmdZhjBJlqraptC3byNy0fl2pu+d9CKgvupS363uGa/Re3rQ
	 8A97IdCBEGNBlW0w6PY/XxMy2QAkpugo+qEbK/pfCNKKE1m4JWD5+BVXdc9wXtGkIBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793453155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=KPfnmxfgCDKDTWO31v/S43Fdk50UfG3zZwHnYB5OXFQ=;
	b=gzhvqhQA6ZpduxwQChy5ES76A+3qMfBF+vCwU7fyO35NTatBMJvPwqRAq6WSDkgoQ+Sm
	 PCqN2uJh/3GAMPS3eKNi/jV7GtVuzGTAqdypH4n4Uy6fJAWGpe701mQ+nqlQqIfItkJ/J
	 TzYt6N759WzrDuXCbnw/x8+ra50y6hsbrX5psFfJ5Znxend4oeduaPU7Fp1oXoM4OxExz
	 azvWjLW4L3rI1Dq3703FBYTRnqmwPiUZK5E9liiT2HX/4weInGC3HJ4PvMPJgbL7Vq0Qm
	 uthfDfs/FmCICk9DgjPRR2Jp3JxoKifPUFsck5Dtow8EKJ7dVGvcdX1V+KFpd4yWi8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="P2Pm/ONo";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.170
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F6A606A31A
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 13:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65F6A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P2Pm/ONo
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3aae7df0971so11790671fa.1
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 06:25:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793453153; cv=none;
        d=google.com; s=arc-20260327;
        b=AruxQoO9g3z9CCzxLjFZaCWMkesVDCwQFrOrnLl+wub4c/bEEDE6q1MOCay3HeUmCy
         +cUwYpGc+Stcn/JhdTwFneLH9bqmX26Tx4ux4o11X6nk4kDIm9BtoU1PWhgreL1fQRkh
         E8krZ1Zkh5llDLdOdQjx5raYkGSVlyLvdbsWMsvenQQIA1/hR3UG8ZzyJMCJPxTGa+q4
         yr/AJqLS8Kv7HLfBcNwF5ADSbyT4K+giSTzt65Q22S9If1r1Ifghz64TsMgyJsfVFbFw
         IHctAzH3AoeIkZLifvYZjO6jA4k57lDMDSX+YVhL9uE1v7qZ3GoNNr9sTKkogDR5TnMg
         RqHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=KPfnmxfgCDKDTWO31v/S43Fdk50UfG3zZwHnYB5OXFQ=;
        fh=k2MquQ0asBstld4T5nb2C7wZxsF2kJQH11ugyqkLAjs=;
        b=YELVhrZsbJVBAu5TNXe6QQxolTy4962gGl4He6JitIbcohz15cmbevofv/Sn9q6/BP
         syMABzz1mmmDTEWjaKzHRUFjdKDQkuDki21aaByx4rOhq1foviJ2x4u3XU0GK9jJRVX4
         R0KyuSDQVGvolUfpmlqjDl6z9cDWxgTGrUYA7jozlHDbe7WXAQbeiV9cUp9wMEYdLix7
         1DFpYSyfzrTwkNROPAWteC5cpz79biiezvxD6BC0kD8Ruae7yFoZjN/nEzgppGJbwWHh
         8cFBF+4i8fCD6IDaB0BHnJBFWTJyvqin+IqubTYM93SNU+DjVTvFsuCAL6mUa1k5L4KU
         W7ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793453153; x=1794057953; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KPfnmxfgCDKDTWO31v/S43Fdk50UfG3zZwHnYB5OXFQ=;
        b=P2Pm/ONoyd+lZlQ7fTG+skHVRZhrFCZCzsL2cj1C6Kq4j0LSZjrVFKQ+rTrKCfG4SW
         GrIbAkCk3K/Oq2w7GJE09FYv8XSlsjPvbESk1b1DsXw++iDAm3twsDm3JQzr1URUA/yy
         cvkdzU3TQXzKmr2RgfHCsMxkC8cnn0rj91WgTveVWosuv3TfQ5d+ede33AzL/W5edBtL
         b9+WZPsBEDXq1ckGnhITNAavR2i8vUxUz9qkfsMZACGo20LQ1q+o1yEj8e0Dn9U2Ss5l
         Lcm5FlZPCiIGx3kQ4c0AtAKbcZon7XnEzstIS+UPlsLBmwtHSa553LEOJOzYviSptW3Q
         QJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793453153; x=1794057953;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KPfnmxfgCDKDTWO31v/S43Fdk50UfG3zZwHnYB5OXFQ=;
        b=QNrRssgD1DenbMoPFe0KFuQ91xaKzfEX6n73yCUpTQuqFDpHuCJFVGk5aX4nJi9DL2
         8rOFwwJmB0Vx1W629ggMS85xjDSJZ7PsTAN6Sfb01q5B7njTEPnKZTLrUGq7wJcUaf2B
         /mKovaM5IfOejlYN4tMJJ9yPT/MNlGxROQgwd8qo8Ljcc8p5Kz/nAUYc62bZEimZCw7b
         3ZPxiM+3IXOoeecYaX5SmHXC4+ND+B8VpwfJTc1UcCNL9+ZgtAzJMO09zlN3jOWyghZ0
         N9zxf7PlF4Y81oLRuGhWHZNbPKWke5wAHGow4KCoImM+Nzwc4fPzP/lDiL646DzYf5to
         W7rg==
X-Gm-Message-State: AFq9FYLijGBa/Ek5Qf7Oxd/3JG7tOtqiuduIfWhTOiBUqTWyongyKQR2
	bTXF8DsAiRt3A1LNdCaE2oA6L1FCfUm1Saas9aywWSNcBBGZeFnKn5hiVmYKtNChuNRkLYYhPI7
	27RlpJwowSsz87vNROrpKo9/lghh/va639b14q3Y=
X-Gm-Gg: AYBFou2nHLWjQby+g0lib0+tQ2xIoMbK9z+15xvQDVxf0aAXulzMU4v+R+SPWpp5liR
	D7FE0MQp6PZ1+mtIW5L1VhKF9mV0wJn0HYMom5TPRTZ1J+xDqfHfH0Ig+cuY4JoHBoJcqJPtz7X
	T3YA/Uh99vuv//dB5IEx0fvCOGWbxOvgViepHzYsP2StptS3qldLUNv1uzVH23lYlQsiWDIF3y8
	KglqzO69M9u46cFzAgSRwGEc2E26OIdWkvN2QA4xvpurK9e+EbhnxtBrjhT4UFXf5Oi4F903qFg
	TyJbka9kznElb6NmDsf+cjbeMPWaYGOixGjsggQJXFjSLyM+C/s5V1YjiVvd7/gmaz7+mZELQyt
	59F5+dajhlIBeBXUk9K09Ee8+k+Jqayu1Oum9+Q==
X-Received: by 2002:a2e:be89:0:b0:3a9:a1ed:6341 with SMTP id
 38308e7fff4ca-3acb7ac0796mr12426531fa.11.1793453153247; Sat, 31 Oct 2026
 06:25:53 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Chris Marshall <deepspace69@gmail.com>
Date: Sat, 31 Oct 2026 09:25:42 -0400
X-Gm-Features: AclHuK_sKgvDCJ9F1bkXoOXlOpf_BDenBVtCxbUg98CiaqxmUSebTJq8LfgRnwE
Message-ID: <CABxJosiWT3Nrhj9dVShPLGc8dbecjbqwL_pkrZbrT2f8K_OFrQ@mail.gmail.com>
Subject: Request: c182bfe944eb ("wifi: mt76: mt7925: fix reset panic caused by
 the WM2 rx irq mask") for 7.3.y
To: stable@vger.kernel.org
Cc: "ck.chang" <ck.chang@mediatek.com>, Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"

Please backport c182bfe944eb to 7.3.y. It fixes c4edf9e3e0e5, which is
in 7.3 and causes an oops in mt7925e_mac_reset() when the wifi
firmware times out during hibernate thaw, so the hibernation image is
never written.

Thanks to ck.chang for the fix and Felix for picking it up.

Chris Marshall
