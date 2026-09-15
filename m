Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B09385D7A;
	Tue, 15 Sep 2026 04:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789446551; cv=none; b=bAuFbZkVle6xz6hZ463MHwhmNg+djYuuLeP8BVREQ1T82lslee4lOGbGzrb1lyEZ80r3ieIoKMb8Tgvw3J8EM6QZp/7MYKL0Wu8eXkFAWCYlOd2u+R9Jvi0mHueY5uNcbIV8taHn1TayKTYTyX6RaJxXZomg9g03mAE5/Lfl+Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789446551; c=relaxed/simple;
	bh=SK0llSaXl+y4IEThLQKs4U/XbIpBEn8FiruFTrcgba8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ff5XqRf094Ut8A2co+aIKGyB2TuhKRgDcPrBmFgfKMQ/1xOx+LB3Rg5xPAqBJ56L6FPl5FohQ2PKlutjkz+pOfNbWECSs7EX0KWqoKuweo8mtJBEUzdsyskIXPDBYU7HZn2kVcQmKCsI+hEB3iuNjyUN5Bh9qoMqw+uEdO6EEKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowADnvPCKyahqhaAICA--.51498S2;
	Tue, 15 Sep 2026 12:28:58 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andy.tang@nxp.com
Cc: bmasney@redhat.com,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mturquette@baylibre.com,
	oss@buserror.net,
	robh@kernel.org,
	sboyd@kernel.org,
	lkml@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH 2/6] clk: qoriq: Fix clock reference leak in input_clock_by_index()
Date: Tue, 15 Sep 2026 04:28:29 +0000
Message-Id: <20260915042829.1725639-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADnvPCKyahqhaAICA--.51498S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Wry3urWkGw18JF1kZF13Jwb_yoW8GrWfpF
	Z5J34Yvw1UJrs8u3W7tF4UuFnI9w48CFy3K395C3Z7ZF43u34xAF1ruFyYvF4qyrZ3Ww4j
	qF42yF48CF4vyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUKdgAUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAMLA2qowzMZGAAAs0

input_clock_by_index() obtains a consumer clock with of_clk_get() and
hands it to input_clock(), which only uses __clk_get_name() to read the
clock name and then registers a new fixed factor clock.  The consumer
clock itself is discarded without clk_put(), so the reference returned
by of_clk_get() is never released.

Release the reference with clk_put() once input_clock() is done with
the clock, mirroring the pattern used by of_clk_get_parent_name().

Fixes: 80b4ae7acea4 ("clk: qoriq: Separate root input clock for core PLLs on ls1012a")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/clk/clk-qoriq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 2524c5c0eb46..2ed8f93bc861 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -1135,13 +1135,16 @@ static struct clk __init *input_clock_by_name(const char *name,
 
 static struct clk __init *input_clock_by_index(const char *name, int idx)
 {
-	struct clk *clk;
+	struct clk *clk, *ret;
 
 	clk = of_clk_get(clockgen.node, 0);
 	if (IS_ERR(clk))
 		return clk;
 
-	return input_clock(name, clk);
+	ret = input_clock(name, clk);
+	clk_put(clk);
+
+	return ret;
 }
 
 static struct clk * __init create_sysclk(const char *name)
-- 
2.34.1

