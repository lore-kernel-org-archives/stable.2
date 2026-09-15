Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2CB364EB1;
	Tue, 15 Sep 2026 04:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789448269; cv=none; b=m2vjMW35RpfqHpjFfX4SvKxQZd5Y3R+mW+ufmQkQ62c38midBYiTt6/PZwxwT4uhUkGI4wtZjKsrNRK5Il/mDrGY/0EWKSzHpPfpR71M0cR+e2uJogUwsjvMaVTKxYokl/SoLDvt8wYynPyfoeRLTR/2L9kHaQJse4sOwNzpH+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789448269; c=relaxed/simple;
	bh=8SCC/yGz3PcfnYOnjzeYk8pr2piwP7O4yZ3ggGmAGz4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YhEH1Sp9S5v+f3/3sQt+MUrQrlcG0QNEfIO059ficYPDl8ZcBUTvDi64X78U5nPe0xS2Ena7P1jm61VHF9egNbnIzb5JRXzFVA0aj+eWR6Hsxe6jMFtn3VRP+DZAzEhqJpnXHR4rmNQ7xq1P6exvImfz32J2ZT8DoRVcKbZchdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAB3TvJI0KhqPjkJCA--.50195S2;
	Tue, 15 Sep 2026 12:57:44 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: daniel.lezcano@kernel.org
Cc: linux-kernel@vger.kernel.org,
	tglx@kernel.org,
	lkml@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] clocksource/drivers/integrator-ap: Fix clk reference leak in error paths
Date: Tue, 15 Sep 2026 04:57:15 +0000
Message-Id: <20260915045715.1726935-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAB3TvJI0KhqPjkJCA--.50195S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrykZw17Jry8AF1xAry7ZFb_yoW8Wr4fpr
	4UKayYkF15XFWI9r1vyF1DAryakw48CFW5G345Ka4v9rsxJryxXFZrAa42vF4UCr1vyw1f
	tr1FyF4rCFyDZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUg4S
	rUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwALA2qowpAw-gAAsR

integrator_ap_timer_init_of() obtains the timer clock with of_clk_get()
and enables it, but the of_property_read_string() failure paths for the
"arm,timer-primary" and "arm,timer-secondary" aliases return without
releasing the clock, leaking both the enable/prepare state and the
reference itself.

Disable and put the clock before returning on both failure paths. The
paths that hand the timer over to the clocksource or clockevent code
keep the clock enabled for the lifetime of the timer and are left
untouched.

Fixes: 76804d052316 ("clocksource/drivers/integrator-ap: Convert init function to return error")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/clocksource/timer-integrator-ap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clocksource/timer-integrator-ap.c b/drivers/clocksource/timer-integrator-ap.c
index a4c700b11dc0..a4cd0d79dd29 100644
--- a/drivers/clocksource/timer-integrator-ap.c
+++ b/drivers/clocksource/timer-integrator-ap.c
@@ -182,6 +182,8 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
 				"arm,timer-primary", &path);
 	if (err) {
 		pr_warn("Failed to read property\n");
+		clk_disable_unprepare(clk);
+		clk_put(clk);
 		return err;
 	}
 
@@ -202,6 +204,8 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
 				"arm,timer-secondary", &path);
 	if (err) {
 		pr_warn("Failed to read property\n");
+		clk_disable_unprepare(clk);
+		clk_put(clk);
 		return err;
 	}
 
-- 
2.34.1

