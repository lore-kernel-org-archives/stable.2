Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982975;
	b=IKfmsartlOmnv7ig2fWyzpJKCcpUQregOQIiy4MmpTFHMGSgpPmq6ijVnqw0bO/e+qZz
	 542v41kSxDfM80SY7BtzRFJHuFW7u0kbBFKceNVJLb01eRloJnZdxFwJsgihUWhsZGqvd
	 sKq5wMrjTodkxvcco0mHo3G8Bt3e5uCwn7Yss5FT14vIfDLkPGb32y27dVV5w0b+EDOB6
	 djYSIQ2AmKYYZ6Uh2ttqPqdUFkuWc/u00QQH4OzTSD7dHZpvcUWRPxY+neyTmdD3eIMrO
	 g70VbZrMQodRzFQwim/FktHLfScL/wDj61giHIZGqSgiaQL0zNV9mYUi9huksCIc0Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982975;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ECvnvaehsbVwslM2pE++SIjcVbQTfV4LTfC0gu6PSi4=;
	b=GV4ZPFPexEMzCy1rgWvfA2onXQpz4yCX/3XeZwdv33Tw8TlwOOWYRyTrWiFQGheIOSFK
	 hsLCoNnyt4o2eNoAAqdAN6GMSJJyh8D0iXBngZ48ZW4wj9K8Gj98zNA2N9OIBMBhKOpr2
	 oV8v8ZL8Z3Wtyu4UEqqR+PNNpQaEs8aOcAOMw7oY/LRKKF0cAJunxl0kTlHRq83uKrhRG
	 Wn0dInqPP080Ms/J1VXpZLzUkJTIYrPsyQMIqxcFe4TAI3B757m4b0D19TmwgLrUIZfsz
	 ewP+/Hvy7LKemh9C0V9VruZnu56cXShL1E8Gj1px4yzAX+4/trTYyEjiHpXBzV9HZ1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="L3k/TDAo";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AF5606D813
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L3k/TDAo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FAF81F008A1;
	Fri,  6 Nov 2026 16:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793982975;
	bh=ECvnvaehsbVwslM2pE++SIjcVbQTfV4LTfC0gu6PSi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L3k/TDAohV/XZWag9gJeR7dCpgG2JRw77cw1Fp68NiO/i9zCjDO0Lq0bx2Dy4mIbD
	 Vd1wIDroBr1ag8JQyaVG0Iz2Hjx3vYulo39wUB2QriR3OX90jTdusi8rX7JA+oQ44l
	 FAtEHZMLLFWF4pgLapZKF+fTJpCT26MwrrnF4gMrdqRmtMyWEFNHOs+Lz+Wy6q0C7Q
	 p7Fmkr8EBD8eJ9OoSdi8Yz3tdquq4uDf0YgTWNErSrZuz0uup/S8cVbnXQSqTvDXE9
	 9HrqPpXSfq7pfP7hXmH3bIYILhJnH0sDnAt19gOVSVa8ZCC94xIgBGDxovJ1FEwLOc
	 QpiP9Zc9MDh2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	aliceryhl@google.com,
	dakr@kernel.org,
	gary@garyguo.net,
	ojeda@kernel.org,
	samitolvanen@google.com,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH 7.3.y 1/2] rust: hrtimer: declare cfi_encoding for hrtimer_restart
Date: Fri,  6 Nov 2026 11:35:51 -0500
Message-ID: <2026-11-06-1-daily-reply-0016-rust-cfi-7.3@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106143802.27907-1-ojeda@kernel.org>
References: <20261106143802.27907-1-ojeda@kernel.org>
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

> [PATCH 7.3.y 1/2] rust: hrtimer: declare cfi_encoding for hrtimer_restart

Queued the series for 7.3, thanks.

-- 
Thanks,
Sasha
