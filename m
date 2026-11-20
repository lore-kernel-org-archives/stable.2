Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172169;
	b=NzEwErtCX3t66BkUlawdUYxniCbuI5k9tQ+koH/9hhnKg4pXeqVW6rjol2VBzkVhPmxL
	 P+oAQEhEqxJNl3AiUoOer0hvxPtXR4L5zRASdZRrX9Z29Q8PEb8qe9UGf/UTT1uVxlsyl
	 XDoJDBMDGueXyKRltSaOVOqhlE3faR5BeNBC7034Nt63z5v9IdmB2bmWKh0T9TWansVsD
	 phAavzaj6ZMKRVWAIzwaNjr52j2mQjf8DZgi19Um5kPUp/3XY7yFcXDYPQBSS0cQBsTZI
	 VTtBpseAxneMvGQfWZgOkg+wCeOGFVFNHGrkQT9LZEf/wcRorknH29oC3lGtdeEPnOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172169;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=l3UcI9yUrxVvioLldGrOSgry5dsxwU15rfB9+uaoMLM=;
	b=rLi47lOuvd9DLNten3x+ZcEAtYgH0dVEuWiadwJMMa0y4DxtDBWU3HiKPMgcNex6+2nO
	 TdvAQOGYafpgjC/p529UQ+rskByQd8qAJs4JePgUdolu8IViax1rrMR2jvll4Ij6qOgam
	 WmAu360CVl5fc/lMhNY6uBpSthGu9pEpHqqL9X14qsQ/dEGwgQ+H10BqcMlf4Lh2qlgIY
	 CDYauQBgQhQR62Ewo6gkaHPneJt5sex/VcHlHldphJA1DBnboAoc29kj+jY4WoOhFaJVI
	 yZFI4Pk+16Lbq0wToLAC51whc4AiZ5yGJd0iHMUbU7hM8oEJmyHq6Z8OGB7ENlfIDng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=kpdBZ+GY;
	arc=none smtp.remote-ip=115.124.28.75
Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com [115.124.28.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A290E606A320;
	Fri, 20 Nov 2026 10:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A290E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=kpdBZ+GY
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1795172161; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=l3UcI9yUrxVvioLldGrOSgry5dsxwU15rfB9+uaoMLM=;
	b=kpdBZ+GYaYGcT/CpNjOE65VWVvr6jIqNfNZ4YJQCXiYzSQKIJa3PPl5d9AJhbiHhsZuR+zBOJHBCmh1vPLXVR40ZJ1TfsxSfg7Ddduy8psDwlY5lsMPYdhBFGWg7M+FUgPO98ipsfS7ys4KOpnYBSQmQT1Chh1Bzn1GR4/kZ7zw=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.044391|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00812833-0.000228324-0.991643;FP=12542528845651154930|1|1|4|0|-1|-1|-1;HT=maildocker-contentspam033023087102;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.k6Wwa0Q_1795172159;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k6Wwa0Q_1795172159 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 20 Nov 2026 18:56:00 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	Guanglei Zhu <zhugl3@xiaopeng.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 0/5] net: wwan: iosm: validate MUX DL lengths and offsets
Date: Fri, 20 Nov 2026 18:55:54 +0800
Message-ID: <20261120105559.54519-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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

