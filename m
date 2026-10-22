Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674803;
	b=cRq2xDguE+RofC1hdeK2rKKFRcbfHvXnVfshkNgRhnzxMFVqq0tOQ/KN9msa3BtFR3t3
	 DJWd4j1HsYKX+VfCwzQHrd0JepC+XYdK38509+8Zx6yPXZ2Cfdv7A7N1ClkOruYpwuBsv
	 UzGrHSHJJ5AaBg8L7OBazWefc8CvTFQLBd165RIMhpT2O5W55PgQkyl2MsCbNvNmSGSyL
	 3Hd9IeGqMypYJe1dasPy78yjj/I1F6TxjCFeJaji7rPYFCQMdYPNw+Z73v0E3d+sSmQ+Y
	 OBulkAJMIXMlAAeJ+PxOoA1aGC/oQJwAujisLINP2nb18VqG17b6NMojBOgBWwUql1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674803;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Lzk7TBoGk9ieFXTTHUgP0ZVoOFd3EIs0XtcwQdYq8q4=;
	b=1jrMr7gr7ZjxTdK59Wuo6NJz5k3IIOVZbzWkM1mfevUgyXouChxuO2huX36Amz0fnnlt
	 Mza4jrwqNbSadKk2UwMKN6mOLTG/I84+R+jzjCiJwhM431CoRyop6sfVY1nDdb4J6SCaB
	 RrvzGth0Z37++uYpENYjymxxRLIzJSVIYNS8oQN3CNrsmQgRJc1uFCb/gf/haE2cmdjV8
	 rZMhEn6WnlBzEcitDf6KW2cyWt0Y3ybIDnOiXUkDs9Tcz7FTgVzWSlxttgV7I8fadxhwK
	 4DR/hREvNp9guWAQXa25/0u3n1JqHgnq3P91B3gCuS5QWBLl9ziTVBCIoMpMGWSN9YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ycpQRqxT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CB5606A31E
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ycpQRqxT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3961F000C1;
	Thu, 22 Oct 2026 13:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792674802;
	bh=Lzk7TBoGk9ieFXTTHUgP0ZVoOFd3EIs0XtcwQdYq8q4=;
	h=Subject:To:Cc:From:Date;
	b=ycpQRqxTJi+y7hjwltdhIBzl6T8rcKKBNCgV+oDQ+B1xwciQWiDKY2wIRL22BL6v3
	 rUShbExmIqfrKxRFeGhNREV4hUrFxgm9ACfrWSXd9jIF4zR/WOu94y+doqgh25LdeM
	 3ARgCPLqGGuU9Rbb4P/Rv0KhcVtgKrE+55M2pnts=
Subject: FAILED: patch "[PATCH] ksmbd: fill in FileSysIdentifier in FS_POSIX_INFORMATION" failed to apply to 5.15-stable tree
To: haa@amicon.ru,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 22 Oct 2026 15:09:45 +0200
Message-ID: <2026102245-boned-daylong-f86a@gregkh>
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
git cherry-pick -x db2267b27c054a6c2151ff7fbb67927e784f31d6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102245-boned-daylong-f86a@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From db2267b27c054a6c2151ff7fbb67927e784f31d6 Mon Sep 17 00:00:00 2001
From: Aleksandr Khromov <haa@amicon.ru>
Date: Tue, 25 Aug 2026 10:19:21 +0900
Subject: [PATCH] ksmbd: fill in FileSysIdentifier in FS_POSIX_INFORMATION

smb2_get_info_filesystem() reports 56 bytes for FS_POSIX_INFORMATION,
that is the whole of FILE_SYSTEM_POSIX_INFO, but never assigns
FileSysIdentifier.  Those eight bytes go to the client as they are found
in the response buffer.

The buffer is zeroed on allocation, so a standalone request leaks
nothing.  A compound request can leak: the offset of the next response
is advanced by the length pinned for the previous one, so a reply that
was written into the buffer and then dropped in favour of the short
error response of smb2_set_err_rsp() stays there, and the next reply is
laid over it with only the header cleared.

Report the file system id statfs() returned, which is what the field is
for.  FileSysIdentifier is __le64 and f_fsid is a pair of ints, so
assemble the value first, val[0] as the low half, and convert it on the
way out.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Khromov <haa@amicon.ru>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 2fbd9010513e..08cb215c3729 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -7523,6 +7523,9 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 			info->UserBlocksAvail = cpu_to_le64(stfs.f_bavail);
 			info->TotalFileNodes = cpu_to_le64(stfs.f_files);
 			info->FreeFileNodes = cpu_to_le64(stfs.f_ffree);
+			info->FileSysIdentifier =
+				cpu_to_le64((u64)(u32)stfs.f_fsid.val[1] << 32 |
+					    (u32)stfs.f_fsid.val[0]);
 			rsp->OutputBufferLength = cpu_to_le32(56);
 			fixed_len = 56;
 		}

