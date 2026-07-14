Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1E848167E
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040135; cv=none; b=UCFUjj4ZaXNdByTNQmyF13oS3lCZnvyl+lwyXYCIgCK4PUrQgWdJjlKmRoPomOzrPRXaB/isEkuNA2+FAhfmCV7btW7pERCXejER3mghEN0bcvsETgNI56QJP3vgccNUIEeGgglJvxtungFYxNAVjbTIOyF4DHlnQDUfNHGjfs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040135; c=relaxed/simple;
	bh=9biIILWh7k8Vh+whNh6JsE5SQ+zQ3MaUtXGtDBogfh0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YwXlnW0DwzPtXAmly44dTlIaWWpSC9b/fZd0dmQaIRZGVnOcChiFijg+kFlaKjrI0qBIPsbJ6AGALLoDCOYqsgwx8U10aohpXeoE/peiiMaJ6oeo4NGP6j6XHjANMQY4ru9LGcijQvlarnlrAur9oztF6r8bi8TyAlrjE2GjZY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E/gdniEV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E/gdniEV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42D91F00A3E;
	Tue, 14 Jul 2026 14:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784040120;
	bh=PQ3qI01d79B6drAV4v2aw9Eb4uZ4VGPVr865XW3QceM=;
	h=Subject:To:Cc:From:Date;
	b=E/gdniEVudRhZXOFB+mVovRZZVLenDZ6v98MaPO611tVxThGiogqGI5ukXNfBYCtA
	 GnIxr3VO+q0Nsjv7Ze209bbDMI6Na99RSdUQ9CNsNBVzm+78Ycb8QYyNNqh+/IIg4G
	 +wEcS/7DO88KXlUTcNlIbR9CqZS3qXqUfYfzg+2E=
Subject: FAILED: patch "[PATCH] smb: client: mask server-provided mode to 07777 in" failed to apply to 5.15-stable tree
To: nmanthey@amazon.de,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:41:54 +0200
Message-ID: <2026071454-wolf-talcum-3f10@gregkh>
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
git cherry-pick -x e3d9c7160d483fc8f9e225aafad8ecbbc43f3151
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071454-wolf-talcum-3f10@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e3d9c7160d483fc8f9e225aafad8ecbbc43f3151 Mon Sep 17 00:00:00 2001
From: Norbert Manthey <nmanthey@amazon.de>
Date: Thu, 9 Jul 2026 15:54:39 +0000
Subject: [PATCH] smb: client: mask server-provided mode to 07777 in
 modefromsid

When modefromsid is active, parse_dacl() applies the server-provided
sub_auth[2] value from the NFS mode SID to cf_mode without masking to
07777. Apply the correct masking, same as in the read path.

Fixes: e2f8fbfb8d09c ("cifs: get mode bits from special sid on stat")
Signed-off-by: Norbert Manthey <nmanthey@amazon.de>
Assisted-by: Kiro:claude-opus-4.6
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index 07cf0e578233..9424281a7674 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -962,7 +962,7 @@ static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 				 */
 				fattr->cf_mode &= ~07777;
 				fattr->cf_mode |=
-					le32_to_cpu(ppace[i]->sid.sub_auth[2]);
+					le32_to_cpu(ppace[i]->sid.sub_auth[2]) & 07777;
 				break;
 			} else {
 				if (compare_sids(&(ppace[i]->sid), pownersid) == 0) {

