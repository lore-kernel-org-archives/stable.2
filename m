Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A1A43846C
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562940; cv=none; b=EbBi5im8dI1IbqGJMJ09BPONMiBA0EAOLg1G4Qf+RtRk51sgyK/VVeu8Gwa/x8yuvjgTfnmhG97jISAoWt/rQXLd5Nz1bum732rvxlZ6WgoQhjed4Y5r7wLfOKnbmsdoBc+NSnj8276u1YMD7qTBdmxQvT1EvEFxTL3HiMS15Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562940; c=relaxed/simple;
	bh=RA87Ri6H3FvCCZnZ53KFOYCN8NB6nnU6YdLtIREl9gQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iGiXvCwTY6ooaaACnulXGjrUcXcmLHFh5P0Yq66pJklt1TOAt1Za0BqgaKWjmn0n1aG6QbE7Lm2QlvWrsfoXfpBKP8alr/tAPmy2Maed7sAJmdQDSmaVs8f7KI3YoKok7vjQJm8OqUpEpGqz/hLTlrUwFqT4TkeyvtbU3+eIxsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kdu58e6F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kdu58e6F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC811F000E9;
	Mon, 20 Jul 2026 15:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784562938;
	bh=xQNfkRo/ILWNH86nOumkd850PE+fZWsAYDz6iNE9QBw=;
	h=Subject:To:Cc:From:Date;
	b=kdu58e6FRcd4cSGMOj9UjJ074r4EOL0kq6oDcWZwZ5dXgVEMvn4EuuHJwIDq4s31V
	 dCq8Gqf7FikIAo4Xzrx7JbmSd/NNxKEnPO5EKmBHfR7gHKBI0Pl4EbGdXkJ9M8jLlD
	 GhkweS/FXMeJPFAdkWqhFN+0MnSX52FbcuZrIGq0=
Subject: FAILED: patch "[PATCH] cpu: hotplug: Bound hotplug states sysfs output" failed to apply to 5.10-stable tree
To: include@grrlz.net,tglx@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:49:36 +0200
Message-ID: <2026072036-pentagon-armory-48cd@gregkh>
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
git cherry-pick -x 86f436567f2516a0083b210bedc933544826a2c3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072036-pentagon-armory-48cd@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 86f436567f2516a0083b210bedc933544826a2c3 Mon Sep 17 00:00:00 2001
From: Bradley Morgan <include@grrlz.net>
Date: Fri, 19 Jun 2026 16:37:18 +0000
Subject: [PATCH] cpu: hotplug: Bound hotplug states sysfs output

states_show() adds CPU hotplug state names into a single sysfs buffer
using sprintf(). With enough registered states, this can write past the
end of the PAGE_SIZE buffer.

Use sysfs_emit_at() so output is bounded.

Fixes: 98f8cdce1db5 ("cpu/hotplug: Add sysfs state interface")
Signed-off-by: Bradley Morgan <include@grrlz.net>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260619163719.12103-2-include@grrlz.net

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 3ed24c711e3f..77fdb2013ab8 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2865,21 +2865,17 @@ static const struct attribute_group cpuhp_cpu_attr_group = {
 	.name = "hotplug",
 };
 
-static ssize_t states_show(struct device *dev,
-				 struct device_attribute *attr, char *buf)
+static ssize_t states_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	ssize_t cur, res = 0;
+	ssize_t res = 0;
 	int i;
 
 	mutex_lock(&cpuhp_state_mutex);
 	for (i = CPUHP_OFFLINE; i <= CPUHP_ONLINE; i++) {
 		struct cpuhp_step *sp = cpuhp_get_step(i);
 
-		if (sp->name) {
-			cur = sprintf(buf, "%3d: %s\n", i, sp->name);
-			buf += cur;
-			res += cur;
-		}
+		if (sp->name)
+			res += sysfs_emit_at(buf, res, "%3d: %s\n", i, sp->name);
 	}
 	mutex_unlock(&cpuhp_state_mutex);
 	return res;

