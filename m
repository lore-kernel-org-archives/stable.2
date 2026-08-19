Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F92B38E8CA
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 03:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787110357; cv=none; b=EIIBRCU+GfMlQctIxMXwf7WLPwzX0va/pkYRgrpEbMeOFIwCXr4W5aKFFJYMoAYDU7JtWgNG4IcjA//de5imNWOYe1GB6559ukM+SqVBoH0bmZCE600zO9/aLMRzidr3zmNU7pYVVIG+6QQCWo0zUZaiCfJWnm7/uXy0mJprz4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787110357; c=relaxed/simple;
	bh=9OBZAQXbGQxJjSmq2uex97x/V04hlE5wqr5ijrBGFQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjTI/pUzGV4Mq2N6sM4+iVaR8L4wq0gEt1ftCW4V2xOV6ObWJmYblWRwOTijPZmBmnA+TZsG8lZd07gAqX7pTzphG2Log3aVocckak53nJb2znuDyVuPw12/wb0qCldPPxdbkXugW8bL3wOYMe7LYrvUxPP4OLp6V/kuPbbJPG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ul7nv88D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ul7nv88D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081F31F00A3D;
	Wed, 19 Aug 2026 03:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787110356;
	bh=gWmjwiTffPOMN4vXT7OwWtLy6jUj0/x/8YBfTdmvru8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ul7nv88DpNwf00N8wDL+B8Qx/uITI2Hlry6CEGGHAM/dhRZf4o8LCP/NIipJuabd9
	 fz2OTyHyG0dZ/FNc1hIJSP5cXjO0ALp09jeQCKNQb5nzVbt02A2oqSMpYEb6O3bpab
	 /dCxGvgsV5m4AlOWW6Y4XV02IC8wSWT2iwLEsx8pjLNcBBHXveC+uhAFtB0ZG0y8/R
	 aNHru+cLyHjpibrkBtT+YasDkR6QfXrAgmE8wcBG0pc1G/xTpTo9cR+LLHW/SX20oC
	 BkRXHuDpwSWfTdDuMMwHjxzR1IVm9zKJOTeBm+QMFDyNd/vuRu214kfm4I6yNAAf8L
	 6fMgWuClC7HJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jianxin.pan@amlogic.com,
	tuan.zhang@amlogic.com
Cc: Sasha Levin <sashal@kernel.org>,
	JY <JY.Ho@mediatek.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Jiucheng Xu <jiucheng.xu@amlogic.com>,
	Jiucheng Xu via B4 Relay <devnull+jiucheng.xu.amlogic.com@kernel.org>
Subject: Re: [PATCH 6.12.y] f2fs: fix UAF issue in f2fs_merge_page_bio()
Date: Tue, 18 Aug 2026 23:32:18 -0400
Message-ID: <20260818220420.4@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818-origin-linux-6-12-y-v1-1-720b168ce6de@amlogic.com>
References: <20260818-origin-linux-6-12-y-v1-1-720b168ce6de@amlogic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Aug 18, 2026 at 07:19:54PM +0800, Jiucheng Xu wrote:
> [PATCH 6.12.y] f2fs: fix UAF issue in f2fs_merge_page_bio()

Queued for 6.12, thanks.

I kept Chao Yu as the author of the commit, since this is his upstream
patch, and recorded your backport with a note above the trailers.

-- 
Thanks,
Sasha
