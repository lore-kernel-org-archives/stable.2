Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D99235358
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 19:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782158065; cv=none; b=m6IFReJ/iK9V7z8B7R/5MQenXFXTX2dY99YnMrJ89jEw4ZYwtxvcm+Zx7S3x7grNHnVgw4smKvzAobKgumnqaKpu5CjVDhcuyXuhxLM34ZEOaa7q6G1oItWv4WDI0AigxwCUxm7m07OEOTWW/w5rnlhYbG+Jj/gnDGc597EUBHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782158065; c=relaxed/simple;
	bh=5VBFf45a3B+NN8rVgt1gUW+jPbWjbQnUQ18nAhENXRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXZZAR6C+L4iY4uGflZdOmmwYkrFTqIGMvqvCfPUoPx4XpliMwqNGcUMQnDCr+an5DGeQ1Z9ejn7FXOOcEitRJqNeyXLj4sMxThvx8Ueqkn0shEi/9OO3Y/KhR/sgpEhm52L+7R08J6hFzmOAGWWXZ9eZb1ianBPTg+6JeIOrHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNiFIT80; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNiFIT80"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9159A1F00A3A;
	Mon, 22 Jun 2026 19:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782158064;
	bh=rYDunGLvQ3h6FaJhHkxitaunydRZIYNEhPtyp1EfZhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QNiFIT809ujgmXpvOAK639KELfPl48bmO7wuOOfNbCOklZc6Ze9gXsOZvRBNXjBSo
	 Ec8dHY72jfedKaxyS+qT6u2CvRDFppG9pYJ2+0/g0F9djVPR/94OrsrbrEQx18MPdf
	 NU36um/AHRXmmRnTrkCdffPA6g3Cz5PyAhjs/cecGC42N4GoZYqePNWaaoIvlpABUz
	 fQFAY5auOdlh8ZW8itwFd7REMAEA7ucgwqrgTqGGtC9/l7d+D9qAd2MxBR9jyJxG/c
	 xda6QqS0B1AKkQoFcAWI4Nq/f+Yqc6rMOuFrmRTN2J9Mgc6bhzibZAI0UEwO1MUrPh
	 tZV9dkhNv+Atg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [patch v6.1.y 0/5] debugobjects: Various backports
Date: Mon, 22 Jun 2026 15:54:16 -0400
Message-ID: <20260622152404.0003.debugobjects61@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260622094345.511524619@kernel.org>
References: <20260622094345.511524619@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jun 22, 2026 at 11:55:44AM +0200, Thomas Gleixner wrote:
> [patch v6.1.y 0/5] debugobjects: Various backports

All five queued for 6.1, thanks!

-- 
Thanks,
Sasha
