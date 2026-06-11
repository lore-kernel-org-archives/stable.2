Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3458919CD1D
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781213237; cv=none; b=aTdAMpMAH5kj2X72i9ghu6Kspu0yMP/pf0haEAe/kRlL+J0EEpOgseeyaUncJktYOUKB18eJJtwpaG2KLpn7MaFpoZaA8OMKzK58CH7xoWcPmsd4Wav8J2b5+U6ihwTkYmDlgGvBecTkVFA9j+aQ4pKegHBkVbhHI4x6U1IpNHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781213237; c=relaxed/simple;
	bh=C6j3x5WYRRV6ciwLPPZ8nA7aPINWU6dJHmIiSTjVJHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=joT1uUNIjvQUZqs5WKJTMLjrfdKS4caD3gGRlOfK1Ow63VJVpMgeNjUOzRL7+cYaVlb8SZAgOqjVTlHypyUN9/JTxM491rNqIoQUgzgVo5o3dNSyg7bPLvXaAcVDlZBRg0v7msWkK9tf1ScorvqV2e2vU08FI1LvOUUEkbnsAhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=A8Fl0Gc2; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="A8Fl0Gc2"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5176465a4a4so2723691cf.2
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 14:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1781213235; x=1781818035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2uVyCKJxMa4TJzaUAXJP9RjvhqBIOc1qSJCsvifbc2k=;
        b=A8Fl0Gc2rkMygUOSVpZyDvRwtdDAD4T8fIsjjP5oMeZxHy+W6BfmQ+xKorHOsOLdKJ
         T8dGTYUyItRQGLnMAPcXVTepU5KpsZlusYV9Y1CfCg6XdjM+fyTn8uh8cMXtZyhTikYK
         MAnSxUKifk/uq/r7ea1ic+9p6y9RBci3WQFQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781213235; x=1781818035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uVyCKJxMa4TJzaUAXJP9RjvhqBIOc1qSJCsvifbc2k=;
        b=eGJEp9BXKJcDDxe2rt8NU99l496DeOCDU2VM5W/T6tSeI1oUvCI/h5+kARQuKX+3mG
         hMe1IE+pgm7PPt92AtEj7tq1rVlEOw3zLAqlTH9rSaLwyXN1hdDtRVakoNerJGtV8CJI
         PU+IlffKak1Lhb6I6zXjKAvdE898XSmLNK4zxfok+2cu4cNIbG1eqC/33TnDRmf5Xwo4
         Mrh5lnDk7om8cRYp3Izi2nmqsJb1vCo3JlkGq7rbi0BnnXn/4PglTVgvvgzJ5ysSQedi
         GkQfKQA+cafHxSthvP30zCOZ2No3hAX5O1RSGkUkGP2uWWWaJEINNjt31liENFUaIPey
         T47g==
X-Forwarded-Encrypted: i=1; AFNElJ+Xv2ZF4jYonBXmI1wwnDBM6kRps4p3QjeaDBR4eBRgxwbuBbHstaL7SuVv6QpU69di0sAvM5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfS4xp86M1K/E/tHenQ3nz5I23IW3svD+TyQgocAFKCojRKdem
	+3yb3WbnsXFHMXGLFeEp0Wyu9/R5BfmcTjSc2Q6w9Ca9tN3ZZfUqUstRLzvAsMEYDiE=
X-Gm-Gg: Acq92OEkF/OLZAr+X6LH1ZPVy4Jc6m+GR6MX5jltsdOGzXn9IBTjVwvwCe3xOoSe19+
	P+DzA8STPjXEwdav+s6bytKog732cdpo9Dm6lEzYGBLSeOBqbJJHszs1Ou6Es+PgLA4EKwcULMB
	WOvhbArDFazd0BvpG65RO+U1jtC+55vnQneC+hgxm0/QQ23XckdxwWGE9q/zcQWGv5ff2uKpDxl
	nw9FoSZVTuGsOo6bfmaJqZskcN6WMQ/RvrVKxiS8V0GX2LqzCQZpSf6h89DKVSDQ8OU5OE1krr+
	gS/5pRyP74JfutKoB0+sgzkfl1jPwDLgkmIYPDNnYs5fhtIQuTq6QbIrfL9szMwCf+S3IJbWMsO
	XBZlH+JcQ0SD1KiP0jimh1gqZD6glQquOWAsTCUG9ER+r5G4jRbZJDk4wCENekGAwqfQaohyu+D
	6zOa/2UbP3f8mw+sWfsW5P5t2xbaigOuSbCMOhZSD6AmZWrvAFjGTdjpNBhQ6JyKhCob/thUwr4
	4AEbuiGFJgoX+OT5OdOI0DyK3KpaQ2LL1QjmXppW9lfxQ==
X-Received: by 2002:a05:622a:4a0a:b0:50d:6b06:a453 with SMTP id d75a77b69052e-517ede809c0mr72346601cf.18.1781213235116;
        Thu, 11 Jun 2026 14:27:15 -0700 (PDT)
Received: from com-75606.node.ndb.openai.org ([209.249.37.146])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7ec47asm3717861cf.24.2026.06.11.14.27.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 14:27:14 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-fsdevel@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH] hfsplus: terminate xattr names before listing them
Date: Thu, 11 Jun 2026 14:27:10 -0700
Message-ID: <20260611212710.5134-1-kylebot@openai.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfsplus_uni2asc_xattr_str() returns the converted byte count but does not
append a trailing NUL. hfsplus_listxattr() then passes the reusable
conversion buffer to string helpers such as can_list(), name_len(), and
copy_name().

If a shorter converted xattr name follows a longer one, stale bytes after
the new byte count can make strscpy() fail with -E2BIG. The caller adds
copy_name()'s return value to the running output offset, so a negative
return can move the next write before the listxattr buffer.

Explicitly terminate the converted name at the returned byte count before
treating it as a C string.

Fixes: 127e5f5ae51ef ("hfsplus: rework functionality of getting, setting and deleting of extended attributes")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 fs/hfsplus/xattr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 452a1f9becb2..35fcbc397b62 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -870,6 +870,7 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 			res = -EIO;
 			goto end_listxattr;
 		}
+		strbuf[xattr_name_len] = '\0';
 
 		if (!buffer || !size) {
 			if (can_list(strbuf))
-- 
2.54.0

