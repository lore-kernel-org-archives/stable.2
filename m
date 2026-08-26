Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E660A348883;
	Wed, 26 Aug 2026 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787737111; cv=none; b=Ty0FsbIcLR3YaIElKKNG5HH0W2XbIXCT4GmzHcrcYWov87cnrwggVgwkAI8YwoWvbA2vj4tEWk40vhaQdrX/o70cpn2vOwf7WDlaLFP/wnFCUBaOEHNfvWAr9RSG9oXw6HPRxxx2lIUti6On/dIPbJG0qMHxaRfzVlxcqq/NvII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787737111; c=relaxed/simple;
	bh=6bVOqBdl49sdHDmCOJe4ZmIN7iErvpvzosx4LgLVZzg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jsvMOijSjq/rPT9mwf7/Lt6+if4oBf1J4n7+zaYAOF0+xGou6otMP5eqJS+R+S86Zg6FEhtexEJQwHvwqAAqNmm9e/G3AdGO0YzV5on1DsZjXp3EWmnmwD098smOJUYAE3abi5dHZ0iEc1J/d1WnVFoCi9zXxv0aGcHEknhj/a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=O/anL7e/; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="O/anL7e/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:Content-Type
	:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=qXvejcODAxGSNWT+P7/G06X5KWDVt+HmEtzp2DOPF+0=; b=O/anL7e/bbzLYbpOxMk6f3ZVWa
	PAIEn1EBjxVM3BmomzTcZ8UDWrR+RsM5FcjQ/xt0q92cSF1H9ybzRSGDibLQLV0fPtSK6CLexBHDx
	11xCw+Ad/UJkE7fP6bcvcgG1pnq0hX6B5LodxmM+hz/u/goGz4RLOiBCihLHA+rTCpfBQFq8RAPHq
	UDiblsOFDF9Z5jNJ26EduF48gJfmYMsECUQRZ39oPyGv4wemTUl6jRiBicRJ/oaE6AzIfN2WI4ngh
	nPDvk8peMjT7a2kMs5I+PKUQj+YyWEen3PtFmJjloEsStIigsTxsOKKdSOVLFCmarRBLrytM5QXGA
	K9eaoDUQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wzA5S-00F7Wu-1o;
	Wed, 26 Aug 2026 09:38:27 +0000
From: Breno Leitao <leitao@debian.org>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Vasileios Almpanis <vasilisalmpanis@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 syzbot+6b16e3d085833cbf3e25@syzkaller.appspotmail.com
In-Reply-To: <20260730093435.195441-1-vasilisalmpanis@gmail.com>
References: <20260730093435.195441-1-vasilisalmpanis@gmail.com>
Subject: Re: [PATCH 0/2] configfs: fix use-after-free of symlink target
 racing with rmdir
Message-Id: <178773710279.2438647.7515532463548402150.b4-ty@b4>
Date: Wed, 26 Aug 2026 02:38:22 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-f8e9d
X-Debian-User: leitao


On Thu, 30 Jul 2026 11:30:23 +0200, Vasileios Almpanis wrote:
> syzkaller reported a slab-use-after-free in config_item_get() when
> symlink(2) races with rmdir(2) of the symlink target:
> 
>   BUG: KASAN: slab-use-after-free in config_item_get+0x26/0x90
>    configfs_get_config_item fs/configfs/configfs_internal.h:127 [inline]
>    get_target fs/configfs/symlink.c:128 [inline]
>    configfs_symlink+0x4ab/0x1030 fs/configfs/symlink.c:185
> 
> [...]

Applied, thanks!

[1/2] configfs: pin the symlink target's dirent instead of chasing ->ci_dentry
      https://git.kernel.org/pub/scm/linux/kernel/git/leitao/linux.git/commit/?id=1507d5b57e40
[2/2] configfs: unhash the dentry before dropping the item in rmdir
      https://git.kernel.org/pub/scm/linux/kernel/git/leitao/linux.git/commit/?id=2251d0ed97c2

Best regards,
-- 
Breno Leitao <leitao@debian.org>

