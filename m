Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337908;
	b=M50bH+j4izJuDDV5RYsvFHUJyW+ClG9znH2qXnHb8npP3JT9bE1YcrIPi+hiUbTFr4Ls
	 U/VHLCJ0CqnrvucH52euDjFBRZVCDz2T1qxa/AP4kIhL2FcLVSGi0HbYulAmu7SuE2bNm
	 MguQzFpFVLc8IaXpAnM33yUrxxJEfcXqdDFULeDQ+lDqOsRPX2UF8eHwlfx9wINcuU+4U
	 mds+FZk3diuvg4d8EMwo928ywzLcPoGrN2LLHcOhG3wrnr6P1U33kSxAjL4DtJ52WnSCG
	 2kLGF5r+7kjzYXDOkW2jwb2DWwXCXXA0o2wS/W56L09S1nKdvzYII1scZcDIUfbb0bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337908;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=b/G+C5BvAeW0sjKI5sBVcF4d6h0uLb0oMObYeFYPN4Q=;
	b=TOSRr5x+2yMeiY+JchSYR+lHpuSut+Arh67bkJw11vy6p9wgcaU97nYQYCv6lYiSrG9o
	 f+7GiuwrF92chXoerF1VHpn3UVLzyFyEkW32tYNs2K0R6ZOPjGNCbF3UntShViT2aRdvf
	 qioakdjYnDD51V/Xz6GeTjfhym94R6Pq1mGedaeAdALG7mrBpM9b5vnVmNlozu96bdOEy
	 r9PO80FddxgT3N9tyVqHmbXu3+j49ZzgGO3GuNPATaesdvlDT2s8zkHJ+1oCC+pcV8oPh
	 Hnl8Yu4bmypIC6AV928g/1ZNeVw5AuU8jLU6GkMiCIjGVumRwBMzkGtX9LWz4ISjKHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=mRsRefxt;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Q9HBUGh6;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54D1606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B54D1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=mRsRefxt;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Q9HBUGh6
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id DED79EC06A2
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:11:46 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 10 Nov 2026 14:11:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794337906; x=
	1794424306; bh=b/G+C5BvAeW0sjKI5sBVcF4d6h0uLb0oMObYeFYPN4Q=; b=m
	RsRefxtt59R2mEfbMQ7ejdqijeGsgTbyO+H4LKm8C+bLWTiInhox45GIDgFzpgDI
	Wx6/oAAMsht5QYF2eaHap55igMRZYBz7Z/eIzkohFMUVDs5NjsJ7UR9M4hNiKyFB
	gP/pJCGOrLQwhyyojSQnC1BElY3aa6nL1jv6ulDlc5cnk9gW5ioeeadpuQ1N2Ytk
	n1HUt5fnDGkXZclB1ikEKZ0luzoXoPSFwNEZBiiMCI9et8vdiNIRBlJZzl0DB9OD
	hAvYzK2JKSUMschW3sjSI2r4Qx2og0B2q/HgodAPGUNUDgHgGa5dMF5X4LOpg/uu
	k5ilPObVEnEVi3kYllBZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794337906; x=1794424306; bh=b
	/G+C5BvAeW0sjKI5sBVcF4d6h0uLb0oMObYeFYPN4Q=; b=Q9HBUGh6hHrRR98v8
	rdU/jf380XreqMsuv3PNZhwVCCA8daFL7/46bJdVc5V3kAAbNLQB+eiRXwNnJ6uu
	FWkxmQVzB+4mfLBiEQBfmKZCF5g76aYL1HzPvXkPlZymWvzp3llvqNwWiG3githc
	FKXc4e6RWnj8n1+5gOIH3wwYR+sDf2L1qc7ggbTluezJb7LyjW/boyckYvBW7BYZ
	TW+XcStPdJ4sPxTR0XnBk3ve7lqju7vtA9jYP8JfE7Ni7EILuVfcaSy4/1efbEKo
	2+grCZb+NzDJNi/ZRLgMKdF24/4l0Ht7sxYbekSDCZb8Llg1OBTk611ei+GeyfRI
	JOnVw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794337906; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:J06mNsvrjV0R8RF51t1TNQ/2JSYNOP0gDVDtQR5C0mx2OEj
	fJHOMguFr8z6YXn2xUXAF7wW7UMvngQUIMZ+cQ91mYyqP8mVrS1BRiRmxwzZHTuB
	YB1rrBkyaqQstjexi04fO60yldQJns4JOcdTos6JnjuvSurZRTsraYh0WBxhgMAg
	/fCSn9jNlzxMH5WK+47MUcWozRg3v8gpY4nVJjrnAW3l6d5oMaRJuD/TbOSyXBYk
	bxCEoiwkNWyEWxDOUm/hXxEzEq3dj9eazunT2nT4q6KXtsezdaFWVCCOPpVi9e8I
	1gLw+R+z77DOpSnulC0B3OxoDRoctA0VuTMqXww==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:RJGuL5nK5RDUu89EQVGb8Eoai1ODxCzyzUZTrr4JsO0=:JEAffmqDnSG1zfegyHrDWrDqon9U5odxNaiFuVQP4CU=;
