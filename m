Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2B84119F7;
	Fri, 25 Sep 2026 18:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362117; cv=none; b=MDdjsop38rzGpapxHvPEJhIDJX7ruNXIVceLCfvh5ds2lm1i6EqoXXKFJq1XQWyAg7ldsVkCbqSuiLwHhHSBfCX3MKE4xdS0HAvUlxP++hVZ7txlkx0VT4/fGx15GMZ0NeHdw0xIS+g/cQGd2ZEiz/I4tzNq9WvQD2jKhAVlBYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362117; c=relaxed/simple;
	bh=bbQnKtZSgohLbV3oo/2lnk4Ge0QxgQoF26s9qg/Gg7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4SX7JNGAqwSdqpZMkNtKdy57dA7oOubsx3LfIUEtFpv4aRDtPDG/+HuuNc0yA8L+N/7cnSOgid0VBD+gsIFlZ11pN2dz0t96r1sdfZZNNMEFdDPegn6QoS5SK2O0upriYVtx++D97448LyjIqmhc+XM3tip9+hWr5Ow/MKYk7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjmetqRz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjmetqRz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16ACF1F00893;
	Fri, 25 Sep 2026 18:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790362113;
	bh=UO7B8QQTVOGlwdjh3i1aXBauNWTrHWnDzflMyP0L03s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FjmetqRzJsKzRehLlCcyd2My/1oT3wLuG4jvxEhXOrDF2s1zeL09efOF110vAi4L4
	 kvF9A4Bx6BDUIBlN9pht/bwNRKO40FxLboX/zHAZfw21EuwNO/RoA1/o6vc7a6xD24
	 Yn+brWjNSEUy60Jo1R3x4B1XlHJmxmEN4oJk5NJhaRpg55OHx4lZROh8FTKHbb9Ddo
	 8Qxw2IiCCUv6wt6Y2XVUSPzBTqym4KqDguSgeuhppoH8JLUQcdgvfaHaLZibXpHXmk
	 bW/PBSfmyZtFXFYdQDMdF2WzKpzSHEA77NJDzU95dLG2JLRMq/ZcjxYowKxIjI212c
	 nDHMcSzL4dvYQ==
From: Sasha Levin <sashal@kernel.org>
To: Kusuma DS <kusuma.ds@alkira.net>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	Chakradhar Kar <chakradhar.kar@alkira.net>,
	Ramakanth Gunuganti <ramakanth@alkira.net>,
	Sripathy Ramaswamy <sripathy@alkira.net>,
	steffen.klassert@secunet.com,
	dongchenchen2@huawei.com,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [6.12.y] Please backport 8045c0df98d4 ("xfrm: Fix dev use-after-free in xfrm async resumption")
Date: Fri, 25 Sep 2026 14:48:04 -0400
Message-ID: <2026-09-25-daily-reply-0012-re-xfrm-async-resumption-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092338-almighty-cherisher-74e8@gregkh>
References: <CAMcJb7NLooAw=6Vyzbq-7JnE9L=gfTbLL0Y=L1pTFMTg3Vf76A@mail.gmail.com> <2026092316-mouse-scallion-6eb2@gregkh> <CAMcJb7OPfN3jSmaqW14CqBESDv=m7Lc+CQ9hms6kVKMWoeHfCw@mail.gmail.com> <2026092338-almighty-cherisher-74e8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > Is anything planned for bringing this into 6.12.y, or does it need a tested
> > backport first?
>
> As I stated (which is the problem with top-posting):
>
> > > Please send a working and tested version if
> > > you wish to have this applied.

I've queued my 6.12.y backport series for this, so 6.12 is covered now:

  https://lore.kernel.org/stable/20260922164842.3125154-1-sashal@kernel.org/

-- 
Thanks,
Sasha
