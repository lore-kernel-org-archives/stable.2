Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CB541A547
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581697; cv=none; b=kpbNL2AfwXeYyb9QYHU1LPCgOxPkpzb0jbyEo1U/a/t7yV3yCU5Z5bQ8FWhqWH8nVvcIaS8FVnaQvRQ1+te0ydJgKYpDX+m74Wq9ycxuf2khwh7PUE3sBUIjlMyLXqfdNV9AIy3LHteCRmJtkNur6XHwEP40kedBhRa7pnCNcdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581697; c=relaxed/simple;
	bh=CyvFyzFd1gbYPxjEkZ4TAXB+esuJNZ3LdYISRv/gmHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESx8aH1d4eEzlAPz1d5L1XUs7o1kOBjTDAS4j6xgdiZnGE2DdYdFezGCVeiTyuB50q/aBo78Kq79mf92WCSErpMffPb2KTWxY7A37qvAmspldFONY5j9Vh2vWEbeT3iIIHbb1Yxs8a7f1CYafjw16wNgcFZ4O4UR/sB7ZrC2e5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdFvtps3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdFvtps3"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cca0c5799eso30786885ad.0
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 07:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787581696; x=1788186496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CZRV0fsadUb2RGyF330MZobT+Dwgs5Uikgpa9gJZ9qc=;
        b=FdFvtps3vBp2OgEHODb2betFLZ8dXjAuqcCsDFp5DaHX5argoBXrLtlCk85VJ8HZaI
         RNyUxhlN/UMPIo1W1Gk6wS0AABoukTA1dvIJSZQI17BfEPEveZGinTyBov0i0ahnF/XK
         OpUNCdFVcB5rUKrFzhVQc2dBa+B/PwDFCsggOR06SyqUtwSx1St1AgnoXXRefxJ3nqzP
         GKYhryA7iDO4jaQaMJTerIobdcsyLFiLcJHM1kjS1bLHenWB153YXCvRZsznkrDAU3jc
         +NOXyKk4fuE2b5EXKdGhsV+318yUrIMS2CnnOxbXzsR5FQTjgtmDNvL9XE4gW5Fr0tEc
         zfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787581696; x=1788186496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CZRV0fsadUb2RGyF330MZobT+Dwgs5Uikgpa9gJZ9qc=;
        b=I7ORPA2kBiCkod6kxJz9UoYKhxChShOhTNCOM5frCN6ZjEkTmwAMWg48TCXLdpUwbt
         X5g35ZiSK1VhOcO3Po8Uj1HXi9WvU5/lN2D9ka5ildocS9mivR3dsKPSlXHKczyiUpa1
         vNbBqwRsOt4zNrrmF8G29ryLkf4MWjrb/OAODRh4th5K8GAc7FSn1Zpnn6qRvosnjTV+
         sO0RVDchyee3c006cXRCasM6AELTkLFmFqzuZpgEemscGxQqiOxaYYVbSGgUXOAw40pq
         2o0JyRO6+dCowxbh4fBj7QjdKK958uAIcBvelQDH9wx3VSbJw4B0gWAJLaFb0vi5rCaU
         rKpw==
X-Forwarded-Encrypted: i=1; AHgh+Roxd0VG21upSFMh49U/hoDKauxXgGfjE9uZ53BtVnpyCdVMF3BGELVysaoPt3ojgs3JlM6OcUQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nXeMe5cC/IyHgaXqxmNMoVajRila3pBxLvkMhSIpzMJcbpUmfv
	jDxDWFcaVx/WRrztoDcBZwAvResvEOBNX2xWonfSqW0x8ZdixN8vu/B2
