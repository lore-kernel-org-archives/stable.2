Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18205155757;
	Sat,  6 Jun 2026 13:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780752690; cv=none; b=H/rPF3Jz3jZnHeUtZhV9kSnb9FjKMAl5KJEf+lrENKgoG44A5c9qQoAEcAqNDnEYB1a13boO793yXTUx9zmc7g5m2cYVEzZD/aDeuYizqErH2Rd8GlSgDmCtnkeee61N30QgekFI+fKc0o3f6R6TQ6nRP+A/e7SlmXERefvfr0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780752690; c=relaxed/simple;
	bh=S0Y4vTzhu1uVbgQSJv23zUAtEwJgda+GHw5VKxaOXdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/XDr0JcmT4I+aORGZ5KNWJ+J7749+DZdcEA25FaoVSUP1v4osodxX/ve2/E/98pz6N8C5QwwBIhlZcV5BuR40DjpLqNnqpQ6OATSL6ZPYDEoaaS6SeAq637GtJwnM5RMFptVJjHfG5WU6qaPuerVUGXh6KgC0TdVhbgWt9g9/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hz5DttO7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hz5DttO7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F611F00898;
	Sat,  6 Jun 2026 13:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780752689;
	bh=iYlUnCtiF3nT5sjh1FybYoMPA5WXEzUG7/rae560OPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hz5DttO7XeTfaJtsyQFpPiNjhrtocJlCmCW82kNufxxwsz05hCUhVFQbL4GTZzpnt
	 H5V45/3JScgGQBNssRvQGkREyBcokJod/0Yk5Hp6K+RfPhiQoWbNcJGGKOjldK4eBa
	 +ftnqtf4oecZSQMzdMYY5ZZ5nSMUzxDvVmPHyBxqAZ2Z/m9mxOm/70dL+W4zYVKK4+
	 sDWcv7RpF6AXyFk6wai7Kptg9DYJATYTamkq+9MIinI9Ybz8H2MZJ7JrxTG4if9tTE
	 pZI1RvViUQUXl4b7m9BPW89vAYsRZBJDNwGG/ZnZY1VnZ8APNPWgfrJ26X+iMHVmXB
	 l33Qre50bvjHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexey Panov <apanov@astralinux.ru>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	lvc-project@linuxtesting.org,
	syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com,
	"Nikola Z . Ivanov" <zlatistiv@gmail.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH 5.10] team: Move team device type change at the end of team_port_add
Date: Sat,  6 Jun 2026 09:31:16 -0400
Message-ID: <20260606-stable-reply-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605134700.23565-1-apanov@astralinux.ru>
References: <20260605134700.23565-1-apanov@astralinux.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
