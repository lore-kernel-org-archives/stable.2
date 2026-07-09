Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A702701D9;
	Thu,  9 Jul 2026 04:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783571634; cv=none; b=bwKSitQRnlAcfn/VpXFaNtAUoXGslNDp3YcQwBGnYPlEUDuCRmLDXQzxIThWq91eFmJOdHncNdyXTcGVYGNHK3W/0ST/1nGDT0Ajk5jhyM2WBdmAUNdiPO0ci5x67GPruZWRAdPgbOatEZrf52r6njlw7TGkoQhsCtASToW/tN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783571634; c=relaxed/simple;
	bh=47wEBBUdo7gpuSZhKo7qmRxniKCLo2OUyGtItDb0vKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zrhee7QW/oM2YnR331yFIK4Mo//qr3QRAkXvh2HKLb3fFD2qPjGmcB7Nzf+MQ8cEVTiXUrdmioC2q/gFlTUXX5tZNCWLcjT95Pa4ZpdGw0Kihan9Lhgac5Hco7lTGX8qsFe1TThHERJtDLqAHoVVYj/Yg3Mc16h07sjDDFQqr0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUZ9PTmk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUZ9PTmk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C611F000E9;
	Thu,  9 Jul 2026 04:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783571633;
	bh=w4vo2ZIFIR98NmV6byBtB02jCiXbmPKfL7h5SaaBlyw=;
	h=From:To:Cc:Subject:Date;
	b=mUZ9PTmkP+gxqTOiEooff1Jrs9ubinN957y9kkolL3ZLoC2PvHu0Yr6jgWBycx41t
	 y6rAFstWJMA7JCCzoCs57dKjQ5BmiYi9aBh9p9nqE1RDkn+V5rDVqIQeS1AaxNZbGC
	 bV7AtZNMcrNaGvb2sVB8nTzgQ0+gs0KQ36T7sWTJdUJQegJS2n1R0O0INrlQZojIB4
	 xtkjHHBpOAiYiWIKbU8N61a4OGhK2tWLp0lTRBtTMbnJcYbwQnOxOwvsVNcM8src0M
	 Qn0rQ8Oq+a17ELJmMp91Ie51apkrws47fd6XR4Cmj9+9Zb6aVarbOMghbsKGTX/lCp
	 XcnpMjkcUCLFQ==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 6.18 0/4] Backport the one-arg k*alloc_obj() APIs
Date: Thu,  9 Jul 2026 00:32:57 -0400
Message-ID: <20260709043301.142931-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two of my recent commits failed to build when cherry-picked to 6.18
solely because of their use of kzalloc_obj(size).  The two-argument
kzalloc_obj(size, gfp) was already backported to 6.18, but not the
one-argument "overload".

It seems likely that this is a very common issue.  These are core kernel
APIs that almost everyone uses.

Thus, this series adds the single-argument version to 6.18, in a
backport-friendly way by omitting the flex counter support.

After this is applied, dd015b566d50 and 696c030e1e34 will be clean
cherry-picks, so please cherry-pick those afterwards.

Kees Cook (1):
  slab: Introduce kmalloc_flex() and family

Linus Torvalds (2):
  add default_gfp() helper macro and use it in the new *alloc_obj()
    helpers
  default_gfp(): avoid using the "newfangled" __VA_OPT__ trick

Randy Dunlap (1):
  slab: recognize @GFP parameter as optional in kernel-doc

 Documentation/process/deprecated.rst |  7 +++
 include/linux/gfp.h                  |  4 ++
 include/linux/slab.h                 | 78 +++++++++++++++++++++-------
 3 files changed, 71 insertions(+), 18 deletions(-)


base-commit: e46dc0adfe39724bcf52cea47b8f9c9aed86a394
-- 
2.55.0

