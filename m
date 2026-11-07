Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794051052;
	b=hB5+cJkb/nmaazQ/o1tDEXdP4wbrkVzm0jnnnE3j6RLIcqmio48KqaajbKOI689vPF8/
	 t4KKsY8y8cWaqwYXP6NjkQgbRatN09WraKUQg6Liv8WEM2k1Uy3fmdPKumf7LU4xKQE6j
	 oAdMgs/5DLgQRoYaGbE0ezIowOHuDMDp3xHIeoCoeS+LJzfUIH+9lp9pWl0aiey9FKme7
	 4RxnQhzJkMDvAdlaJOcOT3B89mZLlcmdeQuZia6y9JQSLQ8R2bFj5feToSOSbakifjSFv
	 bBM8B7yCJYpVUN6xotfJJ+1L8KEgNz6ZMkl1teZViP5xLvDbzub0cmcuVqMG89hMOrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794051052;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yVJ40/RbYYtYL7LS8dBCIU2yOJib21ixK7zoQt03ZB4=;
	b=IbTmNHPCq/CCh1MTaPgsSyxCaedxJvkewbnJDW1STPpByBrpBC0HGuM7g1S+TXy029QQ
	 EWsai9f9wDcpjbsb8j4KYQ4uZGzlMcf6XIbQXaRw3G+M6razvWnBMX8V6pCoLUCZtCYLN
	 bDNqw9Tr4cGSiJui3Xa3aqaQgqIjsPP8QKU7f2jFRb0cy1OOVGqHeIjacAneoy2I7HEQU
	 A+XtPEyrOp1z5fAY/Tk+yqRKhSt92KZRiXl4HEZn0juhbOIBj+rm04pLEA17f1SU0k7ha
	 Watf1Z8a+asKtWV+qXOtLf69rHivQE+O9GV0601O/hzizMoxvqqILBuSpTcRKXARNkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mNsIcxv0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21952606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mNsIcxv0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B14D1F0089F;
	Sat,  7 Nov 2026 11:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794051052;
	bh=yVJ40/RbYYtYL7LS8dBCIU2yOJib21ixK7zoQt03ZB4=;
	h=From:To:Cc:Subject:Date;
	b=mNsIcxv0nZlK7UnWA2Ku9Z20XV2uGqGL1V48wM9WF2K+EE2epZYpPVCQpI1xjpxxa
	 tVyA9qFveuRwQQifOpC4oNAvxSVu11w2Q71+OTFHRFKbHEtKgKE/5fo7/b/Irh+AiM
	 atzKu3qPGl79tT0bd9kF+Mk8AzkOx2gWeMzJePRK7ICcWPhkpPEPooX6LdZ5PCxAyG
	 fsCs9/YIyMmHyvWvYH/x6LIJc4p3dmM6M4z3ABuuBRx1Qw8OKvGdSANRiIPIdi/8QO
	 RjDKCK6eZtgPaDxpkWKioiVS0/TNrSfebVrv4Hbvy6ALivprYwGpxDYm0HG5GQy6UU
	 psi6rQwJ5lFGg==
From: Sasha Levin <sashal@kernel.org>
To: john.johansen@canonical.com,
	georgia.garcia@canonical.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] apparmor: fix refcount leak in aa_get_newest_profile()" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:30:50 -0500
Message-ID: <20261107063050-failed-5.10-33ed50716251@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 33ed50716251d5b2875706c40d0c8082d46be0b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107063050-failed-5.10-33ed50716251@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 33ed50716251d5b2875706c40d0c8082d46be0b1 Mon Sep 17 00:00:00 2001
From: John Johansen <john.johansen@canonical.com>
Date: Tue, 20 Oct 2026 16:00:30 -0700
Subject: [PATCH] apparmor: fix refcount leak in aa_get_newest_profile()

The labels_profile() macro is evaluating its argument twice

  #define labels_profile(X) ((X)->vec[(X)->size - 1])

unfortunately aa_get_newest_profile() passes
   aa_get_newest_label(&p->label)
so every call to aa_get_newest_profile results in 2 refcounts
being taken with one being leaked.

There is no need for labels_profile() to be a macro. Convert it to
an inline fn, which ensures all uses are passing the correct struct
and removes the double evaluation.

Fixes: 637f688dc3dc ("apparmor: switch from profiles to using labels on contexts")
Cc: stable@vger.kernel.org
Reported-by: Georgia Garcia <georgia.garcia@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
---
 security/apparmor/include/label.h | 6 +++++-
 security/apparmor/label.c         | 1 -
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/include/label.h b/security/apparmor/include/label.h
index 2c869b7dec973..61794b9cd6be6 100644
--- a/security/apparmor/include/label.h
+++ b/security/apparmor/include/label.h
@@ -162,7 +162,11 @@ do {							\
 #define labels_ns(X) (vec_ns(&((X)->vec[0]), (X)->size))
 #define labels_set(X) (&labels_ns(X)->labels)
 #define labels_view(X) labels_ns(X)
-#define labels_profile(X) ((X)->vec[(X)->size - 1])
+
+static inline struct aa_profile *labels_profile(const struct aa_label *label)
+{
+	return label->vec[label->size - 1];
+}
 
 
 int aa_label_next_confined(const struct aa_label *l, int i);
diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index 82742a4710552..42ed476fe89d9 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -387,7 +387,6 @@ void aa_label_kref(struct kref *kref)
 		label_free_switch(label);
 		return;
 	}
-	/* TODO: update labels_profile macro so it works here */
 	AA_BUG(label_isprofile(label) &&
 	       on_list_rcu(&label->vec[0]->base.profiles));
 	AA_BUG(label_isprofile(label) &&
-- 
2.53.0




