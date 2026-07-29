Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF8048D89E
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332109; cv=none; b=fSsu91ANtRFAbxl4qo++zlcVf8gEp05PXuJWxgHLzoIZGJhg8pfHiflh4ypFzqkHXYnpKVtfROG0p2T05gnEyJpja7l4Ri2x+DdyK/2we7OuOIity4zMCogazqbTo0f6A8AM6T+h9mYdxNgfD+wggCQz4VwtYpTZDUJuut7i34Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332109; c=relaxed/simple;
	bh=WmydhRM9b/1cU4PkkQAefTr7EjYJDxkVm2+QFVnsw7Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZMpHcd3UNcvhQVftBUqxX+ymA1mXI0DvI/aPXJvYOUAQVzj3xnfmRGRUcwcxawS64k9J9I/c2Q85YZwqpKnFn0aR/HryzcnJqQ1KG2xnJtxcn6fsEGsbxFvPnpREaVy++Wge1SSrGzovZNBSqtumCvNgiy8KpU6xZ4P/sz0WRbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cxron5ji; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cxron5ji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6ED1F000E9;
	Wed, 29 Jul 2026 13:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785332107;
	bh=0y+j5+I0yfqk02WHV0bqB383G9NDZX0B1WbA/whVu6w=;
	h=Subject:To:Cc:From:Date;
	b=cxron5jijhcE/P0jKoZtZEVYYvJu4C1VnOYyJJBIx6/28RX7fV3OLhCxgMtpiEHiP
	 62tSjE/I5VHH6obYDZgNgok430NMHc6dfLCM2TJl265FxXA/yxWj0lifaAq4MdxSsv
	 k7VKr36cYzjFQvelrrKAhEXb84dUZgk3v7NSpLVs=
Subject: FAILED: patch "[PATCH] mptcp: decrement subflows counter on failed passive join" failed to apply to 5.10-stable tree
To: zhaochenguang@kylinos.cn,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:34:45 +0200
Message-ID: <2026072945-unsalted-ozone-c2bf@gregkh>
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
git cherry-pick -x f3ca0ee2cc308e33896536789cbc5f3a12ca7b30
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072945-unsalted-ozone-c2bf@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f3ca0ee2cc308e33896536789cbc5f3a12ca7b30 Mon Sep 17 00:00:00 2001
From: Chenguang Zhao <zhaochenguang@kylinos.cn>
Date: Wed, 22 Jul 2026 00:14:38 +0200
Subject: [PATCH] mptcp: decrement subflows counter on failed passive join

mptcp_pm_allow_new_subflow() increments extra_subflows before
__mptcp_finish_join() on the passive MP_JOIN path.

In case of race conditions, the subflow is dropped without calling
mptcp_close_ssk(), so the counter is not rolled back.

Call mptcp_pm_close_subflow() when the join completion fails to
decrement the subflows counter.

Fixes: 10f6d46c943d ("mptcp: fix race between MP_JOIN and close")
Cc: stable@vger.kernel.org
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260722-net-mptcp-misc-fixes-7-2-rc5-v1-1-6fb595bc86ef@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cb9515f505aa..b32f0cd262a7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3907,6 +3907,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	mptcp_data_unlock(parent);
 
 	if (!ret) {
+		mptcp_pm_close_subflow(msk);
 err_prohibited:
 		subflow->reset_reason = MPTCP_RST_EPROHIBIT;
 		return false;

