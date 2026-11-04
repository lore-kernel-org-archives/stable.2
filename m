Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817009;
	b=uoRA3DnNztn6haGhMFRsSMwPsb1HeENSLE61/BpoeUPSCtIQPGypC28jWHrFx4T3fP02
	 RSuUWaruNm6y1zOIsTWTqUzPmYoQEyEs43EdnBziyVeI9+n/57u4b8gQFOPGLf44FjYjz
	 R9wq7AggIVPP34NmVcNSzG3XKB5kqmNAAiC6nhnWnp+FtQAdqAOh7VVXZRde2loDIfq4S
	 QJOY2jJrvZUQb8IvcFtm28i65WlEBvoV+pAvPj8OO1LDHr8sKvAgaoo+7IL2BqxRtFYvk
	 zv9fk228Wa2nMQaFKDwcfg/4aN7ZMLC/9mPLVEa+aU4Cw1YTQxAOldBMI4PI33ilokA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817009;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=POdaj+WpDN+EaJ8YQ7ozstUE7Mlpj3zGRbWTwSh+la0=;
	b=WhGDkMwbpvlaXpOITUnaUsZWV6X3UZKffUukR51ypoPkXjyoYlJNnTPUphycmSxk7a5X
	 lj4JqC4/nQgDJVoAhEO3dewpZk9YOraPcjtUfOSF/xK2xFEwgnjzJjoWggK6hFW2BaNXq
	 +9bM/MR/sdjFB7iPKRhaxwNBYxfUb82bFPOMB98ZCwHpP+tOWMa6uoky2VHFisFtMxgyO
	 IUG5U9Gr6u9EUWved4fNGf3U0hBv0+LIJUK67s6h9HCRPoXOsjf/G6ZJ4+RZc7CJ6ABeg
	 TzkgTtGh+txbPyTcgBLIlbhj9/GF/TvGXO5X4KQZSjnPVr1VrQ/9+ExOcgIL03lLh8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=wN25CQwT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98B2606A32D
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=wN25CQwT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826B71F000C1;
	Wed,  4 Nov 2026 18:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793817008;
	bh=POdaj+WpDN+EaJ8YQ7ozstUE7Mlpj3zGRbWTwSh+la0=;
	h=Subject:To:Cc:From:Date;
	b=wN25CQwTXE1BmRPNHbRTdf+4TOxd0rCkXJkoV/2FrIVMZwWxBo3V6aPW3vy9t71Sa
	 grRtfq3+CDOena+ggSkYv/E5FxTRlXd+7UvpfTw68SKNjoAGNmnn5pRn0X8/31vrbY
	 hxXxv4SPTxJWaA+VWZhUSvUQwNerxob1lzECQIrI=
Subject: FAILED: patch "[PATCH] smb: client: bound POSIX lock data area by response length" failed to apply to 6.6-stable tree
To: ratnaker.gautam@kuleuven.be,linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:30:06 -0500
Message-ID: <2026110406-dismantle-scariness-905f@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8fc9af68c57156ff64769f30e831553cd03b3000
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110406-dismantle-scariness-905f@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

