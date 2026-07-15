Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4523ED5B3
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 10:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784111561; cv=none; b=EwEglq/Vni3sSo4jI4BTauuHn9bbWYXIugIz1/yEzthJmukra14tByUJm+uNHHfaujvA1yyALF6+88q4JhfUfXiksBjSQ/rGRle45StZ6pVrWbR9rlmkN+FPLIcql7N8uZa0GxDan+jh+F/6/HWlAcjtn7YxO7sOEBqRF+55+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784111561; c=relaxed/simple;
	bh=9j/6h5+B4DkNC2csdwabWjIcYyKlsCGsrC/nAz4P5mI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZaOlQN9GDaSBi4oWUhym6rMzo6+1yT4QxQrl3KqAgOIXlJaOhUIrUkJgfRpxYRqdIlnaLSSSFAbVPX3iV+oXUv8unGE2WW2jCG+jVmkop7jx/OSkweXJRQFjeOZScq63U2q8JQ9xZVVI1AvFUQF00eceFKfNUhgaWtNJD2O5o/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Px5qZUEo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Px5qZUEo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADFA1F000E9;
	Wed, 15 Jul 2026 10:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784111559;
	bh=THK7u00xfwydbsdbj/VDwnCvKX4bdxm+yUvOWlM9ulc=;
	h=Subject:To:Cc:From:Date;
	b=Px5qZUEou2PGxmOsGF/tabMik7bzo8S24RMzrOB5nvPeNNqWC+NK7Ii45PjG2jUl3
	 NmWOQ6Rn75vuATssgjf9PPlhFhCCrX77qGqV8miV9Dr9CXYe8WL0bWhhF7fdWAIV7D
	 yV6xFQMAFzwLQ+R9LLWhfswvZnoHW7YRb9n8Y+3o=
Subject: FAILED: patch "[PATCH] regulator: scmi: fix of_node refcount leak in" failed to apply to 6.1-stable tree
To: vulab@iscas.ac.cn,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2026 12:32:25 +0200
Message-ID: <2026071525-sudoku-chapter-20d7@gregkh>
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
git cherry-pick -x fa11039d6cdff84584a3ef8cc1f5e1b56e045da2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071525-sudoku-chapter-20d7@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

