Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794814539;
	b=v7RaQUcc4XwUxlZwKzToVpkNOR9IySIkZhorV8ZiKOS/TCBfMKHAPVVhsl0xoU7v3UeK
	 8jdJFD4Rgao9DWBWt59/hsM6BZFweoqn808LWW20/vhhJ9Oc/5NayeGz/xfJSD8dvOC+n
	 L3exdY5IaOXRT1UQjIqDR+lcXrMenDb2weuztkLAz8Xbvqdoxp1VD4hyLJSTGqs9gaBQo
	 RnzhLVLv2lnzN1YlGbEVDQj04qbALC6+Uj/GOEh8nVjuUQjWV9KAa681p58rhvbMwaCFP
	 rQAmr1KgH+1n+I0xcyz98z7g2GrzUmfvPNDFVl99d26lEQG9nSNmVs0i/2IRvcmI+wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794814539;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=gPZTbZk8SoJNpUJDON4Ig3GkkPgAjMgPKV23C0DMgpU=;
	b=HcCko3QhekCmiXU5/pBHab6xKh+qa5q5JMC8Xz3KdKkamZ+FB/iK3p/lgAn5hzTRAY1W
	 eqAvQAyN9k64V+Z/QYFHfyzhxdlyV9l71nwq2e53owugpDy2RvWHLuh9B9zDjxeQVFs7K
	 WE0hZVKKmGcbOUqXLeeQY4dJ7ENlfU1zd9dIVWXX7i8w3RwNWgw94m0qH2efKL0hPl7dJ
	 omj/RwF//V1WJHrlfawGX5W8kYOrI8wwFZDJcY8QcIDXn10kA/ErOsPfDkEb3MeKG+jSU
	 eeCpm+Eq38J3cBh1DF768utGJ+QtzdqysHkWK8uhEPPkeY3uTf1ecIokV3rUDUBKgJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=m19tbZ5W;
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F3A606A31C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 07:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7F3A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=m19tbZ5W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794814532; bh=gPZTbZk8SoJNpUJDON4Ig3GkkPgAjMgPKV23C0DMgpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m19tbZ5WnGuKPYWjPPNwepbjA4QUPEQH4rUNG5Vyckd56/go7y0EXkFaC93h8h1dW
	 Xg6RyKFC9jgiVJDMqfX7Ah2ijCw6nTcoVgL5OnaarY+xQv5gRPSoP7pULeRmDP3zYv
	 Ca9okPL2DfIjsyB43xA4GjwXe639CUtXYFse3vQY=
