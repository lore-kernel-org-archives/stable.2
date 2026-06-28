Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89635261B8D
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 03:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782617627; cv=none; b=n8n7XfKBg0/mu2S8SawVQDTd+JVqoRNWLdT9OXIe7xAEYZIrjMg5K1ZoM4VxtvqQot0OKbm10+RZwNbzVNOCPykC66WkQjUwq/eY6XmV9OhgBQ/YjmCHd/ikvx1NXTb2WPmGlZxGzyup3fcOAvCEhxX0QF4VttqJxm5PWUVa2Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782617627; c=relaxed/simple;
	bh=GLYn55f/1q89ZMZhRKcwH79j8QesxOuOZbGq5CqRQGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQ+HgSC9SXkx4WZ5tjcW6Nwojlt8hLvNI4dVS7ebF6jxHjqMS1PpVvf2nGXpkLLJoPP1p0xDQk+RpAnm3QimcddlrXvsjfqShN8ZAKCusETrcREDyu3ZipSTIFgkEFTt6s+j7qLAohHvafbQlmAo7sj+05/3Qn6Y0s8Ac8HNzfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5VLPKvT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5VLPKvT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16B51F00A3D;
	Sun, 28 Jun 2026 03:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782617626;
	bh=GLYn55f/1q89ZMZhRKcwH79j8QesxOuOZbGq5CqRQGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S5VLPKvTGUz+DgdP5wRm2qmvyx4J+spe78g7tCyFhg7jBCvC3no0mFjwzLNkQEkqZ
	 RnKgMGlRqE4yB39L1Bx0foeVnkJntKZ7sz37zRZYW6/EuqdXcWZKZVRjzkLzFsh9Om
	 uFDKjfRUlnkCLpr/ch3IyFq3W9hUzD0Lxfe2RlUivt0lmRKtgtAuFKjvvKXXiGjozw
	 bLt3HM1KTqwBOzlFnpCPR+PVHg4Lo2t8xaY0XuRzMDncmYXVE5/Wq3wca9XtF5hKhj
	 dRXs7wjrmfamLTQYpttPaq6PrbSiPB9/9Uqz4CuUU0p5XI4SUV8UFkdfZEfOq6US4m
	 /D3rq2W60q70A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 6.12 00/25] batman-adv: 7.2 merge window fixes backports
Date: Sat, 27 Jun 2026 23:33:34 -0400
Message-ID: <20260628032401.0004-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626161154.124562-1-sven@narfation.org>
References: <20260626161154.124562-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jun 26, 2026 at 06:11:29PM +0200, Sven Eckelmann wrote:
> [PATCH 6.12 00/25] batman-adv: 7.2 merge window fixes backports

All 25 patches are queued for 6.12, thanks.

--
Thanks,
Sasha
