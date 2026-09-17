Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DE54F4725;
	Thu, 17 Sep 2026 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650506; cv=none; b=IE0R7vCYdLgmrLmfpvNhy9a7NMzvIv1HU1nHjZPfrGWCNwt0c2uXT9D+y46irczmHT80d0pLCZU6xpQ9y82Xvfah2I+xgLjEPck7S1915/NaQeQephXJ50GCyrUk4XTjrpwlwoD5hJPFGKi8nvy+vMhca92H0WmH9TBcm7xx+k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650506; c=relaxed/simple;
	bh=NqzNgsDSPkthvw7ErPB/aEJ8PevOQbn1gOg40xcgy7E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bxRcAeCiSuCtjg+/5n8IEmIWmDp5PCv9+O13lbQyuRmPJCT1uWDY84eO0I29l04blf4hKDk8+oqArM5JkVjBTThJlebLqfrPArIsX3+UKxlNwAK0nwxVcZD3puwA0dzDsuNHznH7OtuzrqzickNy8Ll/6VAKzCji8G2Qc3dehXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADHMTw65qtqMiGBCA--.3314S2;
	Thu, 17 Sep 2026 21:08:11 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: devicetree@vger.kernel.org
Cc: joe@perches.com,
	linux-kernel@vger.kernel.org,
	pantelis.antoniou@konsulko.com,
	robh@kernel.org,
	saravanak@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] of: unittest: Fix np reference leak in of_unittest_printf()
Date: Thu, 17 Sep 2026 13:08:10 +0000
Message-Id: <20260917130810.2152851-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADHMTw65qtqMiGBCA--.3314S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JryftryrXw4UZw45Cr1rJFb_yoWfWrXEkF
	92vr97GrW8CF1q9Fn3Zr1fZFZFv3W8WrW8ZwnFy3sxCrWjvF1UXrn09rn5Jw15Z3ySkF9r
	tr1DGw1vyrsrZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbqxYjsxI4VWDJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq62Iq12xI8VA0II8E6IAqYI8I648v4I1lc7Cj
	xVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr
	1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr
	0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZEXa7IU1mL
	vtUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgMNA2qrq3a6NwAAsa

of_find_node_by_path() returns a node with an elevated reference count,
but the function returns without ever dropping it. Add the missing
of_node_put() so the reference is not leaked.

Fixes: ce4fecf1fe15 ("vsprintf: Add %p extension "%pOF" for device tree")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/of/unittest.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index e6e938bcb100..340e23725d7a 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -354,6 +354,8 @@ static void __init of_unittest_printf(void)
 	of_unittest_printf_one(np, "%pOFc", "test-sub-device");
 	of_unittest_printf_one(np, "%pOFC",
 			"\"test-sub-device\",\"test-compat2\",\"test-compat3\"");
+
+	of_node_put(np);
 }
 
 struct node_hash {
-- 
2.34.1

