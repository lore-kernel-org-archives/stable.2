Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050958;
	b=3m4S5su094oWjSA3+YkvakLZKwm0fmA83CvhthyGfnNRfsPUS/O4Ki8b24KwSnCHy5Bb
	 jE6yBx8162keLxGBvBxA8dzyfhJoD+k+zDdLw9HQRT61dU+XCLRFYE8r+J0S9zcVWHNNH
	 fetWUETF+v6X17+Lq/6Nfk7uYXrMRO4dGj3XhE5iy3k9afgTGfzmfefvYgSn+4tJdOV2b
	 dDkpELRd3kmPZdDlTS2QhEs09Yb1JB7ZLO3bY9uq/ATM3Q0kOHmG81HhcRVYdDD5IGNml
	 KSYJ60P54QFS3OKoV+WlxKSTReE1oihskwC43n5QZEd/bO/HIF8cTYr+ErLgwhB6POQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050958;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VGaNVe8rDNy6TEIzHLIsGjWS+bPJpW/DS5FNv8/oAGg=;
	b=eMg/Ul5ozKGJCpobBN47/mEqoJ4mkqAyTPjk6oqpJ5bBDB3Ie3IWm93JW6w5pAqgdhkm
	 /AYtwP+c6LcGsVo1Ilp3g2t38oY9kQpz65h2MS+rp4mL4urb47a9z/stp+s90aEMUaIQE
	 a4kJKhxC/ZcbJaoI3BRojEGg+v60N/K1BurkgtRf2ougPwdcowyxwCsxxkn2pl4sBwNma
	 M6JI5dcheymGBWRaXY6JsG017bHiMi1oucfrU4ZlXHcZ6rdlMdY/OTSX9bmwH1V6tUZCu
	 VFz5VHpI3EBxHz3WjNuzvOpF1/TGQ9t6vl96i1tVpf4z8F81aJpMb8LXGyinGDsF1dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aj1dXrPu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EE8606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aj1dXrPu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1475A1F0089F;
	Sat,  7 Nov 2026 11:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050957;
	bh=VGaNVe8rDNy6TEIzHLIsGjWS+bPJpW/DS5FNv8/oAGg=;
	h=From:To:Cc:Subject:Date;
	b=Aj1dXrPuikbMEkFX0VVj7Fg3hv5Jv3VQCrdZWk7RrJcas/Hm8yQylMhl0ImWeNDYW
	 WY5JZpsN+kpEEKbE67ZpLwXdEMtdXRAxyXk7EfDzrbQ+5CADipZuSCuiBXgULU32gG
	 ofQRJ8+Z9y0oP3GXU+iuC0DY4fyzVYFsf1ukYZU0aa9Ys14SJNX1B9LubB+nw5u+G2
	 qxRUEyZmnAOdeLkJ12p6MqE7X+Dw3tKOFUOh3OUry/4ItrKWhME/XQaBVHAlQTxA1L
	 4cWxknw8WQqhKZs0euFIkYV7sI0eiplaX/WHvnkZKw9GjePnJ1KxHx0mOxMJGFq/Kx
	 EhAd26xaYWraQ==
From: Sasha Levin <sashal@kernel.org>
To: zzyy19904204639@163.com,
	vega@nebusec.ai,
	weir@nebusec.ai,
	amarkuze@redhat.com,
	idryomov@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] libceph: initialize CRUSH choose argument weights" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:29:15 -0500
Message-ID: <20261107062915-failed-5.10-c3a995ff0782@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c3a995ff0782587789333c621e1f6bd5e574371e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062915-failed-5.10-c3a995ff0782@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




