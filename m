Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B8342CAEF;
	Mon, 10 Aug 2026 23:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786406280; cv=none; b=qtIR2mMXkYpc7QkXThpGm1siqu83STzxiruH/ATz4B4Jc+y37gII2dS49pGYMfFZ4cDpuEuVe8KrhXnDAJy9w5sVnyDneN/ILeDQUb3VjKZDRydATKvjCNE6579ItWOELmbbPyoeoaJ11mI2qS11tXCSPmDIM1qY4CIr3lbKI5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786406280; c=relaxed/simple;
	bh=vJfr1i8f0Ou9rLojm/HpV99ag2h83WKZAxxnzgyMNwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpkewLeDPns1V1cgdmmdy/5rJWoPpIQ0FUMJ210jR/pJcoMIK+fugQ0dyiuXLcTFSrmVRoKsMnvZQSPdwRsJ01xlbE4iRN9QO6B7t38tcRclfeHjYfUo+hxAABgmQZfMtTNeqCr+xOqx7iqLeqT8HZLAfpSFtHLe1rZ7O36yFxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jedcFzKk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jedcFzKk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD151F00A3A;
	Mon, 10 Aug 2026 23:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786406278;
	bh=q+rerF/264fjbpymhEYUKdgwMFbNiefLdZPBTZ7YGZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jedcFzKk64jUcCnVzubKxP3+7nEwsqKP9M3FESZkkLClHnvbIyQB341L1oLC712ZE
	 rZnJ97nqxJlv6uSJJ+4O0971uk4B14tcBKqZ9EyPQu+u2EUXduRZprhtHd9pc0/3fi
	 R5QIT410MxD5k/xLITPgcdrbDOsol0GzK5q/z/Huw3kJm17kvHjHJBEk6KWzLsJxCI
	 qjj/j9UGLo3KjeCwcz52anOsqckUiH2jU9O3KWaTHo+FNGiNoK/fnq9ueVq9IyEZtc
	 nur1Mu5B+PVeW+8r+Gxo/FdPyYIIX5LnZjFQXJlIu+8KG/YkSaLRKItWvQjVpmTJ9A
	 Gg6WS0PuOfcPw==
From: Sasha Levin <sashal@kernel.org>
To: Shuah Khan <shuah@kernel.org>,
	gregkh@linuxfoundation.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Michal Luczaj <mhal@rbox.co>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	=?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re=20=28SUSE=29?= <ricardo@marliere.net>
Subject: Re: [PATCH 7.1.y v2] selftests/bpf: Fail unbound UDP on sockmap update
Date: Mon, 10 Aug 2026 19:57:43 -0400
Message-ID: <20260810234738.0005-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808-selftests-bpf-sockmap-v2-1-c7ffa9a2a652@marliere.net>
References: <20260808-selftests-bpf-sockmap-v2-1-c7ffa9a2a652@marliere.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Hi, backporting commit 66efd3368ae1 ("bpf, sockmap: Reject unhashed UDP
> sockets on sockmap update") without this one broke the selftest in openSUSE
> CI:

Queued for 7.1, 6.18, 6.12 and 6.6, thanks - the prerequisite is on all four,
so they all had the same stale assertion.

-- 
Thanks,
Sasha
