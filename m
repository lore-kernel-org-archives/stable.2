Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7D0498915;
	Fri, 18 Sep 2026 19:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789760754; cv=none; b=tF+b4WJzttdHjrxu9+oRcUzuv9B0IHn6eToRY6ZTlSYts0CJm88qw1moeUuaMbeiSwib9bXOgxI1gepzaXhXAsQeVRfmrSkoZyn2tCdJuwg+sqSUhizykbxuPpA+ddrYvU09gWo3itkhtm1VchSiVHRbfgqyMqi3LciGXFmxeto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789760754; c=relaxed/simple;
	bh=lJGnWAY5jJsT2hCJBGWpALsy7J3/tbAT0eNUqjOW/jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l26n8mIvHeQKw6VPE3Vs138WUq4EZtP1IRJJlHiblqf0nXHRcyHS9nYpBMApZLpRGyWJ7qUj7HpUJRzOCv+Aoa/Oky2/XO2T8Knuj+p0agPZhBryhxBMaxqqmAYpemD/1PIXoiEgv5oMO4vIBEeFGVYtmDtp0XFCHiHH/qnkqSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PI1OY0Ms; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PI1OY0Ms"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB61F1F00899;
	Fri, 18 Sep 2026 19:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789760750;
	bh=eeIhXIUuXsObJh6Pqk8zY8SHLOxVY4tbbQP/IzP42ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PI1OY0Ms3CDl3JKFnt4JjbFhZNu6Ev1DspE78DVx9Hp1xtL6HoYcljzqliVtt1Gta
	 BSFghvgfA5u3msnlR/mbDrD0kbbpQqsYeXkjGKsy8GjIDT/4SSNHnC2nNCWjChYgsR
	 MwOkG2mFAyzcSDM9Wlm1guMua7YUTscugiJ92rhwPLuGJAnfFAM3cEbmvWQhYJ9/iA
	 g1ylj/ViwtlQW4mGSHD4ibjuzId8hLcNYf2mpMsWmY6/d3WM750TfW5IjXUD56diXW
	 HDYRaSmF83nJdQl+dPvPqH9aAPyKkLZcUqZkTXrY61YWIzloxCdCkqGv2g/7af4+aL
	 oH7zAI/fW5nAw==
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
Subject: Re: [PATCH 5.15.y 2/2] selftests/landlock: Add tests for whiteout object creation
Date: Fri, 18 Sep 2026 15:45:30 -0400
Message-ID: <2026-09-18-daily-reply-0003-re-landlock-whiteout-5-15@kernel.org>
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

> [mic: Backport: add enforce_fs() and the missing s3 fixture paths, and
> adapt tests to ABI 1 without REFER]

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
