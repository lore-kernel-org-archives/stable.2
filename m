Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434113;
	b=BNJXX7ascL+d1/AoBCPE6k6CEiWPtvgnh9jpafd6T4jNpQHyJSVoFVs88Qtc3LItRCLd
	 HPqp7gQKS5IvQo48Symg5QC/YaCTmnWttITsuU9t0arlEhYs7hKrtuyih4i0Zh9w9z1YZ
	 IeFd2rqTHSuzPJYjWR0O3VCDoDAQN/4nS+xFYXhoPwLKhDiDEkT6cAubFCoiBckejsUu6
	 ATc9+dgK8NTk2TVpfJFqebD+YnnuRkRVcWRA1ieOG6tSkYFyGs34Uzu+jcyfnIYgM9q2S
	 KU+3VhYL/8nUj7X66mgqbvOqQ8MEG2ypPq5gVzdBwBPYH1e1jZbM2ICMmW9Co+mdaDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434113;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yvmQilY1ojk/CJp4vtybzsIKf5taQ/yUoR8sGbF33I4=;
	b=tJNIVEx9PaBT3qVcPghFE0EW8BMexNG9ptFF/C4C/s5YV1a+pyu6SIp0VLlUra3Lzfu0
	 39yPTItJoMMMqE1MXPSnlGyGPVd+Nzp/AX7VoVe+O6ogMj+T1tv4kvTKpX/34YeXYqpp2
	 /S9rAZTkXnHBDJ6Jrv6q2rttjRmTu5RMprewyVAL6Lgco33TpiqW8Uv4QnTyFUrqsdKv9
	 +l1fU9eZYiZ65Q/t9X+Es7DTI13jGzdwQs8MPFipp2IOZAE8SsjOYCzpoQHGGwNNPhs/T
	 yFpkIQC+U4APuAjNiIV+TTuQr7fBlOq1Tl1z0FbCmgV57DY/CxGiMpYnXDG+l3LrXPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XK17szte;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D2860A6F52
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 21:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XK17szte
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2A21F00A05;
	Wed, 11 Nov 2026 21:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434113;
	bh=yvmQilY1ojk/CJp4vtybzsIKf5taQ/yUoR8sGbF33I4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XK17sztea6XWZZWBl1fUsnC/JjDnIXcLYMYkxcajXvzMGLItJMYckFpYgI/slF89A
	 fPnHtvLkKS7VcZR+wtYBMyM/HI5LhMQll9eSSwqefEkJVya3Sxo2jbW++BhRqFvFVC
	 MPgn7uBPDB1fL7cgalKcCNpTeIDy1G/nSyPceFhdTDqxTIFmJXdW0WUPTnViQW+02N
	 YnRuyLEWfz9AZKhBleim4kESXcljYCpOp3l8/pfjI1GfNvzDcr1p07krpp4XrA4B2m
	 +NjChubMxbLRnRRTx/8WlHe5YFXc2SSREurf+i9fEP2OxuWaYnd3FwtYvE/XOtj+pa
	 9qsFLjQBVP8pQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>
Subject: Re: [PATCH 6.6.y] alpha: load the MMU context when switch_mm() switches the current task
Date: Wed, 11 Nov 2026 16:54:48 -0500
Message-ID: <2026-11-11-1-daily-reply-0015-86b653859727ae1b40cf@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110230954.1151961-1-linmag7@gmail.com>
References: <20261110230954.1151961-1-linmag7@gmail.com>
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

> [PATCH 6.6.y] alpha: load the MMU context when switch_mm() switches the current task
Queued for 6.6, thanks.

-- 
Thanks,
Sasha
