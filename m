Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B879480DF1
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040095; cv=none; b=JJi453fRTP0qT6vYXjnN1398zkPn9DCiVhdXrCbUBc13igkU/Y4C/qVqtCbMtjRdwT3gxi/DUEyX91A8mEQ28q4TVNlansoQ8XARwv0ZggAIY404voYFsuzb/wQhnVC8l7bkKg4V64Z4Nuibb+EszizYRnXEYuk37WmRJZKHY4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040095; c=relaxed/simple;
	bh=xvXd3YqOkRNSerIHXjtQuPS1pEOjaD0lOy/+CHBpVxQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pRpCwxPJk1r63FTC5aGLWcMh1FP2liXBDTAt32dm33OwGhJTf9n3FMG3XKwm8ZoZtDGWgEhUdN9SGiEQQ0eCAhbW82FcSmhwcGZ25AEJyidv00OWoa1dNToEXGkOKzTRz7kmmaTh00f0tLMUFqtHorW4D890h24Pn4do4zCj55Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fQ2CC9Av; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fQ2CC9Av"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315161F000E9;
	Tue, 14 Jul 2026 14:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784040078;
	bh=5ziP2+d3XN+LOdnUS3sfcAgndTyGfjzxrdSJ/jPiORo=;
	h=Subject:To:Cc:From:Date;
	b=fQ2CC9AvHJk0I0fN3620xG6IyK1a3dClzBYPSZBwckGSfGEFxeQsQEoW0ldbvP+Af
	 9F8Zc/5zGC2d3BPqvxW5eV2KwoOpB0XJ1m6EtWwmrvSgYT/T1J+wsiciocTo43OTVT
	 ZJdVgaLJ2v0Lf3GnLjvyKIzTmOo9oxRbK4ifttyM=
Subject: FAILED: patch "[PATCH] smb: client: use unaligned reads in parse_posix_ctxt()" failed to apply to 5.15-stable tree
To: xizh2024@lzu.edu.cn,n05ec@lzu.edu.cn,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:41:12 +0200
Message-ID: <2026071412-jester-ashamed-7c2e@gregkh>
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
git cherry-pick -x b86467cd2691192ad4809a5a6e922fc24b8e9839
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071412-jester-ashamed-7c2e@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

