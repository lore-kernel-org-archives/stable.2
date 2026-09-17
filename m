Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3975433CE80
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789615769; cv=none; b=OrN6+OZCN+cCSc1assQQcTb8ClczR9xZWwii8eXeeGQ1TIetMAgl3b2h/TzroIT/j07BC8Edq/+ijmfLMJAmeLa9VOr6m4/FDTEwoGVF+6Igz2yAzC+orCfMDTtjDZRX3MhUxHh6mmzWcZnjchU4hNmib640HgTqHeAxkIc6wME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789615769; c=relaxed/simple;
	bh=d3AY2MrT8Prs5U7otZ5m/6+yTBiAY6CGqZ+CWZXH7Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ma9zKQR4jJIdX8I+4TWlUmz6+UV2F4M/7DOppO2w5V75zH563HUBIiATk4yA+z7QicCF9wxS/o6LZOmcOJS/cbR5f/XlTBHPD8XxWbju+sqrOvxWgamBu2V/eN8ewP7Yu1ihEjVz5LyZhbHk/9zOilBgntrAf3Ltc767IDhRiJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=om0AVlCs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="om0AVlCs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CF11F000FF;
	Thu, 17 Sep 2026 03:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789615767;
	bh=1ooa+gmf143sGVZkG7tORehkLMea+HfTFgs/4crNUho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=om0AVlCsid847EJ5tjbXBwDULYLFYDiX9TaR+u2mcmxqn6KBCpS3b5XcGbFFuurf9
	 jYV2KNvXr8YQULyL8GkskKShsmT54uz5ETCDvqtIvm4QD5HOUI7mwqOdK5Lroxcc/L
	 5iduOcnB5pUYTbZXc4iIX/ojqIIcw2BKWjbR0+qtD2BHpX96SoovJbXG8eGYEC+Wp+
	 hEisVhDeI3ZGYzwKCBf0S/lblnsWDBVe/HtNqfvDbRzMJRlw6qosmG1THFpbHQefAf
	 rtnSgPsVdKx+V3cWr8d2ysyKynKikymbOWGegDuJ7RUO7cnLIm9QNpVuCNVg/wGeRi
	 HRvGZV2jdjuBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aohan Mei <henrymei@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: reject userspace cifs.idmap descriptions
Date: Wed, 16 Sep 2026 23:29:25 -0400
Message-ID: <20260917032925.4027808-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091652-dreamy-pentagram-586f@gregkh>
References: <2026091652-dreamy-pentagram-586f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aohan Mei <henrymei@tencent.com>

[ Upstream commit d9d7eeb0cea5b55b82888f443622fd8d4ee064f3 ]

cifs.idmap key descriptions carry authority-bearing fields (owner and
group SIDs and uid/gid values in "os:"/"gs:"/"oi:"/"gi:" form) that the
cifs.idmap upcall helper treats as kernel-originating inputs.  Unlike
its sibling cifs.spnego, the cifs.idmap key type has no vet_description
hook, so userspace can create keys of this type through
request_key(2)/add_key(2) and supply those fields without CIFS origin.
A request_key(2) call with a non-NULL callout then drives a root
usermodehelper upcall (/sbin/request-key -> cifs.idmap) that consumes
the unvetted description in root context.

Only accept cifs.idmap descriptions while CIFS is using its private
root_cred to request the key.  id_to_sid()/sid_to_id() already run
under override_creds(root_cred), so the kernel-originated path is
unaffected.

This mirrors commit 3da1fdf4efbc ("smb: client: reject userspace
cifs.spnego descriptions"), which applied the same restriction to
cifs.spnego.

Fixes: 4d79dba0e007 ("cifs: Add idmap key and related data structures and functions (try #17 repost)")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Assisted-by: CodeBuddy:Kimi-K3
Signed-off-by: Aohan Mei <henrymei@tencent.com>
Acked-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifsacl.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
index c8a0a2edc6500..88ab54631345a 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -105,8 +105,23 @@ cifs_idmap_key_destroy(struct key *key)
 		kfree(key->payload.data[0]);
 }
 
+static int
+cifs_idmap_key_vet_description(const char *description)
+{
+	/*
+	 * cifs.idmap descriptions are authority-bearing inputs to the
+	 * cifs.idmap upcall helper.  Only allow the kernel to create this
+	 * type of key using the private root_cred installed in
+	 * init_cifs_idmap; reject userspace request_key(2)/add_key(2).
+	 */
+	if (current_cred() != root_cred)
+		return -EPERM;
+	return 0;
+}
+
 static struct key_type cifs_idmap_key_type = {
 	.name        = "cifs.idmap",
+	.vet_description = cifs_idmap_key_vet_description,
 	.instantiate = cifs_idmap_key_instantiate,
 	.destroy     = cifs_idmap_key_destroy,
 	.describe    = user_describe,
-- 
2.53.0

