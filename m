Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603252;
	b=p8vDAuwpe4qpoe6V6LsnWC+qweqlub3PUriVG2T5IVIErXII1PEMH8JIBlkdeDPUxsM6
	 VTG7RoMtlez0JanwwnLzOt81iPiJoBl095Hpg1J6+UcqHdaNnIzBN1YzXHYrT1RDJQC0O
	 tohKPZvN9VGK9upbOsCKQ5QpLLIDUK779PGAgIg5Xx19bclIqyZF0OuNjhtfgXJ8axf8T
	 8JaUGsnwSmTlDLsaCrJBcsJm5njpFAY83a6X7YXx5/+Wr9tb34A/m/PKufNfGaUf2GUk1
	 b+5X8pK7kcUiN+gly82AydIHoa2niz/Da46A4hGGfvG5rPkkdwxwVN+5mZqwkPZlwjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603252;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2Ap2wCrH88cbRg0hgRMS+e/Qf5rcyCdRYMdjLraV22o=;
	b=S0GZSwJeWQ4vNO3tN81nYmyy+bn7rgyp4HG5+RYuTTX5m12+KNPUfBkqqaSkJ5g+EbSr
	 Ig4LgX9YHIcR69IF7ktfB8YImfeFdBxDWF3Ci7iMYJPDnYnGfMtc2uEU9Eb0VnVhWlDZF
	 IBBH8JALgKVr0625c9QknH2QbT5ctJ1TTjPJ7WszIqSnVvSinO6f5dTQLzVaLDZzTokKY
	 5+Kg1Lb4nOhAOmmH8LQWKI+Om8tWRTIiv8bpDgQpwUoG6TKYFF6KK1T+a1qp9F2gRijCz
	 l2C9jI4wwTFvAkT7WYKawOZYeUeHqTezskxG3ica7A3XZ/5pL1eIan3dxj0KLgw5emw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=RApmQ3rs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB8B606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=RApmQ3rs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD80E1F000CF;
	Wed, 25 Nov 2026 10:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603252;
	bh=2Ap2wCrH88cbRg0hgRMS+e/Qf5rcyCdRYMdjLraV22o=;
	h=Subject:To:Cc:From:Date;
	b=RApmQ3rsherzwd7vXmy9LbK+dC8QecQ002G4tfdQAcHy0keRN8RGcks4WxEepLCge
	 Fse9C2aEnqktfaIrcoqRDgGaSZPqmTA2vPQXU2ox8mk9/BNzODTKlVjiwbrs0RHqPm
	 1ePQj6yX3ZInPPwNhHe2IS87KoNQhD2Ys+OurC0U=
Subject: FAILED: patch "[PATCH] ksmbd: skip metadata-only stream opens in the delete check" failed to apply to 7.3-stable tree
To: icb@fastmail.org,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:35:07 +0100
Message-ID: <2026112507-uncivil-cesarean-e13f@gregkh>
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


The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 2f14fe2d589583ce649b2bf1b449cc9839abda8b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112507-uncivil-cesarean-e13f@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2f14fe2d589583ce649b2bf1b449cc9839abda8b Mon Sep 17 00:00:00 2001
From: Ian Bridges <icb@fastmail.org>
Date: Thu, 5 Nov 2026 21:53:45 -0600
Subject: [PATCH] ksmbd: skip metadata-only stream opens in the delete check

A metadata-only named-stream open without FILE_SHARE_DELETE blocks a
later DELETE open of the file. It also blocks setting the file delete
pending.

Ignore a stream open unless its effective access includes data, execute
or delete access. Reuse the sharing-access helper so overwriting a
stream, or creating one on an existing file, still counts as
FILE_WRITE_DATA. The Time Machine AFP_AfpInfo synthesis keeps only its
requested access.

Fixes: 19043971c947 ("ksmbd: honor stream delete sharing for base file")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Bridges <icb@fastmail.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index f9079c529d07..c846023e5ada 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -420,7 +420,12 @@ bool ksmbd_has_stream_without_delete_share(struct ksmbd_file *fp)
 		if (file_inode(fp->filp) != file_inode(prev_fp->filp))
 			continue;
 
-		if (!(prev_fp->saccess & FILE_SHARE_DELETE_LE)) {
+		/*
+		 * A stream open with no right in FILE_SHARE_CHECKED_ACCESS_LE,
+		 * implied writes included, never conflicts.
+		 */
+		if (!(prev_fp->saccess & FILE_SHARE_DELETE_LE) &&
+		    ksmbd_sharing_daccess(prev_fp) & FILE_SHARE_CHECKED_ACCESS_LE) {
 			ret = true;
 			break;
 		}

