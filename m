Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ACF42BC4F
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 22:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066649; cv=none; b=UzQQRr0IqGzhWefIoMbmrfcjySWvWAZv45A6LJBc7rN7rxwk2+YTsmg3jt5wUYs0JFpqLdWeAx/0VwhDl6GubZDN1FOUBa8IdLaJ7Aq+ra0XsimvZG59VYWL7MfF2kn3t4oWFDUVjTy92PKzbW36uCMCFliaYX+bmYq4Y0+JuPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066649; c=relaxed/simple;
	bh=CBnmXv2ygQkcGy+DeKnyT0kOgfageZ2TncikK5xl4/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iowieBXaBdvn8HDBEln/SuIDi583xhplwgURJK75KyID2WldWKOtxGytvG28ECmye1ldq7jtzpEt58uqji50q0oGw/GtOArkht2eUw/bUgvxFRCxhwc8eyeOHX6fPg3C2dRipsrkrI9kBqSn4XK3BE/Oe8wGhPTAwuAz0lagjwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XO3zXZ2a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XO3zXZ2a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8291F00A3A;
	Tue, 14 Jul 2026 22:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784066648;
	bh=mnAFNbWtzkbjSjERLazqc9UJJZdjntZjq/JunHprQag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XO3zXZ2a+3+VHbRg7syD6d0n8BDKwJrUQB+XlvIVTZF858tWca2hoTVxZicF4FIiu
	 cEv16umv2bYoEEipg6jgkjLokVWEumkEcc8P+Ej0pX5BPN3nQ19CHrzY5Y86RzJUQW
	 zedY00/oN4XIMm1wMJFKrMbNlZVyLsC7gTp3R7mA9B9sF3YBbDdz1Y6me+m96rgDjh
	 BlOL0K6Em1eKOjj1RkpUQaIYsOEzq32RNp/OKrV7kPyRgDmwn+TmetBopd6P9yYGa3
	 1zPWELoAPTIxGDXtNd/SSQ2sipoiRKyfSfDRd49cRbORYlIMV93C728WTHvtZu2iG5
	 rgzIDrWPO+kjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jakob Koschel <jakobkoschel@gmail.com>,
	"Paulo Alcantara (SUSE)" <pc@cjr.nz>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/5] cifs: remove check of list iterator against head past the loop body
Date: Tue, 14 Jul 2026 18:04:02 -0400
Message-ID: <20260714220405.3333589-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714220405.3333589-1-sashal@kernel.org>
References: <2026071312-blank-founding-5203@gregkh>
 <20260714220405.3333589-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakob Koschel <jakobkoschel@gmail.com>

[ Upstream commit 00c796eecba4898194ea549679797ee28f89a92f ]

When list_for_each_entry() completes the iteration over the whole list
without breaking the loop, the iterator value will be a bogus pointer
computed based on the head element.

While it is safe to use the pointer to determine if it was computed
based on the head element, either with list_entry_is_head() or
&pos->member == head, using the iterator variable after the loop should
be avoided.

In preparation to limit the scope of a list iterator to the list
traversal loop, use a dedicated pointer to point to the found element [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: 53b7c271f06b ("smb: client: restrict implied bcc[0] exemption to responses without data area")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2misc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
index 1014e6d105a12b..f6be821bb8bb5c 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -154,19 +154,18 @@ smb2_check_message(char *buf, unsigned int len, struct TCP_Server_Info *srvr)
 		struct smb2_transform_hdr *thdr =
 			(struct smb2_transform_hdr *)buf;
 		struct cifs_ses *ses = NULL;
-		struct list_head *tmp;
+		struct cifs_ses *iter;
 
 		/* decrypt frame now that it is completely read in */
 		spin_lock(&cifs_tcp_ses_lock);
-		list_for_each(tmp, &srvr->smb_ses_list) {
-			ses = list_entry(tmp, struct cifs_ses, smb_ses_list);
-			if (ses->Suid == le64_to_cpu(thdr->SessionId))
+		list_for_each_entry(iter, &srvr->smb_ses_list, smb_ses_list) {
+			if (iter->Suid == le64_to_cpu(thdr->SessionId)) {
+				ses = iter;
 				break;
-
-			ses = NULL;
+			}
 		}
 		spin_unlock(&cifs_tcp_ses_lock);
-		if (ses == NULL) {
+		if (!ses) {
 			cifs_dbg(VFS, "no decryption - session id not found\n");
 			return 1;
 		}
-- 
2.53.0

