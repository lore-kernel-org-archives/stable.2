Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [51.250.60.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565E84AA02F
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.60.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403605; cv=none; b=KJHKxcs5vcCWK+IX/7socwpP11qDPVx98vFztnkgs/PWZ50w2XHJBH9jA0/oBe+m/cGWhOpiA2FBCiavi4o1ua/W6LJJ6shwze+E5TESV00gDowikVUVHF2neLI892+VwP3jhQW2F7Xz44V2fDU8P+kHVyD69rNkn0jMby5yvfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403605; c=relaxed/simple;
	bh=n05IuYNlBEUv4OXwcucbKcjaiUVs3ggrFzBjjJzuuuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTbDlS0VEsPdwgSGzk4LCegICfCPN23kK8gDEBxZuOGh/Q/TYjn7wT3jI8Laa++H3rRjEbUBuuXIvu0WnCBTn/SkTi2Ft5tthWiJnQZ6IoLzYAkPRTyAgKPS3gFx/5D2SUQQv2qDv3loOIQ6pIJ4RZFoOAr5ro+tVu4ZwrLgIDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=coCgNqPo; arc=none smtp.client-ip=51.250.60.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="coCgNqPo"
Received: from forward101e.mail.yandex.net (forward101e.mail.yandex.net [IPv6:2a02:6b8:c32:0:1:45:d181:d101])
	by forward101d.mail.yandex.net (postfix) with ESMTPS id D8660C00D7
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 12:53:19 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-36.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.yp-c.yandex.net)
	by forward101e.mail.yandex.net (postfix) with ESMTPS id 23E1D10043E;
	Mon, 19 Oct 2026 12:53:12 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36 with ESMTPSA id 5rV6YbUhriE0-V9stoluJ;
	Mon, 19 Oct 2026 12:53:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1792403591; bh=WyScD8LTapNqO3ZGr2M2ZoA3z/tJBO9gO9m7DbN/fjo=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=coCgNqPoT7noXiIUH3zGKT/9MWyccOeMn7/rHX98qAn8xOWkXAg7MZz5u3AiWEI7q
	 hHjdg3isL5v9wsW2WUcrzfl6FFmX/rnuDeRZoS3IP0KLoAqC81TQfa86MST+9ntReN
	 n6X5vALt0mEc3oaHdRHsy/3Cui7M9yBgsV7OTODc=
Authentication-Results: mail-nwsmtp-smtp-production-main-36; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lvc-project@linuxtesting.org,
	Sami Tolvanen <samitolvanen@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 6.12 v2 4/5] selftests/bpf: Use the correct destructor kfunc type
Date: Mon, 19 Oct 2026 12:52:38 +0300
Message-ID: <20261019095239.221813-5-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019095239.221813-1-dmantipov@yandex.ru>
References: <20261019095239.221813-1-dmantipov@yandex.ru>
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

