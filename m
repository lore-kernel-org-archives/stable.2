Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799064DBD87
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785349620; cv=none; b=Ev0j6qxph9ilf+cq+9S7izupox06nHnKhgTLTMxsmCBGMBys0XO3qTftXj8bNz6sgRrDvWHGBuOttyy4I97BiSItBCUI1IC/gYuFnO+9JbGRPLsBZFMrjHsLoC42+dE61kPkzO3Zuv9i8IibhRRhWczqNSGE9YFe/I5Z//oPyAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785349620; c=relaxed/simple;
	bh=mSZz9tobKa5d+cHFPiAtDPNGS3+Jr6mqxksozKxJ2Nc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AKOdvzS1TV7jR4pHgClxMF8MEHOeBLjCxBZWYSZaCyJ3rXOy7eNtmoN7l6Rd4OY8PTOEU6PYnwFp1D09ke/6qK4fcSFOeaw7bogiJ/NtxnsI1xVxQ0Y3ynJRCBtiyHVoU7ELOg5RhqSeTq7YGyK+CWR0nSWvTxt/zijQ4b7P8qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=EbQpB1cH; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="EbQpB1cH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785349562;
	bh=Bnftk7he0VmOV5t/A/z3k/R0/9s29grGIw8LSNmMdI4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=EbQpB1cHento/mrnAnifLzGV6HcFAOOfa8eDs7naAglpiHw1G3nMmJjHydQ6nmOnh
	 G3/tCUhtPfXjPWuPl72/53Sd9Awn3QXWsBjs68Y7y7nKjPw4zj1VZe3VAg59qJTOSI
	 2M8NoAN7lyFBRcK/39epBwHJnVB7g3eJY6Yi2Szo=
X-QQ-mid: zesmtpsz8t1785349545taf6011f4
X-QQ-Originating-IP: t+N6DTQAlhKvty6htfxoCk4nDUZEDpXB1JW6ZDqNHL8=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Jul 2026 02:25:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 92975447654379525
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	linkinjeon@kernel.org,
	stable@vger.kernel.org,
	stfrench@microsoft.com,
	LocalHost <localhost.detect@gmail.com>
Subject: [PATCH 6.18.y v2 3/3] ksmbd: validate ACE size against SID sub-authorities
Date: Thu, 30 Jul 2026 02:25:30 +0800
Message-Id: <20260729182530.31304-3-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260729182530.31304-1-guanwentao@uniontech.com>
References: <2026072936-equipment-calculate-e753@gregkh>
 <20260729182530.31304-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: M3vv73qU6a4uAaOp/QmqL/cmIvzbOyh1TZEOx+BLQkCOxT2h/vya1rBn
	vEcQkC7oY0G18eoy/smEXOjb9802qvkvsJB2u6WGPyiNxmQvGFGxBMvi8PWJNlh5GIvHuPu
	3k9+JU7Z3BNwSuJTiOq3lI2l9JjgTHpZXumi/FG0A7tB3IjmjzoJAT8m2cjYHh+3s5zTFik
	+0xMp1Biem8bhi6ZfHzACgbT/iU115Y2H+A7Xuow44pdEfJTtmYCqtoA3+07IdMV7NFTO/J
	q5V7zRCufSCJ3MtUSs7jRLxPmK5Ga9bJ7FwX/f+9mPKM9C8bryadXa4nCU6i972yfYWjqGq
	YQFyonQaPc44JIhwSmnDfYu3iOSnHglrt+cIMp1eqoC+5eSAiQslAXZ1j6bRgCIZ9ouf95Z
	o0E3iSGAYNNvNTW6VQMMj743iqYSkpiizfEjdRiLHwNrDK+HRBdLKAlpznG0xqZBA97SexK
	sSK6GkOB6KL6sKDj6nDln6hXvIyZjGKBL4Y5l5tfNSPGPZ7shtjVAtMXWlxS2uvM2kRjZYr
	hK9G2MXeKDX3Hr00XKli0Y0LkTYIjiKR7UK6vfnf1wQ20pivNUlBA329PPz4zT2ttTpqgTN
	vh2egdzUEBuTaFHdmWprT1wQxsPdFoJDIb4GtUBflHDMFkyCExGX/JeTe0USIox6U66WeTC
	qREiOQW7VAtFpTUV+rrxd/yF4gRiTSAbyxfKsAFWSMirXv3cJXwBqVlvO9yWTLLxl+L5S57
	7MG9wYxyFVGmvPagY7l//2LNLbAFCng/6Hkm5siSsBHNNi6ePsXXz8e1SS4UR9tpAOmc9nQ
	AfIx+j1jmBRZqZaKzNMd70jQ+q7HC01Hmbnd7MaawJYMLITpHUD7F4OMocDbg7LGpxIMdXb
	APMLgJF/Ze5ca5Xf6dI+Ljcs7AeZcAFyxXkE4SajgPRiD1RS69f6Im8F0Ez3ZnBlfHbU/uL
	6/X6BiGPvnR9u8KWw5UH6PuvE3VnAAw/lPhfqaYh3ZhyQhA69Tq49nkH/Ayp+aDhcOfcwAv
	X4wRGA5rl3dXYi7xnCURTBH9FvPEPtuluQ2xIvhj8yvDh+Xfobwt8Kai2SewH5jAIFJoD0N
	Q==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

From: Namjae Jeon <linkinjeon@kernel.org>

set_ntacl_dacl() validates sid.num_subauth before copying an ACE, but
does not verify that the declared ACE size contains all sub-authorities
described by that field. An undersized ACE can therefore be copied
and later make the POSIX ACL deduplication walk inspect data beyond
the copied ACE boundary.

The existing initial bound check is also too small. It only ensures
that the ACE size field is accessible before set_ntacl_dacl() reads
sid.num_subauth farther into the input buffer.

Require enough input for the fixed SID header before accessing
num_subauth, reject ACEs smaller than that header, and skip ACEs
whose declared size cannot contain the complete SID. This makes the
validation consistent with the other ACE walk paths.

Reported-by: LocalHost <localhost.detect@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
(cherry picked from commit 5152c6d49e3fd4e9f2e857c57527aead752f1f87)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 fs/smb/server/smbacl.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index ca0e4aab6dd87..d4ae776c8c677 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -741,15 +741,22 @@ static void set_ntacl_dacl(struct mnt_idmap *idmap,
 		for (i = 0; i < nt_num_aces; i++) {
 			unsigned short nt_ace_size;
 
-			if (offsetof(struct smb_ace, access_req) > aces_size)
+			if (aces_size < offsetof(struct smb_ace, sid) +
+					CIFS_SID_BASE_SIZE)
 				break;
 
 			nt_ace_size = le16_to_cpu(ntace->size);
-			if (nt_ace_size > aces_size)
+			if (nt_ace_size > aces_size ||
+			    nt_ace_size < offsetof(struct smb_ace, sid) +
+					  CIFS_SID_BASE_SIZE)
 				break;
 
 			if (ntace->sid.num_subauth == 0 ||
-			    ntace->sid.num_subauth > SID_MAX_SUB_AUTHORITIES)
+			    ntace->sid.num_subauth > SID_MAX_SUB_AUTHORITIES ||
+			    nt_ace_size < offsetof(struct smb_ace, sid) +
+					  CIFS_SID_BASE_SIZE +
+					  sizeof(__le32) *
+					  ntace->sid.num_subauth)
 				goto next_ace;
 
 			memcpy((char *)pndace + size, ntace, nt_ace_size);
-- 
2.30.2

