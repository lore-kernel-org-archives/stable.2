Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD6E4CDDCB;
	Fri, 18 Sep 2026 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789730851; cv=none; b=ffuuDbt7Tr3upvNBFRtIWFzHjVxVBdd6mt4I63yPR94CLpYxif6IhpkZN3JI/IVBfdWDx/bQ0xHQ/bXJCHK8qqq19a6bTijDXkixDy7heU+ukfB1KKTFb8uwxeGbuFZRYL+Rzyi+FmCbzRFw5TNFJJ0WdLxkjn/ruhU1iI0ag+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789730851; c=relaxed/simple;
	bh=eZbZRybmvbmsk4XGwSN+uF/t4tuxC4PxmlKfpNHKNvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JFNyJ/l5MEWnhE9kjwbM4iBQXnVZsORr7UnhgYNP+t4o2kQMT54xY4/gfr3X9qPuuue6vZjg6mENhyJY0KQCJQwPPSZoKhvo5JvkEVujqLh2Zms7O4Yjxlj7QQnVcimn8XlLkIsjCYG3nCGSJQukrB3wACMtC6/NH9B2VeYMUVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=rVijSmRr; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="rVijSmRr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=g2dHWBlF2h2VLId3fgErv67RQdJUNg2b5tSkFjp3B+g=; b=rVijSmRrA8lz+iqY4PR5LEuTdU
	HJR5o4zgFaqkLhUgwAIY2VSAvTwpblemHbiML73A+MmxgGE3WU1//Mp5x1MauTSNjgEl5quI0ENgB
	4TjX16rYiEhIEwV9aKez0BXx7y4qfuo57rInPJTrbH8kPAXkRJQhCufUq6lDa9jcxVaOABlJdr50g
	h36VFene43tCQh+TUyQniE7MzHf+OdY+c2B137tFy1f3z6C9YU2D0tvQ3zaHf+rmwE76ShJcEQG1g
	FZHHyCjg/y5QApMnaETN6iAaj7xrDcvF9GBFPB3wdVsXltSA5EhZXI/qwj79Aw1RzZb3OqhXBPe9A
	JAVBYT5A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x7WkN-006gV4-1R;
	Fri, 18 Sep 2026 11:27:15 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 18 Sep 2026 04:24:37 -0700
Subject: [PATCH] mm/shmem: report RCU-tasks quiescent states while undoing
 a range
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-shmem-tasks-rcu-v1-1-79acf91a2569@debian.org>
X-B4-Tracking: v=1; b=H4sIAHUfrWoC/yXMQQqDMBBG4avIrB2IBrT2KuIixt86Fa1kVATx7
 qbt8lu8d5IiCJSeyUkBu6h85ogsTcgPbn6BpYum3OSFqbIH6zBh4tXpqBz8xkULWzqU1vSWYrU
 E9HL8jnXzt27tG379bui6bu5gN1pzAAAA
X-Change-ID: 20260918-shmem-tasks-rcu-6be37ae730f3
To: Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 stable@vger.kernel.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1826; i=leitao@debian.org;
 h=from:subject:message-id; bh=eZbZRybmvbmsk4XGwSN+uF/t4tuxC4PxmlKfpNHKNvc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqrSAPgk5hcnjQgEmmh64DV7Rb8qMEEDXgawjlV
 DOSg4Nw0sCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaq0gDwAKCRA1o5Of/Hh3
 bfopD/4jpfXFv7nsm1ZRGAs+v/gSWTu7RgJ0dXlL9sIeZ3yno3H077vLuGyAQ4GOGRRLNXd8MUN
 TubSSof/1AB/Ub0fGl7lCs+W+NNTxIJ0DYz9GhdNM2yGtPxn+KJcSU5bnymtiGH699KkYojmf6M
 SrhTvxzVf1r4lERIC+GOKLWqoueBHmLE3DqswWifI0YBtoObaRWeP05J9axBSpXhGsD4girbfH4
 ePacexgDRuq9VoSV5UwudGR6VyVKV1/ypoY93bR7xGOtnotDHByGGulslCTFYyWQYqrwpnQLxSi
 6k0QMHu9jpSH0iOSFdkRxAfSzH1+dvrAH97dB374O7+yudgn9ofEnR9S2z7lxAvBJ+/8Gys2Ira
 PnCyyzSKkd6cuQn9z/nCFzf0OyxIEoCkmtlvsVwGOORhAqavpvIFhG1tlj1Umv3RMJxrM5YXEdM
 hsVZNSkhmKdZZC8VsplaX8ggJC1KTIFY0MC/OOVMbsRSFA0k+6Xmb1im0P4900mEKRZ0NBlSv4G
 5LDwvJ+VHwYOgVEMG8Ov6qR9fn9jV9KiNpSQigbxod6pMH61lny+s6aIH4ckrAAHYZ6lBk4bZPL
 +MtYyqYwMcwfS6Afo2gaxn+iPlBmqwAccoWTPqr+3WUmhgFAAeC0B+avIpaBUxlXwvqy5g0aAUP
 yLSTb32L6gOVroQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

This shows up in the Meta fleet on ftruncate() of large tmpfs files:

  INFO: rcu_tasks detected stalls on tasks:
  00000000752fd185: .. nvcsw: 59455/59455 holdout: 1 idle_cpu: -1/0
  task:rocksdb:bottom  state:R  running task
    __folio_split
    find_get_entry
    find_get_entries
    truncate_inode_partial_folio
    shmem_undo_range
    shmem_setattr
    notify_change
    do_ftruncate
    __x64_sys_ftruncate
    do_syscall_64

shmem_undo_range() walks the whole of the requested range in folio_batch
sized steps, twice, and its two cond_resched() calls are the only
reschedule points in that walk.

cond_resched() is not an RCU-tasks quiescent state.  Use
cond_resched_tasks_rcu_qs() at both points so the walk reports an
RCU-tasks quiescent state as it proceeds.

Fixes: 8315f42295d2 ("rcu: Add call_rcu_tasks()")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 mm/shmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index b572c60f2af85..bf48cb49565ea 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1367,7 +1367,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 		}
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
-		cond_resched();
+		cond_resched_tasks_rcu_qs();
 	}
 
 	/*
@@ -1408,7 +1408,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 
 	index = start;
 	while (index < end) {
-		cond_resched();
+		cond_resched_tasks_rcu_qs();
 
 		if (!find_get_entries(mapping, &index, end - 1, &fbatch,
 				indices)) {

---
base-commit: e657a464aba873f5eaf3ca821b6e4016674492d6
change-id: 20260918-shmem-tasks-rcu-6be37ae730f3

Best regards,
--  
Breno Leitao <leitao@debian.org>

