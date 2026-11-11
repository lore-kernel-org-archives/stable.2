Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409160;
	b=huczG3ZB0s+TRoqzF3mra5IHjdDobmFmkCONstbtOhCF3sNNYQPUXqpcxZ+xIXinuMOj
	 y4rjkZRP/m7upzVh50UUKwE2LKcYnKBRMDxmIY79PXEE4vPDNv4Hl1rv6Qi0UIqqf1WRF
	 WCPtAYvEiZYyawIh1E1YK3GFXsMNrUHteDTgUTZRm0MQzr/TduX1ceE/AeC0XHofVLa5b
	 29f6/Tgn382s5loyitMfb4bdeZyHMuK7+8wRKX2fIkDuGnz2A4rLJJVXHSgMzqtkZAmIE
	 ApgZvKgmdcvy3Yj1vwPCfelr2vlPuf0UZLaJmlEWpIZp8C/dgsGMcLBKBPSHZnhY9qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409160;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=J3gc3ItOg2bq88SP+obiP3on44prRPZxnRyMt30hQ8w=;
	b=SgtW/6K+cf1yHMzk205+XuB1A9HTvP72N/W3T9SXw1biVjdwp1gbezTc6NFamV5RsFlN
	 EgTJmzisIkemuIGTVDpNPLWo6wSKzkN3zjkYgt/YvgSrgEKuPGFi+oj4AcAKHq7ukBExI
	 YT0r6J4o4YkLeGWNypjMaqgJDgFRNLrWq+E98hwLN6XZf5u4v9+qG16NKxVGL7DlIsgci
	 gLwscUvytypcrDjJPrqBBwqgxr6/orfsOVwcYgZJFtn2evvDMsi0PaIY+QsjMyvjFZU32
	 CbMn6t/TsAyQPgWDWxRBm0AenFx1oEEqORbjTPBT0DChtIMHaI/KJ3bcJ8sRf/YtT6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U6rjuWNQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C3D606A32A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U6rjuWNQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184521F00A0B;
	Wed, 11 Nov 2026 14:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794409159;
	bh=J3gc3ItOg2bq88SP+obiP3on44prRPZxnRyMt30hQ8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U6rjuWNQroTrT92mDCBEPUCjWhLaq4N0OzdFw4JAUVHaEDvMaf+fNo/b6fbfQ/mKS
	 ZvKkSQvtmFigRE+dPontvpwRAcYfPB8Zb+KYYnL6NsbJ8Uu+j9N/RaXs9CnhsiZsHy
	 TFQ6ItoAxfumgDh0tg1SMui8jhGy87UV+MqUFtyhcu9xFJwP7vArEcYioX8EZBEBLN
	 1ce1uL2VCLM7o/XVAClFJjPQ1E81/Tnbw1ytatd9rEoDEj/RC3LIKXNYrGmDa/zj9Q
	 lcp5PbPYO7bkN1yu6x7OM01ZVfeXaX5tf2Rd9x7RDWOl85TSRZaIYA/qI63kQTXNhs
	 E3ozYj7EFBppQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiangshan Yi <yijiangshan@kylinos.cn>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ceph: fix longname buffer overflow in ceph_fname_to_usr()
Date: Wed, 11 Nov 2026 09:59:17 -0500
Message-ID: <20261111145858.2481294-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053926-failed-6.6-71975d6e0db1@kernel.org>
References: <20261107053926-failed-6.6-71975d6e0db1@kernel.org>
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

From: Jiangshan Yi <yijiangshan@kylinos.cn>

[ Upstream commit 71975d6e0db17646102488cf54480fda9de0f7a7 ]

Snapshot longname reconstruction formats "_<name>_<inode>" via snprintf()
and memcpy()s the result into oname->name.  Checking the length against
NAME_MAX only protects the LOOKUPNAME/export callers, whose buffer is
allocated with fscrypt_fname_alloc_buffer(NAME_MAX).  The readdir path
points oname->name straight at the altname in the MDS reply, whose
capacity is altname_len; the reconstructed name can exceed that while
still fitting under NAME_MAX, overflowing the in-place destination.

Save the actual oname->len before the decryption overwrites it, and fail
with -ENAMETOOLONG when the reconstructed name would not fit.

Cc: stable@vger.kernel.org
Fixes: dd66df0053ef ("ceph: add support for encrypted snapshot names")
Suggested-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
[ sashal: Adjusted context for the fscrypt_str temporary buffer and %ld inode formatting. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/crypto.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 62f33516e8bb6..9eb7f5ae3e58c 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -388,6 +388,7 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 	struct fscrypt_str iname;
 	char *name = fname->name;
 	int name_len = fname->name_len;
+	int dst_len;
 	int ret;
 
 	if (WARN_ON_ONCE(tname && is_vmalloc_addr(tname->name)))
@@ -463,6 +464,9 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 		iname.len = fname->ctext_len;
 	}
 
+	/* oname->len is overwritten by the decryption below */
+	dst_len = oname->len;
+
 	_oname.name = unlikely(is_vmalloc_addr(oname->name)) ?
 			tname->name : oname->name;
 	_oname.len = oname->len;
@@ -480,6 +484,10 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 
 		name_len = snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%ld",
 				    oname->len, oname->name, dir->i_ino);
+		if (name_len > dst_len) {
+			ret = -ENAMETOOLONG;
+			goto out;
+		}
 		memcpy(oname->name, tmp_buf, name_len);
 		oname->len = name_len;
 	}
-- 
2.53.0

