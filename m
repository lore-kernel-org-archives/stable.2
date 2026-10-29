Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793237147;
	b=nbGZJbMzJe7a/6Z+MlrQzoQOpK3ui01C5XoEfXqQI3uzR86qr0/f2YSs+38B3EwS87o6
	 QCItvTiJgsO3moJNp8T5ffXmQGycDDU2LcRMb/OzOOR42XBygoyK3lGbhG5Ynw3uk8CsV
	 ThuU4FleekKQXhbJVD37ZfwAndff2q5vi9jw47dRIprR53eDWAzSVN10CDCFRUxIbzVIg
	 HifT2p8gKfBPo5xe5ccn8ixE1mhpeNdmMh1ogeJOfhJVbV+6rvsHFurzPd3s8x44KU30C
	 1L5Xr0vV24l5ylTuF3/h9oOjkN4aTu/G/bNvsldT6IRrt+2iXtMmEUz7SL/YhtR5iSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793237147;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=40uo3TzgyAeLpqUrd11Nx1bywBZTJ09VOqKwD0NOR3g=;
	b=YITRyP4jI5xFsfcMDVrxYG098ADP+krwkp1JMiUbCSzKANBIgYxoSLmehtqCtBHgbgzf
	 65SiF8fzDIRP/C+1qsY/2s5JkNPg2dcx+n9pLap2YDgLg6SPrXhIAdO8zcGt1B+Ix5nEv
	 cquLlAb8Z80H0tfd/U3PkmmZsirbaGnhsgtg48C69hVnLBXqEtB3M2H58KbWIgHgMN5iU
	 LUkLN4PE/8ZipQmY/Fc1imHJ3N+TVJn9HTf7CB4ZNXHkxTYQqveyC7r8CKe0cQ+vcLXjA
	 NQlOsEUefLCNuLEwGxJJ+ftlflm5RWKg8ardh3/la5CJeSQK45DeCr/3Bg4FAvVVxQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.org;
	spf=pass smtp.mailfrom=fastmail.org;
	dkim=pass header.d=fastmail.org header.i=@fastmail.org header.a=rsa-sha256 header.s=fm2 header.b=Gy+ThPxs;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=xKEnE69d;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F327B606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 01:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F327B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.org header.i=@fastmail.org header.a=rsa-sha256 header.s=fm2 header.b=Gy+ThPxs;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=xKEnE69d
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 82E611D000C8
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 21:25:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 28 Oct 2026 21:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1793237145; x=1793323545; bh=40uo3TzgyAeLpqUrd11Nx
	1bywBZTJ09VOqKwD0NOR3g=; b=Gy+ThPxsRWNWJD/vnXzZxlIPx/B8Bu3Qh6+eE
	zJMZBvM+8OJdcxFLJIC+DxfLh91RqrMs21azOkJE9O0Z0hexOaBXZuYcZ01ILzHr
	rFB+30MXwMOtB4/si8+XUwH3PnxrEqllBBrXXhrBCYsSQJ2Gc84HKq7chB9o5Q10
	+l6avqLRpYGRIzRdJFr5AT8tFuzqCXh43MlnFZfjbOLiDBaW/J816M+CHwwCHu31
	0r/tsiO/fqIWcL3dwtp7/ClmsZ0qG47rfz/700qb2m6CwW7B5VlDW2rT8AVw40pU
	9nc+tMgY3bvmpK9PSwb82bncSaGOkk4ZrNZvagzRbq22I+gdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793237145; x=1793323545; bh=40uo3TzgyAeLpqUrd11Nx1bywBZTJ09VOqK
	wD0NOR3g=; b=xKEnE69dH314kAEX4bNRRiQFftbxj3yopmAcoXNEEEMzCtaVOrN
	V0NqBgxL/c7UIuVqbxuptcMs+RkYFKeQhsnN/SeaSTF47j6Cw9WLXEhYUTDrTZMr
	ANtEZIIU7scjI1bnIqe+gL6xbTVDv8coYj0bTwkOinsksk45S8zVxg03OsaiyECI
	uHMuy/5SQf3e6cQxJRljwZ7Og3PCH4/RAQltWMZ4wSr99mP63O4AUSlDKaoyHdIP
	2vXYJ8JxFQtPTIk7nhINTaGWhwmvut40aFOHLBJOa+8PNFg7v85qJ4ZEMIKeUbZi
	HVq+EVxV8gmhJPC5L+K7oOKyPDH4lcUimJQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=fastmail.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793237145; d=fastmail.org;
	mf=PGljYkBmYXN0bWFpbC5vcmc+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Bbe04nDQ6Wja2bJ21dgsjy0YRStCEsBA/7jFe2A6l/NKsIX
	XRsO74SXEmbH+jYJoN/v1XazDYkQbR1wcZvLwN1jGGoFkesviZy9tI33YSXcunqY
	uqmyQBJXAaPNkdYKlwDilzbZQVh5ev0kcmPIksalLy0oSYQKCN/qn86QX8F6K5Hm
	SJRAIxygf1CD+1aRrLnFNGIBPyf31QJOH2Fz8S+7h2641NnRbXAK5h1/1eL0+f4l
	ttDfwcSKYQE0AeXBZmaKYRVGjMxT8dLZ+nmw13e6rW8rj98iBVQ8+RZkEfAlvcyA
	NKd3C4TsBkLnKCSvs8IjjesgLmBBN16IRzWUXwA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:f0Xb0gOGJffAITMlNSj3k71khYqc+Jh/lCpTdboxPFY=:MnATMRxxRcIqckgRxtp9UNy99ER/Ne2NAicQc4MoUvM=;
