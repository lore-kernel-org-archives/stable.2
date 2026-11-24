Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479126;
	b=2lFk271f8jbOuN/QqVv5cm1n15X0uUy0b4IihFYldQozvVAwb1/nWRlLufeDrIUgNnxE
	 2EHA+GkHJmbtuCl73ok0p3TFAy5A5FkRRuR5gzHqyjYgwS7S0Q1U0eWrHyXJ5J8NMFCbh
	 kKxFeXFbpIJv+0dwxWbs4k5U0tDKH1ZNYxxdPdJKulhhZ5GnVgyk3oLm8A03GgnaR4I7H
	 73TeeKyDuzJ6fK8ewjShGK19jRCXkSrRzlM52q5CfOttOAu3EF5g5gGZsPvkgVFsDOrMQ
	 w6Ywkqk3Cg39zapvLe0V1x6AIfxqc+6bT1hM2wsYEPSchT4gl+2uR76q2mU6YBL42lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479126;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KaUYSIyeqCVeCloA99kFzTyzrXyLDFC03yQ/mhPIwQA=;
	b=CB03CRTt8fAcIxuT3VIkGs/EUpL5qjdOloxiMIzhUCD+FOnE1FeCMBZ4qGgCOMH+GYHn
	 yjmaylFEHwoCzoAVn/SkTr604i0UnUXpwQGmDnp5mHkop+58XjbZovQvqZfOCSF4sjM/e
	 VyvKdhz+doxR/bZzQcnhqV0ooEshsStaXOwENsEXqE7sJbdr5a4vpMghHtrzkNniaG3UE
	 5YnbKL8gyYDWsv2GBo2JLdbJGrcF7aNduLSafI7wtOQELSNDpXtQk3R1pigNXo3Ib/pcq
	 n1RI8jAcz/0wbQtIzIhsZPEZS9lygRATQ8r8fy+rGsNGz2oTrLMFs+rvSv/a7i7kBYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TEuhes+E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B266D606A326;
	Tue, 24 Nov 2026 00:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TEuhes+E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E098F1F000C4;
	Tue, 24 Nov 2026 00:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479126;
	bh=KaUYSIyeqCVeCloA99kFzTyzrXyLDFC03yQ/mhPIwQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TEuhes+Eajh+LoP+9RJQRinRmNuOfLbH88zOPsMVuEdPXzj1nUGy+aldJk48PXvKU
	 FHubwGRfFyrw74ozipeQORMLUKubbSUVqJd8zO4NEgOw3RdTel952Y3tlbxOiG+BdY
	 GL/D5Ah9g6XRevxYiDN5aG47sM4WjiAvESkXXW68VqUPgMUPHZ2mRRy/IdOduS0/bY
	 O2IHiE41fToJrx6yWO/3q0FDgXNUWh+xvy//yhjv3qacQ7kXqiNWCz94KRoenTf0RR
	 ZoalUXWAen+6WtwyH41pgkU9uEahGuVglgvCt05uK+3H0H9sej1q43o6L3M41OT0un
	 BLhYyEVHBOTDA==
From: Sasha Levin <sashal@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Sasha Levin <sashal@kernel.org>,
	Junyoung Jang <graypanda.inzag@gmail.com>,
	Gwanhyun Lee <gwanhyunlee@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	Dharmendra Singh <dsingh@ddn.com>,
	Amir Goldstein <amir73il@gmail.com>,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.12.y] fuse: fix fuse_set_nowrite() race with parallel direct writes
Date: Mon, 23 Nov 2026 19:11:52 -0500
Message-ID: <2026-11-23-1-daily-reply-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123141235.2477526-1-graypanda.inzag@gmail.com>
References: <20261123141235.2477526-1-graypanda.inzag@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> @@ -1850,6 +1855,7 @@ void fuse_release_nowrite(struct inode *inode)
>  	spin_lock(&fi->lock);
>  	__fuse_release_nowrite(inode);
>  	spin_unlock(&fi->lock);
> +	wake_up(&fi->page_waitq);
>  }

fuse_do_setattr() drops NOWRITE with __fuse_release_nowrite() directly, so
it never gets this wake_up(). That path can run with the inode lock held
only shared: fuse_direct_IO() -> fuse_do_truncate() when i_size shrank after
fuse_dio_lock() (no writeback_cache). A parallel direct writer sleeping in
the new wait in fuse_set_nowrite() then misses its wakeup and hangs holding
i_rwsem shared. Could you do the wake_up() in __fuse_release_nowrite() (or
on that path as well)?

Since this is a stable-only fix (mainline only fixed it through
0c58a97f919c ("fuse: remove tmp folio for writebacks and internal rb
tree")), it also needs an ack from a FUSE maintainer.

> The patch also applies cleanly to linux-6.6.y (5139929c698c), though
> 6.6.y was not runtime-tested.

6.6.y and 6.1.y have the same bug from 153524053bbb ("fuse: allow
non-extending parallel direct writes on the same file"), so please send
v2 for 6.12.y, 6.6.y and 6.1.y together.

-- 
Thanks,
Sasha
