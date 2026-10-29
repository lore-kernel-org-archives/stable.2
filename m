Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299417;
	b=MsA0JMxZYcRm0YRKxu08ZAjRzNPU+RtApdu9pqldPEgHPoMvweSdihfvqRRFeBnPK4oM
	 KKNtykyuqd8GsK3+mWPaBtR1d/XyEWdzC26qOCCZKp8LtLNbQY4pf+a/1XhBf6WRiH6VV
	 hRhQpUqfK8ulI++P9QAWYP+F3vdLpsV/zSAGj0ox1Ysu0Kn4iLe+yM8S8X7jy9AwWXT//
	 KO2o3iFR6735qph0PDnDPySEfZmxNjhcucnjaZwXJA6WQLgdBkGQLGSHmNB51saaNeU8O
	 KWhOG9lgwL2BM5/eCosCkP15rvzRwPtQRxjYx1NW6lI9GY8HKJ6oz2SKp4bI3B6AdPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299417;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ba2K0yn4sXATn4PEJjhjICZlb9eDtb5zCcKhX6D/8TA=;
	b=sqKNjsCt+oQ7occFovzZVar9SnW10EI7vlu0TuMwkOewGnOv5F0EFo2jcLP+/uqfHPk0
	 pcmcQ0pRM4L4WpNyh51sW7jUYnfv7X5Vme/opBiKsVXknx6+StJVPwDiQ0dD21xlDRpSY
	 NQ/BaJjvINzP6wtLE2zT7jWhr2Ulhlrdf/SJcMYww4d9oHiYkMM+NyU1jmUcUDFQb+jfL
	 LUksKqDHCXjB8Banjs4EyGherGGtP5DqYNsNrpVbI2poBngSyHBZZNE1diz2xRHSM2Aed
	 8HogofweuywlS53anG77gol40I38HNEx8iJjCSzU0cmUQZEEpq22DWb8zk1qFHyL8dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KqB57ZyB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF8B606A331;
	Thu, 29 Oct 2026 18:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KqB57ZyB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85401F01816;
	Thu, 29 Oct 2026 18:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793299416;
	bh=ba2K0yn4sXATn4PEJjhjICZlb9eDtb5zCcKhX6D/8TA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KqB57ZyBl+rNWmzhaUl88koNS267T6znjRZInstBkbc7Ck2//RGFluJirsbumaTiR
	 ty8Eiku257jINNacFaeg/brLMVaR3rx9pu66kXv8JNtb2yCEBDpOkd7HuZdMuWMETz
	 GJyytL/AmBMOXjwaZWIkPhGYDug/AhUu5zt93aRQlgunkDyc2LiNaEcczacBs+gsiW
	 cgukT/h+BJ0wBDNHjbcBz77nhq5Lyaad8VB9yP99NZlexuXhrr5V1ixKD2KU2UUCKv
	 Q1XFlN0n2PW0JoONgoYODoc8nd9sDEzusSps8ub2CdsmcwUFlh1azXnr+k2sgPbDNd
	 vD43kwovx9apA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	ebpqwerty472123@gmail.com,
	paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	yao.zhang1@amlogic.com
Subject: Re: [PATCH 5.15.y] mm: call the security_mmap_file() LSM hook in remap_file_pages()
Date: Thu, 29 Oct 2026 14:43:10 -0400
Message-ID: <2026-10-29-1-daily-reply-0003-remap-file-pages-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028080719.1821-1-yao.zhang1@amlogic.com>
References: <20261028080719.1821-1-yao.zhang1@amlogic.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> So we should check prot by security_mmap_file LSM hook in the
> remap_file_pages syscall handler before do_mmap() is called.

Queued both patches for 5.15, thanks.

-- 
Thanks,
Sasha
