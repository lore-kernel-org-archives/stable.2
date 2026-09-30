Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669BE3B5303;
	Wed, 30 Sep 2026 07:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754259; cv=none; b=umT1n0xQ+q5G01XEGV/DUfuH4y5JSou2huVEOtYMk+M2dKwZhm48LDvJVqSwVLoyk7WxYDQ5j3WfnTF7KBSgC59udF4iAX/YO7PBSrG/u1InKeojL6LkhrIs4Am+s08uDZ9b7N4oz2Bka3zNptVZSs/PoJZd6jeJHnGgKISz74Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754259; c=relaxed/simple;
	bh=zvpmhm+BAUlfIVJ/6Kp9ShG7pA3G2q65FWBMzuTisWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t3BvYIn/RPLlxsdIVRcntRVhTPSZioYnrdoX+4CVWhmU6vSNwd7aOue0fgciK5wQ6wslJL3K/pwESa0haNX88G7otL4APBJ5u3r2qiVpOik0k1k7W0VUVWSn24JK+2gDGRsPeQEwjOcZCp1sWw4Rf+biNOUd0aZS6H9wKlDydfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTUZIhKd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTUZIhKd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFC81F000FF;
	Wed, 30 Sep 2026 07:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790754258;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bTUZIhKd2N/OplkKvZHRqKyTUQz4po5AL68ifzVN90jZeq25Z5Hzc6c2oyul3VVM+
	 1imvVMlJv/MYWtmle9Pncuw6k8zO4H4JhN4grgZYTY7x2r36Ug3J0Ko9U+X1z4qjPD
	 nDv4Y8BbhdsvY4saMyizpCdPpPVqO5CVxLYGA03zbzo/X1ERb5KIeEjG5RlHavHHze
	 JcgYX5btkF16IVDJCKiCdGgspmzlDvIFghVHHXGJCIovk4ALvvvDXPgsS0DMgY3L8e
	 wFZszrS+88cqEfeDzGJ+GAzO4Ce9yxGZ75LPlH2DBPco/H8gWLAYtCKebXmm5FcJix
	 ZrnJuVf4SpsWA==
From: netdev-bot+sinfo@kernel.org
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Sukhdeep Singh <sukhdeeps@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: 
 Re: [PATCH] net: atlantic: only free the PTP IRQ after a successful request
Date: Wed, 30 Sep 2026 07:44:17 +0000
Message-ID: <179075425701.31693.17457011245131119734@kernel.org>
In-Reply-To: <20260930074023.2943213-1-runyu.xiao@seu.edu.cn>
References: <20260930074023.2943213-1-runyu.xiao@seu.edu.cn>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
