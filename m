Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BF53DAAB9
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792319802; cv=none; b=l0/FbcCB8p4Tfyeuk+lZnhkiIV/0XaHGmaARvtsNetwmgdIyAiUUB0CS8+jJHfEdemtYKUq3wNBsBTRaBZ8pmIrxa2n0d5wmKfrkRNV6aSJBAz0Xs9dvDgbmR0A05C1upqC80oynJxipT07ZwuvSoVn4nvG9fGuBu20xn2+ZIJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792319802; c=relaxed/simple;
	bh=dScO//3OXCPK83AZyVSrKIO5kqhcrTpD4lNAneOvXAI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PSl5USZaRaVFo9Rntxhtub8hw+n0b09IjjK4Bbp6WeG/b8v4PAaSoHG9mC0VVxJlHML1qJXa/Ey2ciZwCa4bJWJ3c91oLGTv2mJ/z1ycsZ/PReT7rtxS5mBKmrpfjLloyJCXdQnto73vZfT3Uh046Q5FL5h+J+trLG8F/lpXh+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=KE/aq7+5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rp5W5VZE; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="KE/aq7+5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rp5W5VZE"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 832F61D00131
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 06:36:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 18 Oct 2026 06:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1792319797; x=1792406197; bh=x0njwKrqM5mvnyfFdJH2j
	Oqop7WfZuE2d98EOErm5FQ=; b=KE/aq7+5ZZtCcpj1zpGnLZDzrTXqP5o7CCZpU
	DtdS+t8+RMKcR3ZnSDlrU5jmR31vly7SJ/DP+yp7sVSKzHsO7UqG1iFCF/Knsqk8
	EZOi6pdyLMlweDb+6X0JV6j9jPqmgsq4/oma8M4iXZ5kchOCMv1Zg7zlI1GfrXNI
	VnDM+uRvMVHSZraZF4fcs/irC3Cwzi3f1h/1xCTaR0Eo/Ncrim1Nju/NizLS4ITq
	UNS2PWYUpFgtKI4HGzas+2BxpMbulBC7P4buL6Rc7+tWReXUclnkGSWbS0xbH5PP
	TonR0Y6TCgXatd6u/v/ztjkHYKLF3Brfo2I+odgMvnes08Pyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792319797; x=
	1792406197; bh=x0njwKrqM5mvnyfFdJH2jOqop7WfZuE2d98EOErm5FQ=; b=r
	p5W5VZEd3ZyCinYpVaBOUyfMaZpibpZrRQGUO5xHJmsM3PxDezb8bWoe9d4tHCw6
	msiSomNbZIFQOlpqNggLfoCxuv6zUaDFnz9vHtzWHZ2PuORiVW5Va2aEgkRLSGJD
	jrwIrY+inedKuiQAeI8OGSyqrh0f1e3mpp3BX6kZJKGMyeUue6CnXgLax+uTZtrc
	Nuf/MBMAGgAnwHasBpIQElOE9fzCcIsVWtpFY7SITfKn2bhsAsTMHzCT/VB9GeRT
	a1ANtZsp2EZuXrSWZz5G014/jUN+Xq6okGcmi8mdq74CNPNYTTIS1dqC2LsVaGcp
	4Whrb30TtVSJfTOGWZZGw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=sakamocchi.jp a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792319797; d=sakamocchi.jp;
	mf=PG8tdGFrYXNoaUBzYWthbW9jY2hpLmpwPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:CbXipbCKJKFfyIqkP1Ofjum3+eNbnnyliOSsrangOX2fnnu
	2CDsOUmeN1H0lYlZSllO2MhUShMUaFAWKFqsUHbkgcGjc70RLc7E3Q/gk6g7mqf/
	43JD1KJKENQIOqgRegbXpoGZllZ6JFtdhCE7ghU714nSjaJPjLLRIskpSmzlPgDB
	QqlLDzKyWXk6uokWLaeFwvdTlypAaGPo+LHJzRS0aUP7mjrDKk1mI601lB//ngq8
	9oAed5fDWWb9ogp5NJlCY+EgqPX77wKyLRypLizFgTKQkbBrxm4nv84tFf2mFlXe
	Dc3my3WykDXwBeooHbi2zVxC0mlLVcbMEqPY7Kw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	mail-followup-to,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:7aIV+0FXuty3izUn+OfmModAAjq+N04xx/MePTAeXT8=:dScO//3OXCPK83AZyVSrKIO5kqhcrTpD4lNAneOvXAI=;
