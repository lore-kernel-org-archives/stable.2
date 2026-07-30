Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DC22EEE76
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 02:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379247; cv=none; b=Oda0aRZJptKTbcE6D2UbVvmQSRfbu9SKTxfU/J3f9FGwph84VPSBPZYMj8Y6FsYEkeW8z/tOHJLT5pq3aVL9UJp7LE3/HAg1oXWHG7zaOxB1VwxDM7y4yNUZIeiDGqA6wxylg7aM4lVL/ooJ7XDX0qTCE5+yYtwOXXmbO4jrNoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379247; c=relaxed/simple;
	bh=muTi7/ANDa7tPvE56Frw/nlgN+zFzHLXPaTIDQo/oaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFyYwG/gZ0x5s0dTGem1hCLXk9wZFPDw7fcz7/hM0hmjLdPVnT+yiMVXV+2yhByehSx6PFGjB+UeEYb2Nelf/C2zDjD4BdHhmvrx/qj8g+80kMNeYuRvV79o+HpxlBbhJt74jjifyPGrOj3ZtHy2BJcSOeyA+LYtyWvoUZ68cWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtU2MsL9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtU2MsL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C551F00A3A;
	Thu, 30 Jul 2026 02:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785379246;
	bh=ljPnqzUPW7JUeoglF6eJvrMYFhFS/svmpFtskSqyjjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WtU2MsL9PqILsRMEhqyKn1bdJ58J6zCBjNhuyjgAtE1yu1U4OWkQ+Dx5fhmQjVSJy
	 YdRvvrcmCm+GhPSeVWbOWLl5Jx8VaPmSPClgeZXcHXLHAYPm5rWM2fBt7HYe6A6FUy
	 vA6JVGBVkqdNF6G/o6En+BS0SKweWC2S6lRvV+wPRxT3I7CEs48HRE+zxzmeA9MwIL
	 /dV0RRCnzk6ie77MbOKp1QkgHuefDM7fMIJonEO5I0DuSnbfYutSgxAyDDI3QFiyQn
	 q709rztBndfVk+DSGcJs2exRcmZo3BMdgk0kRkIYkI8aySrNEEHRNvBW3/AqkSZKjV
	 ce6JH0XFeg+pQ==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	guanwentao@uniontech.com,
	linkinjeon@kernel.org,
	stable@vger.kernel.org,
	stfrench@microsoft.com
Subject: Re: [PATCH 6.6.y && 6.12.y && 6.18.y && 7.1.y v3 0/4] Backport fixes for ksmbd
Date: Wed, 29 Jul 2026 22:40:12 -0400
Message-ID: <20260729223316.stable-0016@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729190023.46584-1-guanwentao@uniontech.com>
References: <20260729190023.46584-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.6.y && 6.12.y && 6.18.y && 7.1.y v3 0/4] Backport fixes for ksmbd

Queued the series for 6.6, 6.12, 6.18 and 7.1, thanks.

-- 
Thanks,
Sasha
