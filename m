Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793837616;
	b=vnykt2PW2TqhLU1X+I5lB2vOf1TBD7AdGkhnrfKHMbwTlABspzB64270k8WF+Ed6hqyw
	 CQsitWzqSJQSt8+AVMKzUyLTxKwDnVkbWTqaP2hnnVIv/IOAoY5dhXyINp7BeDtj0UiHj
	 0ifHwMHM3mxGnrDCLXfrih24SHiacK+1JeSIavQD9fzTF+6pK5l+bGSVFBobStXlR1RJb
	 wq0kkAarDlFtF7oz1udBad08qO4jS2mr9gOLJNvrdbI76vHRkiP6ptQOUos1a6SenPlcI
	 BleuF0OozcdFf2tgi3bGb6i9rXZCTpheE4FiF5rU4zGrrG97RhpfymZ109aBAnEtMrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837616;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=fAbg06ow8H9QMQrvOxRXn8nTU+O0wuTG8Qx02cu++Jk=;
	b=pKHM0kB7LF5HPr0kk4mmCYcy2bydIj1HF9vZ5hMGNr/vwkE4jTDcuyHRQ5trGmmDvHi5
	 MJlncR1x1lgw5Ov4BQT46/CW1jtwGv4hNLk9+NJkX0Gkmbghan75slITqdw2/4esYCzsY
	 RWyUxJuCxt+oxVxoIAhrDnBcA4st4XhStP/mztd41rk20uU9CFC9700MLavFoSqc/DRO0
	 jfT8AlEUaxSHZ/Pfo8rI/Xzv0n552xmQrwxGQvmAXIPfyE7+IJ/ZdkdMeyhLziGXLXjdh
	 23Fq2LuLF0xo1W0IeEOG8Y0vk64wbGYcAWe5NAZ+fah1kHUMVwrjxhtYMlOpDbGXAmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ziyao.cc;
	spf=pass smtp.mailfrom=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=HdAPSFov;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA71606A328;
	Thu,  5 Nov 2026 00:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBA71606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=HdAPSFov
ARC-Seal: i=1; a=rsa-sha256; t=1793837597; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DQ622xsHScW3Ad6bz6fv1d2xPqZQGJ/Dhm/Jc/AFkapPbUBCXsgj/iUJdXQMMk1eKXTMFbNS7Iai9ungUwuWB0KmGK+npgwQNdTTVrtqJC1cjh+qL90OFys6JhYCri0DY8kkt691dZ2ROsCOLuJqh2RajL2i8PGpZUSnF2g78j4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793837597; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fAbg06ow8H9QMQrvOxRXn8nTU+O0wuTG8Qx02cu++Jk=; 
	b=nOpJnWVMboje3xbWS3M5AHr1Wl698euBo1vIPQq/aHlsoJ1ajMMPZILp4S/yVrVRVAWQPCa2Bdyvgu0caA3MRpygUFXXnAMXegeTeGdCYVl+HoRlb/iajt/LnBahi0ix3DNSrC4jkQu43zXzwmPEjHNezWNmJPziglMDWRPGJjQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256; b=HdAPSFovFwWtdTHK9ZmbCLVhAWpZPO0UWDZDjv2cWXNfcniGfG9oIixlWS6MgBRlUwPbvqR/HBUPfXzg4FT9OYynKNw7Ryyw7ivutwYO7jFMND8c1W/0z/rdhBVoyBLpA7H+F+EftEOn6QJEYM/0G98h6QE6TEhy0qZPI8X+kLM=; c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1; bh=fAbg06ow8H9QMQrvOxRXn8nTU+O0wuTG8Qx02cu++Jk=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793837597451328.75738105930157;
	Wed, 4 Nov 2026 16:13:17 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Ulf Hansson <ulfh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Yao Zi <me@ziyao.cc>,
	Sergey Shtylyov <s.shtylyov@auroraos.dev>,
	Midgy BALON <midgy971@gmail.com>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Frank Zhang <rmxpzlb@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Kevin Hilman <khilman@linaro.org>,
	Caesar Wang <wxt@rock-chips.com>,
	Elaine Zhang <zhangqing@rock-chips.com>
Cc: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] pmdomain: rockchip: Don't log when of_clk_get() fails with -EPROBE_DEFER
Date: Thu,  5 Nov 2026 00:12:57 +0000
Message-ID: <20261105001257.1368266-3-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105001257.1368266-1-me@ziyao.cc>
References: <20261105001257.1368266-1-me@ziyao.cc>
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
X-ZohoMailClient: External

Current error handling code considers -EPROBE_DEFER as hard errors,
logs misleading dmesg like,

rockchip-pm-domain ff600000.power-management:power-controller: power-domain: failed to get clk at index 0: -517
rockchip-pm-domain ff600000.power-management:power-controller: failed to handle node power-domain: -517

Use dev_err_probe() at the callsite of of_clk_get(), and check for
-EPROBE_DEFER in places where its return value could propagate to.

Fixes: 7c696693a4f5 ("soc: rockchip: power-domain: Add power domain driver")
Fixes: 6be05b5ec161 ("soc: rockchip: power-domain: add support for sub-power domains")
Signed-off-by: Yao Zi <me@ziyao.cc>
Cc: stable@vger.kernel.org
---
 drivers/pmdomain/rockchip/pm-domains.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 34c862e56aad..c147cc88edb1 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -851,9 +851,9 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 		pd->clks[i].clk = of_clk_get(node, i);
 		if (IS_ERR(pd->clks[i].clk)) {
 			error = PTR_ERR(pd->clks[i].clk);
-			dev_err(pmu->dev,
-				"%pOFn: failed to get clk at index %d: %d\n",
-				node, i, error);
+			dev_err_probe(pmu->dev, error,
+				      "%pOFn: failed to get clk at index %d: %d\n",
+				      node, i, error);
 			goto err_put_clocks;
 		}
 	}
@@ -1006,8 +1006,10 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
 
 		error = rockchip_pm_add_one_domain(pmu, np);
 		if (error) {
-			dev_err(pmu->dev, "failed to handle node %pOFn: %d\n",
-				np, error);
+			if (error != -EPROBE_DEFER)
+				dev_err(pmu->dev,
+					"failed to handle node %pOFn: %d\n",
+					np, error);
 			return error;
 		}
 
@@ -1102,15 +1104,17 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 	for_each_available_child_of_node_scoped(np, node) {
 		error = rockchip_pm_add_one_domain(pmu, node);
 		if (error) {
-			dev_err(dev, "failed to handle node %pOFn: %d\n",
-				node, error);
+			if (error != -EPROBE_DEFER)
+				dev_err(dev, "failed to handle node %pOFn: %d\n",
+					node, error);
 			goto err_out;
 		}
 
 		error = rockchip_pm_add_subdomain(pmu, node);
 		if (error < 0) {
-			dev_err(dev, "failed to handle subdomain node %pOFn: %d\n",
-				node, error);
+			if (error != -EPROBE_DEFER)
+				dev_err(dev, "failed to handle subdomain node %pOFn: %d\n",
+					node, error);
 			goto err_out;
 		}
 	}
-- 
2.56.0

