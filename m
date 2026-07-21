Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4EF372B41
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784623391; cv=none; b=pDkh9z9pnjEYa8zLCbeA1X1OVgKHON2Om4ZCDO/hPOCqhyt4v0YDNo7c5oTwb5d51M+bLz+eBHdA1r4Npuf27O5/+8zzNCT8VkZdBfQKAbDq6SCQkNQMUySrBsiwglomKwi0yD7mIsbDWO7IV50siHteLecXL6tfm8cromX65Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784623391; c=relaxed/simple;
	bh=nDmkWdwEQYcRGfuG9PFPe/PeiK8051vulnTxLmbYMOk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LqZUdt4sXHSb4wkIi84vcjWVyBFdW6piH9G1XzFzAj5eYTHRAkr7nDKXf/Jb4JApUL8aK/lZsWEhprtWzFLw4qBtlhSIBJadx5X5i3RBQo/7viavQhZhVCPTwDclqNmwkQRGPXTGkx9uLTqAebigI161Yt+a6Tpz+rc7DbOb59g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pNlY3UzF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pNlY3UzF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679DA1F000E9;
	Tue, 21 Jul 2026 08:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784623389;
	bh=mt/R7rY9Tat+pgvAOfX4MjqDXIWRWf7JhRs7gl/aCB8=;
	h=Subject:To:Cc:From:Date;
	b=pNlY3UzFQv86d+yKgY6awzm3xeKAsHalinpm9+YfNZj+PyYOTHILo+j1BeusRskbQ
	 WjGcV58IBVHtHk9K8lrq3p9izMtNIV00Uh3pcJOzq8gPBP1Nk1uqKr01TZuNuemC5+
	 ASC4ZkQnGQ6+rzGXY/fJZNL0QM0CdRFpYU0FsMA0=
Subject: FAILED: patch "[PATCH] ipmi: fix refcount leak in i_ipmi_request()" failed to apply to 6.6-stable tree
To: vulab@iscas.ac.cn,corey@minyard.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 10:42:52 +0200
Message-ID: <2026072152-astute-spore-9b56@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x a3f3859cecacb64f18fd446271ece9a3b3f2d4de
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072152-astute-spore-9b56@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a3f3859cecacb64f18fd446271ece9a3b3f2d4de Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Wed, 3 Jun 2026 12:06:34 +0000
Subject: [PATCH] ipmi: fix refcount leak in i_ipmi_request()

When a caller provides a `supplied_recv` message to i_ipmi_request(),
the function increments the user's `nr_msgs` reference count. If an
error occurs later, the out_err cleanup path only frees the recv_msg
if the function allocated it itself (i.e., !supplied_recv). In the
supplied_recv case the cleanup is skipped, leaving the reference count
elevated. The caller ipmi_request_supply_msgs() does not release the
supplied_recv on error, so the reference is permanently leaked.

Fix this by explicitly reverting the reference count operations when a
supplied recv_msg with a valid user pointer is present in the error
path: decrement nr_msgs and drop the user's kref.

Cc: stable@vger.kernel.org
Fixes: b52da4054ee0 ("ipmi: Rework user message limit handling")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Message-ID: <20260603120634.3758747-1-vulab@iscas.ac.cn>
Signed-off-by: Corey Minyard <corey@minyard.net>

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 7ca2cacbaa05..ab4c85f3d6fe 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -2345,6 +2345,10 @@ static int i_ipmi_request(struct ipmi_user     *user,
 		if (smi_msg == NULL) {
 			if (!supplied_recv)
 				ipmi_free_recv_msg(recv_msg);
+			else if (recv_msg->user) {
+				atomic_dec(&recv_msg->user->nr_msgs);
+				kref_put(&recv_msg->user->refcount, free_ipmi_user);
+			}
 			return -ENOMEM;
 		}
 	}
@@ -2418,6 +2422,10 @@ static int i_ipmi_request(struct ipmi_user     *user,
 			ipmi_free_smi_msg(smi_msg);
 		if (!supplied_recv)
 			ipmi_free_recv_msg(recv_msg);
+		else if (recv_msg->user) {
+			atomic_dec(&recv_msg->user->nr_msgs);
+			kref_put(&recv_msg->user->refcount, free_ipmi_user);
+		}
 	}
 	return rv;
 }

