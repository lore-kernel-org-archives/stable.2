Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6494F38DC4C
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 04:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790741542; cv=none; b=D1sEuunwZ96ZPOf4yibvgJ3t2E17Rr1xhXnBkz9eGXb5U7DOJFQ4jT4sWAOrouM38Nu+uG01UHOt+PHClESwSL3XPxStz3eBGJhQd3xeyjYFDgMRlhLVzrlwvyRWFvbQGjAfVfuCR+/ugH1ynVlZ6wmobYR+peei5/sXmHIWRgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790741542; c=relaxed/simple;
	bh=0w4mC8arNmkQhMXML9h2TtCEKd4PCD1CoW15iDD1aHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rlkRp8q4K8PKX8mUVhyuKFXQib3kmTwR7KMFTysdOFhqxb0qJzWAac2bKtdrYDewoEmdZ7KAPcNEquPxlY1BN46bJooA8pLUdjBNwYtspf4q7Gv7IH7ILodTnFiTZCS9c72hIV39++zSMdp4EwXN0UrbpZwRlRlV1z2W5426ta8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e//8+exW; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e//8+exW"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2caced6038eso9525765ad.0
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 21:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790741540; x=1791346340; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U5tG0XE62Mo5Tqxqub9B8jicopChvsf5EAXXt/uDdSs=;
        b=e//8+exWRN96Yk8H1WcHomi1i948EWCx7ytvfRpMmNunc/x3zY70Fyhxyh12grfGki
         5zyT+bpz9BMCR6L3qXzp/fpqwZ1XU7yuhoaejUNTqwAgsyFoZzzU5/byJeMpxp3kMATA
         tJ5LrjHhU92G6PPg6dHgspYa9B6cYZRPSiZ0yhLGzDNaa/aUBTE8yz2TUBD0tXCuRqpG
         Qz9vEuFrcJjNtTJMOrC3+r68ZbUByFbbeKYT5dp5B7tTSXzbjiCKLV54hFflVjVxe8Tw
         KB6Zsjvc9+NgKf5vdXm7rasKjrBsWm4mLYW6CL6E0KlmUzwtqcEMf4PClbLKTGHPNwEm
         MBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790741540; x=1791346340;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U5tG0XE62Mo5Tqxqub9B8jicopChvsf5EAXXt/uDdSs=;
        b=rZEJboIoL5URiM0SAPpW73bx2BZsTTiLdEFSQuOFiRdckCdcEpYbOdxS8LhCkwMP11
         b6pcjQDh6cm3mihe1Pd3OCwTu9XnDhwTFcDrR2OEuzdiKa69oakCVMhdoU+y0ncU7+50
         G+HWzBYLR2in+FWPVUYUa03mva+IxKqgf3iwh+yQtyiWuD3z3TcV49AobzSzYuGevsoj
         XLljdX3ofb3OO/j/PAHkGrxOMGtLWY64kj8H6+vfobsjlDKG1rHAEsuSGmaZA4cR4/bx
         2gli1zjW+OCY/r6BfkT1lLjyODq05YDNyCJeTqYuzDl1ylFBMhsA+Blq+wbboCv7V1ki
         5tEA==
X-Forwarded-Encrypted: i=1; AKwUvBz2dqJj2F82O/UCHedddyRbl3QKdY1ePn3DsMOIsZNF25zuz+kXxMGGcyFpw+mLGtwTOi4WwgE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKHzXXGSaaaftjffpojLRdpVue3YZNuDdDRiwxxqjrXYMH5J+FL
	92x1XDrVSTlnwPsAZ4BPuzx4SX38sjIBHbcQvyyzSLqFn9HZ4EQcjqeydzEeGDrn
