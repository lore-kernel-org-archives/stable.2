Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F3837F739
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 19:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789327515; cv=none; b=m8Zt6N8aJsy7KKM6nZj4SF0yn34tfdoaVt0AzEbR2RtgvkHrN2pD4Weerr+qmtei0H7ZFfMyMKBqorpIdCD81udpVdtnItJkSKUqycCQ671U38iyd64cphzoYyIna3P2KgZ2loDXmDkbMMJcKZ7dhMM7Xdu/Vjy7FMQQHZtxvCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789327515; c=relaxed/simple;
	bh=IEHj8+/NBMCpzccJHWJCbgJwrrIvxl98kmy7wm+Anu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qu356qHBidBL5pR5cBqA+z2tK0KuyZnmkrFr5BddJHtMY+KFlhVY+f1WSOARUTiHe7OO8RmEVl1+K4vJr1JbqrmgZFgOFflVYAi1dTbg/p57/VFX2pOd69pvHXw0URNC+2tmcDYWQ1sVpc+oHXD9C9kka9P5OyXH+3sqH3RR9JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OREg7fgy; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OREg7fgy"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485933b2522so1184750f8f.0
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 12:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789327513; x=1789932313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IEHj8+/NBMCpzccJHWJCbgJwrrIvxl98kmy7wm+Anu8=;
        b=OREg7fgyAQQbMdF7OgNhARWTKxlZRnGdClSTd4kNZ6sBLuybmjIINTnB3cNJxUII0G
         SHZLw0fgx/67vjwUoHqBt6P5MG2UB2++I/i9FWYmI/1zWq+qhkeiBcIqRsY3d09IhaAU
         Gb/bdZ+sbat+U7DhRhasM3AFEh/Itztkcf5PQBrtGnRNcZVXn6NGOljs5akrEVemg0xz
         9sNoZLDSGFf9YE/NUVzEsOCRuhg2MZmGevToujzKKvjOTgnfKB5d8eFc3lTvwTtsAf9q
         1HfoIAzPMpMKad6sG1bHj9QMRVZf0Mjsy0OxeyF7XoNOFenUS7W5pELhUrTjoeLQ1CIG
         gACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789327513; x=1789932313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IEHj8+/NBMCpzccJHWJCbgJwrrIvxl98kmy7wm+Anu8=;
        b=lf30//v7aa0aD/ZcMnjBsf5anKDw95X1NidvCNozrUMkwRkt/sGfSy0fOILN3UpWJE
         m1dpz0Fj/xnh3qB8VOkcNw2p3YOM37lnYvPQamvLv3H3lUx13+h+S4HHUmRIyQwF+za9
         3ErAxKBwrtCDvW5IMChdjD/eJsubCS2Lt/VJUHJgKkwWEiHWtRtubE/rd2LCVLrkGV+9
         Fly5T/V1+7w14yezrd90y8qNf6fetxMMx6iKji586/q9mY40EeGuguvwC4lUvjGqdyML
         BHAaemzxG70vIHYS5tS/CHzrx2fwto579DJVZkDiRM8sORsDoeM4SaIThjbGt0WpUfJf
         d/3g==
X-Forwarded-Encrypted: i=1; AKwUvBxvFeKGbFQR8RQ1NWYYqeo4BUrGu98f2kEFO+JisDnCokwBpyPyQn0GZPJ8gIMJB1h+1my3wVs=@vger.kernel.org
X-Gm-Message-State: AFuF++kmEhg068ORWcHta6aZjewFhy6AXhOcZGxiRr6UP6/dn8bjmPdZ
	jbPeE2bOaVLtQvQ/k/l01KwMO2JKdIUwqZcJrGWRVdfob91VhBoSlOdp
X-Gm-Gg: AYBFou23t6/SPhTOiPjqShCfpknuvZjq8DL8vEOqCuRJZuJbxAdshqZUD1+2TIjoxZL
	RKhJJ5DnTdijCRXReJkTwLizo5WoGlL5G83SZOfxjaYQxYr2Bwt3HK8vGEpUBOppz+emcBIazW8
	AO/b7Rtsl8GEfsctpKBSuI4h+A1jOhTQCYOBiaJUz5BXvWn5FQJThHAZYqiCj2vQ6ds90bAHfOc
	0hsqoambRsnG4qZrUHgSc0BnljRNwwC24kxD1FMX+JG1e1w9ZbtaixS3H1kzkxv5n8y9BHoRQF/
	X+dPKc7W64KTKDzRP+hiOlEDdvFoQCtGbDpoisXytDzEQHN/EUXXMj3PvzqqVl3lcSW4Y/LhRk7
	iAUgmk6raXXEsYORdY+lw/Pmy0dHTDEL6guGq1Q6IYAQaZjxSk/EGd1TSeEnnFWvdALTrniWs2P
	wu51rS1p5tY6b8VVkiN6sa+8JOOxnIGqieS+gzcLGjakawqHvhulPZU8mfIelos0WXdM+gEc9wj
	XItmeBdqpCLug1vkmhX4FuAn4iVa01XKNTpvPqfU6XuX+tNGVN8NhwXj9OwE2iFYRpcAPJ1/UQK
	g7k0K/jTNlCN9m3y4UBlGjUcDhQ6R9hPlOOj9jafLfDDuzbA76VCqd2HBXEx804qSaycKDKbAGt
	CiPg=
X-Received: by 2002:adf:f9d2:0:b0:486:e6a2:2d7c with SMTP id ffacd0b85a97d-486eb31b1ccmr23284644f8f.15.1789327512581;
        Sun, 13 Sep 2026 12:25:12 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a0e6-2301-7846-2cfb-35f5-6359.310.pool.telefonica.de. [2a02:3100:a0e6:2301:7846:2cfb:35f5:6359])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb2ed0fbsm21480307f8f.3.2026.09.13.12.25.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 12:25:12 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 1103/1191] net_sched: act_skbmod: use RCU in tcf_skbmod_dump()
Date: Sun, 13 Sep 2026 21:25:07 +0200
Message-Id: <20260913192508.2469-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260912065612.927930999@linuxfoundation.org>
References: <20260912065548.086904252@linuxfoundation.org> <20260912065612.927930999@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please hold this patch unless a 6.1 backport of upstream commit
3016024d7514 ("net_sched: add back BH safety to tcf_lock") can also be
included.

This patch replaces spin_lock_bh() with spin_lock() in
tcf_skbmod_init(). A rate estimator can take the same lock from timer
softirq context, so the timer can interrupt action replacement while it
holds the lock and deadlock on it.

I reproduced this on 6.1.188-rc1 in QEMU with lockdep: after the estimator
timer ran, replacing an indexed skbmod action reported inconsistent softirq
locking on tcfa_lock between est_timer() and tcf_skbmod_init().

With only the skbmod hunk from 3016024d7514 applied, restoring
spin_lock_bh()/spin_unlock_bh(), the same test produced no lockdep
warning.

Thanks,
Karl
