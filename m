Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED05E387364
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090090; cv=none; b=u0e/V1QENKGaWi9o5weLCtenSaM8htkUG4JQIwwuJTjNiqItLFH3vWgVuYSm8nDQAu9qctWm8Gyd7V4Yckew5JlvmkDopnAjVLddkwulLX6XTB/xmyHMUjOzd5e08HQ3XzpYmALV05iXSM1pYzttNI0dDMsLRrlQPu0ZbvTmKvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090090; c=relaxed/simple;
	bh=7DqbVWipRTnXHDlos/If2hM+9BO8SsE++zCitQOKhVE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Nmg1tDg4dkFPcRoc79LXXbXlcf1BpjjpPGCYLie0tH9nTXGQdmsCMEaq85eYSIZ4AvSrwVBaAreMe1ji0syeSJFLq5iOTz0Fe5LEISEjfGrycnCO3lEaNoHUnsBqU5yG0atDhGdG8EvDyf+W1BDtGGH8/1U0VgBy0BgMi15eITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JNxmRgXV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JNxmRgXV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD01C1F00898;
	Tue, 22 Sep 2026 15:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790090088;
	bh=EvaeQMjhYwuE+E6AKOLQ2E1EZ5oeBc3ZxCG4wCywvq8=;
	h=Subject:To:Cc:From:Date;
	b=JNxmRgXVJDrDYSA/S3BFAwIZw1Y5SLl3woGlh7RvAU08DX4Mg3kE93hRdo8OAYq0A
	 FKHErrBTN5oU6EVq6bDL4G8L4Z0jtDEW+B98l0JZf7SQB2OJkwWysjW3Fy7awRC2jG
	 YnjmuKSl6JcopbayWy+/98JOf2gH2kdzgv3MAXUo=
Subject: FAILED: patch "[PATCH] smb: client: fix missing iov bounds check in" failed to apply to 6.1-stable tree
To: sorenson@redhat.com,dhowells@redhat.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 17:08:45 +0200
Message-ID: <2026092244-scalded-wanting-c9bc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x b09d092eb24ad0110f16a9b7c1ed5d2a0c1733dc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092244-scalded-wanting-c9bc@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b09d092eb24ad0110f16a9b7c1ed5d2a0c1733dc Mon Sep 17 00:00:00 2001
From: Frank Sorenson <sorenson@redhat.com>
Date: Wed, 16 Sep 2026 16:33:58 -0500
Subject: [PATCH] smb: client: fix missing iov bounds check in
 parse_posix_sids()

In parse_posix_sids(), sidsbuf_end is calculated using the server-supplied
out_len without being validated against the actual length of the received
iov (iov_len).

If a server provides an inflated out_len, sidsbuf_end will point past the
end of the iov. This defeats the bounds guards in posix_info_sid_size(),
allowing out-of-bounds reads into adjacent kernel memory.

Fix this by rejecting responses where the calculated sidsbuf_end would
exceed the received iov boundaries or cause pointer wraparound.

Fixes: a90f37e3d7ac ("smb: client: parse owner/group when creating reparse points")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 96063e355186..13fe8e3b48f3 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -77,6 +77,17 @@ static int parse_posix_sids(struct cifs_open_info_data *data,
 
 	sidsbuf = (u8 *)qi + le16_to_cpu(qi->OutputBufferOffset) + qi_len;
 	sidsbuf_end = sidsbuf + out_len - qi_len;
+	if (sidsbuf_end < sidsbuf) {
+		cifs_dbg(VFS, "%s: server-supplied out_len %u caused pointer wraparound\n",
+			 __func__, out_len);
+		return -EINVAL;
+	}
+	if (sidsbuf_end > (u8 *)rsp_iov->iov_base + rsp_iov->iov_len) {
+		cifs_dbg(VFS, "%s: server-supplied out_len %u overruns iov by %td bytes\n",
+			 __func__, out_len,
+			 sidsbuf_end - ((u8 *)rsp_iov->iov_base + rsp_iov->iov_len));
+		return -EINVAL;
+	}
 
 	owner_len = posix_info_sid_size(sidsbuf, sidsbuf_end);
 	if (owner_len == -1)

