Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C94C3CF041;
	Fri,  9 Oct 2026 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565850; cv=none; b=r4hlGS8Q4YZyc60rlNM8rM1yWiJ2N6Gm+bHzn5AdD7Wbv/P5yQSJMV4DpsboHpc3lRiijQ/aXI463cmC8UBZQ30rMl4LuE7eRQqW2QX2xG8jwod7W579RVMWCfO7hSauesfGfeh97yKKsdIMJ8SiMQhu8aDwYvhcETXdF4/JApg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565850; c=relaxed/simple;
	bh=uh2Sp2B61/jVF9wJgFgd3gWGexSGxoXDUx6uEUduG5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pX97jypC1nSOcov9LXQQ6uQCoxUo+LHpmOxvRWhQj5zty1psDyDbNbBIRIyW9UKQAwiKBx1Kbsfu+A8FXiRqMHOMmqmc5N19oO79dc2jhl6X9RjNQdWNNZLiphV+qhFl3Arkt1LhDo3bBlLd5UQeelxcET+skBSpUFkKbg+v6eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8yaZhdE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8yaZhdE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13261F00893;
	Fri,  9 Oct 2026 17:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791565849;
	bh=4qwijWE2N6foqQkrKu47I+vq7bullF8jKJyIbMblTFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D8yaZhdE8tbOoqKQAUAYZdRQaoyIngSqZulZJu8YK9d1n2ro+mgeSVuu/7zfbkwFP
	 8z2K3QlPmgDr8wraoK1W5A1etcgcEMjURLJugLOLh64ru+EEf9uQWhRDuJpVvU734b
	 fFoFYzkgIFpTEgEl+tqushzzGJBdYXM8ZFfDZpkAaBqXbVPiD9ipvnJi8eoGr8xD/T
	 BwI+7q6gOk4QUyvJ8zROYvQUN6+NfXoD1JAh4sYYNo3fsWk/7p4lNKaBLTqX039ZBk
	 iRi+46hTRrKXcw0x1cMaRvlleLeXG7ql5O7OIV0+gq9XxlHMHmjP+dlZy457SEnMpE
	 kHANTMUD6rWzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	dtatulea@nvidia.com,
	Jerome Tollet <jtollet@cisco.com>
Subject: Re: [stable] Please consider two mlx5e AF_XDP refill fixes
Date: Fri,  9 Oct 2026 13:09:52 -0400
Message-ID: <2026-10-09-1-daily-reply-0015-mlx5e-xsk-refill@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179147141500.99533.12861786180147681790@cisco.com>
References: <179147141500.99533.12861786180147681790@cisco.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Could you please pick up these two upstream fixes for the affected
> stable trees, including 7.2.y, 6.18.y and 6.12.y?

Queued for 7.2, 6.18, 6.12 and 6.6, thanks.

-- 
Thanks,
Sasha
