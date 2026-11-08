Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794142014;
	b=IPdBHKxHt7ruD1rAoH70crdGrJZjK+4jfISXwMbt6JY5IhHQy9HcFkpMoUoZM3Dzb+3n
	 A1+zyPnEYs1x/s0+r5x79JCHKtXUm8aH339Fa973B2Lq/VX5l9V29N16sO9QcUJoXXUKl
	 /Q8YoAcvKrzmXXrOizCKG54IxlALhqkR3jXWb9+IU7zauKGSdNrLtodG6FhtH8pQnyH+L
	 P81QvkUBb+JrOaBAdwuJA24Tad3wNwFbKUr7lqkfE6rA+vT+Dz3QlJXR6F74e2Ci2lHFA
	 ih6/H6iD40XTZoOTthSnzX5s96D9oJ1nFSvD9ClolyLx7uBs5GJYhq+X8/h2wTuhlnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794142014;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=vv8OmZQm5KxWlzjPYOE+BeDtBp9uw2tuTQVGnOhSDyA=;
	b=s0YfsvhK4lz/sG2syjdFeB/r9mIF2wMvkNYtXfPV/GL0XQMccwKH1kF83ibpj+kYA71Z
	 H/mdoRdsBU9NLxcNjQobBUvBxLIUfsyUjhUNeUk2jfmR/sCW64Ym2BPUKJtJr1AIc66Py
	 f8DzAV0PSu81BDfgVpeFSF4AVCS3vUnyFnH1y2Tt7FHdnFhKJ1M46DH6mTqUbLBQSib4W
	 qj5jGnAsXwprH4TMggwoRtxw3vk68JS3ANZIF0qPAEbTnkq4fuotFsMPZ379EODNEPcL5
	 LWsZD2tq46D8Xj99CQkGjEkZ2JttbowlIT3OYd7tFp/57V7oroYBvXr0eiZyMnDrByQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=k96Ue86M;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C7B606A320
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 12:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23C7B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=k96Ue86M
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC9AE1477;
	Sun,  8 Nov 2026 04:46:48 -0800 (PST)
Received: from e127648.arm.com (unknown [10.57.14.94])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B03E73F628;
	Sun,  8 Nov 2026 04:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794142011; bh=bmMCnJRuvIDrFm88DWlwBMjGOEWeY9OX59NYhVThmKI=;
	h=From:To:Cc:Subject:Date:From;
	b=k96Ue86MOQ6NEc0/cWdpEESxBbCDMqcIOELgmGSyWcLQrgCBTMI2BL+FLrfKFFdDb
	 j3FxMO/+59K+Euxh/xP8AU69fARrdWvmkvOaWIbOaavO73V/hCzAQ9mZWbBw78y+pa
	 LQrl62s520gJkfU9BKtwqdaHj/eSxsAdoByqO8D0=
From: Christian Loehle <christian.loehle@arm.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	peterz@infradead.org,
	bigeasy@linutronix.de,
	tglx@linutronix.de
Subject: [PATCH 5.15 0/2] debugobjects: Fix wait-context warning
Date: Sun,  8 Nov 2026 12:46:39 +0000
Message-Id: <20261108124641.2604547-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha,

Please apply these debugobjects backports to 5.15.y. Unpatched
5.15.225 emits "BUG: Invalid wait context" during boot.

Christian

Peter Zijlstra (1):
  debugobjects,locking: Annotate debug_object_fill_pool() wait type
    violation

Sebastian Andrzej Siewior (1):
  debugobjects: Use LD_WAIT_CONFIG instead of LD_WAIT_SLEEP

 include/linux/lockdep.h       | 14 ++++++++++++++
 include/linux/lockdep_types.h |  1 +
 kernel/locking/lockdep.c      | 28 +++++++++++++++++++++-------
 lib/debugobjects.c            | 15 +++++++++++++--
 4 files changed, 49 insertions(+), 9 deletions(-)

-- 
2.34.1

