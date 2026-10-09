Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C78207DF7
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565817; cv=none; b=Iuz62aQk1qVsAMcJCasIl9rXxkSjDR2lFDnXoKvXcwEPPyWuqPaw5acqk6neaCN18QB1gFSIslHrW1sGEw+m4lnQY34m+gDq2cKicFuPEb5eHHaeiBECtSFYIW2wNndPnKWVML6B+oQLRPB8GFT58h2GhFYTFy1LVKsNn2/P0o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565817; c=relaxed/simple;
	bh=IAd3YGHhJrb7oVavAkEO2a8cZ5TuJHwf6VI80pOURjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QsoIG8y6TEHI4W4VEZDDBrFqGqygyyCaJklbtjpDXUQO2u81fov2EPDO/sPfn/7oGJQZPU2ejqTTtE/Oz8/VgK+BNq/PE2NwKXx+CXP14MtxbGLrbfQBptZbLLuKEP0vIXXbd1uhuIukbwNYDqGLtLe5y2dF8Wo1HgI2XPtzsL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWLdus6B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWLdus6B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF141F000FF;
	Fri,  9 Oct 2026 17:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791565816;
	bh=/ixUzz0Fki9FTGZOG2wDX47Kl655xnT4DX66l3CJAxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gWLdus6BGXz8P/NGcZBV92FCzcXG3A1UHNUI8VrrRj3lBMYAjX/ugyZEY0UF89WPl
	 gKB+pD4zUFAwpUOmXGOUVi/VVH9QCAVued3e59IjkS9PTF3P1asuKc/T9ajUUeGOob
	 giGkaqq2HnkEiqaFjvLEACpe+tC7xCHqq4+yYtLIsHW40kcy8Xf3692DZBXJOumcju
	 +VHm6bBGmWPyY7eti7r6onnBE0m5uv9F9j43cgD05/6aW1HKdGGluhTxhCpSh11C11
	 VrvHz588H9hTe70kKRSPH6Xt21jV5N8wgEVU6+cuqlDJtlw3WjgqgVApvHn0FurDda
	 ruQmbugfFa5MA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Ting-Han Hou <ue081723@gmail.com>
Subject: Re: [PATCH 5.10.y 1/2] tty: introduce and use tty_port_tty_vhangup() helper
Date: Fri,  9 Oct 2026 13:09:42 -0400
Message-ID: <2026-10-09-1-daily-reply-0005-tty-vhangup-helper-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008141723.1183340-1-ue081723@gmail.com>
References: <20261008141723.1183340-1-ue081723@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Introduce a helper similar to tty_port_tty_hangup() (asynchronous) to
> handle even vhangup (synchronous).

Queued the series for 5.10, thanks.

-- 
Thanks,
Sasha
