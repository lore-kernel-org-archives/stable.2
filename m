Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531863;
	b=iUq44g8wHHlHySLZGme6zzUj/OpJdT/GzCPVzA2QuuMyW7n73JHsqGYM3bmFZoqY4zny
	 6CcATNJVsZmkTJxDYe5NptmZ+9miBQXVR7ApE9oo0OhUU4GpOsAtxOFl1XTdSm8JEkrLH
	 zgUT05HDbMd9KYCr5gsdq3OgGtBdvJ71+MGvlcnrsVmgkwllpB5MWVt4kh6NnwgFgDSpP
	 yPwWuYGyVMm/FB4E+glyqu3COJ2iky+i1cFLIrG26fvyGhYeHdszJtkIVT/GVdWO1NQow
	 wtPGGyNSlVja6PSJHEDW3xrnKgikWnfFpFUBhqPQNUIXUX9VaQ4jMJMVqr0tlCj3AYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531863;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=b2Gy4X9HeJehI2wEOaYviLj+m+AOtYE7SYmU4R5eHTQ=;
	b=wCNQXXv7l7sivpOELuPCgKRHQXUnTyDRyHzHf7F/FLHrVbINM+07+hqV9mwQkQsy59Wu
	 3NC4Y2f3iAJ3p62N/bbWyGrn8xYJueRwTPhLwAapxkXb/MfF7aBfeJK/WvK680YJET5je
	 RKWEEc9Equu5CEbn8NA54+26Rib3JzE9yxBhZ3J9BUHqPS5YoBM2hQ6AHtMu+uQ2lIdGe
	 FLOqBQb3aI2arVOwrqYzaHotqb6oAzO3iA6F6sKM49kqPf3zp8rZNPuQsr/rxHiKWlkVZ
	 ZFBVQLtn6mVtoli9IT3lgl6QDU5pqW1nICPqopTQa7lRQwZC5Q78cjLO41bT82bRbMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U177rlR3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE22606A321;
	Tue, 24 Nov 2026 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U177rlR3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0009C1F000D0;
	Tue, 24 Nov 2026 14:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795531863;
	bh=b2Gy4X9HeJehI2wEOaYviLj+m+AOtYE7SYmU4R5eHTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U177rlR3WYERQ7RL5EPHmWKVyG8eEldV0lxu3eLquCA1Ss5rvJPQgTbqbY9ZnjOmE
	 q0SHldb3UHg+IH9+QUzlRSchcgLxbwQ+O7bY4CSxJl/04bzx3sqIBmtNZaNgcHGkbY
	 k0QZklj90Pzcr7JmveiXDWEii1rX/6NsobCZ6tBPn+QHmZKUsenRC8e7wOHtEfd8Ex
	 QOWJCOADQZ/IrY8TLw7a1Z0BWLhNhu+MNlA3NosSTucd0m7/9LIZR5746yBoWH1Up6
	 T6ujXTdeiTG3n+ds1I3qsPPVjwb5bg0b1UDqAy5xx0lq1CYAa+/bm/BpJLOgDLYzBA
	 CyTTuqg0bZ0Xw==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	Edward Adam Davis <eadavis@qq.com>,
	syzbot+512459401510e2a9a39f@syzkaller.appspotmail.com,
	syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	stable@kernel.org,
	Bin Lan <lanbincn@139.com>
Subject: Re: [PATCH 5.15.y] ext4: avoid infinite loops caused by residual data
Date: Tue, 24 Nov 2026 09:50:55 -0500
Message-ID: <2026-11-24-1-daily-reply-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506073835.32481-1-lanbincn@139.com>
References: <20260506073835.32481-1-lanbincn@139.com>
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

> [PATCH 5.15.y] ext4: avoid infinite loops caused by residual data

Queued for 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
