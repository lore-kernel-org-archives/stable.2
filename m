Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700903;
	b=s2Vw170JiPBrvw0a1S7DcB+TpQ0PyWnO+oHKqf0BAo/24THWO9ZRr0cOTIFALbHZ0YU/
	 N/Fm5mwILd6VajaWEBwHEKiqc2WI3jc/YN5mbSn0W4V6rIeBfKzXC59zrrF3qXgpDpl6P
	 ok5/Z+JH8GpeT2XfywX4sPzTOjBgiBLof1QSVIko+u8fqIXSMShs3CslnHOFfvBVkDzst
	 w3wajM4Z2idxKDuhGSG9nO+mnVOB3gIMngvoVoEvH+FL1vzUgoIrc9x+wNXxVG9jEZ2U7
	 lUgcGTs3rjh/srYGqoGK1kjBTzZl1eZ8ErP8hzVVRw3/BRPg23M34aVPO+Keu7EeCVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700903;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bLdPty+DTuSHqzQctslTxDVxNNMGVDfqJ4av1q8h4Fs=;
	b=h36+k4fBQ1j85Wo2TdDgu/F3uFC7CctmLmKz/cErDDharU50MEnxg3priLsNFAn0jn5b
	 BY9bR0+aZ9U06SObqMS6ANy8TztxRm0amiDSi1Yxv32lzJclKK/xoz1ivEZQk56SvNkFt
	 hAsK/bS/26eeyOErJN12WocxhTK4wsAKLDFYNYS4wqy9HdwgNrNdYwN1O3VwEMPwFLEc0
	 cbszAtcsi9rSEnRuiIpAcdUP57rsVrzGjlVAQ8vkGmwDHyvBWeuAy/5JKD3aAm7aqwV0R
	 QevzcZYKixaFhNvnjtWxIgrYh9hLIQ3GPJXtJcTsCyPulatwM93gxHPHLgemrmFkYpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=TMXQra1z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C3E606BFBB
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=TMXQra1z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE981F00A02;
	Tue,  3 Nov 2026 10:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793700902;
	bh=bLdPty+DTuSHqzQctslTxDVxNNMGVDfqJ4av1q8h4Fs=;
	h=Subject:To:Cc:From:Date;
	b=TMXQra1zfsoJYFKHXAFY6kLYuxIGK8vb3rKAAYz3w/UU9mAar7bf1+njqUwHqb2FH
	 BcD0h/kd2zZO4EFLM6/v/GOACpYH3ld8D4YN+5OA5uC1prNgnSxa+EAK9pgS3vFNpW
	 C948GN979dZ8fW6nHZhjOXuvIdEmf1ot4smasyXU=
Subject: FAILED: patch "[PATCH] ksmbd: accept share config responses from ksmbd-tools before" failed to apply to 5.15-stable tree
To: mike.michalo@gmail.com,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:15:00 +0100
Message-ID: <2026110300-underwent-entrench-2c0e@gregkh>
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
git cherry-pick -x 4f1ce9ffb996a524acf864316479a7806ae500c6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110300-underwent-entrench-2c0e@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4f1ce9ffb996a524acf864316479a7806ae500c6 Mon Sep 17 00:00:00 2001
From: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
Date: Mon, 19 Oct 2026 21:11:16 +0200
Subject: [PATCH] ksmbd: accept share config responses from ksmbd-tools before
 3.5.3

ksmbd-tools releases before 3.5.2 do not have the payload_sz field in
struct ksmbd_share_config_response; the field occupies the last word of
their reserved[] area, so the kernel always sees payload_sz == 0 from
them.  ipc_validate_msg() and share_config_request() used to treat
payload_sz == 0 as "legacy userspace" and skip the payload size checks.

That case was removed by
commit f25e93768fcc ("ksmbd: prevent out-of-bounds reads in share config
responses").
With payload_sz == 0:

 - the IPC$ (pipe) response fails the final message size comparison:
   these tools always send a one-byte payload, so msg_sz is
   sizeof(*resp) + 1, but the expected size is now computed as
   sizeof(*resp) + 0;
 - every other share fails "payload_sz <= veto_list_sz".

In addition, ksmbd-tools before 3.5.3 copy a global "veto files" setting
into the IPC$ response, so with such a configuration IPC$ also fails the
now unconditional "veto_list_sz > payload_sz" check, even though pipe
shares never use a veto list.

ksmbd_ipc_share_config_request() then returns NULL and every tree
connect fails with STATUS_BAD_NETWORK_NAME, so ksmbd cannot serve any
share when used with these ksmbd-tools releases, for example the 3.5.1
package shipped by Ubuntu 24.04.  Login still works, which makes the
failure look like a configuration problem:

  CIFS: VFS: BAD_NETWORK_NAME: \\127.0.0.1\IPC$
  CIFS: VFS: \\127.0.0.1 failed to connect to IPC (rc=-2)

When payload_sz is zero, derive it from the size of the message actually
received and store it back in the response, so that the checks in
ipc_validate_msg() and the path and veto list parsing in
share_config_request() all use the same bound.  The response is the
kernel's own copy made by handle_response(), and msg_sz has already been
checked to be at least sizeof(*resp), so this cannot underflow.  All
checks added by that commit then apply unchanged, bounded by the bytes
that really arrived, and newer ksmbd-tools that fill in payload_sz are
unaffected.  Also skip the veto list size check for pipe shares:
share_config_request() reads neither the path nor the veto list for
them.

Tested in QEMU with ksmbd-tools 3.5.1 and 3.5.7 and the in-kernel SMB
client over loopback, with and without a global "veto files" setting.

Fixes: f25e93768fcc ("ksmbd: prevent out-of-bounds reads in share config responses")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index e550aa41ad2c..f5cfc320500e 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -532,11 +532,25 @@ static int ipc_validate_msg(struct ipc_msg_table_entry *entry)
 		if (entry->msg_sz < sizeof(struct ksmbd_share_config_response))
 			return -EINVAL;
 
+		/*
+		 * ksmbd-tools releases before 3.5.2 leave payload_sz zero.
+		 * Derive it from the size of the message actually received so
+		 * the checks below bound the payload for those releases too.
+		 */
+		if (!resp->payload_sz)
+			resp->payload_sz = entry->msg_sz -
+				sizeof(struct ksmbd_share_config_response);
+
 		if (strnlen(resp->share_name, sizeof(resp->share_name)) ==
 		    sizeof(resp->share_name))
 			return -EINVAL;
 
-		if (resp->veto_list_sz > resp->payload_sz)
+		/*
+		 * Pipe shares carry no veto list, but ksmbd-tools before 3.5.3
+		 * copy a global "veto files" setting into the IPC$ response.
+		 */
+		if (!(resp->flags & KSMBD_SHARE_FLAG_PIPE) &&
+		    resp->veto_list_sz > resp->payload_sz)
 			return -EINVAL;
 
 		if (resp->flags != KSMBD_SHARE_FLAG_INVALID &&

