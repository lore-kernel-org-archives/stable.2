Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239622;
	b=LFA7PKEvRK772IGLyLBdvPYf1bWP1Jm/NFnWp9+Bu2AiLHBoyFvN7TugnAG07skF1jEo
	 bTEobKj3tUI0yb3/tmWSuLsWxsweCtUq6wfksL4VJxqXSw5tsSEmn6ew0XkyYahv/mg+y
	 U5AR3YtmI9v0hjAPpsVaJfuPQerPunVrB+ESvJcBdnTRHBX9gZ5t7CzZtlHMMw0QVk2lG
	 kyXbG6QUJ77/qJOoqJIEspwykjJl/ErejGvbTENFHWpSa/Kl7qfK04KSTW39E2UKogBds
	 8TR/DoAb5B/WtqKGLwofyQQjf8HVPVXJ4zr2tLd0lkjM6uLPlwu+47ZpgIXHyq+cWxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239622;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=K0aYS6Z2LTuqD8cd+K4Z4rYmYa3Yn5WmJK80VpjcgVg=;
	b=PVNOhi31MJ3Ye7NGmsyxO7iLlxiZrgQvugqJ04uirVfZCXAAOST3/1tBCOC//F8GYF/f
	 mcL1ZSoyt1TcZ56kPNDvJgI74TMqk18VHC4MQOnpeAb3pnS3IjCEYNT7jJxxMc/TtTXRT
	 EPil6zOqN1mcv6vkrEzL8IYYZFAczDl8EAfTiM57fE22Mhg35DlnGPsNuTgckb5vAFpEl
	 eFhNoBCMNoNxLA4DGt01cO+oLf9uBEV5FxzQeBxK72v6VwpS3HRhIqwXl0THdBHVFK9zn
	 cx7VUY1X7xpmlJbFsW0rzMJOrHh63By3P87ugowHR6eB+KLAQuVXnXw7HdkwlX171WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BDV5VIc3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7357D606EE89
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BDV5VIc3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368F41F008A5;
	Mon,  9 Nov 2026 15:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239622;
	bh=K0aYS6Z2LTuqD8cd+K4Z4rYmYa3Yn5WmJK80VpjcgVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BDV5VIc39KE4UTeVZ8hWsnHpD79tV3iRoq2CJie+//izcPX9RcmTjpxdSFyfHulKB
	 IOqh7nGir2gMImAUvOA1vYGWNPOAtLgLwjwW3Zl4dQWu78n6qa6k2PkTLR6B+uKIDy
	 +a7TrarHV2r/cXaVBVeTiq+WXB/8aUCXOVikpvSmIb+W6OiBLREU4u0DSa/H+LWftH
	 cnOh5aVSyYmLLLbUWWm8Ec1fnYGllvGSj6L29HBQ7PRXsxkIvbnzrZWvC18HNwfE+S
	 vgulrmcwQQEpKQ9/tGCBzSA2g+k51buoKE8qjMGTNC6tL16BHoAftjtNA1CI4WSuZi
	 XOb9eY4bJ39dA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@kernel.org,
	Yu Junzhe <junzheyu1@gmail.com>,
	Daejun Park <daejun7.park@samsung.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Daejun Park via B4 Relay <devnull+daejun7.park.samsung.com@kernel.org>
Subject: Re: [PATCH 5.15.y] jbd2: don't advance j_fc_off before the buffer is recorded
Date: Mon,  9 Nov 2026 10:52:57 -0500
Message-ID: <2026-11-09-1-daily-reply-0015-jbd2-5.15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109-jbd2-fcoff-5-15-y-v1-1-bdc09d7a5941@samsung.com>
References: <20261109-jbd2-fcoff-5-15-y-v1-1-bdc09d7a5941@samsung.com>
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

> jbd2: don't advance j_fc_off before the buffer is recorded

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
