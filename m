Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3F53F58EF;
	Fri, 10 Jul 2026 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676009; cv=none; b=fz914eN7LP2M0PG1inauUVb30scve78l1wh58GERWRfq2d+qaoj34wePK2E8i7Pt6UCFzLXZZSLklJ4uGfY80euKopcGq1U0BgYm9IXUdPzx2G+lnG3dDB3q0fSSiCtC+cT5KlApTi0AoQJlsCl2RITHdBTPWcNn0R97/D7xNpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676009; c=relaxed/simple;
	bh=LJghwtw/rZdPZpzGD37v4e9liYjTcIOPdSBYtvPd6LM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YJrxE5GZJTNIgBumwswYqffJdUw/JMijreW2frCF5qXo9e3ZWAUf+Xl/1f68ttv6vqQAWPwHjBwwtlvgMMp3YM+V6u6x5h17P/eMMoGUbrJGvyhwd3my7vdIVdvx53nJDU0FCE8DyLpmH4Z/Hf5e+2/TYnV5m62vuVl2Um/AOoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nN7+0tvZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nN7+0tvZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2AC1F00A3A;
	Fri, 10 Jul 2026 09:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783676007;
	bh=xrs5lraalE2UG0MriVBsYhlbNUjZEy2u+I/gnOfdohU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nN7+0tvZRI8ao2T+BWyC2xVLZc9ZQ6PLswTiXRS2Z9lqXMUCPS1wpQxTSbT22Exct
	 K1JLTiwFpJ/XWy5Rf8To66gjwDJBIXlEHoAHCGj8HjSBts4kRQrHj/hUPv/49oukbI
	 I4MVlqSXSao9gatsjqV9Ttgi6B8iBiGZGJc3QRoFCK/YeKRyoj+uAb67EiQ4CT8hy8
	 IchSa1/AR8ooDSzLMgxajnyCOF8u1sBMi626J6ze54bXDSIhq+4PMpHnyJXsrj9gtz
	 zcgrxWBy3LYJXwckMZUfLM5vv2JFNAnyKJ1hgS6YY2ZkGl6OgcE+2tCgTzRzY/3HHN
	 Z4W3URY0XuuuA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 11:33:04 +0200
Subject: [PATCH v3 03/24] binfmt_misc: reject a flag character as the field
 delimiter
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v3-3-a162f7cb58d6@kernel.org>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com, stable@vger.kernel.org
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2408; i=brauner@kernel.org;
 h=from:subject:message-id; bh=LJghwtw/rZdPZpzGD37v4e9liYjTcIOPdSBYtvPd6LM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQF7IkLu1Tdkxr3luHWi29BHPxrVucsefmc+cTOA490o
 jfVJmZe6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIjJOMDCcn+nFPWZjX5ePN
 x7z6tcfrj3NOL9yf+NnnVoTVrgXrSvcyMjQHXBAQvhmS2lkjH2+2O7VxgfSVQKvfBTFB2SnZP37
 48AMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The registration string starts with a user chosen delimiter that
separates the individual fields. So that the field parsers terminate
even on a truncated string create_entry() pads the buffer with that
same delimiter:

	memset(buf + count, del, 8);

Most fields are scanned for the delimiter with strchr()/scanarg() and
happily stop on the padding. The flags field is different: instead of
scanning for the delimiter check_special_flags() consumes the flag
characters 'P', 'O', 'C' and 'F' and stops at the first byte that is
none of them, relying on the trailing delimiter to end the scan.

If the delimiter is itself a flag character the padding no longer acts
as a terminator. The scan swallows all eight padding bytes and keeps
reading past the end of the allocation until it hits a byte that is
not a flag character. For example registering

	PaPEPPxPPiP

with 'P' as the delimiter (name "a", type extension, magic "x",
interpreter "i", empty flags) leaves the flag scan running off the end
of the buffer. The registration is rejected in the end because the
parser does not stop exactly at buf + count, but only after the out of
bounds read has already happened. With an unlucky allocation layout the
scan can walk into an unmapped page; under KASAN it is reported as a
slab out of bounds read. binfmt_misc mounts are available to
unprivileged users in a user namespace so the read is reachable without
privileges.

Reject a delimiter that is one of the flag characters up front. Such a
registration was always rejected anyway, only after the out of bounds
read, so no valid registration string changes meaning.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 24142859658c..b7664d90eb8f 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -385,6 +385,10 @@ static Node *create_entry(const char __user *buffer, size_t count)
 
 	pr_debug("register: delim: %#x {%c}\n", del, del);
 
+	/* A flag-char delimiter runs the flag scan off the buffer. */
+	if (del == 'P' || del == 'O' || del == 'C' || del == 'F')
+		goto einval;
+
 	/* Pad the buffer with the delim to simplify parsing below. */
 	memset(buf + count, del, 8);
 

-- 
2.53.0

