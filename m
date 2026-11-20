Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170897;
	b=YZLusMEld9ljpF7qg+egmyluKB9zOEtOuMvVibdDRBHdxAdORXWqLHKitLXSZpd16FBt
	 enloOWkdp9MDYRmCTnAeZgk77nTAPapLbyH6ixu4p/uSsKav98xf3z6tbFIZgPCziVtDO
	 147gCp+MhgHYTALgkQSSmdqCTUFsjQQtAsKrcOlZOB83m+qE4RGXIuNE8IC1/9ZT96Ff4
	 iP589sL5D8HlxmiCFSHo0Q+A+mhfSqlZLhNJfniEc3MC0eF0VayplF6s6V7LINmD84NZ6
	 zUPmfVEhNqKLvU/ahIsGU70JL+Alv0GHIISkhZD+bERYdpp7UsXtSZKXwTe9S2FN/0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170897;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=11nDEItDnEf9IWVwIw4QwOtVFX0pVzD0C56dS2T97Oc=;
	b=27ZcG6t929lvp5wLnQdC57hyiPcLaZZze382QYlRv7ao/Z+cvJg5OoTcdVuNUqa7c7HB
	 YClJ6JZx/H7dL3Hie1AUDE5txQ4bKJ1ohSTwPzs/krbzndzX91/n/mCkZDLTcbObX5OVd
	 joCEW2HisUGEh0ro3Ju2eTbURoG305iJmzM9TZ+aWtsTJ5D3TpuBlx6uv0xipwCxW34RW
	 hNyzGDOi3tiOSKN5n36g89e6zzdkkrKOmOB4q4TqgAjxZNHH3vdpsoUxHf5Y9T3JTpCR0
	 HCsrE4jw2ybky1DLBAQJ3aElpiswOY8rvV9eh4hLMCzmdKrc1jQdj63/HXHTxKc8CwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UlSnMms0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F23606A320;
	Fri, 20 Nov 2026 10:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UlSnMms0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD4E1F000EC;
	Fri, 20 Nov 2026 10:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795170896;
	bh=11nDEItDnEf9IWVwIw4QwOtVFX0pVzD0C56dS2T97Oc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UlSnMms0vGikcAnJG6qqdFJR57dRq1vs5dd/Idk8ENnyAlTpNH/ktQvw6UuTEehmg
	 deVXXT8QFsBWEgzDa7PupG11Lcqk0NkMMVaOKNzRAsX7wGNPYAogxp9ZQLPLrC2Fzj
	 q9bYB4i9VT1gt7Vf9FhWJGz+ZmVagqEvVHUk+8b+EcCtpdHs7EVUvCRZo6pg86GwvB
	 E/rgZwkUpAgPKoKPClDhsgOqoNVp9lh28/t+l6BzGMbG8k/Mx/natY7KHFa7V5kC17
	 aUUDl2JuL8J9N6U6vuI4eodUxJJH1yYaMJKVeqoclRSaHs32EJhmS/onZIKSkgAIiy
	 ZT2moDUFxI/SQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Fri, 20 Nov 2026 11:34:43 +0100
Subject: [PATCH 2/2] vmw_balloon: account 2 MiB pages in NR_BALLOON_PAGES
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
Message-Id: <20261120-b4-balloon_nr_pages-v1-2-d8944b587819@kernel.org>
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
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593; i=david@kernel.org;
 h=from:subject:message-id; bh=6FQGSQFtSeIoA04JJqzZmDwVXcEslBgR8TrlTiQR56c=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIZlFy/Clz4sES/6azaEaZ/qu6b8q96HmbKiuewNn9aY
 KHow8vZUcrCIMbBICumyBIUfN/g5ct1tdVufMwwc1iZQIYwcHEKwESeLGL4Xzgl+9UZr++bQz5p
 VjlNtwwVV7HVYJjTXisjlfH134JWG0aG67MUrfb8v20xY1lRv/nGxf2GXz4wGdar3TzPMPlSSV0
 eFwA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

vmw_balloon keeps 2 MiB balloon-inflated pages on its own list, not
using balloon core that takes otherwise care of updating NR_BALLOON_PAGES
for base pages.

So far we didn't account 2 MiB pages under the "Balloon" counters, so
/proc/meminfo etc. would not reflect them.

Fix it by updating NR_BALLOON_PAGES when enqueuing and dequeuing for
these pages manually.

This has low urgency.

Fixes: 4d689474e1b2 ("balloon_compaction: update the NR_BALLOON_PAGES state")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 drivers/misc/vmw_balloon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 3edb934dd7fd5..47dbcb3be6ed6 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1005,6 +1005,8 @@ static void vmballoon_enqueue_page_list(struct vmballoon *b,
 
 		list_for_each_entry(page, pages, lru) {
 			vmballoon_mark_page_offline(page, VMW_BALLOON_2M_PAGE);
+			mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
+					    1 << VMW_BALLOON_2M_ORDER);
 		}
 
 		list_splice_init(pages, &b->huge_pages);
@@ -1049,6 +1051,8 @@ static void vmballoon_dequeue_page_list(struct vmballoon *b,
 	spin_lock(&b->huge_pages_lock);
 	list_for_each_entry_safe(page, tmp, &b->huge_pages, lru) {
 		vmballoon_mark_page_online(page, VMW_BALLOON_2M_PAGE);
+		mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
+				    -(1 << VMW_BALLOON_2M_ORDER));
 
 		list_move(&page->lru, pages);
 		if (++i == n_req_pages)

-- 
2.56.1

