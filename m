Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990638;
	b=fY+f5z3PV9bf1s/HApbIwnZgmyJ7QHYFW1zQh8vZLhWZeoCQ5h6BcVYYwAtbpjzNCZ4a
	 RG3bdRfaRhod6c8KHRDQqYy6Axlu6vSEJd8uAzboytppcDcC81QEllNMp+YC5z4001jHQ
	 cOsy7gzmnGuodtE6eN5SHBaDGEFTAUgpeV9WeALEfbP1xBbsBWJuhshYVrv9LKGBqJmdy
	 qlff2yhQgxEeFv+E2EJ8e9LQUqM/ZxAoXYIBc+bN/FlGgPc/IZWp+OyXjo0E29fJlFGDS
	 l+EHIyhxnJvkvXjOM1rJNZgJd3c33+rWd8FKAnOt/b5kMFvqLtBwhkw8Ixm9e4mckRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=V+8S8+cfVySobIuEWLwG5yyplz+yBADfrmzT80ly82k=;
	b=3ltE5G6JOXO9l3qbiVOTiCroEbMAvTnZYQoU8aMGRBLQMNeoa1i4f0PrwVv3b+axKuxw
	 X7hICnmvUafEPxBXpOxunisU6dtOxGKUp05PZ2Dyxukge1PXDScP7uc2w5B82L3lxlUDx
	 p6av/9VDSCMzrMCcHN+fs9Y9wWsGB82WHMtqYk+SXj6sGd2a310pk2VA2pgXFP6XPIWgU
	 NSb3/uivbgKa3quCv9SQdWT5PGNOpHWQKDtFaarCGQ477hfTmYh+0g07ZEwiQdSOkRrrH
	 PKxltXLS929f5CPZj23a5WhlX9h3W1tCXFiwHBJA4VjYiOhD8wHt/YZDDteGU7LYjeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hLUt8Oox;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45C7606D83C
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 18:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C45C7606D83C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hLUt8Oox
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso1588018eec.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 10:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793990632; x=1794595432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V+8S8+cfVySobIuEWLwG5yyplz+yBADfrmzT80ly82k=;
        b=hLUt8Oox1wh+RjoZr4soKfhuHh/efc9x9XCcVBYW0QcvUiwa2YY1pL35ARccV2i0o4
         FwF8RyC6rYr0xQx5cEi756PL0wOLo9s+GrN2Lrc4SnZzQfZ2XzrhfY4UWj5erNGeVZjh
         mW671qX5TKHR5fN1JPk1n9a9b4wSnGvjoFPf2rMdO41BSMjTObGWsd2oTxO1jyr2Foy3
         tBkdUavBMTWrVs/SWnNgADkv2nZPYotHLXnszKEJ5WuaaRQ10FSGBcL8+FdmWSUukYEB
         p4uU8/D1M/frnSvLA057OEh+5whQd94RHg5Yzsi/WJvHh35jl35xkNZm/+w9cg7/OXZt
         xqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990632; x=1794595432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V+8S8+cfVySobIuEWLwG5yyplz+yBADfrmzT80ly82k=;
        b=CrR/S27HNeukOvnB58NBcL3gM2ZkeF8GcykOrXwt7cWGrf5z0582abJqzbpRcpa+bM
         +kHXqGoPQF3jCtizFRJwl3A1ZMsA7AggTD/A0w4wNTmCO7H0JdnY0lV7aFeJ146Y4+vP
         4qlXGEhBzI/cYBqKRpCLRUHSnIdNaZar+dAZW059/heSuLQf1IU+CzUnrcN6Tma66R0A
         X52xXRf3PEJkEvOaKANjAfpXn4s5MTqpETGXbys1x9C6Z7DW1fGTQkqaes0LkOD9QO5d
         lLoxvPlkMd1LjNVITXVosyRt46y/lNuAn7wUH2VQax8XL9e0nDZ9CeaVGaotTWL9rFZm
         OrHg==
X-Forwarded-Encrypted: i=1; AL+hErGpELhMlMrGjJsO8DFGCgjvazWaQUiduWkqmaw8xsSJCpTKd2d3+Kv7NDmm0vOAE/d4pEWDl/M=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8G1+DNoAF1dv1EPBqVTUqiCMTj1/5BkgSj/RCWXk8y/sEdxxg
	TgQdAATXJn/+MuZRyslWmBa+MLcDTwvlNi1IMZj7qsai3bfXo6N8cViU
