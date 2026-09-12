Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B206147A872
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789226793; cv=none; b=KCP9bvaR7na/9/py1bNIeBH/WlO0ZGYeVr6h1MrgljS/Rw2PhKozF7Gn/C1SKQY1D1NMs/LLgGte+PzMK65mYaAgn6WFaPdoQJ2ozdSsDOJoZ1HeMbd4cby2y7OCrAgQ06pp/3JfNp/dlU3IpXgxSHVsqnus4FbGmnbvpIN9Mug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789226793; c=relaxed/simple;
	bh=ZYOo8rH0aU15noryshfs5y1PVMFZhgghc7rDOS33Tow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZL3V9LnPMHXrBmGqu7y/rXs7WAD0BW74rlz6fWR3edsVBPX2Ttk/chSLrk0scgzIiw1K5MGi6RfRKLijpE1qrvVFg3iHPIEpjyxFKON1fua0wLZzHQ09LRw1aMwQql1YTEZQ4AsHJp+10OZGJjkmjRJWMh1/paa8U+FTjk1LY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNBkYk1G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNBkYk1G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4B11F0089B;
	Sat, 12 Sep 2026 15:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789226791;
	bh=oFWB0puLuVcH/HhuMjfTDP6CevVsCQWlQbSJsp5bwng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aNBkYk1GmmTHgvrSLKZLVGBNR7g632j5QpytbQpF4Ftc3bioHWp4opbpRhcKt7nRM
	 JKHehvZEYMuJxR2c/oVtqmgTgHWk+Zgv1QoktcJoQHCI7+emjHV1xlHeQU+nyoy+PT
	 fqW2cQO60erefEWQGQx+HsASDMFdV59jIXTc7oz1x2CbUXphiSxjc3B1AZN3Jsil9l
	 FPiuU9VPs5TZL3kW6J0vQveHsPmwXTcqtuRI5EoAe7YfQ0yOqIo6BKekh/amDv8fMd
	 TKOloXPIMcErLSKAj+LclMT44EfXhJNe0ueVbR5bntAYxqBBNEc8dKZPv9MkKEyB2y
	 4MRLWFmVinVEA==
From: Sasha Levin <sashal@kernel.org>
To: Sudheendra S <giveback4fun@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	almaz.alexandrovich@paragon-software.com,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	syzbot+7bdfe1182e4c50d2a21d@syzkaller.appspotmail.com,
	Miguel Garcia Roman <miguelgarciaroman8@gmail.com>
Subject: Re: [PATCH 5.15.y v3 v3] fs/ntfs3: Change new sparse cluster processing
Date: Sat, 12 Sep 2026 11:26:19 -0400
Message-ID: <daily-reply-0013-re-ntfs3-sparse-cluster-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CADggw7+k+B7xFnWztHP_BD6G6a3T0tyoG=7JpYWJ6KmjkgyxKw@mail.gmail.com>
References: <20260908192213.1169088-1-giveback4fun@gmail.com> <2026090924-idly-theology-e828@gregkh> <CADggw7+k+B7xFnWztHP_BD6G6a3T0tyoG=7JpYWJ6KmjkgyxKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Few issues...

First, the backport is incomplete. c380b52f6c57 ("fs/ntfs3: Change new sparse
cluster processing") needs d7ea8495fd30 ("fs/ntfs3: fix missing run load for
vcn0 in attr_data_get_block_locked()") alongside it.  That second commit fixes
a WARN_ON(1) and -EINVAL return that becomes reachable through the very vcn0
path this patch introduces, and it is absent from 5.15.y. Taking the first
without the second trades one bug for another.

Second, the commit message doesn't make sensetogether. The author attribution
doesn't match the upstream commit, the syzbot tags don't correspond to the
reports they name, and the provenance line is garbled. For a stable backport
the trailers are the audit trail, so they need to be exactly right.

Please resend both commits, each with the upstream author preserved, a
correct "commit <sha> upstream." line, and your own Signed-off-by added
at the end of the chain.

-- 
Thanks,
Sasha
