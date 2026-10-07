Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFCD3B9608
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 05:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791350808; cv=none; b=ZGtMLrt9+okEHrwYiwkucQ1ubZFn1jeMT8TKjToiXNXW/6V/RnCaOK3fE43OPuX4cm4l4LNZFo1coXM7jvCuaaVHxWnmAzM0wNmYa+LZjxsjy5kEZVMhboK0v6ho+LMXlGdou6N9nh3fzUsnIM5WLmsBII9lDYXjwfZ9g5WtyZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791350808; c=relaxed/simple;
	bh=RPZiDtKUGYHj7dl2dNOssY+iV0/QonPwIiVcW82HTJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YskG5IGuu/N1In//5fTicW5V7mWefbqRetTqO/U5o5pF7yrvqRgNUB1/SSiup/V8nTwRCCQKuFUKb3CMy63h3Zze8Z8gvJDFVNGdinVkujx0vQsxRsjQsgxxxXRwWaWKtf8Z5oxZRg3ELiRZq+7zibXEmb4SSqoTS4iYJEbt7o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvW1Cv6y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvW1Cv6y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CFE1F0089B;
	Wed,  7 Oct 2026 05:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791350807;
	bh=hJHFED/KfnBT9K0cyqefG+mJ70uqrh5u088TAim7I64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FvW1Cv6yQY72lk9TfKKCwNj/skZVPKqVAxY7aRPPlbK+SgDCMU5pR4aT8uJlDSw6e
	 k32Blxfz92EiFBwazRmD+NOcDS5WRXTVSZap5MrOyElkNPay5VTR2XyH1UjbtE5IQ7
	 wf42V5u1aN3e9lYHDcMm+2R87hXfvKIxzM5OyKhDgTdTGxxBNOzw3JYvaZQ8nXv8tj
	 DIT79x9T2pAoOWpUoe9D5GsPR3sM/8RBTkS0nCzFM4wsn3+WFrj7WdWxefjdvmH1BZ
	 036wE2rmTHR57bA91MRb2N8unsVmJLK6niIIdC0c+gF2Y2YbT8WOKITSNe1U4E8Nat
	 xBB3m2zhbbueQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] thunderbolt: Fix NULL dereference in tb_remove_work()
Date: Wed,  7 Oct 2026 01:26:43 -0400
Message-ID: <20261007052615.1232583-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100543-winnings-brussels-2477@gregkh>
References: <2026100543-winnings-brussels-2477@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fedor Pchelkin <pchelkin@ispras.ru>

[ Upstream commit 4310c6b8e75d6a47f7548e5948fbe6318aa4440a ]

There is a slight race between tb_remove_work() and tb_domain_remove()
which leads to dereferencing a NULL tb->root_switch pointer inside
tb_free_unplugged_xdomains():

        Thread A                            Thread B

  tb_remove_work()
                                    tb_domain_remove()
                                      mutex_lock(&tb->lock)
                                      tb_stop()
                                        /* doesn't cancel a running callback */
                                        cancel_delayed_work(&tcm->remove_work)
                                        ...
                                        tb_switch_remove(tb->root_switch)
                                        tb->root_switch = NULL
                                      mutex_unlock(&tb->lock)
    mutex_lock(&tb->lock)
    ...
    /* without checking ->root_switch */
    tb_free_unplugged_xdomains(tb->root_switch)
    mutex_unlock(&tb->lock)

Commit a8937f35cf39 ("thunderbolt: Remove XDomain from the bus without
holding tb->lock") doesn't seem right to move tb_free_unplugged_xdomains()
out of the &tb->lock section and the check for tb->root_switch, in
particular.  It states:

  For this reason separate removing the XDomain from the topology data
  structures (where we need the lock) from unregistering the device from
  the bus (where remove callbacks of the drivers are being called).

tb_free_unplugged_xdomains() belongs to the former group of functions
requiring the lock.  And it also calls tb_xdomain_remove() which should
only be called with &tb->lock held.

Found by Linux Verification Center (linuxtesting.org) with Svace static
analysis tool.

Fixes: a8937f35cf39 ("thunderbolt: Remove XDomain from the bus without holding tb->lock")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/tb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index effb8c8a8fd6d..fd33b187b8aa2 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1608,11 +1608,11 @@ static void tb_remove_work(struct work_struct *work)
 	struct tb *tb = tcm_to_tb(tcm);
 
 	mutex_lock(&tb->lock);
-	if (tb->root_switch)
+	if (tb->root_switch) {
 		tb_free_unplugged_children(tb->root_switch);
+		tb_free_unplugged_xdomains(tb->root_switch);
+	}
 	mutex_unlock(&tb->lock);
-
-	tb_free_unplugged_xdomains(tb->root_switch);
 }
 
 static int tb_runtime_resume(struct tb *tb)
-- 
2.53.0

