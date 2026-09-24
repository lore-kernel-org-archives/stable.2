Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B31B3D566E;
	Thu, 24 Sep 2026 03:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790220404; cv=none; b=U2Jq0rA+v5wzvHL+akE0w3qSz7xbzCcRD5buM6UZuckd2SUwz/BnS1SVpdktMzEYkwhtbltyQ3hGUDdGO25tMX47hSzWNJLw3To/pCUHvEdK0rKxwsLi3JGD+qV1pq3qk7kIHjyB5Zhr2GD37Ua5uDPcvmHvk0VAMKvfl3mXj/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790220404; c=relaxed/simple;
	bh=Tb7mG1uj0rHwkAcYMsqrfW6BC/IWdMqZJqFjms4KMJM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c3jEYWQQsQDLjXBGEepxJriWEZKO9n0zhWsvWOHogzwchVf2o9cHphWL72ZxunH/czAeeqqR5SP0cVvYzJaP4rKGkew8iLlsZpY2INf9TYQP9NsC2GeYZtDQOEdI/f9DuOk+HUQlDsW+Av8exZX8+1+3+HfymE/ANi8a+uEtg/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=NTxMAAUP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bE/iocc6; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="NTxMAAUP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bE/iocc6"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6B1897A00E7;
	Wed, 23 Sep 2026 23:26:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 23 Sep 2026 23:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1790220400; x=1790306800; bh=WZti31B3yyBQQjCPw+8OB
	Addfmrx0EwcJfktDxOnydk=; b=NTxMAAUPbF1QMnTuPRf8GoWfytWLaDWnHaA8a
	jSrHtYf5aqB1RPWZ4PGWW+zboxXU0fb8Q6cQMo0w4hfUN1c5FGzYZuz7xEeJzzDU
	LW4a5LNVnYeJFQWGFE31PBrXnzUi3jCHyLmIxSuhONOiLmBt1q04/0HBHIwSEix2
	PDFnj1Qs+7t05B68+38/ghqGLjEqt4BC1MuBsWJKapYKbb/RsdKyYTZaXmOAiDKX
	LO0hSse8FBHPqIDb6qRAIwctRBv05ghPQOb7GHY8uE8GFHArWOC7bZCBU0Fpi/Vh
	uZxMBIc74h8ZMVZ7SFlrmnz46RVe4EYX5U99UPHqw2TiyRBDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790220400; x=
	1790306800; bh=WZti31B3yyBQQjCPw+8OBAddfmrx0EwcJfktDxOnydk=; b=b
	E/iocc69KmrvqNROMwDYYQlwY40waP4NpQWiZAKHrMeeDXg6TkFbzL8FGUZDXhzR
	4QYTm71VJy/hMZZB40HJW5m5++5VzUl1kmxJUMp8RslaxVvGyTlV+XRbEoWJLjDh
	KzJjeohX5qzQp/Muy90DVkxkKAdbNygfHnwIemQyOYcxaA3zifKAiPy44cV0D/g2
	gIz0roBz5QYVc4CmxNo1bYwsiPIOev0pUHqkvP9/sydFY+ppCxPwAb1ssikqoQxw
	xEjREFIdTOVFQqCY77DYLq07MFurwfgjdumzkKlYuonQEKm1QDmx25DkQk/jBlu+
	ioIaBnzHuiQHLD2DezarQ==
X-ME-Sender: <xms:b5i0asalkm2UtrgiEULfDiYGXmEkPOd3j-FKGD-tZ5Pumdr_-Xt9-w>
    <xme:b5i0ai3Hfj13LHaIYQmie2LwkUQOnSiMX3Ot3u35LTU6-cwQXBXMIUcQIvPXvqDt6
    85Z_OILu7ibczSEaV1PfcjCfZ41nZEtlSwbZ2bHsYSlI6HmcmK95yA>
