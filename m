Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794393474;
	b=tCyp9dsYe91mVw0jVaFhbYCegvKZ5d1YKgJXAXqzzEokkSDqdFG0K1aoxVYMRgIav8bs
	 jfIZ0B/ehhCjam2vffRQC3yoig5Y8I8Z6lWtYb/YKjeQo+AvF60HA32SXbrligL7EuNwg
	 oJayq96/UKTPKPv31WjgkqBhXBf/S4sNsXshCOfn6yNZJF1krG7ZZRG50fRWm/xqr4DIk
	 zouUh4u3J6wrq/C7Ay5PPZw8Ix0yu84tTiI8EgRYDPWG5+V5rzlyd0Q7f0uyRD/ZbIfxg
	 5ZpatdEg4ZFywNOTFWHw3mB33gLdCqV1AMhHOQDT/JflYBVLvD2LIUUrSKbugLdIT+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393474;
	h=DMARC-Filter:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=Dso1ta380YcEMHupulitAz3YzmTiixvx3621zNH+NpM=;
	b=FQr1kVIdWuMFooUY3RVfVyNqPPdve7OVLPvvJ0XJruF+lkcM+nYz8oYs17wizFx4AhGr
	 irODsK12wWA4xY/XqwcZrH2EcaCg5ntqu3T2FdJj4P4IUkhV3pARtUEYCFbvzbwtC4N72
	 PAkOJstMwWHu1c2zsDbqyfdTWnembi5yLGFvyp4JFKUCslOk0qd5dsz1UjXCAAhr2c791
	 kSGXQdHim10VlVUXZB1FyTF5rb7OIGh1r8JR9DXIORAmd5K+NdIYhFUYJ1oK9vgWh3ESq
	 0xhScmVfjAqx7oFj3gcNxP44zPtyK/RNDnISLKP5Lw4MLO9cB9YCgBBKr0xWyjfCt1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=gmail.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=G6mwolTN;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD02606A32D;
	Wed, 11 Nov 2026 10:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AD02606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=G6mwolTN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type:To; bh=Dso1ta380YcEMHupulitAz3YzmTiixvx3621zNH+NpM=;
	b=G6mwolTNAeWl/uaRaypqdXOQr2u6tZPi9h27+/jsMgDAE7dfjRLiWLY6zBZVnC
	5A7muMzBl59snsTCtHsJ5RV/RM/FOF4W1rQQoRq70nu3v5ydbx9h8Nve62HPuQpr
	FLY2a69JRTF8rTElxXmxhK77n1K+K8KUyw+RMXRySq3y0=
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Subject: [PATCH net v9 0/4] can: j1939: fix the abort timer and bound EDPO
Date: Wed, 11 Nov 2026 18:31:21 +0800
Message-Id: <20261111-j1939-edpo-v9-v9-0-e779ca334a81@163.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPlD9GoC/yWMywqDQBAEf0X6nAEfIIy/EnJY3TaOh1V2jQTEf
 89q+lYNVQcSozGhKw5E7pZsCRn0UWCYXHhTzGdGXdZtlSdzpY0K/brIruId2belG1UbZGeNHO1
 7954I3PD6n+nTzxy2q4Tz/AHkQYV8dgAAAA==
X-Change-ID: 20261111-j1939-edpo-v9-daeeb60af993
To: Robin van der Gracht <robin@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-CM-TRANSID:PCgvCgAXI3dtRfRqn9XoEg--.16848S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw1kJF4DtFykXF4kJw1fWFg_yoWrWF4rpF
	ZxKFy3KF1kJF42kws7ZF48Xry5ZFs3tay5GrySg3s5Aw45Cr1ftFWxKw1Sga17C393u3y2
	vr1qqF98WF4DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7o7NUUUUU=
Sender: quchaosheng000406@163.com
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbDAA1EuWr0RW03FwAA3m

This series fixes two bugs in the j1939 transport layer, plus two small
hardening changes that fall out of them.

The first bug is a timer reference leak.  The receive timer is cancelled and
restarted from three places, and they do not agree on
active_session_list_lock: the receive handlers call the helper without the
lock, j1939_session_cancel() called it with the lock held, and the rx timeout
branch of j1939_tp_rxtimer() open-coded the same sequence.  Two callers can
interleave between the cancel and the start, and the second hrtimer_start()
reprograms an already armed timer without dropping the reference the first
caller took, so the session and its netdev_hold() reference leak.  [1/4]
replaces the three copies with one helper that cancels with
hrtimer_try_to_cancel() under the lock, so the cancel and the start are one
step.

The second bug is a NULL dereference driven by a peer.  ETP.CM_DPO is peer
controlled and its packet number is not validated; a value at or past
pkt.total moves pkt.dpo past the reassembled buffer, the transfer still
completes, and the local loopback of the receiver's own EOMA hands a NULL
skb to j1939_sk_recv(), which dereferences oskb->sk.  [2/4] rejects that
EDPO.  [3/4] checks the skb in j1939_session_completed() anyway, so a future
regression in the offset arithmetic degrades to a dropped message instead of
a panic.  [4/4] rejects an oversized CTS where it is parsed, instead of
letting it come back one step later as a bad EDPO offset.

Testing: [2/4] was verified on a local vcan link -- ETP.CM_RTS with a size of
1786 bytes (256 packets), then ETP.CM_DPO packet 256 and an ETP.DT with
sequence 0, dereferenced a NULL skb 3/3 times before the bound check and was
rejected 3/3 times after it.  The seq 0 case is the one that made
j1939_xtp_rx_dat_one() compute the last in-order packet, so the transfer
completed and the receiver's own EOMA came back through the loopback, as
described in [2/4].  For the timer side: two unparsable ETP.DT frames
followed by "ip link del" left unregister_netdevice() waiting for the session
reference; with the abort timer rearmed the session is deactivated about
500 ms after the second frame.  Each patch builds standalone (net/can/j1939
built in, x86_64) and passes scripts/checkpatch.pl with no errors or
warnings.  I have no j1939 hardware, so none of this ran on a real CAN bus,
and the race in [1/4] is argued from the lock ordering rather than caught in
the act.

Changes in v9:

- Send the patches as replies to the cover letter; in v8 they went out as
  four separate threads.
- Start the first sentence of every changelog in the imperative.
- Add the Assisted-by tag required by
  Documentation/process/coding-assistants.rst, which v8 was missing.
- Add the missing Fixes tags and Cc: stable for [1/4] and [4/4]; all four
  patches fix behaviour that dates from the original J1939 commit.
- Say in [2/4] where the CTS bound lives, instead of calling it a separate
  fix while [4/4] of the same series does it.
- Give this cover letter an overview of the series and this changelog.

Functionally the patches are unchanged since v8; the only code text that
changed is one comment in [2/4].

Changes in v8:

- [1/4] rewritten: the v7 version armed the timer after cancelling it outside
  the lock, which left the race it was meant to close.
- [2/4] cancels the session timers before aborting, and carries the Fixes tag
  for the NULL dereference.
- [3/4] and [4/4] unchanged from v7.

---
Chaosheng Qu (4):
      can: j1939: serialize cancel and rearm of the receive timer
      can: j1939: validate the EDPO packet number
      can: j1939: drop the message when the reassembled skb is gone
      can: j1939: reject a CTS that names more packets than the message has

 net/can/j1939/transport.c | 119 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 97 insertions(+), 22 deletions(-)
---
base-commit: 2f2f7eeef8b0a1a9b9ca998231419873ccae8d4e
change-id: 20261111-j1939-edpo-v9-daeeb60af993

Best regards,
--  
Chaosheng Qu <quchaosheng000406@163.com>


