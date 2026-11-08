Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794142016;
	b=xI9JfiYvLSsDMwB2yzU78peGma3vIJwPhy6E0S9g+omeyca1FtxbxS95DBJ7bvWBWZcZ
	 EqhQb1KzmBdnbgtR7xNmpvaJ7p6CGT9HpGGJf4JslIpFYw4NStl2zb2mgRSLcuSSkRmug
	 DUUOzmVErVRPUne1ffuND/ydGZQwdkvy8Un4qcxqI40cjNxAH4lNSpkMK/gwkBIgcuMVi
	 n3RPbl0n0FbJAb4pzPGlPtmHQgn9fOwTfJf8ySwUivWXKjiXUmD+piKj0XWYXACkodCDD
	 Asrnn2g5bDpifjvPkINZr93k2B/ALQ3/QxZ05iWrHfl28bCYz+o+ARXr8QO16jU9aog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794142016;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Z/rRXXzx8Ub6qNSqEW+2JNvm4qzRvsJXD+zUp85RF5k=;
	b=wb50VFfoTZVM4/A4Vz95azcEZXcLRc1umc+W9OBiLEXpXLexwq398GPHuVeAHqRMY7ZE
	 VCS3ghfDOC1EpwjKNkP6kgHhPoAvT2j62uCMt5iJW49w87nprj8SyNaAm+3siu0db2ixX
	 zoyYgNYeF/uHsnYRXZ67VJyH2y2+nG0G2QY5ZVdPIL+yPfqsTOfpR6OmNlZHllvnj/klm
	 lt6G2MNxjaZgrBZff68TBtHVduKQl2rr6yVYPbq3/dLQPBDNSEC2gTRn8YHZTjP3/DFCS
	 leCWl7qFIjyMFsS4cJSU1YBqk1D2neZdbKYINfSQ/xe+fgfzFeqjIZjPV7QcUIJQTdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=CbnySkhX;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7248A606A32A
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 12:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7248A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=CbnySkhX
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E17BB16F3;
	Sun,  8 Nov 2026 04:46:51 -0800 (PST)
Received: from e127648.arm.com (unknown [10.57.14.94])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AF66A3F628;
	Sun,  8 Nov 2026 04:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794142014; bh=cX7eENr6iXdrtjlHPMSY6SI0vXlpQibxVW89I2CDTn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CbnySkhXZ3iWJPHY7AECkARglTbO9JcfOTm9IRlSeYYJVnP4oAiJ1krKj200ba9SY
	 dyOfMhfKBzxAdqg3TtYJygR3rF4Ik9qmR4ETVI9+uOS2Gp6iCtDKHUfj418j9lqzE8
	 W/gFBYHFaAXlVfZkZgnkVo9xddziLXzsJjKvJ7CU=
From: Christian Loehle <christian.loehle@arm.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	peterz@infradead.org,
	bigeasy@linutronix.de,
	tglx@linutronix.de
Subject: [PATCH 5.15 2/2] debugobjects: Use LD_WAIT_CONFIG instead of LD_WAIT_SLEEP
Date: Sun,  8 Nov 2026 12:46:41 +0000
Message-Id: <20261108124641.2604547-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261108124641.2604547-1-christian.loehle@arm.com>
References: <20261108124641.2604547-1-christian.loehle@arm.com>
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

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

commit 37de2dbc318ee10577c1c2704de5a803e75e55a2 upstream.

fill_pool_map is used to suppress nesting violations caused by acquiring
a spinlock_t (from within the memory allocator) while holding a
raw_spinlock_t. The used annotation is wrong.

LD_WAIT_SLEEP is for always sleeping lock types such as mutex_t.
LD_WAIT_CONFIG is for lock type which are sleeping while spinning on
PREEMPT_RT such as spinlock_t.

Use LD_WAIT_CONFIG as override.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251127153652.291697-3-bigeasy@linutronix.de
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 lib/debugobjects.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 29b495adac24..513de56d0ea9 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -616,10 +616,10 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
 		/*
 		 * Annotate away the spinlock_t inside raw_spinlock_t warning
-		 * by temporarily raising the wait-type to LD_WAIT_SLEEP,
+		 * by temporarily raising the wait-type to LD_WAIT_CONFIG,
 		 * allowing the allocator's spinlock_t and local_lock_t locks.
 		 */
-		static DEFINE_WAIT_OVERRIDE_MAP(fill_pool_map, LD_WAIT_SLEEP);
+		static DEFINE_WAIT_OVERRIDE_MAP(fill_pool_map, LD_WAIT_CONFIG);
 		lock_map_acquire_try(&fill_pool_map);
 		fill_pool();
 		lock_map_release(&fill_pool_map);
-- 
2.34.1

