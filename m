Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674817;
	b=UEYpo54HkXg0zVUdUk6qKn4UsFQHuf+veK9ncbWCCOaXIKP4JNQvlLZt5lzEGuCXPDB4
	 BwArhh5s7MtWMWBFMynp3Hgw7rNLxhto34H2P+esCFgGOe0UarNRZpM1Fle0ZqR1tdf4e
	 jfghDmJ9G6EUX/Q4BTsiGNplCcFt+D7Lwrg596/jRUdXa7p0xXkyfsTL3iCk2rHjptYJD
	 wOQX3dghTSyCo5b37YvUc8LjNO2THmApPT2tdZoLeTPioGb7WBqA4CkR0sILb+Jztt7bP
	 HTf/xWumxO+LsYrQU/FakZ81UxMMB06r9by6njeNEGjJl6fPMtYPdheAc8K8QuhftNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674817;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cangsGNF/8/N7cnWqtPMq9N2nkhXwEus3DwnGWFj+7A=;
	b=i1T2Rx5xmaqcX39q9dbCJILK6E+zRA9d/LdzysfGqmEbqWB/x1O9g76ERLW4jrR7q+lF
	 3G+gZ+zoM7XqIEckenrfkEPg3g6YUiCrMcGfwtZ2BSYpt/xlXTh4n6AclqsJqHH8ZwjOA
	 pjpUhEgVh/z7xSlsaXTb4bIe2a0tpBxE4jIRnkLe6WjHXO+fcf2bxZhnV2o/pEq0B6MCg
	 6l8DTpdudurxIwlDoxcPAZDxtxt4oYFDt5r60G1wuosiVaIvdDfP4LVj04ndu+Ooh3GXV
	 yagEVJPVvTxNIidG8ZpH7VpL8XeArkHT1wHcLkWJ9TtxWGMlZ69ZVuTUJ76O9YGzMtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=mhpPwWZ7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A97E606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=mhpPwWZ7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA771F000C1;
	Thu, 22 Oct 2026 13:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792674817;
	bh=cangsGNF/8/N7cnWqtPMq9N2nkhXwEus3DwnGWFj+7A=;
	h=Subject:To:Cc:From:Date;
	b=mhpPwWZ71YyzqWaxNpI/2A7pjGa3lbjt2bXDxO9TEUluSPQe15TGcO714yhJ0Yzxy
	 0OAr/T78+xreJPCCpOKG+C1P7CKNIf5uDUSqygUsd3/1mpwp+GddhuZ1C4PBMWCEvr
	 3i/o0uPeFhIUCHq67aqrtbgFdt77coK7fjcPROY4=
Subject: FAILED: patch "[PATCH] smb: client: reject SetEA requests that do not fit the" failed to apply to 5.10-stable tree
To: shionthanatos@gmail.com,gmwgg05@gmail.com,jupmouse@gmail.com,linkinjeon@kernel.org,npczmd@qq.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 22 Oct 2026 15:11:30 +0200
Message-ID: <2026102230-cardiac-properly-0c3f@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 4aa2c106aef4bf3dfd97c30842db0767b26e8428
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102230-cardiac-properly-0c3f@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4aa2c106aef4bf3dfd97c30842db0767b26e8428 Mon Sep 17 00:00:00 2001
From: Yunpeng Tian <shionthanatos@gmail.com>
Date: Sun, 30 Aug 2026 18:46:56 -0700
Subject: [PATCH] smb: client: reject SetEA requests that do not fit the
 request buffer

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

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 230af243247c..f8aa9e7b4bc6 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -6334,8 +6334,10 @@ CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
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
@@ -6387,6 +6389,13 @@ CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
 	pSMB->Reserved3 = 0;
 	pSMB->SubCommand = cpu_to_le16(TRANS2_SET_PATH_INFORMATION);
 	byte_count = 3 /* pad */  + params + count;
+	if (check_add_overflow(in_len, byte_count, &total_len) ||
+	    byte_count > U16_MAX ||
+	    total_len > CIFSMaxBufSize + MAX_CIFS_HDR_SIZE) {
+		cifs_dbg(VFS, "EA request too large: %u bytes\n", total_len);
+		cifs_buf_release(pSMB);
+		return -E2BIG;
+	}
 	pSMB->DataCount = cpu_to_le16(count);
 	parm_data->list_len = cpu_to_le32(count);
 	parm_data->list.EA_flags = 0;

