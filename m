Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701221;
	b=eZY4EzImsKefxe02dADXu7Dm1WWL+Oe2RVh0SaCwygRs6m0x23OUjSVLCreAHwuhuVAD
	 92MF/OYDqmfcFkbsjj0W41ykq31oLAzh3FoAcGUduU4NN4gHsPMWzkxWUrGt40j7qgRvc
	 Q9FFY0E/3qGsEM32oJ98yqKDZSU6xPsu7Hsry6+7bem83VL2zH3+6RYiBwh6lFSLPP88U
	 7pH7GAOb2LI573qnW0TxZvY9LFSeeVZhjacK9g7iRySWIMwOx89FHnyLXzXo2pcaG0JVR
	 KQ3YhI5qbxDRSEuhx4yC6xaCldv7zldz9pZBS408u7lk/suIJ1AUGGlrT0NXxFExuMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701221;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=uLEND9KUb4XGJChcqLcjvq5YDMuPfIEbWaHUotOysFk=;
	b=IqK+/04A7cJgZ8Zj9fLZJaIybWiZWt4F3W644C0t38eIRwt6iNNPD3ZaQAXvZ0zlTkj6
	 MeJ1lX77uDxSB8P9OZhLCzf12t4GeFbutI0UXs1Of5O0KO5AliQtR77OoVy4C9Kk3vCF8
	 ajWuDIEioZKzJr0UqW67y/B426afPgR6yTfL34wunBCmOB9daeMxX2zhVPK9v0mIidQ4X
	 yO5z3nfMZ9kLd7Evt7lCvFeDC+fHeniD3Huy6eSZ4afPEUhuW39mjjyCJReFQa0k7HW4R
	 4sCFdREyU1M9FNWHfhbu8gglufWA78yHoUvtqlQ4ctN32MmPYpecOAGNKG6lUetWFHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=N9RPbKdw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D737F606A80B
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=N9RPbKdw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7602E1F00919;
	Tue,  3 Nov 2026 10:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793701220;
	bh=uLEND9KUb4XGJChcqLcjvq5YDMuPfIEbWaHUotOysFk=;
	h=Subject:To:Cc:From:Date;
	b=N9RPbKdwcomQUm8FzVb/ogdRKbxDnKBxYxatudHG/zxlDE1RnRjMV3BbcRb4SAS82
	 xRnuacYU866jsHyU6Th4MzlEoGi+7VweKo2SANxXd0H1hP/Yp0IS1EdLCYyGyVADM1
	 c5UXfXB2Y/AvtiX9ylJqxWzL7YHBWqIRr4+ZwNrA=
Subject: FAILED: patch "[PATCH] ksmbd: validate security descriptor offsets before pointer" failed to apply to 6.1-stable tree
To: linkinjeon@kernel.org,ratnaker.gautam@kuleuven.be
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:20:19 +0100
Message-ID: <2026110319-default-yelp-9aa0@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3474e1a304fbf9f7c996b24adcd519e031227a90
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110319-default-yelp-9aa0@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3474e1a304fbf9f7c996b24adcd519e031227a90 Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 17 Oct 2026 09:44:48 +0900
Subject: [PATCH] ksmbd: validate security descriptor offsets before pointer
 arithmetic

parse_sec_desc() constructs SID and DACL pointers by adding untrusted
32-bit offsets to the security descriptor before checking their bounds.
The existing checks reject offsets into the descriptor header, but do
not reject offsets beyond the descriptor's length.

On a 32-bit kernel, a large offset can wrap the pointer before the
descriptor. The end-only checks in parse_sid() and parse_dacl() can then
accept it, allowing an authenticated SMB2 SET_INFO request to access
memory outside the security descriptor and fault the kernel.

