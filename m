Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337882;
	b=03R8ZBwwvpKlWCcF4D+JjLm9f31B955UIjIOiE0tG+daQxB6t5NsRP/Pi7GR3656LTzv
	 8feraDvdz5WjTFUqCXq2CWOslEmI543DcaXltbQqv0hK0EzTwzVjjuuPmDihLiRKDQ17O
	 3A46MAxuMpHQSisiAibTfItww1MfVSyRUzJOcSZfkjMcYv0DuLpBwbf54RpScWydgW2dj
	 CT1OFsIhPvzfrU7cQMCcd3s1t/3Qz6CJFdce8FvEmdmmdhb3bfZ5H9ucVsM67wUuYom/J
	 ZD7JPW+nNhpfieXIudno4Uovl0hFS0T0DuqKFjW4dv9gaFA+7HQ/OaakQtmpqYn6XCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337882;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=sHsQ3qLswmfivBErON5DJnbJhLOdQU4tFwJN4Yg+YSo=;
	b=Z8ZOdWH7FSJwZ7xzxFNRgbIsMlyrPZMyg27zWYlCmnKZXzah8/TShY672UyrWpkXamNA
	 U6s8XnCjIaSaKJRC8JIJfBFUknxRP25JVB3nir80Oni0gnLmL6vMdJsZlMaDMkNYDLnxr
	 JrfynpGr2LSyhXRTischNZ+MRJ+foIaZ0C92QQdRU4kwy6ays1BIcAr1oo/5tX2b1jdQU
	 VV24VsuBF/bUvBrsnu8S63QG5+2/pb+xD5/t2Sc0UKSk2koy14Q7dPSUF5IXg/GFLPB+X
	 TBn+vCh40dZuefRmureMiIjM5UR6aveeyDGgvX39MwkdqSaSPI3WL3vzToJLIRh6rjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=UDE1mQjg;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1ZIpGJyg;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD04606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAD04606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=UDE1mQjg;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1ZIpGJyg
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D550A140012C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:11:20 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 10 Nov 2026 14:11:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794337880; x=
	1794424280; bh=sHsQ3qLswmfivBErON5DJnbJhLOdQU4tFwJN4Yg+YSo=; b=U
	DE1mQjgA3sV/aWUPr/KR9SdLg/JbwvBnO3vN4eWpE2eQfHh/UeOUAmJgJhwb631U
	xwsJ94L7v6ECV5nv87nbrWcmwrmcVUENGTL7zJajV/syammEC2e9WI+7R6Os899S
	f9plD7iWCISnJd1f6Wh9lY+nVOdECLiph8iK9vWzb1eDrmYQmm7rkO9THajsGt3T
	fCNekuSMHlx7FiD89yYqOqrwQOk2A6kBlB7x47cuAyvk52mjFTdWVJ1REdN9XWqD
	p2fmE79/xtpIlvOrbzfH1ngl0qdCLNK+/w0sX8sA717awfYm2kDV+rX0mQRYw5Mz
	wadAREhBKdDUm+DErkpJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794337880; x=1794424280; bh=s
	HsQ3qLswmfivBErON5DJnbJhLOdQU4tFwJN4Yg+YSo=; b=1ZIpGJygaCqkd/JoH
	pImv5VdYXDW2GSa6/0JU/ducnF4DNm+GK2LBV2U9GxEGne9+HRnCeiKcZ7+stOUb
	pwcQRloRE8KM2Xuc14uM5Aqser1+w/rOfMETr7XhAh9Xx8UlhkQLXtXYm5vS4Dp3
	8PAJqnwZnxD9x0HT0Rx5hBvTbYsQS9vK4nbAgY1z4TiCoVWdo6wCilyG+onC3BjE
	PhJ/8kzNDdJvle5PuqnJCgJvsQsexzFmYYOldYaEoCW4a+GzL4rznsBkuXIJ/Se3
	azPEV19Ti+1CL5JqSwLfNT3Z68de/TQaO4I+FTeNYeQ5ivuhwQIjsJ/upe4yuZIr
	oFk2Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794337880; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:lDJnijlrvbHSUw/ymvNWzJfRzLWtby+h4VsGmv22IekuO/G
	aJ1dQeqaLZAkIIbD2Vf8wYZ5ENIc3qEAhzk1nkLg0PlzetWhB+JAb4fYtT4MTMdP
	4Kr3P1uA2kHopSMBn1Ow3BMzI+1E3tiRKe5ciLzIollyFDorqRTPFYobogzk5Khh
	g4YUeVwnk3mQUKm8cUUnfZMccOwLfVnH2UAAtFBbmHtWEiKqFUZx3S8diBO0x740
	Q0lXH1yBiqu1jAumgfrZTT4ND8YWF7FbEkLunQiJ/E7sCigowpwePHOKKurCfq7H
	Pvn33uHu7DOSAiVFlDnyoBxd68P4B5YcP7wVHVQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:zw5/8791dUR3nOT3h0eAYCLzVZBqOt5v+GGap4lxa8o=:juPyU7CnXuaMgULhYnTBCSZlxlqG9YQU2H2qANxqWxU=;
