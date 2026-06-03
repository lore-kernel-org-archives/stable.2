Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580EC3AD52B
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499699; cv=none; b=FeynMEBZ2sZEj4j15wGESa2A0aK/SBFHNSSuokmW8YpJ6sKLGDjUBRS5oB8Xf3hXi1tO3V5Y8mrQBnZmiLPD/RMBJF1EaKT+TX1ccebXQRasfDO8gL0MXzFdjlEFof4/Cd5eu+RJbrqzyxGwY7Nh1ctBXiYTEICxidcXoj+6/io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499699; c=relaxed/simple;
	bh=rvstaQQOueCrFRpvO4Ln4+OZ1BtNaw56YFgOD9hmKx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVUoANM5n2LyNmVYNjiMZ4gdUdWv6kJGY7V5+WLbqzu106IFw1deeCqUnUnqzoM82sn4xNGuc8Nl4SyjhIlW8jNz0xXVXPQK+GumHM9pPUQgQFbM4uZD61X9B5O1W4NIUN2ZcQ+U1vao+FUJ1Yz2oIme/ARbiDWx3Vou+IAQmwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULgZJjAw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULgZJjAw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6CE1F0089B;
	Wed,  3 Jun 2026 15:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499698;
	bh=J3ZB5HAccrJz6Q3Rilq0rYBRkXNZxh13pnA2YLERoe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ULgZJjAwDyvCx1pqv+YRuhrWrwgHzgYRXWcbn5sfnTPx8EA14Pd3LYh8pnu7HSKru
	 2U1X9FrMVSATDb+l/O5Xv+5vyGnrP3JFr3bBf+02n3MbbeqoxE4csBkuMEf3dEwl7c
	 Ll/L9WEz0mDB+Cwok9cfl0gtM16Dcc+G4uhR7HDHrimxjaHbmqUCUbxREKl0g8UD7l
	 qnLKsrt3GQ8iscyHEFdrQ9M3cE4wD5VopG2SvF3kvKTbqts5Rjd1gWq8jaTLbIitce
	 b1XN9dpvJ4vKTqP4zphMHrQ9VNTTf1TOr98YAkFkPWz6iOVT00KRFFr7RYvaQmZWJu
	 igB4s/ffL3Gaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Paul Chaignon <paul.chaignon@gmail.com>
Subject: Re: [PATCH 6.1.y v2 00/11] Fix BPF selftests
Date: Wed,  3 Jun 2026 11:14:23 -0400
Message-ID: <20260603111500.item074@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780427227.git.paul.chaignon@gmail.com>
References: <cover.1780427227.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.1.y, thanks.

-- 
Thanks,
Sasha
