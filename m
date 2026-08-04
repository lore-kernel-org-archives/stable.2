Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66BB3F823F;
	Tue,  4 Aug 2026 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832621; cv=none; b=dG/fhCo9gy/bWhEsmZASxzHlXRooqPEBnvd7f2c9Di56n9gCNLlfv7XVowNaZTNiR9I84G6oI/iJhXWJ+9eapHeFMFVlTDjddWIkXhnu36a3i0mYKSzb63yxvMnMUqip4+yTgUlcrpISDjhVlQKsZJjLm8QF7N2LeANzu771Sng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832621; c=relaxed/simple;
	bh=/2Ma7SS3jzCvfDpmm+RP/mBpO3xvsXVu03lVdAogAbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVgeQbKy6gW791pnIZmMWJMPwA82s3jYg+Wm9gaPQlrj3FOymwo3/0u5NIyHN16JdnzMOA3kTzDFsZWuCI9S2dMWG0XfTYmoPmIQA0/26S1A7DSn1tW1N1qO0e5e+m9tbFjogVk02VAYkW1OrMO9OKs7pY754X6mdb84GeMueDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lGjUAgkx; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lGjUAgkx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785832620; x=1817368620;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/2Ma7SS3jzCvfDpmm+RP/mBpO3xvsXVu03lVdAogAbs=;
  b=lGjUAgkx01QS/2UVvNAOtx83sYB4aAf1+5M3gkgDlD0504l5CsKZQ2D7
   t7f/xtAmp/MfG2Dpzkz3gexyMJSGvkbOdCJp5FeG3rAIUM6mX3aPfNUIv
   A4JutIqP76Yg5rh7GRXKDbCHsbM0GXyCccB6PecEuIJ+EulJXr9eRR3b6
   QWijf4WY6mpiUn/rpOrMdDvN27DuEBkw0jBPqPmtIA+yZFxvXNqEN58UK
   97TBS/lfXrabvodVKOx0BTUpzk9r+j+9J3Q4EqTBodP59k7uQ9PsVUXBP
   lhPYayyWG1Lyf8f6oaeJTeMajTUf7slNtc0BfFJPMr+i4UNHiljDPfRsw
   Q==;
X-CSE-ConnectionGUID: oJ1HjNMlRy+wk+XfblmRqw==
X-CSE-MsgGUID: pV14WiZYT7SQpB/8UkLURA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="85508026"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="85508026"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 01:36:59 -0700
X-CSE-ConnectionGUID: rMIBEI6jQeeBqdJVfhXtRA==
X-CSE-MsgGUID: flgjl9yZSueqVgVogpwavQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="265701709"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO mnyman-desk.home) ([10.245.245.149])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 01:36:58 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	stable@vger.kernel.org,
	Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 1/1] usb: xhci: use BIT_ULL for CRCR bits to fix incorrect 64bit mask
Date: Tue,  4 Aug 2026 11:36:39 +0300
Message-ID: <20260804083639.2148950-2-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804083639.2148950-1-mathias.nyman@linux.intel.com>
References: <20260804083639.2148950-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lachlan Hodges <lachlan.hodges@morsemicro.com>

xhci is unusable on some systems after driver switched to BIT() macro.
Upper 32bits of 64bit CRCR command register are unintentionally cleared.

Seen on a raspberry pi 4B compiled for arm32.
The main symptoms were the following log message:

[    0.549897] raspberrypi-firmware soc:firmware: Attached to firmware from 2021-02-25T12:11:39
[    0.626859] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    0.626889] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
[    0.812619] xhci_hcd 0000:01:00.0: hcc params 0x002841eb hci version 0x100 quirks 0x0000200000000890
[    0.813188] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    0.813203] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 2
[    0.813219] xhci_hcd 0000:01:00.0: Host supports USB 3.0 SuperSpeed
[    0.813602] hub 1-0:1.0: USB hub found
[    0.814052] hub 2-0:1.0: USB hub found
[    0.952714] xhci_hcd 0000:01:00.0: ERROR mismatched command completion event

