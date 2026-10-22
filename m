Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792712978;
	b=2il1xBRMYPT4UM+XM59KoLa1Q8R1+fxuR/IYiadnm4D9fYB2kWzWBDF7TwBS08UAhHoh
	 Anbv01ukeSBDA+4h1L5QNYIHwhrvw6z+Xg9hEwLmQP66j7CGoKQ+M7JpDx7wEQYFXI/8Y
	 o6eS10XRp+nlQLbG6QT3NjeNVrx7xbqF4tsizssV/cHTNXyiIT0VKp9bWO0jCos/itdXd
	 PMZZTx2VElkNKVQ6RKB/quEk9cCUgLbZIfgEZaRoBbyT4ZUZcNfzFHAJ66UDQeQXQRliy
	 ns00uLYsgdGDI+zuJhInjsl9EbVBEsWqTuOY/CqrWD5Lto/kUm7qa2q+GmppUhVbeKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792712978;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YBGRdHh8w421SAdlENNWIVHbkQrG197oRHkIac9jmAA=;
	b=HrwuH0k66HiBp+GHQ7gTL2OTjd95pK0TqUrNFDMrI1WONWMG8QTUasTa23HXtDzXs/As
	 IyKb2qPY6DXk42PpD00RJhCT2Xp0EyN5aaFl0hVKxGhra5xW0un1p2nnwKvFBM8/7bBMM
	 5JCaRvCm144wNfSVnzlgMv9MUyzXKUKeoqEJKasVEhLvq17RIcm71ZUmn4dJWjpc5JEcm
	 YMIr7EFAf7wRJquRVNIDhvaoNJqy4kqPYZxtWznGy7q8u/G71Fn58x7CCBqryM40IX83P
	 y0O0qCaAU/w6gU1X1TG21+a9+Ww38bibrbWhRbM90XjiTokxticJE2jxh3GN7grKnrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NtwUkCIy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58064606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 23:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NtwUkCIy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5C71F01825;
	Thu, 22 Oct 2026 23:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792712978;
	bh=YBGRdHh8w421SAdlENNWIVHbkQrG197oRHkIac9jmAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NtwUkCIyXa4ti5ErVrtnekkEoipXwtzBjdVbQ3xSdWmrodr9RENdH0ie4ubb4kRPv
	 BxjGey3R/FdLG4qDxC0ImgujoQ2bwP4dt6Jgn2gx/tcPPDYs4ZtAZ6bKc/101M5yWa
	 y5wQecj0aAquo4daA32ROJf9F9amDkIjRCzUbZuXSl8DIEBdxr4WpKHy2E/bEfw5GV
	 UcADGoypAQZweuEQDxdIiIbwr9FXzuYFuhQ8KxGfaIZ5O30f4dY+3tM0QV+1eA9jTM
	 Uc66EsO/+6hcz6Mh6wAvRH5arbnk6pGos6o0OLNrMqVUaupGkN0qHXmqe3SEPz20U2
	 wMBE2im6Fmj3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yunpeng Tian <shionthanatos@gmail.com>,
	Mingda Zhang <npczmd@qq.com>,
	Gongming Wang <gmwgg05@gmail.com>,
	Qinrun Dai <jupmouse@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: reject SetEA requests that do not fit the request buffer
Date: Thu, 22 Oct 2026 19:49:34 -0400
Message-ID: <20261022234836.2161443-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102230-cardiac-properly-0c3f@gregkh>
References: <2026102230-cardiac-properly-0c3f@gregkh>
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

From: Yunpeng Tian <shionthanatos@gmail.com>

[ Upstream commit 4aa2c106aef4bf3dfd97c30842db0767b26e8428 ]

CIFSSMBSetEA() copies the caller's extended attribute value into the
SMB request buffer without checking that it fits.  The requirement is
stated in the source but was never implemented:

	/*BB add length check to see if it would fit in
	     negotiated SMB buffer size BB */
	/* if (ea_value_len > buffer_size - 512 (enough for header)) */
	if (ea_value_len)
		memcpy(parm_data->list.name + name_len + 1,
		       ea_value, ea_value_len);

