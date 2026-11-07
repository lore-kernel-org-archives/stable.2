Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047208;
	b=hwkedXRpOdKoAESeV8UC7VD0u8JhioRAOimkNY9iypgi+oe+hm5oDZbHVlxuAtNQR1yc
	 niZEatzNkIYgoVmFtlK2pDkPuXloAHWEM8vqfyFFV/ZCF/Sx3IDnaMiyg0qfdGUcIBU6T
	 5tpUEWjWw9aDNqweQiUwBc/XkDsv77xVlIPwxS2Nt7Y88yCvoslxX7Nxp4pame5Ht9D1v
	 cTzLexw7xVdqQ8/LA0m5RFLtZdtIu1byG6661+qjThpmcRTh3ioBNUGktLVSc8irYhTvm
	 Oo2izxHlY5kPwTrrUzFSQwc9h3v18e28xcESFf6QS6vWFtTZQzKfFevqARkBMU/lmmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047208;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8kJrOJ0AFQ0oaCpQl3VtLRFM/DV2vV/IlRai6c9uz0k=;
	b=YP63CYH4iwwp42u/L6fzsvKzo3TYJzVY13+DKhpZytskuTaI2r/y2uOuaFLbzdqrIQ5E
	 AA0I//NZgCElFsTtRxwedW0ZcV63BItMPYNiQO/brXWKXDikV43wTLUk9C8CPEiTDDn+I
	 yi/Q2E4MGba0zYADzdKAPGkkS7gb47X6+JxcOU245k+Hxloi1VgB9Mywpjm005PrUg/iQ
	 +hXpv9z7gMI32wCBuIOzYrpHIgYOfmRQZ5gF3OyNhbvxNjQN1Xxd4pCcGykDw0++1/EaI
	 AGk682I3zsdThdGFhmPArUxA747rX2ibtIY4uRJ4+ccjylZ7YMDU72sdPI/6ht9Ej1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gWbb5NRb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12986606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gWbb5NRb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E401F0089F;
	Sat,  7 Nov 2026 10:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047207;
	bh=8kJrOJ0AFQ0oaCpQl3VtLRFM/DV2vV/IlRai6c9uz0k=;
	h=From:To:Cc:Subject:Date;
	b=gWbb5NRbA/AD00j8LaXI2XXmlj4AL303DisNRnOB+taQ/4mHAEp2ulCvb4gRnApnp
	 OnvjJoHtmWQbkYYH/dzFBxJbDxrFkJwfs6IUpNvKnGO3a95NhG5gZflMCAU0p3DpFe
	 hWZkT/UVR4fbGDPR4cPR9u40PEfWDNSoJC0UmRG9CjlsKU2wj12u1rawyjHsGhQYS+
	 LEBqja4XPB9EZYtmA2iPs3wPXXb8nIk2DR4tca3Ao08wL0wCa+mkfmB3qyfOW+OEw2
	 L4n7o5UlikX56A58BJX/kY4vCEDAek7jNeEQ+8i6gHmUyTIMc5leo4JtcDTuLxl+ut
	 2/dDQ3ua0ChIQ==
From: Sasha Levin <sashal@kernel.org>
To: zzyy19904204639@163.com,
	vega@nebusec.ai,
	weir@nebusec.ai,
	amarkuze@redhat.com,
	idryomov@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] libceph: initialize CRUSH choose argument weights" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:26:45 -0500
Message-ID: <20261107052645-failed-6.12-c3a995ff0782@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x c3a995ff0782587789333c621e1f6bd5e574371e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052645-failed-6.12-c3a995ff0782@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c3a995ff0782587789333c621e1f6bd5e574371e Mon Sep 17 00:00:00 2001
From: Darong Lu <zzyy19904204639@163.com>
Date: Mon, 28 Sep 2026 01:44:22 +0800
Subject: [PATCH] libceph: initialize CRUSH choose argument weights

Initialize the CRUSH choose argument weight-set array before decoding so
entries start in a defined state while the decoder fills them.

Cc: stable@vger.kernel.org
Fixes: 5cf9c4a9959b ("libceph, crush: per-pool crush_choose_arg_map for crush_do_rule()")
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Darong Lu <zzyy19904204639@163.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/osdmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 7d65a81148166..e69a2249ddfbf 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -319,7 +319,7 @@ static int decode_choose_arg(void **p, void *end, struct crush_choose_arg *arg)
 	if (arg->weight_set_size) {
 		u32 i;
 
-		arg->weight_set = kmalloc_objs(*arg->weight_set,
+		arg->weight_set = kzalloc_objs(*arg->weight_set,
 					       arg->weight_set_size, GFP_NOIO);
 		if (!arg->weight_set)
 			return -ENOMEM;
-- 
2.53.0




