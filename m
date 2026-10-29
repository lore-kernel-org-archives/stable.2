Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793271130;
	b=I+0NqX0mnUVfRfNYMIrMQ+FmOQuNZeDKJdko0lR4K+vI7XTF/r74NHCnPTUuw7zPZzJb
	 kVyJnHrfUbuVB5L4J0+wVi7xQaEFwFTZ2QNz07rRHAr7TOOmhOOcLYwwujoU0kRd6Ftf0
	 r6exmglcz42tS8tLQW0AR5/GfXdumaY/ahXnpyzxofYL99UYselOpCiH4rzJzG6xFpiIJ
	 Jkf1zOBghliqXwtBgk7/rq2MgK97QJSXy/NyPeWLV9Ig8+gVPX1f21M7DOPZhkjxTntL6
	 Cwe7mHZUb5JXJgN8fS2VrJpjVrhnYF5QIXKHpy8CGMrojaD7ZEDvFYNMeewl9zc6Ewg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YJGyVP59UIBEumPiJG+nyeTNgoOkuxJ2PfWkUy2HMTM=;
	b=c63I+eJrtrFkNVUYX6htRJ9s3UJ9ftuaFCjyUiws17wtbskFZh0u2mUxboi/0TNgCsMi
	 MLXlevk9Rw8XxOtvx6uEevrS1NJDor1hNalSXyY68mE4jZAdXU+MOb25EPqJlSqCJsP4d
	 DLNA10ubKk85Q+/8G8vg7I8TmyU3QfHDf4XGxiPxSPsPEWnl8IarrEjPxu5mik7rifhQU
	 ZRHBt9GURvyERhm5cz3KhuqvzYvqY8+QGkSjQuGKFZMyve1AFw+anjnuZGFt3tbmyyJf3
	 /JultyqJSpQh/yjQ1bs2b+zQJZT9qyz1XZx5DIQJVqWMH2ScjJcJDk3VI6pblMm65XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XW1nzIQi;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8CD606A337
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D8CD606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XW1nzIQi
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-14fc585291cso1762912c88.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793271129; x=1793875929; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YJGyVP59UIBEumPiJG+nyeTNgoOkuxJ2PfWkUy2HMTM=;
        b=XW1nzIQi4H3OuoU9THImPRKoMX39uKEa2/UmpkhhWUjm7EAeJ3Adb5D6ulc47NdL9y
         PBfxdvqQykobWATR78jKBnTxW2BoqtbN2mlkcu/98Eym8KoX9Hz9i+9GPgdgUdvRx7nh
         Df8q5C3sHVHkDmxTFfIgn/QjWjPSfh098Ib56d6Jt5QRw/nxfTdRBiuaG7Z56rNy7qdV
         /K5qnV+0RaS2HCFdHzNMmxg52y3rkcTCndb9slcH/OoGh/hfK6G/ishCVpFATqOTLX6Z
         T1Bwrs38pdoI/4HR185QyfFDn2AdJQjx8WjZd4396IhKTqfMY05x07rkO2m8F/jHBF/U
         6n2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793271129; x=1793875929;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YJGyVP59UIBEumPiJG+nyeTNgoOkuxJ2PfWkUy2HMTM=;
        b=iRZhUdNgH6ljogi1owjkAm2G2mIEC3hSw1QXLGeNwYaHSqkJS7TQ16M+YbFooOaDLq
         57nOEcuv3W2Y81WJTxbFB8G3hDpPj1X+gYqgifpmrjd5dENa/4s47gDYPWVtXK6SUumR
         eNktl/z24bO/+l3jzRiHWshkefwgoKX0x4uw8+RKpDi9tvE9iQeuXe7FXx54G+e85SXC
         v0d2HTOljiPR8EBCrlcwtmuOXhsXQyim31inMaUclDk3QHiGLfFeA6CLgnct9aEEpaa7
         L5wZR45/huCGdiDvrmxqAJGAdmRkPjgsqlNUSZwWIQl0fmR4LqRAQFnsHVFrQgrWvXh6
         mb9Q==