Check each nonzero offset against acl_len before constructing its
pointer. Initialize the optional owner and group SID pointers to NULL
so an omitted SID remains absent when parsing the DACL.

Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Cc: stable@vger.kernel.org
Reported-by: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 96428df33b43..f3b1efd8e85a 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -900,7 +900,7 @@ int parse_sec_desc(const struct mnt_idmap *idmap, struct smb_ntsd *pntsd,
 		   int acl_len, struct smb_fattr *fattr)
 {
 	int rc = 0;
-	struct smb_sid *owner_sid_ptr, *group_sid_ptr;
+	struct smb_sid *owner_sid_ptr = NULL, *group_sid_ptr = NULL;
 	struct smb_acl *dacl_ptr; /* no need for SACL ptr */
 	char *end_of_acl = ((char *)pntsd) + acl_len;
 	__u32 dacloffset;
@@ -912,12 +912,7 @@ int parse_sec_desc(const struct mnt_idmap *idmap, struct smb_ntsd *pntsd,
 	if (acl_len < sizeof(struct smb_ntsd))
 		return -EINVAL;
 
-	owner_sid_ptr = (struct smb_sid *)((char *)pntsd +
-			le32_to_cpu(pntsd->osidoffset));
-	group_sid_ptr = (struct smb_sid *)((char *)pntsd +
-			le32_to_cpu(pntsd->gsidoffset));
 	dacloffset = le32_to_cpu(pntsd->dacloffset);
-	dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
 	ksmbd_debug(SMB,
 		    "revision %d type 0x%x ooffset 0x%x goffset 0x%x sacloffset 0x%x dacloffset 0x%x\n",
 		    pntsd->revision, pntsd->type, le32_to_cpu(pntsd->osidoffset),
@@ -933,9 +928,12 @@ int parse_sec_desc(const struct mnt_idmap *idmap, struct smb_ntsd *pntsd,
 	pntsd->type = cpu_to_le16(DACL_PRESENT);
 
 	if (pntsd->osidoffset) {
-		if (le32_to_cpu(pntsd->osidoffset) < sizeof(struct smb_ntsd))
+		if (le32_to_cpu(pntsd->osidoffset) < sizeof(struct smb_ntsd) ||
+		    le32_to_cpu(pntsd->osidoffset) >= acl_len)
 			return -EINVAL;
 
+		owner_sid_ptr = (struct smb_sid *)((char *)pntsd +
+				le32_to_cpu(pntsd->osidoffset));
 		rc = parse_sid(owner_sid_ptr, end_of_acl);
 		if (rc) {
 			pr_err("%s: Error %d parsing Owner SID\n", __func__, rc);
@@ -951,9 +949,12 @@ int parse_sec_desc(const struct mnt_idmap *idmap, struct smb_ntsd *pntsd,
 	}
 
 	if (pntsd->gsidoffset) {
-		if (le32_to_cpu(pntsd->gsidoffset) < sizeof(struct smb_ntsd))
+		if (le32_to_cpu(pntsd->gsidoffset) < sizeof(struct smb_ntsd) ||
+		    le32_to_cpu(pntsd->gsidoffset) >= acl_len)
 			return -EINVAL;
 
+		group_sid_ptr = (struct smb_sid *)((char *)pntsd +
+				le32_to_cpu(pntsd->gsidoffset));
 		rc = parse_sid(group_sid_ptr, end_of_acl);
 		if (rc) {
 			pr_err("%s: Error %d mapping Owner SID to gid\n",
@@ -975,9 +976,10 @@ int parse_sec_desc(const struct mnt_idmap *idmap, struct smb_ntsd *pntsd,
 		pntsd->type |= cpu_to_le16(DACL_PROTECTED);
 
 	if (dacloffset) {
-		if (dacloffset < sizeof(struct smb_ntsd))
+		if (dacloffset < sizeof(struct smb_ntsd) || dacloffset >= acl_len)
 			return -EINVAL;
 
+		dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
 		rc = parse_dacl(idmap, dacl_ptr, end_of_acl,
 				owner_sid_ptr, group_sid_ptr, fattr);
 		if (rc)