X-Gm-Gg: AYBFou0AF7fHlPpijD6uj4+z4iI19fTDAQZITGu6ejE0EP5OE04wYlCtKpGEjD+3uYy
	RJpB9V5HoDv1ULvV4x1DQohZpMwm/9E2iM9VvidZIEP/RYKB8tfOV8Jc++AprmRGD4QjRUfHQDi
	83rnsEaCLtR0dmD9IYkA8/h0KjtOpIh8GjOsvUX1BJbJ2WrTRPUi8RrcW5hHRCActnzL7RvChMc
	q9KXQtufxkxMqYDUAQ2i/sv38K7QI/lUsAtYWIFhCVDir5y0rkkJ5ewt7k2lsAWZryi3JYXxd4Q
	2e/mbJNON9TZ+rpeaJI5Cfc+ONICR4YKcVnqBxN27McP0kd0lLn3LIS8QxcCA7QIR91YjhIFwqy
	d77BNZEHR8HWnY/rm3vySuw0qqwMZlQ7R8UnfvwlrHxr1ivZv7uLhUz5hghRWBGjXoyJ9flTehC
	OBVlkvvKdTi4YnOxEw+XYng/RY6Uj9BV0Dbu1eTgYDMXGvda9xiDk8Pje44aBf/BBApd+te49/H
	ZzqqNDeYBMsIgCEFjDJL1uIS8O2qC7vYwqu4gLNjELFDPa85ZiAwYTmq4QtUc5pGo1P8rAe1GnE
	Xfxh866QVKuViBn0U0e2zULww9Ol
X-Received: by 2002:a05:693c:839b:10b0:36c:a42d:9bc9 with SMTP id 5a478bee46e88-36f76023a00mr5131720eec.25.1793990631801;
        Fri, 06 Nov 2026 10:43:51 -0800 (PST)
Received: from JMD ([2405:201:d028:10ff:eceb:5028:6b10:da7c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9aea414sm8278073eec.16.2026.11.06.10.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:43:51 -0800 (PST)
From: Atul Akella <atul.akella@gmail.com>
To: andersson@kernel.org,
	mathieu.poirier@linaro.org,
	sibi.sankar@oss.qualcomm.com,
	quic_srichara@quicinc.com
Cc: linux-remoteproc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Atul Akella <atul.akella@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/4] remoteproc: qcom: Fix bounds check in wcnss_da_to_va()
Date: Sat,  7 Nov 2026 00:13:11 +0530
Message-ID: <20261106184312.100-5-atul.akella@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <20261106184312.100-1-atul.akella@gmail.com>
References: <20261106184312.100-1-atul.akella@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

offset is calculated as da - wcnss->mem_reloc and stored in a
32 bit signed int, while da and wcnss->mem_reloc are both u64.
For a sufficiently small da, the 64bit difference is truncated
into the 32 bit int, bypassing the offset < 0 underflow check
with a small positive value. Additionally, offset + len >
wcnss->mem_size can itself overflow when offset and len are both
large, providing a second bypass.

da and len come from firmware's ELF program headers via
rproc_da_to_va(), and the result is used by the ELF loader
to write firmware segments, so a malformed firmware image can
cause writes outside the carveout.

Rewrite the bounds check entirely in u64 arithmetic. Reject
underflow before computing offset (da < wcnss->mem_reloc).
Replace the addition based overflow check with a
subtraction based one (len > wcnss->mem_size - offset) so no
intermediate sum can wrap.

Fixes: aed361adca9f ("remoteproc: qcom: Introduce WCNSS peripheral image loader")
Cc: stable@vger.kernel.org
Signed-off-by: Atul Akella <atul.akella@gmail.com>
---
 drivers/remoteproc/qcom_wcnss.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
index c856a92af43c..d95530e8be71 100644
--- a/drivers/remoteproc/qcom_wcnss.c
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -321,10 +321,12 @@ static int wcnss_stop(struct rproc *rproc)
 static void *wcnss_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem)
 {
 	struct qcom_wcnss *wcnss = rproc->priv;
-	int offset;
+	u64 offset;
 
+	if (da < wcnss->mem_reloc)
+		return NULL;
 	offset = da - wcnss->mem_reloc;
-	if (offset < 0 || offset + len > wcnss->mem_size)
+	if (offset > wcnss->mem_size || len > wcnss->mem_size - offset)
 		return NULL;
 
 	return (__force void *)wcnss->mem_region + offset;
-- 
2.43.0

