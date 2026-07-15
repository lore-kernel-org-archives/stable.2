Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2382F84F
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 00:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074371; cv=none; b=sER9UPFtZc231CV97Atfe9xOzWjQKrCne5bkBxsRHbYXzt4oEVA/i7id1fDcqajqMHRDMx9BO4GXPNWwfADjYrWNg1oiLkG/VIcDYWi9zuxS0aXlNUgTRUU46aWXA3gaM/O4lHk3ghd2euIo/EbLxAC5dqOEwsRnktgm2t+Oabs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074371; c=relaxed/simple;
	bh=E4ckGSUBWZZiDLmwDnBQhdPjjePVogARFR/YPGdVz2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/XlgaMW9wgKhTMh0+sUZI4KTlbGnXEXgzvBvjTGtwENmvpH4nljAYz5GZ1C+oQhlqRPOmI2HU7vRglq0f1isDXkGn3teBHSwvE+PI+N0ocbGTEX5SPVZ2ZIzPaQz2wuhJXd63uyw7j+aKynM42mGtGLhoalA+F3Q79eb4L11hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GitoFxqB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GitoFxqB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC3F1F00A3F;
	Wed, 15 Jul 2026 00:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074369;
	bh=SAYXCPd7iA+PG/fQJYnEpZFYA7O1U4l4G1a7vLhLvUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GitoFxqBmykiOK4vNfLOyorB4CpRm4Fun+6sh9z2TQ47KZ7kVVbJLMxjJZSDTJkd1
	 Pc2Bi7MT38Xgm6EKDSKDYgYgcGSAM45chzcehY/qYHyqD8J/e6BtFXRvGMl8VTHSn2
	 /SLBw3N5xSVUTWWZ/ylOJN2hPAHGqw+mXZaZ6bRY6pX3a8G/7ZpMAN+A1QCsTYkNhK
	 a2hedyFLLQ2CngI3DSTvSpq4is9YHX80bj1TITXTbdYnL6CpmEFJTe4sl4dFdDLa0/
	 WRwb3iNZ9CfAyJMx6ijzgiwGArNtsOq/QYo1k7uO387Xdd2/VuXkOt5BdTvkOkvwDP
	 37Siaubq5O2uA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Liviu Stan <liviu.stan@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 6.6.y] iio: temperature: ltc2983: Fix n_wires default bypassing rotation check
Date: Tue, 14 Jul 2026 20:12:33 -0400
Message-ID: <20260714200600.stable0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713154526.100997-1-liviu.stan@analog.com>
References: <20260713154526.100997-1-liviu.stan@analog.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Initialize n_wires = 2 to match the binding default and ensure the
> rotation check fires correctly when the property is absent.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
