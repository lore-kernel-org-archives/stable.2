Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793251845;
	b=loRGaQZA3zQMG+LFOT5wZn0Pb+xRSx1Bs7bx0bgASezqM3Hl8DRAvxExD61oj4t1pXUN
	 vZMO8UiLpVdf0HG+49NYbCZalywzzGA0uw8fSihHV+lKBFi76P3/DrbXRdMZOZrMyWhuy
	 Jpjmm3IX2hJXx2AK6s8eN8zW7qFZ6u78P6sJHa0dNKTBfsEGDSrgS8SXzB5IbWSWugE5B
	 sxhbarP8wwLBxDxs8XBPRgocoOkFwDMkmxVJgnVH34P/6cKY/jYTgP5wzh6oMYKZMwfNf
	 hG35GMhmrxDO1Kfuhv4yQ9A1L/OvN5d+N20sNnpIw+WRGc2+I2U0pTekuyCJ3TKnbOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793251845;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=aaGFXjlWznnwtHjFBVxR5yr0lhNmkbRMpFW9Kta8BMc=;
	b=OEyCAwfs3gkzkrwgClOwlPzNzyMDBd3jU5JKdYsT7TgSXkqoVAeBefAZzQPeEyYX0CRQ
	 BfPbVwurRV+/YMOe9SzgPJTZ1pQoAGYTQgo4abnnf42VfoUob8QQdCpi6KmOifofL1bBC
	 wJ3OudOwSh//aUTnpSuvDAqQxJh5xFW9mRzErcSe3gNWXyMlDVKBgvR0exaffJWdkE2my
	 JJI3Qp4I/t/XNvBCucksThLTsxmJbdmvatwOAO+ArqjyxwWwKNzV6aVgjqZU3KMTgDAkK
	 jQDczAPCHmMJ2pbiOZNaJMqLBvKHb9nfw/2oFRm2fXG/aa8jO1MFJOuO8MHzFJABQUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=BBkRLJ9t;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F618606A31C;
	Thu, 29 Oct 2026 05:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F618606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=BBkRLJ9t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=aa
	GFXjlWznnwtHjFBVxR5yr0lhNmkbRMpFW9Kta8BMc=; b=BBkRLJ9tZR6uSVjOgB
	rAHBRSnc0ILF+NcxLsofyApktFj6JdH8fa7L1+4FJiW36BbnGWZKJ9bIw+WERW3F
	saaYHTbm/Uti6cZUWA22V/XYm+RrxeN6spJ/L5ZxXHOpzbh0BV0lID9/tgb0JMQd
	ikEl+EGcFMviyI91CJW1UUTLQ=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3P2nN2eJq1iVeDg--.22839S2;
	Thu, 29 Oct 2026 13:29:50 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] powerpc/eeh: NUL-terminate force recovery input
Date: Thu, 29 Oct 2026 13:29:48 +0800
Message-Id: <20261029052948.2525048-1-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3P2nN2eJq1iVeDg--.22839S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrtF1xtF4xWw1rAF1kZFy7Jrb_yoW8Jr15pr
	n0kFZxtw48JFn3J3WqkF43Z34jgrs7Zryaga1kW393Zr12vryq9ryUuFyaqr48tryIgF40
	qrs0kFyUKwnrGw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjhFsUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQ78N2ri2c7tOAAA3C

eeh_force_recover_write() can fill its entire stack buffer from userspace
and then pass the unterminated data to strncmp() and sscanf(). This can
make the string helpers read beyond the buffer.

Reserve the last byte and initialize the buffer so every accepted input is
NUL-terminated. Propagate copy errors before parsing as well.

Fixes: 954bd99435b8 ("powerpc/eeh: Add eeh_force_recover to debugfs")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 arch/powerpc/kernel/eeh.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index bb836f02101c..2d7898ef6b8c 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1728,10 +1728,12 @@ static ssize_t eeh_force_recover_write(struct file *filp,
 	struct pci_controller *hose;
 	uint32_t phbid, pe_no;
 	struct eeh_pe *pe;
-	char buf[20];
+	char buf[20] = {};
 	int ret;
 
-	ret = simple_write_to_buffer(buf, sizeof(buf), ppos, user_buf, count);
+	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, user_buf, count);
+	if (ret < 0)
+		return ret;
 	if (!ret)
 		return -EFAULT;
 
-- 
2.34.1

