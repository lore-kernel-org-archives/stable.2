Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815611;
	b=VRStZzpuBtzXU6Ka+VOOfq1NhzRyPqmF9NtADFsb61USxZ8o3yDozROONHgXSBMSt3qU
	 I/Hu4u5yH16JUBqZJekLvbXM2GgbDfv2H5fRLc7C56RSkBUNpZLb+7YmyNTkBRAApGdbP
	 FMeGi0JhnLUlmX3rE0qrto2hTqxuhKcIeyOcqNUgadJs5bOQ2LB9dVXDDgh0tdpG2nNLJ
	 tyxo+WUh+7SzkU5qLmzkUnaW+HSQo2bEbASFLe5+kudxJ9hAyBBUtFMrmGuoh49IT9lkx
	 +tR5MmQ75UZlSCDe0heHCKVN7hrwhbsJi/Jw9HzKKVrrSFBSUQ4oRj1802FwaMY0UhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815611;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=lVr+PvuxwPoJYoyARXvzG+BDMpFOZxa4C3Y0HgYCBmA=;
	b=QS1kj3WCPAqaO0A6qFOKdYc7rxRtKNRtN/JoFsZ8HbXCIadbhf8tru8g834VVhpq9+Ao
	 LycYMs+nu/lDGcj3zhvGS3EjtdScaXzRY5kbEMzC9+mWi+ejDFc1fkbOkCSGj1SiLAiQt
	 jQZ1xf+vHd3xUvpGZt4Bi9LZ/pwKARTlYZcApK/D9Jy3p9gvGNHsOqiHAXMmpJX4HtnR9
	 xF9mNZt9s7+LHzqLxfTcJVplsRuSetmNJyAMSEYbhJL0gsVPtvAkfvKnY/wBTlQPYkWNV
	 YeC0l1WslNj70/kWIIc5jGBg4vMs/YTGU92fS4ev6+ujOS8OzTnvRPLXeeI0djE9mpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=becholey.ch;
	spf=pass smtp.mailfrom=becholey.ch;
	dkim=pass header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=pYL0rGRH;
	arc=none smtp.remote-ip=109.224.244.118
