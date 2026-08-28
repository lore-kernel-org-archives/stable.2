Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0508321F5F;
	Fri, 28 Aug 2026 01:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787881605; cv=none; b=Ejui4sRsVCQCLLReYdPQHJ27Mh3uONlbJyd6SezPnJ0OWDUQfYnGJ8ioup7Ef+JjstQyUOQZoDxjYXLVCIT+O4/k7iA8B8KqAZI45+OhEmtJnnYLCqChKll8sVmOwCyBV8CbRh4LKv7HBMJn+eNKgGxltKgNiA6bzvMXmxAZIhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787881605; c=relaxed/simple;
	bh=vU51LggHZHPmNw3cjZcYQosdPTMtD4OZWdGtjVI3v4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLEs1iEinEo+LFgooyMRSzLaSne/LEvBrpdRyimTEV/GnTDeFNJY7AWi/C1f2lT6mquyBYKdzLZnBwFoL65lOp98oQUDycA3KnYnQdskgqqsiDeFNynri4FFp02sX9OugBkh+o88kQz8scD+kAdhS/TaA/bCUtDb3S5PY3wx1CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NR3Y25nz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NR3Y25nz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6A81F000E9;
	Fri, 28 Aug 2026 01:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787881601;
	bh=YWgsq6eqMguaTVFH2AgLK2+8s678oyCj4KEdTTGcwRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NR3Y25nzkzTXm3tpObIX79j2QgDV87qVMAqBjynEG6VrVpPophXlg5BrBuXAWgnb2
	 YUP1YhCcFHUeNpgwWgOBCzonjOz0UsDuuQzrfhCV+egv3iNERpTe5UOihU6Kj8p1Zu
	 G4aJ5uDp7sxblyCfcUMvr43J1YKZT5BIpIvbzmyI+FQv6CQlteOtI6bTMDKGfyoSmm
	 6J7olxEShNvxVH+ajKw11XgIPWvR8mEGL8Qyvfvq2rrUT7brP6LvL8mD9+/BCpGNV1
	 R5JLt8swGliynuIXayLnNynFcJA0XP4NuCu8Han63N/22cs5I2+usqRSR7l/HiKHMO
	 CVKIhHD7gJPRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	asml.silence@gmail.com,
	vrazdan@openai.com,
	krisman@suse.de,
	axboe@kernel.dk,
	io-uring@vger.kernel.org,
	Vishnu Razdan via B4 Relay <devnull+vrazdan.openai.com@kernel.org>
Subject: Re: [PATCH 6.1.y] io_uring/io-wq: fix worker accounting when canceling creation callbacks
Date: Thu, 27 Aug 2026 21:46:25 -0400
Message-ID: <20260827-stable-daily-0012-io-wq-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825-stable-io-wq-6-1-y-v1-1-8166bc2decba@openai.com>
References: <20260825-stable-io-wq-6-1-y-v1-1-8166bc2decba@openai.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Decrement nr_workers only when the canceled callback is not
> create_worker_cb(). Continuation callbacks still release their reserved
> slot, and both callback types retain the existing running-count,
> reference-count, and create-state cleanup.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
