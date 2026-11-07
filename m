Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047975;
	b=bbIIHsZSj6jyYpiNYEJpZHWiIqC+5HNaiV/mcYK1OHMFZBZ9VJB02+Milq7lPgsQnu9M
	 5iE56Ooul+oyX513nreqHyvg7xX2kfPRuCKhsr/X/ZPzVXc2sh0IbEMOV+w99N7IBBAX5
	 wUAJS+Z+vSEbLdgZls2CrQE7EbIt/onMqZJKsTWCa3u4J8wVUWec1kNiIkBdPFalGKddI
	 5Zl7/p44cz5QPdlGD40KkkbXCPoVctcp7fas8T/BCda1rnpfpZO+tqyHURlmgLyc8fTCp
	 /l3EkzPnyhP559AeRp7l17+1S68moVzji4Clk6zqrRQbwt/jYRMxAXdq/5/6qhHvrmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047975;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=aYi1t8smN4vptEHnFOyugaj1byQTU3gES1Jduu4X2gw=;
	b=TcT5qNf24DZwV+l7sLu5/ZWNUKKXPqF7UZ58zhKlBP847hK1EN7Fl1XqD0V3ImMyISdm
	 U0dD0pIAR+9xqBfMzWm6tudnJWk/AASFAD9q7hJC/+1dxD60nnOXloxz3VTc2fyXgarGo
	 S8X2hgCdu0IaW/fwethLx7XR+ipw3qBDRPzHvf7rel+jtFYCn+hmmX4k5B9YgXJX8JyBL
	 Hb+gDYjeO0EXGvh9ZqMKZTHO5QDuQYR6hO9Ic7MAYJgJgcGqkOz2GptwKmWBk0I2Wo+vG
	 MMGLcNzlnU0koCiUurfWTp+VW3qLUmKej8kIknQScO4U6g2Hvr7SS94chiwT6BKfhOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nyUAMdcP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F29606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nyUAMdcP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665711F0089F;
	Sat,  7 Nov 2026 10:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047975;
	bh=aYi1t8smN4vptEHnFOyugaj1byQTU3gES1Jduu4X2gw=;
	h=From:To:Cc:Subject:Date;
	b=nyUAMdcPt1zPxtUp4uPZQvE5JugKMp/mwi1UJZ6BYx2wcBnSdouioVZw5eotKoL7N
	 P4X8Qppac8y9GBPB8s5L5qRGcmfiRabo6CUkbvbnH/bmtCyuMbP224lcRSXJhjxkMl
	 MBDiLXxS3RthLtvRehOYghNHrEG67xHHsNqwWhZmhmiA+ZSvFLasT17NiWHYpvam8o
	 G7xqcGfOcSRu+rC9Iv5jy+bf3yGfUIf7Ocfqi4pz7ho0AThhvj77cbTkYH6712YlnK
	 119ps5GThcOsY32PliQJbJGK90xG43cTOBc5VeUZbiO5PKNyDc0HEj3cAOTBDNtbfu
	 Xbp62pzZbf1yA==
From: Sasha Levin <sashal@kernel.org>
To: zzyy19904204639@163.com,
	vega@nebusec.ai,
	weir@nebusec.ai,
	amarkuze@redhat.com,
	idryomov@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] libceph: initialize CRUSH choose argument weights" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:39:33 -0500
Message-ID: <20261107053933-failed-6.6-c3a995ff0782@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c3a995ff0782587789333c621e1f6bd5e574371e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053933-failed-6.6-c3a995ff0782@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




