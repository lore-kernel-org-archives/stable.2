Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050017;
	b=zrMKMIidxwS/cd2H3CQsj0b84QH91gdSA3HhDYNNgffPrfzoC7fo6WUZI/nmX/ugCb52
	 Tnk+lnAbQGx1yWAoU7NuZyU8ADr4JbpOoCPhn3bYi+17JcuKStYNcyPDtmsu1yQc/tbW8
	 9aH7L37a/7SxkXjv7Bdrxtt33LHdtHP7LZperBWL+kTTi77mDT8MG2nMu1cWVKuW65ZWf
	 ewDmFjOTUx3OlMMFI5OpyPp2JSq0/V1QXIXEVb5l5nLC5glpUwY3obwOPnCSgQclFN0cb
	 cyJZTDoEOTYX+GP5U9sKPSEc3VRMK0Hi3/YmXN789HwqdgAXUr1FuTOd9YbZmo+UPqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050017;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bN80jlvyFBs4tLOMKug0bhBNbZ1ZbY2N36/+aVU8oPM=;
	b=Ef/AyW04qoDy8sgI/4sKrroim+dYBltSJYTRK7kSUu2lscsevq6OyoYx/fxZsbF8J7zm
	 VF1kKgL0L8Hh7416X2ABJwKsmfh7biCJ+iDHrgKAcg9I4izWqR1uOB58SZi8AZlpAYZfP
	 RaibZVcLgz5CRUZm5RW5tdTJF2is5a73swEOsTMHwU6Ns+7gERaXXrAQMw5BtTEwcgbN1
	 trms4q8W8mjlHwsErk4wFGIE+bOe/ZnEvz1srStdoBBX5gbXjJKpZOwcjWOZoooWaoY8Y
	 XTQ9EUIZMXjiUtq0Gr+U7TCPVHxGSeQgb3FH5QNMbDSSVSC+o+Pdg7yXcqRErSEElIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cC7dAX4D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9022606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cC7dAX4D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C731F0089F;
	Sat,  7 Nov 2026 11:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050016;
	bh=bN80jlvyFBs4tLOMKug0bhBNbZ1ZbY2N36/+aVU8oPM=;
	h=From:To:Cc:Subject:Date;
	b=cC7dAX4DD6+AHkI2vSYKNjgoJX5IhuDYL13iGlDags48zEjI6OKok2P0Y0e6j6TcH
	 yhRldwzcR0eJ2d2bY7d3yCKMOlI86eNSWM6/BE8GZBNiiUsA55VhoExnWOINn/QVp+
	 xXmVS1FLlYV2FrnmEJCbCLnMH2aKswtvBwRm2iHll6hjJGu4VWXhzr9iFXBeMJGa0L
	 Pl+hdCsyiSf3MRmJeoy/Uiwb3gcwrzjLA7dtQVIzXYBWwOU3DcevkZOs4HU/6mxwQd
	 SGC1DEVD/K9eBHAEUaICAv2T2g3YrSv2nMCrTLkb+V0twnpbXWpQmjQIaIglYl8Oat
	 lrUkVzH5tyhWg==
From: Sasha Levin <sashal@kernel.org>
To: john.johansen@canonical.com,
	georgia.garcia@canonical.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] apparmor: fix refcount leak in aa_get_newest_profile()" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:13:35 -0500
Message-ID: <20261107061334-failed-5.15-33ed50716251@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 33ed50716251d5b2875706c40d0c8082d46be0b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061334-failed-5.15-33ed50716251@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




