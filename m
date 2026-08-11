Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A2E3D7A18
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474570; cv=none; b=eUjUYRnTd7IjARhsuB6JQr7r0cmyNkzmzr36iMyNLBPKTM/VdiCf3m126/dJaZkml3Ila1+KeUUEd72UbY8Bp2SV7v7LyvC8Xw2vk/t2DRmQmPEQVrui0hmFDMzgvib+obdX5GS63Z8DsQF0uiiEqlqKrQ0XmVXjj7IqoVSlFSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474570; c=relaxed/simple;
	bh=qZSEQ7IIGLHu2nSuukLqXV/watvEaJOV2mTOwaDbFi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1O/lHDQ1iBxdQokefDh2Wax+QqFyGsKvLZnKZawTkTvkpdJecHMCl61u3shi/4n9YzIHzctsGOGseHJD6eNWp4GNfpx+BiGmNusSZBUSJpttO0vZHA//rTFRl/2WZ+0irdTLbOkyo1dxjeNxDdav3lLwjFcJKWLEjC8wDDJTZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsLGN41C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsLGN41C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0551F000E9;
	Tue, 11 Aug 2026 18:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786474568;
	bh=9LrUP2yIpPh6B0nZYnxGWVtixACTXySFlvYvKGyBQKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PsLGN41CUEQdBcXnkKByf4R/9YJ8xjgXj0N6YSPtEA8b2JVqoBnodKzR0saZbrPCg
	 UfJqbqvhBouFODQdjGCVW2LffX0sDu4yn1g/BtiNW0ZDZGqOmwn1XcTqPSQj/lrurm
	 PuAQVOLzQXhovG52jdXi9FyzOQR1YwFLpgzkc/hOjn0gLViZMnOQGbv0CF6FYh1Wri
	 bw2tsLXStmU3rsg3uQKEHOySxXetoHzuXFeOxfZcBScCk59YPInl+rD2mA/ytn8qc2
	 ww2j0ZZgDhR0Z/8PGOUzE1sc6+n822GOe5pQME38jgICUiM+QldWrLWmGfNpW4S4u9
	 E/NhSMH3RTVHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Martin Petricek <mp@petricek.net>,
	John Johansen <john.johansen@canonical.com>,
	Ryan Lee <ryan.lee@canonical.com>,
	apparmor@lists.ubuntu.com
Subject: Re: [BUG] apparmor: deadlock in complain-mode change_hat
Date: Tue, 11 Aug 2026 14:55:52 -0400
Message-ID: <20260811184500.stable-0007-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <552f7777b10a92ef675cb12a07ba8b7b@petricek.net>
References: <552f7777b10a92ef675cb12a07ba8b7b@petricek.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> kernel:  __mutex_lock.constprop.0+0x569/0xa10
> kernel:  aa_new_learning_profile+0x15f/0x210
> kernel:  build_change_hat+0x19f/0x3b0
> kernel:  change_hat.isra.0+0x5dd/0xd60

Thanks for the very complete report - the reproducer and the stack made
this straightforward to pin down.

The commit is 32e92764d6f8 ("apparmor: grab ns lock and refresh when
looking up changehat child profiles"). It makes change_hat() take
ns->lock and hold it across the build: label. In complain mode with no
matching hat, build_change_hat() calls aa_new_learning_profile()
(aa_new_null_profile() on the older trees), which takes the same
ns->lock again - a recursive acquire of a non-recursive mutex, so the
task wedges in D state and never drops the namespace lock. That also
explains why every later change_hat in that namespace hangs behind it.

John, Ryan - this needs an upstream fix; the deadlock is in mainline
too. There is nothing in v7.2-rc7 or in linux-next that addresses it,
and I could not find a posted fix on the list. Two smaller things in the
same commit that look wrong while you are in there: it swapped
aa_get_profile_rcu(&profile->parent) for aa_get_profile(profile->parent)
on an __rcu pointer (the kernel test robot flagged the sparse warning
twice in June), and it adds a label = aa_get_label(label) on entry with
no matching put on either exit path.

-- 
Thanks,
Sasha
