Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69901363C73;
	Fri, 18 Sep 2026 00:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789692785; cv=none; b=CtfLx4bDViMIdGBo/eeB9J60/tzofYGFwyRiay1WtUcuz5MZtDGfpNxecgeaQPzlXz/dDwhClVEGqnbSPx0H2G6F+zZyj8YW/HViV7oh5QnLAXLVDQ0pONVwfys/pmKTjBscYmY7moWJ9Ip2ib6Kq8eF0Ogbm2EJDpAZNkBOpLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789692785; c=relaxed/simple;
	bh=4rSpVDRw3KfRqQElYQ/6U7vvVqZlwdtdJ+OIY5ZbNd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLfLxWLNicQzURE/8MQ5XP0bqzpn5LicbFMKwn1FDyZElyrWQhK9tI74u7lKAE9N7kvLXcVJeSL2PfQ7kiJmw5MZ1onuScvg1H7sVKMSUHjT7WbJJkgeRHobViAVlNjrfDtfXPJ3Tk+YJWBoBqrYtzH+E+X8bxdj7eIetR2RAX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoqApIKH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoqApIKH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BF71F00893;
	Fri, 18 Sep 2026 00:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789692784;
	bh=FufOZFrat4/V9B8FOuTnerSR/nqhw6zOwuLUreu9eYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QoqApIKHjqIhbOFqp7ZSNmC9CRR3JHer2GL6nAmfnbwQtM3kT8N2Ipj5oBsDtqrvu
	 WFh6zjDpgjv1voQdVGv1G5yEXjv7RILdnAdn0KAKUnYwWJ1sHXrN2rADNX+Bw2aKjy
	 /wWL7itsjkjx/GDOkFFSZo5Q6AB3BZhs9gkTRAYULTZWpOUCB0kzO9j31J66yFT3Wj
	 Znj5cGB7Besfg1lYdp210t+alohXKkWkWXs+dvirdNeF0sFf5AMuSW0px1kB1kvpg1
	 sFIwlJJ6MowrEyDvL+KEk7nJHoXSybSfqs9Cu28byZeFZJBGjPzp8UOM6ZOdgQc8uJ
	 Vwai9xkQ62HXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	=?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jann Horn <jannh@google.com>,
	Kees Cook <keescook@chromium.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5.15.y 1/2] landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for whiteout creation
Date: Thu, 17 Sep 2026 20:52:38 -0400
Message-ID: <2026-09-17-daily-reply-0011-landlock-whiteout-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <a1915a39f4c8469dae12d207e202588d6954bb92.1789655723.git.mic@digikod.net>
References: <a1915a39f4c8469dae12d207e202588d6954bb92.1789655723.git.mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 672fa082d48b21e1fb62cdb184fee41513e53421 ]
>
> Whiteout objects are used in the upper layer of an OverlayFS to
> indicate that the file with this name does not exist in the unified
> view, even if it is present in one of the lower layer file systems.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
