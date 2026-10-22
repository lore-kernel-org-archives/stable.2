Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674815;
	b=GP7wOcZhtUds6rCToq23or6WH2Bx09c7qU07iI91Pyv4OleL+8K6SUdFKXgJ2c6KT1ze
	 4rsyBbsH4m61veStNJk/WzfUdNAKG1b58Jm0B8T/GIuzfJFU5/KGE6llJtWdcjVa4WM3A
	 E0oiIhvx7szqw/MbY/67M6ku+ZnGOIYhK14nMYyQQBMVeoyeKBQqAGP7V4ABPtbQd/sPN
	 CLvWOKlZPp5PjGsi0ZtSSIJjxP43bPAd/trRvmTHLz6n7L+4oiRSmvqYz88v2dunuByvt
	 fLDCMvDc3K31C7jl9FD4jCXmsQ8DE3xC1CnRFMW3HaMSXIbZU+yxURXShsdcvxBU+BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674815;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HBU2JAX/Uahk8sTo1Fq6WZ1og9Ox736tkI4PCIo7RsU=;
	b=UY6UAZyPb+z2hoWd99mSY+rg8vm3b9n/nZQvr9BcmQcinUyhZTltxYsiTtJbgjlJR07c
	 D3h7qBCjIGbpB6wNwnCghMXwsAp6sF89qhlqGdMEp/Lyqz8UfH7zOCN3e7PGEaNVy3mNU
	 UA4qAdCiiGr6oeAp3XHfEp/DxOGJ4IWBSQtFlbu4+UeUfWXulbpBiuatL8kzR1c+xMvpM
	 xcWlG41M0mCQ+h+lEyCokFUiVAAWiEWN+cl5m2u+1H99PxS2yirCZKJTON0+Q3KTRqkGP
	 3V2YRtorglZ5B13UXI27GTqz+DRGvQu53uKrmdGIiEoCR9YTHsl59cV8iG/0vbTOtUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PhVgj29W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC881606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PhVgj29W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB611F000C1;
	Thu, 22 Oct 2026 13:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792674814;
	bh=HBU2JAX/Uahk8sTo1Fq6WZ1og9Ox736tkI4PCIo7RsU=;
	h=Subject:To:Cc:From:Date;
	b=PhVgj29WOsx0LasbDOIPjKfPmkP3wDJfT+YxWL5GfFHFS/8oc+3vIcec0PFT2kFKF
	 j6uOwLR9j+S4JBSrmoqEDs9CsObbjy7b6i4gX+1/0f6XFIdS7g/3oPD5MpHZtaw3dW
	 NOiEAQAHE/Zo4eTCSjW7lrexIvBOlYafYtoh5EeQ=
Subject: FAILED: patch "[PATCH] smb: client: reject SetEA requests that do not fit the" failed to apply to 5.15-stable tree
To: shionthanatos@gmail.com,gmwgg05@gmail.com,jupmouse@gmail.com,linkinjeon@kernel.org,npczmd@qq.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 22 Oct 2026 15:11:29 +0200
Message-ID: <2026102229-snack-quotable-d6f5@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 4aa2c106aef4bf3dfd97c30842db0767b26e8428
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102229-snack-quotable-d6f5@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

