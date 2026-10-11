Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05040361675
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791737317; cv=none; b=ZJg/Bpvzup8RQe5troGWoTFfWpCe7mklLu/7S7gFULydPlYGGB1TqNTjtZ0izFgn08Si1xplQJA7VP8vXzetsWJq18U3v7XmtvtCuRB+6IXC/4nxTHPgYeU6zibz2xHCWMOMgTEnnDd7Mkkcj1gPsDaUc5ngQciWsGmGoN/Wsgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791737317; c=relaxed/simple;
	bh=ansXjhdbmJsSZqY7LNPwCELPiuH5gHOfW2MX9Au4R9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTF+CJyG0h442oh2p59fq+gMjCdB7mPYlEEfzyZyLTd9GJod6Q0jSfBwtkFc5IchSmLkxnivoEDc88t+EoHCqbD6LXnuhes9FAKbItqbVe8/yDI3QbyWHc+x8POq3UKVDgsVTOLxHcf1gDQpXnNCAkyAxDMNhy7eZTybjhpYgOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoV53xnQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoV53xnQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AFC1F0089E;
	Sun, 11 Oct 2026 16:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791737316;
	bh=P7uNgjLR1ue2A+THKCnp1XkskAQJ4zRbuEndOSWWT90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PoV53xnQllFG0C9C1Jl4xSjUw/61Y7xGtmyOW+RKm9Pv+NlN5UQv5cCOd1o4vF3I8
	 4WMWuigw83ag+/DEtTO0flVB9nLh8Es2nt223+IN/95yfBpe0/pbVbL0Unjnwnnzj5
	 jXimlSG53CDPOzXynHGiFrBlJZz4ADDyNUCsMhfiLFxqGlUH/9LcYdCHz5uBLSgJhC
	 m1CxXYdQA/VsAhUaaovW7xLs2eGKOSPYOEYsMDQ9bJ52ZzpEhqM87oqjk79AS5wSDu
	 DtE/w2fq+XoXvYKcUsRQFscWXmKEnItBnwgaxzZow9jtZmZhAO42SKPo3YFW86LIXS
	 r4B+mCB8o0RnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH RESEND 6.12.y 1/3] f2fs: fix to reclaim space in f2fs_allocate_pinning_section()
Date: Sun, 11 Oct 2026 12:48:13 -0400
Message-ID: <2026-10-11-1-daily-reply-0006-f2fs-pinfile-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009112220.2276173-1-chao@kernel.org>
References: <20261009112220.2276173-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> It needs to trigger checkpoint to free space reclaimed by f2fs_gc_range(),
> otherwise, fallocate() on pinfile will fail easily even there is slash
> space in conventional zone.

Queued the series for 6.12, thanks. Patches 2/3 and 3/3 are queued for
6.18 as well.

-- 
Thanks,
Sasha
