Received: from mail-24431.protonmail.ch (mail-24431.protonmail.ch [109.224.244.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2A32DEA74
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784659929; cv=none; b=odvM98KyxyOdHsy84gfoERVC9F4Klai9iJahN5Ws2q5aZM6HnMvB49A3pFYPt19f/1lSUUGpMeN8oIwFTdwd1v0evTgQoXGRapMPWCksrQqL8AeKHQt5Z53YwyiJxPXIZpgx2WgQnj/cnQ05BXnYFlIzPH3T3Neq+FyITxaYGOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784659929; c=relaxed/simple;
	bh=H3b/ROqSge60oAHBUHiIH4TfcUDWhDXCVKMHgyVpvmg=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=JsrV4WyeTGSWq1zGY1ddOwgrZIJogI2Jm8Islcr6c6Jmj+HF71jJOFC13b24he9CCrrq1GRCyOpAE9B2WiuHaCYKWDn438YjQWoS00ZMtjSpKS5nh8+0L2UvE0hAY53nmesqJTtUHa+zyxnPxIuysMbvM2qV8/2SzFUWaYnGMB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=JBe7HvQO; arc=none smtp.client-ip=109.224.244.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="JBe7HvQO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1784659916; x=1784919116;
	bh=H3b/ROqSge60oAHBUHiIH4TfcUDWhDXCVKMHgyVpvmg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=JBe7HvQOC9PPkijk8aH9uI/bI5eT59sj15WFKrwJhEgDGZoSbohlBOOL2cXwJXMVf
	 L7UA1C0bAjAfvE7jKE0giehSjZnChXirFvbq90SwrZdYMipLJ7wmejP358FIdkj8AQ
	 SlG2ztP551eoRbQIW3VHg1bWWejczJh7TkjjszuaYysqxjR3Kf/akJrNsIcPd04vMR
	 chq8HTQ0pBzNulymQXyQQtoALML77nD4Ua9KTHOA4Eg6JJaeSYQqfjvuCsdEAapcP4
	 w0gbZwL1ntBhFlZ9LbaH8eC93kRhfyrqYPmvDIGNtgYrgJMt3Jg30bqt2pNX5LrLFb
	 h63r18KNlpXXA==
Date: Tue, 21 Jul 2026 18:51:53 +0000
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: "Alex L." <lkstl7@proton.me>
Cc: "sashal@kernel.org" <sashal@kernel.org>
Subject: Backport patch that wasn't dropped, but not applied in the actual stable release
Message-ID: <Dwu6EPhoqrm1RQ9cqVTWmxbiSKyzKQLg9BXcfdVDrUiF2_MAdSlmA6gU9EOdv0PaX6vysSJUVsVSOMu6aNnppuA3sfg7Z8M3rYdaf75KkO0=@proton.me>
Feedback-ID: 210542756:user:proton
X-Pm-Message-ID: 27c09e0cfb8c4e4af3f079a1bb08e2d1addaedb6
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,
I'm writing with regards to drm-amd-display-fix-ism-dc_lock-deadlock-during=
-susp.patch that can be found in the stable-queue repo, under releases/7.1.=
3/ on the master branch.=20
(https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tr=
ee/releases/7.1.3/drm-amd-display-fix-ism-dc_lock-deadlock-during-susp.patc=
h)

Despite being under the releases directory to this date, this patch wasn't =
actually applied in the 7.1.3 release upon inspection of the stable tree. I=
t also wasn't included in the release announcement for 7.1.3 nor the diffst=
at within. It wasn't even included in the RC's for 7.1.3.
I have searched the stable mailing list and the stable-queue repo's commit =
histories to establish whether the patch was dropped later for some reason =
- to my knowledge, this doesn't appear to be the case.

On further investigation I found that the commit that first introduced this=
 patch to stable-queue's queue-7.1/ added the patch file to the directory, =
but did not add it to the queue-7.1/series file. (https://git.kernel.org/pu=
b/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=3D76522806dbfb589=
41f6fa4b6116b891b66689613)

Could this be an accidental omission of the patch due to it not being on th=
e series file, or was there some other reason that the patch was not includ=
ed?=20
As a user who's affected by the regression that the patch addresses,=20
I would very much appreciate it being included in future 7.1.y releases.=20

Thank you,
Alex

