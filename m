Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44D04D7948;
	Thu, 17 Sep 2026 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644898; cv=none; b=ZC9LIUVX94Wf0N/AkcgDTh7TyLY/gIn8Z9PrtV//u+idhk6UlSfXLC/7b8aIGiheIPJRVwRgciUGU6oPMwMBc/foj2CdBupWh8gWUEyYkyBjbr2vdkDOJi7v2A02wU2fhoVQooe6vjyNhaVpTvFfFCWQc7h/kFW+y5lh+yq+vfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644898; c=relaxed/simple;
	bh=33MfYXKTSmQZVl6Ni4FMmPcTZk6Tf10K4v8CMJve8d8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gTPYDtiziZ4tK4OArFuuEoku1RmPKXvoyFOcMPRVbivvctR77gZ6bayWDNJXq0CgsToOuAo5Tj/xSQX71UqBi3ReI/mQTxJE2CQg9FDvudvfzkz1WmTcr/Yq0dJx89c76YmUnhrz/3WP50mrOGbmElEma34lAp83yFjvzGPP7Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAC3HzpU0KtqgKl_CA--.1856S2;
	Thu, 17 Sep 2026 19:34:44 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: UNGLinuxDriver@microchip.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	vladimir.oltean@nxp.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: mscc: ocelot: Fix mirror reference leak on VCAP aux resource error
Date: Thu, 17 Sep 2026 11:34:44 +0000
Message-Id: <20260917113444.2149183-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3HzpU0KtqgKl_CA--.1856S2
X-Coremail-Antispam: 1UD129KBjvJXoWrtF48AF4fWF17Xw15Kw4fuFg_yoW8JF1fpw
	47Ka9rCryUXF4rGw1DZr40va90g342grZ09Fy0yws3Z345J3s8G3W7tFWjqr1kCFWjkrna
	vr4qyw4UA3Z8Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0E0s8F02x267IIx4CEVc8vx2IErcIFxwAC
	I402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrw
	CF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuY
	vjxU775rDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAINA2qrrJpv4gAAs6

When ocelot_vcap_policer_add() fails, the aux resource setup returns
without releasing the mirror reference taken earlier by
ocelot_mirror_get(). The caller drops the filter without calling
ocelot_vcap_filter_del_aux_resources(), so the reference is leaked.

Release the mirror reference before returning the error.

Fixes: c3d427eac90f ("net: mscc: ocelot: establish functions for handling VCAP aux resources")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/mscc/ocelot_vcap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_vcap.c b/drivers/net/ethernet/mscc/ocelot_vcap.c
index 25e533e91d71..c479af2a423f 100644
--- a/drivers/net/ethernet/mscc/ocelot_vcap.c
+++ b/drivers/net/ethernet/mscc/ocelot_vcap.c
@@ -970,8 +970,11 @@ ocelot_vcap_filter_add_aux_resources(struct ocelot *ocelot,
 	if (filter->block_id == VCAP_IS2 && filter->action.police_ena) {
 		ret = ocelot_vcap_policer_add(ocelot, filter->action.pol_ix,
 					      &filter->action.pol);
-		if (ret)
+		if (ret) {
+			if (filter->action.mirror_ena)
+				ocelot_mirror_put(ocelot);
 			return ret;
+		}
 	}
 
 	return 0;
-- 
2.34.1