The MUX downlink decoders trust several modem supplied lengths and
offsets without bounding them against what actually arrived: the block
size from the transfer descriptor, the ADGH datagram length, the ACBH
block length, the command chain offsets and the declared parameter
length. A truncated or enlarged DL block makes the driver read past the
received data, hand the network stack an undeclared payload, or walk a
command chain that loops or redecodes the same bytes. The aggregated
datagram block path is already covered by commit 526b8ef54668 ("net:
wwan: iosm: bound device offsets in the MUX downlink decoder") and is
not touched here.

This series adds those bounds. No command type, response or protocol
semantics change, so a conforming modem behaves exactly as before. A
parameter too short for the member its command type reads is dropped
with -EMSGSIZE, which also ends an aggregated block at that command.
Patch 4 is the prep change for patch 5; both carry Cc: stable, as patch
5 cannot be backported without patch 4.

cmd_len is not a parameter bound in either path. In an aggregated block
the boundary is next_cmd_index, or the end of the received block for the
last command. In MUX Lite there is one command per skb, so the received
length is already everything that command owns; the flow control decoder
treats a mismatching cmd_len as a legacy device, so the field is a
compatibility flag, not a length bound.

Patch 3 bounds the ACBH command chain by the received length rather
than block_length. Although the structure describes block_length as
the length of the aggregated command block, the uplink encoder
initializes it to the ACBH header size and does not update it as
commands are appended, so it cannot delimit the received command
chain. The field is sanity checked, while first_cmd_index and
next_cmd_index are bounded against skb->len. The walk's
array_index_nospec() call is removed: it bounded a byte offset by
sizeof(struct mux_cmdh), zeroing every legal offset past that size.
The offset indexes no array; array_index_nospec() is kept only for
if_id, an actual array index.

Patch 2 relies on the ADGH header check from patch 1, patch 5 on the
ACBH validation from patch 3 and the parameter pointer from patch 4.
Every commit applies and builds individually, W=1 drivers/net/wwan/iosm/
is clean. Found by reviewing the DL decode path against the MUX protocol
structures, not reproduced on a live modem: reaching it needs a device
that truncates or enlarges its own downlink blocks. The series is based
on net-next at 9068e05d35f3.

Changes in v3:

- Rebase onto net-next (9068e05d35f3) so the series applies on top of
  66974df65a0b ("net: wwan: iosm: drop redundant skb->data check in MUX
  DL decode"). Patch 1 no longer anchors its signature-length check on
  the removed skb->data test; the check now sits directly before the
  signature read. This clears the v2 patchwork context failure at
  iosm_ipc_mux_codec.c:696 and the dependent context-hw gate failure.

- Patch 5 wraps the over-long continuation line in
  ipc_mux_dl_cmd_decode(): param_len now goes on its own line, clearing
  the checkpatch "line length of 82 exceeds 80 columns" warning.

- Cc Guanglei Zhu, whom get_maintainer.pl now lists for this file after
  his review of 66974df65a0b (the v2 cc_maintainers warning).

Changes in v2, all three points from the Sashiko AI review of v1:

- Patch 5 bounds the MUX Lite parameter by the received length alone,
  not by cmd_len: v1 dropped legacy FLOW_CTL (cmd_len 16..19) and
  OPEN_SESSION_RESP (16..27) even when the parameter bytes had arrived,
  defeating the backward compatibility branch in
  ipc_mux_dl_cmds_decode_process() that exists for exactly these (the
  protocol minimum for cmd_len is 0x10).

- Patch 2 rejects adgh_len == packet_offset too: the zero length clone
  reached ipc_wwan_receive(), which reads skb->data[0] without checking
  skb->len. mux_dl_process_dg() already rejects the same case for the
  aggregated path with dl_head_pad_len >= dg_len.

- Patch 4 gains Fixes: 9413491e20e1 and Cc: stable@vger.kernel.org: its
  by-value signature copied all twelve union bytes even for a four byte
  response, and patch 5 bounds the session responses, so the two are
  needed together. A prerequisite itself marked for stable and present
  in the series need not be listed, per stable-kernel-rules.rst.

Patch 1 is unchanged. Patch 3 changes only its changelog and comments.

v2:
https://lore.kernel.org/netdev/20261117173940.34970-1-fangxy@xiaopeng.com/

v1:
https://lore.kernel.org/netdev/20261112125201.1019-1-fangxy@xiaopeng.com/

Fang Xieyan (5):
  net: wwan: iosm: validate the MUX DL block length
  net: wwan: iosm: validate the ADGH datagram length
  net: wwan: iosm: bound the ACBH command chain walk
  net: wwan: iosm: pass the DL command parameter by pointer
  net: wwan: iosm: validate the command parameter length

 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 186 ++++++++++++++++-----
 1 file changed, 141 insertions(+), 45 deletions(-)

-- 
2.50.1

