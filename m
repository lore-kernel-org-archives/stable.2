Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508575;
	b=Omf/GyDGcqSNntfmb698NCYTLllhXE3Q8CHc/MlUdt3XUB9YwzigR3viqfOyz1zOwNEK
	 cElgTKbGTNfRdx88sMdf8Z26MNsVtZTtDYPXjNoFdK8JHnfuEQRQNahOD7o3imJ7I4DMY
	 7wMEEYumrHUb8a7c7EpqoQvLpQA+fPVEjlDwgsOqN4kwVgQZhDvQ7lVwA0u4VbIk4mt9T
	 AoH1VX+BvyP/M0GkkJqS332SLII2v5Df/cpB8AjmEGkiMZbrC9Jw4x6JoBmGO+VFwK1YD
	 J5Pivbc2zcUTb04iWXz9uxHhCnOsy82m4WHSUSZxTmuvMM82AKTVzu6BJzbefIIY5ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508575;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h/x7lLLMUI4IgZrRNq/jXPBRLVQnIUctIa1/ZHhnXT0=;
	b=Gg1LtACnmH+Mz0vDiiLjg+tuPLau6KmXqXH1US9Gqd9XjkiS5ykYqdjadzV4GNY3YdBL
	 SQwuAkV4ka++Bl+ymwgIcVRr+97bPkctVxXQWfD3xxYIOgmDza0Z1gb/0crexAThJCDdg
	 0rG4pbPiV6HcSm0NcTSHiLYfUF9s65hefvWivxjTr9A5sNWwN4A7IWB7kwG8NHYE9slbB
	 WT3fllZflkNJHHnBuiX8dzP3td6kNBd5t+mkFKoH0qPwtrY1/tM63C6umRcLEGid7UTlL
	 lUJ8s9U1rJhb+Sr4/Y/51XRBrgygWlWLjlQsbLszuAuFJ7Sse4nF4722egBYUhE9qOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.org;
	spf=pass smtp.mailfrom=fastmail.org;
	dkim=pass header.d=fastmail.org header.i=@fastmail.org header.a=rsa-sha256 header.s=fm3 header.b=d4wYVUEu;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TqtoVI5S;
	arc=none smtp.remote-ip=103.168.172.138
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434E3606A32E
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 18:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 434E3606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.org header.i=@fastmail.org header.a=rsa-sha256 header.s=fm3 header.b=d4wYVUEu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TqtoVI5S
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 4868B1381C51
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 13:36:13 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 12 Nov 2026 13:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1794508573; x=1794515773; bh=h/x7lLLMUI4IgZrRNq/jX
	PBRLVQnIUctIa1/ZHhnXT0=; b=d4wYVUEubxKK4b4LpE7LXzsukyFjEN9A3mrYc
	llUrK+pA6axbuzPQo60L7YUJk7+OCatUZAnRgYRyg91SSgW5yeAmeGVaNm8jYZSE
	vBTk3zpaBazD6znDbqwVpMPsW/40jlOypkBJy50tKorITYPWcTIE4fOrddKZHvdT
	hB2WtRl0PSTE/RULEte9WV4tY6cvVHGtcYj8a5LO5qMh/TWph6Cbqvk3No1vjaF3
	YMjJ5yKMZ6DwmTe0Exysm/DfDrnJ/3T5h5G1z4jF36Ry5yZahxsqF9OsJftPVsOl
	EVYgm+OGtnO+74iqK6ZremTx1LkCGbg9O5TtWAkmuFrX6rY6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794508573; x=1794515773; bh=h/x7lLLMUI4IgZrRNq/jXPBRLVQnIUctIa1
	/ZHhnXT0=; b=TqtoVI5SFh9twXjfJY4oDbas6wwfwx1jm11JPycu8n2Cpw1xV87
	Vke6D/rsl9qKnVrroAqTy5gdQEfAMq9oKCavbSsMiEclew1HWPChRwsaiivpmRe0
	pbiLdk5vZOL+1j9uh8tYPHITDkiQBmtQDrISDCF53iTL/dPOX9yec0lSEq1VFYB8
	z7pkMCLz4OIciIJqU0RLUx3VpfiYNmhs1MrFtACHLLhkp4IErfOrBQNU9ceEIKJB
	9eB/0ZOwccsCBsnQGXFsOILcJGJDfAp9uS2+/9/tR73JgcyiouIGFtlW9ik21nIi
	qhoQV8bdGJmyZNUBti3QdjNRLNMUwz8LBaw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fastmail.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794508573; d=fastmail.org;
	mf=PGljYkBmYXN0bWFpbC5vcmc+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:qmgYtEcZbCCU+NfeeUgp/SZXtrfbLbDtKMZOW4oqz6+lvs0
	dI6rH+cH5GeA5MG4SQmjZmARUpIrXHSIZ4fVK87hejgY+Y5020PpaLdP8hm9FmV+
	9YoUH5NqLzCcZhVFsEAU5hs3QXCC+L2+dFLbvYlUIiwMcEov8kw7N58ThrlEAiu/
	u91YHwB1p8PLGAGrFGtiTIUCrHqLUEJLYbL9NFrpq3T6lwlEXgx14/4odBN54I8o
	95m/1dzQmZR0pNTf6X22Qa8R4CiRMmZdIrXXOH/fRqpKoXfOw5oEgSDfXb3ZfmXq
	9cV1NLy0/nhXX9Tc5V2vWtEtmYaDXUtyOE0zVRg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:0cGylmTX1jmna07k1aJ+X4s/YkV93KmPKVfLelOX3IA=:8Dgkf4DqtdBdmkWiLLQ5+Ad9Iv3+Y1BKL6yEo0a5pnQ=;
