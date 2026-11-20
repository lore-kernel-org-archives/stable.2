Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170893;
	b=UeQrlaN3EzE8dhPKiHwQC1/ikRNivN0cKZZ7luKFGJ3KO1ZCjNscb1NyS1sLlVRT2l7x
	 lhMMVQf08VmBYGGjFVi1jVZ36tMttsDn9K6Pj3bqG1Q0lrpfs7PXJclZuJP+Jszco3NoI
	 7/AQLLTvwRBw9AH0+NJgwOcCG3zQBsvKPMb6S8uFQrkpCO7smsIi1VrAXsnpJOHIrcqUL
	 UGSnm4/2jw+ZaAduQCDTlwPkeMw6FGt+npZnA/FyZMZ6kiTTgUDYGiJ6DhOOjzlm/55Lm
	 I08TdXCwzGvDRCzf4UpY33SdB5F8tMrvKRGSipkh3ltRU6aqqMWtmn9Up0DX9oVVhaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170893;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=NIf0XC3unLIGycPwy7b+8DZLYvzuuP2h7PHGv9TP1/M=;
	b=wrUcZ+86YnAPWB9hG2soILzxpmDRsdjDVtpDH5QTh3y560G1yi8opPTEwe1LK0EiN04a
	 e8rXPKEh4MhQsVT3GV0zIgFunWSeleCk3PNHPuc/FZRSn+fBcBjp9PQTILhyFhrVsyD1u
	 4f5/myypYOApCFJjZRlNDQH7o/NP1SJ2sT0lTxSvQ8a1HG0o0ORgXYGiURfIf3Fat+EGl
	 MqigDphG46ugqFblyHwm9AhneKFQWX8gbTBFHb9LursfwbIogOMeeieLXFbAo1aN8XIOc
	 sMFtRvp8nLbGvbrkdRsAZnPFD5RHjAYRPA0SbLWoHR09Vda2dnhR9Ob/tZBVK6PLGmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cYCVV8A9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C59606A337;
	Fri, 20 Nov 2026 10:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cYCVV8A9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB861F000C0;
	Fri, 20 Nov 2026 10:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795170892;
	bh=NIf0XC3unLIGycPwy7b+8DZLYvzuuP2h7PHGv9TP1/M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cYCVV8A9+VIzoDC+yu27UtvyOkeEBh/LkrShUKvOzSV6gdELr4bR9zKDjRr7ukwDk
	 aI94LGBto98W4Ux3nZAmQEzNyUf9wDyg/3oTxuSBI+Osh3WMQW3tbpvz5UdgTC9Arq
	 oJuzOiFnuUjACdXUQQm4NWe9KP/lfH4ZWn1G4VSEi1n5m+IJH/Dgu8Xkgr0dDuiz0u
	 /4MNWlevh5cct+TBF7No7uYC1sA0l9cybd8kg/sKuWdDnasl/UZ5wy6hvHf3Y7Y8Fo
	 hgfqc3bXqgAHwLxDliDWViJ3dWFmU5i7OuY250vD/xHHRQF6s1Mnb/bETCiwujMpjc
	 OQFOqzoelLBMA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Fri, 20 Nov 2026 11:34:42 +0100
Subject: [PATCH 1/2] mm/balloon: fix NR_BALLOON_PAGES accounting during
 page migration
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-b4-balloon_nr_pages-v1-1-d8944b587819@kernel.org>
References: <20261120-b4-balloon_nr_pages-v1-0-d8944b587819@kernel.org>
In-Reply-To: <20261120-b4-balloon_nr_pages-v1-0-d8944b587819@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Nico Pache <nico.pache@linux.dev>, 
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: linux-mm@kvack.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>, 
 stable@vger.kernel.org, Shao Mingyin <shao.mingyin@zte.com.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1649; i=david@kernel.org;
 h=from:subject:message-id; bh=lfRg64mzDBRbG2+tSqnrBIxz1wpQE4OfxlTPZhj6dXA=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIZlFzvmUVNk3WbFv1t0iJTzl3n73w+veTfqeKlu1sed
 u8Nzrtt1FHKwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBEihYwMqzdcSTi0pXW1Q/z
 t4sybDu834vz07JlJb8fVb6/Hv6yLLic4a9AeeHVtYs1dzhde8PR7vzWIIBF8tkb6WnfFnOfFAm
 40MsJAA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

balloon_page_migrate() doesn't update NR_BALLOON_PAGES in two scenarios:

 (1) If the new page is on a different node than the old page.

 (2) If the old page was deflated but the new page could not be
     inflated, effectively deflating the balloon.

Consequently the "Balloon" values in /proc/meminfo, the per-node meminfo
etc. will be wrong.

Fix it by adjusting the "Balloon" counters accordingly just after
conditionally adjusting the manage page counts.

This has low urgency.

Fixes: 4d689474e1b2 ("balloon_compaction: update the NR_BALLOON_PAGES state")
Cc: stable@vger.kernel.org
Reported-by: Shao Mingyin <shao.mingyin@zte.com.cn>
Closes: https://lore.kernel.org/r/20261115004708909xx05JgB9nXnOCG0zL7h_K@zte.com.cn
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/balloon.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/balloon.c b/mm/balloon.c
index 96a8f1e20bc66..b31543dd4d4d2 100644
--- a/mm/balloon.c
+++ b/mm/balloon.c
@@ -310,12 +310,17 @@ static int balloon_page_migrate(struct page *newpage, struct page *page,
 			adjust_managed_page_count(page, 1);
 			adjust_managed_page_count(newpage, -1);
 		}
+		if (page_pgdat(page) != page_pgdat(newpage)) {
+			dec_node_page_state(page, NR_BALLOON_PAGES);
+			inc_node_page_state(newpage, NR_BALLOON_PAGES);
+		}
 	} else {
 		/* Old page was deflated but new page not inflated. */
 		__count_vm_event(BALLOON_DEFLATE);
 
 		if (b_dev_info->adjust_managed_page_count)
 			adjust_managed_page_count(page, 1);
+		dec_node_page_state(page, NR_BALLOON_PAGES);
 	}
 
 	b_dev_info->isolated_pages--;

-- 
2.56.1

