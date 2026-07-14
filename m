Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9133D48034C
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040070; cv=none; b=PqzcL7xMc4CkwrmZJwJPkuhqPay9AsahIob7eBfAWArqnGamEq9/ji+bThlyzQtFiCLh4kRWYu7DznH+74Qmn0fLa3mgzNkYZbVlql0SVNIKh7JyfZNIOK8UqvzpQOrya114sf1wZJINe5Y7xz0jV8XHLPx4AKd+SPM5I/DSEuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040070; c=relaxed/simple;
	bh=t+A9U+rUce4IiWlCu15lTWwL6NpJBr0Ymc0BGuzj65o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EpPIWhN7+pia3GT6SZoVFBV7Etytpm38/hxshPVENLdTYDHSCZ4equavyiPSx0BKA9tljggJlYcvl2/6yZB/6zgLYhqFgUeW9N4X75ZXyCdgYOkj55lbmK0o5bs3eDwJob02DCcqpmDu7SkpP088EA7FFLh/Kkjx/ZXzY7RNfno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LGwVz6oN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LGwVz6oN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093951F000E9;
	Tue, 14 Jul 2026 14:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784040060;
	bh=rxonamjs/XdC1SeLX0EljOt8RAMvZ8OWfW3tIlwcY5Q=;
	h=Subject:To:Cc:From:Date;
	b=LGwVz6oNKsTkDUAIVrFM82vMUU76TwNrm7hIZuVw23foO8T+iRU+e5Mi9hNXYvVlp
	 NF/53V9AcnE/88uokog3r2r6B8i7fkAZ062eDr3gk+rXQArVHTncmAkiHpIOlfim0l
	 nUrh5GwZS5SyfDdAxVa/ZxGxImzONv7BK/wfTl0I=
Subject: FAILED: patch "[PATCH] smb: client: Fix next buffer leak in" failed to apply to 5.15-stable tree
To: haoxiang_li2024@163.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:40:54 +0200
Message-ID: <2026071454-probe-applicant-d9c0@gregkh>
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
git cherry-pick -x 1c6267a1d5cf4c73b656f8181b310cbbb3e4767b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071454-probe-applicant-d9c0@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1c6267a1d5cf4c73b656f8181b310cbbb3e4767b Mon Sep 17 00:00:00 2001
From: Haoxiang Li <haoxiang_li2024@163.com>
Date: Tue, 23 Jun 2026 09:45:38 +0800
Subject: [PATCH] smb: client: Fix next buffer leak in
 receive_encrypted_standard()

receive_encrypted_standard() allocates next_buffer before checking
whether the number of compound PDUs already reached MAX_COMPOUND. If
the limit check fails, the function returns immediately and the newly
allocated next_buffer is not assigned to server->smallbuf/server->bigbuf,
making it leaked.

Move the MAX_COMPOUND check before allocating next_buffer.

Fixes: b24df3e30cbf ("cifs: update receive_encrypted_standard to handle compounded responses")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 2964f461fc84..c862a98e52df 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -5111,6 +5111,12 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 one_more:
 	shdr = (struct smb2_hdr *)buf;
 	next_cmd = le32_to_cpu(shdr->NextCommand);
+
+	if (*num_mids >= MAX_COMPOUND) {
+		cifs_server_dbg(VFS, "too many PDUs in compound\n");
+		return -1;
+	}
+
 	if (next_cmd) {
 		if (WARN_ON_ONCE(next_cmd > pdu_length))
 			return -1;
@@ -5134,10 +5140,6 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 		mid_entry->resp_buf_size = server->pdu_size;
 	}
 
-	if (*num_mids >= MAX_COMPOUND) {
-		cifs_server_dbg(VFS, "too many PDUs in compound\n");
-		return -1;
-	}
 	bufs[*num_mids] = buf;
 	mids[(*num_mids)++] = mid_entry;
 

