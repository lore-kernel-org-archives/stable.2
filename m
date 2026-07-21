Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBCE3BAD9F
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625426; cv=none; b=Edru5LYZg0OVoew2MCM8y84xeWsM3c1UTMo0Q9gIYZuETURl/DO/9xn2KMn+CfNR3M1I2SLhwySbjLfZK4VqzH9oc/ajQGoSejlphDrEUiiq5VA5so/8R4HAgg5eZAx0rJqx4EM54xt+SRDQCFn7n+Zd/Z9NSuzsHiTTBziahCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625426; c=relaxed/simple;
	bh=B7kPQ4PFa0BrZtZbgXcltKNwXowZM6szoATJq86MYaM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=D9znuIm+ep8Wv8ZNWGFilud/UzIXZKNT83cRbFkVV6HTCbz5l2qX5Xcd2ocKmtkzqe1ifcxGObohRMpww4jDADDU67DFCF5dARM2nr5y2u3z2Iavqnm4tvNApmvKBykSZMfdGSCwMy0AEcp2EgJ9XwG+DCv7XymOUzu/ooeVyKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xmC6G2pu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xmC6G2pu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70CB1F00A3A;
	Tue, 21 Jul 2026 09:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784625425;
	bh=iijItRbpl6ianSB6j0FEceSdh4mMYDIU1HZ9tektMyo=;
	h=Subject:To:Cc:From:Date;
	b=xmC6G2puVWgonNhJG5R5sDGTarMysFiAgPh/oIJ0ekhIDf1peH6Fxw0zBJeOdd6Ml
	 1tXPR2XOjUu94p88trHgE8OXTp1SA1Q7eEEcS/EOW0W+JoDxfGHz+EZiykoVkKx9X+
	 /Rly2JimaU24TG51EioII4TP0jzZjfpcxkKOc0G4=
Subject: FAILED: patch "[PATCH] tracing/osnoise: Call synchronize_rcu() when unregistering" failed to apply to 5.15-stable tree
To: crwood@redhat.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 11:16:47 +0200
Message-ID: <2026072147-untainted-eradicate-d6f3@gregkh>
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
git cherry-pick -x fe58f457ad8d0a2bef4e053cfecca4b5cd266b1a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072147-untainted-eradicate-d6f3@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fe58f457ad8d0a2bef4e053cfecca4b5cd266b1a Mon Sep 17 00:00:00 2001
From: Crystal Wood <crwood@redhat.com>
Date: Mon, 8 Jun 2026 23:54:30 -0500
Subject: [PATCH] tracing/osnoise: Call synchronize_rcu() when unregistering

This ensures that any RCU readers traversing the instance list
have finished, before releasing the reference on the tracer that
the instance points to.

Cc: stable@vger.kernel.org
Fixes: a6ed2aee54644 ("tracing: Switch to kvfree_rcu() API")
Link: https://patch.msgid.link/20260609045430.1589786-1-crwood@redhat.com
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Crystal Wood <crwood@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 5e83c4f6f2b4..0e1265acd1cc 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -179,7 +179,9 @@ static void osnoise_unregister_instance(struct trace_array *tr)
 	if (!found)
 		return;
 
-	kvfree_rcu_mightsleep(inst);
+	/* Do a full sync to ensure that tr remains valid, not just inst */
+	synchronize_rcu();
+	kvfree(inst);
 }
 
 /*

