Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A45360EE4;
	Fri, 18 Sep 2026 00:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789692792; cv=none; b=DMhC5YRPDyUTCNdjoginjFj8oaK3J4TzDPuGKcw6ZrrqH41TNp7I0uUwT3Xy1zWQfJv31KwIzivF3JyRfY12ZMEo+S5Zdq2LAoF163lYxy2is9h4B3AtfZLqTRcXB0xvVQ6Y933kqnSoW3oqhVETE1KI4acts6779MKjMkRLxcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789692792; c=relaxed/simple;
	bh=ZhN1vky93wRevgNcgWoe0i5jCckTDopm9ui/ofeo7Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKHeqxXRFowh+zOoxVqnbevOwOUsYfcZrhfhX1LDQm0lDuG03A7A7uluDdJ2iG8eWOwPQhMWM3zTJAWthmTN+IWU5We9Tuj6eLmNAUqX1v/o5738+885zy2RMW1S4/qG5SByKjqA2z42+TR45xc0ez2/4ZLbvmAy8oyM1ZKMExM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7/AKb/8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7/AKb/8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03311F00899;
	Fri, 18 Sep 2026 00:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789692789;
	bh=3P8470NtfppKxM6NzTXLW3NnoZTqQRukdD4i+mf0CHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V7/AKb/8EzDJPDeSXk6+5l0AL1mYIwAFfT56ZiXxXo+ejczeNhk5fZ98SLpl03mVs
	 MT2JnDSNKqN/qJaPunkJyn6copOvBpGTrhTn20nXE2PVJSRa1rBnd8/HYivJdLChOr
	 XooDYnKECy0emizFZ8DlCbcNxdFFI7vrg0B2xIFlgVLd1s/Rl1cvKI9e+nT+h4BuRT
	 7Wyt0K3/hgZvtd85y+hGzXzFBCrgzhzFZzpQrqugRWa96qx6RQjSsPCF3Jgl/HxYpP
	 xGSO/0OxBfraKUGsouTmJ2Gwc4OWzvizHvJpIeqHJqL3E0qD9ZfkGzD8vCUgjCrHsT
	 hD8vNc5tbI0sw==
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
Subject: Re: [PATCH 5.15.y 2/2] selftests/landlock: Add tests for whiteout object creation
Date: Thu, 17 Sep 2026 20:52:42 -0400
Message-ID: <2026-09-17-daily-reply-0015-landlock-whiteout-tests-hold@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <88432dfe86f2aaa9ae499587fd7acff9d34a338b.1789655723.git.mic@digikod.net>
References: <88432dfe86f2aaa9ae499587fd7acff9d34a338b.1789655723.git.mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit ee890889b30b22f9a21636061def7a04e4f89380 ]
>
> Add tests to check that whiteout object creation is guarded by
> LANDLOCK_ACCESS_FS_MAKE_REG, in the cases where these are created from
> userspace:

I am holding these until the newer trees are covered. 7.2 and 6.18 already
carry 672fa082d48b ("landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for whiteout
creation") but not ee890889b30b ("selftests/landlock: Add tests for whiteout
object creation"), and taking a fix on 6.12 and older while 6.18 lacks it is
the wrong order.

7.2 can take the upstream commit as is, but 6.18 cannot: it has no enforce_fs()
and dc75f8904694 ("selftests/landlock: Simplify ruleset creation and
enforcement in fs_test") does not apply there.

Could you send a 6.18.y version? The 6.12, 6.6, 6.1 and 5.15 patches themselves
look good and I will take them once 6.18 is in hand.

-- 
Thanks,
Sasha
