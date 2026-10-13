Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89178414A0C
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 01:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791855352; cv=none; b=fOfXmuY8yIThMisbprcpnxVVLRps54D2hoyKizjDJ+/VltUZ4PZOxuSnmoTzUtdteB/ulmkipUNWyNUbEuvwBs9KAi8Jcv3Dk2/h//RygKFM8rjomfjBqp4Ir2FT4Mpf5Da/4j9HmxNfk7fk9LjUhO310t3Sc3jO54JGhciDyN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791855352; c=relaxed/simple;
	bh=IIVOJsgn1Fzp6J2UaPQgxgn6NYtZB1HT9aJu1pdQroM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shDknkWQD5hQ8yaIgkGW61A/HfTA6d8/HJ/qz+sYEP7PyU+r/GW30EhVEifXsd6YUlPFx1m3ZX1JnRGe7NqYEcC7hlvc+vsUgIKpiAnTpXqD+52cvQj6yusrKrckOtm1B37qTIkU4aqj+4mCvmVunmUxGIR2Jrw4Eq5TjhbYkXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=timdoug.com; spf=pass smtp.mailfrom=timdoug.com; dkim=pass (2048-bit key) header.d=timdoug.com header.i=@timdoug.com header.b=bCHEsw7v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KDUzT5e1; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=timdoug.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timdoug.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timdoug.com header.i=@timdoug.com header.b="bCHEsw7v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KDUzT5e1"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id C426DEC093D
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 21:35:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 12 Oct 2026 21:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=timdoug.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1791855349; x=
	1791941749; bh=ynU+Bv1nkxtpTw5yF1AgPdxSe9NKymP1ojZfCaIJGWg=; b=b
	CHEsw7vaLLJVUH8XekA8hgEtCs3js4FQ5LZGANyllY3HVvthqV/15X4WdRZ6dd+x
	RKZ4HptJljsj9CoknD8RJSAm4ZLK9/C/m1obuWQC7LO1Bt/HgqfF2FR8wzp4Xbg+
	VZ/g/hXoeZ1IcAi0Pv6tFVguBJ0Znmr34HkE82sKZ/3zQaanJldVU/XnAybq4QBb
	3oxwE8PHC0d5lwTrVFSAMyPfKhqMKTGH5B+OtJRn8F3Bl5f/k9FGZHBJGwFxR2FH
	3oySrK3t4Lar4xmz6/MBvPGTywIFCSQdP+7PPtS9RO8pcQJXCut/Whe1kugob+XS
	PqisVpIozH723HtHKEDgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791855349; x=1791941749; bh=y
	nU+Bv1nkxtpTw5yF1AgPdxSe9NKymP1ojZfCaIJGWg=; b=KDUzT5e1uXPYXNSde
	wc0+tVcQDsX/eSNSaarzG/FeMuXyRqBN1z0RHUSeFTfRfYOqxSQPpBWYqx2p6zXq
	C1G132vPiHJ7GUwAQ8X29ISE6UbX/7ZPaWBh0WySDEECcJP+eIPJqA7JDUYb1om+
	FyHmJtxZGq+tS9HkZR/nBZLINSZnj9N5wYiFFcsWiBQH82GZ53LnWhP+/09mn6VA
	MyRI1eHfCwYdqrXx4S0OdhRmH7dGLCEBfN8Juiz69D0xxShjtVx8iT09IgD7u8G4
	l9GPecWx3edDvaqd0vnX2IE+fnrcHAYect4D+yX1+iE709/4GW/LRi2zlG7HtAQM
	b1Z3Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=timdoug.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791855349; d=timdoug.com;
	mf=PG1lQHRpbWRvdWcuY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:g/6gvFqgmwfsMeBbf3CYsFau/Mcm+Fagq3RPu64c2e7sD6R
	abG32Qt/46HcwavV8F/0YgkaCxptW99B8hnDI+IbrIDNweolaX33TxceV3EyBtOH
	mIURnzsf5+19wBiYbIFWaK3xt45NvtsxBVw1vQUmEHO2Bclx4/uDenqcMSqssUo4
	nMkK+ajJK3lmqKDbvIRZ5WK7wUfifHbFSR4NwC70VSw1oUQ9s2sJiBfHZAXk4pmp
	F+QpdBwyugeo04+N9333NzS+iisc/z0nq81yNcUTqhoFIMw3fiI3h1O4r2b1Ylgu
	R8VzChV/o8r+/Jt0P0TSZVg5t1AGZXkRNWZd33w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:UQfw95Fz+iiaKhM4B0x3CiboQNps0uiguSgaWYaEfus=:IIVOJsgn1Fzp6J2UaPQgxgn6NYtZB1HT9aJu1pdQroM=;
