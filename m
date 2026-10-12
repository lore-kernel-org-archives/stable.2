Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C734B37B003
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813658; cv=none; b=R3BOffB+R4RnksHL268SYL1k08Gl4dMWknIbGsKaaUA33TGpWfQ883mgfOd5JK/HzlFdgbMUelVJ1/t6WsF1LRrhRgakOUd0tFGkCZrLjjrvL3a3e/XCtrgJ2CCL8DNFLvUlrFXOFZBaxB1P6wMsiw2izr24LbVvueoVyNQc0pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813658; c=relaxed/simple;
	bh=u6T/QcNbBrMQtCUQxWxPqQynUjCh4DdX/gqnd/tQhKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=raYO1qYTWP3qXE2AuFb7/194bZ2hZ/eRYwbILiFVFmw+DOXesM65wrUSGp14pxyTUidenJq6pKTku59DElNh5Zddozr+d/B52ABQEkbetpM4N50zeFrogob3a8gavuy/QrHvW5Gb98mrU6C7Fnc4mXwsMKtNBnpgj8DNzz8uKeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFe50LjZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFe50LjZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B099B1F0089B;
	Mon, 12 Oct 2026 14:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791813657;
	bh=XdCZ07k/agk27jcqjH5lUihXHZVc2fK923DoT8t820M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QFe50LjZraITTM9AmexYmPZL4bAzX4W1BLNYeB6TbKGIETLQTDE/4L3WUtNKxyqJo
	 5QAFDYzLyf2hgvNGZSWDcj7z24H+wOKAxuozq7ZCG11gIhOrtB/GrA8a736DGdmfS2
	 xzoXFKpfMU+ZP+497+EuCTg67G6H/T2ArlXiNGTmKJ6dCo+K2szyflpwIKBTkPFK0Q
	 Kj1Yklwa1Z7S2nIul1NRBiwUZ+CNkHW0GN7mGha45Uv8BLCQZytSOpCwyIWkYXg9Zw
	 t9Tn6IIlfM/4Xwc52hKn8JnsC5FxRyI+kwyUa11TKlbUBBI3LCiCj9YccG2oh9HwJw
	 UMjQm5iMB1/yA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	syzbot+a7f7cb0737bd91aa698c@syzkaller.appspotmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] selinux: fix data race on AVC latest_notif
Date: Mon, 12 Oct 2026 10:00:55 -0400
Message-ID: <20261012140036.4188580-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101222-xbox-operate-40df@gregkh>
References: <2026101222-xbox-operate-40df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

[ Upstream commit 1ca924044bf0de879a1648be93a56939652267d3 ]

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
[ sashal: Adapted direct selinux_avc accesses to the existing avc and state->avc pointers. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/avc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index dcc8e1df4d7c5..e26f9b01b7305 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -589,7 +589,7 @@ static int avc_latest_notif_update(struct selinux_avc *avc,
 		}
 	} else {
 		if (seqno > avc->avc_cache.latest_notif)
-			avc->avc_cache.latest_notif = seqno;
+			WRITE_ONCE(avc->avc_cache.latest_notif, seqno);
 	}
 	spin_unlock_irqrestore(&notif_lock, flag);
 
@@ -1202,7 +1202,8 @@ int avc_has_perm(struct selinux_state *state, u32 ssid, u32 tsid, u16 tclass,
 
 u32 avc_policy_seqno(struct selinux_state *state)
 {
-	return state->avc->avc_cache.latest_notif;
+	/* Writers hold notif_lock; readers only sample the sequence number. */
+	return READ_ONCE(state->avc->avc_cache.latest_notif);
 }
 
 void avc_disable(void)
-- 
2.53.0

