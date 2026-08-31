Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDD13CEB99;
	Mon, 31 Aug 2026 07:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163135; cv=none; b=nyVqStdAWG44lQ5V8VVy/JJT7J1d8dGNptPrVPobQBCvpzw3NPn5YUg7Vwx8uDjeDEt81AR6PrSMh4NKXtdC1o5xpzEaBRG4aZyM8hVP9no96E0g7AFEg8vqlXecI4771ePtLUkbKTcKrEO72YHLTD2fMtaRjaFRygMrAvYz1fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163135; c=relaxed/simple;
	bh=lsZwcvFJ6DYatuuXsPT8MW0GHN2pbYxU6wvTG0VjDFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ah/nA5Y+QELYneTT58XK/Rct0V5gKCVqsM/aoJgUbDpTyj20Y2/THoeZukdn2WtYpcew1ywBMeyah3ICH3GPluB8IMt53maDm8R5KB0YRwfKBkdyX39PswiRD4uw0rwAWILKEzlCoA1LPU9zxNXj4WX5N3RU4WCr92VplQOSEog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=ObiRXBs8; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="ObiRXBs8"
Received: from fedora (unknown [79.139.241.61])
	by mail.ispras.ru (Postfix) with ESMTPSA id DCC2E407672E;
	Mon, 31 Aug 2026 07:58:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru DCC2E407672E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1788163128;
	bh=JUgrRmOxgoqrS39FwlG/0IiuRy0INCd2KDkj4TL48UI=;
	h=From:To:Cc:Subject:Date:From;
	b=ObiRXBs8BoGwWZyvjOySncqfJDPPX4u5W2fzCqaYOuEklg292BnANLNcxgnZBBTuh
	 h7QCujDuR/fw/TMAg1B/SYlBqls2RPXeyzAMNniHvQlHDRroiQgHhei4+9gXHGuCgF
	 qNvqFebgCNEGAcnenEsaVw0+g9PgACMsSm/f4uRM=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Mika Westerberg <westeri@kernel.org>,
	linux-usb@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] thunderbolt: fix NULL dereference in tb_remove_work()
Date: Mon, 31 Aug 2026 10:58:09 +0300
Message-ID: <20260831075836.16038-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---

Reproducedd under QEMU with a passthrough'ed USB4/Thunderbolt NHI
controller.  Not sure if this trace gives something extra-helpful for the
commit message, I'll just place it here for now.

Oops: general protection fault, probably for non-canonical address 0xdffffc000000009b: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x00000000000004d8-0x00000000000004df]
CPU: 7 UID: 0 PID: 866 Comm: kworker/u32:50 Not tainted 7.2.0+ #16 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/10/2025
Workqueue: thunderbolt0 tb_remove_work
RIP: 0010:tb_free_unplugged_xdomains+0x39/0x4e0
Call Trace:
 <TASK>
 process_one_work+0xa3e/0x1a10
 worker_thread+0x70c/0x1040
 kthread+0x3de/0x4e0
 ret_from_fork+0x6c2/0xb00
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Modules linked in:
RIP: 0010:tb_free_unplugged_xdomains+0x39/0x4e0

 drivers/thunderbolt/tb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 47753a5c0f2e..f2e53feff5a6 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -3274,11 +3274,11 @@ static void tb_remove_work(struct work_struct *work)
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
2.55.0

