Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793837616;
	b=g/Xv78E77jTiT0zXrCiQf06K9RPXdfJg/+fOE+hP44GXFIeEbQmmXuEcYueKfWHdRCzo
	 Ka4h9dVAuH0s7JlPMTVNYK4OMHRRpAxrJ+nnA0DbQeBC1UxymYKgt+sqwk6pe7cniWUnW
	 w8UUwBIIBumLml3Ew7aLOOggS6x9lM7A2leooRHqvsZHhLnE90P3773QV2dB3aiV7/MgX
	 Bj569o6DjnptL/HELve5jaeRLCbkuqO8hbzBONk8D9z/B7AYCVM9gZ4NYr0Ik28FZDk1B
	 XDiE//41NIXNrltNXWK8tJkVVdX+t/yzaoKbQMOpPcxmw5VdAf3GtK8+zNE8QgrSrTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837616;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=5MfiJva0/xirl8FRrP4VnTwbPtQthSWfsgrznic1PW4=;
	b=F+TJXlVngMnz7WFBelqBGY7VpFBlTA7iPVzmWelYvjujjKMLFH4Ajf2VWXZL1s6NaylC
	 /R/TrKLfxjmzTcTB12CpOZDbBmbbIMrmcZ3ScSyvjHtUo5Pu4Wj/7mYpwGfoqFQHxd/je
	 0ok7XBI/3dSkd62HHlmsUA4lfKJyNlcWdsBKA7fWY6oncvD0qDH5YEPnl1Dz3yiMHpzfE
	 odlmH0HY4nzI0oO+avdigXxb+iak3RuZvcQFS3gNeGsLGq8ti5UNq421hFF6S3AXCl8Tt
	 jdWvMzcYVY43c2Ol7vTcjFPFl94PTBcXhrWaofMYZfZ/WQyfO62oP1aAQF6dP+msLSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ziyao.cc;
	spf=pass smtp.mailfrom=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=J2+gircp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57891606A330;
	Thu,  5 Nov 2026 00:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57891606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=J2+gircp
ARC-Seal: i=1; a=rsa-sha256; t=1793837593; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gurDVg4V4MKsadFymtJ57Ev0pnXMQXXNYW3ANli0W75NRY0HMaFa+B0Tce6NIRxkADIywP6u0jU3jOHxq64oLbSCx74XtQISw6uj5CBsQYDMuW/sHPZfy60ALsCMcQ6FGoviUoOn0l7CuRVFjmzOhCMcHwnn4Z8o1UZizyVZkhw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793837593; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5MfiJva0/xirl8FRrP4VnTwbPtQthSWfsgrznic1PW4=; 
	b=bGioRSTdTZM3j0432MVEZg5FG4EdpwsbU5/LfQFRttnbi6iUCFB8J01JfyTqj9ZAw86/sdQNPj/naxIzABJ76A8zV9pzFJnrQg2OdICJNcuUEh4u6QZZPKJfcivpp6tHykP9hB3fNswAocSSVCUJ9LGRmfQTzwcxmggRhHlNiiA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256; b=J2+gircpt3PgzMMd50ML7WYpzET1fGn0/kg5xEPmDZVzL0iMwjgcT7mCk8BmIEgLRC/8yBhWeWvkTp9QaN0ahS+T3uD4h3N6jYFmuS3k2Y5W22QIZj063MErbB3Aj6OKoZufxBMCyKzF9ifPZwzn8M95+HT3bnQg0+We41LcKSs=; c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1; bh=5MfiJva0/xirl8FRrP4VnTwbPtQthSWfsgrznic1PW4=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793837593399851.6803336597001;
	Wed, 4 Nov 2026 16:13:13 -0800 (PST)
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
Subject: [PATCH 1/2] pmdomain: rockchip: Only put clocks that have been successfully obtained
Date: Thu,  5 Nov 2026 00:12:56 +0000
Message-ID: <20261105001257.1368266-2-me@ziyao.cc>
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

Since pd->num_clks represents the number of clocks described in
devicetree, invoking clk_bulk_put() with it will put invalid pointers
when some clocks cannot be obtained, triggering a warning in CCF like,

  WARNING: drivers/clk/clk.c:4844 at __clk_put+0xf8/0x12c, CPU#0: swapper/0/1
  Call trace:
    __clk_put+0xf8/0x12c (P)
    clk_put+0x10/0x20
    clk_bulk_put+0x38/0x60
    rockchip_pm_add_one_domain+0x2b0/0x468
    rockchip_pm_domain_probe+0xd4/0x2f0
    platform_probe+0x80/0xac
    ...

Invoke clk_bulk_put() with the counter used in the loop of obtaining
clocks instead.

Fixes: d8b384777066 ("pmdomain: rockchip: fix clock leak on domain probe failure")
Signed-off-by: Yao Zi <me@ziyao.cc>
Cc: stable@vger.kernel.org
---
 drivers/pmdomain/rockchip/pm-domains.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index db3879846db6..34c862e56aad 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -931,7 +931,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 err_unprepare_clocks:
 	clk_bulk_unprepare(pd->num_clks, pd->clks);
 err_put_clocks:
-	clk_bulk_put(pd->num_clks, pd->clks);
+	clk_bulk_put(i, pd->clks);
 	return error;
 }
 
-- 
2.56.0

