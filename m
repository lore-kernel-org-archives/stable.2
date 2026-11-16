Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866947;
	b=5gXKwJatX3ampyC8bxYvsIimqIK0DtYiiUAAsuXrNC6NO3XAigHfZdEiz6IVEDaHMvis
	 sjDQdaTb80X9CB4zz5oF4AFD64oPdDwHPr7PinjokDk6nAG0SrZJxfChOibMBVmdatPe2
	 ilAG6ZIQNFXH7ALiTPk4PL0Cy8aLp4HR9kR4yg/XnjEOS0XuRqQVI5UETtjSSCZYTsNS9
	 e0Oy2DhsC/lJoyrcdB+kS/7HYFSkPzfzYyXlJrpeGpQCI6xbDVVU/t/uoD6SaVMhPt1fv
	 0KjUQB74zO/Mmc9P/jnSgmEkbJyXk9utHiYT3qJMaodVMDxpkWBwNraOvttLC4JGBRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866947;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=1S2JG0K8dQlVY7uMvfgeH0EUxwYxdfh4NPdqZIEsOw8=;
	b=C6WRoopyuZqGgTwt0s7TTWhU1Ux1jpGNb7AbEx1nMxn/Oay+XVoO/srODG2BlEMloqSN
	 NyWyAB3qDB0sMLBTWgr+U0LjPrGW/7B2sgBhY2j0W/12UGCWxYumUvaTjpsYXV7lMrPEv
	 7Ar4rWIMHNiSuX1y5KJhm2X5xm4CABBly/NQWHrcs7lYl+4GuIwwp/VIwMrxRT4nLbuNy
	 8HjfNhFLhrdm9Yqc01wUfym6mvFCQPHXo4/EBJV335v83ZTpjRflr2W2s2L93n0PFPkuf
	 Chw/AlHCaSYtuR3oTQKqFkhKKQfnXvtrsqqSrxHvWWrzjSq0DDfCaneMWMLfhxGHTng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gzdAzHls;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3242E606A887;
	Mon, 16 Nov 2026 22:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gzdAzHls
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6651F000C4;
	Mon, 16 Nov 2026 22:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794866946;
	bh=1S2JG0K8dQlVY7uMvfgeH0EUxwYxdfh4NPdqZIEsOw8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gzdAzHlst/oVpS2s52CTsRAoa5D07MLUNCHLzFdWrKucjLubUDdeskYoYJURjWazw
	 L3boWOY4zd7fFouLxIG3xRnJ2N4puO/xi682567esA27euPBYW22iTr/YvOBd4NMLF
	 AQEF9jHvz7PDJNynNyLtb2Go3K7DqFaA8xfaM1m0z6FwEmH/ltJ2dU8o+9wjqG72Az
	 95kjOaC4dVv3Y5F5II7wLilSvp0MsUDZw+qR/OaZLwd0y8WEic8vhLrsdyHvQDmjUC
	 a12wEPm4OjK1+49nAUNSfIC0qazDuSCMSe0G+pR18OBL2kg5elzOIR/qPV5Er5RGYg
	 zr/6KOnDtqrmA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 16 Nov 2026 23:06:14 +0100
Subject: [PATCH net 7/7] mptcp: fix dummy mapping of overlapping segments
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
Message-Id: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-7-bf7656de653e@kernel.org>
References: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-0-bf7656de653e@kernel.org>
In-Reply-To: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-0-bf7656de653e@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
 Dmytro Shytyi <dmytro@shytyi.net>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3846; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=cZPOlHWTnOxbxMx5o66RJt82bkh/T4a/OuHPb6biV0g=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJ+170K8mA6VbLamnGrkQnDZYE/W5XW5nOwv1204/F3z
 nleU9cc7ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjITT6GPxxS+TPv8658373f
 s7DLK7H33yHuD/zsy8/pemYsmtfQMZ/hv9faeRss84vu7j28jMdT9fpGjTCXtg22infvM607sqL
 pLBcA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

An MPTCP socket that has fallen back to TCP can silently lose received
data if a segment partly overlaps data received earlier, and recv() then
blocks, returning neither later data nor end of file.

After a fallback, subflow_check_data_avail() makes up a dummy mapping
for the skb at the head of the subflow's receive queue, in which map_seq
and map_subflow_seq must describe the same byte. But since commit
2834f8edd74d ("mptcp: cleanup fallback dummy mapping generation"), it
computes map_seq from the first byte of the skb, while map_subflow_seq
is still computed from copied_seq, the next unread byte.
mptcp_subflow_get_mapped_dsn() then returns the data sequence number
(DSN) of the first byte of the skb, instead of the one of copied_seq.

These two bytes differ for a segment that starts before rcv_nxt and ends
after it, since TCP does not trim it. mptcp_init_skb() then gives the
new bytes of this skb a DSN that is too low, and __mptcp_move_skb()
skips some of them as old data, leaving a hole in the stream:

    bytes 0 to 999 are received, the skb holds bytes 900 to 1499
      byte 1000 gets the DSN of byte 900: too low by the 100 old bytes
        that is 100 below ack_seq, the next DSN that MPTCP expects
          __mptcp_move_skb() skips bytes 1000 to 1099 as old data
            ack_seq is the DSN of byte 1400, copied_seq is byte 1500
              later data starts at the DSN of byte 1500: out of order
                the TCP FIN becomes a dummy DATA_FIN after the last byte
                  ack_seq does not reach it, so there is no end of file

Fix this by computing map_subflow_seq from the first byte of the skb as
well: mptcp_subflow_get_mapped_dsn() then returns the DSN of copied_seq.

Chris Mason sent the same fix in private, and found this issue with the
help of an LLM. It has been reproduced in a VM, with the reproducer he
shared, and with a new Packetdrill test: after a fallback to TCP, a
segment overlapping data already received is injected. Without this
patch, the new bytes at the beginning of this segment were lost, and the
connection stalled, with no end of file:

  reader   30.64: conn 1 BREAK: at my offset 1000 the bytes claim offset 1100: A GAP OF 100 BYTES
  reader   30.64: READ-TOTAL conn 1 outcome iii-gap-or-repeat bytes 1400 of 2500 [...]
  [...] end: hang: no data and no end of file for 30 s

And with the Packetdrill test:

  dss_fallback_overlap_client.pkt:24: runtime error in read call: Expected result 2500 but got 1400 with errno 115 (Operation now in progress)

Fixes: 2834f8edd74d ("mptcp: cleanup fallback dummy mapping generation")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/4c48d016490d43b6892c622cbae858b48f176cff.1794304840.git.tanggeliang@kylinos.cn [1]
Co-developed-by: Chris Mason <mason@kernel.org>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
[ Combine the commit messages of Geliang's [1] and Chris's versions.
  Commit message: how the issue was found, and its symptoms. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 00677fb3efcd..6f07544bfe40 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1496,7 +1496,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	skb = skb_peek(&ssk->sk_receive_queue);
 	subflow->map_valid = 1;
 	subflow->map_data_len = skb->len;
-	subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
+	subflow->map_subflow_seq = TCP_SKB_CB(skb)->seq - subflow->ssn_offset;
 	subflow->map_seq = __mptcp_expand_seq(subflow->map_seq,
 					      subflow->iasn +
 					      TCP_SKB_CB(skb)->seq -

-- 
2.55.0

