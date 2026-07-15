Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7D13ED5B3
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784111563; cv=none; b=eWsC8U9o08O59ajA0TeHpUaLMBLpSAkNZbG+FGQtuPlwbBHWMt5SfBs9aKTVMm/hV/3apQcwPvOD0keYlKeuwALSj1h8zUqoaPIo5zsdkP6dSRvXdSa+9fLg8ZDZiWeD0IOlcBV8SsqRvViRgJQ9bJZKgWUb7bgvEDaEfCLcc9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784111563; c=relaxed/simple;
	bh=G+jxQLoOIHUuwAI6H55dkQsiiF5G2vrwvRKfzoWhPTs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Rsb4MSkRgofBLLkWAt/x1GkWW65HTVvwv+GQyVdYiAdaSqzkYb0aqXnpcENu0547TAR4hehsn8cKf6S7wPu/QboF885z2Jb4WuFoCpcvqoy8cuHm7ip9GvtQ3xXCfStnUm9xOLAbTsYfs3jUeb4QfARoc1gXk5HF4nBVJX85vo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WBEVfWgM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WBEVfWgM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139281F000E9;
	Wed, 15 Jul 2026 10:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784111562;
	bh=90JrngxjswCn226N71mUMPIlKRDrGyR48BQjW8n0iHg=;
	h=Subject:To:Cc:From:Date;
	b=WBEVfWgMDk93auEoNp7uyL5lD7qUvQvPpor/XSIA2gGIUDbMwK4U1M89/QjzSOIHU
	 siNLxK0zGCBfmkfNhwBDLKS8Ul/QU3M7BzYCIFcV3zbhT/8bYC5jP7fkcRBfBZMlnb
	 GOUau0dkc7UzllV4QJEEagfN48sM0fBwqzyKU8dM=
Subject: FAILED: patch "[PATCH] regulator: scmi: fix of_node refcount leak in" failed to apply to 5.15-stable tree
To: vulab@iscas.ac.cn,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2026 12:32:25 +0200
Message-ID: <2026071525-curtly-mothproof-9d7c@gregkh>
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
git cherry-pick -x fa11039d6cdff84584a3ef8cc1f5e1b56e045da2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071525-curtly-mothproof-9d7c@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fa11039d6cdff84584a3ef8cc1f5e1b56e045da2 Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Wed, 27 May 2026 10:48:50 +0000
Subject: [PATCH] regulator: scmi: fix of_node refcount leak in
 scmi_regulator_probe()

scmi_regulator_probe() calls of_find_node_by_name() which takes a
reference on the returned device node. On the error path where
process_scmi_regulator_of_node() fails, the function returns without
calling of_node_put() on the child node, leaking the reference.

Add of_node_put(np) on the error path to properly release the
reference.

Cc: stable@vger.kernel.org
Fixes: 0fbeae70ee7c ("regulator: add SCMI driver")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20260527104850.872415-1-vulab@iscas.ac.cn
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/regulator/scmi-regulator.c b/drivers/regulator/scmi-regulator.c
index 6d609c42e479..c005e65ba0ec 100644
--- a/drivers/regulator/scmi-regulator.c
+++ b/drivers/regulator/scmi-regulator.c
@@ -345,8 +345,10 @@ static int scmi_regulator_probe(struct scmi_device *sdev)
 	for_each_child_of_node_scoped(np, child) {
 		ret = process_scmi_regulator_of_node(sdev, ph, child, rinfo);
 		/* abort on any mem issue */
-		if (ret == -ENOMEM)
+		if (ret == -ENOMEM) {
+			of_node_put(np);
 			return ret;
+		}
 	}
 	of_node_put(np);
 	/*