X-ME-Sender: <xms:WGzzaniQB5wXqFCtrJhoUSPKE0h5bIPEp2Z5Em-NT3viNHu4WnBL1g>
    <xme:WGzzaqDyN1KwbgE2TylcNSJeM-N0QdqNRE9wnLVNL_MR6zzsCudCHkpRBNzMok-D2
    SknkaqRf5gtWx1hmz1eaw8eoPpetebrMhXsNPE7DC771RHZJcpIBbzx>
X-ME-Received: <xmr:WGzzaksEl-WAP2nVVzJx9mvsDwndWvrAHM2qAar9h9aDwZnJxWxmxEZnfgKz8gF_i1JX-Xc>
X-ME-Proxy-Cause: dmFkZTF6g3OKTu9bmuykajJtT5GgxaU5t37f15cAatcYA61qhwtOFXktfE5PEf8GNbAts/
    LzG0Di3rxgfD0YFcr858wOKsDGKfn0LU8S9v2Ly3d2I0u1G8myBJvsXKuwU7CAW8ZGMJQN
    9FLPlPXZF2KXtaHhFTY+4B5eJylexix4DFZKy5TK9FmCzCfy+SJC6HopYXUKcs/+3bJ9vy
    gK1EhT1BKCqr7z7uDPw99BqXxWnwyIUJFOzccMvZvfRmgW/qpz8oOJWuuR78bYrBwcuV4X
    Gaqa9xKwJWu2A5RwHssqixKQ6AraAJYMTCVUX5zVofgmegWvsrmoLPLCFfF2rzpEiBqLIX
    hH3cXGWVnCNqTgCpWvYJGb5QtyNpx823bIMQ8ZwJfKyDa/t76l7SDDk/6LO/bRRcdBHfj5
    L8CQrwXmjB+W0LYC6sSHMyT54uhgKGJXJ7uITsbJXnXLDMPrfoupcqx2m+FLrcCZ35PrMj
    h4yVaPp9pEUZVj8FOnty5GXwd3PWkZcjMHBPfAbh9GtA+UFRY5P66O2s03C80NZM6Hxlj5
    GTcMRMSp0DsMtiKLFFu6Ds/kevBlWZoavv/wiGzZdOYVhaYu57eSLlkA4oqfJ+5/mEFEw/
    HZxasOmwar5vaxy53nDDOIGqIf4TIjLb+G3v8cwM0/IakCZXLm3FccHUQy7g
