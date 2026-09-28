Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C4F33A9C4
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613981; cv=none; b=Eakna8s0Imqow7ygt1NiltqjuMSqCVWYoJOyZxxKXnah/547DaEc+8DtzqvbIfcP6HELFfqBdb77DMOKf4v5+T8nqMpuXY6eOzU9Jfzk492uFFJL6OOzwiDLSR/wTRzfo9J7RgGlVi9GfAu+aixE6EiDRQbKpspMJArui07L6Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613981; c=relaxed/simple;
	bh=p9k4rcOh6MoIA/Ec8lMCSBGg9HaksMyXEBZcq2kz18M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5AoySoOJk21F8Xmk3YpFppek+AwKNhdwVwJEUPzXcQVyJtkYBZ8mMHhCqAFRzyOhZ0fyPkOA0pv9Or7sluzygLoAp3PlWmthcX2ghzgEgw38WMXoHPm0b0XeaU8rO8WKTGdxH7SXEo61kZ9VEbymnsg7JaE5utySSEWQZcLbCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8L2VDao; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8L2VDao"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDC11F00898;
	Mon, 28 Sep 2026 16:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613980;
	bh=2CFIxcNCcDvZkqLJACj2UInN7J67CHzT9Ckm4okLxlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G8L2VDao1Xx3j7UZOhNpUFcWWBsEDYv62BNwpLkj1INKmqIegmDZlgh42MagHMBwC
	 bWXnmX0eqjh5Z4gyJvKuqgvA4+VIzcf9HHJTf1tYFTc6gKCn0OJgxPk+2E+VFGoCLb
	 RyP8xy4JF0U7+CLswoASaxArvVx4OBsPK6CaNLogNmux0l/mVn9OKpayNI8rrBk9hM
	 yagyzdm/wwlJAo5/isiNqpefmY78UTqHFuntBVA48U4p/7UA9AxC5QChU2SJh1jzHp
	 Z34ZtK71kniZZC4yNQxbacmE4Uvu1tdwLTHTIMTQeBX8HmfvERWTFItq5kjp8UVkLX
	 HQo6AXb4K7TbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Sasha Levin <sashal@kernel.org>,
	miguel.gazquez@bootlin.com,
	thomas.petazzoni@bootlin.com,
	"Benjamin Robin (Schneider Electric)" <benjamin.robin@bootlin.com>
Subject: Re: [PATCH 6.6.y v2 0/2] netfilter: nf_tables: join hook list via splice_list_rcu() in commit phase
Date: Mon, 28 Sep 2026 12:46:04 -0400
Message-ID: <2026-09-28-daily-reply-0005-re-nf-tables-splice-list-rcu-v2-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928-cve-2026-52988-6-6-v2-0-0d40c1553ff1@bootlin.com>
References: <20260928-cve-2026-52988-6-6-v2-0-0d40c1553ff1@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> An additional patch was backported, which adds list_splice_rcu(), which is
> required.

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha
