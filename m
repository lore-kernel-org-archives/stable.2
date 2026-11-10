Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272565;
	b=UTRAPXvk97LVkTIfeC9PIAAUE4h8iRXzoeP+TTOnRGQT2A6Iiof3HwaAytCR1w5/B9cT
	 K7e2Fz+X4ElXUxTKV2rFjg0wecTzeGtxGxHa7s8rYIJhB3aIXmURgtZiaDVcUgNJHIE7h
	 Wbg9GqEb6iZ4MHsrgD0ftcagskir3eT+qfJ5zct21E2hoLp+Kubj7Zv8tcuVoqzuDjAiX
	 9VrbjdRQwSWbRf1LUXnOQ8YiNTN+jtYYIi3Tk7lBk5kejXUFOTZI6cpH9Qofk5b5z/D1B
	 vfan7Fui8Rd6hJmQ75+x4kw9fILHYQcxeyKGz+MlV146xCxo7mc4If9TZual9CLZHEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272565;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Of5dbOj+kgFk/OcJbfEBoUFvKNDp5TVT3Il9N7Q0/Fg=;
	b=VAZjrDnybD3Mf6gihtDiQzGuSB0mnSoHKDizwM5akA+G7UoxX6Y/mFg5s88Cu9Ry0Udb
	 XoX+Z+VztoI71PreDbqn+YZ9ykFWxeoeIsxLl3v1YAwvfMQx60Ovdl8YdKNwc0dsY/nKn
	 HVKtvRV8ObbwbBhLhIEugnyPsT16NEFltUyu+J82uaDEzUSfYK0l65xZcYOscgvMPCo5x
	 uvx+T/lVWXgBhCSG4Yrib3Z3YdqjdG0NgOXbjyWSBnoWvxzvyyP0+4eSX4p5gYQ6TNHRA
	 2+/N/NgldkVjcF6izsenxtQDpVYC8aASyK/YEIvO2Bh2aMVxiOWPkkvNMuXSH2V73xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e04dXme9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35186606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e04dXme9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B221F0089F;
	Tue, 10 Nov 2026 01:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272565;
	bh=Of5dbOj+kgFk/OcJbfEBoUFvKNDp5TVT3Il9N7Q0/Fg=;
	h=From:To:Cc:Subject:Date;
	b=e04dXme9xEPcmD1EhVRyf6yvgjYPt1ZfHPvkuMC3IP06JfKfZxwy9Z658CRiUoWit
	 JCwObOkNxo0Ko1vLrcZuh+dsAVB+55s2/YDSY/ZNxUt4N0nAOtXD9djjDSXSvBoXRJ
	 uH/0uwvNUS5lupL7cRmOulPtjF71PtZacfIvaxO4v3IzZdJALRxZNAtdqdx7iEb+0O
	 n2SIFd8GSeg34AxsOq5BE9Eou+I1WOWkDzBWU+hKBzysQ5gnDoPUTF7wrIeNZGsdRF
	 c5CHCQZ72r2izltjYCf9qzM/UM69pc+QeOgou1TCql74/CpObeyHCjOda1UgvtR4XQ
	 EZ2XfGnsYCltA==
From: Sasha Levin <sashal@kernel.org>
To: icb@fastmail.org,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ksmbd: revert fsids on durable reconnect and replay failure" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:02:43 -0500
Message-ID: <20261109200243-failed-6.18-539223f18026@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 539223f18026448f67d33d09719c355b91db7fd0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200243-failed-6.18-539223f18026@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 539223f18026448f67d33d09719c355b91db7fd0 Mon Sep 17 00:00:00 2001
From: Ian Bridges <icb@fastmail.org>
Date: Wed, 28 Oct 2026 20:28:03 -0500
Subject: [PATCH] ksmbd: revert fsids on durable reconnect and replay failure

On a durable handle reconnect or a request replay, smb2_open() switches
to the SMB user's fsids before calling ksmbd_vfs_getattr(). If that call
fails, the code jumps to err_out2 and skips ksmbd_revert_fsids() at
err_out1. The user's credentials then stay installed on the shared ksmbd
worker. Later work on that worker, including other users' requests, runs
with the first user's fsuid, fsgid and supplementary groups.
ksmbd_free_work_struct() also warns, because work->saved_cred is still
set.

Jump to err_out1 instead. No path is held at this point, so skipping the
path_put() at err_out is correct.

Fixes: c8efcc786146 ("ksmbd: add support for durable handles v1/v2")
Fixes: bb8bf7eb13b5 ("ksmbd: add SMB3 request replay support")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Bridges <icb@fastmail.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/smb/server/smb2pdu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 528bb4ac97e16..2e955d272f4bc 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4530,7 +4530,7 @@ int smb2_open(struct ksmbd_work *work)
 			file_info = FILE_OPENED;
 			rc = ksmbd_vfs_getattr(&fp->filp->f_path, &stat);
 			if (rc)
-				goto err_out2;
+				goto err_out1;
 
 			goto reconnected_fp;
 		}
@@ -4560,7 +4560,7 @@ int smb2_open(struct ksmbd_work *work)
 
 			rc = ksmbd_vfs_getattr(&fp->filp->f_path, &stat);
 			if (rc)
-				goto err_out2;
+				goto err_out1;
 
 			goto reconnected_fp;
 		}
-- 
2.53.0




