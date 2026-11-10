Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344378;
	b=CNFs3CFG7xFOo4NS6e0o+j6AB6eVc3zOC0GjfLvbkpUar7kvSuyANZsK2nDvAkK5VW4p
	 7IuUoKSlFEZLIfb+IWBA01zXyNwtDb8FJpv61WtwOhi7BiHtfyr0K5Moxdoi4vOaGuLho
	 p3fZOFloCXz0LbsAnW9HcW/D4MMrobFqon+5dce/8l32QhFDBL0xQXqwUMvzzUnSJTqWt
	 MlfIswILi/cnBHhHMDip9VtbAniYbWbuh2Vy1lutcyZ04B4BbYsNI0s0Urd9k/dRXm5q1
	 XZH4C3Hu3yOaAnijP68q2SgdzUd3lXz4Jy61YXBZ3o7eXk3UD6DcWrVjNDB9YnYhFgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344378;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=14WnKwmeVNGLf0TFr4UOGcrxpPJYgCqJaD+YHSDN5SA=;
	b=ZQLqFxI7MfwtKaxCpfjCErlOGl/Jvk2b5AfbXbY8UQbjXpM2/YszyW88ZM70wIET5tIS
	 JQSsLyzY9H7HMPVbM/Ah7ajVqi1N8+Glv6HhdwQozNYvf9RQB4iVIqQ2yNBePMiZpjkHs
	 Qcbxxjk2wI0FXcQNGF6qzxHDdHqFJTmN1rmR/iKmo7QPmE7/yrJJBc3glBOuCj6+NN714
	 SFDXrtmqACFw7Pm6i07r42oKrQq8T8BomE0pv4Y0F2Jy8lTSeZU6wApzIJQkNBAn7QTnH
	 sIP5ZsV6DKu2HShzRCJMeNnhqROz54ynBmpMP0tiyks7nkOHTlh6k+jzur2IZebJujg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TspOXd9b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812FD606A327
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TspOXd9b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA3C1F0089F;
	Tue, 10 Nov 2026 20:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344378;
	bh=14WnKwmeVNGLf0TFr4UOGcrxpPJYgCqJaD+YHSDN5SA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TspOXd9buYjZEUda27Noy5bD0MEKipyAZFqQAA4kpnYghEOEseLfd2bODeGkmnpDr
	 L8MHcBry0Ob9VgUPSxYvkkHwyPFKigdEbKifYCwV1lQDNqQxzoX2J1E760tLvLazUH
	 baCc4Lsh8CroU4UEuKE/jMzIfZy2HRU0Oc8r/ElLT9DvdBjw1S/kwHJ1mcK+EQkvQQ
	 NWRc5hWwZRiroSd3gYSmaZzkUzycrme4cqNOY7alkYs5XsXl0zb/9wlZvRokUzjvA2
	 t4S/PmrdJvTMjBB4mcKZSHUOkYpfqrSHD9P4jDNU/dlV4caxfMZcXWHVfOB3koU97k
	 qd+Trd2eQocZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 5.10.y 1/4] can: raw: fix receiver memory leak
Date: Tue, 10 Nov 2026 15:59:01 -0500
Message-ID: <2026-11-10-1-daily-reply-0005-can-raw-5.10-series@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110180456.792270-1-socketcan@hartkopp.net>
References: <20261110180456.792270-1-socketcan@hartkopp.net>
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

> can: raw: fix receiver memory leak

Queued the series for 5.10, thanks.

-- 
Thanks,
Sasha
