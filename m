Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203763368BF
	for <stable@vger.kernel.org>; Sat, 13 Jun 2026 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781362304; cv=none; b=GlfjEJ6Q6mBMhAQCbZbXSdblDjzukDEvhrIL8GZEdbRcV7XarFoSQxCTNnueFQunqbwRQQtR8fK8mfPVumc3TwI7Ljbtmz7um6PGVZ0duABxCw2GXrCSla15rdrKf3fuC2n2/OkK3Uk65Lxinb04Y8AidklUbzwsnKHTnF67LDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781362304; c=relaxed/simple;
	bh=YxcKzlWBR0/NXF7dD9595Lk32P57Q6IUNKkhluQziJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQ2iJ27ThUNzJf6w3hEJS+d6BXO362+LCNK/vwmNqn6vq3IZC2QgvYV03KZkz2WFQPL5EbAo/CODEXIOVI8i3Pev7GVY+EK85Lv++tenS1U2N5k5nNfgrRJ53ZFawjSZlesYWt8pgEflTm0PmQBqer9y+Z+P9oREaOJj8vDyqPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jq2UyUfl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jq2UyUfl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2391F00AC4;
	Sat, 13 Jun 2026 14:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781362300;
	bh=YxcKzlWBR0/NXF7dD9595Lk32P57Q6IUNKkhluQziJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jq2UyUflIAjJ6cteoYW1j0JpRqy6zQWK01TkB5Tl6g+eYpV/pn0I2G4tcegSao3yw
	 cWH7iTLqqE/N4eaHCaBpL5uPIE7dSfEclL8ERhuWPHDfDndCHgdENRTqkeNGhDdJ3b
	 h/yir8qadKNxjHXf90v+boKFE+MRThUYnn271uzAo4K8UcVKGty5I6lTvL3ruHaaUR
	 z+9jnp+ZbR8QKONWrnBqGFjDhiKugGcV9harOAxgLeF2QEGActy0vIUdIW0/pZ0As8
	 dCcbRXyx90DJ8mPmL33WwUCpXWjUzm5IYu57JXxfoFbJOgMJgSLhkhQiULwaz1k3y7
	 LYvgc2RBKd1+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: Please apply e1b849cfa6b61f1c866a908c9e8dd9b5aaab820b to 6.12.y
Date: Sat, 13 Jun 2026 10:51:30 -0400
Message-ID: <20260613143004.0005-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612212134.GA3841315@perftesting>
References: <20260612212134.GA3841315@perftesting>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jun 12, 2026 at 05:21:34PM -0400, Josef Bacik wrote:
> AUTOSEL already grabbed the other two patches in this series, but this one is
> equally important and we're currently hitting problems in production without
> this patch. It applies cleanly to 6.12.y. Thanks,

Queued for 6.12.y, thanks.

Note that e1b849cfa6b6 introduced a use-after-free in
inode_switch_wbs_work_fn() that was fixed later by 6689f01d6740
("writeback: Fix use after free in inode_switch_wbs_work_fn()", which
carries Fixes: e1b849cfa6b6 and Cc: stable). That fix wasn't in 6.12.y
yet either, so I've queued it on top to avoid reintroducing the UAF.

--
Thanks,
Sasha
