Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793396318;
	b=kcItZ5QGZxbZNeREiJzfFNDvKQa2080nBuSThZFXWiHzW18OVQJOHdVhDFxwQ+HDwYZU
	 YXYCT/3KPcWws32X+YRKSc9RZJY1oXrnqMjXEu7xG8fT5PLUEZl/n/WeK+sSAlnCDZXrB
	 6vywb5MsbF8b/T2zk2UZs/oT1QROb/ZOfvjHakNqMlRS8TYIoaZ17UVqALWIi00jvlrhV
	 ouy9BAcdoKZjpzeWPYRb3QnBChIsl7FeXK8vN1Qc34k+hg36I/UVaaCY1iKkAmO8d0I4R
	 ibOrTX72ByBjPu5inyx5hSKlnE89JxkFpXCBCqAtFDJLyvMik7IuIsyIX8F7RHyXVhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793396318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yCiSFwp1cCOa8SOdttgJlPnlrtvKmubMnzBrBcTEAPw=;
	b=ecqcueM5pNP2KHmbaAdebviUYDhjMZQZ9UIYL/xiwuZ/Hf13+l1dm6bydySzoNWLvvx+
	 AnRddGQjwVnlQWwJFE9F4ztHMw+apQmlFC0QJrWVbZ4NneHK8FsNwNZ7YIhnEVVRy39Te
	 kOyl893wXTQq8mDjcvlz6qhBkr4snHQG5hTsMtkRUR1ZtTsW+857jLGSGGY2B83DW16qN
	 T/eK5QhxxRKNb+KS+d4sd/nCZyoKPVJ1OAcVypilf+XLpci6fV1kqldo9Fe9Jwc7k9LeJ
	 Pgk/7xhRuarZQ0ZcVhNW+NW1BWlqKw9RUiYAXFAQxvju4t+VazNBGFG2ie6U2HUlSlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h8XBL0xo;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575E7606A322
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 21:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 575E7606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h8XBL0xo
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48afbd2c386so672836f8f.3
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 14:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793396316; x=1794001116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yCiSFwp1cCOa8SOdttgJlPnlrtvKmubMnzBrBcTEAPw=;
        b=h8XBL0xoOGZ4AQFHfHYcT/MlggAh9bw44ZnQnHfwNE1mv9HPuuur+kIFlsNEaLMqlQ
         SNRyWLTnf/rJGipSl+BRD8ReZOJveoxVKyVDv9+h69d2cRH3DApE7dbSqSPDivXf6zM2
         GJaR1Ja5OHdIozjxoyIPJ6OnRTEv+c9hjAYOP881XxWo95WuLjAwMrJBk8SK66Mdwl49
         +pxaqdUE8kJO6fXENWsKJ3Bb9qtsaxvgsBZxnJD1ySZtpgXXIJh102Q3b7HTDauyqlW8
         OUwP6wpT1zuNhH+5Ij0hkEJxk4e/1l3xwmJqwY0whEH2jQbfbnW6ho2g5LRRT83L8e88
         IxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793396316; x=1794001116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yCiSFwp1cCOa8SOdttgJlPnlrtvKmubMnzBrBcTEAPw=;
        b=CMUR13dByGa498jaXzY3BoPTqBD30KPEhieftToQpc/y0q4c3PFTy0B+h8ABcySusq
         Vj7t8YVEl2V9wxmVvkX+R4uIDGElgLOF6HB8AmHuArsyF+x/fGiu9ofnVr6GJDhceYZT
         qbpg7/rAj8Yos9aiTS2YLcDnpkVAzBSd+yU/F72x5+O9FjU6XkyT0b5zKDUH0WrAcmeH
         t/yaGPfiDiQgT5iFgApV0dpARDSuGmjMSGA86gxkWYMP8MzAo8q0WAeFDbbnz0+Tnw+k
         4+0N7b1bUmZurHmmojgADgaQh1Mm+NshDUg3K1ciE7gyq7a5OudxqhRUel35RRRNtYaV
         o9rQ==
X-Forwarded-Encrypted: i=1; AKwUvBwN1X9PJSjsynK3BHE2qZ6Y4LUP+y1heLCTQVuuEFw9lE3sc5BU09ogyjyZRLWnY4lkmt0wNTY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0HQti+IzULUoHSE2K8/4XWBddLUVa+8CeZSxZB3DjeM/bQ6Mn
	eGRU+IsdCGzO2zejgnurkZoGfNpxA3Q89Vz28i4NQ2ylLUQyTEAEdUOd
X-Gm-Gg: AYBFou0YzR3+vEEZxqO9rw5a9AYLtAbQmAfEzF/ko6hqa3dv+hSKD+WsugVOEgN3HdC
	SDgASQD/Kef7FweYeyJmaIC5x/PMfZzr9tqSwlbfoGFhwpp9fAK9xX5ehC7aaWwDLZSr7F+dKwI
	+tERdy035IjJ4NybSIRdUp84lXYN4croy9PnaI4IWGv7v5QQsb7vp+yvFJs9IQgZRcgdWZyReUB
	FJYJ1jGxNO1hW+kdlP9BkZVh/OzWZquoWHOnPF02QHIqf2jjAy7x/qQFvNV61BGgWV9Rys/i/aU
	gvTs5kGKL7NNg48Fj3QDpQEHVniDNtjs6KNinGNQPMwqCrtVEe8f2W0j502Gah5g6kERuGc9rxA
	OcdPLFOLUWkTTl5OeN0i74Me1oPsNU/4onfQXRpe4yoGQCMEqoOKnyXFDP8rml8t7HFDUeepLV0
	4thr+CWPZwtTyHnevO92F3T8bfpGuh4NfQnWq2IKdkqKFHODpcEPskFMu9p1aQwQgAgqEPe38dy
	OLSjQol8Ji7uZ+Tq79E3zaD2cXUqD1jqcIDOwYNofb5BfGWMdnO22SICQaLkzRdFjk6ZoED+UtD
	O5quj+zGoGbLTYUAAv6mogNY
