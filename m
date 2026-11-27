Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795749352;
	b=NKQ5PMPpcx21ZMKI8tg+G0qx4X+zJMNRSnIUmlCZm0qD7FJOjM9gGOCN9/4HwjHZlqIB
	 dgwW+gqBaDBhJ0phC8Vl0TBjqCPhFrCAH2RktZ4FjGqZquQSNT67vC1QOId/xlAJ9+fWh
	 ir6hXIyHuwxvzVNPuWdwEUHdVT3Wm+v0isMucXn9rfq8yW3TCgR84l4jbiSx1PqbBaHP2
	 EUnwp7TWkbI9C+VG0yVlZLfjujWctGG6ylBtzIFgc/94Aw11BjUdIcniao7XoakVzEOmq
	 rLIvX1emCLudKeZPdFyZNuXHr0KmajfJKvwamFhISjjlGcrFnhjTs14+sXFk+Iec+ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795749352;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=axAdrv+zRsPNCPdePNYoKf8dQmnv2l67HHhbrEvN3mM=;
	b=1QWVVq9Qo2onldwiwmWjdPo3nJgJCRprH2X6VzTdYUlvQHtFot9ZOx7PF7hSzRUm0jZP
	 CO5rqy/00hvOK3bnqiSgSzt/PJ8knOkLHKMkpaa8Gn6WwLV0LgJMGTTLF6kVB7EnfPpk/
	 8K2+oIWv10mdPklbS2uP51YBVYlkn9/qKd6CcO6EgMu/1F0afdhjXopeieJW9OH9Sxm7U
	 P/cT4UZ8z95Bh5piiJONiUPO+2W1Ba/BfVwJtwlBHAYvq0Mo1FW88Tq1kzYILjmEYP7wT
	 6FENIVJ7gu8ge0wZ5Hl1AmUu8RP51RjUur7NDCTvkgwVm4HtI0WoZmPPNZEHQ6oZ1NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.org;
	spf=pass smtp.mailfrom=fastmail.org;
	dkim=pass header.d=fastmail.org header.i=@fastmail.org header.a=rsa-sha256 header.s=fm3 header.b=pZvvh0v5;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=c3r4C1mC;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A46606A31E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 03:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3A46606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.org header.i=@fastmail.org header.a=rsa-sha256 header.s=fm3 header.b=pZvvh0v5;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=c3r4C1mC
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id B3F4AEC0994
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 22:15:49 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 26 Nov 2026 22:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1795749349; x=1795835749; bh=axAdrv+zRsPNCPdePNYoK
	f8dQmnv2l67HHhbrEvN3mM=; b=pZvvh0v5wlIEE8WSOqu1zuSsGUyzYxSQ3Gakd
	65St5hijB1u7tvx7AEpBsVsVLJlgN5k7ZQq98qRx/i8o/EZvA859wxBJBXk8p9R5
	RW/GNSXtC8poA1uFDz4dZA89H2lQv/e6JNK5guAk5znzytusoZKE52eyjAsTqZY+
	T0CsEGT5M8M4gxFiARPgNiyE3txaqcN5ka1Yypz4tTszdAuesuPpAjlzYy25AOAP
	2HC//q6/BXs7eWpw0BdfY64HZC+Ciw/QTk71UF/vsljtYFsklKNzCGKXzj43OlF0
	arahmARCHVegWIqXETmk4UB1d2Xv1ZlKXGdTP4jWDicU1P26Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795749349; x=1795835749; bh=axAdrv+zRsPNCPdePNYoKf8dQmnv2l67HHh
	brEvN3mM=; b=c3r4C1mCBAMRBzwnsGgqop5oSfSTTcWY1nhH23f3uuBvjnOgffA
	KNn/GKUnoj4c4r+QpgRTguznEV2tNKssScfEVyIj0e7scY2+xEmCzkX3Ur81hOpi
	mBC0hIbUzoMAiPlRtHpfQ40FSqnKZwO+XBpKl5VCHpLpJmMRglDCpKkHawcugTj7
	hAWyvIg79Tt47B9JRP0DCghdRrO+t3oFPFrSikTJvNZlF1nwQgjsDtPLjSJfwPnX
	UWZgP7Bkfz9sURF70xOehCfKQbrjGVwt7wZchnP0yh5jZylZZkoAkvfVPBo9RQ+5
	hijyK81XwwukBRfKc/GrM3DPDZ5ddl3FS2w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fastmail.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795749349; d=fastmail.org;
	mf=PGljYkBmYXN0bWFpbC5vcmc+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:AQai2C5aEobZSFz7d0Us29zs2eQbvVPtVhtfZ+e5T6pwvng
	4vSsgxLa2bN7RRI8FVv1ROLvK4OFB/IVY5IGpyOCreh9tnAnoza+mwxeCYNSVwsX
	NMMs0TjRj9XZQ59TQMPloqoYySQGXDNNuX/VfNDwqpZ9oqgYzD/HI0rBEP3OXBzL
	eknkdXDEuzd9ltsEThBnVZwmCD2m/WY62wbu+k7MQp5a5PDG7iaC2O41NdWi87+1
	DQ+tCf/dxJiDKn4TqDKbs9oIvOlTLHKKGVF7M+br4ynIUij1+38AUNen4VWS8zX7
	5xDeCG4C1vZRcTi5dvxAlJ5VFztWxcr0obAJMwg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:gPvjH358mXvk557ugfhpaXM9XwLdOdXeLOwXO5ByvJw=:BN6oi1N/O/sumQ9WlAlspdBJzHbYFwJt7MF/04zsLDg=;