X-ME-Sender: <xms:9YrNaonMRSAxG4NW42C6VGKvOsZ_VLvCBMovkGLuqWz2FGLBu1I5eA>
    <xme:9YrNav_9xfoBccUTdcmF998KYas9gDKCnjJf9GfpTzYcUy6KSpmrwA16yZf7x1Iia
    m59KKsSG7JaJ5MWQ3ljI7BuMIsRTg80wLXnlR6ffxvDunKS5ur0qw>
X-ME-Received: <xmr:9YrNamJNLbt15yvhEDa86_QL276vFiL3ayuX0I426bdA_9E2nznQlMEEu4Qq>
X-ME-Proxy-Cause: dmFkZTEs+D062zKm0g1Z6uCgWCfkrFCAifr7RRfExPlp2j9+nb3h4r6gXg5CPa1Hy28Gb3
    jjDLtlUgehkFGvKDjacNQVtZmY23pAF2FYbp1x1/5WsfXHbMKYRnZ+oQxz1fhwjXas6rKu
    O3Nic0YZYD3FpXcovN1s3R7DDK+4Hj1a5uljDvBzZS+QeauDTrkmI+gPO2CmEBM6fWNjv8
    Djeb8EpppwYC7edHx9ftnnCjzX5VJXWtrTADVNS4avcixVuC0kwn7oOy4yRPpbQ4M0xpTk
    MmxPAM3Unja5wAJOz1sQKNPVQ6CUgMoR1EdLi6JhrBSuMn5LiWNNsi4Kz8D85j94CaW+C/
    zfQRUKnl+FFLPQYZ0KHet3ZLw5lvm+8hadwApEPbAsd/FzVn0J9saV93O2FZ9gZR451E6I
    nZchxAfQzUh3qnVemeWmPsiENbHKF21Eb/qfgIxiBPg8bds6sEdtE0HUmvmUaDC5wCqnxy
    1sdDDtGv0+Qp4GNLcTSWa/KHUOFPqBBaND/STNL21IrhDAXDD4JLid5BjKwEDfGY1uTByL
    s6zzICKIWoTuFatUM0KWEpZOgQq/fXgs92TvsQdIjjpMIwHeS+aEWmf/G5VDReVWQPROdh
    miG9Pup4vaD8yvW1KPm+TL9SMcI1pAkQ2GZtFtQTyhCCkT7ivz81YQzeFN8A
X-ME-Proxy: <xmx:9YrNakh9kgryqBTLfSijKIwWI-VIkZ16k7U0KC6keeKB1kKNa8OmWA>
    <xmx:9YrNai8pPoij5JEzMsrkTeHuX7HaIvD2tJ3wYYkyWPzzEa1-mWZjFA>
    <xmx:9YrNapNiOfpLeyXP2WOjceAY0OMWwJIkgEkAyISP9wzWRwVNUipP1Q>
    <xmx:9YrNamAVbQtRO5jiOXzcu9Ww3Dv3xRwUdtb3ZdfkdeI7yg5qnRULXw>
    <xmx:9YrNarPlmUz_4Gpz5l1mMHBmOA27ju6S51F9TJzRFo1AxHdEYJlzf1Ek>
Feedback-ID: i12bc4175:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 21:35:48 -0400 (EDT)
From: Tim Douglas <me@timdoug.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	Tim Douglas <me@timdoug.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] serial: pmac_zilog: push received data to the port that received it
Date: Mon, 12 Oct 2026 21:35:40 -0400
Message-ID: <20261013013541.4535-2-me@timdoug.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261013013541.4535-1-me@timdoug.com>
References: <20261013013541.4535-1-me@timdoug.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pmz_interrupt() drains both channels but, since commit 2e124b4a390c
("TTY: switch tty_flip_buffer_push"), pushes the flip buffer of the
port whose handler is running rather than the port that was drained.
With both ports open, data received on the other port can be left in
its flip buffer until something else pushes it, so its reader may not
see it.

Fixes: 2e124b4a390c ("TTY: switch tty_flip_buffer_push")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Tim Douglas <me@timdoug.com>
---
 drivers/tty/serial/pmac_zilog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index e3a9193..f49d605 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -444,7 +444,7 @@ static irqreturn_t pmz_interrupt(int irq, void *dev_id)
  skip_a:
 	uart_port_unlock(&uap_a->port);
 	if (push)
-		tty_flip_buffer_push(&uap->port.state->port);
+		tty_flip_buffer_push(&uap_a->port.state->port);
 
 	if (!uap_b)
 		goto out;
@@ -469,7 +469,7 @@ static irqreturn_t pmz_interrupt(int irq, void *dev_id)
  skip_b:
 	uart_port_unlock(&uap_b->port);
 	if (push)
-		tty_flip_buffer_push(&uap->port.state->port);
+		tty_flip_buffer_push(&uap_b->port.state->port);
 
  out:
 	return rc;
-- 
2.54.0 (Apple Git-157)

