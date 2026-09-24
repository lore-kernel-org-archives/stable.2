Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4FC32A3D7;
	Thu, 24 Sep 2026 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270025; cv=none; b=ZDSwcxyyT9pz+S8mzTNgp6fHHlHEnhhgqsQmGCGKn2UwWl6JPwsgTSvmgLC9BELkt4REe0SjinMf3YMf3DoKcUDhSu8C8pHDJFJzVfzJRp88a6RLMw+eiWK0upKZuNifPb8e/wegKbTKpseIDOBupWJJKjwfSSg+lh++8gyjcmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270025; c=relaxed/simple;
	bh=QxXA3uQ67pgUn5t/RopmcMZoZB7kY8Vjao6R/aiTHEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rch0kGCC7EzkaWh8fnjtCAOMQo9SdRU3eL4AkuDCZ+geNPptNRUtRi+wCA1b5f8q6d57OwToiQu1D3x0LbEXx1nGHJy947+3TZEoPMbs4xeKKqp629cE16p1F6lpaYduQePlnnReaSgEdBooyhvE9zR5yX2KURY/M//2XcT/uog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyOCmc+o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyOCmc+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85231F0089B;
	Thu, 24 Sep 2026 17:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790270023;
	bh=u/pJXEDfDeQ6yuR9LZaN1ivK75isMoDfQFPvPEhsRWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UyOCmc+oRDedfWO6Fbkv9I58sxx4FdMi+M5pATNmmWsFIl95BPint7E81aIrOcnQD
	 2C2roi0z4VhNIX/iReH1afTUHyHTpPOgKv9lqaEojfHeUJXgZ4zLoQvQsRO9DIdALp
	 a6k/3TEd7SFYK8oyfJoioJLcfea9gJNx4yqnWpatuZzlYbp/iDSoplN6Zbnl6cZcc6
	 BhhYEf9JIg/xClWZ0oLICo1pTJDZIDteKeKqsMmlSGziqcM/efDy8A0LVxetRvkPVo
	 Wk4wyyciWj+pjvsSyyJZGQaxF4yp3zlVAWMPeyQiDAd1RemNu2Y0Za/xs4uS3hmNcN
	 kVOFa64P1UoGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
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
Subject: Re: [PATCH 5.15.y v2] selftests/landlock: Add tests for whiteout object creation
Date: Thu, 24 Sep 2026 13:13:28 -0400
Message-ID: <2026-09-24-daily-reply-0009-re-landlock-whiteout-v2-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aee05236ad5600be7fc35c089b345eadf6bcaba8.1790169454.git.mic@digikod.net>
References: <2026-09-18-daily-reply-0003-re-landlock-whiteout-5-15@kernel.org> <aee05236ad5600be7fc35c089b345eadf6bcaba8.1790169454.git.mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Changes since v1:
> https://patch.msgid.link/88432dfe86f2aaa9ae499587fd7acff9d34a338b.1789655723.git.mic@digikod.net
> - Add a guarded RENAME_WHITEOUT fallback for glibc versions before 2.28.

Replaced v1 with v2 for 5.15, thanks.

-- 
Thanks,
Sasha