X-ME-Sender: <xms:5fUIa5GdJ1x41kWkIjeumVnZ3DuoUrgX0Am6aDAl6rMBAhySTG36BA>
    <xme:5fUIa6Va0rQbrwP98ez-g6ijQLluGabD9R_fojfhXHZfnu4r1M2R92yUhBjdLZtR3
    5GQoImmM1APRswavsYwHvIAD0Rj61YeRX2wzwA0ZgZSRCCgThFMoolU>
X-ME-Received: <xmr:5fUIa9Um4CM2gLiAVc0oqaOeGp45Wa-LPj9cJIRR78C_5W60EEAHcpWYdnSZ-KHT>
X-ME-Proxy-Cause: dmFkZTEVB1K5zqo6vBiwbt1cra3FHQdcsEgfwD7yL4qEf5MM0e6IZAuLjLR3O7T6DsAPX2
    Q0R6c2EJQ4T30hUpoqihRcRTvadrkO5tJ/9tJ6yqlkNTJpGY6a+xRgvC05556UwzMF1WOr
    oKK6DuYPtFF50oPn8lvBN00JhQ3LxpykOvUEaNWOQDK14fH55184OzYc341RMlFZGM+0Ax
    DB2gFABtHYcfLoIeaxrxEx1L4BTXbO2h7HPEesRRklG2fOPx+bVOmNZN46y+Ahg2An3EpJ
    9F7ygFEW/WTIHoLWgXbsTg9tC66OZ1BsO+52huz7h18aOnY/WsDUba9uO1rDJ3HkXd+cM+
    iRQIoBAbGt8kb5GHeMWcR614oEHgkwT4GivW2dg3ya4YN5mQqAoqlPHS/nHdf3MLXpxjgH
    dF0cwYgHKcDNFDFcdt6aTwp1TMrokwOA6fSRJtmETcfpY4sT/afduUAcryqpLk8c/NUT8H
    hUZkHXiX90krVODho5OxfkSweawhPyzbuC7Fs+MI52GBEZSe2/4Ai8iEW0v6ReqL7qQhtb
    aqfcLY2Hg6JWFjIqqIvRfN2LB1CMguV+52sTh0gd14SKvb8cBd2TTGBxUqA3/WdsZKbGgo
    pX3RJ5SKciuZ+fhlhH4tcdgRpY6HQLMjPYbNCEam2RhemjueVnc23dvFBwYw
X-ME-Proxy: <xmx:5fUIawLHY15Y3ELPA961hsPryfX4rE8ZduFdIb-r-1YY-U9GQUS_xg>
    <xmx:5fUIa9BcPY4zL-vdbBPTghTDDKTGArFOsI13_pARU_eI_3Ej3ibKbw>
    <xmx:5fUIawca0K6gXCCdNnWUEOxgXFUua8AHu7j4hg-_g3fljYfNfOvCwQ>
    <xmx:5fUIa82O8feP9iBGYHNJXG3hzbDNAVe6tGty-IRl_O1VTcvJIlrYCg>
    <xmx:5fUIaxOB6cHjyhBFFN9ZrF-7zanf-xnm0Op-8EVWvlAGyroM8tdqeu89>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 22:15:48 -0500 (EST)
From: Ian Bridges <icb@fastmail.org>
To: linkinjeon@kernel.org
Cc: senozhatsky@chromium.org,
	tom@talpey.com,
	chenxiaosong@chenxiaosong.com,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Bridges <icb@fastmail.org>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: fail a non-directory delete-on-close open of a directory
Date: Thu, 26 Nov 2026 21:15:42 -0600
Message-ID: <20261127031542.1542831-1-icb@fastmail.org>
X-Mailer: git-send-email 2.47.3
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

smb2_open() fails an open with FILE_NON_DIRECTORY_FILE when the target
is a directory, unless FILE_DELETE_ON_CLOSE is also set. With both
options the directory opens and is marked delete-on-close. An empty
directory is then removed at close, although the client asked for a
non-directory. A directory that is not empty stays, and the close
still succeeds.

MS-FSA requires STATUS_FILE_IS_A_DIRECTORY for a non-directory open of
the unnamed data stream of a directory, and delete-on-close makes no
difference. Fail that open whatever the other options are. A
delete-on-close open of a named stream of a directory still succeeds
and removes the stream at close.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Bridges <icb@fastmail.org>
---

Tested on ksmbd-for-next 3c31349456c5 with KASAN. An open of a
directory with FILE_NON_DIRECTORY_FILE and FILE_DELETE_ON_CLOSE now
fails with STATUS_FILE_IS_A_DIRECTORY, and the directory stays. Before,
an empty directory was removed at close. A directory that was not empty
stayed, and the close returned STATUS_SUCCESS. A delete-on-close open
of a named stream of a directory still removes the stream.

smbtorture first tries to remove a test directory with such an open. On
the base that open succeeded, so later tests in the same run found the
old directory and failed. Those tests now pass, and each of them gives
the same result on the base when run alone. The other smbtorture
results are the same as on the base.

This patch was developed with LLM assistance.

 fs/smb/server/smb2pdu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 5a7842264b98..28fb77bcd3dc 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4976,7 +4976,8 @@ int smb2_open(struct ksmbd_work *work)
 
 	if (file_present && req->CreateOptions & FILE_NON_DIRECTORY_FILE_LE &&
 	    S_ISDIR(d_inode(path.dentry)->i_mode) &&
-	    !(req->CreateOptions & FILE_DELETE_ON_CLOSE_LE)) {
+	    (!stream_name ||
+	     !(req->CreateOptions & FILE_DELETE_ON_CLOSE_LE))) {
 		ksmbd_debug(SMB, "open() argument is a directory: %s, %x\n",
 			    name, le32_to_cpu(req->CreateOptions));
 		rsp->hdr.Status = STATUS_FILE_IS_A_DIRECTORY;
-- 
2.47.3

