Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20578400E0C
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805231; cv=none; b=rPpQIEk8v41PfhxzkFLelHzx4tsqh2vK3QaQyqrsb0BVMF9fHcf+1Paewa9rmj/fJEMNizXN0LzC/w5ywSKy71HtZPINFb89NsCNMKPSYC3Ty8h059pqN89tiFRO4ad7HtaAKIVA9s/VDUyPSqM2+zucQPrkf9KqpjP461xd7Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805231; c=relaxed/simple;
	bh=GhAJw+OHxFWvAbLGVpurVzXK5z/DyGSpngSs1/I4qds=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PDCYRjCND8WVzk5yMpbEfDY7tib4t5LcNGSMx7mnYghgXI51Ju+ZZWwcepFfPux15f4LCzKfXlFaYHnUJF10tnmB7DxtM2Iw54Z46uD1vt2vi3JmZkHsCfKmwajcCQE0vbMhRKoqyR4hAZ9cQIwBvPoEsESaGGqYg+dRjrRQ4f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wKHflv8k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wKHflv8k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D721F0089B;
	Mon, 12 Oct 2026 11:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791805229;
	bh=HdTVXpDLXbzpdHft7gKxBG+cuQGatLI4AhfvTWGICfI=;
	h=Subject:To:Cc:From:Date;
	b=wKHflv8kqIt/ReAMeOWxMfy2QpkuNBS83Yr012UhTVkLEwmCvNHUPzta0eWne0ZE1
	 4INMU9B9lPogB6gDN6vAHIQLu03cVF1+RX+Xjggmkcf0camoLiEs7hjF5BCMpHuUH5
	 H5CUkXdyPXsL3Gg/eAJu3n6LaZIxmYaKEAL/oqq8=
Subject: FAILED: patch "[PATCH] selinux: fix data race on AVC latest_notif" failed to apply to 5.10-stable tree
To: cgzones@googlemail.com,paul@paul-moore.com,stephen.smalley.work@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 13:40:24 +0200
Message-ID: <2026101224-sedation-swoop-65c9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1ca924044bf0de879a1648be93a56939652267d3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101224-sedation-swoop-65c9@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1ca924044bf0de879a1648be93a56939652267d3 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Wed, 23 Sep 2026 12:13:23 +0200
Subject: [PATCH] selinux: fix data race on AVC latest_notif
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

avc_policy_seqno() reads latest_notif without holding notif_lock, while
avc_latest_notif_update() can update it under that lock. KCSAN reports
these concurrent accesses during policy boolean updates and permission
checks.

Use READ_ONCE() for the lockless read and WRITE_ONCE() for the update.
The spinlock continues to serialize the comparison and update against
other writers. Reads made while holding notif_lock cannot race with a
writer and can remain plain accesses.

This marks both sides of the intentional concurrent access and constrains
compiler transformations, without suppressing checking with data_race().

Cc: stable@vger.kernel.org
Fixes: 788e7dd4c22e ("SELinux: Improve read/write performance")
Reported-by: syzbot+a7f7cb0737bd91aa698c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a7f7cb0737bd91aa698c
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 560a82c6d682..b91f914d292e 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -578,7 +578,7 @@ static int avc_latest_notif_update(u32 seqno, int is_insert)
 		}
 	} else {
 		if (seqno > selinux_avc.avc_cache.latest_notif)
-			selinux_avc.avc_cache.latest_notif = seqno;
+			WRITE_ONCE(selinux_avc.avc_cache.latest_notif, seqno);
 	}
 	spin_unlock_irqrestore(&notif_lock, flag);
 
@@ -1206,5 +1206,6 @@ int avc_has_perm(u32 ssid, u32 tsid, u16 tclass,
 
 u32 avc_policy_seqno(void)
 {
-	return selinux_avc.avc_cache.latest_notif;
+	/* Writers hold notif_lock; readers only sample the sequence number. */
+	return READ_ONCE(selinux_avc.avc_cache.latest_notif);
 }

