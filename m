Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443371;
	b=bmIujMtJBnWXDz/9N0wvaEIdQDaQGEJ4C6dGSMiPaxzpwxYImH4cPYNaecW7ZFFM6MyV
	 Jh5nH6gfkOXn+iMrcO7QcXBqX8cS1hrJt56D3ae5vaMRfG0GIuRyrG0ZaW4T7tQVbiOYG
	 FDbqOnIrHZdEFgkOgI0A8BhCy5zvRhRHtip8OsaYAISdCE5CiOxqIdoD6iKrl6HbDwxuP
	 8/xAm412gMYs8U2O0LTv/SiO9WgmtMfxFMklJDo65FR05f0uBOEyF2rVwZ6vVWUhZeihF
	 ZjI9N257+lFVV5E4H048bKgNhMw9WBkj+q5oIX9Z8jfGdoX5D+whWQJvfIgRadPgK1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443371;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1sSRiuhUT2L7YQelzzyVYy5ejFQRJw0I95rCZ397zT0=;
	b=5bK9J63JeYqGH4pBOgKPHCjlW/TD2aZPANJu6MPLrWQqTzI7Ww+EQaq8c0sYeNxpc2DW
	 /Q7cgREAahR3HNc8Yt7IEzzzSjZQ9ejI+aytC2DIj3wzUyRTr1rioOUAI4/3vhALBJWEW
	 PXvnzM7O92gIh+vp81R4Dixd6VXmjaKJzaNPuQyVFLs3uIf+Un5A2zbpG7TWmXvX0P18j
	 pcz7nDG59T83a1KgsJ26O6WMM5Qk0PzpqzW/ZeWslYfQVRo84sxB6CrXNxrk/2/GZCN0d
	 0HCpVRI/CmHTgDoomgtIvFG1uhnGCw8fL6QouFuemv/Xl4zY7XX3EZxiD8u/2zMPEKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Icym+B/Z";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D5F606A32D
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Icym+B/Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFDE1F000C5;
	Mon, 19 Oct 2026 20:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792443370;
	bh=1sSRiuhUT2L7YQelzzyVYy5ejFQRJw0I95rCZ397zT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Icym+B/ZO1LgMsTVtV/0rWQI2vzYcUjbHGsacdF12PoDgUzlmV8m104Djel301NOg
	 b2+ud4GFaI8A+NQHEuNuynKNmOyqVK+1CIZ4ASu6i38IkKeBszpDGoWmwsXRUGpUy7
	 ZiHinyjLKQMgG1jw+Za9iGxr6kOHpv+HxvmPs1+1OoJ54pOSpwo30SiBsDTdASUeRj
	 Qg7iq+uMv9wc0foAyEWgj4cVq45eoC6NwwgKotoBvZFGaplVJaMyc2Rr83MGNK5UZ4
	 NgTQtDzL53GVJCRUTYx/5+BpjXLbzYlD9WhZdzmZihB+uVjtmtYA6tRbjv5ZYwnska
	 GRrtnJ9So0yYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Benjamin Robin <benjamin.robin@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH 5.15.y] bpf: fix potential 32-bit overflow when accessing ARRAY map element
Date: Mon, 19 Oct 2026 16:55:44 -0400
Message-ID: <2026-10-19-1-daily-reply-0019-bpf-array-overflow-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019-cve-2022-50167-v1-1-965ab366b9b6@bootlin.com>
References: <20261019-cve-2022-50167-v1-1-965ab366b9b6@bootlin.com>
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

> If BPF array map is bigger than 4GB, element pointer calculation can
> overflow because both index and elem_size are u32.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