X-Gm-Gg: AR+sD11Rolvmr6i0KZaCWwQFoGIelq5GTLmfKx5mccxEbhlPJDz/1HrkBIBXQc+PAfX
	IInfkLCjW0TvihLCcncPEKPDITHc+P5KaLE1YVzw4yxxOqH5CWfv4dkQKdI81O5ASFxJeFsX5Mm
	TUBy/chselOgCvXa7giSoatmnCtpFMAY17lH3S0/G26JvSVE6ysFlZcdYlCKnIOZRZCQvNyMNZa
	jvFHoKUpiw/fnx9x1Vsw6S6ABZFb3MLLscUr3+6FvxUp8oN+gMAqKRcw/f1dc8uVyNZZZkMvrKG
	5dqN8YwF/jPyiugsXMEHh7nKm38WjLkx7PkDBqEAozsn3G3c8ZTi7yLRh8HUiWJixI0RHjqVrLU
	HCNntSFa8jkl4r8Tw1ibWR7UfeoJtr60FSk8o9R7ZS+bf2c4qlG8FWFfDwYQDBGUDGzRhsSPMtc
	ls/WJOoxPc8IQAZKYsvJqqx8Ai+DBkjgkGAReKX9mIWAvkXqDI8mmDpg1bDaMO9AejCZ3HkN+lm
	+ZU8i9u/HGO9oLtq06FriwRTqOypf3DK0uXrlc5rWX63l8TrG52
X-Received: by 2002:a17:90b:224f:b0:381:1f51:1ff0 with SMTP id 98e67ed59e1d1-395c354d445mr44970306a91.2.1787581695499;
        Mon, 24 Aug 2026 07:28:15 -0700 (PDT)
Received: from hanzj-mi.. (ec2-99-79-140-187.ca-central-1.compute.amazonaws.com. [99.79.140.187])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4a1597csm10201997a91.13.2026.08.24.07.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:28:15 -0700 (PDT)
From: hanzhijian <hanzhijian1991@gmail.com>
To: Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Brian Masney <bmasney@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hanzhijian <hanzhijian1991@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] clk: mstar: msc313-mpll: fix off-by-one in clock array allocation
Date: Mon, 24 Aug 2026 22:28:00 +0800
Message-ID: <20260824142800.3497263-1-hanzhijian1991@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <67ec3261-9f3d-4dcc-b916-19dc8be56a6e@web.de>
References: <67ec3261-9f3d-4dcc-b916-19dc8be56a6e@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hws array of mpll->clk_data is allocated with struct_size() using
ARRAY_SIZE(output_dividers) as the element count, giving it 7 elements.
But the probe function stores the MPLL clock at hws[0] and one
fixed-factor clock for each output divider at hws[i + 1] for i in
[0, ARRAY_SIZE(output_dividers)), writing 8 elements in total.  The
final write to hws[7] is past the end of the allocation.

clk_data->num is also set to NUMOUTPUTS (8), so the clock framework
reads hws[0..7], again accessing hws[7] out of bounds.

Use NUMOUTPUTS as the element count so the allocation matches the
number of clocks actually stored and exposed.

Found by smatch:
  drivers/clk/mstar/clk-msc313-mpll.c:134 msc313_mpll_probe()
  error: buffer overflow 'mpll->clk_data->hws' 7 <= 7

Fixes: bef7a78da716 ("clk: mstar: MStar/SigmaStar MPLL driver")
Cc: stable@vger.kernel.org
Signed-off-by: hanzhijian <hanzhijian1991@gmail.com>
---
v2: add Fixes: and Cc: stable tags

 drivers/clk/mstar/clk-msc313-mpll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mstar/clk-msc313-mpll.c b/drivers/clk/mstar/clk-msc313-mpll.c
index 61beb4e87..bd45aa0ae 100644
--- a/drivers/clk/mstar/clk-msc313-mpll.c
+++ b/drivers/clk/mstar/clk-msc313-mpll.c
@@ -105,7 +105,7 @@ static int msc313_mpll_probe(struct platform_device *pdev)
 		return PTR_ERR(mpll->loop_div_second);
 
 	mpll->clk_data = devm_kzalloc(dev, struct_size(mpll->clk_data, hws,
-			ARRAY_SIZE(output_dividers)), GFP_KERNEL);
+				NUMOUTPUTS), GFP_KERNEL);
 	if (!mpll->clk_data)
 		return -ENOMEM;
 
-- 
2.43.0

