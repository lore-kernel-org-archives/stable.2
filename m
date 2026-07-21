Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E703F12CE
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595414; cv=none; b=Ke6eLRAf6Y2bEiNBwaetR1PDUtDeRJD47hK+inyd37cvGpu/utVx0tkMF7nEu+SRn4ReeXmEdpgWOAhpmwhOkwZir36cd4HDtzYI9lGwplkfpzT417asNL3xHvvA/DScFXbyXF9f5klK+XIb+MkXmKQEdaizeJyBCmyl2bZyXQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595414; c=relaxed/simple;
	bh=BPSC3CjUmGfShxlwUN73JRzKj+FVoHRYMwOMdu4LMH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJcP6mPy81NahZtKP/tq+m3FNQNawYTaHS3TUm81UzGuD8tyeXf8/isQ+u1lR9TV5lZV3x/9DR630QeZcpAm9NdZJMwfn4GMU3xe5lcqQTpLVhgzkUTKoD9Yk37L0/iSANaWuZbNq5u1k98up/Fi0EaHvIRi75AsmH6OuhktEKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBU6kbaC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBU6kbaC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029341F00A3E;
	Tue, 21 Jul 2026 00:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784595413;
	bh=u6Nol4zz0ObnKsrBXbycL10DJV+YXz2AUkslPvzeq2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FBU6kbaCTWMoVYb9OWdejkHp8WwpXsMh6wfb66DTSO8i9LgmTxD+E3XoN23QDy5MB
	 +n3+Hqwsp74ad+W2X+mGQHypOvI/AVoWcNVLjLEs82kAjF0xoljNfPoaFB0pfAqas6
	 J592fgD/WJZoVaCSxv0WH0XhixjwOuXWKJsDKehc99/Ce1Aj4gyS6HEDCT5FW0/UPN
	 cgs+0sBuUXUx2FfBcMINTde6LU0wS7H0Z398sfSfzC5x/aRvTjv9UDi0RfkFQDWfgj
	 3hNw0bl1XjqB+QGroOpD3DN2AutvowJV9vfy1GD5Z3nPqV49xXmmFpxbCi1+S4KYAg
	 W0Qb3i0lCau5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 6.6.y] batman-adv: clean untagged VLAN on netdev registration failure
Date: Mon, 20 Jul 2026 20:56:27 -0400
Message-ID: <20260720175500.0020-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720134448.600024-1-sven@narfation.org>
References: <20260720134448.600024-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The register_netdevice() call will try to clean up the net_device using
> unregister_netdevice_queue() - which only uses the .priv_destructor to
> free private resources. In this situation, .dellink will not be called.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
