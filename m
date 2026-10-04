Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B112D23A6
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791131437; cv=none; b=l1gAAXKKJXDYQ1L83UGYZimhSGMzzJ5PWKfm0+W2wMU25U2T4j2vt9MceLfu92zALYukbWRxTq4KxhwmUBbZD4eF0eL/eiqVuEIzE95z2GNrD6sxU6Q9fUYxN+zSpptYOPSzQeZ2vxtkhqOwK/rOi4fnPWWNDYQtkIpXD79vQO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791131437; c=relaxed/simple;
	bh=h7uVoLQn3zM/pSniNz3ZXJCRlfA0H0jezMqmUE3F+3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hoe01fbO/2ayWr5kfeQGdY7KvqMICEpsbef+A1SU31XUcvqsjg7lRkg9j99E2+NplJQwxrZkFH6AdyQ/TKQGAJkenJYv4MOsbie02ApsY7OggraSCqGCnO/Hd0dfw0k03WEjGu/oaPi7XwrLMLwRpXHvkhHTqvcQ03XIDlICK6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/I9G0zT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/I9G0zT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776571F00893;
	Sun,  4 Oct 2026 16:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791131436;
	bh=QZT/zph8HlhRV0OxqjFI2qT9VfXAfIRZFOlJRwQlv4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G/I9G0zTY9cSpcXKVDq/uXi25ABnV2Ee88FnrGcT8ACBEvo7koEeKd7/uhNovGRpg
	 TxgSrAt6yHTAhnafd9gHiXtavP89Jve81/fnfDM3fHzMvrm0PiuyZhRuWhZUzOIVaT
	 tKYVW4Fwykc1AQGaa5cgoBQ1y4+xY6KKf/2KFAutBaHi5NRfXJTACZa0Ioy9lnEUL9
	 0s+NsLs0HXFONxyKs7ZPELEIRkAiNLAXI2SvNAVR6AEIEUnXMl7nq5sE+sMqjtbeAE
	 pd+u7v2VCKcfafV8bMFB/Pl1lGrBOUsxYp81jlerB0F5Y3e8XyO6vEVbMEwsVqUMYk
	 7iw6fZYSmPezQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Bjoern Doebel <doebel@amazon.de>
Subject: Re: [PATCH 5.10] smb: client: clear setuid/setgid bit on write with cifsacl/modefromsid/posix extensions
Date: Sun,  4 Oct 2026 12:29:53 -0400
Message-ID: <2026-10-04-1-daily-reply-0015-smb-kill-suid-5.10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002145332.3925377-1-doebel@amazon.de>
References: <20261002145332.3925377-1-doebel@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> +	if ((attrs->ia_valid & (ATTR_KILL_SUID|ATTR_KILL_SGID)) &&
> +	    !((cifs_sb->mnt_cifs_flags &
> +	       (CIFS_MOUNT_CIFS_ACL | CIFS_MOUNT_MODE_FROM_SID)) ||
> +	      cifs_sb_master_tcon(cifs_sb)->posix_extensions))
>  		attrs->ia_valid &= ~ATTR_MODE;

Same as the 6.1 post: the posix_extensions clause needs d413eabff18d
("fs/smb/client: implement chmod() for SMB3 POSIX Extensions"), which 5.10
lacks, so cifs_setattr_nounix() has no POSIX branch for ATTR_MODE here.
Please send a v2 without that clause, after the 6.1 v2.

-- 
Thanks,
Sasha