X-ME-Sender: <xms:mKDiare6mpmahmLGzUaFzYM-cYANsBCy1FAKargyYgqPUTNVi5l5jA>
    <xme:mKDiahqg904N32gzU8BTNlPYMCnLDUZYQ-bsg4FhwkHAdcXBAnfVGUUKGH0qvn0sD
    QpCyRjauWoUz3XJ-38Cv_7PZtLomTPbZJvLe-ZC4wqVaBzwmg_GyyzA>
X-ME-Received: <xmr:mKDialODRQaN37p_e5C1YTP2ZfKwFrzUFxVVA7DuWewZeWWI4NY_kTrumNvc7wMV>
X-ME-Proxy-Cause: dmFkZTE/sHuRLxtO961CCQw8GTWuuNDeNSfYM3hpyu1Lq8MfnehnZRY3vI6jAL1IOsza+t
    foWFHfTlGi2G5hIgVT7me610kTF+unGYeN+PL8gWn6cY8hFHlGYu/Gw/NqJ4JY6JGv8n7s
    TUqVB37vxxaWAyvnWi7g2gEmuaroydDygNtTjfD1Bc43d6lFnD+8TDgCt6cJAGciNUVnWr
    mFQQvguQ6gKQOUi6EnmIILe9x2gj4nAQJ7tDg8nTfy6iovFi2m8uJ/D6Iae/oezxP9axsN
    RqwrgBEp6h7rC3HpyS37K52fNgQQe2/N9sjbq/vYH0DmdedZD4zR72nr7YYE1jHI3X4ll2
    RHyThGOVt3ZE4uWhkJkN+bwzj1oK4UgAYELuOot7gcm/ZbgC44A7zCmhcgK0RkdUHJiAcA
    FJJOPCaj2Z0QJo2iktux4OLjiMzBlEojMDK83UIDqy+LziybJAytJxONJJdmoZHvGVglUR
    mAkzySiSiEVoitpm2u/wgrwS8qnfShE2v57JGBCfAha7UKSoMJtVD7syBJ/eRkIAMzOkLd
    UJYfHfZPDGjbVhYmVQkj/EgKXEDZAZ7hCEAqHUA99PulyxFiQcCBIwwqksNWQw9Xc6W9wB
    Im7TjA52W+Z3cr5r5zmhU7WWM7TFqg+68N/L0KwxpEW3hEZC9itVVBHLAxSQ
