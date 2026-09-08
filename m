Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40CE250BF2
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 00:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828856; cv=none; b=H0L6x/DQoat2hPETIyxyKsrGe5GNTtOs1YnGUf3VUMaoY9TkPltDzZx+lyUJHxpnCMkxrWKpqs09xrWwoTwJfcGBlfJKGJiLyyCBvKfNDx4ew7ZdUC2j6A92DQD13aDDWfuOx4Us9Nxie/huOB0cJcy/y6jVpp2UyebI8VtnmSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828856; c=relaxed/simple;
	bh=6Aa3Oh/OYfzZjQnM5Cvru7eXWARousxI+2vlohZUiQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QH2Jbf/LajAnjMdKRvXi1/NrOT8EEv9GYrF7NtT7Jz/OVpofjkc3fxB7AO37DvQzxLl+BIhJnQ/bJWAZa1GkKqOXqtEuVFXn2hbNNMOUON3y6ONQdKhsSPcwLfpTVibv03q01vCWMXZ4NDFuU9pGAWEygVyr5RXBGoeMvHitKYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CauG2H7A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CauG2H7A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F6C1F00A3D;
	Tue,  8 Sep 2026 00:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828855;
	bh=RGVkylAtYY/mR1Af5vZ3OiT/YcdF1Cff9cCPpVpo22k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CauG2H7A/Af8rmb8kCAGqGfSs/kB5SzmrWVmuI1JKbGuAYa0gxVmm+Vqm524xDWkW
	 0n9ULaZUV+CHXrpTZNnyTBI+Qfvh9FVo7OkmeZx+lzHQsiFj4QVAt35gMzp7OHpSGr
	 kObA3IwXMFNze8pcRJWbOhFbt9lZB2R9dUhEV4Iff+5viDg2iu8Wwg+uSUlfofr/QW
	 4dNeCLUdbslCqetfgipL6JmLPpE6NqExlFsWEFjL6EZ+3fjoQe680LSbCJgI38PPkO
	 DiVnAzBoP1xJzPhLYh03iV5PQpVBgw46u4J4PAVg1bT+2T7DqUKwXKBXcNqg0qzsYs
	 PwUQcqWYBNgLw==
From: Sasha Levin <sashal@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Sasha Levin <sashal@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	tzungbi@kernel.org,
	alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] ALSA: seq: Fix port lock leak in deliver_to_subscribers()
Date: Mon,  7 Sep 2026 20:53:50 -0400
Message-ID: <2026-09-07-daily-reply-0011-alsa-seq-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87se3krhcj.wl-tiwai@suse.de>
References: <87se3krhcj.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The fix is correct for the stable branches.  Feel free to take my ack
>
> Reviewed-by: Takashi Iwai <tiwai@suse.de>

Thanks for the ack. Queued for 6.1.

-- 
Thanks,
Sasha