Received: from ikun ([221.176.157.242])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 8D3BD429; Mon, 16 Nov 2026 15:35:19 +0800
X-QQ-mid: xmsmtpt1794814519tl5lnlj7n
Message-ID: <tencent_69B311F4356254E166A5EFDC981AA138D80A@qq.com>
X-QQ-XMAILINFO: MAUQIEZVArhLaRAHwoTiol5Eu17QC9JGLGD4PHcJuT6LN1zjNUHNcIM05oWU26
	 wyNGR9jWY5a/tzcgEoPwCEk8TwpkQTkplTdrFeP6TL4vi7dF1QeIlIru1AkXB7Q4HlFJO8KbRqIn
	 FQlN0HkIHbrZP0nQpzK/NEvjmaAoAqo87M4ogtRFNMuCFnitg8C7siVQh+Y05w3XoCGYvLzVOamj
	 trwcarLtqAY1FaPoOawK8mRzCnsBY8W2EG0jDS/GBK3z4M2xl1GbyV7XJXx0woh8Z3NPeCNiJy7m
	 pLOAJkt+6p/g+OZJ0EpHdQApBXxUw1em1hdv5j0TYo4U4EQ7Oibk5WPKDftKej/UiJRUdcJNVpYt
	 avDIv8MZL5gi1+TSM/ZMPAWr7+W6oX8Ntg1CHh8GxAQfapbAlyr11zREAmqwW9kUF4g6o4/fXite
	 w2Sv+fH2/6nbT9abLemPG/B3qETPc9rbUG+BuwtIBG8T4zAOOLcvH1s4yc2geR36re5ZefiQ4u/0
	 zHLyZKrcSq/Xo7cDJEowG2G10Ffm8Posz2Bwt9GvCdFt5LmMacE3b7sGHNo/JOKDPtXyKsIwPj/6
	 P6NzWXqXkIJuXJnwF+g4bqw8l4qCukIqb5DY4QBanYj+363PnX5x6s70dxuaNMsljzeHKw7NQd1o
	 HI2fseuS68VhoQgorkbdVWe8mlX+aemTsunomyJI1qV3SkN4SsLVBEMsEPMeaGI9j5hQllTAiBgo
	 7SzucFk97OCvBNrQqJ6pgy2ojTFV5MLG5Fol8Cl2wM/of0jbzA7nCZqsaXR+AkE5jaenVI8IUnEG
	 AOPUf9wvwevS/Pc/5ArXbWVxOKFQL08TxrZ3MbN00D8pnmzqW3VpFP4IhP7gI+fMXXy3/EYtSoDM
	 +uF1c5Cqx2E+U5zH4AqgbDnpmqCOh3hJFtfDWeoK8VudQw/E6e/+jj9n8bHt/1ree3cBlmVE+49o
	 4drTN6uA2uaW6xXpAfJ7XlBK8poZr7Ei5aNk82gbwz48UqzhqTQAyTjDwwbMrdUmhDjLGXrtrTXs
	 WJZQQlz6ag8l2/s8ZAE4RATyLQ4Zs=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Alan <3164729207@qq.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	libaokun@linux.alibaba.com,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	harshadshirwadkar@gmail.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ext4: reserve inode write access before unlinking entry
Date: Mon, 16 Nov 2026 15:35:19 +0800
X-OQ-MSGID: <20261116073519.21804-1-3164729207@qq.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <tencent_D60E766CE07D3A1847B81DE9BC37B4466908@qq.com>
References: <tencent_D60E766CE07D3A1847B81DE9BC37B4466908@qq.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ted, Jan and ext4 reviewers,

A gentle ping on this patch from October 27. Are there any comments on the
approach?

I have additional validation from November 2 using QEMU blkdebug to fail an
actual guest block READ. These results supplement the source-derived fault
injection described in the original mail.

On the unpatched Linux 6.12.1 test kernel, with errors=continue, the failed
read was at sector 2312, in the parent inode-table block (block 289, parent
inode 13). The kernel reported:

  I/O error, dev vda, sector 2312 op 0x0:(READ)
  ext4_get_inode_loc:4554: inode #13: block 289: unable to read itable block
  __ext4_unlink:3469: inode #13: mark_inode_dirty error

unlink returned EIO. After normal unmount, /p/file was absent, but raw
inode 2064 still had Links: 1. e2fsck -fn reported:

  Unattached inode 2064

In this case the inode-table read fails in ext4_get_inode_loc(), before the
journal write-access call. A separate run of the same block-read failure
traced JBD2 through unlink, sync and normal unmount:

  jbd2_journal_abort() probe hits: 0
  unlink handle at jbd2_journal_stop(): TID 7, T_RUNNING
  h_err=0, h_aborted=0, j_errno=0, journal JBD2_ABORT flag clear
  jbd2_journal_stop() return value: 0
  jbd2_start_commit: transaction 7
  jbd2_end_commit: transaction 7

The offline filesystem check still reported the unattached inode. This
demonstrates that this read-error path can commit the directory change
without a journal abort when mounted with errors=continue.

With the fix, the same clean input and block-read error failed before the
directory entry was removed. After normal unmount, /p/file remained present,
inode 2064 still had Links: 1, and e2fsck -fn completed without diagnostics.

Thanks,
Alan