X-ME-Proxy: <xmx:WGzzavZ-JpYQ0kjYZVfY5bKUhEqtCUFbm4N1K90eVdKUEXYO_Ql9HQ>
    <xmx:WGzzanWQA82hvKx7TxQGC-a35MJ3J5P4VR_6cHrEv7Ph4LzIpPx1vg>
    <xmx:WGzzaj6Lwb32hvyXg6tTf-NrEYBe2F0Ca7G4xPNkXpowMbBqA4-jJQ>
    <xmx:WGzzaiiwPqueVgsOFvvxmC4NYOAdn-iofZtc7VTkgt-uGI95zvCtcw>
    <xmx:WGzzaoCt_Rois1sWBYlNCYDQOqZ6bUi7LDa4A1uYF_lWrOc1VX7jsFU3>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 14:11:20 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.15.y v3 0/3] Bluetooth: L2CAP: signalling response fixes
Date: Tue, 10 Nov 2026 14:10:49 -0500
Message-ID: <20261110191058.1747963-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107060628-failed-5.15-6320736af7dc@kernel.org>
References: <20261107060628-failed-5.15-6320736af7dc@kernel.org>
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

Backports of

  6320736af7dc ("Bluetooth: L2CAP: Reject signalling responses in invalid states")
  a518b9a9ef6e ("Bluetooth: L2CAP: Only accept connection responses to outstanding requests")

which failed to apply to the 5.15-stable tree:

  https://lore.kernel.org/stable/20261107060628-failed-5.15-6320736af7dc@kernel.org/
  https://lore.kernel.org/stable/20261107060634-failed-5.15-a518b9a9ef6e@kernel.org/

Patch 3 is a9f9eeb5344f ("Bluetooth: L2CAP: Ignore connection responses
with wrong ident"), which tightens the check added by patch 2 and only
applies on top of it.

The series goes on top of the three L2CAP patches already queued for
5.15.y:

  c1398cf11b31 ("Bluetooth: L2CAP: Reject mode changes on connected channels")
  c5ebb0245fe9 ("Bluetooth: L2CAP: Reject invalid TxWindow in configuration requests")
  226fa3b676cb ("Bluetooth: L2CAP: Use default TxWindow for zero socket option")

5.15.y still has AMP and A2MP, which upstream removed in e7b02296fb40
("Bluetooth: Remove BT_HS"). This version leaves that code alone, so
the patches only carry the upstream changes, with context adjusted as
described at the top of each commit message. The changes are the same
as in the 6.1.y and 6.6.y backports.

One side effect on AMP: the response to an L2CAP Create Channel
Request also goes through l2cap_connect_create_rsp(), but
l2cap_send_create_chan_req() does not set CONF_CONNECT_PEND. Patch 2
therefore ignores that response, and an outgoing channel can no longer
be set up over an AMP controller.

Changes in v3:
- Drop the AMP and A2MP changes from all three patches. They are not
  upstream and did not get the maintainer ack asked for in the v2
  review.
  https://lore.kernel.org/stable/2026-11-09-1-daily-reply-0038-bt-l2cap-v2@kernel.org/

Changes in v2:
- Patch 2: a2mp_discover_rsp() now pulls the payload of an unsolicited
  Discover Response before returning, so a2mp_chan_recv_cb() does not
  parse it as the next A2MP command header. Dropped again in v3 with
  the other AMP changes.
  https://lore.kernel.org/stable/2026-11-08-1-daily-reply-0003-l2cap-a2mp-5-15@kernel.org/

v2: https://lore.kernel.org/stable/20261109015902.3034747-1-oss@fourdim.xyz/
v1: https://lore.kernel.org/stable/20261108000542.1969015-1-oss@fourdim.xyz/

Jinwang Li (1):
  Bluetooth: L2CAP: Ignore connection responses with wrong ident

Siwei Zhang (2):
  Bluetooth: L2CAP: Reject signalling responses in invalid states
  Bluetooth: L2CAP: Only accept connection responses to outstanding
    requests

 net/bluetooth/l2cap_core.c | 47 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

-- 
2.56.0

