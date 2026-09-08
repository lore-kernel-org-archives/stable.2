Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE70A25B0A4;
	Tue,  8 Sep 2026 00:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828871; cv=none; b=pG33Xh1rbBPurdMSKxoFMNBwFIfUqcdSbqGChPcVNz1QDVSFe7pYkTcAeSxtvKvFIcfQ81z1Do7A6Bd06lT3njwe/o/5KvBz90w6RGb2p+sLG4uBUY61eycyYRdQNGDVUTjbbAlepqUGCr0atJnSu+ZmU6FFpm7WT27hlzcJbTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828871; c=relaxed/simple;
	bh=urulPs8xBZRa9mR605svBohkXrC+2ywLOWlEwd7aLio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTGgfMSOd44j3pdknWjPSe/0cHtchp3QLezjin5/EGQk7TUUOR59/Kf7oce0xNf0UBUllv0XZc1uGfSBPlLvgoQzXRkvlH0ZkLSNLygsSXjCg8QQm1ce0r3xaIiLsoXpw+CnHQgEEr9QCTGvtiVqlw7JFVeBiddzFgfJBYS9v2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gU3DDjSZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gU3DDjSZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84F61F00A3E;
	Tue,  8 Sep 2026 00:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828867;
	bh=Ierh7BhA2lugTrhu1M2fPcGnIA8C1lQpCJ7l8fML2Og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gU3DDjSZXGq1mOfr5DM/su/E4acdAwZWMLXCK/tshvmvQwcWy6vM4EEuY82HQSIcf
	 O1GbAb+kxBuT+jzLKA7iDuG1PnzMyrnbjagKCYd7o/SJYJX/Q2HErBR+fhqVHDp8bz
	 oAfoNkQfYgl0e+mbsRsnSMtEmK6oNbKWUn2hSfjiWvEMwj01FNo11ZMyL+YfKigCOP
	 Hlclh9DNlXR3SzoP8bx+HgA3VpVebEQMmSWCUeowK3Ssk1her97V2p2BCJiw+Xlxkz
	 kBP9M4Jz9H94gMdvZQqq+w4Q0ifLhSBX0GwipgMG+jxMK1XLzhz4We70a4evajAcUq
	 C4hh/XhQz+llg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Miguel Garcia <miguelgarciaroman8@gmail.com>,
	dmitry.torokhov@gmail.com,
	gregkh@linuxfoundation.org,
	pengpeng@iscas.ac.cn,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1.y] Input: aiptek - validate raw macro indices before updating state
Date: Mon,  7 Sep 2026 20:53:58 -0400
Message-ID: <2026-09-07-daily-reply-0019-aiptek-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907184959.1567893-1-miguelgarciaroman8@gmail.com>
References: <20260907184959.1567893-1-miguelgarciaroman8@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> Link: https://patch.msgid.link/20260329001711.88076-1-pengpeng@iscas.ac.cn
> [dtor: fix macro fallback in report 5s to use -1]
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> (cherry picked from commit 95dffe32a66cbed07fbfa7afed39d56d5014e04f)
> Signed-off-by: Miguel Garcia <miguelgarciaroman8@gmail.com>

This is upstream 95dffe32a66c ("Input: aiptek - validate raw macro indices
before updating state"), authored by Pengpeng Hou and adapted by Dmitry
Torokhov. Your diff matches it byte-for-byte. Before I queue it under your
Signed-off-by, can you confirm your relationship to this submission (sending on
Pengpeng's/Dmitry's behalf, or an independent resubmission)? Want to get the
attribution right before it goes in.

-- 
Thanks,
Sasha
