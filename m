Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EC439D6D5;
	Sun, 19 Jul 2026 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784473242; cv=none; b=rqnslDuMASLEx2rPSpy7N0hGvwfB/faImnlkcwbIfM/EZQJZfqBmd0a8qreMOQszmgCF62ekc7q0xQGaVZYDUQ7EpuBxB9Tns6KyEl6QAtBhoGVvAnG7u8kYHQ+sV94AE9qfw7SUetNljmckIvzRz8HjvFNr78XqZZsX05qKuRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784473242; c=relaxed/simple;
	bh=dzRHrn1Mo4qXkLAXXkoAUi+Pwn0y5RhauZYHKoQtb+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJ0C3IXEi0Nvn3XLbAH4dHg9qmHpP2iSFmq3rFVpST3E4koGmZr14lT6BsdnWbMs1LN4yZmHxAM5urkYz4gJKAroBzBBq5MxqzE6VNibt5YjOY+F9z+egYZjB6InWYRAuzhDu5K6Xo0fmufL63ftJYiO6tyfKtttMGobOtowoUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/uRUoLv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/uRUoLv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079E71F00A3A;
	Sun, 19 Jul 2026 15:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784473241;
	bh=ii3cTMtCWqWfqA7E2ZcVF3XDG7sonjvGyWKO3WM070Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k/uRUoLvPuQv1ddZPvs7mK/oy69Vz8yTp3YspCc0z+53HF1uKrpQQ1GtP38B8dglI
	 pkb+UiJntIQW3jiIFxypDbPkr2F7c5uRhxBVirny7W968AdhU2l/8rfx2Ko5qHNKXe
	 S7WtcJAft7qNBhtvDoODxF45nW4CUMHX0jEbExBcQRt4cqsYEDaDm2kC9FdQVMw8fM
	 wJvGL/YgrLtKQM1Sz74a2jXr5Q+AsNIrFcURqrT96vFZoZ5YSOQhuYTE7MWy5WslP1
	 f1HIxRgQBdV81yak10xez9u7AcxRxuVacLSnM/NmaG4RvGy1PAZpeyv0Pay0bJmvs0
	 af2RSkuC1tM4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexander Martyniuk <alexevgmart@gmail.com>,
	lvc-project@linuxtesting.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maher Azzouzi <maherazz04@gmail.com>
Subject: Re: [PATCH 6.12] vsock/virtio: fix zerocopy completion for multi-skb sends
Date: Sun, 19 Jul 2026 11:00:15 -0400
Message-ID: <20260718192718.0001-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716163600.115458-1-alexevgmart@gmail.com>
References: <20260716163600.115458-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> When a large message is fragmented into multiple skbs, the zerocopy
> uarg is only allocated and attached to the last skb in the loop.
> Non-final skbs carry pinned user pages with no completion tracking,
> so the kernel has no way to notify userspace when those pages are safe
> to reuse.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
