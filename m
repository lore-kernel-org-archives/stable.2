Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E90536197E
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791066824; cv=none; b=rL3e+XT5DB8zfKWx9Meao9KH3bSg8za+BmyvZnJf+4KAAn/YIVCMiFITJHFrKKUXqxBWT2zNQIjecwhEl5rM82KFbjT4K+GjsmT8fp0KTOUHBVHVqrxXopvoPkae1g0XG/DtRGdFVfxRlbxTz/jZLjWQtJWT3T9IWcWi/J22x3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791066824; c=relaxed/simple;
	bh=HvnkcYZ4GvxLIVJ83JW3jm5HZ+Hef5e1Kj3rG8DY7TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YvmmvuQ02hPlYnbhbomPJ2pqGj4dPwIDG9A+oua8iXHTS9EeLVS+NSRWgaItnlUHc2Lr4lTO4KlVLrD39fQBi7GSklogvBOC/gGUwHsChZ5f3GHeTrXOQvjrUnf/2rHkiN0MhbbDObgONVc0U7uhYyMRKXdLNuxFExJYTrl9IvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmJDrR6g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmJDrR6g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F35C1F0089B;
	Sat,  3 Oct 2026 22:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791066823;
	bh=nUi+p7xPHYZkdH8V31na563sfTNM8wtKrq0C45uLUGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZmJDrR6gPZKOLPcahqDI9hLE+Pk/4yyCA2eAC2SxSLrVZnseRCorO70RAuPYoyQXD
	 lpbw+JEniDlV7XQmEoCd5PHUxr7TZG+65JiSluFiMAPAttVdwJl81VNsIqtoXb/6cF
	 LDpk9kGoEnvzTVm4CxKQhSc2aN51qi/OD2/VWqRbp2VZIPzG/e+o3M8jzTlviDy+ov
	 e/k1DZbDbOn3ltIlkKGTE11PAcKOyyyxHbg2lKMUqwa8Ngbl4XhKV8LHKeGUJTBlpe
	 hBkCl02wpjEQzp/wy/bOmGjMcYZAJ/kjXfABB44w7sc+OVAUPcHpSHlqSYRRmQcQUl
	 dVWYKSYfgJMBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Bjoern Doebel <doebel@amazon.de>
Subject: Re: [PATCH 6.1] smb: client: clear setuid/setgid bit on write with cifsacl/modefromsid/posix extensions
Date: Sat,  3 Oct 2026 18:32:46 -0400
Message-ID: <2026-10-03-1-daily-reply-0003-re-smb-kill-suid-posix-clause-6-1-v2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002145450.3926570-1-doebel@amazon.de>
References: <20261002145450.3926570-1-doebel@amazon.de>
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

6.1 doesn't have d413eabff18d ("fs/smb/client: implement chmod() for SMB3 POSIX
Extensions"), so the ATTR_MODE handling in cifs_setattr_nounix() has no POSIX
branch. On a POSIX mount without cifsacl, the posix_extensions clause sends the
kill-suid mode change into the DOS READONLY emulation instead of to the server.
The bit is never cleared on the server, and in some cases (chown/chgrp of a
04555 file, or dynperm) this sets or clears the server's READONLY attribute or
rewrites the local i_mode, which upstream never does.

Could you send a v2 without the posix_extensions clause, so the check matches
6.1's own CIFS_ACL/MODE_FROM_SID condition for ATTR_MODE, and say in the
backport note that d413eabff18d isn't in 6.1? The cifsacl/modefromsid and SMB1
unix extensions parts are fine as they are.

The same applies to the 5.15 and 5.10 posts. The 6.12 and 6.6 ones are
queued.

-- 
Thanks,
Sasha
