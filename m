Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792967137;
	b=rxlV+KW219eM/kzkdmZaH20rrQz8O6cji5LiDPLajq/96AgCNNhE6SQ74IteaB8fmqZw
	 gRAHO3UpVnnGl1hAfVNt+hk6ZmIXzr/bZ7i+ZTEWS+F2pTXOSz5/WdBgtS5UD0zZjVR6l
	 H9pkleLsQnMOf2r19atxiFc8LB34RbDVOLQslbTUtuEZYtznTIcEyxdiBeLJ/8jjlnapF
	 LfV50n5yQLweKrtgK/rcLuPkqOOgAsroGpFbbopPE58R72sIEwTaKDCrNDXF02MPwEl+u
	 k8zDJtULKst5oUALy5eFpxIRIQmxatcWZJ+qvhBa0HuIDvIdj3d5g+8PlDws2G0V79w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792967137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jxWNiiMZU2V+Vwzd05i/7abkd1YHSREMmJ+NAkrs9vw=;
	b=Qx3CSog1jB7wggwQzZ7nq9PyhFnixqlndPN/gWOn8SF6K9qyHAiLxBpxQXm7vE5CKQVz
	 8U267rL/JxlAOB7hzZwSNgSOqNtxXz1XIi+hVaSE2MBoo6Uy2j6orRfocRCaMotfeMSb9
	 xzkgRtl3S4vV+tKq4GsOwbLvx+ZW/8oLU0dgXvqgF5f3RzqqqVeW0PQgKo16Fj2NStmnk
	 jd44cIciXn3/1dYXxmPUMHYKvUYgRSQQroC9eZBqk45GkPI6VDvABZCwrf94q3fEPjcjd
	 tdbIrtZUQ5A1/OWTg2kiLees/41qdbWKM8SOrKDi2wwuIU+RU3s9HZwSUnRDCWb5dUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GMuiN648;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A565606A31B
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 22:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A565606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GMuiN648
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48c5358fc28so2239722f8f.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 15:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792967136; x=1793571936; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jxWNiiMZU2V+Vwzd05i/7abkd1YHSREMmJ+NAkrs9vw=;
        b=GMuiN648OFl980xtHBvqjE1Y2JmTydPOMaJfxc6rcetGvFwivI34HQflhLukDqw/Xv
         xhmMhR2eWHdAb5I3Htu6JMb7gN5sVRodNkXL7OfieShBOW+dgDGbVO2ds+XlQmzXPbhR
         DW7j/hXd1YMWoD16y8U/yrzSQQuL/18MHp6HT3LdkX/b15nOwmfPLembVRlMMzo9469n
         9y1iyP97AQvt2QApD9YPGZ7bz0vxB8HFnTHDiMOdHaUNmmtWrjhByk45NnsUAfv8NqBg
         sEywqtlAj36W+t3Ba77kTHcY948opf8++LxyTCLlELnPKk11mK7RBHbpK5T+adAPgUS4
         g6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792967136; x=1793571936;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jxWNiiMZU2V+Vwzd05i/7abkd1YHSREMmJ+NAkrs9vw=;
        b=hpoP2HJ4TY83VErDMalMv5TJXCdQ2Rse328D9L1w/GVszeipNs3FUFvusm8IdfbFBQ
         S0aCBSCQbwcM9F6pIMwl6/1bfb4ACxuF1S0m96QMzCbdv1I/YuIJsN8VjlTECdw6f3pn
         INAEA5yIaxzMo2GeM1zKQ4n58UoC9nMvSvzKtcNZfRaVPav2Ycydkw5PhIwn7g4lPhrX
         VhoWakWCKtKbgRGapo4KIwYCLEVuklT1+Lyv9NkHvbjuBeUfDjFO30/Y4v1Mx+eN0AHc
         5qTTJ5kEqzulW7JWVgofnh0ig3q3dhUBbX+117M03L44q0OYwllCuNuAYIgQtjTTeD6+
         JZzw==
X-Forwarded-Encrypted: i=1; AKwUvBw0nS8MFzCe0xgb3YGW6bD0lprJfhN16wmLBDWC+aHb8/JuhrkkXssyhOr8iV/MUEGYGnwN0Fc=@vger.kernel.org
X-Gm-Message-State: AFq9FYI4hwK03kBK+6Zyq+DHTDhFuMvF9h8AbU/s7fTVeROqtOT7TX3+
	k7Q9c/i0RuD/y4uja71GH7E0qtx+H183SNFVZcWoRwkWrbLcUjCaBog=
X-Gm-Gg: AYBFou2LaYHeWOdFVRE1J+Qm+Kn6TgBYw67X/JTYrODQMzo7MAkKUD66lehqmTz5OoM
	CthiPv0G9zdw+HNdMh/yT9KR6XLZRp1Xsroymy/IzRbb6mAd7XrJEG9IJclmxOmMD5KuQQUJXzI
	wiSAnKLjAIxNB3Xrt8ZNF4hIK1CTWvM+sgYA4JHBdDc9kuyCb4Kbi3QamCfoyBhNOpjNwAmO0Hg
	ufHLTxx9fjYzr2wmuwfZrX1bBnfirI8pa5Xg0QYdj6zcffcQEcS1+uvRWRiwo1HN39nxbq/YYwN
	5zIQhXz3FyQf1IDBXFZYqWw7SK8kll3ZG5jcuAXmyVun0DqPJGEc+INpp6lPB3A6/3mhAXzyhWj
	nneK0V/eKSHpidbmLBzjqCK+518KY4lUsnsadWnwqQAMqxFkg5oCxPE5aseBEWIk0FKrBGsLwG3
	EB2sg0PdC3d8i1B22XfSuAdtfvfJs1rBM+RzOMKOl+FFm5ekawhIFHgmMdf+UKM+32kLtsqHpX6
	Ti9zWHgDH682eDiEaNp4l+5xTnX87OkN9N6Sw==
X-Received: by 2002:a05:6000:2504:b0:48e:1421:ed49 with SMTP id ffacd0b85a97d-48e3eb75c9dmr9779933f8f.18.1792967135658;
        Sun, 25 Oct 2026 15:25:35 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e412cc164sm11555816f8f.7.2026.10.25.15.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 15:25:33 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: netdev-bot+sinfo@kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH ipsec] xfrm: fix output state cache TOCTOU in xfrm_state_find()
Date: Sun, 25 Oct 2026 22:25:32 +0000
Message-ID: <20261025222532.1080377-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179278530870.3327.6992676893660130130@kernel.org>
References: <179278530870.3327.6992676893660130130@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Found by manual code inspection while auditing TOCTOU patterns
in the xfrm output path.  The issue is theoretical -- found by
reading the source, not triggered in production.
