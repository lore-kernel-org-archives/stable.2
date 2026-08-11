Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01283E16AE;
	Tue, 11 Aug 2026 18:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474568; cv=none; b=B7n/hcQwfD3HFQZ/yGhiktqmse6+AQu02Hx3yygI6hbEdXiydQWCtpLRkk+hfnZy2DAzsEH5gHq3A3h3dRQEhAJBX9J704zFiET/tqyssxn8QIhnZwqshLTmrJ0fO7yBB8+U3ToVlJ9qQEb8H22tV719kbtRGL8aVp2025ebtJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474568; c=relaxed/simple;
	bh=JQJcuS0inougcGk2EFyU95PedYiZ6t6/NmybBEus6lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVw2yW4AMQ5Ru12/FbTjwMN7TTih4PJivT2w8mD6J9UpxcSS/4rcS5E3wVzOCKBUYxfwBrdenzY2Eea/nwr4cYcJ4hKwREQ7C7qdzj8sVPObWOkxXQ2Bhq3ovc44Q7C0M4wGCAvnzAVG6znb6SHIboC6Qj903HQ/FDaK5Qyj6uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JO5xusKn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JO5xusKn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2271F00A3A;
	Tue, 11 Aug 2026 18:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786474567;
	bh=WguRyZrowNxfU7BRQOeMCu12e4drDxmzeT1j5M286YM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JO5xusKnQqOyZaz1HAoXOLZ1hyswxYyURwj9yhx43GG9cVJM8iLKHW/VrdMd5c0p6
	 EAbKM636Z7cBaneWVngxSJtXbNsBmlb1FkXwHOT1wF3nmNMTf03cTuFEgmi931t6T0
	 GeoMiqJeoaXaQ7eJZ2d7em78yr+ABV27t0wCq35jKZgQ21YNQOnTdYjmJCFEEjqxdu
	 bYy0Dt8SGdJ8tQizLihC9vu+GncPOzCJhegNQYv8nwSoU42mU2RpQWoU+qxNJRKQ+/
	 Qg0lgx3alJdSYuKo/8uY17t1Sk3aueFEYBXTaW6aLfGtMxmrNe+v6REsKO1aj9hFOT
	 Wp4eSoKtm9dSw==
From: Sasha Levin <sashal@kernel.org>
To: John Stultz <jstultz@google.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Jose Fernandez <jose.fernandez@linux.dev>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Janne Huttunen <janne.huttunen@nokia.com>,
	Zicheng Qu <quzicheng@huawei.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Shubhang Kaushik <shubhang@os.amperecomputing.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Xuewen Yan <xuewen.yan@unisoc.com>,
	William Montaz <willymontaz@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 6.18] sched/fair: Revert 6d71a9c61604 ("sched/fair: Fix EEVDF entity placement bug causing scheduling lag")
Date: Tue, 11 Aug 2026 14:55:51 -0400
Message-ID: <20260811184500.stable-0006-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CANDhNCq7sFij0uCT75B5aT3voABaK8-=KMbKMNdO1Yi6QWRhng@mail.gmail.com>
References: <CANDhNCq7sFij0uCT75B5aT3voABaK8-=KMbKMNdO1Yi6QWRhng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Do note, as Jose pointed out you should probably take: 80390ead2080
> ("UPSTREAM: sched/fair: Separate se->vlag from se->vprot") as well
> then (ideally prior to).

Queued for 6.18, thanks - and thanks to Jose for catching it.

-- 
Thanks,
Sasha
