Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCD83B6C13
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791131435; cv=none; b=NpsQDuMjYpJHH5NRL7DkF/Y/E37chmddXBj+mwL+JbPdIfd/M9Xb9B5x/PwkOckWwfYFbNCiCzlHiBRbbBLx/N6E+aQJkCybk22yxJm8O8aLMNFy38slVtqs+WhYW/nxyHPK+5bQFsHi59s+T+NZzvSGsbB7rr/8JrJC6GwQSbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791131435; c=relaxed/simple;
	bh=g25VuozRyS942mZkzTpQwDRGFaH8ZOOm50SfatzXQqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+fF5Xc7nwLp7sbrcW1W/8il2xU4loSAxQ0mjg03WZNR09XznLhtHvvQg+dgLM7+mb9yAF2uYSBeTaxjEzp91RiBc17Y0iCbou3LXkqAm+JYnBZA3E04aunQx//1DQAfJErl0txqdxXE49zf2gknY/MTWOojuRMS3msRZ3c/LTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKJAvEyc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKJAvEyc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398DF1F000FF;
	Sun,  4 Oct 2026 16:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791131434;
	bh=JHh3YhrpQnpXtEr+HWDQFu5FoOj+laxSDn4gOWkJMn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MKJAvEyc9vbUroc+8ryZnuugTrwqd+yPRpkP29Vc6T5UJXym3sjkKX6T01wpXJdaE
	 iG4vbPZYLu0WXSzThnJCg2AlNli52AERY27AJvwJASEWsBAf/LVl/KaCmi2cwSPhne
	 C1fnWq/HZlWAirTtI7fAevUjL6bnFsVTIix1HcyvV7FKFeeqJNCsjwjUx01Jos7G8U
	 VUkP/TFESeXXrHDKdQuLDLey34gEv0flMZ9ba+uo6FycDvkL8e0kU0tIEyWKLeAKb4
	 NnxymE83PGIZmkkCD+cdkNeRcT+HOu/LB9AENQrul6cn+UWwWFvhLq6MJNvrmnX0rk
	 abgfaX7qkNh+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Bjoern Doebel <doebel@amazon.de>
Subject: Re: [PATCH 5.15] smb: client: clear setuid/setgid bit on write with cifsacl/modefromsid/posix extensions
Date: Sun,  4 Oct 2026 12:29:52 -0400
Message-ID: <2026-10-04-1-daily-reply-0014-smb-kill-suid-5.15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002145352.3925654-1-doebel@amazon.de>
References: <20261002145352.3925654-1-doebel@amazon.de>
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
("fs/smb/client: implement chmod() for SMB3 POSIX Extensions"), which 5.15
lacks, so cifs_setattr_nounix() has no POSIX branch for ATTR_MODE here.
Please send a v2 without that clause, after the 6.1 v2.

-- 
Thanks,
Sasha