X-Gm-Gg: AYBFou0zu/IOvMcDDqbUv77F9/Njnx3qVC4LBHuQi6Qyv28mVK2x3zwSLFIx7S1w/9e
	RjqqT51jvAD6v+wDaBCaYgybgCKYULGRJvAPGdbuyJ/uFry7yV1evuW1IdgvnYgUIG92bc3TdDk
	myd1YJ3xhObuWzCWxhxyaR2mDDw6NfB5W81brAu2HPNTJ1ktU0x8DyTdgc6I5eLS736wD0Ix17a
	yIkQjEp9fZPNXsdAeTdwm8GzB8LWOn5wI9N444/77NZFyDiwCd43PbogH4QfLKSiVjSUoBPpqv9
	+Wo6zKl1E8dAUnN6k/mjvC/r6T+5rpw3vCeyJQTDJpH5U5yb6Cx6nA8+PCu0rcC4gYrxeMBl/sz
	UofSXlL4cROf0hktBdWvmjaBuuBI3Sen/x9WkfHnn97RvpDU0X5olaHbR3SeJqhXkpYDG0HCruC
	rMioG8TMek98ef5Yn5wCBnY81d4SowJBgKF5D1T87GuMtixUd925WWGu1mv/FYoaCkfMWFzelMN
	Zuc7ByM6sKY4ZILCpmbYNW2t2lqSWv7FxPEYQFgjT5TBzMXIoJI9uJBlIdxNASJ1zpLZ8StxfwX
	ibMF/UxNQ5ftGiSNm3i8
X-Received: by 2002:a17:903:1109:b0:2d8:d4d2:d136 with SMTP id d9443c01a7336-2e2e4b6ce5emr1156045ad.18.1790741539618;
        Tue, 29 Sep 2026 21:12:19 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2e5c4a240sm160065ad.81.2026.09.29.21.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 21:12:19 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v5 1/3] serial: 8250: hold hash_mutex across IRQ chain linking in serial_link_irq_chain()
Date: Wed, 30 Sep 2026 04:12:14 +0000
Message-ID: <20260930041216.155911-2-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930041216.155911-1-benquike@gmail.com>
References: <20260930041216.155911-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In serial_link_irq_chain(), serial_get_or_create_irq_info() acquires
hash_mutex to search or allocate a chain instance and drops hash_mutex
before returning.

If a concurrent call to serial_unlink_irq_chain() runs immediately after
serial_get_or_create_irq_info() returns while i->head is still NULL,
serial_unlink_irq_chain() acquires hash_mutex, finds i with
i->head == NULL, frees the chain structure via free_irq() / kfree(),
and removes it from the hashtable. serial_link_irq_chain() then
proceeds to scoped_guard(spinlock_irq, &i->lock), dereferencing the freed
chain pointer i and causing a slab use-after-free.

Move guard(mutex)(&hash_mutex) to the beginning of
serial_link_irq_chain() and rename serial_get_or_create_irq_info() to
serial_get_or_create_irq_info_locked() so hash_mutex is held across the
entire lookup, linking, and error-path unlinking sequence.

Tested in QEMU against tip of mainline (62f4c998b297, "Merge tag
'parisc-for-7.3-rc5' of git://git.kernel.org/.../parisc-linux")
with KASAN enabled by concurrently opening/closing 8250 serial ports
sharing IRQ 4 (ttyS0 and ttyS2): on the unfixed kernel KASAN detects
slab-use-after-free in serial_link_irq_chain(); whereas with this fix
applied, port registration and unregistration run cleanly with 0 KASAN
warnings.

Fixes: e91f1ed6c24f ("serial: 8250: fix use-after-free in serial_link_irq_chain")
Cc: stable@vger.kernel.org
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v5:
- Rebased cleanly onto tip of mainline commit 62f4c998b297.
- Updated patch diff and commit description to align with upstream
  guard(mutex) refactoring in 8250_core.c.

Changes in v4:
- No changes.

Changes in v3:
- No changes.

Changes in v2:
- Split out from monolithic patch into patch 1/3, add Cc: stable@vger.kernel.org,
  and document QEMU test procedure in commit message body, as requested by
  Greg Kroah-Hartman and John Ogness.

 drivers/tty/serial/8250/8250_core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index b875d394796f..e831a8fe9a95 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -130,12 +130,10 @@ static void serial_do_unlink(struct irq_info *i, struct uart_8250_port *up)
  * - find the corresponding info in the hashtable and return it, or
  * - allocate a new one, add it to the hashtable and return it.
  */
-static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_port *up)
+static struct irq_info *serial_get_or_create_irq_info_locked(const struct uart_8250_port *up)
 {
 	struct irq_info *i;

-	guard(mutex)(&hash_mutex);
-
 	hash_for_each_possible(irq_lists, i, node, up->port.irq)
 		if (i->irq == up->port.irq)
 			return i;
@@ -156,7 +154,9 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
 	struct irq_info *i;
 	int ret;

-	i = serial_get_or_create_irq_info(up);
+	guard(mutex)(&hash_mutex);
+
+	i = serial_get_or_create_irq_info_locked(up);
 	if (IS_ERR(i))
 		return PTR_ERR(i);

