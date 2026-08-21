Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9D4242D72;
	Fri, 21 Aug 2026 00:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787271076; cv=none; b=TWtb7Z6qAPViH2kBacRYrixzTushfLCMtQvOZwlJ0S7YrniBA3+9VVGL64MGZMvn07JMoTqR7kxruGVAqoVcgkA6DZXEjfW1fbzpfIdl0Cl/3LLRXWMl2W5wNFLSpgncxFiVW1iDPiuOtMc2YidnV1mQnezjiOBHKKPvcbr4g7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787271076; c=relaxed/simple;
	bh=9hUgGEreFwFPuEvjfCDr8xlZlYy4DYhbfja55WfQixc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kdJCuWsr/nstbE2pYsl29puiqdoptTLTa0VK6VSDI4QAi4+Z6qNAxmQfzA+fHNHUmIVkCeZrPOikQ4K1r+9VD7dCfImOI3FShuUA995w2MqTZl51Ggktrjzt8GApjfE2Kc7ZPGO0l7m9wkQJU1kKDOZw905PbNNNFndI4NDu61k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diptitNN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diptitNN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67121F000E9;
	Fri, 21 Aug 2026 00:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787271074;
	bh=VtxMgH/D+tWPzdttlkyqh6KK71n6PeivsVR/hRZbqW8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=diptitNN/DlAgctSQNCIBr2mujhI/Q8q1Z6uLvKiLC1+NbC1YEQZNBUi2dY3ZqXhn
	 SK1UcPBEZKYdOY5T/twVkxvF6XM8cfcYwqq7DRFeApRGQps5WxvS2Gj+R7DkPNOcjm
	 JwpNgDYXFTICsLhkwwKHQmgayuY0qQ8kjeLYUHjh1FoPpf8EbPdcAto1RdKd3XKglU
	 rKuZ8DOpw1NBmuDrO0kI6p9iAn8wi9oCHVYh11yU+MJWyFWdn4gi+ClIQqSi5ewnug
	 nE3DNm9GTYQtpmtOdo7OMg1sGKhYi9ACGTvKfbDBzAs2dahptUjd4DyRAsQuW/pEJ8
	 nLeubaw1kVj3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19DB93924472;
	Fri, 21 Aug 2026 00:10:26 +0000 (UTC)
Subject: Re: [GIT PULL] vhost,vdpa,virtio: fixes, features
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260819124604-mutt-send-email-mst@kernel.org>
References: <20260819124604-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <stable.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260819124604-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: b282418bc366194677eafd1dad180d92254586ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f063b2f17eaba2a35e251aa53627f2a70d536e2
Message-Id: <178727102496.546823.16524833429188272058.pr-tracker-bot@kernel.org>
Date: Fri, 21 Aug 2026 00:10:24 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, aesteve@redhat.com, ben.dooks@codethink.co.uk, chenyichong@uniontech.com, david@kernel.org, den@openvz.org, eperezma@redhat.com, gsomlo@gmail.com, hexlabsecurity@proton.me, linfeng.sun.dev@gamil.com, lirongqing@baidu.com, me@linux.beauty, mst@redhat.com, panchuang@vivo.com, pankaj.gupta.linux@gmail.com, pengpeng@iscas.ac.cn, peter.hilber@oss.qualcomm.com, sgarzare@redhat.com, stable@vger.kernel.org, syzbot+28e5f3d207b14bae122a@syzkaller.appspotmail.com, tavip@google.com, wangyufeng@kylinos.cn, xiongweimin@kylinos.cn, xiongwm2026@163.com, yangjinqian1@huawei.com, zhaoguohan@kylinos.cn
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 19 Aug 2026 12:46:04 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f063b2f17eaba2a35e251aa53627f2a70d536e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
