Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B71392C4B
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815560; cv=none; b=jBCbIBus1gUhDSb4zUzN+VFrlSoGdmdXcLBI1Q6PRb62Q8qKkSeTa093r+4P9OTm/oCA2I6qV+R/9P0pckoFtg+3l/HH2pzJDiAFmpE/ltDFr8YrtRNZnXoorApfoxOHmk+krrYF9uL2d8OBkiMdH1+49qijl+t3hyATdVIKFRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815560; c=relaxed/simple;
	bh=6sdrWcle8MAUn2sk77XAtLEf1L5zSkCRmI8D7Phtu+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ig4vV6hJUgiXARJtYPCBrarXqqK7MBrAuxLwockseaQ3Qal0sSYc1q/oXZtFp3x+ztQam8HwpWLgLWpC3bSBuPwT6VcwcZzKeilfZ3Ve9f9GsIfn8iFyBiaeUVQk8nQqiz6+oleo+NcCj6+scf/atY0copml4G/HdJh5ugeoJmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMhZTNgi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMhZTNgi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D814A1F0089B;
	Mon, 12 Oct 2026 14:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791815559;
	bh=bwh4nfmTzYRW81TSMR9lmSPFDdPItHgQwk2HHDILgck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CMhZTNgie2uZ4KEZiBv8pRKpQJh8WX/YyF7ja1tsh7pXhz3kJRUEzJerfhQGgQpml
	 Rfi3MwFYBY5+Q8tp8CTaEu4potreqAGJL3/as6uUZ7HxpVTLsKc2BpaI1GPVWggBws
	 myEpfe+4YPUIRvcZ6u5+WscR7qzSrZo/889Z+EZGiLb/POzguuhDmDQKkJ/sbRcZmb
	 LEGmveQ6ZUghoaxGU2BvpBEZaxx9VTXIqoNDnRDjtjA3K+OU4ADWR9108UeUGQdU5h
	 SCPQ9FLRgJi1LZz6H/g5tjs1XNAY2pe8uDchdyUWZdT8hcBnz01jRKdu2SGuYNiVFQ
	 IWrNxEE4/JHQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	syzbot+a7f7cb0737bd91aa698c@syzkaller.appspotmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] selinux: fix data race on AVC latest_notif
Date: Mon, 12 Oct 2026 10:32:37 -0400
Message-ID: <20261012143218.726728-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101223-rerun-preachy-f36b@gregkh>
References: <2026101223-rerun-preachy-f36b@gregkh>
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
[ sashal: Adapted global selinux_avc accesses to use avc and state->avc pointers. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/avc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 70eeed3e44c05..04efc9582c56b 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -588,7 +588,7 @@ static int avc_latest_notif_update(struct selinux_avc *avc,
 		}
 	} else {
 		if (seqno > avc->avc_cache.latest_notif)
-			avc->avc_cache.latest_notif = seqno;
+			WRITE_ONCE(avc->avc_cache.latest_notif, seqno);
 	}
 	spin_unlock_irqrestore(&notif_lock, flag);
 
@@ -1191,7 +1191,8 @@ int avc_has_perm(struct selinux_state *state, u32 ssid, u32 tsid, u16 tclass,
 
 u32 avc_policy_seqno(struct selinux_state *state)
 {
-	return state->avc->avc_cache.latest_notif;
+	/* Writers hold notif_lock; readers only sample the sequence number. */
+	return READ_ONCE(state->avc->avc_cache.latest_notif);
 }
 
 void avc_disable(void)
-- 
2.53.0

