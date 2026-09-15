Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3193A382F
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789481768; cv=none; b=ZZxHbYZUc3Vdn/xFblaszliouyIwHC22fLZRN2TZr5WBK90T6RUza5OhTYOZ56yDzDyZKWEiH6ReU281Uo1hfkwAF7tWN0NAgo2qsTGSC0YHuhHZEpwx3rSOuFeqvMgqJNZXjB02rB1CP2sG2QpY8uXgJOwFe5mNv62W8MuM/YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789481768; c=relaxed/simple;
	bh=fZFg/j3pb6twOqqBfqfH5ANDxZSW/qTsavhnzB5RzzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLl+wWVvhYInkl5ay3f3CkYGyfs1swNRNrpYEXJr+stIqYUifD5p6YFTaFckrVKzMhwwgveA58u7TGoJ5bkGwHTlDUMevEwXb/E663Zt0ghaJatWMLg+UNzonkEH7KhHzRyNYEUvQMZfsKYoZEdTgyarfJ7vvExzPOUogyk/Nbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U24A1ncC; arc=none smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U24A1ncC"
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c98e1942dfso540078e0c.3
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 07:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789481765; x=1790086565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8fJS//1ZgrWfO+Hpg+mD2bvTEqYipgvOVKK1VwTdF1g=;
        b=U24A1ncCjpfO8XOmtRMh28g2L+lTBAGTlv+QcNj9KFJk68ZIU0Y/Fq0ndUKjPkqNnm
         1UL0n7benzscYi2KCnQUNbKOptZVb8LXamMrh7fRL1XSUj2ACM0XOaMSe9BXhcx/G3ZE
         EaXjDGm0Z1wn1xQXtRdFBfy7xVcL8VzqCeS88vKhwoEhIHy2mL1Btxn0GttZrpsWZopF
         pj17+4hzLKQWnktNdO7gKm3USS/+ALSjOKOjGFqKZ84XKJQfJfXSKvQAQlWAReZ/XZ0w
         GhFx7GYSA+quru3czgBrLrxMsPEeeMHiWFTncYDa8m3j25X0sogZ1PPrjEc5M9Gh+0dB
         2AnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789481765; x=1790086565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8fJS//1ZgrWfO+Hpg+mD2bvTEqYipgvOVKK1VwTdF1g=;
        b=AbdYisZEx3ZEYHpjF0V7gH9U1jk3muDN9KecKLQEw0WKRGhVnQT+iek4isUpoiLB0l
         kmZBeiT51nUwNsxIUpKKyNBI5hxAF97yxAJAROWRSf+O2weMkvOBxDuQtDdUmX1Q1a0Z
         cAboo87BfK88MkdVKPyO/cpeaHy/SP7HlQfC6u0F66hbS07xaxkb2/FT/XNDyIR9dHth
         S4Ljs8aMn6fj8IJe+YSY9R3zZ1sZdByPQ7WsU+rJEiJM1pJX4P9DzGozu505uuv7BmFh
         Evgi53WK09CSrlX9Z84QWRFUdUimwtE++lLKEwg6y0Tf3+P2bdLVpmzpyX05jSOeaqgz
         ZmwQ==
X-Forwarded-Encrypted: i=1; AKwUvBzf4chNrAQD3HhA+qU4k7tL/xwpIm3hZgcQQ5Z/Iaddd4SXeM3xyiWeGwSfFfM4XWpP3hOkWa8=@vger.kernel.org
X-Gm-Message-State: AFuF++k3qTCWwtvU3mCvmuAJMp3kNDhdA5HCXvGEAUyuPt8phAV9A3RX
	N7sDD7PxoUjnfLJbUOAwB74Y+oEJZiMOj4U/f3uWnhPZlnaiqxi4p5R0
X-Gm-Gg: AYBFou1wI1neCpPzo42nVDWciP4UpNulR3LgZxQdyf946NNabyX65ZJOAeLXxbIoHP5
	BuQQYZkPdTTQz6mugH4YjWXUxLAB1Kpg+zj58aq7rTPHxA4rgNzH3bu8kjeNV0eA2WmfQ8qoVBh
	3oj/9hG5kK87yQJjpGPeV0ViZXjwDQRWidTpltprwm84jaaNzR22AQnhyFg2QMxhC/+KyodS8X7
	ISRfR9uk1uD5hHoYBR/SqD7jb88aTKvsTlLIZMxihTE0A3PYTa1PCD8G9ZCFDNXoVLg1NPOIJjq
	o8s8tYAe0+faKOrWf8v3vHWWIet6KQnZ7jTxjov26dtnnF5cVuNcvkM9VZudJ2QHDfk12YIvs19
	zsjs9OXLlK1IcJAo6a1V3tAIDlGuDPxBIg0n27FV4PaUoIIoazia3kEsQkRff4phl1L+UH/9CBU
	G3Zl03fME2gz85/YzhU1Tav+C3Daid+/dca6PD4FMtHC8zJXjqrMStMRQo7i8mgYlJ
X-Received: by 2002:a05:6122:2056:b0:5c9:82a1:a6a3 with SMTP id 71dfb90a1353d-5c982a1ad55mr8136390e0c.6.1789481764710;
        Tue, 15 Sep 2026 07:16:04 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c84716a167sm16029131e0c.18.2026.09.15.07.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 07:16:04 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v2] vsock: ignore empty child namespace mode writes
Date: Tue, 15 Sep 2026 11:15:47 -0300
Message-ID: <20260915141547.3010692-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915111417.2726515-1-qwe.aldo@gmail.com>
References: <20260915111417.2726515-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__vsock_net_mode_string() returns success without updating new_mode when
the transfer length is zero. Its caller then reads the uninitialized enum
and may permanently store a stack-derived value in the write-once child
mode.

Return before inspecting or storing new_mode when no bytes were
transferred. This also prevents an empty write from locking the current
mode.

Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 net/vmw_vsock/af_vsock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 622dbd0467..816d25b314 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2883,6 +2883,8 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
 				      vsock_net_child_mode(net), &new_mode);
 	if (ret)
 		return ret;
+	if (!*lenp)
+		return 0;
 
 	if (write) {
 		/* Prevent a "local" namespace from escalating to "global",
-- 
2.43.0