Received: from mail-244118.protonmail.ch (mail-244118.protonmail.ch [109.224.244.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA22E606A334
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 07:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA22E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=becholey.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=becholey.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=pYL0rGRH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=becholey.ch;
	s=protonmail; t=1794815608; x=1795074808;
	bh=lVr+PvuxwPoJYoyARXvzG+BDMpFOZxa4C3Y0HgYCBmA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=pYL0rGRHYAaJBTpHrQkIra/2TG6WdVyW6buM3oDyD6mEVPuZHOvo5rgTk/UxZXp7k
	 /xG0hc1QJ+UlfDGFfb9uExkfL3GIRqiABB/sA7NfJCMN6b1iEooVr1lNOGbLQ6H0S4
	 3HIjcKuJnJiQCeocw14LIKtyv7xruq/7LaD+rtz+iX+Xz1Y18Z3FR4+5KS6Z4Igkwh
	 KFmPvy1/97rmmdVV0RtAgL10azY//2MJUtnZdMj8hyO4BJsXMNa/h1bRaD0OpV/my/
	 gOq6cNNjl/OZURQD3Po6vB9DEguaiCJUvWrolhFa2FziL7Jyr4tckyE0szLQi42/tz
	 S0sWvGGUq5zAQ==
Date: Mon, 16 Nov 2026 07:53:23 +0000
To: linux-wireless@vger.kernel.org, "John W. Linville" <linville@tuxdriver.com>, Pontus Fuchs <pontus.fuchs@gmail.com>
From: Alexandre Becholey <alex@becholey.ch>
Cc: Jeff Johnson <jjohnson@kernel.org>, Weiming Shi <bestswngs@gmail.com>, linux-kernel@vger.kernel.org, Alexandre Becholey <alex@becholey.ch>, stable@vger.kernel.org
Subject: [PATCH 1/3] wifi: ar5523: don't WARN on a short command reply
Message-ID: <20261116075305.234240-2-alex@becholey.ch>
In-Reply-To: <20261116075305.234240-1-alex@becholey.ch>
References: <20261116075305.234240-1-alex@becholey.ch>
Feedback-ID: 60743817:user:proton
X-Pm-Message-ID: fb848ebaef6850f0537b43cc977c114a54fac972
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

ar5523_read_reply() computes the reply payload length from the header
length sent by the device:

=09dlen =3D be32_to_cpu(hdr->len) - sizeof(*hdr);

ar5523_cmd_rx_cb() only checks that the USB transfer carries at least a
full header; hdr->len itself is not validated. A device that sends a
reply of at least 32 bytes with hdr->len < 32 (or with bit 31 set) makes
dlen negative and hits WARN_ON(1). This is reachable during probe, from
the first read command (WDCMSG_HOST_AVAILABLE), and also later from an
unsolicited reply once the interface is up. With panic_on_warn set it
panics the machine. With an emulated device on
v7.4-rc2-141-g9d66f26fefac (arm64):

[    2.565535] WARNING: drivers/net/wireless/ath/ar5523/ar5523.c:57 at ar55=
23_cmd_rx_cb+0x730/0x980, CPU#0: swapper/0/0
[    2.573914]  ar5523_cmd_rx_cb+0x730/0x980 (P)

The branch also completes the command without setting cmd->res, so the
caller gets the result of the previous command (normally 0) and goes on
with an output buffer that was never written. For example, a corrupted
GET_STATUS(ST_MAC_ADDR) reply lets probe succeed and registers a wiphy
with the all-zero MAC address read from the unwritten stack buffer.

A bad length from the device is not a kernel bug. Report it with
ar5523_err() and fail the command with -EPROTO, like the existing
"olen too small" case in the same function.

The bug was found, and the reproducer and this fix were written, by AI
agents (Claude Mythos and Claude Opus models). The analysis and the
patch were reviewed by a human.

Fixes: b7d572e1871d ("ar5523: Add new driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Becholey <alex@becholey.ch>
---
Notes for reviewers (not part of the commit message):

Trigger: an AR5523 device emulated with raw-gadget behind dummy_hcd
(arm64, QEMU virt), also seen with QEMU's xHCI. The device answers the
WDCMSG_HOST_AVAILABLE read command during probe with a 36-byte reply
whose header length is 16. Other variants that hit the same WARN: a
header length of 31, a header length of 0xffffffff in the
GET_STATUS(ST_MAC_ADDR) reply, and an unsolicited reply with header
length 16 after the interface has been brought up. No local action is
needed for the probe case. The reproducer is available to maintainers
on request.

Decoded trace, torvalds/master 9d66f26fefac (arm64, QEMU virt):

  WARNING: drivers/net/wireless/ath/ar5523/ar5523.c:57 at ar5523_cmd_rx_cb+=
0x730/0x980, CPU#0: swapper/0/0
  CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.4.0-rc2-00141-g9d66f26=
fefac #1 PREEMPT(full)
  pc : ar5523_cmd_rx_cb (drivers/net/wireless/ath/ar5523/ar5523.c:57 (discr=
iminator 2) drivers/net/wireless/ath/ar5523/ar5523.c:125 (discriminator 2))
  Call trace:
   ar5523_cmd_rx_cb (drivers/net/wireless/ath/ar5523/ar5523.c:57 (discrimin=
ator 2) drivers/net/wireless/ath/ar5523/ar5523.c:125 (discriminator 2)) (P)
   __usb_hcd_giveback_urb (drivers/usb/core/hcd.c:1657)
   usb_hcd_giveback_urb (drivers/usb/core/hcd.c:1741)
   dummy_timer (drivers/usb/gadget/udc/dummy_hcd.c:2051 (discriminator 1))
   __hrtimer_run_queues (kernel/time/hrtimer.c:2079 kernel/time/hrtimer.c:2=
136)
   hrtimer_run_softirq (kernel/time/hrtimer.c:2153)
   handle_softirqs (kernel/softirq.c:669)
  Kernel panic - not syncing: kernel: panic_on_warn set ...

ar5523.c is identical in v7.3.1 and 9d66f26fefac; the same WARN
appears on both and the patch applies unchanged to both.

Testing (KASAN, UBSAN, lockdep, emulated device): without the patch,
6 of 6 boots with a bad reply length hit the WARN (v7.3.1 5, one of
them on xHCI; 9d66f26fefac 1). With the patch, the ar5523.c:57 WARN
appears in none of 35 boots (v7.3.1 27, 9d66f26fefac 8; 5 of them on
xHCI). Every bad length is reported as "invalid reply length N" and the
command fails; probe then fails cleanly with -EPROTO. A header length
of exactly 32 (empty payload) is still accepted, and a device with a
valid handshake still probes, reports its MAC address and the interface
comes up.

Not fixed here, but by patch 2/3 of this series: any unsolicited
reply carrying the command id, even with a valid length, completes
cmd->done although no read command is pending. The next command then
returns early and the one after that resubmits a URB that is still
active ("URB submitted while active" WARN in usb_submit_urb() from
ar5523_cmd()). This happens with and without this patch; with this
patch alone an unsolicited reply with a bad length ends in that same
state instead of the ar5523.c:57 WARN.

Related: Weiming Shi's "wifi: ar5523: reject negative reply lengths"
(2026-08-31, not merged,
https://lore.kernel.org/all/20260831191502.3321906-1-bestswngs@gmail.com/)
fixes a different bug, a negative olen word in the reply payload, a few
lines further down in ar5523_read_reply(). None of the three patches
here depends on it; 1/3 and 2/3 apply with or without it. 3/3 and his
patch overlap in one context line: with this series applied first, his
patch still applies with git am -3. If his patch goes in first, 3/3
needs a one-line rebase (the check becomes
"if (olen < 0 || cmd->olen < olen) {" inside the new locked section),
and I can send a rebased version on request.

Thanks,
Alexandre Becholey

 drivers/net/wireless/ath/ar5523/ar5523.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)


diff --git a/drivers/net/wireless/ath/ar5523/ar5523.c b/drivers/net/wireles=
s/ath/ar5523/ar5523.c
index 66ac396858a5..734f0561cf73 100644
--- a/drivers/net/wireless/ath/ar5523/ar5523.c
+++ b/drivers/net/wireless/ath/ar5523/ar5523.c
@@ -54,7 +54,10 @@ static void ar5523_read_reply(struct ar5523 *ar, struct =
ar5523_cmd_hdr *hdr,
 =09dlen =3D be32_to_cpu(hdr->len) - sizeof(*hdr);
=20
 =09if (dlen < 0) {
-=09=09WARN_ON(1);
+=09=09ar5523_err(ar, "invalid reply length %u\n",
+=09=09=09   be32_to_cpu(hdr->len));
+=09=09cmd->olen =3D 0;
+=09=09cmd->res =3D -EPROTO;
 =09=09goto out;
 =09}
=20
--=20
2.53.0

