Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8F249CF5A
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819545; cv=none; b=bXBfdu2ivFl/Dg9f2Uptcx14KgaLlV9RFEHbD/Fv3EoBooQT4nAVoh2q+CtdZhHqvcC93d8o2me3RoqQI4zJCVSsTRSQR6ce9JRnaCkwD4H6IEuVNlrRAnrjsL6GiMHw3vUlOfJ0bPOdfRmJPJ3XN1IU7eI63DUqsdihLl8P0kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819545; c=relaxed/simple;
	bh=q29PMV8jQcuEw7plkOEx/Nw6iaNHp2EcRVJCgMrKAkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lDkxHFia/qke1pyi9temOzDEb+W9DXlGxmuiLL7sAF1cw3vFUwp/eQa1L1fYZpkIt02lSEf190qTDGTrD8yamqonfRg7i7L1T73Um6+Cm+l6SSI0EvOvxXmtcEmxAvLBYfMZ7UoIdxJDPqJvScSycVmJwXx6M2zeqjLEplsYH2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZJKoNHw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZJKoNHw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED5E1F0089B;
	Mon, 12 Oct 2026 15:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819544;
	bh=fi0/AhTG23e4iE4ewbNkVpncbVhOOr0WFfwFcw+hjSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cZJKoNHwXIGcyzV98d1YhIIon8Xwr4dEsgu0MICVLP9bjfsWCWwP9BjASmse38LOU
	 sDFRAGHsuQ2NtE74TB5LeROcgTDzsVVu9/+qdXXg1SxwiNRdfYMdmzLt/NKIxGRmm5
	 xZPHePgqMUTGxqpaXfQePyvVXXUaPFSYCrp+40FaYkK33J9V3tjOrcG6oC2UF1zC9l
	 hzaRAxLx3VDsiUoXJaudb6qSNgMo/VkMo0cf9Druo2AudGY5/1fFoFH/Uegbzp4VUI
	 f6wwsUSQVreZIX8f6xnFOuMuJ+q6XjcNK4Msn4FRSwuFhW0zgs0nuD9lMiTh+6Rkb2
	 WVWwTmxVjtjyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	syzbot+a7f7cb0737bd91aa698c@syzkaller.appspotmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] selinux: fix data race on AVC latest_notif
Date: Mon, 12 Oct 2026 11:39:02 -0400
Message-ID: <20261012153844.1064344-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101224-sedation-swoop-65c9@gregkh>
References: <2026101224-sedation-swoop-65c9@gregkh>
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
[ sashal: Adapted global selinux_avc accesses to avc and state->avc pointer accesses. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/avc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 441ff3e773894..2359db283e7bb 100644
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
 
@@ -1221,7 +1221,8 @@ int avc_has_perm_flags(struct selinux_state *state,
 
 u32 avc_policy_seqno(struct selinux_state *state)
 {
-	return state->avc->avc_cache.latest_notif;
+	/* Writers hold notif_lock; readers only sample the sequence number. */
+	return READ_ONCE(state->avc->avc_cache.latest_notif);
 }
 
 void avc_disable(void)
-- 
2.53.0

