Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798957;
	b=JTCsa0xv/ZpL23ltdY7lVtr3fnvf2HNZ7O4Mr0R+mSipLrpuu+zVn8yQ1dmsZHjA36c3
	 h4cQYEDA3Fta9nkZzBcXS4kcL0MEPzgFjnezMagP4iQDEcvkhSYB4H1Zopm9m/bbojQHL
	 rR7ksTgj7e5NTtjyRlChubciwUaJrvnQq61D3VpWOXpJqGt8YIrITL66mZdcL/ZYSn0cC
	 ZGkbjrJC/vl7VnubA/2NAvtvyLdSsBmf8zv8wyk0Q8o5ncKlXNsPLRlGaYnXgSOONsJ8D
	 706WdWyGKbIeoNvkWnWNX4E2KCfKpZrpAmBXbRugIQ1TY+VjOVTzkhnnhz0nDK+4Nbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798957;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=g0ZA2Zm+yf6dcFjeGcZOuWIa1/Lg3tCSAeo8dRAw1OM=;
	b=47xRgTSgobZVCCBL3cQ9CD68YAcjMFud0fO2ZfxX/o+4YZja6BwVXLZTuTddRPXnTDkr
	 5ckAsYVHABcf2sQb3vln4WSptGePzBfddpnrx6WA3nCx8ubIlLHmAT5KtetYYobyn/fM6
	 a7dmgDZP6ZFLcIUt2E1KBptmWw2V9bZ89wErGmH2XdT3mBL9HaymOrgV22EAn69lgFUb4
	 64iB2S6S+oaOsQIJPL/j9DGE79R8t3tBVO8FOUkmcrjqiUcQBWWV1eFyFBFrQ/i0BtZtf
	 cCO8x1JvXdiba70UoffTByxNTZZUYqq9DvFERc8uSDIU+YxZrT0NfuGSkCdqaxEFoIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hp8SiUsG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F93B606A330;
	Fri, 27 Nov 2026 17:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hp8SiUsG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223581F00898;
	Fri, 27 Nov 2026 17:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798957;
	bh=g0ZA2Zm+yf6dcFjeGcZOuWIa1/Lg3tCSAeo8dRAw1OM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hp8SiUsGsVsLYwe4AY1IzXY8yoo4kY+nWyA8d841E23QBXU65tWDti8G8DOiXBxyU
	 Jf1hwC5Sjb01cUuC0nQJuMZTiemHKa241bOak04b19yMqJih2YvqUGC/cxOQmT+OCn
	 z43Dvg3UmPoAI0MkA+oa93/PLDJVbWTpBvHcUXkHrRxC7/LCK2rodp4ef8m8dPEtSD
	 AuZBg3A7ES2MVZIpxF2q+m9ShQkBFrgym29R30RJUTdRwwrnMuNgj1DQDqbiSlYljD
	 a3D7SkjDnXGbu/tjCSXrdbT9WewYQwCIhu0ji2gYAcw9fhMv17m3brakfXoKp0ew/E
	 AsZB6vqDYdO9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Krystian Kaniewski <krystianmkaniewski@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org,
	Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>,
	Dickson Wu <dickson.wu@certik.com>
Subject: Re: [PATCH 6.1.y] Bluetooth: hci_sysfs: Fix NULL pointer dereference in device_del()
Date: Fri, 27 Nov 2026 12:01:24 -0500
Message-ID: <2026-11-26-1-daily-reply-0036@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126-so1b-bt-61-v1-1-8d8aab8cdda7@certik.com>
References: <20261126-so1b-bt-61-v1-1-8d8aab8cdda7@certik.com>
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

> A NULL pointer dereference in klist_put() occurs when a child device (such
> as a BNEP network device in bnep_session) is concurrently being
> unregistered while hci_conn_del_sysfs() reparents child devices.

Queued for 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
