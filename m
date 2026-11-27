Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798914;
	b=sHby3wvDeGvecvXQAR3CtajQGSY0herpe91Kf5YgMfzkdog9SzxhUot/3muaetHY1fM/
	 Ztd83nnaB7rdzRB3E4j4dguuBIV8Owd+XLeLp4eOevEuJuIojB7+f50dmb5mWA9Te4H4C
	 AqXXlJJYnK1QRGVNGt763L7eX/y22yEwq7JqDSwgM8PVGDzChbv02ZLdmFSe36osAv3+t
	 eeZzso6XYF6lRGLzZFiXujH84gEhIs63a2MwYqKa+iHVpaJO6TgMqvDvTfXJbsasvcgl0
	 X6R1+hKqqz8pL14OfnwMrnrlVBsjwp1WGldcqxzAUwG6BdzAVs0P7eM5CtdZtzBKypg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798914;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=R5UjKXVQP5ts+KvBCnP3ldyw/aWFcIq7NvJ+/b71EYc=;
	b=vGHndOb3u/WXwSb99+LGXvJNLE7Lq2Z+KBF8QqFAcc59AaVi1ftKuTKQyB5xK+zwbnQe
	 aqtoPLTP97CHkkHW971qSI1j2RlT64/82oSIai6ucCptSLyYn1+NDNfyt590FVWWMHx4B
	 DSSgklYObafHrgRWqsc54GTMs9XP/aVVWlYKzYLJwwKmX/xGqsxB7PN3RLv8FoFUrJz5Z
	 2EK0Bci1J47Yju+NYydYcfeRmro32Lxa5Y3c2wm9SfST83CIlYlzFhGnWAHhqlGplBCwX
	 rsqiKGCUxuuim0lfrdyZniAglEMDOhZ6GFReoknPC/058eenSAIcVvqp9W2n2Pg/WoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fYx8YIaN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC888606A32C;
	Fri, 27 Nov 2026 17:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fYx8YIaN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8CC1F00897;
	Fri, 27 Nov 2026 17:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798914;
	bh=R5UjKXVQP5ts+KvBCnP3ldyw/aWFcIq7NvJ+/b71EYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fYx8YIaNxlgj+xeRpCxf/PYP5RDyRS1uInydgxlkv+TEC/vGS9GEYx8mq10mfxPOe
	 Q6MeNdfT1YpzPVhs6BZBb+1Ir/GILzKBDo3b6+F8QjhwQF0SqC7l577U0PLNeNmQNd
	 YOXZIadIXKzr6gyoluDcSvDllQvknZF1jBgBER4mPEFr+lqmeglpTu0rQBDv6f1IF6
	 lXtSUO1diD+890A7cp+AmARCiqZLs6tvBBEJKs4StGbRxumiJ2xqYtr0c7fVxw5zT5
	 aEV9DnZn/0bURGrwOtj95JHrkl51Ww01LoKv/E40jOYcQB0flcNdDG5zXZEmPZfV17
	 xVYzEyhGc8sHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	andrew+netdev@lunn.ch,
	bird@lzu.edu.cn,
	davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	kuba@kernel.org,
	n05ec@lzu.edu.cn,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tomapufckgml@gmail.com,
	yifanwucs@gmail.com,
	ylong030@ucr.edu,
	yuantan098@gmail.com,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: [PATCH 6.18.y 0/2] 8021q: reclaim cleared egress QoS mappings
Date: Fri, 27 Nov 2026 12:01:00 -0500
Message-ID: <2026-11-26-1-daily-reply-0012@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125194534.52951-1-artem@trailofbits.com>
References: <20261125194534.52951-1-artem@trailofbits.com>
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

> Please apply these two patches to 6.18.y. Together they fix
> CVE-2026-46153.

Queued both for 6.18, thanks.

-- 
Thanks,
Sasha
