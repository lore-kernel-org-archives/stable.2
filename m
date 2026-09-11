Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738C330FF1D
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 09:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789119889; cv=none; b=N/5kjNu95JdBdlqtarmaJsnJEcVmHDxRC/zOJmYrvcai4Mf2mAfh2Iv9JBmXPm1EySRFpoh1wLrnrNAEz2lpES7VKhgSUwXgz+7jSWUKFx42qG9EZ995YQvkSIo09aYCJr2+7h+CBkziEcVt8dle+VPYCJ2NGhOlfn9zeCqBVcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789119889; c=relaxed/simple;
	bh=N0UG3ZikMPsVLFuo/p30QgzGJgMzj8ihW/UfwVzRXQk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eM7VWLRkkcUJ5ItYqNT/TpvF/gGqrpFIW746Gm2/zR80nL2VQwS759rqDMs4HxhvbSlmQkkm9/i3a4z0afTtDSEOyn/AT3ZK2ojVtjQz2niTocv04TTc79uHxKy5dmzCGzMmjoiPnZ/LIESboHwUJIl7cYMQBeIemzBjzHAKbBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aP05ygs7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aP05ygs7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6AE1F000FF;
	Fri, 11 Sep 2026 09:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789119887;
	bh=S+1a/a2jbnsr/awAWW6kg9s9WvQYjcCWxFNt9QPIvdw=;
	h=Subject:To:Cc:From:Date;
	b=aP05ygs7LfXkSLKdN6G/io0AmaXtB+kyuoFWGNcSvb4LeR+jr4VwCeOFGiRPw1JGM
	 D7/2PT5UHpyq6MqQoeUg+/BlHZ8I/Taw7hCTYbCSQG2olR/Sj9kT3urCi3LU0l0k0P
	 ZcRc6SIvySM0Xp47HuXO6nmtBgcK+dVJIJk1ayig=
Subject: FAILED: patch "[PATCH] ksmbd: zero pipe read compound padding" failed to apply to 5.15-stable tree
To: linkinjeon@kernel.org,cheryl@renat.io
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 11 Sep 2026 11:44:25 +0200
Message-ID: <2026091125-profusely-shortcut-0dad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 73f860489e3be2245598d1819226304fc5b87291
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091125-profusely-shortcut-0dad@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 73f860489e3be2245598d1819226304fc5b87291 Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 25 Aug 2026 09:31:35 +0900
Subject: [PATCH] ksmbd: zero pipe read compound padding

Compound response handling extends the last response iov to an eight-byte
boundary.

smb2_read_pipe() allocates only the payload size, so the alignment padding
can expose up to seven bytes of uninitialized kernel heap memory.

Allocate the aligned size and clear the unused tail before pinning the
response buffer.

Fixes: e2b76ab8b5c9 ("ksmbd: add support for read compound")
Reported-by: Cheryl Babcock <cheryl@renat.io>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index ba0fe25bf366..8c589110460a 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -8657,13 +8657,18 @@ static noinline int smb2_read_pipe(struct ksmbd_work *work)
 		}
 
 		aux_payload_buf =
-			kvmalloc(rpc_resp->payload_sz, KSMBD_DEFAULT_GFP);
+			kvmalloc(ALIGN(rpc_resp->payload_sz, 8),
+				 KSMBD_DEFAULT_GFP);
 		if (!aux_payload_buf) {
 			err = -ENOMEM;
 			goto out;
 		}
 
 		memcpy(aux_payload_buf, rpc_resp->payload, rpc_resp->payload_sz);
+		if (rpc_resp->payload_sz & 7)
+			memset(aux_payload_buf + rpc_resp->payload_sz, 0,
+			       ALIGN(rpc_resp->payload_sz, 8) -
+			       rpc_resp->payload_sz);
 
 		nbytes = rpc_resp->payload_sz;
 		err = ksmbd_iov_pin_rsp_read(work, (void *)rsp,