Additionally running lsusb just hangs. Running the same kernel compiled
for aarch64 worked fine. Bisected to the commit in the Fixes line.
Additionally a USB device plugged in to the USB3.0 (or 2.0) did not
enumerate. Once this patch is applied the USB device enumerates properly.

The CRCR register is 64 bits wide - commit abe93f27cdd7
("xhci: use BIT macro") changed the flag definitions from (1 << n),
a signed int, to BIT(n), an unsigned long. Within
xhci_set_cmd_ring_deq(), the following operation is performed on the
CRCR register:

...
	crcr &= ~CMD_RING_PTR_MASK;
	crcr |= deq_dma;
	crcr &= ~CMD_RING_CYCLE;
	crcr |= xhci->cmd_ring->cycle_state;
...

Previously, ~CMD_RING_CYCLE was ~(int)1, a negative signed value
(0xFFFFFFFE with the sign bit set). Widening a negative signed int to
u64 sign-extends it to 0xFFFFFFFFFFFFFFFE, correctly clearing only bit
0 and preserving the 64-bit pointer written two lines above.

After the change when running on 32 bit kernels, ~CMD_RING_CYCLE is
~(unsigned long)1UL. On a 32-bit host this is an unsigned 32-bit
value (0xFFFFFFFE, no sign bit). Widening an unsigned value to u64
zero-extends it instead (0x00000000FFFFFFFE), so the subsequent AND
silently clears bits 63:32 of crcr, truncating the command ring
pointer that was just written before the value reaches hardware.

To fix, similar to how CMD_RING_PTR_MASK is defined, make sure we
use the BIT_ULL variant when defining the CRCR bits.

[Mathias: use BIT_ULL() for ERST_EHB and EP_CTX_CYCLE_MASK as suggested
by Michal Pecio, also include raspberry case in commit message]

Fixes: abe93f27cdd7 ("xhci: use BIT macro")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-sonnet-5
cc: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 2d3941b5e1e3..708e3ccc5d87 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -190,13 +190,13 @@ struct xhci_op_regs {
 
 /* CRCR - Command Ring Control Register - cmd_ring bitmasks */
 /* bit 0 - Cycle bit indicates the ownership of the command ring */
-#define CMD_RING_CYCLE		BIT(0)
+#define CMD_RING_CYCLE		BIT_ULL(0)
 /* stop ring operation after completion of the currently executing command */
-#define CMD_RING_PAUSE		BIT(1)
+#define CMD_RING_PAUSE		BIT_ULL(1)
 /* stop ring immediately - abort the currently executing command */
-#define CMD_RING_ABORT		BIT(2)
+#define CMD_RING_ABORT		BIT_ULL(2)
 /* true: command ring is running */
-#define CMD_RING_RUNNING	BIT(3)
+#define CMD_RING_RUNNING	BIT_ULL(3)
 /* bits 63:6 - Command Ring pointer */
 #define CMD_RING_PTR_MASK	GENMASK_ULL(63, 6)
 
@@ -271,7 +271,7 @@ struct xhci_intr_reg {
  * bit 3 - Event Handler Busy (EHB), whether the event ring is scheduled to be serviced by
  * a work queue (or delayed service routine)?
  */
-#define ERST_EHB		BIT(3)
+#define ERST_EHB		BIT_ULL(3)
 /* bits 63:4 - Event Ring Dequeue Pointer */
 #define ERST_PTR_MASK		GENMASK_ULL(63, 4)
 
@@ -502,7 +502,7 @@ struct xhci_ep_ctx {
 #define CTX_TO_MAX_ESIT_PAYLOAD(p)	(((p) >> 16) & 0xffff)
 
 /* deq bitmasks */
-#define EP_CTX_CYCLE_MASK		BIT(0)
+#define EP_CTX_CYCLE_MASK		BIT_ULL(0)
 /* bits 63:4 - TR Dequeue Pointer */
 #define TR_DEQ_PTR_MASK			GENMASK_ULL(63, 4)
 
-- 
2.43.0