X-ME-Sender: <xms:NaHUagi-t0L0FFJkG-a7f8m8TuBnoMkptguBOp6yn6Ezsx5yaQCMQA>
    <xme:NaHUakdn7eogc1D53vX3-hJ7hUisOFvgWRkI93dsxvdyC3k6fEJLkp1nBBFLdeqtV
    qDJ97SYqKvB45elKZ63G8s2E5yRV2PkH0jWbPxAHpPFN8kjC4uCJTI>
X-ME-Received: <xmr:NaHUarnWPaF1w2aZ6qqk9twAs3MbarLVFrELnvqIUEkc4JlVyz59RorjnfJ1FOavnY3Y8DpKvS70boBKfbAIjap1ToZ2>
X-ME-Proxy-Cause: dmFkZTG2xmJIM2TZ8yhppk8p5H8soyTrAFdYSQzyycr0BU/oGaQ6JVeLhVqUn77L3auT1k
    U/Nc6qlegI7NT5ABznLrpc1U2ZURjbOUdEe4a8qNS1OY3oPFpPGCPCDYqQ6BMync3uau72
    1qPR6T0TP/OoH75o1vIES+E22i54O2EYtxEFAESiNEJDRQpX/HWjxwDB40X9M3FRfBizud
    fjm9nCmEwop84+8kLnpUyvDLp5V1zQ+Cmj35P0/GAjCA7CPCG5yWWwjATCiYZbU6qy0PGV
    r/M6Qti7aQQuMpWd/hMvwoD1HCDwZJ9eo+NaT7saBZeXDT+rTY3kJJssOIdSh1+8566/OA
    6HGy3n7JBhmcKFixeUtEX8WgW4VYJhd22hWZrcc4inGMiXvGwytL9RJQ17vNuwHOzYpnxt
    EnkmrewIa8E2tyl+EuRT0lewjD/wvsLozjWZUi450YLFgmDywtAb7SyYe5H7tg8SsuOyHu
    A8FTUoxiwdlwwjGBp79hyWpUBaULq0AlcWgK2AOJtac6n+90ZYT8D2MTIErggDXh1k4rE/
    8DSg33xeZxlZPjRUZ2YLKqM9iUVqYEyFybH9T3ugM14h+6Ze9uzNZ8xur5hj5+LY/Ox+ia
    RD+kBcHyQBmv2sF5bLLVqoXAwgheCNz0TQU+p+J7GIcH5S1GPDB0ZtPvjA1g
X-ME-Proxy: <xmx:NaHUaluJ97E_rkWWQddJrthJ8FtgCf53p6O61OJMt1DeCHIvR03dGw>
    <xmx:NaHUap_Qw1gMyKjnGypaigQk7EClajXYq71aInaXfWAXlSCy3iwijw>
    <xmx:NaHUavPXA3P3Bt7dE9bDfnMU1GZsZpCY-QM1iAlMVobYBM_NRyr6hw>
    <xmx:NaHUanEBwW9jdRXMGMYkIib39Kh3dZ0bGPa5USKZy4SJL-sB_iYSqg>
    <xmx:NaHUaodNpCZpZA07wmJ1VyV1es_7pWVGXterrjGeZ8IgUeu27YfyzN5g>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Oct 2026 06:36:36 -0400 (EDT)
Date: Sun, 18 Oct 2026 19:36:34 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	stable@vger.kernel.org
Subject: [GIT PULL] firewire fixes for v7.3-final
Message-ID: <20261018103634.GA346762@sakamocchi.jp>
Mail-Followup-To: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	stable@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please apply the following regression fix for firewire subsystem.

The following changes since commit 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907:

  Linux 7.3-rc7 (2026-10-11 20:04:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-7.3-final

for you to fetch changes up to 7f9f2d6abc40f79e802b4063859eda343043b85c:

  firewire: core: fix race condition in split transaction handling (2026-10-18 11:59:35 +0900)

----------------------------------------------------------------
firewire fixes for 7.3-final

Fix a regression introduced in v6.19. It affects cancellation of the
timer for split transaction timeout when handling a response. The issue
is unlikely to occur in practice.

----------------------------------------------------------------
Takashi Sakamoto (1):
      firewire: core: fix race condition in split transaction handling

 drivers/firewire/core-transaction.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)