X-Forwarded-Encrypted: i=1; AKwUvBwvWP5TZu0/qn2h5iKXHI8cTXrUio26MIn8Av3DxOPcRZP9ovWc584gmL0XoCR98vMlgtlfaiA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzNOn62N0J36EMD0Snujg8uyaOp3ZyePYIYehmTPbXK4gP6Xlu
	FLvKvmCmXxGRuddz8NGaP6RKTE3rvdiqgdtpsWF24m+HmRrQ0d2ndOpl
X-Gm-Gg: AYBFou1RqR6McP1lemPX/sPQrKn7506kilXyqzBqtuuPmVeo4kOeIbF8l43qXFEmzmc
	WbboH5ziTP7jPtu30OAnVxNqkZtueF0l7KAYw89Fu5I1RwSruykZFNDFksC9fsSKh1j7Fq/aSqQ
	vrKxvJoICxfgtLvA1Y4ozB1HFNnrOOaHPa7vhQOjs3bsqLfEmhioyP8f69UmQjgr5HYOfJqyAbl
	AbiiLm1RiGi2BFdAme4jANGl1gXEidBr3pMMWqfGqOLCChVyyBRFcyhQx4AxpTUhB8MDA9LA6S6
	VAewiASJCwRY9u2EtZOw1kdcwriPNN52gOpEn/7F390LUkLdHGdQNp+aUc1YOpKfA+HJH9IgIFt
	jIxJtHLfy5a/wrwWeexp/KDJRJ8ixl8RjtZVz/uhkT+VkLWwni8lNEbpjMFseUWYN1N8eaXwbhh
	uXyiQcwv9jHe7YZ7OSzPEKpl8SBMj74tFgAyjgg+DVJraVipobPYndoL2zKfLDkUkkxisu906GQ
	qycmjOoGUV7KIvEyPQ6vgjm3GpL5ElkDAPDj6ylTEIToNwtGwCAh+kGTxfWPy9w9Ob5lBahwNpa
	9UmN1ujxdreE5XWuMd6P4eVhaPtW90m/KhRYMKm88sR2PMYG8jDx2Pyqn4PkKW5AjQ==
X-Received: by 2002:a05:7022:622:b0:14f:8d59:edcc with SMTP id a92af1059eb24-1a6cd3a116cmr8983973c88.12.1793271129261;
        Thu, 29 Oct 2026 03:52:09 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75fdc1031sm14304398c88.19.2026.10.29.03.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:52:08 -0700 (PDT)
From: Joonhoe Kim <26rote@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: mani@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	christopher.lew@oss.qualcomm.com,
	deepak.singh@oss.qualcomm.com,
	pranav.phansalkar@oss.qualcomm.com,
	andersson@kernel.org,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: qrtr: announce local services again once our HELLO is sent
Date: Thu, 29 Oct 2026 19:52:04 +0900
Message-ID: <20261029105204.2577-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <179303637610.3134.6464335759134048296@kernel.org>
References: <20261022163116.1042-1-26rote@gmail.com> <179303637610.3134.6464335759134048296@kernel.org>
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

On Mon, 26 Oct 2026 17:39:36 +0000, Sashiko AI review wrote:
> - [Medium] In net/qrtr/af_qrtr.c, qrtr_hello_work() replays the HELLO
>   once and never retries, so a failed replay is lost for good.

Agreed. In v3 qrtr_hello_work() reschedules itself when the allocation
or qrtr_local_enqueue() fails. Once hello_sent is set it skips our HELLO
and only retries the replay.

> - [Low] In net/qrtr/af_qrtr.c, the new HELLO replay in qrtr_hello_work()
>   is not serialized against qrtr_endpoint_unregister(), so the replayed…

Agreed. v3 queues the replay under ep_lock and only while node->ep is
set. qrtr_endpoint_unregister() clears node->ep under ep_lock before it
queues the BYE, so the replay either comes before the BYE or is not
sent.

https://lore.kernel.org/all/20261029105142.2503-1-26rote@gmail.com/

pw-bot: cr
