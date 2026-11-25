Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605976;
	b=btgCL6H5RaKu7vCutQjezeMRw+RMTQRtLpp+koKfZSUuw48DvZTG9yTWmDlDCpf/E+9s
	 3KCK3GZndjFvv/MFMH0UOW4N/WcHJEX6I4trCBSUtTzJer07m8EMrl4bh8dYsry3aRysM
	 DUEBrrt8sHNo5vIPJX2nXKH5i01uJwnlw71+qJd/h4H2LNEnBgVLFqjH8estviynzlFKM
	 vBPKFjFopv/iP9hi9u5D8W2VQU3DDDTInlLrJ/1xWhXZ85XhssRfrl9b6C8CUo/m3S8uX
	 5OCgD+oProM59ZGE4umTLEWFVb2CuYhfTQSQzRZyT4XtOXKJ56l/etvnwx8nSGew5EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605976;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=uhZCm9KiTyI74LKC5ZiDiSam6MMP84VNwWNM1LhGT0o=;
	b=D+EN9nhkn+h45ToXKe/zHxJbwwc/W5Hhm3FP6xuu8bv0WT1IJnOUxQkoaubu8XcB2oZD
	 /drB1wwWhbOsfqaP1geuvEKL2PWn3UmUWYnUOR5xMIxFhh/7hFRZcntm97RxmCD/LUUPF
	 7Hut/KbMg5nHFkmsYx38tvUGqfvXpeX7QWJPS/YCl7d0udQ0ZjZVrv+fjVrugcxwI3U6I
	 pNfNrff40FZ65dPKLXk7WaqhTPzJMy5UMq3yHosx7adbNURo6/5F3v+/uV46Mjzbgb/yg
	 zYRSxnhDSYWGAxC/SwjG3GVK40MDY0cXPfsTZ/RHq1KNS5S0qbSn15wh847sZBIu3xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=eZBolF1K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD36606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=eZBolF1K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBE41F000CA;
	Wed, 25 Nov 2026 11:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795605976;
	bh=uhZCm9KiTyI74LKC5ZiDiSam6MMP84VNwWNM1LhGT0o=;
	h=Subject:To:Cc:From:Date;
	b=eZBolF1KpPfuM0g0OBqcsxQ8OU1rvNicjRB+yEJxopryc7cIdp2CEyUIS75lwJxvL
	 msXIzdzikqaHGU6ZjiSG3lzYwuwAj7gJgBPvOfRY9txpzJvqQfpnIteJDExuuYC3dQ
	 KBVtzxvO4eShHGTJIcPEjf/PKrCKQx3BRT8yFS/I=
Subject: FAILED: patch "[PATCH] smb: client: bound invalid NTLMSSP signature diagnostic" failed to apply to 5.15-stable tree
To: yfzhang23@stu.pku.edu.cn,linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:10:11 +0100
Message-ID: <2026112511-natural-provolone-2579@gregkh>
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
git cherry-pick -x 0584b02669c3e76188097174b4f25ed13723e94c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112511-natural-provolone-2579@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0584b02669c3e76188097174b4f25ed13723e94c Mon Sep 17 00:00:00 2001
From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
Date: Tue, 3 Nov 2026 10:45:19 +0800
Subject: [PATCH] smb: client: bound invalid NTLMSSP signature diagnostic

The NTLMSSP Signature field is an eight-byte binary value and need not be
NUL-terminated. decode_ntlmssp_challenge() prints it with %s on the
signature-mismatch path, so the diagnostic can continue beyond the received
blob until it encounters a zero byte.

KASAN reports:

  BUG: KASAN: slab-out-of-bounds in string
  Read of size 1
  string
  vsnprintf
  _printk
  decode_ntlmssp_challenge

Print the fixed-width field with the bounded hexadecimal format.

The patched kernel reaches the invalid-signature path and returns -EINVAL
without a KASAN report.

Fixes: 0b3cc858003b ("[CIFS] NTLMSSP reenabled after move from connect.c to sess.c")
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
Cc: stable@vger.kernel.org
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index c1fc90726e2d..fe006e9f2e10 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -666,8 +666,8 @@ int decode_ntlmssp_challenge(char *bcc_ptr, int blob_len,
 	}
 
 	if (memcmp(pblob->Signature, "NTLMSSP", 8)) {
-		cifs_dbg(VFS, "blob signature incorrect %s\n",
-			 pblob->Signature);
+		cifs_dbg(VFS, "%s: blob signature incorrect: %8phN\n",
+			 __func__, pblob->Signature);
 		return -EINVAL;
 	}
 	if (pblob->MessageType != NtLmChallenge) {

