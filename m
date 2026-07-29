Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CB0396B8C
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 19:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785351775; cv=none; b=rloXKQhigIwgrxEln0KFP3HGGhB7HKg0fVGj7bHWsDAmGDQ63bzd2ygnHnl1fiIiqI09911TCoU/iF7vG4rIPYGcOu4SRkWz5n4mYlC4ABcWZFySUK57RQjJZuvmIVWqKrAHpu/5eD3NUsz+Vr3JfpHZrKLI3kFQk8VZ9B94BZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785351775; c=relaxed/simple;
	bh=JWrXHvEwHNegNJe4k4C3JwE8I7TUYD99BBgmRlUs9I8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A66nrznDCNGMX49hO1lh6ks+7HU6BRwYp/Wwebb8H6dTWxRJcVJsYrgvRga/+sSMmLIZV2fQkbcZc1cjPwqyFzJAMqrBF3aXNDD+w3paBYdqjW5YtPhyA96K/3/8LHUImC2qNB3xuzFVIg2BOJfjHXCtegGjctKUpYbkqyCdjag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=LNQShe71; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="LNQShe71"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785351741;
	bh=CzEhAPIth+V2TSkf1dZi+xfhYzY9lNBcvwm5roPJp/Q=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=LNQShe71KQ1+3gGu1ggRfO2JQN+vNxxAEoIscSUMGY+sbj9N1/LxqjKr1cqjLSew7
	 q1YGcuU855CiHvbECQWNU64UEtyU0WkNVfQuGluBJyCIoIIFt1hz8ApVARC0dOxVEY
	 r05U18jGZ4DdW916FpBDh2BuouGgJsAld7tpWPcM=
X-QQ-mid: zesmtpgz8t1785351723t569c98d4
X-QQ-Originating-IP: mbeVUoPbtFDPuDKSPHK75tcSbCDJbtL7GVx3UlKinUI=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Jul 2026 03:01:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9169055778896367910
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	linkinjeon@kernel.org,
	stable@vger.kernel.org,
	stfrench@microsoft.com,
	LocalHost <localhost.detect@gmail.com>
Subject: [PATCH 6.6.y && 6.12.y && 6.18.y && 7.1.y v3 4/4] ksmbd: validate ACE size against SID sub-authorities
Date: Thu, 30 Jul 2026 03:00:29 +0800
Message-Id: <20260729190023.46584-5-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2026072936-equipment-calculate-e753@gregkh>
References: <2026072936-equipment-calculate-e753@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OLPPkukr/NyPZFxT6LCaOV9JNNxIk8VLNJFrRHFCBoGp4VTNHWVrYhwp
	fjx8CXQPCBr8bjSOPtumtlCcuri/7L/U6B8B9Tc6vBtZ8Hzq32fi5cddFI/WGq2Dl+XvJuG
	8rQsdNES6bAaPCJQcnlCVjR1hyt+P+coqNFqQQSc95L0/sNhJrRGseFP4fl+ENR3n2Eo5jy
	Saj/d4ODarKAjsQG8IoaLTD7SpgnN/ch8axRlYxzCQKJdE89qS5QTYuoxg+kLeibJICTC00
	udB3YUzsBVRTUUIK4LFfoFzJyhEt723Rw5fBqURYWJtCHgRBzCkZsUA90TLSPCtm3jxyKXS
	SXThsM2j/LCUN6dn+7yU1M+rmEQXPmIlMyOtxZGFtwX0L5T34fuFahpJyV9KcO2xZq6M8sT
	+/nFc045nFPzmvwrtT19NImoe/TUR/GpledpjF0u2kCietVUhUdULZCMhoI+uR+FU3Qy5Q7
	pjARFUyIx1Vw0LafL1ixLqpvEYWERr520+fBnYyTa5RKjK3LPZ4sy9GBzT/K6NNqfGU5jha
	y6x6ZqZt3MjtrAGgpj7kM6MDdxX5Yw3LXZz++Ho49l0zHNtwv69ZPUgUg1zlTGHvYwrukbP
	Nvn7rrVQnzLsbbYXOjhXMHqXnVCgm/CYY+zapfNzPaDujukXjodMwSTft+nF2YguaJ11l0R
	xQbNO83Sw/8UIcxgSIQTSzb+bl9Clm1dEMkdqLMP89aVCPhlsKYRhT7Dqfr07UCwg3+vcm3
	WnCjLnIAvIgPo9YF/2Vu3DJ5AYG0T5nozQJPiK9z2tz/kL2KbyipJvq61Th1+QwwETXdh1j
	kcrPQSzwLzrx3t/wQCZM1/u7y1h89VS8fZrsocWIvO//DuLPXXQ/Xp6lv+jXyFI0HcPb+EK
	esHeoN52PxHkyggoy6iWca3wbdOs+iMSPjSUnkm6Z4cQLuYyhFW6bOSyPW1IhAkeyGLSsQg
	1F4eIzuO/4SPxEyBsAebO+Rs5ssQ6x8zcF3a2jf4YQfR/iLq/ll9oCXAXRNKf7VgVIjAjL1
	8AOy3w3JGQVmFOv9B3M4qwkh6ZSkDaKjJ9mNgeu4TA0NRwyGFuUivYa4AtsRGtzCA8/So3/
	4ikX4fv/eoAnene82hrvD/CCStrtJx8KksIRbl8oHPzF0n2okF++FYdBTYHBsBPaKpISFP6
	ryV3IWmeFPgPQxAQJ3Ga15MeWd3WXAnh4+YF
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
index f869639913088..0359cd1032026 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -743,15 +743,22 @@ static void set_ntacl_dacl(struct mnt_idmap *idmap,
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

