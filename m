Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C1B33E36A;
	Tue, 25 Aug 2026 23:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787702158; cv=none; b=YGNU4U61+XNKbnCavX2o3z9NYhZ42JK4uja0kMYrhBGJHNdPCAwnOjDTHx4rWTtSxV8ApYpXeCdb51+WYw0PoeEX0BW7/ZbfDkr7prwL3VvBgEFUGGCulmvhhkJrqjweBAp35vZXKZaAHHs585lskbxD2g9OHr2uEBZK6JADWMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787702158; c=relaxed/simple;
	bh=u4RhN4rbo6U/CaIYZY+2wB4CsC8y/ZHMm49Y4elRzyo=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pY0MMpRqBdEP/ubry29r83ollwIE94jb03Rl2Q728I9DHBtajwcvCKZqLSTWdJhfVuu0lEA3v7l+RAZkbXRHQYe4vsP8j2eqx67H4oQhcNCz5f6xbyuQBrwFeJ4OwdgVTZKBxY9UhpaQ1OANMZLGDM0JeOy3ToEaLsd6Xfxw55w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=mrGmclxG; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="mrGmclxG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail3; t=1787702146; x=1787961346;
	bh=0zuxoKD2M1JEVqHANBIUbWduPp/SxtJyTy5Prh/oD7w=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=mrGmclxGRKil5ZV/uCVKYMkGgZX257YTVHByLpKbQjafzcklEip4jwpOOgdPl2hch
	 tqTZFnukn1bui8ETwIF6tdrefF4GR4SCv3s3aBBHDPKS8lkdI56C1nkKpaPZ1+rvPT
	 CQGTwcanShKSG2PUZlDhKTqcAqL1mMdagjK3HMkrHwky3dHFfHFgYBtnT+gRAvkBJF
	 dCOhDtafvMec+qinDtVQKzeH/DIUpxqP2DWiNsxQorhPCNzMyLJI+/RDr2j6vwYm7X
	 aYVsXeF0IwZKinWiNHh08MmMxEQTonwL9f4BXX6sxUCoKuJzwnXSNQVNXV5j48aaZi
	 FRr9h/9BRK6Zg==
Date: Tue, 25 Aug 2026 23:55:40 +0000
To: intel-wired-lan@lists.osuosl.org
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, maciej.fijalkowski@intel.com, andre.guedes@intel.com, vedang.patel@intel.com, jithu.joseph@intel.com, richardcochran@gmail.com, tkusters@aweta.nl, stable@vger.kernel.org
Subject: [PATCH net] igc: only strip RX timestamp header from first buffer
Message-ID: <20260825235530.3278670-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 8f3ba88960520ef0ca5839f4ffd264c7e10e4b08
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

igc_clean_rx_irq() strips IGC_TS_HDR_LEN whenever a descriptor reports
IGC_RXDADV_STAT_TSIP. For multi-buffer packets, continuation descriptors
retain TSIP even though the inline timestamp is present only in the first
RX buffer.

Subtracting the header length from each continuation buffer truncates
jumbo packets by 16 bytes per continuation and leaves the packet length
larger than the received data.

Only consume the timestamp header when skb is NULL, which identifies the
first buffer of a new packet. An skb carried in rx_ring->skb remains
non-NULL when packet assembly resumes in a later NAPI poll.

Link: https://lore.kernel.org/all/20260625-igb-rx-ts-fix-v3-1-99b3efa08dca@=
aweta.nl/
Fixes: e1ed4f92a625 ("igc: Refactor Rx timestamp handling")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moses <p@1g4.org>
---
#
# REPRO
#=20
# Receiver: igc / enp1s0 / 10.0.5.175
# Sender:   RTL8125B / enP4p65s0 / 10.0.5.165

# Both hosts
sudo ip link set dev enp1s0 mtu 9000
sudo ip link set dev enP4p65s0 mtu 9000

# Baseline: RX timestamping off
sudo hwstamp_ctl -i enp1s0 -t 0 -r 0
ping -n -M do -c 5 -s 8972 10.0.5.175
# 5/5 received

# Enable RX timestamping only
sudo hwstamp_ctl -i enp1s0 -t 0 -r 1

# Receiver
sudo timeout 20 tcpdump -ni enp1s0 -s 0 -w /tmp/igc-jumbo.pcap \
  'icmp and host 10.0.5.165'

# Sender
ping -n -M do -c 5 -W 2 -s 8972 10.0.5.175
# 0/5 received

# Receiver
sudo tcpdump -nn -e -vvv -r /tmp/igc-jumbo.pcap
# length 8950
# [total length 9000 > length 8936] (invalid)
# wrong icmp cksum

# Expected Ethernet length: 9014
# Captured length:          8950
# Loss:                       64 =3D 4 continuation buffers * 16 bytes

# Disable RX timestamping again
sudo hwstamp_ctl -i enp1s0 -t 0 -r 0
ping -n -M do -c 5 -s 8972 10.0.5.175
# 5/5 received

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
2.55.GIT


