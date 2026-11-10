Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344389;
	b=R8r2a6wQIrveomB1GIVV3+8/5w/ckfFYBYwZlCftzfyThlkbqKIwtvJreu4+WsXzL+Rw
	 Tc3taoUIUTqpauD4fpw4ukBzbQINQRDcuK3KyjXl74mu0ifdDSE4fNJhfLesbamwZeG0n
	 xGhOOZbORfceTqDwaUz3lBNPrlmLEqtxpqJ45ARt0eJFr1U55cdJiKDbPKFlEpawiBwyg
	 g2yTqxyaROofmuryyD5b2OcyqsDSdc23SWHmY3CPAXvTmiOltMyxWoNwEGVNAANwcRgSo
	 NwtcFrinRGn/34yZkOQxtfNl2DyP7ezvwQL8Wxm/0sW2QGNnyruBLX/fVBfhsC6qKeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344389;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KXkLHPKKMwh+wJqwZbfSQVngruDSkDumTVZRSX/szaA=;
	b=hoOkJqy+7ANfeiFY/eiL2+220bPMHBYPYxrLwvCgMWsJdz6KIO++c64mAsO422mGMUuQ
	 4tniVhGqSNxk27Go4fzWDLhvFGPDtXnzXclgJ+FHs3G5TyOFmw/kxt3+mXRFxsVI2xc+t
	 uCpGVP1k5nUfSVZy6pAUzkxfPczKN0PmU/WAmjVBepupLymnDrYMEwhXyUwcn37/KxYsM
	 zjIOfkCpVHZsiR9mNMpxGdj+Qe+H+z4wdkhXR0y2EL0Q4OfDsV057+oocsd/8n7Xs8RGx
	 1MnHo2UV57TtJEKBRkJC5xERrUYKq0Z3Ry+hIrLGL6bMKvCgSm/Rj4dPglOhYyYaDug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YZv3WHoO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA385606A331;
	Tue, 10 Nov 2026 20:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YZv3WHoO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03791F008A6;
	Tue, 10 Nov 2026 20:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344388;
	bh=KXkLHPKKMwh+wJqwZbfSQVngruDSkDumTVZRSX/szaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YZv3WHoOXrbtvRQtSRy5iGPjPfF3kjShadC2NwjxcE0uxOaQPa5TyeM5GKoE4DP+h
	 IsgtcTarsLty4EktTgQmKwx+kCLP/F/x5+i8My9LtzlmiNOyzWQn3L+7Tl/Ewfd8C1
	 4M2e0+pknD7TdBQKaffccY3rfZlUn6Tqwpt2FYPUEHEjq9hOyGvkHqAHEtNJImHd+/
	 YCdAUhv5fmQc6znt4UD1PLSItnkO6F9Kd9oMToimowppYJYBVc1bJslzOsHSCemBub
	 qf9Kv9axSIgLrfU0gWs0HG2kOoLA3mfHXKCaE5WMhpKgAlepTRnhevhxjH+JZj4Z2K
	 fP1sTsnKZaY5g==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Ping Cheng <ping.cheng@wacom.com>,
	linux-input@vger.kernel.org
Subject: Re: [STABLE v5.15 0/2] HID: wacom: Fix Use-After-Free vulnerabilities in Wacom pad handling
Date: Tue, 10 Nov 2026 15:59:11 -0500
Message-ID: <2026-11-10-1-daily-reply-0015-wacom-5.15-series@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109133854.3026082-1-lee@kernel.org>
References: <20261109133854.3026082-1-lee@kernel.org>
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

> HID: wacom: Fix Use-After-Free vulnerabilities in Wacom pad handling

Queued the series for 5.15, thanks.

-- 
Thanks,
Sasha
