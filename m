Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F094439F86
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585681; cv=none; b=BX/2bmioyZvx7G6sbABCnPe5Y4e5CiGYdBVKGmZrnohd7utf45UkSsloSbohrZO75A0VGYtYeHW1YV/PwlAJjSJJUGYdOseqTYIY9WMiCNDIbma6ZSCZN82x6xmV9PjanLaB35UeBY9kQvvd92351Iqbw+4/9IrjN0uK8THUKqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585681; c=relaxed/simple;
	bh=LD25mc55Ci+THDGXv4PexIzjSt2pjtJ6qoO5lPi185g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFcukRUycnTKLlbE1rjDzniH8tuVmXRkf/3KcfXMnQVZMdZX3+fr2E113tTcnbIGJGkZ8xy7GgAssm0hMkBhrVdMz8gQPgivNF/4QBxMhL/2BCtoBDRNmUYv1vL0Mc5OEsz+mqZ2u/tv219K/tDRP4Ctsx7IFd3NAOT+EMrXOu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdXQldvq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdXQldvq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5E51F00A3A;
	Mon, 24 Aug 2026 15:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787585680;
	bh=o4rUx+0dZN+7k0+rvVGxygzDDmZK1/jzP1bvurs4aXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XdXQldvqVcvEHWFrsDB4oIQeo1ha0hreRFrzcNuihugSjQcxpliwzozuo6GSRjmLg
	 +wN2ZjLoUBx0NPxcv/mtjSsYTCTF2HAOuaj6m11x/LfUdOwUOuEri+5iN0syyTf4ZA
	 f98Ig32t1tQjpchfpWC2ytbYHJLD+GAkph3LWnncrRhnqFXAyENRwAkmvI9MfxL3NI
	 +4TWwlBW5n+O4HCN17ZJcWuzT3q83LgzsV4sYGWk9jAKD3XF0v29fX7Lfa6HOXiUsh
	 FEuLlrf9EAoEOG9o4rhVqM7R59XXnvXpEukvDr7cCZG0i10FKfI3Bw21w+R7njNweH
	 RWp9LdfF9Ifig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pavitra Jha <jhapavitra98@gmail.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] libceph: fix OOB read in decode_watchers() via missing bounds check
Date: Mon, 24 Aug 2026 11:34:37 -0400
Message-ID: <20260824153437.3851112-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082058-swiftly-hardwood-656a@gregkh>
References: <2026082058-swiftly-hardwood-656a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavitra Jha <jhapavitra98@gmail.com>

[ Upstream commit 00ead17c7de137a692edee59f2772e6af687e8eb ]

ceph_start_decoding() validates that struct_len bytes remain in the
buffer after the encoding header, but accepts struct_len=0 as valid:
ceph_decode_need(p, end, 0, bad) always passes. When a malicious or
compromised OSD sends an obj_list_watch_response_t reply with
struct_len=0, ceph_start_decoding() returns success with p == end,
leaving zero bytes guaranteed for subsequent reads.

The immediately following ceph_decode_32(p) in decode_watchers() has
no preceding bounds check. With p == end this is a 4-byte read past
the validated buffer boundary. The garbage value is then passed
directly to kzalloc_objs() as the watcher count.

The sibling function decode_watcher() already uses the safe variants
(ceph_decode_copy_safe, ceph_decode_64_safe, ceph_decode_skip_32)
after its own ceph_start_decoding() call. decode_watchers() is the
only site that uses the bare variant, confirming an oversight.

Fix by replacing ceph_decode_32(p) with ceph_decode_32_safe(p, end,
*num_watchers, bad), consistent with the established pattern.

Attacker model: a malicious or compromised OSD in a multi-tenant Ceph
deployment (e.g. cloud) can trigger this against any kernel client
that calls CEPH_OSD_OP_LIST_WATCHERS, without any further privileges
beyond OSD session establishment.

[ idryomov: trim changelog ]

Cc: stable@vger.kernel.org
Fixes: a4ed38d7a180 ("libceph: support for CEPH_OSD_OP_LIST_WATCHERS")
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ceph/osd_client.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 89b02b8baca35..92d379c60da5c 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -4993,7 +4993,7 @@ static int decode_watchers(void **p, void *end,
 	if (ret)
 		return ret;
 
-	*num_watchers = ceph_decode_32(p);
+	ceph_decode_32_safe(p, end, *num_watchers, bad);
 	*watchers = kcalloc(*num_watchers, sizeof(**watchers), GFP_NOIO);
 	if (!*watchers)
 		return -ENOMEM;
@@ -5007,6 +5007,9 @@ static int decode_watchers(void **p, void *end,
 	}
 
 	return 0;
+
+bad:
+	return -EINVAL;
 }
 
 /*
-- 
2.53.0

