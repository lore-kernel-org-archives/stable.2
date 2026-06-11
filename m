Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF75136358
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 00:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781138731; cv=none; b=Kuootl7jzMWsnwVEKqZY6bi1Nx4V/phDbhECfJb3T6f/KV1u1nJuKpeWN4g05LzYllnCOxb2XwjfwxfYvwHjq3PeC8Z/qKczEHJ61BFWYaR4QFAlbLNMuCmJVVM9bECqVFB5ol904ZlH4uAHPAJl9SvtDJ6q++ssXsoT082IDuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781138731; c=relaxed/simple;
	bh=MNnhgKsXKLSb7pVL6r24xoJkPgTOKCxRDS5m2/vCuBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djheUYAa+C+xJn7dqsZXztMpzRGiOlOmp0vxc59uIzUGjhqREMr+y53RSygEWf/wRbLXhiQb47X9enIE/pjZw3YBarLTj3ypBWfWJq720+umxzKNnI9oATgQXYQcJ1S7QmzYVksVPK111hkBGQODy9vfPDg4/ViA8JqZaTsuYoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjIeccS8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjIeccS8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DFB1F00893;
	Thu, 11 Jun 2026 00:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781138730;
	bh=GAsM6h3VlB/JQ83dYEgWUs9hN4roS8bdo56fOT7FoCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OjIeccS8z/AHdB5famHCkjRO5hNcQ3Y90gFAqGUxrzM2CGWUteCtNZ8by1s1ACvZO
	 EKT6S4kmHvocwbKr2U/wFV1hqe71kOMbLdAtYGFCvBMcMaPUnIgkX0nlvzCA3L9L0u
	 Mq6CPP3gB7LNc5zjTC/TXoDM07V8jRv1HDgxD7Tl92bgmk0pi+YFvFRlbVCIfWCr6o
	 KhE58YN6yIY7gArag1n+QlKZkx6EDlmMy+UyJyKLj6xd8COlA6pUfR4RlK/ZyhDOoy
	 oblZpmTag+bR7+zXDaRhhLmngI9FbX+P7ccjESRhA9hB7sEwy5nzaPfpJWhBFtG5Fm
	 77bR4oIfRwtoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	chenste@linux.microsoft.com,
	sherry.yang@oracle.com,
	ebiederm@xmission.com,
	tusharsu@linux.microsoft.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com
Subject: Re: [PATCH 6.12.y 0/2] ima: kexec: fix kexec_file_load panic with IMA_KEXEC
Date: Wed, 10 Jun 2026 20:45:17 -0400
Message-ID: <20260610-stable-reply-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609215844.1835378-1-sherry.yang@oracle.com>
References: <20260609215844.1835378-1-sherry.yang@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jun 09, 2026 at 02:58:42PM -0700, Sherry Yang wrote:
> This series backports two upstream IMA/kexec commits to 6.12.y to fix
> a kexec_file_load panic with IMA_KEXEC:
>  [PATCH 1/2] ima: kexec: skip IMA segment validation after kexec soft reboot
>  [PATCH 2/2] ima: kexec: move IMA log copy from kexec load to execute

Both queued for 6.12, thanks.

--
Thanks,
Sasha
