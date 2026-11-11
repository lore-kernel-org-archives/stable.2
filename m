Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368992;
	b=ZjCdr+sH5MxKKmqx7qBnqGJ2vY8NhIuxxpgsEC1d2089xBmvipbcKEzW00ZdnTP+6BAM
	 Wp3DAlMp0WZec5ACH+8XWHn+dXS0hA4LmtrGxBHA+8CbcmlDNfztYyNGUryq+iz33Pnxp
	 bgVWL7NTFMXhpowYuBQm8aYvXzUrnDXgm7onguS3gQ7LzQcxWiyxcEpbxaH0YdGZVfghJ
	 g8aJGqNrVHw7VIinmHibxoLo//V4CZbpqPiXOm+Q+TY+Da/gmt5NMUYkd8UhwfBS56jRQ
	 8zZwMRTg8U5RpkPy+PFPzX2eQkVcBtFQ3oHVsF87jpfiNcAyqaJXU7ikqRO55UGZZyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368992;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4s9CtiPP0Kq5oeJwuPfHnd5Oodde9BhBkHYevw75Ee0=;
	b=aOHK7OIhszLUk55DUjsh/ifrpLKFsBjCwMxTeCRFHf/mHTAjvaGzx/Kv18qFnMWGPmnT
	 1ip9XEMDnTOab/hy4etz6FdYMzXhE5daUDz+Btne/vTnhArVM/JseWYxeCywQNWu38UHd
	 NpaIjm3qqFL8c03qdEG/Xm/GUic6WlpEiIj7bg4JMlZRSyZkiQAGr741eSfaDFT5N1LGc
	 2IJRDTbQqdlnctYCFcesZUrTISev1hZHX7ui0n+K/ewP8RWvYGR5wLqkjMiFIt/5q0Qux
	 NlxbAggfsqzVAh433baXTohWQ5SjT+5zZRRHuN1FszDVtBqhrnwzMwM73/Nzbec0bFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kSRxyime;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD755606A327
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kSRxyime
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220DE1F00A00;
	Wed, 11 Nov 2026 03:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794368992;
	bh=4s9CtiPP0Kq5oeJwuPfHnd5Oodde9BhBkHYevw75Ee0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kSRxyime5qKwVk2QsUD8dFGPXxefmt3H4oz/Na2dgdCZiBh/Pchl2oXrFU2bl2WSI
	 9HYoCiOk9lSp5LMsV9Mn5kXdHERtziGcKUD/HdwqNbKKBnR5k0UOiATJTtMU+ns3t/
	 MVnzBsi7tFljFfwCjpNA/pAQVJzKLjI0oFvI3emtgpRJAeDRynKh1OUa3Dcf7L+go2
	 egTq3xkPQ90XwbsCP4hamnN57xRA/PJkU1y0PvO3cCIerKoFdlY5fb6WqfmGyiuZUi
	 O32azcweetEdbhT8u+ttkd21ZbsTSkOsDMNZLJdM7EiIZSNhxglClmIZ95ORrSYORs
	 URXqd7L7penyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Muhammad Bilal <meatuni001@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/4] platform/x86: hp-wmi: fix heap OOB read and memory corruption in hp_wmi_perform_query()
Date: Tue, 10 Nov 2026 22:49:48 -0500
Message-ID: <20261111034941.936350-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111034941.936350-1-sashal@kernel.org>
References: <20261107062147-failed-5.10-6dea092b261f@kernel.org>
 <20261111034941.936350-1-sashal@kernel.org>
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

From: Muhammad Bilal <meatuni001@gmail.com>

[ Upstream commit 6dea092b261f04d632411c2be52d13190f5f67b1 ]

hp_wmi_perform_query() evaluates an ACPI WMI method and expects a
struct bios_return header in the returned buffer. However, it only
checks that the ACPI object type is ACPI_TYPE_BUFFER without verifying
that obj->buffer.length is at least sizeof(*bios_return) (8 bytes).

If the firmware or ACPI method returns a buffer shorter than 8 bytes:

1. bios_return->return_code at offset 4 reads out of bounds from the
   allocated ACPI buffer slab.

2. If return_code evaluates to 0 and outsize is non-zero,
   (int)(obj->buffer.length - sizeof(*bios_return)) evaluates to a
   negative integer (e.g. -8 for a 0-length buffer). actual_outsize is
   set to this negative value and passed to memcpy(buffer, ...,
   actual_outsize), where the signed negative value is cast to
   size_t (e.g. 0xfffffffffffffff8), attempting to copy ~18 Exabytes
   and triggering an immediate kernel crash. Additionally,
   memset(buffer + actual_outsize, ...) performs an out-of-bounds
   write before buffer.

Fix this by ensuring obj->buffer.length is at least sizeof(*bios_return)
before accessing the return code, and compute actual_outsize safely
using min_t(u32, ...), which is sound specifically because the guard
above already rules out obj->buffer.length being smaller than
sizeof(*bios_return) by the time that subtraction runs.

Fixes: c3021ea1beee ("hp-wmi: allow setting input and output buffer sizes separately")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
Link: https://patch.msgid.link/20260826103012.240453-1-meatuni001@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/hp/hp-wmi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 140a5f797980d..c721fcdd2e43c 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -246,8 +246,9 @@ static int hp_wmi_perform_query(int query, enum hp_wmi_command command,
 		goto out_free;
 	}
 
-	if (obj->type != ACPI_TYPE_BUFFER) {
-		pr_warn("query 0x%x returned an invalid object 0x%x\n", query, ret);
+	if (obj->type != ACPI_TYPE_BUFFER ||
+	    obj->buffer.length < sizeof(*bios_return)) {
+		pr_warn("query 0x%x returned wrong type or too small buffer\n", query);
 		ret = -EINVAL;
 		goto out_free;
 	}
@@ -266,7 +267,7 @@ static int hp_wmi_perform_query(int query, enum hp_wmi_command command,
 	if (!outsize)
 		goto out_free;
 
-	actual_outsize = min(outsize, (int)(obj->buffer.length - sizeof(*bios_return)));
+	actual_outsize = min_t(u32, outsize, obj->buffer.length - sizeof(*bios_return));
 	memcpy(buffer, obj->buffer.pointer + sizeof(*bios_return), actual_outsize);
 	memset(buffer + actual_outsize, 0, outsize - actual_outsize);
 
-- 
2.53.0

