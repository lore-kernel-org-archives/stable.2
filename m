Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795827873;
	b=eKPXtdwetVqJ5nWOARAI3OzPUbx1czJE8Bjt9ckHbSMf9OTqGe2Y/QaL8a9+LAT1sBqL
	 D+yORjMwQzI4sIyBRGULaOfJiZWAShST2FIVK3xJmMn4pSuyZOxMniQ1RxbmBLofb1/rd
	 HlAtD32BLalNzqL3Wp7NIuhzlyGJA1lOzHfkTBXVVrGtAHs2HwpbWJAIn5Qe2bf0srIxj
	 tcv9pdOG8HaxpcCeo01HkuRlHsGbjf0FKdPUXzVu1X8l6pEe7FwrTAME/lZMq44DVJkYn
	 2bgArzz1T8VfLHnXqgatMRMum73G32gePUlaFU/OklQm3upMDwG3jetuSp1m5kPqV0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795827873;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=AcNCtyIil+7PDZKj2GznaKRziU9lVCwka+/OixA6CLs=;
	b=ic0qyhYrzBrdQ/2LXtnThLS3/yGnJgHpDqPXXj65pYPJLHeedtnEIIARbLIiE2i24ABT
	 EGT5wjvYFMx3Ad99sIMdbUte2rhkJub95b39rXyjiuMzg7WVdcVUT29FNVkk+lRDQghar
	 Dp6Ph5jzvlqsPeUv0CknE0VgZ0uHW44HrGGNFb2AbzggiVMmzNGyqy+mCofFmFZzIauQ9
	 JqrLEeUhJ8NnT7EcsZWoaszqSTTv6KZ1BKEe+z5QNk7ScqBlh2KZdWZrrWnxWc0ho9E57
	 sBn3qy9DabjM77hQHtJvDMaDtPABRyQOJdKd940EbRTphpFwnBzlvAZwCtzqzgoKj1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HgM/bEnG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7706606A31E
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 01:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HgM/bEnG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B4D1F00898
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 01:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795827873;
	bh=AcNCtyIil+7PDZKj2GznaKRziU9lVCwka+/OixA6CLs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HgM/bEnGXhcpZWw/bczAmNTXKH/oIAVpLFH25L51wNkwUXspAywokudLDLE7FpA6d
	 rqQdSoxA+0nIvzGIuBAmSbZnbUZiCT5LF0emROG1bhnWKigP7Z2hN2PYgSoTd79Cq/
	 SzJe0OQ+e77zHtFoW0B6pVOzNH0LD1vLq3/VfDVV29YEzAGmFLaicvl8GgyDz6zV6f
	 BdTl1oYzchlSNJuVN9SHqDPeZzD5QAoIgB2wpoMcnyL8hGo74oxUOyViCax62MwLfH
	 d4gjCsAIIpaYc9BCe3ka7B9P63wUI8mlEvJLrLOiiMjMqUmSBYyZIDaQcOry2mjote
	 Vg7oxmXiZUk5w==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b8c60e0d39so11110482a12.2
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 17:04:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFLe5uia0bhrKDSXqzFnCrin1IjuG8vHI/IUqbTIu/sk8mTf3SRIi5iANvmOZ8PhoGUpveMq04=@vger.kernel.org
X-Gm-Message-State: APuU4Z8u0RnXH+kbJnOaC9aFJbI0qJYFYOoFShPj3rgU2wh7Oedpv378
	/mTEmd/UATdQNoewR3ssxMlb3hjIGPstLwkFvTBm03j4wNKuQmvBh77Kv+2qQcLgpZtR95l3SV8
	w663GDoTu2wP0LW+dd/9PqBD6Ax+Bo5E=
X-Received: by 2002:a05:6402:3553:b0:6bb:2049:ca92 with SMTP id
 4fb4d7f45d1cf-6bb2049ce80mr8851622a12.18.1795827871879; Fri, 27 Nov 2026
 17:04:31 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <179566442733.1993761.5390442849622005459@163.com>
In-Reply-To: <179566442733.1993761.5390442849622005459@163.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 28 Nov 2026 10:04:19 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_Ts=bj5SqxhfjMLLYVGgUGpoHRTDdbgWLaH6CjV-z65w@mail.gmail.com>
X-Gm-Features: Aa3M54oTFIu2Wwl6K4m4iCMKi59ejhQbKyYIjWLNgD6BSOyZblrZyH7rM8lGjFw
Message-ID: <CAKYAXd_Ts=bj5SqxhfjMLLYVGgUGpoHRTDdbgWLaH6CjV-z65w@mail.gmail.com>
Subject: Re: [PATCH] ntfs: avoid re-locking the parent for stream timestamps
To: shaos <shawnq1@163.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, ntfs@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Fixes: 3f11c48d4f94 ("ntfs: add pathname access for named streams")
> Cc: stable@vger.kernel.org
> Signed-off-by: shaos <shawnq1@163.com>
Please use your real name.
Thanks.
