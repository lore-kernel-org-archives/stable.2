Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B4838C406;
	Mon,  8 Jun 2026 07:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780902697; cv=none; b=IQda4J1vwRLVV5dH7L8ydU+VfMQcD6rlxaxjuJS8ZuFCHsWgroXKY15S5tA4ToEhOP2TgucKPFlx5p9HugrLvIm2r39wcg11OT1kRDauU4IjGPKFXvvxhJ1eLpF49see0S676wUt73lzBIv6p8m/VuTlhejxr85CxTrqXdWfClo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780902697; c=relaxed/simple;
	bh=dlSg88VmdGxXbPR7ZyuEinTyShHdG/AqDdM1y5ib2zU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G9gLyQJWHlXB7+ATe6haUIzw1IkoXQLCFZ3JQ7gvddpDKX/8Wa9oOBtujpoOA70pbvQb5cinDPxZ3e91lSb9WQJAonP1TNS5XpFmzIwaG8GkZluB7wahkxY2q0dnau+7ob6PV9xQSVgs8loIP1egGUST4+Y0ZTVO5jL0u8dy5hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowABXeuEjayZqs7wDFA--.289S2;
	Mon, 08 Jun 2026 15:11:31 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: chris.brandt@renesas.com,
	andi.shyti@kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: riic: fix refcount leak in riic_i2c_resume_noirq()
Date: Mon,  8 Jun 2026 07:11:23 +0000
Message-Id: <20260608071123.128964-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXeuEjayZqs7wDFA--.289S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4rtr1UAw4DXr43Xr17trb_yoW8JFyxpw
	4xKrWSyFyUGr4IqanrAr1FvFyY9ay3trZxCrWDK3s3Za1rXas8Jr4YvFyYgr1kAryDJryY
	yw47taySkF1qyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbLiSJ
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRAMA2omaj4DuwAAs2

When riic_i2c_resume_noirq() is called, it deasserts the reset
using reset_control_deassert(), which for shared resets increments
a reference count. If pm_runtime_force_resume() then fails, the
function returns without calling reset_control_assert() to
decrement the count. This leaves the reset deasserted and the
reference count unbalanced, which can prevent other users of the
shared reset from properly asserting it later.

Fix the leak by calling reset_control_assert() on the error
handling path for a failed pm_runtime_force_resume().

Cc: stable@vger.kernel.org
Fixes: e383f0961422 ("i2c: riic: Move suspend handling to NOIRQ phase")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/i2c/busses/i2c-riic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 9e3595b3623e..6d2ebf67dd62 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -725,8 +725,10 @@ static int riic_i2c_resume_noirq(struct device *dev)
 		return ret;
 
 	ret = pm_runtime_force_resume(dev);
-	if (ret)
+	if (ret) {
+		reset_control_assert(riic->rstc);
 		return ret;
+	}
 
 	ret = riic_init_hw(riic);
 	if (ret) {
-- 
2.34.1

