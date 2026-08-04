Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC974446F0;
	Tue,  4 Aug 2026 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785839517; cv=none; b=fI5z+sinU7Foub6Oj7M6QUf+APDCNKtbbI9n5RteK1tZQQzHGgi+ei0i9JkRgJaBBmDqyH+nxaMxcSwD1sCsdHlB1H8h+zMIARPC0DlxckJkBG8KTXGyiZ5vcsB0MHf+K9EznANHL8WOenhlhq4B1XyVVLWznhnEOA7X//19BTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785839517; c=relaxed/simple;
	bh=GkEgJ9p0eiWT5xUfnlMoKg4hnITIgC9Epzo7QbRDZPY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eIWMn5VPKtiUBMv+QsMfpR7WiGLPQo+f6Fu4RIISZ6VvQyHtQ/yK29dczENfu3oG+ZorVAFg91Cxk7cLcQLTHsEfZSdE0G1f+5+Dvke/fttQMaOXqmhxMg6jM1gNPq2aWvPIDeEYudC46O8XjbE20QqnWvIttgaThT2JgpwK17E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QeOZfdYe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sOX1u4l/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QeOZfdYe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sOX1u4l/"
Date: Tue, 04 Aug 2026 10:31:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785839513;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=chazM3dXHMFBvpbHWZXE8fwfstFR3LzqOY34tU89GUg=;
	b=QeOZfdYeRFXaqUp8QQn/H298JGGcULGOY2imKXMtafyFn2yYk9s/nkHuyeB8UakHJku2vG
	sPAxk2PU/YbJZc5heGM/rlFhMhPHOPPi1QXTUSfz+8xy1Vr8EyC52zJmchg2iHyOOb78Jx
	oJY0nHrV10nnwElOip0Ryjwp89qF0g6ubARy8gjIfKc0XbTM4LWB014aP3UonbuQTRFB3e
	3u+AePfxYIu5hJlMEa+4zak+GnMkx/yMOwlSpZvjBq/CCxLpBVvNtH7iBYq8xp+L/uCFoR
	AKqj77iFoyOx3RFYWfVKqeEFtMPyuhvBVhXtk9GwLK9W5DKy3WHqra3wpDZzYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785839513;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=chazM3dXHMFBvpbHWZXE8fwfstFR3LzqOY34tU89GUg=;
	b=sOX1u4l/u6Vl4kvUiZFtZjiYSWZlYxvQ/sulZLYB+S71xS4aI7xKBLAYqDTpn5NUN8+sMR
	SsUQXtyWVgsGJQAw==
From: "tip-bot2 for Felix Hoffmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] futex: Avoid private hash use-after-free on final put
Cc: Felix Hoffmann <f3lix.dev@gmx.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260731155024.1150011-1-f3lix.dev@gmx.de>
References: <20260731155024.1150011-1-f3lix.dev@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178583951210.1210945.18223157820047637311.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     1c7efabfbaf796f11000a46094a69955a01ec6cc
Gitweb:        https://git.kernel.org/tip/1c7efabfbaf796f11000a46094a69955a01=
ec6cc
Author:        Felix Hoffmann <f3lix.dev@gmx.de>
AuthorDate:    Fri, 31 Jul 2026 17:50:24 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 04 Aug 2026 12:29:45 +02:00

futex: Avoid private hash use-after-free on final put

futex_private_hash_put() drops the reference to fph before evaluating
fph->mm for wake_up_var(). futex_ref_put() enables preemption again before
returning. If that put drops the final reference and the task is preempted,
another task can pivot to the replacement hash and free the old hash after
an RCU grace period. The first task then reads fph->mm from the freed
allocation when it resumes.

KASAN reports a slab-use-after-free in futex_private_hash_put(), with the
read at offset 24 in a freed kmalloc-512 allocation. The allocation and
free stacks point to futex_hash_allocate() and the RCU free path,
respectively.

Load the mm pointer while the fph reference is still held and pass the
saved value to wake_up_var(). wake_up_var() uses the pointer as a waitqueue
key and does not dereference the mm through it.

Fixes: bd54df5ea7ca ("futex: Allow to resize the private local hash")
Signed-off-by: Felix Hoffmann <f3lix.dev@gmx.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260731155024.1150011-1-f3lix.dev@gmx.de
---
 kernel/futex/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 0864c6e..d3fcad4 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -139,8 +139,14 @@ static bool futex_private_hash_get(struct futex_private_=
hash *fph)
=20
 void futex_private_hash_put(struct futex_private_hash *fph)
 {
-	if (fph && futex_ref_put(fph))
-		wake_up_var(fph->mm);
+	struct mm_struct *mm;
+
+	if (!fph)
+		return;
+
+	mm =3D fph->mm;
+	if (futex_ref_put(fph))
+		wake_up_var(mm);
 }
=20
 static struct futex_hash_bucket *
