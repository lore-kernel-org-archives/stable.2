Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CA635AC3B;
	Sat,  3 Oct 2026 22:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791066875; cv=none; b=tkFEs+IcVRFvMmzlBdzujkmKB43kMvDNyYAqInYVjdPyfu37UgvZ3TQd5vg9La3dThcurFr9BJmVvShR7JCM63y0Shr+E4bkUAftco62Ou6Zkodc3rdSemQODeS5oHvwl6vnV2aakXOq0yA7bBalwK4HE6k0+RbkK8y7va3t6wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791066875; c=relaxed/simple;
	bh=KvBBhm5O+htqV8yAtcsPneZ6zIbOK1dPsGy42ky7nsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfwEU75sg15Hp6KjKs2zPdQw3IRN0r9oKH3QHjTNKurl4Jb3gApnbnCHn9npiXKRCSNlRtWGHehv95aBX7d5D8aKoeWhy13nGs5798BTeyOGT18/N66x48QXD0dDCJ1KbURA33JIUUGcmongmLqFwnXQtyX3wfI6SNF+nutjg8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6T43gxs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6T43gxs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63711F0089B;
	Sat,  3 Oct 2026 22:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791066874;
	bh=44rApmqgvJgsmXFkykLDu5ohSH7xNM5gRY9KubCrYYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K6T43gxsZ2bvAL+QQpP4w6vMAb02j2M4F1p+e9+qmYHVVQxD/Vkr8eDHi/X6MEP0/
	 7nTF0Nm74rQ4q413/yVgh2lAHFgcoIPEA+ptAX5JvW1Z0fYT2rHOQGFEB8yBm8b7Nm
	 pjvp3N1HLcQTz4VHfV8BTuwKUaiu/UUOBrfmzKl1CtfFYSAKrPU5omXQplXboHp7XL
	 1QfQDBoxjoBo0czcrf6byW+k2QXDmddpthNEocN/qWyJvZvyTervhbYJbkGGY02YhT
	 6JOi/wmpDvjfu0hnrInTDgyUTd5EGLJOtpaVnZQk0eB0CEgnBYxX1WM0jn5Ws9h9GW
	 StoMIg6ZejkWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Dohyun Kim <dohyunkim@google.com>,
	Neel Natu <neelnatu@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	netdev@vger.kernel.org,
	toke@redhat.com
Subject: Re: [PATCH 6.1.y 0/2] bpf: backport CVE-2024-41045 and CVE-2024-42239 fixes
Date: Sat,  3 Oct 2026 18:32:49 -0400
Message-ID: <2026-10-03-1-daily-reply-0008-re-bpf-timer-cve-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002193020.19392-1-artem@trailofbits.com>
References: <20261002193020.19392-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> 6.12.y, 6.18.y, and 7.2.y. Could you please queue this series for 6.1.y?

Queued the series for 6.1, thanks.

-- 
Thanks,
Sasha
