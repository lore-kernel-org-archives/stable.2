Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85362F3C0E;
	Tue,  6 Oct 2026 14:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296142; cv=none; b=gimou72nu7pCsXUhTxG3NrINxrKqylzPh74SaZPYR0yEH28eYKyCTJ2z7HQT1VuOeOVOTes+MvX94Wq+8WtmpkYp/nSEoMD8sPxgL7x7HBczlcjIBhdyuhvw6bSvrU0ByjOjDujT9qG55ted53uJtDsYpO6gExwyE7hOu3a89Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296142; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dUWAROo1jDKSSk5xovT+dPUamcDLheYYMYRFRw62G736H9y5adtw5RPLwDSBG8XT0Z5sqzXFuva3F+Y0SC327Awy/QrJFFDwtp0uIUv9gwJB7JTh2bX8PC606tBHkbcVR8vp31xH/7JcjnAneVrzXDgZUKIJPsU96T/ArSdlwc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbxqU3SB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbxqU3SB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240071F000FF;
	Tue,  6 Oct 2026 14:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791296141;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hbxqU3SBVUQqpC/kC46zV2KfzXTwFNIAk8cKpkw166DfQDWddifQs3u85HizaXb3x
	 H9RVHUNWmC8XdC87krFF5KvvYpvtZ2xCqW0hwRtrF6ow8MueIfHDbklVu41dSxqTYi
	 fEm3tz0pp7UZK1c7fQyvg+ZDan/y5J0eVmDBtKd6c63F98Qyl+fnQxj3ZNWPw666UY
	 pwYyOqHjVM4z0Q1QZsPF4oIwDFa//8tuMvh/OQe7X2Wv/0bneqtb+e4xlcs8twdeT0
	 MBp7HkDrDymWdX6Iq2JA4km7088o4L5oiQl8RRmCB9MLLrpDH9NytNQKfAVybcL1o+
	 8ZH2wG01azLDA==
From: netdev-bot+sinfo@kernel.org
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Lino Sanfilippo <LinoSanfilippo@gmx.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net] net: alacritech: fix dma_free_coherent() in error path
Date: Tue, 06 Oct 2026 14:15:40 +0000
Message-ID: <179129614068.2231598.9785203810491083743@kernel.org>
In-Reply-To: <20261006140912.50828-2-fourier.thomas@gmail.com>
References: <20261006140912.50828-2-fourier.thomas@gmail.com>
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
