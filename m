Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9089289E13
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 21:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407026; cv=none; b=ZSczdyBvS6eCDc/1ZjOyRuF92qrEks8OS/go20L+IuHTb4AGXz1ECCbY8exY/5r8xUMAAK7qDX6HnF8ATbhln+xJfGCwTzGHJT7f4/lteXzqHmw1xw+l/WizSIBxrzvHRQSh3g8S9fjZ6XgQU4XYxZaxgtNfkj3gMxeoURmck0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407026; c=relaxed/simple;
	bh=PVvd94F3lq43NROujln7rbF44CwLxqAOfp4kMdzShXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtQvcAR2l4jtO3O7itQepggco9pTtHWmlRqyoE/M7d+1QoT6OHr5p/70d+7KURr+OHRzNGqUiEksv1HwEm8VnupmNj3Y7UieHXDpb1I64veT/DE/NtcFLsRId2iDtOj+q74ZuIIaPbSmePTPc93VusJ1DMt1bbAGi7HWE4q8d+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lF7yrDks; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lF7yrDks"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE32F1F00898;
	Wed,  7 Oct 2026 21:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407025;
	bh=DmWpywlKSxhdq5a+1f9fd9mMxaU36COUfllJMenIt5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lF7yrDksuncN3XYahwmbI7FJn8o2ZvyfbxTiw2t9yV8FaJZ1t31coJkBDH94sHRww
	 iz8Xa/zkfd5mg4XTFmyJOfd76obU980O0jAiboW3XL6WPdWGKDwVSWMDpgv+imswKG
	 jAyzBYBKLpmNSXlrbrqqdJhwnCMcJ4uuEYhSAedog+a5g4QoaB7DRn/HsjMrgxjJj4
	 zMoNmIK7kT+NaHd6vlF9d9IXqcBjgI/9j0AZDO13+bAdqZF1xBmZP+mN+Amzc6pjYy
	 Rq2r7UZAhPVx1QBtTnoCOPZMun4nkSDC+rrv9VwuS3jrba9HH9PBWEMnsOtm53kPvc
	 kAb0p+tkB2Ucg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Bjoern Doebel <doebel@amazon.de>
Subject: Re: [PATCH v2 6.1] smb: client: clear setuid/setgid bit on write with cifsacl/modefromsid/posix extensions
Date: Wed,  7 Oct 2026 17:03:18 -0400
Message-ID: <2026-10-07-1-daily-reply-0001-smb-setuid-clear-v2-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006161421.1948193-3-doebel@amazon.de>
References: <20261006161421.1948193-3-doebel@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> When a file has the setuid or setgid bit set and is written to, the VFS
> strips those bits and issues a setattr with ATTR_KILL_SUID/ATTR_KILL_SGID

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
