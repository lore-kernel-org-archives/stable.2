Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537227;
	b=LkTmbC0SXn8ReQoCyTLWERmZuwye8Q3b6hSq92ZFtl6I9Muoa/ogxURnWQABvMNt+9jv
	 TMfh7AHrbwhYIqES0nlYO2BztEswm+u2i4YFZtoV1XA8dOXKegyki/Psek4QH6Pu0LL8/
	 TirCNF/uLmPexa0FCLgCAw+dej9EDBagzM2kQXfja3wvo6hkVSVOoUGi2DWOW98DjuJfa
	 b/HKfv2xbsaLyGHO/mO6sd7R+c5rdrTmyK7jryx8Rfc8NMG6ttVq77cCKeQlt9cq256bM
	 mzfIy+v42UUihW1ABB/t1xu3DjuzdiH92J9W1qsip8QnxOb6vRePF+d6QLIsy8/MqQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537227;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8ZtizZhbgrEHCSoKDXI5kt1Pk0gtoi/ng0ueIJWCX1k=;
	b=1hlMQ84C6JlK9S3OxZcyBFCcj3PAvLjG3S1Y9ZjwK+MsI0MG6+2ftVL5d00rjwrLUtPN
	 tFhlIUiNd6It9JYwrJ1gwHGSuSfLAGS0c2VOgyu5nn6ChmpkNa81ypVwXtAETWBUqMEPC
	 MQ488pjQ1wopSs9Y3FZIaWsy4371zlfVZDipU9vNxrLja6EyOsJrmGYAjM4LBBpdyX0/W
	 oEkNXNLC8ckpHNRmeYfoi6dyRNHt7F0R8ZszyzVmT3mKiXihtg7S7mfEOaRLQZ/HjX3A1
	 FHH212YGzQtWld8ObH1qLDEnYNdWQm/O8ioDBgvnqZ8Pxez4iVbm1awhIZcYdgbPMKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JAnLmMhW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9D4606A88A
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 02:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JAnLmMhW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A038C1F000C4;
	Fri, 13 Nov 2026 02:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794537227;
	bh=8ZtizZhbgrEHCSoKDXI5kt1Pk0gtoi/ng0ueIJWCX1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JAnLmMhWDcpQM1Xk5ChXA8w2shun19o/7KpvLS6MwBUh4NoQq6I4Nv0XsiaTk2dr4
	 FVVU3a3IIasj8JxSWV0u4rRwYUzw/fjXQzUIgNRCLWeQmmAkj74K9iHXuG1xIQwSIT
	 IdqrkI3RGK93NvJZID6nJCLrqFecZvcfhUhrBhQox0KxcGEAN5idz9by0gGHROmz+7
	 Ah4Gbsfr8GJuFRGqtq9V08ZUhcwCnYZzvQgUfSl6JXgAtyInUnDjgoHKEPD/1MSbky
	 73WXDPxKisSQoYhFvypMlJsR0ry64D+dscwajCKG6/ktu6cl/ElvqQPGsDLbk5p/mE
	 R5tTUn1eOzHSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
	Marek Czernohous <mczernohous@gmail.com>
Subject: Re: [PATCH 6.6.y] drm/nouveau: disable the fence uevent work instead of just cancelling it
Date: Thu, 12 Nov 2026 21:33:26 -0500
Message-ID: <daily-reply-2026-11-12-120429057@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179447220252.849346.18231918170218281434@gmail.com>
References: <179447220252.849346.18231918170218281434@gmail.com>
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

On 2026-11-12, Marek Czernohous wrote:
> [PATCH 6.6.y] drm/nouveau: disable the fence uevent work instead of just cancelling it
> nouveau_fence_context_del() drains the uevent work while the event that
> feeds it is still armed:
> 	cancel_work_sync(&fctx->uevent_work);

Queued for 6.6, thanks.


-- 
Thanks,
Sasha
