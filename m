Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [51.250.60.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75C14973B1
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 09:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.60.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403614; cv=none; b=NXur/ss/KsjDtq5+Z62YTTuKlp1eYWR+9NdjPWPTrFb/jiOkXKCjGYAHqEEGiuxdA6Ly8RP3GE7a07DHXHybJ8ZcqIXN4KCLS1p7iemDUAQi5Hlg4cCV0GLf9yA/UUCcJumF79rAeL/sqSFQG4kHxpimOYi8c1vdBi9KcV3A34c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403614; c=relaxed/simple;
	bh=NPcQU+TdPSBNuzZThbg37HnIF8ciK9VfGaEgERRfzAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3GKQV8m4R3LnwQ5gHQskNVsqLiRNnuMhG8xZ2cbzyL2ibc5ui0UP8tEzLCtjqVZ3PmkvWPxaTPP5GJ6EbY1FyZg81EllJSekKTjCo2UJymyZdbFCFO6tWjvuAFZhZzu6iiKScF708UpISjHtG3pz0hKfrC6LOrJEdWYGuQnrIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=kmXJ9ezc; arc=none smtp.client-ip=51.250.60.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="kmXJ9ezc"
Received: from forward102e.mail.yandex.net (forward102e.mail.yandex.net [IPv6:2a02:6b8:c32:0:1:45:d181:d102])
	by forward102d.mail.yandex.net (postfix) with ESMTPS id B049AC01A4
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 12:53:30 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-36.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.yp-c.yandex.net)
	by forward102e.mail.yandex.net (postfix) with ESMTPS id 44E27800C5;
	Mon, 19 Oct 2026 12:53:13 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36 with ESMTPSA id 5rV6YbUhriE0-bqi6QGYs;
	Mon, 19 Oct 2026 12:53:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1792403592; bh=RR19wngGKMN5kHt+3p/yYi3Mp4a6kIE11rZ+27aXC2U=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=kmXJ9ezcbKQgWdtd8kexdZHPWA7yAuZUMaZpH6twlak2FKVdNfAcmvBsMrgIJfW10
	 oIpvCl2c5rZ9RfvS6oJMVYqtZ8PAslmWX+5Jt3QrNQqOTOSqcxMvFsGOCQquEbsgFz
	 jmB6UyZGipzfEDwYwbw6jn1aQs2K5wPDCFLox/Do=
Authentication-Results: mail-nwsmtp-smtp-production-main-36; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lvc-project@linuxtesting.org,
	Sami Tolvanen <samitolvanen@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 6.12 v2 5/5] bpf, btf: Enforce destructor kfunc type with CFI
Date: Mon, 19 Oct 2026 12:52:39 +0300
Message-ID: <20261019095239.221813-6-dmantipov@yandex.ru>
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

