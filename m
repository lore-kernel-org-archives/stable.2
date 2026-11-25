Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622611;
	b=K3z+bxNIHKfJ8H5BlY+DO/jYPetJHaow8RQz1rtjjvFKcsG6FyJhVESsWWuHjme1pju8
	 vhQii/gzjJbtLUNSn09e7HObUdxSWo4TgTX0esmCSbhzrR/w7AsD6aPrEOZwggm06+pdg
	 +3AZj9oQtILugq27iEdwdQYuhRgr2KfrMifoNx8vqzT1x1MsEKZGlIX1QB8fslj3AtIv3
	 v2TjOXSDoVI4G/hcLruMKZjTabmH6Wn4Q7jOhNNXzEGHEv/lqoHQofGYBv9g7N3Fs6Fts
	 pjJJVWk8BuANwxrOElrBR8tRE0RuT/5N7vuvrPZI+Jofg39ji2wj2MUECxkCHnWrLag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622611;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=30XKkNhBHtAMZ1vAF0bhL3GbSzopE2QJq9kezQdjGYg=;
	b=ELAHP+PuLUaX8KWYvB57Fbgb+u9O39eOvrJ9oypHqYQ7Wfu2peOiZpkBP4GAlC8eQ5Ad
	 +MF2WJUr4uIEFZvbuYQp+VtEcgt886JF4V29iaydnKMbxrCQHpyrZzaK6p8qVG+43GSov
	 iC/hjzrwWCUUqZT8yxlPzS4M0RXK8HRXSWX5xNH2UEzoYlMF8byG+htzxDbohe0WU2bf8
	 w8TQW1tE4A1/b6J6bZl/qrgjfON+j/JKyKDb6GzZAPiIr/Ya5JykajIEYdl1iFnY0ZUau
	 EqB/AbUmcQJLO9z8b+p9tUobSPebJvhGnujQNrXO8jiIBDvHJm8ZHj3JXKlpev2LM5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i6SWBrU5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3682606A323;
	Wed, 25 Nov 2026 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i6SWBrU5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751DF1F000C6;
	Wed, 25 Nov 2026 16:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795622610;
	bh=30XKkNhBHtAMZ1vAF0bhL3GbSzopE2QJq9kezQdjGYg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=i6SWBrU53SoAoY4XVv51y4e4x0Jp0sD5V7g3exv5dhvF3IoVwyfcvYj8wnOxpbHm3
	 vAkPEU4OiboV/4elRz6moNKq0g77W1eP8t6VLEm9ewAPYKAdbT5yhkg1Gtwtc0j0r+
	 9m1dooFw5bc9CPOET6zEV0xPjdMW9IH4nZIyOJI+tKr0O2nqyS/1ieGKX6LjZVeOxT
	 cT9Ttay1gmej0EPnl983itB3LINzno+ewMiwD65zAqYgBskXDaJjqOXWrcXADwNeSv
	 MhQqjWfSMyLT7BCYAU5WL5BG0yIhyikmgPsUX5ohJAfJvTROUExNNHVHCPKF8mm4Dn
	 e1La2Qot17ENg==
Date: Wed, 25 Nov 2026 06:03:29 -1000
Message-ID: <1357055318f5d596a81026dc1e2a7ad6@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Boqun Feng <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] workqueue: fix cancel_work_sync() on ordered workqueues
In-Reply-To: <20261125-ordered-wq-cancel-v2-1-13620a09773f@google.com>
References: <20261125-ordered-wq-cancel-v2-1-13620a09773f@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Applied to wq/for-7.4-fixes with "# v6.11+" added to the stable tag.

Thanks.

--
tejun
