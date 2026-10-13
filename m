Received: from mail-4396.protonmail.ch (mail-4396.protonmail.ch [185.70.43.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA6939CD12
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 01:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791853801; cv=none; b=ivNJvPrTMiVkYO52//W23Y6trpJFZJoajWwtduQZkb1DTs2ZclcJ/HEIMPAPobdKmKg0RN5yewbjvEm20mJ4Nc6+rKCIuhmZMSA6C6LbqkF4+KZYUE+rMX24iGJBgQefpTHROelgD9gmhAtDfQnE1nrEPCCukpI9ZtlMeKGez5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791853801; c=relaxed/simple;
	bh=mxxVJJZXvsWjhAGYMFHHBSyb8RYQdhl/WBRemRiUE08=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Q1usE46p1imjLYc4ojUG3W1jKQFokeucH4G9CP8eLd8BrIS5Pbuq+CI/R311pD5HeWz3anXY5m2ZUw5F94NRLpxh74exhqa68yFzw/e7hVoOQks4qZTF0hVUBjUu1hVpe4d3ofVS9PCF2I4JqKFkKi1egbgNv+LznPRP6UHAh7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=ihkm2S3c; arc=none smtp.client-ip=185.70.43.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="ihkm2S3c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1791853787; x=1792112987;
	bh=jCsFKpLJmYvgm1OlKEvx32KM7x7W0yeCdPkSIbJ20jc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ihkm2S3cNXK6MBFgENx6x9lI8ENmuQ83ikVkPU2W+wZz3s3KgpZwZ9yOIA1EGFZYV
	 +Voj5RyxUloDM6XzlPICV8zozczQwpoQxx3zgyc8RZ1Q9c5UqCrhXxhUnndVBlJ34K
	 lL9NRmgHE4PAxN7UL4LBN09tFoTgtmqwTjSWoePnpij+VoLUtHCETrW7icoyjYPJqB
	 MhwCcXkWQq+BOeuETH9JoYwVJF0iUjtDk+mB3JOxRjebpWerOJ220UHxWoheRrRT2M
	 icSkearQlf6q5EFdZODFSl173pa1/nXJgdsvFEAYcNJhNT7MLa2O1yNne9Fg1ahEkB
	 dRuGwC+d0kE3g==
Date: Tue, 13 Oct 2026 01:09:37 +0000
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
From: Paul Moses <p@1g4.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com, maciej.fijalkowski@intel.com, avigailx.dahan@intel.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v2] igc: only strip RX timestamp header from first buffer
Message-ID: <20261013010854.4068874-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: b4fcef83b2762455dccb4db51660a44ac447b7fb
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

igc_clean_rx_irq() subtracts 16 bytes for TSIP without checking whether
the descriptor contains that much data. On continuation buffers shorter
than 16 bytes, the unsigned length underflows and is stored in the skb
fragment.

From the wire, a 2040-byte timestamped frame with an 8-byte final buffer
produces a fragment length of 0xfffffff8. Bridge forwarding allows that
skb to reach igc TX without passing through IPv4 length validation.

igc_xmit_frame_ring() uses the corrupted length to calculate the
descriptor requirement, overflowing its 16-bit counter. igc_tx_map()
then passes the same length to skb_frag_dma_map(), requesting a nearly
4 GiB DMA mapping.

In both reproductions, the DMA mapping succeeded and the descriptor
loop completed. The corrupted fragment generated 131,072 descriptor
writes. With the tested 256-entry TX ring, this traversed the ring
512 times, repeatedly overwriting descriptors.

The TX queue then stalled. NETDEV WATCHDOG reported "transmit queue 0
timed out" after about 5.5 seconds, followed by an adapter reset.
The first occurrence also triggered a warning in the NAPI poll path.

Only subtract the inline timestamp header from the first buffer of
an skb-assembled packet. Continuation buffers are appended as fragments
and do not contain an inline timestamp.

Fixes: e1ed4f92a625 ("igc: Refactor Rx timestamp handling")
Cc: stable@vger.kernel.org
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Paul Moses <p@1g4.org>
---
v1...v2
    - improve commit message
    - no code changes
---
Logs:

[  540.236838] WARNING: at igc_poll+0x4f42/0x7660 [igc], CPU#3: swapper/3/0
[  540.372991] Modules linked in: igc
[  540.413904] CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted 7.3.0-rc6+ =
#4 PREEMPT=20
[  540.505951] RIP: 0010:igc_poll+0x4f42/0x7660 [igc]
[  540.563556] Code: 00 e8 b2 c6 eb f0 85 c0 74 27 48 c7 44 24 30 00 00 00 =
00 45 89 e7 8b ac 24 e0 00 00 00 4c 8b b4 24 d8 00 00 00 e9 b2 e6 ff ff <0f=
> 0b e9 10 ec ff ff 49 83 c6 74 4c 89 f0 48 c1 e8 03 42 0f b6 04
[  540.789183] RSP: 0018:ffffc900003e0b68 EFLAGS: 00010282
[  540.852006] RAX: ffffc90000469100 RBX: ffff88824b711380 RCX: 00000000000=
00800
[  540.937776] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff888205d=
33468
[  541.023541] RBP: 1ffff110496e226f R08: ffff888205d3346f R09: 1ffff11040b=
a668d
[  541.109317] R10: dffffc0000000000 R11: ffffed1040ba668e R12: 00000000000=
00000
[  541.195086] R13: 1ffff110496e2270 R14: ffffc900004690f0 R15: ffffea00044=
85d40
[  541.280849] FS:  0000000000000000(0000) GS:ffff8887ac2a5000(0000) knlGS:=
0000000000000000
[  541.378102] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  541.447186] CR2: 000079fdfe44f188 CR3: 0000000109c68003 CR4: 0000000000f=
70ef0
[  541.532974] PKRU: 55555554
[  541.565530] Call Trace:
[  541.594960]  <IRQ>
[  541.619184]  __napi_poll+0x91/0x380
[  541.661120]  net_rx_action+0x4e0/0xbc0
[  541.706209]  handle_softirqs+0x173/0x4d0
[  541.753373]  ? handle_edge_irq+0x1af/0x710
[  541.802631]  __irq_exit_rcu+0x63/0xd0
[  541.846664]  common_interrupt+0x81/0x90
[  541.892793]  </IRQ>
[  541.918044]  <TASK>
[  541.943297]  asm_common_interrupt+0x26/0x40
[  541.993593] RIP: 0010:mwait_idle+0x49/0x60
[  542.042838] Code: 80 0e 40 48 f7 06 10 00 00 00 75 1f 48 89 f0 0f 1f 00 =
31 c9 31 d2 0f 01 c8 48 f7 06 10 00 00 00 75 09 31 c0 31 c9 fb 0f 01 c9 <fa=
> f0 80 26 bf c3 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
[  542.268428] RSP: 0018:ffffc9000025fed8 EFLAGS: 00000246
[  542.331248] RAX: 0000000000000000 RBX: ffff88810091c400 RCX: 00000000000=
00000
[  542.417000] RDX: 0000000000000000 RSI: ffff88810091c400 RDI: 00000000002=
2e00c
[  542.502770] RBP: 1ffff11020123880 R08: ffff8887608f06d3 R09: 1ffff110ec1=
1e0da
[  542.588551] R10: dffffc0000000000 R11: ffffed10ec11e0db R12: 00000000000=
00000
[  542.674330] R13: 0000000000000000 R14: dffffc0000000000 R15: 00000000000=
00000
[  542.760111]  default_idle_call+0x39/0x60
[  542.807277]  do_idle+0xff/0x340
[  542.845051]  cpu_startup_entry+0x48/0x70
[  542.892212]  start_secondary+0xfc/0x100
[  542.938337]  common_startup_64+0x12c/0x147
[  542.987604]  </TASK>
[  543.013881] ---[ end trace 0000000000000000 ]---
[  543.069828] igc 0000:02:00.0: Using 39-bit DMA addresses
[  548.627473] igc 0000:02:00.0 enp2s0: NETDEV WATCHDOG: CPU: 2: transmit q=
ueue 0 timed out 5480 ms
[  548.627546] igc 0000:02:00.0 enp2s0: Register Dump
[  548.627556] igc 0000:02:00.0 enp2s0: Register Name   Value
[  548.627566] igc 0000:02:00.0 enp2s0: CTRL            581c0040
[  548.627581] igc 0000:02:00.0 enp2s0: STATUS          40680683
[  548.627590] igc 0000:02:00.0 enp2s0: CTRL_EXT        100000c0
[  548.627599] igc 0000:02:00.0 enp2s0: MDIC            1805dde1
[  548.627607] igc 0000:02:00.0 enp2s0: ICR             00000081
[  548.627616] igc 0000:02:00.0 enp2s0: RCTL            04408022
[  548.627630] igc 0000:02:00.0 enp2s0: RDLEN[0-3]      00001000 00001000 0=
0001000 00001000
[  548.627649] igc 0000:02:00.0 enp2s0: RDH[0-3]        00000013 0000000c 0=
0000000 00000000
[  548.627668] igc 0000:02:00.0 enp2s0: RDT[0-3]        00000012 0000000b 0=
00000ff 000000ff
[  548.627687] igc 0000:02:00.0 enp2s0: RXDCTL[0-3]     02040808 02040808 0=
2040808 02040808
[  548.627706] igc 0000:02:00.0 enp2s0: RDBAL[0-3]      ffffb000 ffffa000 f=
fff9000 ffff8000
[  548.627725] igc 0000:02:00.0 enp2s0: RDBAH[0-3]      00000000 00000000 0=
0000000 00000000
[  548.627734] igc 0000:02:00.0 enp2s0: TCTL            a503f0fa
[  548.627748] igc 0000:02:00.0 enp2s0: TDBAL[0-3]      fffff000 ffffe000 f=
fffd000 ffffc000
[  548.627766] igc 0000:02:00.0 enp2s0: TDBAH[0-3]      00000000 00000000 0=
0000000 00000000
[  548.627780] igc 0000:02:00.0 enp2s0: TDLEN[0-3]      00001000 00001000 0=
0001000 00001000
[  548.627799] igc 0000:02:00.0 enp2s0: TDH[0-3]        00000013 0000000c 0=
0000000 00000018
[  548.627814] igc 0000:02:00.0 enp2s0: TDT[0-3]        00000013 0000000c 0=
0000000 00000018
[  548.627828] igc 0000:02:00.0 enp2s0: TXDCTL[0-3]     02100108 02100108 0=
2100108 02100108
[  548.627837] igc 0000:02:00.0 enp2s0: Reset adapter
[  552.415852] igc 0000:02:00.0 enp2s0: NIC Link is Up 2500 Mbps Full Duple=
x, Flow Control: RX/TX
[  607.597798] igc 0000:02:00.0 enp2s0: NETDEV WATCHDOG: CPU: 0: transmit q=
ueue 0 timed out 5680 ms
[  607.597890] igc 0000:02:00.0 enp2s0: Register Dump
[  607.597901] igc 0000:02:00.0 enp2s0: Register Name   Value
[  607.597911] igc 0000:02:00.0 enp2s0: CTRL            581c0040
[  607.597926] igc 0000:02:00.0 enp2s0: STATUS          40680683
[  607.597935] igc 0000:02:00.0 enp2s0: CTRL_EXT        100000c0
[  607.597944] igc 0000:02:00.0 enp2s0: MDIC            1805dde1
[  607.597952] igc 0000:02:00.0 enp2s0: ICR             00000081
[  607.597962] igc 0000:02:00.0 enp2s0: RCTL            04408022
[  607.597976] igc 0000:02:00.0 enp2s0: RDLEN[0-3]      00001000 00001000 0=
0001000 00001000
[  607.597996] igc 0000:02:00.0 enp2s0: RDH[0-3]        0000000a 00000006 0=
0000000 00000000
[  607.598015] igc 0000:02:00.0 enp2s0: RDT[0-3]        00000009 00000005 0=
00000ff 000000ff
[  607.598034] igc 0000:02:00.0 enp2s0: RXDCTL[0-3]     02040808 02040808 0=
2040808 02040808
[  607.598053] igc 0000:02:00.0 enp2s0: RDBAL[0-3]      ffffb000 ffffa000 f=
fff9000 ffff8000
[  607.598072] igc 0000:02:00.0 enp2s0: RDBAH[0-3]      00000000 00000000 0=
0000000 00000000
[  607.598081] igc 0000:02:00.0 enp2s0: TCTL            a503f0fa
[  607.598094] igc 0000:02:00.0 enp2s0: TDBAL[0-3]      fffff000 ffffe000 f=
fffd000 ffffc000
[  607.598109] igc 0000:02:00.0 enp2s0: TDBAH[0-3]      00000000 00000000 0=
0000000 00000000
[  607.598124] igc 0000:02:00.0 enp2s0: TDLEN[0-3]      00001000 00001000 0=
0001000 00001000
[  607.598139] igc 0000:02:00.0 enp2s0: TDH[0-3]        00000008 00000006 0=
0000000 0000000c
[  607.598153] igc 0000:02:00.0 enp2s0: TDT[0-3]        00000008 00000006 0=
0000000 0000000c
[  607.598168] igc 0000:02:00.0 enp2s0: TXDCTL[0-3]     02100108 02100108 0=
2100108 02100108
[  607.598176] igc 0000:02:00.0 enp2s0: Reset adapter
[  611.790143] igc 0000:02:00.0 enp2s0: NIC Link is Up 2500 Mbps Full Duple=
x, Flow Control: RX/TX

---

 drivers/net/ethernet/intel/igc/igc_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethern=
et/intel/igc/igc_main.c
index 1fb5f3cbe93c..41b293dc10c3 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2639,7 +2639,8 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_ve=
ctor, const int budget)
=20
 =09=09pktbuf =3D page_address(rx_buffer->page) + rx_buffer->page_offset;
=20
-=09=09if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
+=09=09if (!skb &&
+=09=09    igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
 =09=09=09ctx.rx_ts =3D pktbuf;
 =09=09=09pkt_offset =3D IGC_TS_HDR_LEN;
 =09=09=09size -=3D IGC_TS_HDR_LEN;
--=20
2.56.GIT


