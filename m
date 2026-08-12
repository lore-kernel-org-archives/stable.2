Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FE33939C8
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552014; cv=none; b=KZiOqMQkAbPuqoZmVxq8ZyV19LApVDkb6UQVqvbPbk07No9ouZaC+kbSRUQIWL1BbVC+HCOrvjZrl4sihKNOC9JYXev4V1ZGg8SOgUUz07hjSiZWV8t3ehXja9t7hpTGJb1lVnTF0hQHM1QtKYb5Feb/tc/PB36rolwe6hJuk+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552014; c=relaxed/simple;
	bh=uoUQ4LMAV30obMZtfJE8aeQ27YUvvZVmgmC2qSek1sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtN7Pg97m4DUkwp88B5ugk80vR7ba9WFGZ6c0tFLqZYSAvXStG52U78VTOcVGGFc9CSfzgTSkZ1BL282TCFkAlGmH8ZjMVJnbOKoooZSnBQzDKdG85NSBE9Hm1Hw5MgX2TP020DQwZZoYZc4NkYxfSUOk9+FT1CHZYeTULT3mGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oon9hfe4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oon9hfe4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF74D1F00A3D;
	Wed, 12 Aug 2026 16:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786552012;
	bh=nKkjqSdvIk+IGvSVpwodsokhj/v4EzamX1lhyGyOjNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oon9hfe4BYFszJRtfreXF8nAKnq6iF2hC7GbBc+BRJhGKvS2mEllNIKGWyaZRZQr3
	 FHo9WcH9b6JLlVJGk2+wP9wcQVwDeI66S2wwyVi2db9g+AuRdk82eJ2De01xsrJhEG
	 yc9hLfUEMwOfNHBPVNmlmffEO44unLECxQUZWb7hpU7I59mdJlHP+IpxZUDFuzcOJJ
	 NMLYBP2QlVHMU7aOmm/z5oFBx2XuaRBjThXCIgBJBqMxhkLqDGj20+goJE22a5wCxJ
	 0AsGEvJ7AM2JVBPF8LLnnrYbjYoI/vlP62JP2Cmplb69Z1XGwH21udzDbDdQDbMHxr
	 Ly7nu/MxLo6AA==
From: Sasha Levin <sashal@kernel.org>
To: stable <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Brian Maly <jmaly@digitalocean.com>,
	1143545@bugs.debian.org,
	Zeng Jingxiang <linuszeng@tencent.com>,
	Wei Xu <weixugc@google.com>,
	Kairui Song <kasong@tencent.com>,
	Chris Li <chrisl@kernel.org>,
	"T.J. Mercier" <tjmercier@google.com>,
	Yu Zhao <yuzhao@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: Please apply commit 1bc542c6a0d1 ("mm/vmscan: wake up flushers conditionally to avoid cgroup OOM") to v6.12.y
Date: Wed, 12 Aug 2026 12:26:39 -0400
Message-ID: <20260812161500.10002-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <178652421812.722408.8065577541585442120@eldamar.lan>
References: <178652421812.722408.8065577541585442120@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 12, 2026 at 10:47:45AM +0200, Salvatore Bonaccorso wrote:
> Can you thus please backport/pick 1bc542c6a0d1 ("mm/vmscan: wake up
> flushers conditionally to avoid cgroup OOM") for 6.12.y?

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