X-Received: by 2002:a05:6000:1aca:b0:48c:7037:aee9 with SMTP id ffacd0b85a97d-48e6e4fcfacmr8292130f8f.50.1793396315576;
        Fri, 30 Oct 2026 14:38:35 -0700 (PDT)
Received: from dev1.kernelcare.com ([2a01:4f8:172:1c85::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71ba4ac6sm5547147f8f.52.2026.10.30.14.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:38:35 -0700 (PDT)
From: Andrey Misiurov <andrey.misyrov@gmail.com>
To: Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>
Cc: Steve French <stfrench@microsoft.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrey Misiurov <andrey.misyrov@gmail.com>
Subject: [PATCH] smb: client: fix OOB write when compounding SMB2_IOCTL with encryption
Date: Fri, 30 Oct 2026 22:38:27 +0100
Message-ID: <20261030213827.2216453-1-andrey.misyrov@gmail.com>
X-Mailer: git-send-email 2.43.7
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

On an encrypted ("seal") mount, SMB2_ioctl_init() keeps the IOCTL input
in a separate iov (iov[1]); iov[0] is a 448-byte buffer from
cifs_small_buf_get().  When such an IOCTL is not the last request of a
compound, smb2_set_next_command() pads it for alignment by copying the
whole request into iov[0].  A large enough input overflows that 448-byte
buffer and corrupts the slab; the copy also sets rq_nvec to 1, so the
input buffer is leaked too.

An unprivileged user can trigger it by creating a symlink with a long
target on such a mount: the native symlink is sent as
FSCTL_SET_REPARSE_POINT + QUERY_INFO + CLOSE in one compound, so the
IOCTL is not the last request.

With slub_debug red zones on the cifs_small_rq cache, the overflow is
caught on the next allocation from that cache in the same compound (the
0x61 bytes are the 'a' characters of the symlink target):

  BUG cifs_small_rq (Not tainted): Object corrupt
  [Left Redzone overwritten] 0xffff8a59c7790500-0xffff8a59c779053f First byte 0x61 instead of 0xbb
  Call Trace:
   check_object+0x1a8/0x350
   alloc_debug_processing+0xab/0x110
   ___slab_alloc+0x7e/0x2f0
   kmem_cache_alloc_noprof+0x28d/0x4b0
   mempool_alloc_slab+0x16/0x30
   cifs_small_buf_get+0x1a/0x30 [cifs]
   SMB2_close_init+0x8a/0x100 [cifs]
   smb2_compound_op+0x2571/0x2b50 [cifs]
   smb2_create_reparse_inode+0x27e/0x490 [cifs]
   mknod_nfs+0x1ce/0x2e0 [cifs]
   create_reparse_symlink+0x119/0x180 [cifs]
   cifs_symlink+0x19f/0x8e0 [cifs]
   vfs_symlink+0xa3/0x1b0
   __x64_sys_symlink+0x41/0x70

Pad the input to a multiple of 8 bytes when encryption is required.  The
request is then already aligned and smb2_set_next_command() no longer
copies it; InputCount still carries the real length.

Fixes: 90f7c100d2dd ("smb: client: fix compound alignment with encryption")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Misiurov <andrey.misyrov@gmail.com>
---
 fs/smb/client/smb2pdu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index b140ec0a71a8..71d9b698c208 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3432,6 +3432,7 @@ SMB2_ioctl_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
 	unsigned int total_len;
 	int rc;
 	char *in_data_buf;
+	u32 in_buf_len = indatalen;
 
 	rc = smb2_ioctl_req_init(opcode, tcon, server,
 				 (void **) &req, &total_len);
@@ -3439,15 +3440,18 @@ SMB2_ioctl_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
 		return rc;
 
 	if (indatalen) {
+		if (smb3_encryption_required(tcon))
+			in_buf_len = ALIGN(indatalen, 8);
 		/*
 		 * indatalen is usually small at a couple of bytes max, so
 		 * just allocate through generic pool
 		 */
-		in_data_buf = kmemdup(in_data, indatalen, GFP_NOFS);
+		in_data_buf = kzalloc(in_buf_len, GFP_NOFS);
 		if (!in_data_buf) {
 			cifs_small_buf_release(req);
 			return -ENOMEM;
 		}
+		memcpy(in_data_buf, in_data, indatalen);
 	}
 
 	req->CtlCode = cpu_to_le32(opcode);
@@ -3471,7 +3482,7 @@ SMB2_ioctl_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
 		rqst->rq_nvec = 2;
 		iov[0].iov_len = total_len - 1;
 		iov[1].iov_base = in_data_buf;
-		iov[1].iov_len = indatalen;
+		iov[1].iov_len = in_buf_len;
 	} else {
 		rqst->rq_nvec = 1;
 		iov[0].iov_len = total_len;
-- 
2.47.3

