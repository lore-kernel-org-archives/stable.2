Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB2D432BD6
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560208; cv=none; b=q8Z08pwI30VikIx9p541z1/+teamiLxNKaiGK/TmqWvfUrD1MKttA5GC/TsAhb8lbrCnd2oHQIEQ1+r7rI3dZ4SXjQ6821v/T4ezBgMYOqveaBWxVA3fYXcLQJDf6n7l3e3oSXBvqEy1Opou5AISkMqO7BDd4fIFzV8rzans9eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560208; c=relaxed/simple;
	bh=Wh27N65lYJ/5ORurkFliOtVWSjrzOqOkWwC6h+4BGOU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ceV8OuYBSO5j0QCWC0N918WjPLsmPxL/uX/74QDnxxwT5b7h8OhK4+UIeUVUMZweYL3omg+74q4L/b4mDbkWqmPbXQGutuN0ncIOk8aNLk6y1zacFaWHt24X3u8iKjh2V2cJVmg2b4otFJQtw8mf2wrLzM8Fre9wN465YLM5uHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vc+4vu+o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vc+4vu+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB971F000E9;
	Mon, 20 Jul 2026 15:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784560207;
	bh=j7S/tbjNgO1TGvJakiHeQSB3HIldjuTIOuIO6ngvEpU=;
	h=Subject:To:Cc:From:Date;
	b=Vc+4vu+onxPXDN9xOOWbeRCSREuQKuwxC/zXd8t1liTznPUCIxXXhJhDxHz0+vECp
	 xeNyh/wwE3iy5RpycaO9pdDtLZH0ie8Egr5fCIAm36mw246uqMuLqvIKwk3tfMZnUl
	 vwaDHgrJC9F8kOHDqZBYop5Eag0YFRM2iRSxdNFM=
Subject: FAILED: patch "[PATCH] nvmet-auth: reject short AUTH_RECEIVE buffers" failed to apply to 6.12-stable tree
To: michael.bommarito@gmail.com,hare@kernel.org,kbusch@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:09:58 +0200
Message-ID: <2026072058-flattery-mammogram-5fea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 779575bc35c687697ba69e904f2cd22e60112534
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072058-flattery-mammogram-5fea@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 779575bc35c687697ba69e904f2cd22e60112534 Mon Sep 17 00:00:00 2001
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Tue, 9 Jun 2026 14:24:31 -0400
Subject: [PATCH] nvmet-auth: reject short AUTH_RECEIVE buffers

nvmet_execute_auth_receive() trusts the AUTH_RECEIVE allocation length
after checking only that it is nonzero and matches the transfer length.
In the SUCCESS1 and FAILURE1/default states, that lets a remote NVMe-oF
initiator reach the fixed-size DH-HMAC-CHAP response builders with a
kmalloc() buffer shorter than the response, so nvmet_auth_success1() and
nvmet_auth_failure1() write past the allocation; both only WARN_ON the
short length and then format the message anyway.

Impact: A remote NVMe-oF initiator with access to an auth-enabled target
can trigger a 16-byte heap out-of-bounds write via a one-byte
AUTH_RECEIVE allocation length.

Compute the minimum response length for the current DH-HMAC-CHAP step in
nvmet_auth_receive_data_len() and report a zero data length when the
host-supplied allocation length is shorter, so the existing zero-length
check in nvmet_execute_auth_receive() rejects the command before any
builder runs. The SUCCESS1 minimum is sizeof(struct
nvmf_auth_dhchap_success1_data) plus the HMAC hash length, because the
response hash is written into the rval[] flexible-array tail, so the
minimum is state dependent rather than a flat sizeof. CHALLENGE keeps its
existing variable-length guard in nvmet_auth_challenge().

This is reachable only when in-band DH-HMAC-CHAP authentication is
configured on the target.

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5-5-xhigh
Assisted-by: Claude:claude-opus-4-8
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 0a85acf1e5c7..45820a12750d 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -493,7 +493,31 @@ static void nvmet_auth_failure1(struct nvmet_req *req, void *d, int al)
 
 u32 nvmet_auth_receive_data_len(struct nvmet_req *req)
 {
-	return le32_to_cpu(req->cmd->auth_receive.al);
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	u32 al = le32_to_cpu(req->cmd->auth_receive.al);
+	u32 min_len;
+
+	/*
+	 * Reject too-short al before kmalloc(al), since the SUCCESS1 and
+	 * FAILURE1/default builders write fixed response headers into it.
+	 */
+	switch (req->sq->dhchap_step) {
+	case NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE:
+		return al;
+	case NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1:
+		min_len = sizeof(struct nvmf_auth_dhchap_success1_data);
+		if (req->sq->dhchap_c2)
+			min_len += nvme_auth_hmac_hash_len(ctrl->shash_id);
+		break;
+	default:
+		min_len = sizeof(struct nvmf_auth_dhchap_failure_data);
+		break;
+	}
+
+	if (al < min_len)
+		return 0;
+
+	return al;
 }
 
 void nvmet_execute_auth_receive(struct nvmet_req *req)