X-ME-Received: <xmr:b5i0aqdPVEFPnJkfKnqAwwCmvpiW2makPvJkmMuiA9XzLN9RMU860vtoYy0mbib9w3jZY2tqjZd755uyQqX4_EEREsg4AA>
X-ME-Proxy-Cause: dmFkZTFpnYrNUG1h59Sbd/xt0EIrLt+m/uemFkLE3oMxWyJZ99VvRNlPkoFItnUnb5V5CQ
    PVmPQd1NCLCEUkoditggYCtXT9VfyD5GRoFYlLOi2sd2L/VnWaGYe+xQ9AWjEYe99436qw
    jxai+8PBTpbI5DrSijaXHSNskzLkb2Mip+dnZgHzJzArGXx0u1lQm+hoyL2UUXDXZnyaej
    /L0cEYKqAkmipG1Y3VX4vvg9XCdrDtB7XlNYQc6SLtTcgy9eaCPsYrXn2+LqTCmy7iKens
    TFROExPCUAls6YJ7bamZTAjKKXHXL8KZ5rbgB41l8fDO5vMXzOWIZIugcpc74KZcJd2UpO
    AhGpa80OuM6oo3ojDyjmIL03pVt9/fz7Rik1WudvlapP4Q3y9cO6Sifdulx0Ter9D2mk2m
    8RetZyVH5v5/+kPHxZghc8h3By9DGo4buKu2AF/BZ0Zubl/uFrfZyACcAWk0bD4wkZB8Kz
    XwHkzdloXrzCPz6CU+TqBAdBrGlkm7HOACj4qV0+ZZJDS0chiEAZAb+2oDpsH3g/dNb3IN
    eQjFdR4uYP6sUQfQUTIFjyI0FMxdHs3iIQBDAXHU5NbNqTCQFoqsNR49Tb970S3Y7ERqS5
    HLq3f1OL78AftBMy8CeLiMfvIZvVcusWXhpanPuDh6CIcacKNLLv/oLv6SnQ
X-ME-Proxy: <xmx:b5i0arHalus7nddIKw-XoFJDD8mwjRs4FvgshtsSYksVsxjlv3kJHQ>
    <xmx:b5i0aj229JPHDpV9wINLcIc5EmUTLZEB19SKuEJxfIPjLZ6MYymxkw>
    <xmx:b5i0ajmQyUZHI54xdtO3SdwqVFvdrDx4q_HtbMNAJj8KsCXi-ghulg>
    <xmx:b5i0aj9bB9OedIpXNRCkPy3lfq5fWRD2e7eEDf5WX-x47bTatcEeKA>
    <xmx:cJi0auWWgiVETo9jMcRun_nrelPUHhSyT2DDrxzN0RCzotX8BHTp6SCR>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 23:26:38 -0400 (EDT)
Date: Thu, 24 Sep 2026 12:26:36 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	stable@vger.kernel.org
Subject: [GIT PULL] firewire fixes for v7.3-rc5
Message-ID: <20260924032636.GA314300@sakamocchi.jp>
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

Please pull a single patch for firewire subsystem to your tree.


The following changes since commit 93f51579e7df248780214094418f205253383cc5:

  Linux 7.3-rc4 (2026-09-20 13:48:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-7.3-rc5

for you to fetch changes up to c6b51091cafff9ce6c03c1416aa13864d17ab97c:

  firewire: cdev: fix back-transition for iso_resource_auto client resource (2026-09-23 09:20:17 +0900)

----------------------------------------------------------------
firewire fixes for 7.3-rc5

Fix a race in the cdev layer that can cause a fw_iso_resource_auto object
to transition back to a previous state. This can happen when a file
descriptor is closed while the work item for the object is running. The
race can leak several memory objects, including client object itself.
This fix should be applied to 7.2 kernel or later.

----------------------------------------------------------------
Takashi Sakamoto (1):
      firewire: cdev: fix back-transition for iso_resource_auto client resource

 drivers/firewire/core-cdev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
