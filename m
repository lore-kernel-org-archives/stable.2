Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804623;
	b=TDauLeIzZ0DuAdHXwxApmXU5WmBcEmzHlAeIaAfLoShohn7RDThoquSsGYcu70wxLjHb
	 uU9qES33KkiP8Ad65utQ4MtFZ5SR9orspCniEIJekX/FVLBcgkSUbAY52KVkczjtyWyoy
	 JilEF0lpiib56W7N11KaLg+q4kw3O0CXzm/RauIdXZLGYNpoA4hPUlajfjJ6ctn7g2ftY
	 XtrOgB8E2RbRhmcc9swdvkdJrHM1fIyPuyk8J0O5NAbRg/xaWVLXaZsMB2U8Ll34KS+Cp
	 +jJRbJRNhw+gpUw7nmmkMISawblz/Zb7PHDFa6f4muA8ADozEiCznBl8kMSrYL83YiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804623;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8+D9GiWTokgGGcKCBk0ztn+Lr2EnxFcY4mAE4LVEcrw=;
	b=QUOTFDsvdXrKveRP9pyx6ZduJrclMe4qeNpiGYwinWjGH72jxfaCS2wUwy6Wjidm9fGn
	 qJuPicTnKyR+IUm12Kj9Op0zcJej6+94tk9tUZ8DB5va8zC8wAgtS561TJAH9Bcr5JC1E
	 j4JitGBTk3BfI3K96E0OOpDX0oBYhODtgJJOGI6/V6estl1RjohSLoTn3crYQq0IIrduR
	 XoEMNA/ntHcoyK64Bx4WMcDEKAZSNeFKGyhmEiXc9pcKkvpx5JN9VX4r2Iov76SnXQpHF
	 ePhPmoBWNXjEFOZ5hyJo0w+0/Abkqqp8edD/UGJF4Av4oPbXcFUyHoSVW5wsduagNwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QfzfYaa3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2AE606EEA4;
	Wed,  4 Nov 2026 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QfzfYaa3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F3C1F00A18;
	Wed,  4 Nov 2026 15:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804623;
	bh=8+D9GiWTokgGGcKCBk0ztn+Lr2EnxFcY4mAE4LVEcrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QfzfYaa3vjpDFvKbihqkF4G1A8BnbuLl15O+HDj/9op7yraPRFgX6d3dqKmZyXYOf
	 YBkAjrQrh5zx9WG/B00AuVqKXDkDnhxH6S7e9iHSYEtFy7DXXtQTpJ1mgpixWloWkP
	 xXYCqv7fNnuoLLsVIrvYcMNfGQGRjUQLRta/ocrt+VQJM9n7Zg0fmvuHk+0xTvxWdB
	 oGkuMnOTKadIGWPB9gFyznNxxUg8HF6x0JcmIazQWCbzGdFuO76fvLGQ591b0MHDmm
	 /tYU597n1VdnTEBnAk1oOP1Q+N/f9ARHDB6+mZTPIongmJN9NZm4cFXC8SsgujzSmQ
	 liLvQvLUb1a4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kuba Piecuch <jpiecuch@google.com>
Subject: Re: [PATCH 6.18.y 0/2] sched_ext: Fix bpf_scx_unreg() teardown race
Date: Wed,  4 Nov 2026 10:03:23 -0500
Message-ID: <2026-11-04-1-daily-reply-0014-re-sched-ext-unreg-race@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103190805.3487350-1-jpiecuch@google.com>
References: <20261103190805.3487350-1-jpiecuch@google.com>
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

On 2026-11-03, Kuba Piecuch <jpiecuch@google.com> wrote:
> [PATCH 6.18.y 0/2] sched_ext: Fix bpf_scx_unreg() teardown race

Queued both patches for 6.18, thanks. I'll pick up the 6.18 version of the
scx_flush_disable_work() follow-up once it lands upstream.

-- 
Thanks,
Sasha
