Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E4454652
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785373093; cv=none; b=GeiUO/kBZ+ofkEUaA4m+sKTnlHc3ew1dSP3hlgx7RqQMLCZDH4ag/jCuANQNfSMMOG5KH/aupBCshdfq+VZmNuTf/8G+FQlyXEQixaoeqbkI3d2kf7cIRW6DqdfqtbDG6BE6erfowJdShDA5EbGfMaGjn7QNUwF9T79keerkES8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785373093; c=relaxed/simple;
	bh=WbTInzwNHgU5dNMRWotWvNRiIP07OktVFNYiS/0yRXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8WgNPOOjWQmQfe2vO+kxmu+OWazva7nduL3WVyrwnj0XX0eHf0GVKxnx9SkAxfC/8uPvhPckOQDZlWBoT2j2WwdkA5CV/CVRTn5HFujRsr6S4n733h3cqkw6L6cMbt2y0ioWHnMAPkY/72RDO3ysTf0W2KY5yLkeRulmy3lQK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bt8d7NEd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bt8d7NEd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913F31F000E9;
	Thu, 30 Jul 2026 00:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785373092;
	bh=Xzwb1V0py9vR7piiS7xNnpByp3q3smSV3he6w3MTjPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bt8d7NEdQm4d/JZ4d0x09cFjpFzaEkYxCyXSnU5MfPVnyyAPQ5wf1ONnDXEMvwT4O
	 LsatXdKpisIx6f+KzHb9mV8GJlQznEW6HnXdZKUBMTmyaeUrQhQVvlLJrWdkV4Wepp
	 ZM948QHqPqjMAfxHjSYqXABcRTk/rpODN6dgIzxtCKVTDVDmR+qkyU36Ys76aw6/W+
	 hGe2r5JpSFcdwOowVzG9+QIVzWBZcV6KXEwEhtWyswoZWO5TR5zBcQTCGyDH/Aln2P
	 GJ7waZlGoyTKEzK0zXCcS+dfKOknj2w3zNw9e5sQWZkyKJDoS3u8QgozkFI32Ce7Hf
	 zAqTwI333No8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] Bluetooth: Remove usage of the deprecated ida_simple_xx() API
Date: Wed, 29 Jul 2026 20:58:08 -0400
Message-ID: <20260730005809.1696206-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072135-skiing-jawline-cb0b@gregkh>
References: <2026072135-skiing-jawline-cb0b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 9c16d0c8d93e3d2a95c5ed927b061f244db75579 ]

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

Note that the upper limit of ida_simple_get() is exclusive, but the one of
ida_alloc_max() is inclusive. So a -1 has been added when needed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: 84a4bb6548a2 ("Bluetooth: HCI: Remove HCI_AMP support")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_core.c | 9 +++++----
 net/bluetooth/hci_sock.c | 4 ++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6a69b85c1c7fce..00f813cae68c99 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2596,10 +2596,11 @@ int hci_register_dev(struct hci_dev *hdev)
 	 */
 	switch (hdev->dev_type) {
 	case HCI_PRIMARY:
-		id = ida_simple_get(&hci_index_ida, 0, HCI_MAX_ID, GFP_KERNEL);
+		id = ida_alloc_max(&hci_index_ida, HCI_MAX_ID - 1, GFP_KERNEL);
 		break;
 	case HCI_AMP:
-		id = ida_simple_get(&hci_index_ida, 1, HCI_MAX_ID, GFP_KERNEL);
+		id = ida_alloc_range(&hci_index_ida, 1, HCI_MAX_ID - 1,
+				     GFP_KERNEL);
 		break;
 	default:
 		return -EINVAL;
@@ -2698,7 +2699,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	destroy_workqueue(hdev->workqueue);
 	destroy_workqueue(hdev->req_workqueue);
 err:
-	ida_simple_remove(&hci_index_ida, hdev->id);
+	ida_free(&hci_index_ida, hdev->id);
 
 	return error;
 }
@@ -2787,7 +2788,7 @@ void hci_release_dev(struct hci_dev *hdev)
 	hci_dev_unlock(hdev);
 
 	ida_destroy(&hdev->unset_handle_ida);
-	ida_simple_remove(&hci_index_ida, hdev->id);
+	ida_free(&hci_index_ida, hdev->id);
 	kfree_skb(hdev->sent_cmd);
 	kfree_skb(hdev->recv_event);
 	kfree(hdev);
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index e7ec68fa3ad3c5..b818abbf871e79 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -101,7 +101,7 @@ static bool hci_sock_gen_cookie(struct sock *sk)
 	int id = hci_pi(sk)->cookie;
 
 	if (!id) {
-		id = ida_simple_get(&sock_cookie_ida, 1, 0, GFP_KERNEL);
+		id = ida_alloc_min(&sock_cookie_ida, 1, GFP_KERNEL);
 		if (id < 0)
 			id = 0xffffffff;
 
@@ -119,7 +119,7 @@ static void hci_sock_free_cookie(struct sock *sk)
 
 	if (id) {
 		hci_pi(sk)->cookie = 0xffffffff;
-		ida_simple_remove(&sock_cookie_ida, id);
+		ida_free(&sock_cookie_ida, id);
 	}
 }
 
-- 
2.53.0

