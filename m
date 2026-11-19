Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104529;
	b=oO1/w8lahIZten1EPURIvFGuITyYk2izwr+Xe33qJpKedPlmUmpVL3lPNHXY12zjnE4n
	 KDlE3/gyhUeENYQ9mdfkZk2aFjRyF44zLNfWYX6oD6tqzVi8ceth7EvTKxRqP8Ak4rnTw
	 JV2IcoV1YFpLUhsP40n3DdufBkgr4+s9z7DLG0l0GDtOKRJZVjd+OexA5qOZK3nA6k+BD
	 f2i6I12A1xOFB1bzbK6Z6At1HegXzRnKZZRhLuAvUrtLPrDQ1NVVYeNTZYc1qSsxo/S1R
	 NOXnRMrRe9Qo7mLDZPBu9jMLLzHr+VYxV8TG10KTMTx7Xcl6DCwJIx0yK9KhCFtZmNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104529;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SDVJUAI7zVAkPhpn5PQi2XR9YVIfm4XrM8Lb1OdDL0I=;
	b=S9dGUPhhPLCfKfu0+M2adynrCFnB+K+OmtnZ+cBpLSud7Y+YFo5jMv1NzLZFKUifQPHY
	 pziJ7yVveJCu7jp/YmJcjzdO44BnySpX0zjgd1CDzX1VliV3PWC/7sANArVMmCXqcB4Br
	 Frlpxv06B9b+ar899LJUjGz/0P3wZ8iTHi8nN2e5lrLT0uo0LhsaHSvyveGUiw6iXpEQR
	 qn6X42VVQ6G3b1hmO+rIZROSjvVXVK2vdWxbQXGK3mnWBxuZNIXN6cDRxfsvDLw+hhLuQ
	 QIEYVHi4QUllUyGHpzNTnVnxPwgq+vvxW1Wtws1Znd3DitWtJbA9WLNk6O/K0Mfa9iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h4zfKEl0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D1A606A326;
	Thu, 19 Nov 2026 16:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h4zfKEl0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC4F1F000C4;
	Thu, 19 Nov 2026 16:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795104529;
	bh=SDVJUAI7zVAkPhpn5PQi2XR9YVIfm4XrM8Lb1OdDL0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h4zfKEl0Cwl6F3SjVcqk6reRJapQDQ52/6Mq2AuOtJO4fJGN/Beut4e7iWAyesDcZ
	 1gzEd6Vr+8UpbY8IbAgtXqa4VQDlNjI9HB4hb9MjDXJRkAK+tRbv37XJRcjo8pWR5L
	 oYykbmnDi+2dinoLgf6fBfeZc5FSGyBi23n/1sHPOrFTH1DZX4c8msDowINN4RzCRT
	 OiOH7vJq92QStuDzWAmCk6gC8HMN8kD89bUHt9yAx7uwI0fpUXD2RsUXt2SYdLCcTz
	 mor6pYLlBwCIRAdxGb9//Rp4udS+B4NW2WGx5FHf1bQWe2cuQiavp2HSXLnIcOiSUn
	 3XxJZwupPo6ag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Xiubo Li <xiubo.li@clyso.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	=?utf-8?q?Jordan_DESNO=C3=8BS?= <jordan.desnoes@francetv.fr>,
	=?utf-8?q?Jordan_DESNO=C3=8BS_via_B4_Relay?= <devnull+jordan.desnoes.francetv.fr@kernel.org>
Subject: Re: [PATCH 6.18.y 0/4] libceph: add CEPH_CRYPTO_AES256KRB5 support
Date: Thu, 19 Nov 2026 11:08:16 -0500
Message-ID: <2026-11-19-1-daily-reply-0014@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119-aes256k-6-18-y-v1-0-bd5db87da2f5@francetv.fr>
References: <20261119-aes256k-6-18-y-v1-0-bd5db87da2f5@francetv.fr>
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

> Backport of the libceph aes256k series from v7.0, as discussed in [1].
> Ilya is fine with it going to 6.18.y.

Ugh, this really looks like a brand new feature... Is it not?

-- 
Thanks,
Sasha
