Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD13332B113
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 03:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787974492; cv=none; b=QjkKUDGwf0bpKVS+IjZnkYEU1fw9NisfFTXQwBUSKocJH+pCJJwzRDkJfvhGuATn44wdS375sKQL6JymvdZaRFiNh7f6Hy/HtxHEPcUJ6uwB6EJKvfCVBwSXxHoHEEK6FBuVPDMerUeUHAUfEFkuKpZ6JInsVTq2bp/GHmr7QrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787974492; c=relaxed/simple;
	bh=ljRHmJ5No2up+3SwDIk1TzjufhrZlj6MX3HImjMNf04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ghv0f0Voj8vHXXB5ZtgHjGDoiYJ/tXBgB40DnMamqZzG8gPa/R/Iv8lfzofYBTYC/aszWRr3ilt4MPaZ0CW1PH1kFxGpTdy3MhG57y5sdXYjbQRLG9rbZ6mkVx5OWPT4E93LOUOjFa9/cW03nbZvaV6ItnGWBIWV7SJELxLIgCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbyN2Qa5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbyN2Qa5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32931F000E9;
	Sat, 29 Aug 2026 03:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787974491;
	bh=/gp8LCiEq97yfNXPMkLeZ9vh8xVWd1HaQ4EzdFf0Gvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YbyN2Qa5nPbbhzSu+7wYBrojmvVgmYIjA3RmZk6krbgQUiZ3EuyQf5PwrfmC7AV6N
	 KN7WpT2t53yt1LJHEwyCdNayqPIMo+ilB7P7fR6Nq6j31C54o+4vnMORxhDHcWpeMA
	 BhBOZ6XYPL/9oKS5gkfEkclyfIr1NYagCRlkm8bjpAjLPNNKsk/WtCWWcYHi9Vzjhv
	 J0lZD7mXfnfmVTEJQVft7HPQMkDsLCetVyt60XPbC42K4XlVb9q76NH7Fbq9tKGEEM
	 fP/TbolzrbY7WSWhmT9DAnTVt2brInjgLKeqh5mTajoXe0k3twuG8OlPqmTkaD8RKR
	 uskDD27iuen0g==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	guanwentao@uniontech.com,
	hexlabsecurity@proton.me,
	paul@paul-moore.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.18.y v2 0/5] Backport bugfixes for selinux
Date: Fri, 28 Aug 2026 23:34:37 -0400
Message-ID: <20260828-stable-daily-0006-selinux-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827180605.4187309-1-guanwentao@uniontech.com>
References: <20260827180605.4187309-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> changelog v2:
> Rebase on v6.18.47, and revert only necessnary commit.

Queued the series for 6.18, thanks.

-- 
Thanks,
Sasha
