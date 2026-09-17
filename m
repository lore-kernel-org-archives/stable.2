Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6544A2614;
	Thu, 17 Sep 2026 11:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642926; cv=none; b=C2viSQWFrzjk6/XqnHPIy5UN8FJ3pmsTdnA1vqn+UiqxdldcrUrUkF9vgmuSSaEWsyPGP+Yl7SqQ8ZgzqA8ruCg9D/zNI9acvYn7yYRNIl+Cdq4IQ0p2iqaq3dNqmPN1kt/i9rYjUX1cjPzsJWWLEXiFtOpilBjgOvD3p3wTUXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642926; c=relaxed/simple;
	bh=Vdh6G9QbhTxH9886kt/N/CrIqDOp+Vquw7Go2R1qECM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aOINlWKhex4DOkV5b56hN0wZK2zdCLVLwfUaYVNhe5YVAyiqpC09PWEaqhmmVdPavB8tYLAwNTBsLHuHSqwQPBnZui4sbr9FHLBnulx6ECM6q1XdSMfpzKmVVRnDHL8H3Obg3mBerNhPusLdc2bJUHMuClq346rXkNTNQ3COvSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADnF0KPyKtq7yJ_CA--.1333S2;
	Thu, 17 Sep 2026 19:01:35 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	igal.liberman@freescale.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	madalin.bucur@nxp.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sean.anderson@linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fsl/fman: Fix clk reference leak in read_dts_node()
Date: Thu, 17 Sep 2026 11:01:35 +0000
Message-Id: <20260917110135.2148068-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnF0KPyKtq7yJ_CA--.1333S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF1xWF1fKr13Xw4rGr15Jwb_yoWkJwc_ur
	1xWFyrW3yUAFy7t3W5KrsxZ3sIkr1DZw48tasFy3y5KFyDJrnxur1xArZ5CFy3Za1IkF98
	Xrnxt34xA34ayjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbgkYjsxI4VWkKwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0E0s8F02x267IIx4CEVc8vx2IErcIFxwAC
	I402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrw
	CF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuY
	vjxUqdHjUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgINA2qrq3Zj9AAAsB

of_clk_get() returns a clock with its reference count incremented, but
read_dts_node() only uses it to read the rate and never calls clk_put().
The clock is not stored anywhere, so the reference cannot be released
later either.

Release the clock once its rate has been read, which also covers the
error path taken when the rate is zero.

Fixes: 414fd46e7762 ("fsl/fman: Add FMan support")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/freescale/fman/fman.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index 013273a2de32..0f342b1a845b 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -2732,6 +2732,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	}
 
 	clk_rate = clk_get_rate(clk);
+	clk_put(clk);
 	if (!clk_rate) {
 		err = -EINVAL;
 		dev_err(&of_dev->dev, "%s: Failed to determine FM%d clock rate\n",
-- 
2.34.1

