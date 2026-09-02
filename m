Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1C14AD4D0;
	Wed,  2 Sep 2026 22:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387278; cv=none; b=ap0u2ZJ8+PgcvvRvcdcUxH54xYWcl5HzQ0l2AtCGo02CO4HJjcSPmCCeAUZXniyPByheMtsn6u41ahOtDPAN16uBs3aWISK2XlgXMdr7/Y3kNIIJjkg+n4FUknqQUT7k5zz/u8Sv/AL86D8vcICvvPzVGYW2dRynxBrOMFJrHdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387278; c=relaxed/simple;
	bh=1N1zFAyREy66fj/Jh+jau1cc7CodIROS0FWqy5Ii3wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8d/pbdYvPGLXHVB46KuLwNZ4C3yGCGfa5u+I/0Le0JrDdoo0njxx8fy7DUUpOHp9XoEqCvSFuNyg73gAHEgyaG9v07OIA0NBulaBJMkjkIg4114LBXo+0B/A3Xg9U0s6lNN7Pikx3VJyx5D5nlA87gvI5RuRlk0oToLUT+cVjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ny4CnrlY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ny4CnrlY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366211F00A3E;
	Wed,  2 Sep 2026 22:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788387273;
	bh=JT9HSu16g+C4kMeFvUJo+VUDLEf9GRg5cbRFzsvXVBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ny4CnrlY2z1AE1wQ/8pkTCeYmE8qyUm6shjm2TaVk/NtGbZlQP+pKbs/14gGi07o7
	 5rEpgiuQ3/AYV/dJdBAxK4vnCV7WEzTf4Ift9XkOZMrLJFjSKQGZKPS5dwaivdhPH9
	 +wt+K8wwZ8QgCauqL9kGgckljYX+UAiwQmB9IvwUkke0Jb6BkvIKMYumgnbjlZSsO1
	 32faKZbvVbbhVo3Y+Dg8m5GbkhTmX83+GdVRM7fHDsykuoqjo5gXAPterFYdQvBx5d
	 YHXP4RP44GIxrRHK3OwimgG109ukUak/77Fpd+vDrcKq2xn44k9AjoOCDsJEwDw1Fe
	 W7Ny3jplT0C0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+5f8f3acdee1ec7a7ef7b@syzkaller.appspotmail.com,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 5.10.y] ALSA: aloop: Fix racy access at PCM trigger
Date: Wed,  2 Sep 2026 18:14:10 -0400
Message-ID: <20260902-daily-reply-0011-aloop-racy-access-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901103729.70869-1-kmehltretter@gmail.com>
References: <20260901103729.70869-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> From: Takashi Iwai <tiwai@suse.de>
>
> [ Upstream commit 826af7fa62e347464b1b4e0ba2fe19a92438084f ]
>
> The PCM trigger callback of aloop driver tries to check the PCM state
> and stop the stream of the tied substream in the corresponding cable.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
