Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4B5471258;
	Thu, 24 Sep 2026 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790249256; cv=none; b=r3ISC9ogKVJUWpZbzlkr26Wa33jNxvVQrtMQmtfeVEYdfalWrXzozilZ8zq9rd308JWKUcOOozsmMmJED2HkChSNBxhCynLDDKzXErocZJloK8xrSux6U1npnRF3W03LeoqgeZQWvhXAy6cd2/qxEcl4tnHm75Q8j0+IDbmLvAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790249256; c=relaxed/simple;
	bh=CIAPN49LYNcXJ4qPdZ65hFvFXICKCWhILfmWQwprOzI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uIr2OSei9YcttTTAHyunlI8XqFYbyZ3QpIDL4hRhTlxwhfAZdr18BREIWMF4fbgaPaTZdQEmOQmTQELIJc4i209b9R6f6ITfomyFrsKDSghhrM8kkYYqDTDBerenodCTrMXl/28McgjfPtxNO+DSasl/C0XhUVcbmKyk+qW62qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAA3Cu4VCbVqttfSCA--.48775S2;
	Thu, 24 Sep 2026 19:27:17 +0800 (CST)
From: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
To: Johannes Berg <johannes@sipsolutions.net>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Mathias Kretschmer <mathias.kretschmer@fokus.fraunhofer.de>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mac80211: don't warn on empty legacy rate mask for no-sta frames
Date: Thu, 24 Sep 2026 11:27:16 +0000
Message-Id: <20260924112716.376346-1-xujiakai24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAA3Cu4VCbVqttfSCA--.48775S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr1xZF13Jr4xCFWxuryDZFb_yoW3KrW8pr
	yYqrsrGF48Xa1Yya18A3WkJry3GF48Aa1xW3yxCryxJFyakryDX3sFkr4xtrW5K3s7AF4x
	tF1DtrsYkrs8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28I
	cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx
	0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU5QID3UUUUU==
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/

__rate_control_send_low() warns when no rate in rate_mask could be
selected for a frame that is sent at a low/basic rate (multicast,
management or no-ack frames).  However, the rate mask configured via
NL80211_CMD_SET_BITRATE_MASK may legitimately contain no legacy rates
at all for a band, as long as an HT/VHT/HE/EHT MCS mask is present:
nl80211_parse_tx_bitrate_mask() only rejects an empty legacy mask
when no MCS mask was configured either.

Frames without a station (sta == NULL, e.g. multicast data, beacons
and other management frames) are only ever sent at legacy rates, and
rate_control_send_low() falls back to __rate_control_send_low() with
the configured legacy rate mask.  With an MCS-only rate mask, no
legacy rate can match, the loop runs to completion and the warning
fires -- on every beacon/multicast transmission.

Falling back to the lowest rate (index 0, which the loop leaves in
info->control.rates[0].idx) is exactly what the code already does,
and is the only possible behaviour for such frames; the warning adds
no information in this case.  Keep the warning when a non-empty
legacy rate mask was configured but no rate matched (e.g. filtered
out by rate flags or station capabilities), which still indicates a
genuine problem.

Fixes: 2103dec14792 ("mac80211: select and adjust bitrates according to channel mode")
Assisted-by: OpenCode:DeepSeek-V4-Flash
Signed-off-by: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
---
 net/mac80211/rate.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 64768abb0a5f2..1dc05bdaef01d 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -396,7 +396,14 @@ static void __rate_control_send_low(struct ieee80211_hw *hw,
 		info->control.rates[0].idx = i;
 		break;
 	}