X-ME-Proxy: <xmx:mKDiakhj5aG3i8EOKJcgYyLxChFpddMMukddz2xveLa3-JogAieCmw>
    <xmx:mKDiaosu5G9nVI1rRqu0H9dwlKPoyEs4Yef-7tG0_BlLQsDfeAmvsA>
    <xmx:mKDiaoi0kUiaGxrFiJ9VfSLo87m_2lYZEeIHpbB2ZB4Er6m85BwCSQ>
    <xmx:mKDiaubluYfE4zXo9LHMjEt8OKL1iP19U1f3u319v0E_UG_UVKOTXg>
    <xmx:maDiambLTxcXMrWz0okXtxTAnddFICfbTSaBzugyLWGwaYD18ZiaPwk->
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 21:25:43 -0400 (EDT)
From: Ian Bridges <icb@fastmail.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	Gael Blivet <gael.blivet@gmail.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Bridges <icb@fastmail.org>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: enforce the read-only share flag when creating a stream
Date: Wed, 28 Oct 2026 20:25:32 -0500
Message-ID: <20261029012532.222013-1-icb@fastmail.org>
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

When a share is read-only, smb2_open() rejects opens that would create
or truncate a file. Creating a named stream on an existing file with
streams_xattr sets neither O_CREAT nor O_TRUNC, so it passes this check,
and smb2_set_stream_name_xattr() then creates the stream. On a Time
Machine share, opening a missing AFP_AfpInfo stream also writes one. A
user who can write a file at the filesystem level can therefore add
streams to it through a read-only share.

Do not create a stream or synthesize AFP_AfpInfo when the share is not
writable. Existing streams still open normally, and a missing stream
opened with FILE_OPEN still returns STATUS_OBJECT_NAME_NOT_FOUND.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Fixes: eaff8e924f60 ("ksmbd: synthesize empty AFP_AfpInfo xattr on first probe")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Bridges <icb@fastmail.org>
---

Notes:
    Reachable on a read-only streams_xattr share, or for a user outside its
    "write list". The change is persistent but only adds empty streams, or
    the synthesized 60-byte AFP_AfpInfo on a Time Machine share. Writing
    stream data still goes through the writable check. It is not a privilege
    escalation.
    
    Tested on ksmbd-for-next bd24b89645c5 with read-only and writable
    streams_xattr and Time Machine shares. Before this change new streams
    are created on the read-only shares. With it they fail with
    STATUS_ACCESS_DENIED and nothing is written. Writable shares behave as
    before.
    
    A reproducer is available on request.
    
    This fix was developed with LLM assistance.

 fs/smb/server/smb2pdu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index f3cd6ff7eb09..cbbe12b3f96e 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3566,7 +3566,8 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
 	if (fp->cdoption == FILE_OPEN_LE) {
 		if (!strcmp(stream_name, "AFP_AfpInfo") &&
 		    test_share_config_flag(fp->tcon->share_conf,
-					   KSMBD_SHARE_FLAG_TIME_MACHINE)) {
+					   KSMBD_SHARE_FLAG_TIME_MACHINE) &&
+		    test_tree_conn_flag(fp->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
 			/*
 			 * Synthesize an empty AFP_AfpInfo xattr on first access.
 			 * type=0/creator=0 tells macOS to use the file extension
@@ -3593,6 +3594,9 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
 		return -EBADF;
 	}
 
+	if (!test_tree_conn_flag(fp->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE))
+		return -EACCES;
+
 	rc = ksmbd_vfs_setxattr(idmap, path, xattr_stream_name, NULL, 0, 0, false);
 	if (rc < 0)
 		pr_err("Failed to store XATTR stream name :%d\n", rc);

base-commit: bd24b89645c5fa8283aceda78dbe53aa234e6bf9
-- 
2.47.3

