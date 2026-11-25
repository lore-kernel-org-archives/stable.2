Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605973;
	b=KUCalW62nBamzQ+CIxiqVeEzmD4c7tiGVzKj4U+IB1kzy5o65fybyt5CAX4ES9SysH6h
	 6tp9j0D8GPlAySFbJBfDgfWgiF/dGknHKDX9B3w/BUC4JUCZaSmfCZu0fq9sK0ru40q0g
	 h7CAJjAQJ0bCFeJ7fVJ75x6SBfzs/Bupuk0W9KnvfAiSb1/GsoxeWMig7NstzB3HRf+xB
	 HFKyrREeUOm/eBzvTOZ5Xc4jsmgUkvxRzwFIg+BuPtfN73ZWcT92JHuZ+96m4K6fUNVlJ
	 wAYQE5hCrQA74RHqSM75j9vPKyUKE7N1TzHK6RtK6B4J7AzFpt8xdhafBGO/c4nDN4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605973;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nFwiswYhU/9VIhfXUDu+QT2++bi8Gs0rDC3VzXQHf6k=;
	b=cTRMjF2TS2Ahs652wDRjaK87LdZxW8louSC5hQxyTMSg5JaPTV3DmDv5abhF1dJw/EdG
	 /OJcPK7bB+R1X/vJQSnJ9bp6IgxKI3VkjgYDMsETRDF2Pez/c7D+/Wu/VxEfHQ/Ea6xz4
	 PoSqJ1odSacY7tAZfBuzrhMrefCbrHjytdcbT7o51Qv6vyMjBOjEmKMp+2yZ4XCgYZ6Ku
	 TblxrXi/7Cva+sekSzHyoLeElfV6Rr6hwVojFXnW23OIzxUX8fN3REf6//EC1f0fi0xn2
	 8y+7em2ov+ZofO0cnqZG+TPXxpdF3ohJeoOsJ7EHJMQdbQdadifiuRnUg10CO/VfUOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zLMemW29;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805FE606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zLMemW29
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BD71F000CF;
	Wed, 25 Nov 2026 11:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795605972;
	bh=nFwiswYhU/9VIhfXUDu+QT2++bi8Gs0rDC3VzXQHf6k=;
	h=Subject:To:Cc:From:Date;
	b=zLMemW29vr52GhqpsIymcJ4+hX1Wb7jukobwHsvhzc58Pfx9/azsi0LIh5Q6Q0DFK
	 YDWJm5C3+4o19R7OMl4I0/R2xfz2JaupTuNQgDNDefxWDBZn3GAIPqBdgQi0ArlDp3
	 j6KSGEP/+eP4Gj9KEpsts5170ldDj9AqFLnRWvao=
Subject: FAILED: patch "[PATCH] smb: client: bound invalid NTLMSSP signature diagnostic" failed to apply to 5.10-stable tree
To: yfzhang23@stu.pku.edu.cn,linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:10:11 +0100
Message-ID: <2026112511-calamari-disabled-3216@gregkh>
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
git cherry-pick -x 0584b02669c3e76188097174b4f25ed13723e94c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112511-calamari-disabled-3216@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

