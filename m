Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFC93A7839
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 03:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790134153; cv=none; b=mIsMCsof7BejoHGR25tKzF4XjmaiSEF7i/X/TyxfnG8IGHShbmBkpMP4rVScA5c6NmBCuO17aVsim10X14tMRVToMC730Vig5MElaNMxqOjmrEXOEd08bCxBZbMJ9mr3GMccaZS1w63Key6V1rlmmA/ePmkQBNznhqz1iX2HuYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790134153; c=relaxed/simple;
	bh=D5Pj8S6OjuUPUjxDjkR3bZ8oxZf9vtAcRUH1S8TiNyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PK2But/TFECf1lCsjAKEdRBO3E5XTOSprXWbYNt31VZX4gsk5GnUgmogbFxgCRU3dd/yzoVKyGqwrzaum+Op3U7DkrIumvEl/ry4NX6FimNQNfDnd9q6E1hhu1eWuD8/m9v9nXkxEWtFqNlwHzCX9RkTVTurc9vem/NOWo3OROA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inM/8v68; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inM/8v68"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4e4979c47so24486a12.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 20:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790134149; x=1790738949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jcik2WgO+A5TDX3gT8NploWgNnf4BlOc/QIMTcS6Ry8=;
        b=inM/8v68/sHlCGG5EbwKbNGyaBzXFODBcMGW+p9/iBM4TgU3GbAJn4g5alc6Tsk70T
         PHhvI9+WoC/BuMF19acwzL1u8GmT5hktZgmhE86FX4dXblBRmGVtlG1Nh0Mkw6Z+INqA
         Q6vkxjqzXcR1jp7/ZvNF2cLez4ksbZJW0sbCUjKxT5ogH8sxHe8MJb6MfvJhqglSjRpS
         68LJwyOdG/7Um9YlAECuIyijZxocmj+C4axtv7pJ7LJE3y2kYZ/KwlDzXQV8u7x9mSh7
         ZwXxguaiRT4dFbez/zJb/HkZN2g1oteaN5+nW3Wi4jSwByKqWm+e9wKZPEa/CvM20O9M
         WDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790134149; x=1790738949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jcik2WgO+A5TDX3gT8NploWgNnf4BlOc/QIMTcS6Ry8=;
        b=UrmVLA7apFFN3a6yd+JSJxwqwX7N+8S2wwUcBq3kT13iGjazkF6jbQBIODqw+N14Lw
         LW6KeyjkMrFLwajltC4JOPrFjlcGp0JVqnUdmKnb4CT1VKt2YELO3QuuP1X0hi3Q7yJI
         NUGmaJQJFw3DH9vzrGkgY4qygWlL+bMjGQXuNepfi/JLbxNgcp9kCuLlzJ/OnSjpaHCU
         EvJ74/S6Sk10uFvvG3SjQET1b5YhbPa+qrXmgkib9YujBAlXFEGqIZ40AIgzcJitDGJz
         k/Niii7J30xDOlbjztI7qPFR6F9VhO+Z+qyH9Gtplvx0xm2CrEZjRkzWdo0WFJ9g77dm
         gvLw==
X-Forwarded-Encrypted: i=1; AKwUvBxktexSyo1tPjeU1tOtSLO0I2hyF8y2dhF28hHkmxWFzhskW2sP8A71fNxHHI2lmXc6PlgMaPA=@vger.kernel.org
X-Gm-Message-State: AFuF++kWliR71pB9MHJL14nIIp3KVdFbZWKlUFU1XtfMHeyMPvNkF1NX
	6+9c812ah/aTQHkEvzWSbrSRctcatgQaacPlh5WSLcxoLw1yxzHdQBFQ
X-Gm-Gg: AYBFou1oePxf5ypAZtWfV5Xlaunf8nriY2HSLD/PaY1QGXbHakhlRz/R8r/hfbMnG9r
	BQWDYkNeuJAeRZen0kfoOIY8Sscv1ANyo3T+XbgpHQpKPPacUpwVKi8INIvVcyEBzDwYQED2eEg
	i3qDF9Nh7Ucp0wqEn7eTJhYtwoeYzymQ+hStGxaXAruUlJHN7XPIunGl+B92ev5tHG9glXJRRv9
	6oIWRBJEaJH678t2xULReI2Y5KVJr5/AJICMhzs1G2s1lhuLVWyYW902mgkFbnzuOIOxlEopyV7
	KWXrwKcCxWLi1Hh0G/BYttYZN7YATqCXOlUVSa/QuoQlFm1YhVpf0ppo1UzbUH8Q72mpeBDWLuW
	/NIzdS52OpK+S1ncWBSdX4FfP6J5MoJisV3Np6Zcg8cnpuJMpryuSIFweMAA32dCJU9UOyTrXwm
	eRIl4J4I6vHf0d4NCNDl7UMUV/8uF9Ou2FswOsQpTw920nflqnKLT9jCluB07PzyuaYaIanC5V9
	nuap+NhzZotd3qY4U8h5JG3UiOmY1KPMuuP77YsEYt19tNtBkYLcMuvKZfcYVo=
X-Received: by 2002:a05:6a00:4709:b0:864:59e2:2968 with SMTP id d2e1a72fcca58-87d165ce4ccmr1464616b3a.0.1790134149301;
        Tue, 22 Sep 2026 20:29:09 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1cfbfd11sm579384b3a.11.2026.09.22.20.29.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 20:29:08 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org,
	steffen.klassert@secunet.com,
	stable@vger.kernel.org,
	kuba@kernel.org
Subject: Re: [PATCH net v2] xfrm: validate ihl in xfrm4_transport_output()
Date: Wed, 23 Sep 2026 11:28:40 +0800
Message-ID: <20260923032840.46294-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <arM4SS7k7aswJAOL@gondor.apana.org.au>
References: <20260917072226.80788-1-q.h.hack.winter@gmail.com> <20260923021640.38855-1-q.h.hack.winter@gmail.com> <arM4SS7k7aswJAOL@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Sep 23, 2026 at 12:24:09PM +1000, Herbert Xu wrote:
> As I said when this first came up, our entire IPv4 stack
> assumes that this is validated upon entry into the IP stack.
>
> So taking a whack-a-mole approach inside the IPv4 stack is the
> wrong thing to do.
>
> Please fix those entry points into the stack instead by ensuring
> that the IP header is valid.

Understood, thanks.  v3 (posted as a new thread) drops the
xfrm4_transport_output() change and validates the header at the
xfrmi_xmit() entry instead, mirroring the pskb_inet_may_pull() call
that vti_tunnel_xmit() already has:

    <20260923032456.45814-1-q.h.hack.winter@gmail.com>

Thanks,
Qihang
