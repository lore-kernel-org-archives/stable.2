Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272587;
	b=d++g7nz533SOTB9pYW041qviBDPLNMWoLrf6YNlXnnWDb7x+UxLcQ+u0KCdO4N25Rubs
	 U40wmmIQzqFZq/+U+ihWQBrZJxKgrDhVKXytTnIBtAWFJe44CicAQG2uHsuIa/Ub+5xuP
	 vIAAjZCTo9pe9ZS8l3imZL5i8S4FWESwoe9K+2M6AgRLdEUYWksYIS3tmaVZqO3vwTtQT
	 d57Huce4uFS9sBEQyYOfdcsuCSQd+6MNYCFCec04WomtBw+3Rz7J6sjQBjQJLEXjbnJFl
	 8Zp+7v8TMgTBM4q8ggIs5nyCWWab60TuzS215MPCQg+l1WDfw55zmPZA53gKrSYVmsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272587;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cUTOiign2Fu1zQiwaFY9HONGcp57wxRfCrmiVuXuHpo=;
	b=Xu2Nv4DNEQMs8UxytT4rFa4qNGZ15h8co4/mEiOFo1erPh3paOwHW2e0PNcYzx/GYEMB
	 5Krcawl2HcKicbeVRS5GKhUkt2aXZL/RWN0Pv7YHeJQ7ju+GI7a/TtQo+C3EyZN8cwJG8
	 UTcPgXftZ8nnGNSxW14+9eensfQzi2xuUXirlX1sbRO7Jd+KgLv+itFgfVsj0j3Z6tVCw
	 NZJwQuIVrmscdIjZ/T2DdlkfDIxC7cKTcfbnPZKwGobeenXbS9AmRrHBpakbC1C9MQXWB
	 kxf75EIdZexo5VElq4ddkOnBpglDXnSCH6d3BrqpceoWgUipem+s/5N6K62D0DnQ51Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RzUo5Dd9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E7B606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RzUo5Dd9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096AD1F0089F;
	Tue, 10 Nov 2026 01:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272586;
	bh=cUTOiign2Fu1zQiwaFY9HONGcp57wxRfCrmiVuXuHpo=;
	h=From:To:Cc:Subject:Date;
	b=RzUo5Dd9riEY162Fu2y/bikcxEV6Gsm1EHwsWWhkTXKpvA3Ms2R9cBS1Pxn0cthfX
	 h9SGuN4JX606xq/k6dg1O0+r515+S+PDeqSqQbx4yPOyj6Ob37EOwB8mrSPcUnlsFO
	 Ogb0nZrcrHfXP7EeVsJQqRXHrNbQIBwuY6grwU7bM3wDBjfI+FTx+0C6jr4QuksgI0
	 bg9KmPHQv7JbT56nkJJu3TbhOf0ZjKWPqEhEyWX1I0fECX7R1rOaR4krgby02nM6S0
	 cNJRPCuit8Y0B5wS+WrRgvQjau4vcgQxfACYXeqM5DL2YAtkfadlj6Rx17ZbgReBwC
	 zQqEuiNDeBMEQ==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	josef@toxicpanda.com,
	kas@kernel.org,
	baolin.wang@linux.alibaba.com,
	gourry@gourry.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/shmem: preserve allocation errors when swapping in large entries" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:03:04 -0500
Message-ID: <20261109200304-failed-6.18-f4ce23b1feef@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x f4ce23b1feef16d435aa1188b6c2a637a5373ed5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200304-failed-6.18-f4ce23b1feef@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f4ce23b1feef16d435aa1188b6c2a637a5373ed5 Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 11:43:33 +0100
Subject: [PATCH] mm/shmem: preserve allocation errors when swapping in large
 entries

shmem_swapin_folio() adjusts swap to the requested slot within a large
swap entry before allocating a folio. If allocation or charging fails,
the error path compares this adjusted value with the original entry
still stored in the XArray in shmem_confirm_swap().

Unless the index is at the start of the entry, this turns -ENOMEM into
-EEXIST even though nothing changed.

The caller retries -EEXIST, so persistent allocation failures can leave
the task spinning instead of returning the error.

Restore swap to index_entry on allocation failure so the existing error
path checks the original entry. This preserves the allocation error if
the entry is unchanged and still retries if it changed concurrently.

Fixes: 91ab656ece13 ("mm/shmem, swap: tidy up swap entry splitting")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Link: https://patch.msgid.link/20261029-fixes_shmem-v4-12-392fc715d8f6@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index e1b7cf4b5280a..02de6326ef3b3 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2552,6 +2552,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			else
 				error = -ENOMEM;
 			folio = NULL;
+			/* Make sure to validate the original value. */
+			swap = index_entry;
 			goto failed;
 		}
 		if (fault_type) {
-- 
2.53.0




