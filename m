Received: from forward201d.mail.yandex.net (forward201d.mail.yandex.net [178.154.239.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098D03D6663
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 06:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791528661; cv=none; b=KsZkFApJksFDhc3BNSizLi7Ue/ZZuvnGrocpWI3+7Ad2VQa6CLJHC1GVFiKpy28+AMfyUVry46AOVKdsQIdgJ66bZ2GCghd/GhRUdCS6vabZeRPNcn6+OOAqtC5ZP4VWwoOHkaqE2wvf7KOyt2cj86I4ETfcXhptD/W05BCq3XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791528661; c=relaxed/simple;
	bh=NPcQU+TdPSBNuzZThbg37HnIF8ciK9VfGaEgERRfzAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9dXg07ZxIIJF4h44CCsy2FMtrwHF+KWa2P4VfEStzgZQz+XgrcjgTzfMi9oTbaFcHTv5qERjVqHTQV4k9WRKLMjKRUGFFzvB8uY7mpMzBWWk64XNiWzOlz7tMGhn+b4eXGzLSmrLunv6ddtiPTOIEBNkrONWXuaMFuUXJVr4iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=RKcle/Wi; arc=none smtp.client-ip=178.154.239.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="RKcle/Wi"
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d101])
	by forward201d.mail.yandex.net (postfix) with ESMTPS id 03BDB8D5F6
	for <stable@vger.kernel.org>; Fri, 09 Oct 2026 09:42:57 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1924:0:640:b9a6:0])
	by forward101d.mail.yandex.net (postfix) with ESMTPS id C8D42C00E5;
	Fri, 09 Oct 2026 09:42:48 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (smtp) with ESMTPSA id igIbxPLdZW20-rZTaBv66;
	Fri, 09 Oct 2026 09:42:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1791528168; bh=RR19wngGKMN5kHt+3p/yYi3Mp4a6kIE11rZ+27aXC2U=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=RKcle/WiV3xHClenIUunAmuzWTGA2gBbNToWU76bhVOzEAY2DgZJf1oJzZpamYMCa
	 Jry0EC2FS+TOJ2jUBrMYoGpj2JQXkefnUd8+KgxrUAT3TZvE4QSNFc0CBm8d3sRUPb
	 VBU37juyUIbHzBVFPG1hT5RmR9Vgl2e5N666iM+w=
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
Subject: [PATCH 6.12 4/4] bpf, btf: Enforce destructor kfunc type with CFI
Date: Fri,  9 Oct 2026 09:42:20 +0300
Message-ID: <20261009064220.451530-4-dmantipov@yandex.ru>
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

commit 99fde4d0626176d03cea35c64a063df73816e64d upstream.

Ensure that registered destructor kfuncs have the same type
as btf_dtor_kfunc_t to avoid a kernel panic on systems with
CONFIG_CFI enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/r/20260110082548.113748-10-samitolvanen@google.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 kernel/bpf/btf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5f3b1162208b..b38bdf282991 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8745,6 +8745,13 @@ static int btf_check_dtor_kfuncs(struct btf *btf, const struct btf_id_dtor_kfunc
 		 */
 		if (!t || !btf_type_is_ptr(t))
 			return -EINVAL;
+
+		if (IS_ENABLED(CONFIG_CFI_CLANG)) {
+			/* Ensure the destructor kfunc type matches btf_dtor_kfunc_t */
+			t = btf_type_by_id(btf, t->type);
+			if (!btf_type_is_void(t))
+				return -EINVAL;
+		}
 	}
 	return 0;
 }
-- 
2.56.0

