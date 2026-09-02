Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6E13B9D81;
	Wed,  2 Sep 2026 22:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387275; cv=none; b=qf8Wm97bvScG4+cdxxm8pJIwXF5F8tAm/yJRCjTe3Z0Jw8N6wtOP534iqhNFB3v/712Lruw7pD9XRkOUnZJombWyzaZsnHzz/Pu/TKj9ESgeBVGcxRYPQjCyEbcAZVBONaVSPXtI48hcVoOhrJttr1nFkf6/O7AaJ8yrp1FIg+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387275; c=relaxed/simple;
	bh=A4pFNK16Gy3IGury3q4khKtvERzO5Fpg6vXbeRHsFAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3w9GV2cJ4KIcnthoKIAjvVia4/9i+IjBgXZHLolIeAHIvddVO8zVuNgFCG4/tcWte6glovcZlB4sN3TbdLgHlooZ0NpaO0eHeGy27UxrpyOyImaxUq5CeDKbP1JKNRVLPvmPTn4fUZJ6jJynH10YCE4QplxUe9j1ejKlygk7b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jC7Vg191; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jC7Vg191"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532CB1F00ACA;
	Wed,  2 Sep 2026 22:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788387269;
	bh=8eZo0Fj5bfcbaIJiXC27Dgb7m59pepPqxpuHkXNCh7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jC7Vg191XINPiY/w7bdCbbrPwktsjjVI3bB8M/rFFW6PWLwq6Se7gZZpftyxVXTuZ
	 8oaXCrZbooGIm7Gilo+0XoKp4/7n9VejfN5/G2p2ZRI/AaK9Vg0NjjvF/WiNtwsxbm
	 nSeQ2q96Y5lCS8HwdqamFVPhRLzpY++zW6xdnk+bkMmg9MC9f87Ga4sQhs8dGF3XdB
	 txPwzgsIQBXyGklEdLQ4bdxxZvicd6TOe2wwb6y3bc1EtUgwPaj0RWds3clhL/PszU
	 HEGnBOv2WPSCpf5tX0VVaH3pm+O5CsV9SihN8N+v0v6cHNcgCCrMIoUbmT3ea9TGnm
	 bFDydTHhsS7Ow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6.y 0/2] ALSA: aloop: fix trigger/close UAFs
Date: Wed,  2 Sep 2026 18:14:07 -0400
Message-ID: <20260902-daily-reply-0008-aloop-uafs-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901084637.66106-1-kmehltretter@gmail.com>
References: <20260901084637.66106-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Backport the two ordered aloop fixes for the trigger/close peer-runtime
> races. Both carry Cc: stable and each fixes a separate syzbot-reported
> UAF, but neither reached this tree.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
