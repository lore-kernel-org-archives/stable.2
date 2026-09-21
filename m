Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD6D3BFE5B
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021255; cv=none; b=HAY9M23i0sErCUyiKCPo/bgUS5lKNZ/soH4v6v7Vm37P7WHG3WisPnl6lhgem6wJzizKWsVmAktj2D5jP/nLlskBanttoSda3S9bSeHEwMIPfr4+Z5pOz9BatmLytfsVrQZ8XwDPRFE2M0UlliuRBdGpHUyvspDgOozdviJ+KFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021255; c=relaxed/simple;
	bh=GebsKRDHt3UQhaWaTAl53f/Sh/f8qeGCKjN+sx5S42A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D/nAY7yf/GhWyVBosAJDZ89N64lXkbHfzg9QtZKBIUr+FBXuEywlTq+YfH8ZZKoQPgJxavnA7pl5C09ucYnbJVne3whTMZr4w2LcSou9Xjgcx6TGM7+01ThGWZ9ZV5x9mT+MOOPOnKqUVom/MDDwjc/Xunqcdl3GbNP6BLyuPqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=B00vAzGp; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="B00vAzGp"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4aa0f1a94so2388553a12.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 13:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790021253; x=1790626053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6cpRmN69U5lCxBcGPQGzsX/kkdZBkTNEMnGFB5cbb5o=;
        b=B00vAzGp78XYuGLYqOz2Vq9anLXJzpwREE9AXmGxLez3d+Y0XAqGcXuD9ExyPHmAUB
         TuZEk3CFW6CkHeK27es8PcyRDIIuyKnLBX1A8mhmTpE1Td2cd5M6QgNCZjUvpyjHL2sv
         YRlH3zTW/nXq2VCVnbWpoE0mzvLdyfIb2SN7SEj6hTtv3XIw5olN7CjhqiucHAbEdjAx
         rbVTUg25voKXZbIaCM0h19MFRc/j+uuubdHU3j+Z0VShiHneaN5N90PfI86ZyDAgXtjf
         HXzB1IG+kKXNbXevS0vCvJCxbG6A1nHZa1CDsLkgZpp69q8ALpelkr/+QZ0wDM/6StRE
         nuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790021253; x=1790626053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6cpRmN69U5lCxBcGPQGzsX/kkdZBkTNEMnGFB5cbb5o=;
        b=znqQwVsxBcPnPSMu7MBjk+p37s4AopnUlOQpoYohxouXS7Pio7Y/khZNN+NiT1ahth
         ymqFQFamxa6SZ+uf4U4MEkUYkYpvqp7RCaLpylrl6g0AWzG18U/quQqowUohvBAs+Ji2
         oWQzL+FXZE4VD9QLE9n6TVYb1bJpm/KS0yqFcGZtBDbHYtCbUdJU7/eGk+l4E5ckrcYI
         K2i5zL/JHCXJ6Nebid/9iiAV9H2jD8yRu1+jn1AUn/whyflCbld3/Oj1D266mSgPU/Yn
         anQUuHVLuC+wz85PsInWGaPxbcY3ZmcwPQK65OLDlkpn7no3tvlt4ChGObr6lZfVpnbf
         E0Wg==
X-Gm-Message-State: AFuF++kFaNuVlkOxkUTMWuEoqsagu0GpS0jNhbMIzIUg3CbUuALTgj2y
	XbIYoRhr1pM6qBmspSNfZ3bVos5aVV4AvK2aqqXQrD8hMOcBVhpYKXoUJzU3tJ5l2elzvKERVRC
	AMwre8oE=
X-Gm-Gg: AYBFou0PUz79ANSYKsAHjHTia0GQ66mRrjF1zsgqHYgE+HKi26yoxYI3Yom8wT9v+gp
	a6kyXcQTpoQ9WtPkFa+2dNzYo+Ewh1AwOALdKfY07umddiB9JwXUnIHQBDMXcUHLpYO6hYm7/0s
	uqoWIy9tLCTnIWoMLuJaLIKMnKiyYvwkQ0oB2Ge89fP3S441s+uVJxWvaRWkVwKygNiYgDWJTiw
	P9dDgke3O6KQL0uVwVKpQ+vVKyofv8qwS4BCCtLltlCSPWoaEQFUwnI9fuP/6kMts/lYKG6RkHP
	26+tb6dG/hpDJXuKzF1CbBBb+zY87s52Saq8c6uifD8aA253xH4gjotqVZjXmKYv0SorZ6KPXyS
	acoxqEpORd/6L+XtzaQz/ue5Hi6rlOJvhSz3ppc7K5eRCwnULGZhJNU+PL/ZoqTXw0vmVYUHQNd
	LtfiQeD4Jatn8j/a4fCEYc/0GzGBC5ovoJs1wp0UxsBJVfs7nFqMh6N8ogqhAXXOkWzOcsKCMUA
	XkYNK6NxQnixY3Q3MNKujy0TvVhjn8zb+97teoNdTrbOZryA9JtgK/6YXrH6UeqSwtcRuY=
X-Received: by 2002:a17:90b:1c83:b0:39e:6c69:34dd with SMTP id 98e67ed59e1d1-3a06b0caf64mr39927a91.65.1790021252643;
        Mon, 21 Sep 2026 13:07:32 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:289a:f600:f11e:a45c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e5ebcdbe8sm501164eec.15.2026.09.21.13.07.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Sep 2026 13:07:32 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Ming Lei <ming.lei@redhat.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 6.1.y 0/2] blk-mq: backport CVE-2023-54227 to 6.1.y
Date: Mon, 21 Sep 2026 16:07:24 -0400
Message-ID: <20260921200728.84114-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha, and block maintainers,

I am continuing with the smaller CVE backports still missing from
6.1.y. This series handles CVE-2023-54227. The first patch frees excess tag
sets after a queue-count reduction. Its immediate upstream follow-up moves
that free past hctx resizing so the repair itself cannot race into a UAF;
they need to travel together.

Both changes are already inherited by v6.6 and every later mainline
release.

Could you please queue the pair for 6.1.y?

Thanks,
Artem Dinaburg

AI assistance: An LLM helped find the missing CVE fix, adapt
it, and prepare the draft; I reviewed the code and build output.

Chengming Zhou (2):
  blk-mq: fix tags leak when shrink nr_hw_queues
  blk-mq: fix tags UAF when shrinking q->nr_hw_queues

 block/blk-mq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.39.5

