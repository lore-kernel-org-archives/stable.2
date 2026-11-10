Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344394;
	b=Ba3rMTzUD9wj2LTzoY6icFXrscn6azqOnUg/AMwpP1nvkqRmVvIkXJSjscDzMfxdBfl2
	 ic4/8VAKgMavNpeRgudZGiiUitE182BM/v5w6W5lEb9HwlANs77I9+WzjsG8g+WS2Yj8k
	 dDIj/2A2cYvaiPYmHrWFDUkSvXuA05qak1D7zKqSvKUH0vHS7WRjyBYyoCCmP+/exc6TJ
	 hcubdpn5G8MIeohxJw5crQ4BrQsFNdxwWzZuAB48dHEm4h496ZGfFbFBDgX8NbuASfVUO
	 n1SxILZFVwbaF8hNOstYjZ+9x+Rb07WughEVR1YlcVYpZFuqoHSJV45y3D0YmL1B9VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344394;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GFiRhG1M73zJ8b7krACIa4HGzVCXtgNUwEkH/Aqn70k=;
	b=VVUGWikGA9TJqfUXvPfg9upgI7cYZN8ft1vyAL0lOW3Q4Is3psgYtckFDzwaJvo/r21U
	 JCQTaw7fAIt9Q4nN20FajJN4MZsY0yoICQ04JXi8vWLeWVo3KQb64n3ERgkA+KNccfmBZ
	 7J4mRr2jhUUQcBH+IMkWJxiHGUXEYGnzlYT4oEOWJ3hw7zOIarG7SG+yqyZ3q+CRLJ9NA
	 4PL6oEF1PoqJPF/atYy8QnpPM+Z0gsWy4I/Czbge+R4iHtOipe9pGB18lJHLJ9xrwzFZL
	 45llcIxzxH+jLi4Wy3M/nQyYpbOrZ4Oyo7lDKoyDIRQvMyh3q2Rs8JHv4MQRfc1hGNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mDiy1mDX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6457C606A33F
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mDiy1mDX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97021F0089F;
	Tue, 10 Nov 2026 20:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344394;
	bh=GFiRhG1M73zJ8b7krACIa4HGzVCXtgNUwEkH/Aqn70k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mDiy1mDXCz2pwqExMxKK0slcxnXMqwGRoKNnk1qovOqHUm6TffOXM1WPOZocQsSHn
	 Rnrd07by97iYraagbcUbLcwFYC3VcCvWDRukYfaK2yD6erUWR7lf7zUCgZAcFMvJs1
	 XjD1EQxFey2smCvHxd1kbeBeM+pyD35tvMiKzFS+3gpRkIZhfdL89gHzbYaes7EwBB
	 ogoltokzlX6EYF6DS4TPqSedI7ZSlZtf0IbbPXKSz7m6FyI81QLLroG5sDuIY3/pwu
	 4t4DHTagk4t6staz6dnip3psmO3lGlq6XVNKFZR2OUlmb7zejLKxbtDkgZ8ntQevNp
	 bHxiwbU9rWnug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 6.18.y] batman-adv: tt: clear ROAM flag when re-adding a pending local client
Date: Tue, 10 Nov 2026 15:59:18 -0500
Message-ID: <2026-11-10-1-daily-reply-0022-batman-roam-readd@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110185036.73635-1-sven@narfation.org>
References: <20261110185036.73635-1-sven@narfation.org>
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

> batman-adv: tt: clear ROAM flag when re-adding a pending local client

Queued for 7.3 and 6.18, thanks.

-- 
Thanks,
Sasha
