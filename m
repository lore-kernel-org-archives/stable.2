Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEF837646A
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 00:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789692786; cv=none; b=iKDxWrAMxTSCtIMTuR11dJcmgzP8L7Hqd2obR0ur3IGzNreeoELL2zePkrGz8/nGzEYlNvWzl59u0fuEg8cc11+0XEvRZUVp8cKXzq04Ddbaw2O+jPwpvmwtDs1JV3EqyP212YIYOjunCkZyLTpB8t0fLQWToIvJ0Yln671fNwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789692786; c=relaxed/simple;
	bh=8Y9G7dRzso6cJGFNOxi4lmvdgwzEBwIfGg27GB6qLxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NfYKP79IJn/v/CX4C6WVRdciY7LSHlFnYOQTqvLfNb+BsvwoP/z425MrsfGlGEtfIpsfaogTtYKEiB23qrg0+cMqprGYnVAqJe46PQrWuml6Yzm8Y2uCmzsAytR8xd0vlVDe9FtyPzuY+3qQOxcF+tCnXtFBqocadbo//EfJbmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epl9idlU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epl9idlU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454E01F00899;
	Fri, 18 Sep 2026 00:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789692785;
	bh=txSDb1Gfga6dflibsNUYY9ubZg0x6IA8k7EXEohtv98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=epl9idlUaJAtndE94Q1zE5X6ThwZusE9nkfRGJ9Ua6XtKwcPypThKA7UKSRPXf7HN
	 k+QADkwOJ+P0Ej6L8gylgAHeUaV5GK74g35m15bqlOKDg3r5rmoLbI5lPUwk2w5Tcz
	 NOOteywgj2x2Dnngcj+93Q5rWDfT4oh+yBWefU6HJ9WdZdHseDbPTb21piuhpYKj6z
	 feAjxqidMczmTTHxkrG9AcdQNe4PxJVQsEVjrmLHFAmMbFqnHtvz4SvYfkoViSo5un
	 BsL+W2NoUE4htCJ5XOo48dZYT86ShW9m9D73Z1NXm7gOuQiB2nM83TSWR/78nSaeCH
	 ctyVgcS0HY2hA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	=?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	=?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>,
	Song Liu <song@kernel.org>,
	Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH 6.1.y 1/4] landlock: Fix handling of disconnected directories
Date: Thu, 17 Sep 2026 20:52:39 -0400
Message-ID: <2026-09-17-daily-reply-0012-landlock-disconnected-dirs-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <71ca68abf74762f78612f635123cbfe1773b6de5.1789655724.git.mic@digikod.net>
References: <71ca68abf74762f78612f635123cbfe1773b6de5.1789655724.git.mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 49c9e09d961025b22e61ef9ad56aa1c21b6ce2f1 ]
>
> Disconnected files or directories can appear when they are visible and
> opened from a bind mount, but have been renamed or moved from the source
> of the bind mount in a way that makes them inaccessible from the mount
> point (i.e. out of scope).

Queued for 6.1, thanks. It also closes the gap where 6.1 shipped erratum
4 without erratum 3.

-- 
Thanks,
Sasha
