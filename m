Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785782;
	b=VSfVhMyUrZW2Mc+ICo7vncRhoriKdg2iPtSsvw5v8LFFhAzfsXGSlvPoih5E0kp2axws
	 kJtuXJl/WQZEVIPFn2ncm4F7SOCKYf81c5vmdiGod4bO4KbDgcyGCh3SvQY9Kvup80ZH9
	 vM7nk6nHBko1mGBCv6r8T9QUHGt0pbVv14DG9ICC8LRDggKqOD8Jm8MMcHBqVpaQ3ThuG
	 wOqB23dTcP2QRhtdZ4xgJ6gJKjOqEpD+UVmFEc3S0WamkwhVWz5hCWs+jvJTDcRC4gAdc
	 L5ddowPZcPsgpRJZeq0bzARrr3KqbP+P1C9mC1n1itN7LUtKOc1Tvt3QiVHiRx+oDUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785782;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HMjEY6BaF66OdfhTCMToJzvhSQ68ibf9pMZkvknMrYQ=;
	b=Ed16D/pXDOL9QkYQshX1AqdDQEz/QSjyQssP3KLlmsCsIz1uk70JikK9MRK7JdofBrK0
	 7zmry/I44odgZ5OiH6YnW27PtSuJN+fz2/ol/wPiqE9ngopZob0WYz+0bqYJHNRXkvNmN
	 gBX7nCoVn5YUuKElO47y0mDdYCLMjxztQcPZMMnCxdhUsW4D6FAylYvS015KgxUPfkmmf
	 tUbsRYf7D/VEbk1/ZMKiC95kDbl2RYzZGzmGujTSgHglQnIYPGL7DvZw7ToXaPObhSfOT
	 pC+0+nvLcjhJgsj9/H2AcCzq+h1Guydvbasn1D2Py+HMnV9CnLF6i8qT0RLSAqfuWHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I5ofXz9Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CCD606A327
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 20:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I5ofXz9Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44921F031E4;
	Fri, 23 Oct 2026 20:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792785782;
	bh=HMjEY6BaF66OdfhTCMToJzvhSQ68ibf9pMZkvknMrYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I5ofXz9QgyXywq89H0ySBSq7rLbJaf1UtaOyzyDkRqNlD1xj7kBaY0GmY5aeC3JNd
	 a7OHsNoffUVLcWha8W5UFQPv5ZBq9MarRQTIh050Mn3iQDZbwwWKNxQfecb5ao6bbE
	 aZiB8BjLfhmBfQBBscgh+XP2B/SsivSp8lv+3+VRwQqND2xnZuyGpyuXEQ+7mmxp9M
	 cFaU7ryl5hwAwoFfz70EdhyvWZM3+Bev1HNM7asaf2tg4a3vuDFeyslbNcqmNGYFSJ
	 vp8DmHccJaGKPWvb0dHOwScgxYgVUlHKHXbiJXK8CtB462TLqHkfHiTEuQxfRUR1Gz
	 VKpg+rtrZ4Uuw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: Re: [PATCH 6.6.y] perf: Track the perf mlock gift separately
Date: Fri, 23 Oct 2026 16:02:43 -0400
Message-ID: <2026-10-23-1-daily-reply-0007-perf-mlock-gift-6-6-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021155541.1700184-1-ljs@kernel.org>
References: <20261021155541.1700184-1-ljs@kernel.org>
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

> This was reported by a user who saw secretmem failing while running a
> simultaneous perf record.
>
> Resolve the issue by simply giving perf its own field separate from the
> rest.

Queued for 6.6 and 6.1, thanks.

-- 
Thanks,
Sasha
