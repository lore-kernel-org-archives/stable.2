Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310094AFE23
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443346; cv=none; b=A61VKwzrMzrH0eTuBy7QyjNn4b8uV08KoZF6kW8HlrmZIVgXPYEUkj9UIXImDyRMkV0JXtNg063mNMGbes7Hygq5R60kh+FYCyCyKFMjMZqEZUnpxr5uLwrikXxSxXQTpZ95+TEAQixJUwDBvXZfDgGWatzTraLotG95HapuL1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443346; c=relaxed/simple;
	bh=iC2209fcC4wrrMnDWJavHzMDK968ouGLD/Kml9YK2ao=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VCY97jmPWr43mA7tQDE1Qne7gvesitIGju2xYlrZWG3FM8EERatEl0w9FhN04NNZy2tKsa+BBnhw6x5vIxTxZ7ZVE7YnTk7sq1m7lBvaDHMLSZ9pRS6u/CrTN2bp2aqZwMH19bbWTV6JRjvPwq2I56Z+Cm2Lj0lh14rHzynBfbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LFxKc/07; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LFxKc/07"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CE61F00ACA;
	Thu,  3 Sep 2026 13:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443332;
	bh=BEoe+zc5XchyrxdPYOMYI6Vf3XOfiT5knOQIw8VOiZk=;
	h=Subject:To:Cc:From:Date;
	b=LFxKc/07skTC98mUFq0kDMvD7CfQqADpv9tl6gINxMmpg+6rYT3gYVjRaf5+Cu89q
	 q89p1xdAy9hEX1nDGzgcMRzEYpDglp+UCpESwgB+TNwFw+24jZGjGGrH7oNksQrxr3
	 4MWCBGWTxk3KLiZSj9e91BeMDYUG/O//ePY+OIyk=
Subject: FAILED: patch "[PATCH] smb: client: fix OOB read/write from unvalidated DataOffset" failed to apply to 6.18-stable tree
To: sorenson@redhat.com,grayhat@foxmail.com,linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:27:02 +0200
Message-ID: <2026090302-bronco-shame-0d3f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 6343c1da561962688f203362d80d6a3bfa39fa1b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090302-bronco-shame-0d3f@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6343c1da561962688f203362d80d6a3bfa39fa1b Mon Sep 17 00:00:00 2001
From: Frank Sorenson <sorenson@redhat.com>
Date: Tue, 11 Aug 2026 21:41:26 -0500
Subject: [PATCH] smb: client: fix OOB read/write from unvalidated DataOffset
 in coalesce_t2()

coalesce_t2() computes data pointers directly from server-supplied
DataOffset fields with no validation against buffer bounds:

  data_area_of_tgt = (char *)&pSMBt->hdr.Protocol +
                     get_unaligned_le16(&pSMBt->t2_rsp.DataOffset);
  data_area_of_src = (char *)&pSMBs->hdr.Protocol +
                     get_unaligned_le16(&pSMBs->t2_rsp.DataOffset);
  data_area_of_tgt += total_in_tgt;
  ...
  memcpy(data_area_of_tgt, data_area_of_src, total_in_src);

A small DataOffset can push a pointer below the actual byte area,
overwriting header fields; a large one can push it past the buffer
end, causing out-of-bounds heap reads (source) or writes (target).
The BCC overflow guard does not prevent this: BCC reflects how much
data is present, while DataOffset controls where in the buffer it
starts.

The "validate target area" comment present since the function was
first written in 2005 was a placeholder that was never implemented.

Add lower- and upper-bound checks for both data pointers before the
memcpy, and before any target header fields are modified.

Fixes: e4eb295d38b5 ("[PATCH] cifs: Handle multiple response transact2 part 1 of 2")
Cc: stable@vger.kernel.org
Reported-by: Shen Yongchao <grayhat@foxmail.com>
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/smb1transport.c b/fs/smb/client/smb1transport.c
index 966f2cf83a51..66daa5a37e4a 100644
--- a/fs/smb/client/smb1transport.c
+++ b/fs/smb/client/smb1transport.c
@@ -375,12 +375,31 @@ coalesce_t2(char *second_buf, struct smb_hdr *target_hdr, unsigned int *pdu_len)
 	data_area_of_tgt = (char *)&pSMBt->hdr.Protocol +
 				get_unaligned_le16(&pSMBt->t2_rsp.DataOffset);
 
-	/* validate target area */
 	data_area_of_src = (char *)&pSMBs->hdr.Protocol +
 				get_unaligned_le16(&pSMBs->t2_rsp.DataOffset);
 
 	data_area_of_tgt += total_in_tgt;
 
+	/*
+	 * DataOffset fields are server-supplied and not validated against
+	 * buffer bounds; check both data pointers before mutating the
+	 * target header.
+	 */
+	if (data_area_of_tgt < (char *)target_hdr +
+				sizeof(struct smb_t2_rsp) + sizeof(__le16) ||
+	    data_area_of_tgt + total_in_src >
+	    (char *)target_hdr + CIFSMaxBufSize + MAX_CIFS_HDR_SIZE) {
+		cifs_dbg(VFS, "%s: target data area out of bounds\n", __func__);
+		return -EPROTO;
+	}
+	if (data_area_of_src < second_buf +
+				sizeof(struct smb_t2_rsp) + sizeof(__le16) ||
+	    data_area_of_src + total_in_src >
+	    second_buf + smbCalcSize((struct smb_hdr *)second_buf)) {
+		cifs_dbg(VFS, "%s: secondary data area out of bounds\n", __func__);
+		return -EPROTO;
+	}
+
 	total_in_tgt += total_in_src;
 	/* is the result too big for the field? */
 	if (total_in_tgt > USHRT_MAX) {