X-ME-Sender: <xms:cmzzaui-gAlI-5mZDbNS2cHKFRiiO2x5pLkTDnJWVxtpfj1WnRYFGg>
    <xme:cmzzalBYyb2OVWHeSwSbRrdipktalRFI7wGXstF09rnEnK-YMQtSSQp4Febxi6PeH
    IUKAOkZo0OF_KJE1cx0D6IyaFrH3QpMWoMrUkhGxW5Lnt0KRifg9-7N>
X-ME-Received: <xmr:cmzzajtwG7Ik0dCBcw6mPJShE7x_3fIZVMB8YQP3cDnl7cIK_-doF4gfAlroBE45zUx4Nmg>
X-ME-Proxy-Cause: dmFkZTEu9BqDtNH88eLZ+S8C5IYoX51v3p1TQB7sMGS0s/AXW/6Mp7qcLhxEuxj8b2Llo8
    oqfr8kgEgX4zVOHIe/M/BkRQ0mQK4aGxEIm+bHuzUJSWgY9Zrmop5IyPeTyaBUPVGeJSiS
    2KGNnnNnVcE6rfy1uqT1FNPEZ8nAvP7YwqVYtiWGvdMfrHbU7aXfNPULbwHPQ/f0fB/XNj
    bjTPa9upP+sLpukeD+yylxx/nvf8cYMui4+rpu/NboVBopNZ1ww5JLLBP/O4AXCUwtOpN+
    q1ztUB4zc8rCPIyKVW6eM6PyqvVJtcWxMFuOpvRVm4s/weTlUTzJG4ae5yARKrvDHqckR5
    BHswUOp3tDPvwbVb3frFkvpcFi9a6knmaFanfDkVF3PgDc/JE/SEVktVQGh/NatjV8NZ1g
    GQdnRNxWiPJGXXH50A9AfqwGf1vCMIm7tyUWRpqqLYRduti0M+K4Kv3m83LMQ+9SnwH8jo
    wM2uvKnP557KEnhAeJGfNBHv24z+GYIcfXRzoLEnJirQ/1ZpV6MnB9SJQiL2IPI/i1SERB
    bQMMkOcWr6HBCdI1AIdiJTF+w5UIf2TAITu0z7GVxO3r7bc6U3LGhEx/nacbzF+v2nOxsh
    BKSTUDJXwZLPcVkcx1Rkti8TfYCfnJoAEf10OMpj1uUiypFgGDdDBaEwoWCA
X-ME-Proxy: <xmx:cmzzaiYUwkQLw09Z2Lctmt-VEhJKSMYzw9oXd05g4T6WBC6MPGE1ug>
    <xmx:cmzzauU1ixURePt56LSbU-IF8M0uVDJKtaj8zOvQ21W-9_2FPhv0KQ>
    <xmx:cmzzau6bZSFbPCVX3gLysnZS53vn7_M1LgGYtYprt4jr0PZdHGgzDA>
    <xmx:cmzzahjrV4GRMeXBoaNeYc0kAjYy1fgdpgw5fPJbwa_BvjNgG4aHLQ>
    <xmx:cmzzavBMKrHfkZtpAZWPrvmpf1HGKHqO0hmQG-twzMNuqA9xz1-OUgHs>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 14:11:46 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.10.y v3 0/3] Bluetooth: L2CAP: signalling response fixes
Date: Tue, 10 Nov 2026 14:11:23 -0500
Message-ID: <20261110191136.1748573-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107062323-failed-5.10-6320736af7dc@kernel.org>
References: <20261107062323-failed-5.10-6320736af7dc@kernel.org>
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

which failed to apply to the 5.10-stable tree:

  https://lore.kernel.org/stable/20261107062323-failed-5.10-6320736af7dc@kernel.org/
  https://lore.kernel.org/stable/20261107062326-failed-5.10-a518b9a9ef6e@kernel.org/

Patch 3 is a9f9eeb5344f ("Bluetooth: L2CAP: Ignore connection responses
with wrong ident"), which tightens the check added by patch 2 and only
applies on top of it.

The series goes on top of the three L2CAP patches already queued for
5.10.y:

  c1398cf11b31 ("Bluetooth: L2CAP: Reject mode changes on connected channels")
  c5ebb0245fe9 ("Bluetooth: L2CAP: Reject invalid TxWindow in configuration requests")
  226fa3b676cb ("Bluetooth: L2CAP: Use default TxWindow for zero socket option")

5.10.y still has AMP and A2MP, which upstream removed in e7b02296fb40
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
  https://lore.kernel.org/stable/2026-11-08-1-daily-reply-0004-l2cap-a2mp-5-10@kernel.org/

v2: https://lore.kernel.org/stable/20261109020039.3035406-1-oss@fourdim.xyz/
v1: https://lore.kernel.org/stable/20261108000617.1969616-1-oss@fourdim.xyz/

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

