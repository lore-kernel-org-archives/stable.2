Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1F91FCFEF;
	Tue,  8 Sep 2026 00:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828858; cv=none; b=htprVls+DuHXvPgl0KIYcRtts01H8vwVJVI48j02rQyKh0dxj1H3aF4XpsxEMAo+oAPld2Cm3MdTi4KzJ6s+re5vuOH2ot3o5ilO+Qz3StAxUnTu2hg3UDbi+yvhtX48y4Poar9pm1/CnsCXWTSbffStOtGaKB1LuiLP6qy/Woo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828858; c=relaxed/simple;
	bh=IRusWtHW7mcbjKYztHYH+8izFk60cn1ITgkZLvHtMF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=El3Ts0ulRhMzfp3ul4zu1QGJe8yW3r6dlIPr54Iwru46bHEAbkOUgWYvqgDITAfA2NiattrMTejxZa3byQ4VX1Z6/JfxExFzDq6E5/rgPgSASIHw3DuAjh4n/VRF2/xhsbHk53Kcqp16HP9QvK3cjVfTzfyfyR7l0Xk/u+2W2VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JATViqPO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JATViqPO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672751F00A3E;
	Tue,  8 Sep 2026 00:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828856;
	bh=qDirhoGWjc2csBx5d7xGbdH0VhGX3fyzJfQO3BP318E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JATViqPOpoe9C0rwmk6Y0aHo1Xk4cvNxXBgDeUpumGGgmpuD1kV7y7C+LLzBXt3nd
	 USlk7dwstkRprraKWW0FuqTHnaQL/jaKDSeEBWSlFQwN+Ne6UJU3G/VhCBeapjbo8W
	 5pNmV3aef/SHErc5WbjQ6Bw5iagh7Sct7/cEuJfSEqqyIxC4lKAOSGN4xA2Ei3AD4Y
	 8EROnMiw+Mwoqkyz3I4tzrg50Y4aqbgAjb6J0r/AfwjwqBZhVNYuNzOUZmT77uVV0M
	 STU6VimGlx6cWisDVYS+YbQ86UU2PfviKUFMvH3iLEhmHFhGrf97ac50uyYFNeJ/ZX
	 Fz9AWP7J/KGBg==
From: Sasha Levin <sashal@kernel.org>
To: alexevgmart@gmail.com,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	karolherbst@gmail.com,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	mhiramat@kernel.org,
	mingo@kernel.org,
	nouveau@lists.freedesktop.org,
	ppaalanen@gmail.com,
	rostedt@goodmis.org,
	tglx@linutronix.de,
	Ingo Molnar <mingo@elte.hu>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5.15/6.1/6.6 0/2] tracing/mmiotrace: Add NULL check for mmio_trace_array in logging functions
Date: Mon,  7 Sep 2026 20:53:51 -0400
Message-ID: <2026-09-07-daily-reply-0012-mmiotrace-v2-3trees@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907163919.183961-1-alexevgmart@gmail.com>
References: <20260907163919.183961-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Masami Hiramatsu (Google) (1):
>   tracing/mmiotrace: Add NULL check for mmio_trace_array in logging
>     functions
>
> Steven Rostedt (1):
>   tracing/mmiotrace: Remove reference to unused per CPU data pointer

Queued for 6.6, 6.1 and 5.15, thanks. Good catch adding the
prerequisite.

-- 
Thanks,
Sasha