X-ME-Sender: <xms:HQf2ar00mfWr6gbwfCVtkOo2iaR5WBW1HF55YLgVpxBg8MTNkctUmg>
    <xme:HQf2amFAkZx1kk2tYDjKlTsMg7lQWI5SiouCBfieeF8uaB8gFWHHigcwRlcLvtWBo
    G2HrHOSMp_u0ik_E2CeZgHtmZCs7xQRZ3-a5a0mctg7d1HLUYtx1ew>
X-ME-Received: <xmr:HQf2auHf3iMzxmCDd4Td9-hNDZwN0i_p5Xk8M8K1g3H6-NBOTwRvAB1m_5g5ir55>
X-ME-Proxy-Cause: dmFkZTEefKr1SuHJfuLBi5/JbM9WKp3TnwTA2lcP0waACeOLap/D+NE8NbuTQSP+lRzrme
    9HOI6IKPoHLcrH7Y+WaRCSQSPRJ6VTYKDpQC+2ajfRN/gtZ3YCw/IUIDJh+TiaInttzv7/
    reiQKQmubv9euvswsBeANIydCrgZnHaQe/UK6y2ZLtqwJfZqfsnUIK/1MenIVNxHdenxQU
    EN4sfx+FTindZf4Y39sWPl12lCMuXGPCpdXi/rj/xPyfas+0VMQEw9yd21W3MXPQhhsjdg
    b9zyBAYE7mxLEMbH6mVqJPswVCzXSLMIiB7KUf7tf8FKJLVWw7x7owqsPfVblUwIeBTMGW
    rhsyE4ukDPCBRNB5ex2jcK2+UkjbLx3Zg8cWc7A6MLbOuyhyoSJ/d25nUvgkEzXKuuzSBI
    Q1Pn7g/5z5td0mhf9pRPWtHnOsOWGJDc+3ItKT/FNFgf+WMEBArYdQXg8/tufPlSKnrOR1
    rRvmyI/yK+ngg1g+noZTuh0veF5q96ftaWTsUiFDOSPU9EMqfvBWOGkphnFWe3rAuiqY53
    wpE/uyqUF+ED4/WPr3hkDlBKRJv+wghtWg2I7fsUK8vrjw+zA1LGmxSOW+hih6jdRNSzto
    EbzhyRlUPv3utQIJrBEpQgMrCylPGe4/6Styl3hX951FNM9eUKjvHS3ifaiA
X-ME-Proxy: <xmx:HQf2ah5ZKTfbj26WfGH0BmHaXTDCi8Q5WCrNUsZwNgTijM4lwtQaPQ>
    <xmx:HQf2ary6cVUwAiMFlVA4VRb4NqbzQrwtEEhVCBSVgVjU-mUquJUBdg>
    <xmx:HQf2aoMfDsrEqrKhPlwHj3ZHlbSBY5h2IiEv802xrrxL1vf81Bky0Q>
    <xmx:HQf2aplMl-A4I7Qz5fTllTR8wwJCUFyA2FBvK62GUeZAtBR31nqd6g>
    <xmx:HQf2aleDdJ7PPNMjDqou8e-o0ChGo7g-hTrfmOAEoOBfPebo0EaK7sUV>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 13:36:12 -0500 (EST)
From: Ian Bridges <icb@fastmail.org>
To: linkinjeon@kernel.org
Cc: senozhatsky@chromium.org,
	tom@talpey.com,
	chenxiaosong@chenxiaosong.com,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Bridges <icb@fastmail.org>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: ignore the allocation size create context on a read-only share
Date: Thu, 12 Nov 2026 12:36:07 -0600
Message-ID: <20261112183607.1660070-1-icb@fastmail.org>
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

On a read-only share, ksmbd refuses writes over SMB, even from a user
whose account could write the files in the underlying filesystem. Such
a user can still open an existing file for write on the share, but the
WRITE requests that follow are refused.

If the open carries an SMB2_CREATE_ALLOCATION_SIZE create context,
smb2_open() still calls vfs_fallocate() on the file, and the filesystem
allows it because of the user's write permission. The user can thereby
reserve any amount of disk space through the read-only share, up to
filling the filesystem. The file's size and data do not change.

Ignore the context on read-only shares. It requests space for a file
being created or overwritten, and such a share permits neither.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Bridges <icb@fastmail.org>
---

Notes:
    Tested with KASAN using fs/smb/server from ksmbd-for-next
    f4692d0e3b5e. A 64 MiB allocation context on a read-only share no
    longer reserves space. The open still succeeds and reports the actual
    allocation. Writable-share allocation and smbtorture results are
    unchanged.
    
    This fix was developed with LLM assistance.

 fs/smb/server/smb2pdu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index d17fe9f9ffc6..78758817e692 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5272,7 +5272,8 @@ int smb2_open(struct ksmbd_work *work)
 		if (IS_ERR(az_req)) {
 			rc = PTR_ERR(az_req);
 			goto err_out1;
-		} else if (az_req) {
+		} else if (az_req &&
+			   test_tree_conn_flag(tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
 			int err;
 
 			if (le16_to_cpu(az_req->ccontext.DataOffset) +

base-commit: f4692d0e3b5e16d32d4ec7b1e0e58d7dbe74aaf4
-- 
2.47.3

