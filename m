Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700580;
	b=Kcws0gdz1UV7T0PdsGXTs64C95d0oZR/7pWl7BSpimAkj5UtKFt5fobC06COG2gVdUw3
	 zOlqp/Oio80fvb167RTQ479ItftJu0AxbiZrJB1zfIOd4/0eXXbtBz9xZRvx3zLvlyFx3
	 1ZHiSa+stLMLyLe4VlPhHXgQMhItP+zdOQ8DvP+HFY4ocZv65J+q+vziuLBQ0PLbLMCZA
	 ZtAZpzEq0yYe+BdxDhKISj39r/ml+Tim3it+RDmH1KORje1BFNVYQ17E6zq+INlo+hwXB
	 EvG4/z9UUKhB3GWB5H5trcn0y1Pr0WEuyxPWnxDO1CQeZSk46MXUDXL7U3812xBt2fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700580;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=mMt9FRTXqI++r7+ZaasPqDHUcuRtBzAlL+XD0USMC563Zn2K4FIiTqq/0l/+Hk867kBs
	 CNmedBLBXpkVPRmXYLCaoiWNnq+8w8O1vU+3ZnU4aXOhVnk/I3/ziX/J7Dz9Q1qQWp5b4
	 xkvNpTjo9JGTfXKousJq3bcJRkCLoS/IQEJdaRDmnSDFp6C+pcKeH1QT1ArAq358TbY9l
	 uBemIxFgAeHorTIjAdFsOpoTIkSZT/ut+8kH5ESilRX1elB35Gz63ZUP5O9XLqhMEz/zr
	 G5FBi7wHc9IDbcwnmWM/kt3zgZ/7QgPncRLZ4r5bHGlrQkxYaZHcw5aa9QBSy22hgpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QNWRjEuD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3986082BEE;
	Tue,  3 Nov 2026 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QNWRjEuD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147B21F00A02;
	Tue,  3 Nov 2026 10:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700579;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QNWRjEuD5sptp7JkoDwFqra3mErx4Ycq7rBK2w266qBK+EJ2t+pZDJpoUGGVCe5kb
	 +JmnYwzVGG81Rap37VKkNj3kPZzDitLZyihv9tupnygzyQ4Svu3XCvIOk9O58Z+wgr
	 nbBYhftIg6SpZ0zDry++0CBsTK3weFmOrGacOBOm7+wAzHUpSlzVqf5UYr6OVbsb7c
	 fW0wbtnwFDq4WXCruYBC4RGVTAHCa5YIEt9GpmJ2dKehZ3pAmMmn0lNVxE2iGv+03N
	 QNg3rCd/qCGpfq0zMOXrzPB10IdFOsEsgperLO8XB8ISTi+/HYpxrHMZrSry1BGJbJ
	 elkOag/EPsWew==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: ixgbe: drop the SA reference if secpath_set() fails
Date: Tue, 03 Nov 2026 10:09:38 +0000
Message-ID: <179370057861.488859.14762779860331668203@kernel.org>
In-Reply-To: <20261103100534.1310039-1-vulab@iscas.ac.cn>
References: <20261103100534.1310039-1-vulab@iscas.ac.cn>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

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
