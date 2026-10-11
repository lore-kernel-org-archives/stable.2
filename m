Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862C033260C;
	Sun, 11 Oct 2026 16:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791737321; cv=none; b=T8KdwXS75gG+lYS4xqHbalvL0YXEnRT5uyDe2szuJdNfQJH6KcUY2V8plfHQNTEx/Tzr3rV9PitS+TM9JOHJf5YKgFK+dOKBsKQ84bKOHZhfxqnBcLB/S/ZRDmGLwxp8f24IT+mII8QZgB81lHNPI5RHigvcnubEPvuypAJjJiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791737321; c=relaxed/simple;
	bh=PEYNpCn0mjPE2irxLsVLwKn5xnZ0OGDvSWs+sRGDyN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDg7xaGtRm1UjbQR1H/06XfIacgzFa0MNAAp/hWhM24UljCnhhwjAVbLA4M1c49a6tp+8YYWsAOKZ9f6R9EPEHJsp2kbuqC9cQRte0aEnAPFq4sPWZw0jRNYlsjPOOLkDHyJ/1i8ukLDOFYxumJa5euNFMH9TYLB0aDjyHiNRm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VF+j5gPj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VF+j5gPj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73771F0089E;
	Sun, 11 Oct 2026 16:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791737320;
	bh=iwwkzLXKPmp7K4ihQDAGuJ319BZ8yQsR3K2nM+nALFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VF+j5gPj8IjjjIBikauJwAnwQhdEnaf7UMesJMxS2vKQT5XVlg4pdIqMrjYRDmUpV
	 pAl/7SlzoJ41zmIXgeCSuwE0HgR9lXpALc91Jbqk8FDlXIMUORCR+GVLKMdzOVbafz
	 LY83rkqDkvv0cqV6B7x/EOALMI5Nlw5Kk3m5DbX0SSDiC42LOPvVTmhEe0rot3U5EU
	 AjzpljV7JxTEebUik654wGcbhgf3CMq8Z23Uplr3wXiqbgedUBx5zoJdg7axm+M8Ul
	 brwQO1NejyKiCjE/XPr1hmtuc/9TkFhxTSPS2e08cXZPF89D9AQow/KV+iWiOHrpOW
	 oiYACLEmynOsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>
Subject: Re: [PATCH 6.1.y v3 0/2] mm/damon/core: fix last region handling of damos_skip_charged_regions()
Date: Sun, 11 Oct 2026 12:48:17 -0400
Message-ID: <2026-10-11-1-daily-reply-0010-damon-skip-charged-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010063042.8611-1-sj@kernel.org>
References: <20261010063042.8611-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Patch 1 is a dependency of patch 2.  Without it, patch 2 introduces
> out-of-bounds memory access bug that was found by Sashiko.  Patch 2
> fixes a bug that categorized to be backported to stable@.

Queued the series for 6.1, thanks.

-- 
Thanks,
Sasha
