Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E8A37FF60
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 22:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791067039; cv=none; b=CtcA9JPTfEYjeGbXPE1r+ajma70xG4aP5qtEXA77qw2w2JHCY00ODMXQE5HsjOQnaTIWOzwyRMgvos3LSMsm7bwV5n9UUGJ+IyWyEHjRSMHl+T51AX6yLq1GSsC9bNZzM6ANaoD038up3R+xt8hJEUroXcwQ6e5t8PfJIVkgivk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791067039; c=relaxed/simple;
	bh=FH+xS2we0+HlVgxa6Tw/5EcC1mkMm4Mvapx7tQz83Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShSXFajUR2YSVzk+wMMqHqULxVdGA0dRcUMUo8PJiPqUK6CGzffShWQAX//4egbmnSuxk6H94bUnZF4S8RX4Pbf0dWcbrj9fO5K0bCk5dqmESdAfNddRSEy6jNh6unLYiP/IHbBITOPAOgDwDgN3h5qZL1NrnGMh+zeYaLGMg2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YylzDd+G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YylzDd+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F68B1F0089B;
	Sat,  3 Oct 2026 22:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791067038;
	bh=8/jyq4yW42LKshf3hTX9xFurNwa7a1FUtcW1Pcbxxa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YylzDd+G/owrtHS8Izkk+Ve0+QPuZpgaFg6gghTCtoBj/eIXepTo/gdWv5xCTgOwx
	 dqhmkm675kwBuPV6lZSFuWTUkCDYe0NjijBjmxTlUkJ7IJ931s8hfVKlIiwu4Qi7KH
	 eu9+bAae438v5nxFeFWZ99gfcmybMqHqfECw7rfntne6qn0qXHGcNnwc2JJcBSQesS
	 pv1B2iLIubxFIg/pErhPF8oSk1QnYjbOm6ccHD3O0hb4Cho82rRJHlP/6ZPwbknh4U
	 vvYHUMbxe+bG0Tic3cAIpRwUS3QHry5ykBGiHzySoGOVKkV9TGHJWbtDHWKBDtloqt
	 Xu8KRTvxKC66g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	harshit.m.mogalapalli@oracle.com,
	maoyixie.tju@gmail.com,
	Simon Horman <horms@kernel.org>,
	Maoyi Xie <maoyi.xie@ntu.edu.sg>,
	Allison Henderson <achender@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.18.y] rds_tcp: close NULL deref window in rds_tcp_set_callbacks
Date: Sat,  3 Oct 2026 18:32:58 -0400
Message-ID: <2026-10-03-1-daily-reply-0017-re-rds-tcp-t-sock-6-18-to-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261003015055.1241731-1-achender@kernel.org>
References: <051245f8-42ee-4046-bff9-5fd2dbeaf807@oracle.com> <20261003015055.1241731-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Also applies to 6.12.y, and to 6.6.y, 6.1.y, 5.15.y and
> 5.10.y on top of the queued backport of c96a5209dda6 ("rds: filter
> RDS_INFO_* getsockopt by caller's netns").

Queued for 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