The only bound applied on the way in is in cifs_xattr_set():

	#define MAX_EA_VALUE_SIZE CIFSMaxBufSize
	...
	if (size > MAX_EA_VALUE_SIZE)

CIFSMaxBufSize is the full payload capacity of the buffer, so a value
of exactly that size leaves no room for the SMB header, the TRANS2
parameter block, the fealist header and the EA name that are written
ahead of it in the same object.

SendReceive() already enforces the correct limit on this very length:

	if (in_len > CIFSMaxBufSize + MAX_CIFS_HDR_SIZE)

but it is called after the copy has taken place.  An unprivileged
setxattr(2) on an SMB1 mount with a 250-byte name and a 16384-byte
value writes 16384 bytes starting 345 bytes into a 16588-byte
cifs_request object, ending 141 bytes past it:

  BUG: KASAN: slab-out-of-bounds in CIFSSMBSetEA+0xabc/0xde0
  Write of size 16384 at addr ffff888003aa0159 by task init/68
   __asan_memcpy+0x3c/0x60
   CIFSSMBSetEA+0xabc/0xde0
   cifs_xattr_set+0xd3a/0xff0
   __vfs_setxattr+0x13e/0x1a0
  The buggy address is located 345 bytes inside of
   allocated 16588-byte region

Apply SendReceive()'s limit to the assembled request before the copy
rather than after it, and widen the byte counters so the sum cannot
wrap before it is tested.

byte_count is also tested against U16_MAX, because it is stored in the
16-bit pSMB->ByteCount.  That becomes reachable when CIFSMaxBufSize is
raised at module load, where it may be set as high as 1024*127: with a
5-byte EA name and a 65521-byte value, count is exactly U16_MAX while
byte_count is 65556, and cpu_to_le16() would truncate it to 20 and
transmit a frame whose ByteCount does not match its length.  Testing
byte_count covers count as well, since byte_count is the larger of the
two and count's only 16-bit consumer is written after this point.

check_add_overflow() is evaluated first so that total_len is assigned
before it is reported.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Yunpeng Tian <shionthanatos@gmail.com>
Reported-by: Mingda Zhang <npczmd@qq.com>
Reported-by: Gongming Wang <gmwgg05@gmail.com>
Reported-by: Qinrun Dai <jupmouse@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Yunpeng Tian <shionthanatos@gmail.com>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ sashal: Adapted request-length checks to use get_rfc1002_length(pSMB) with the maximum reduced by four bytes. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifssmb.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 67ff1669cab2a..debbd8d2b5f10 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -6385,8 +6385,10 @@ CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
 	int name_len;
 	int rc = 0;
 	int bytes_returned = 0;
-	__u16 params, param_offset, byte_count, offset, count;
+	__u16 params, param_offset;
+	unsigned int byte_count, offset, count;
 	int remap = cifs_remap(cifs_sb);
+	unsigned int total_len;
 
 	cifs_dbg(FYI, "In SetEA\n");
 SetEARetry:
@@ -6437,6 +6439,14 @@ CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Reserved3 = 0;
 	pSMB->SubCommand = cpu_to_le16(TRANS2_SET_PATH_INFORMATION);
 	byte_count = 3 /* pad */  + params + count;
+	if (check_add_overflow(get_rfc1002_length(pSMB), byte_count,
+			       &total_len) ||
+	    byte_count > U16_MAX ||
+	    total_len > CIFSMaxBufSize + MAX_CIFS_HDR_SIZE - 4) {
+		cifs_dbg(VFS, "EA request too large: %u bytes\n", total_len);
+		cifs_buf_release(pSMB);
+		return -E2BIG;
+	}
 	pSMB->DataCount = cpu_to_le16(count);
 	parm_data->list_len = cpu_to_le32(count);
 	parm_data->list[0].EA_flags = 0;
-- 
2.53.0

