Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794877388;
	b=cqTxH+sLqCl5StNWXfcO60xYwjPGSgqEWMgf3DF7GgA8JCiYHAbyhfVkzqrgXsdO1KGA
	 LjtzRn3xyAUmTL8j1gWPcsifywY6phHqsnYPRPqszSjlhLLvQlFRIXGOpF1KUmrdw6Mh9
	 tnYHrTyWw1pr7iCktx3niBGXutZdETItCowyl8GE73b6tDSCtBK6+P4CrN0uTc7tFna+r
	 gyF0JyP8g/pJBpFKrsGlvPOpQXQXWwByqa3k+ZFaSphGeKKXrudABUiLcv5ry0QLK/IiV
	 aiHJPavrzpJgzoRvwQChepgKErvvaNsjd9DzVGmavPwvAg6KA8Ke4Rs0U2Ad/VwvA/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794877388;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oKZJzPYVkx5rqAGNN9mfmAQMj6g+lcaDvFT0JS0ueV0=;
	b=d7zjHK7YPOub12j0fKmxFN/r6+WvU5Qfos9RoejL0H+4V1V3npy9v9tLRRnUHcAPmezG
	 EmP4XOGqIevD6XtFp8rZftPR7JSNioIhY+5bbDGgbW4kUYeDfOrLVjvL7iFeMD8gYq+3s
	 tZYxK1JkASVUtR7WVXxbp86vdlULOtdXNt0KFhSQfLoyW0NB/VhKJGNpniPwhxgji5r81
	 EEfUA9GK9FVTPWAaPv0D1ww4HE51Hdi4S6RjtL9/ljTLPI6FmQC8aQ9+xeVFUWW2IPw9Z
	 b01RaKXkfLpg3nj4pQS/iBNrBRFZv9uUq5fc3jesGikno/qJyesUCLV2zH4lG8T1aWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJya1Tac;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93617606A31C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 01:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJya1Tac
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB371F000C6;
	Tue, 17 Nov 2026 01:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794877388;
	bh=oKZJzPYVkx5rqAGNN9mfmAQMj6g+lcaDvFT0JS0ueV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hJya1Tacr2K9DpvOJ50nV2cphImU1TTpK/xWrT7fEMLmeX4MKwIHKLfuei8UQJckx
	 pr3zUgJALp15PjrXemQFQGjKDQsC9JluGIpGXfFDPnVAKIKHHQw8mYKdCcceDOBIXJ
	 IJWtsSbeVkLPl9X06LVerGJTQ0rR0Nmg70u/mIocCShMeBVl+ckhJdOYc2MjPHFzQ4
	 8+EUsCfn5lAN0J4QbDhHWCcRCsItMkUz3yw2QhW1c3CE4UaOOgcLXkKe5L/18oSeUH
	 0OWHM3UlT9E0F9kA+AagpV7RJ8otGnCGKrVZ1i+i4CPG/xWJL2tglNfxT9mdVHgTWG
	 DO7untYLuEoVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Yang Zi <2959243019@qq.com>,
	Ian Abbott <abbotti@mev.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.1.y] comedi: addi_apci_3xxx: fix subdevice count underallocation
Date: Mon, 16 Nov 2026 20:02:58 -0500
Message-ID: <2026-11-16-2-daily-reply-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116142706.114307-1-abbotti@mev.co.uk>
References: <20261116142706.114307-1-abbotti@mev.co.uk>
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

> The ternary is inverted: when the board has analog input channels
> (ai_n_chan != 0), it counts 0 instead of 1, so the AI subdevice that is
> actually created is not accounted for.

Queued for 7.3, 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
