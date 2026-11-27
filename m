Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798969;
	b=05wsaQBz2jUSMmp6wnUKs4eklah/Fvp5cZ7zS6xv0PVvqF3QXwlNRD77UtDcRXsL45AW
	 VFpZE76GZ4OftGXpy6eZmbnQ7hoCW9ahI1hTcR8Oiw05d8N4Fk2DBM+Ey9wYJlnDVkUhp
	 tTJhKHAEQXKP4rH/T6EcL5e/9/OVXSB7woLYgGq6Z9wkTXFdQ8xIsdjLJBR168+baQi4o
	 iunkfcTvI70LWJ+8cPOErJVxJ9d9RwR+oZIIC8IFHrl4RqWDEt1Hml1ro2l7bn0AY415O
	 bFqqe5yTxzZR1WWkyNRcohXhHYTY8VxexAz8urFRBnvc9Xui80UWbRvYKWEyVpXg6Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798969;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=m3/PiAkjRdm8i+RN8VsiWHLZIrTzPxj10nRANuJ312U=;
	b=uovfczXc0+xzOLgLKTB7HCwEQ8yc0TdoUtV2Z0+GunWNR30qmDos/z1dnn2GAjpF5f9+
	 qUqETqbVTaOvE71zmOapBA4DQ12ptJOfaJz2E8eAk44+co2HKXcn6eipXqQ5ZtwFJF63z
	 Ik5N4H0J5jSpfHrqCvpLK3nJS6MOveSrjCgrJVMKJwTrrmPTtXd8V+akAIdLB2tytm6wM
	 dd3KUC9pM9oJ20CuOGKiRyD+dQhhgzvQ0iZlRpfDE0pgFYRZQrmetJRhiWoyAfXGEjGhp
	 2CsuymzAVuqQVFuiQihCt1vb1RMRY/5SThhAlpydMrp2mt/kA9iBD6t8zYpP7/cLkTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oqRFAVmz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B415606A327;
	Fri, 27 Nov 2026 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oqRFAVmz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758451F00924;
	Fri, 27 Nov 2026 17:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798969;
	bh=m3/PiAkjRdm8i+RN8VsiWHLZIrTzPxj10nRANuJ312U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oqRFAVmztBmBkxJ5wNlo6lMe0QwCpkFFvhwOw3n7xp/6jeHml0pc21PDMEtJKC1Jr
	 jehjIMES1iILE7ADonrH1jjzDnNVnynfQVT5M51XZWwEzL9z8egDEsTxhApPq70MNt
	 9Nyvyfsp5K2rmq+P/YYNnIdLlePwEsIGlvAvucQ8Q3VevYBShyFI7xT0L822rcdxky
	 uXWZNDmR/q3TLRIui+G/L8WbBrxmXtj4a2RsARNsdIBZ8esgljubKx1TrYQmKVa3aK
	 s9k/6liAct3WHOAF96bpV9bmDJGEuPUnoQekH1i/7CtK0vU8T4ev/b6ucI1gp350ZY
	 C/oHGh4o+MUOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Til Kaiser <mail@tk154.de>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>,
	Dickson Wu <dickson.wu@certik.com>
Subject: Re: [PATCH 5.10.y v2] net: mvpp2: limit XDP frame size to the RX buffer
Date: Fri, 27 Nov 2026 12:01:32 -0500
Message-ID: <2026-11-26-1-daily-reply-0044@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126-mvpp2-f3c6-v2-1-808d54f66dd7@certik.com>
References: <20261126-mvpp2-f3c6-v2-1-808d54f66dd7@certik.com>
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

> XDP helpers use frame_sz to validate tail growth and to derive the hard
> end of the data area.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
