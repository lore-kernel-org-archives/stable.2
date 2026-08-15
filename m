Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3847A1E7660
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 02:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786761223; cv=none; b=IGLoShXVxX1VVG5QDunU5WIInRB5xbgpkyIqaD0bHbkvNDr30ALwwN78MArUI+TJzAdm6yAaGQxW22lRtI1y38zggU4S7OBWsLcr/pwHCW8Gen7/jnYCx97ZRtKSB7VMnBwwKr84LFSjuzptn97VWVfgZqg5ly1Ka1tyMQ8qS3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786761223; c=relaxed/simple;
	bh=jkfWQfFakUCt//bNjrA/1OsXTKWgyWfWZKvtqKgQ/io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czHSGSpvrxeuIuqn2Mdue1fi/zEWzwNYsF9xh7ChtCwQrCDez+BhljXy/hY/j9OWohEIviLAj/3uX4SdnD2Q9pakelpipu1Vzk6w8d/6vf4YGlDwSTlzkw2RysAfM23V8oOO5wwzmWcLOsxI32OUugZDyT/XRc9dApWoNUvbnFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+ncTVCk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+ncTVCk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF801F000E9;
	Sat, 15 Aug 2026 02:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786761221;
	bh=WQUIb8+2r+Md4DwV5EN8jGcyo9scTUIc1bMKBrPmApU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y+ncTVCk9YXC5ZxFLnBk1EXmAa+ZVB5tXoZRNJ2u0TOXff1u6vX0oGl89ZKHPrX5b
	 tiNd8iq3Z7GBqmCQ53Lj+4S+ax076pHCpFem5njQyB0dT9jRrIoUimtLGHAwqPX1vX
	 fbJ5hJVa9NpQJjP3/x7Jrwg+hwp9eAmM3AzPlRO4YFvlh5lknmw6qH7BGMMbKaV9xz
	 8tFqNRpL0xMFvL5K1dmdBh78hkESZzoxZn8MV9vo/31Wtz+KCb2aS+kspyZURcpZED
	 gVl4y1vzyUJpKkjMCy+kTtKs6P4GfD70lbguQkZeOyUVUr2vAYTShf8s2wFgBu+Cww
	 h9qCFLqtfIgAw==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	dmitrii.omelchenko@cloud.ionos.com,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>
Subject: Re: [PATCH 6.12.y 0/4] crypto: ccp, KVM: SVM - missing SEV/SNP platform-init dependency + 2 bugfixes
Date: Fri, 14 Aug 2026 22:33:15 -0400
Message-ID: <20260814193000.15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814100652.225499-1-jinpu.wang@ionos.com>
References: <20260814100652.225499-1-jinpu.wang@ionos.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Patches 1-2 are the missing dependencies of commit 3f8f0133a5fc
> ("crypto: ccp - Move SEV/SNP Platform initialization to KVM"), already
> queued as of 6.12.97 (bb1c8464702540 on queue/6.12). That commit
> dropped SEV/SNP platform init from the CCP driver's probe path,
> expecting KVM to take over, but the counterpart commits that give KVM
> that responsibility were never queued alongside it.

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha
