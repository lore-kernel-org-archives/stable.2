Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [51.250.60.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF7A353A95
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 06:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.60.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791528180; cv=none; b=C2zv6Er/sh0N/pdNpY7EiC+lDGItXHisbzveoaN+HUMqyr8UEJ9Cc//jS1R7pfonZS5VnY3lVJ+Jy5SEgCgG1M8uJdBhMDEFrMPN4CGU+1Je4PIIk8+M+7mLtaiViw9MANIwR6RA3s4KsKX2YeMsz85L7E7N45XYY1HfYREAQYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791528180; c=relaxed/simple;
	bh=n05IuYNlBEUv4OXwcucbKcjaiUVs3ggrFzBjjJzuuuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNf/CrXPva6Q2We1+lUNlvtMGWuKN3HbhF3jLy8MU0BkTAJBw0vlDJUbNQ5gkY3JY3YWfyDbzX82HGI1a4A06CsQ82rFIW7PErg3QgdtHjx1w1hjJKhP0I/DDv5WAMEsxKWPG3N5zLsnOoXOe11xukCjOeAHST04sIGgvNY+XK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=JAGe7M/b; arc=none smtp.client-ip=51.250.60.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="JAGe7M/b"
Received: from mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1924:0:640:b9a6:0])
	by forward102d.mail.yandex.net (postfix) with ESMTPS id E5272C0281;
	Fri, 09 Oct 2026 09:42:47 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (smtp) with ESMTPSA id igIbxPLdZW20-rjteNtrN;
	Fri, 09 Oct 2026 09:42:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1791528167; bh=WyScD8LTapNqO3ZGr2M2ZoA3z/tJBO9gO9m7DbN/fjo=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=JAGe7M/bzB07g9paMwA1hM34ghsxguSAqqeQIfXv3My01G5Fej2c4BaRzhwilh9zg
	 VzyCGyMWXK+AubXYJ/b256RYKP0qNG0+GkC3cOlRt0+7ykYgt853MM4wf/9d6Yns5Z
	 3bcgDbtRwEuypxbx5C+7wE1tDwa3G98Vn6S9IGlg=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lvc-patches@linuxtesting.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Sami Tolvanen <samitolvanen@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 6.12 3/4] selftests/bpf: Use the correct destructor kfunc type
Date: Fri,  9 Oct 2026 09:42:19 +0300
Message-ID: <20261009064220.451530-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009064220.451530-1-dmantipov@yandex.ru>
References: <20261009064220.451530-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sami Tolvanen <samitolvanen@google.com>

commit ba7f1024a1024f219a18c40b4ab2d7d900fd2d15 upstream.

With CONFIG_CFI enabled, the kernel strictly enforces that indirect
function calls use a function pointer type that matches the target
function. As bpf_testmod_ctx_release() signature differs from the
btf_dtor_kfunc_t pointer type used for the destructor calls in
bpf_obj_free_fields(), add a stub function with the correct type to
fix the type mismatch.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/r/20260110082548.113748-9-samitolvanen@google.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 4e6a9e9c0368..321b867e8630 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -245,6 +245,12 @@ __bpf_kfunc void bpf_testmod_ctx_release(struct bpf_testmod_ctx *ctx)
 		call_rcu(&ctx->rcu, testmod_free_cb);
 }
 
+__bpf_kfunc void bpf_testmod_ctx_release_dtor(void *ctx)
+{
+	bpf_testmod_ctx_release(ctx);
+}
+CFI_NOSEAL(bpf_testmod_ctx_release_dtor);
+
 struct bpf_testmod_btf_type_tag_1 {
 	int a;
 };
@@ -590,7 +596,7 @@ BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
 
 BTF_ID_LIST(bpf_testmod_dtor_ids)
 BTF_ID(struct, bpf_testmod_ctx)
-BTF_ID(func, bpf_testmod_ctx_release)
+BTF_ID(func, bpf_testmod_ctx_release_dtor)
 
 static const struct btf_kfunc_id_set bpf_testmod_common_kfunc_set = {
 	.owner = THIS_MODULE,
-- 
2.56.0