-	WARN_ONCE(i == sband->n_bitrates,
+	/*
+	 * An empty rate_mask is a valid configuration: nl80211 allows
+	 * configuring only HT/VHT/HE/EHT MCS rates.  Frames without a
+	 * station (multicast, beacons, management) are sent at legacy
+	 * rates regardless, and the fallback to rate index 0 done here
+	 * is all that can be done for them, so don't warn.
+	 */
+	WARN_ONCE(i == sband->n_bitrates && rate_mask,
 		  "no supported rates for sta %pM (0x%x, band %d) in rate_mask 0x%x with flags 0x%x\n",
 		  sta ? sta->addr : NULL,
 		  sta ? sta->deflink.supp_rates[sband->band] : -1,
-- 
2.34.1


Crash report (WARNING_in___rate_control_send_low_KConfigFuzz_20260917_174018_416fc16d, kernel 7.1.13; a second variant with the same signature on 7.2.3 goes through ieee80211_beacon_get; appended below for reference; everything after the "-- " signature is discarded by git am):

---
------------[ cut here ]------------
no supported rates for sta (null) (0xffffffff, band 0) in rate_mask 0x0 with flags 0x0
WARNING: net/mac80211/rate.c:406 at __rate_control_send_low+0x145/0x230 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/mac80211/rate.c:401, CPU#1: kworker/1:3/2272
Modules linked in:
CPU: 1 UID: 0 PID: 2272 Comm: kworker/1:3 Tainted: G        W    L      7.1.13 #1 PREEMPT(full) 
Tainted: [W]=WARN, [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: mld mld_ifc_work
RIP: 0010:__rate_control_send_low+0x188/0x230 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/mac80211/rate.c:401
Code: 94 bb d4 00 00 00 eb 11 e8 e5 e0 09 fc eb 3f e8 de e0 09 fc ba ff ff ff ff 48 89 de 4c 89 f7 44 89 f9 44 8b 44 24 0c 41 89 e9 <67> 48 0f b9 3a eb 32 e8 bc e0 09 fc eb 05 e8 b5 e0 09 fc 48 8b 44
RSP: 0018:ffffc9000593f4d8 EFLAGS: 00010293
RAX: ffffffff855cb732 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 00000000ffffffff RSI: 0000000000000000 RDI: ffffffff877e34c0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000002 R11: ffff888102d5b200 R12: 0000000000000000
R13: 0000000000000800 R14: ffffffff877e34c0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881b447a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ff1aff8 CR3: 000000001556e000 CR4: 0000000000752ef0
PKRU: 55555554
Call Trace:
 <TASK>
 rate_control_send_low+0xb9/0x230 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/mac80211/rate.c:429
 rate_control_get_rate+0x80/0x300 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/mac80211/rate.c:943
 ieee80211_tx_h_rate_ctrl+0x3f1/0x750 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/mac80211/tx.c:764
 invoke_tx_handlers_late+0x3f/0x830 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/mac80211/tx.c:1859
 ieee80211_tx_dequeue+0x153e/0x1c20 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/mac80211/tx.c:3993
 wake_tx_push_queue home/zzzrrll/tmp/kf_src/linux-7.1.13/net/mac80211/util.c:296 [inline]
 ieee80211_handle_wake_tx_queue+0x79/0x130 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/mac80211/util.c:317
 drv_wake_tx_queue home/zzzrrll/tmp/kf_src/linux-7.1.13/net/mac80211/driver-ops.h:1394 [inline]
 schedule_and_wake_txq home/zzzrrll/tmp/kf_src/linux-7.1.13/net/mac80211/driver-ops.h:1401 [inline]
 ieee80211_queue_skb+0x7df/0xbc0 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/mac80211/tx.c:1674
 ieee80211_tx+0x17f/0x230 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/mac80211/tx.c:1980
 __ieee80211_subif_start_xmit+0x50c/0x7c0 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/mac80211/tx.c:4401
 ieee80211_subif_start_xmit+0x61/0x220 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/mac80211/tx.c:4597
 __netdev_start_xmit home/zzzrrll/tmp/kf_src/linux-7.1.13/include/linux/netdevice.h:5369 [inline]
 netdev_start_xmit home/zzzrrll/tmp/kf_src/linux-7.1.13/include/linux/netdevice.h:5378 [inline]
 xmit_one home/zzzrrll/tmp/kf_src/linux-7.1.13/net/core/dev.c:3888 [inline]
 dev_hard_start_xmit+0xbb/0x310 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/core/dev.c:3904
 __dev_queue_xmit+0x7b6/0x15e0 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/core/dev.c:4876
 neigh_output home/zzzrrll/tmp/kf_src/linux-7.1.13/include/net/neighbour.h:560 [inline]
 ip6_finish_output2+0x5d4/0x9d0 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/ipv6/ip6_output.c:138
 NF_HOOK_COND home/zzzrrll/tmp/kf_src/linux-7.1.13/include/linux/netfilter.h:307 [inline]
 ip6_output+0xb2/0x1c0 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/ipv6/ip6_output.c:248
 dst_output home/zzzrrll/tmp/kf_src/linux-7.1.13/include/net/dst.h:470 [inline]
 NF_HOOK home/zzzrrll/tmp/kf_src/linux-7.1.13/include/linux/netfilter.h:318 [inline]
 mld_sendpack+0x3bf/0x600 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/ipv6/mcast.c:1871
 mld_send_cr home/zzzrrll/tmp/kf_src/linux-7.1.13/net/ipv6/mcast.c:2170 [inline]
 mld_ifc_work+0x407/0x600 home/zzzrrll/tmp/kf_src/linux-7.1.13/net/ipv6/mcast.c:2709
 process_one_work home/zzzrrll/tmp/kf_src/linux-7.1.13/kernel/workqueue.c:3314 [inline]
 process_scheduled_works+0x2f9/0x690 home/zzzrrll/tmp/kf_src/linux-7.1.13/kernel/workqueue.c:3397
 worker_thread+0x31a/0x480 home/zzzrrll/tmp/kf_src/linux-7.1.13/kernel/workqueue.c:3478
 kthread+0x18d/0x1e0 home/zzzrrll/tmp/kf_src/linux-7.1.13/kernel/kthread.c:436
 ret_from_fork+0x191/0x450 home/zzzrrll/tmp/kf_src/linux-7.1.13/arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 home/zzzrrll/tmp/kf_src/linux-7.1.13/arch/x86/entry/entry_64.S:245
 </TASK>
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	94                   	xchg   %eax,%esp
   1:	bb d4 00 00 00       	mov    $0xd4,%ebx
   6:	eb 11                	jmp    0x19
   8:	e8 e5 e0 09 fc       	call   0xfc09e0f2
   d:	eb 3f                	jmp    0x4e
   f:	e8 de e0 09 fc       	call   0xfc09e0f2
  14:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  19:	48 89 de             	mov    %rbx,%rsi
  1c:	4c 89 f7             	mov    %r14,%rdi
  1f:	44 89 f9             	mov    %r15d,%ecx
  22:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
  27:	41 89 e9             	mov    %ebp,%r9d
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	eb 32                	jmp    0x63
  31:	e8 bc e0 09 fc       	call   0xfc09e0f2
  36:	eb 05                	jmp    0x3d
  38:	e8 b5 e0 09 fc       	call   0xfc09e0f2
  3d:	48                   	rex.W
  3e:	8b                   	.byte 0x8b
  3f:	44                   	rex.R

---

