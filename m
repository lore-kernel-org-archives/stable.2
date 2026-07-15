Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AFA42BC49
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 10:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784111553; cv=none; b=PeDC1Tuq/KyhahUmlz/8hyBcRW5x344bLLX5ks02JZZC01CGnim8HjMQjF/s8URns4zfT49DmxGB30s7oTM5YzXD6VF0D2yawO9RrQvFDCoZ8wQOCuysuMmBqIDku1D23OgAgIN7IMvprQoxh516WQzRNzZ26kMbCkDdNDCsuiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784111553; c=relaxed/simple;
	bh=0ndbC4qfjoZwSzmah2JvCE7KPcykhRGho1G/adKuIAk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gXQLAtGS1hr5wakC0EehjcK12SgwCnEG/oLqDeR86OqwQQk03fNEqgm6hC0wBEpn4/gqjomjbUxl5OoAVlXgjG/33ofS231E8tpjWh4mUPVokSAyA2xgEagIaCXIxhkbySh5R8PybuXqN651bAGEKzY8f8XD1xPb7AyMHZwgkSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d5pj9Vyy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d5pj9Vyy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257951F000E9;
	Wed, 15 Jul 2026 10:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784111551;
	bh=VS0GyhZszpfKthPTFvrdzUwNb9bcnzPtIM087GhzqCA=;
	h=Subject:To:Cc:From:Date;
	b=d5pj9Vyyn5AHk6uDgzSULGpf5ctxY9l5UQvSALgNYt/p8gWFIzncW3OhRJeyBwKjl
	 iC0ik3NmumLd6eiWxYg0tu3YsB3BUNPhAo4YowlzgnoOcEL/DtW446Db1kPGPDG6NV
	 QfzPySP8jY5/tkogySU8or/zBmRutjOTa8NyfYnw=
Subject: FAILED: patch "[PATCH] regulator: scmi: fix of_node refcount leak in" failed to apply to 6.6-stable tree
To: vulab@iscas.ac.cn,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2026 12:32:25 +0200
Message-ID: <2026071525-evade-yogurt-25a3@gregkh>
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
git cherry-pick -x fa11039d6cdff84584a3ef8cc1f5e1b56e045da2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071525-evade-yogurt-25a3@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

