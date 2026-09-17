Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FB51AAE28
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789615236; cv=none; b=riOh5l3xTNnVUhot00fK0B7m5lgAuLlo8DaiU4zuIESdC4x8KXvL3ekt+OVFEPRVaLZgKQjzq9Uzg5GC06A3CEhGcuPfm4lBeFN95pwoX27wHzRr17GLpQ+aMsWxIqeSIfa8W6RsUynGmbaA+q9T9kYDr99EpO3ML8WE8mmx25c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789615236; c=relaxed/simple;
	bh=lEWGQjnqxr3VzBx3GwuRKF6jRh0uZ+viHbD/+q6XrRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kwcz8kCCuNzP49/K7ZIr3YbkWdR+FMjdAb+a93c776PadUxm82aAKimMxcj8Xe8yuecnC1shZtYJqEWUZZQ5p+wCcQ1DlJNGqU/k7jjpOAp0DDVH6DECbf3vKDnMPFDXFmjKeGhMTDA9M7DpgA/AYvdOMJIBAyIxPQDqrhaVWfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBp2SacW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBp2SacW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73831F000FF;
	Thu, 17 Sep 2026 03:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789615234;
	bh=rTkLf+Ry0gjV5dYI4+0/bW3PvH4AymI9essuHw1zFWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SBp2SacW+uv7Nk/dMGFk80riaBStHWLQNLSAvBM0uiZ2OArE9yMiNUTMIPl9UYQL1
	 uNxv3XXEIFK//et0OeJ5taD1ogarhg5FWBoeVZ5581LCBSG2QMTVuH9L9LnL4mIH6k
	 JlmF1t7Oftt4sG5Bm8wfvDrxHovG/NyQ0vk6MXPtV4RVEZA6k/jj1TuzvX6CBCDKHF
	 QEmSs1mq1fGJOWH5iSTcrJwOR+imjXEAQYRC0auKwV8ybSaRHKt6z/DT8Q+zm91+8X
	 7k6+PtRCX+SF+0PE6yN496iQSug19ajEjDgVXVKbHStADtJYssQJMiY/UaarTbOvgG
	 68E6UQMbGlVaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aohan Mei <henrymei@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: reject userspace cifs.idmap descriptions
Date: Wed, 16 Sep 2026 23:20:32 -0400
Message-ID: <20260917032032.3994854-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091652-deodorize-unison-29a4@gregkh>
References: <2026091652-deodorize-unison-29a4@gregkh>
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
index 1b52e0c88877a..070bc9b46b743 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -93,8 +93,23 @@ cifs_idmap_key_destroy(struct key *key)
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

