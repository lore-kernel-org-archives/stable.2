Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460793CFF55;
	Tue, 15 Sep 2026 02:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437840; cv=none; b=IAcB9tEM6OZSGwSHqto0bATuDTAQMfeNHrXu7mW7wQfsHoP1GTnB9dKaJoSjfMKX8Aa6mPWWVSd63IJ76duiiUi1oUZq53rMZ8XUwFZ7yveDtpBpskJLPjCT3VuqqHXq6ITvoD06gNubb2clXA6e25exP9z+8HMhToXw+wj/CPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437840; c=relaxed/simple;
	bh=0I/otgPlBKLGHuU2YvX6jFtyfcM4XulavRj5rilrl8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6JEpju32O8p+MGfW5Q0kEEYNXi/KZOyI0Dm7XqzmGZVUUEo5yJcrpjnwpAhpPTo1Dw0v57sNpxrhqkJ0Jn5BR0f8M97VybbDzuRnzK4fu7Lk9laTAC9W17h4FC1fyH1dY7098Wv7XuhXKMEXXnWW2/yYPVYwkbEizZEPYfo05M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKIveioP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKIveioP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0291F0089B;
	Tue, 15 Sep 2026 02:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437838;
	bh=z0vL2p+Bd88btvl3Ksm1wFnOPohiOiTkBKSRUoYcHVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jKIveioPNhMqPBhOJHPVrFRe2TZU9csQBTAj24Nftp8XjhJudo+o/kpgK4cZ9MEcD
	 kfA2tqmfMEdKI0BdpYR4ayV7j+459XEIq9gzICqy3hOEpaofPwq7TC+hl1NmMMG17z
	 wCcRRadLkpzn0xRHzUC3oJKos4jCot8G5C1ithqxsMhAMMv8oyHfelW4JRr8etH37T
	 GwNf4RHs6YbK+/yV7P9LIhZEMZhqIUO4xRHVw4e5XYRBcWd/V00wUpfmCL3sA3P+sx
	 Vx42Jksvt7+Zz4nVDvdlyQS8amvJSZMFva2Y6tUF0yGBNOt59vIF+yBTAsmBQwuIQQ
	 KXUEDFhiZWbCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Roman Demidov <roman.demidov.nn@gmail.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Wayne Lin <Wayne.Lin@amd.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Fangzhi Zuo <Jerry.Zuo@amd.com>,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Ivan Lipski <ivan.lipski@amd.com>,
	Melissa Wen <mwen@igalia.com>,
	Alex Hung <alex.hung@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sunil Khatri <sunil.khatri@amd.com>,
	Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
	Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	George Zhang <george.zhang@amd.com>
Subject: Re: [PATCH 5.10/6.1] drm/amd/display: set new_stream to NULL after release
Date: Mon, 14 Sep 2026 22:03:31 -0400
Message-ID: <daily-reply-0015-re-amd-display-new-stream-null@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914081639.12512-1-roman.demidov.nn@gmail.com>
References: <20260914081639.12512-1-roman.demidov.nn@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> If a later error (e.g., color management failure) triggers the fail
> label, the error path calls dc_stream_release() again on the same
> dangling pointer, causing a double release and potential use-after-free.

5.15 carries the same double release of new_stream in dm_update_crtc_state()
and has no fix for it, so taking 6.1 and 5.10 alone would make a 5.10 to 5.15
upgrade a regression.

Could you send a v2 covering 5.15 as well?

-- 
Thanks,
Sasha
