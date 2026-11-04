Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817012;
	b=uGx6jC3i0o37zZyciQwetHBFhLyCcr8XKHk+uWyQkbhbDS5RU12qLAD30YQxJZNdF+Zf
	 dW1X+z4k/ok/+xHR9u+Qe1kj4zv1p+tGU/4dCjjjKId/51p96qcwaWVprpW8UPprNQCcf
	 Efm46nlsWcAH3rc4H+SfBlaZxUzZXVN3KfHz9j7GBRnlvVTRYX6S2UWa3O3zyWbLKZzN/
	 NVrwZmzR1TfFU4MkftNIg4PiypqDRMzOM9czx4ux/YCDUn3c1jxheesfACFRVEBQQZ1hU
	 ZJp5qjR04gmXPqvM0gZuG7G9UDQt6zwnAPxoKBh04iN6EhDHLhRw+Z+MSpNeMbIFtiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817012;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sW0jFwIhF6aDD7le3vcV8/9m53YNhdPEaVOssKEevYU=;
	b=tAqgU0znXMObtpUqFKK3M79ThVcwodUxez8VDriuHICbXtrJZLR957xFZ7ets0BJnPkF
	 PxBZ9NywCKR+KgnR6W0MO653PEQrA8t0BKXu90UTB63XcJZvX7kkiPWcGPI9Bao2iMzew
	 4wTK+IbLyPaUD7MezjfiVrB3+nWu9taF9iVryFmcgP91vAgY+WsRRe+geNVJ/km+a0jUj
	 b5MmM6lSU5bvcFljOhxaV+huN3AldbtRyAnWUMo1DRRErXj5/Tqp/5P+fMUq0fIB24vpg
	 70mWIHYW7UEp3VJLHr7CKcwCOzs0rQ0Ch3/WW3dY2l0tRudj89t3VJK4NGX+vYmXZyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=fsJ6YOjX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3EC606A32E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=fsJ6YOjX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2321F000C1;
	Wed,  4 Nov 2026 18:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793817012;
	bh=sW0jFwIhF6aDD7le3vcV8/9m53YNhdPEaVOssKEevYU=;
	h=Subject:To:Cc:From:Date;
	b=fsJ6YOjXdHtHvj9nCeNR7ZVyTxn1M3b6XuwQTUfXgIGemAhNQp7/B070O+jFpzzmw
	 /rHdvuNi8Mlho45ZPCy2pFxplxNFGqtgvxxR1jwzvwOA/Nuk2/GZ/tP+u+FLkTzwl9
	 RYiBkaPZ6SkcZnw2DK9P10EJa4dPjmydsmgnhq2c=
Subject: FAILED: patch "[PATCH] smb: client: bound POSIX lock data area by response length" failed to apply to 6.1-stable tree
To: ratnaker.gautam@kuleuven.be,linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:30:07 -0500
Message-ID: <2026110407-custody-treadmill-c8a2@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8fc9af68c57156ff64769f30e831553cd03b3000
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110407-custody-treadmill-c8a2@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8fc9af68c57156ff64769f30e831553cd03b3000 Mon Sep 17 00:00:00 2001
From: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>
Date: Sun, 18 Oct 2026 00:49:33 +0200
Subject: [PATCH] smb: client: bound POSIX lock data area by response length

CIFSSMBPosixLock() receives a TRANS2 response whose server-provided
DataOffset and DataCount are not required by validate_t2() to describe an
interval inside the response. A server can therefore make the client read a
cifs_posix_lock beyond the response buffer and return those kernel bytes
through F_GETLK.

Use smbCalcSize() to obtain the full response length after any multipart
TRANS2 reassembly, then reject data areas that extend past it before
dereferencing them.

Fixes: fc94cdb94462 ("[CIFS] Fix new POSIX Locking for setting lock_type correctly on unlock")
Reported-by: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>
Cc: stable@vger.kernel.org
Signed-off-by: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 50ca062a22bf..e335686a68f2 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -2369,6 +2369,7 @@ CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
 		cifs_dbg(FYI, "Send error in Posix Lock = %d\n", rc);
 	} else if (pLockData) {
 		/* lock structure can be returned on get */
+		unsigned int rsp_len;
 		__u16 data_offset;
 		__u16 data_count;
 		rc = validate_t2((struct smb_t2_rsp *)pSMBr);
@@ -2380,11 +2381,18 @@ CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
 		}
 		data_offset = le16_to_cpu(pSMBr->t2.DataOffset);
 		data_count  = le16_to_cpu(pSMBr->t2.DataCount);
+		rsp_len = smbCalcSize(&pSMBr->hdr);
 		if (data_count < sizeof(struct cifs_posix_lock)) {
 			rc = smb_EIO2(smb_eio_trace_lock_data_too_small,
 				      data_count, sizeof(struct cifs_posix_lock));
 			goto plk_err_exit;
 		}
+		if (data_offset > rsp_len ||
+		    data_count > rsp_len - data_offset) {
+			rc = smb_EIO2(smb_eio_trace_lock_data_area,
+				      data_offset, data_count);
+			goto plk_err_exit;
+		}
 		parm_data = (struct cifs_posix_lock *)
 			((char *)&pSMBr->hdr.Protocol + data_offset);
 		if (parm_data->lock_type == cpu_to_le16(CIFS_UNLCK))
diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index 2708bedb49ab..5331ce6dc8b3 100644
--- a/fs/smb/client/trace.h
+++ b/fs/smb/client/trace.h
@@ -44,6 +44,7 @@
 	EM(smb_eio_trace_ioctl_no_rsp,			"ioctl_no_rsp") \
 	EM(smb_eio_trace_ioctl_out_off,			"ioctl_out_off") \
 	EM(smb_eio_trace_lock_bcc_too_small,		"lock_bcc_too_small") \
+	EM(smb_eio_trace_lock_data_area,		"lock_data_area") \
 	EM(smb_eio_trace_lock_data_too_small,		"lock_data_too_small") \
 	EM(smb_eio_trace_malformed_ksid_key,		"malformed_ksid_key") \
 	EM(smb_eio_trace_malformed_sid_key,		"malformed_sid_key") \

