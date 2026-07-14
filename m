Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DA33290AA
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040101; cv=none; b=C2ufTeNMo0gnJYLGVK2bV6RXydVMv9tMw+aY0Hwpy7tKevTNt5NcjkMrYOwQ6GPFS5Huohxxe2bFYw/trskpO59miDU7nxUklBIuFXbCi0vaP1oDuZL42fNiAlGrVv3tQgjCUYEK8eVAhoUa2+39+/UtFok/+YTe+0NUsEJu5i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040101; c=relaxed/simple;
	bh=v3vqUpO9DODBJ+Dh7Rbtv8rq3nKbWps7Ij6CWXA+Fo8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tl+S1BP306YwgdgMIN8j3Eq4+7bSFZOC7BEHK3F8Az/z+X8NIwTh8DZ/rcxRIeX+7Fm6ENsFb8U80Op7KiMV2QUVNQl1mvhkcI8oNyQDuijPls+3urX8eTFHwK7melNs45w7wBZQdwZm2EN98NeQ64iRQ1S8B/eVEcgXYWqyT/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QjxVMblu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QjxVMblu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720851F00A3A;
	Tue, 14 Jul 2026 14:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784040086;
	bh=hxppwmxOKEuJzKWgM5MXCQ04xRRCnDDYOElYeNuEi+A=;
	h=Subject:To:Cc:From:Date;
	b=QjxVMbluvH/WlbRLtY+LS36ZAKyarhim2zXDNfShaY7BdXHhQu0ZBF9iGDznLpQil
	 JWMtav4RGGGhRtf8AqvgddjIQX07z50iDoJ9+DBvX8PiRgTiVEn8THZHyVlYYh9diI
	 F5OdukU19gOlnrwFKPh+Kjn/Q4C36Tsd8g8F0HyE=
Subject: FAILED: patch "[PATCH] smb: client: use unaligned reads in parse_posix_ctxt()" failed to apply to 5.10-stable tree
To: xizh2024@lzu.edu.cn,n05ec@lzu.edu.cn,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:41:12 +0200
Message-ID: <2026071412-earring-oozy-27d4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x b86467cd2691192ad4809a5a6e922fc24b8e9839
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071412-earring-oozy-27d4@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b86467cd2691192ad4809a5a6e922fc24b8e9839 Mon Sep 17 00:00:00 2001
From: Zihan Xi <xizh2024@lzu.edu.cn>
Date: Wed, 1 Jul 2026 18:23:21 +0800
Subject: [PATCH] smb: client: use unaligned reads in parse_posix_ctxt()

The server controls create-context DataOffset, so the POSIX context data
pointer may be misaligned on strict-alignment architectures. Use
get_unaligned_le32() when reading nlink, reparse_tag, and mode.

Fixes: 69dda3059e7a ("cifs: add SMB2_open() arg to return POSIX data")
Cc: stable@vger.kernel.org
Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 77738900e75e..95c0efe9d43b 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2396,9 +2396,9 @@ parse_posix_ctxt(struct create_context *cc, struct smb2_file_all_info *info,
 
 	memset(posix, 0, sizeof(*posix));
 
-	posix->nlink = le32_to_cpu(*(__le32 *)(beg + 0));
-	posix->reparse_tag = le32_to_cpu(*(__le32 *)(beg + 4));
-	posix->mode = le32_to_cpu(*(__le32 *)(beg + 8));
+	posix->nlink = get_unaligned_le32(beg);
+	posix->reparse_tag = get_unaligned_le32(beg + 4);
+	posix->mode = get_unaligned_le32(beg + 8);
 
 	sid = beg + 12;
 	sid_len = posix_info_sid_size(sid, end);

