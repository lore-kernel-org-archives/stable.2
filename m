Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9864A2A5D;
	Thu, 17 Sep 2026 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641999; cv=none; b=jWijtrqL6w6F6JU5sOWr6sbnG5/4sRHyMTHKj0aiq5wI6t83PEr4KxX6jltF9IYBOjbfLxN4JzkombNKLfkolG8JiaXs0wMtdBgRl2DISU6RtV6jSMU8c0B/1j27dZ0ds6ryHBr5nflByPQGIzwg+QRZ8UdkEPNxG/SxTyeKjIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641999; c=relaxed/simple;
	bh=2brjDjMOz3c8GylXr4aOle6WPQccQEH3lob9orL+4yU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f8ssJoE6hjlQPZZCDolSO+s2JBNGqZqRmv7Y3jztu6rPlGk0iBdMpx6D+PL4q8eeVT+K54O6Qxi00As6vdubKA5iQLMyYbVkMrlUZAUEuqxqZ8cEFH4MCwblD/kJm3V12DsvLSnDNXQgrxsAuLIUfyCVN8pAZRlU+17g5qWysww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACH8z0FxatqGOl+CA--.1032S2;
	Thu, 17 Sep 2026 18:46:29 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrew@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	f.fainelli@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	olteanv@gmail.com,
	pabeni@redhat.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: dsa: dsa_loop: Fix netdev leak in dsa_loop_drv_probe()
Date: Thu, 17 Sep 2026 10:46:29 +0000
Message-Id: <20260917104629.2147418-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACH8z0FxatqGOl+CA--.1032S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw4ftw1xWr4UuF4UWFW3KFg_yoWDWrX_C3
	Z7XF9rZr1kGayUKr4vkr4Svry5Cas7Wr4xXan3tFsxG3yUWry3JFWDZanxJrnrW3yUAFy3
	C3W7urW3u343GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbgxYjsxI4VWDJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0E0s8F02x267IIx4CEVc8vx2IErcIFxwAC
	I402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrw
	CF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x
	07jb5rcUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgYNA2qrq3ZagQAAsJ

In dsa_loop_drv_probe(), a reference to the configured network device
is taken with dev_get_by_name().  This reference is dropped in
dsa_loop_drv_remove() on success, but if dsa_register_switch() fails,
the probe returns without releasing it, leaking the reference.

Fix this by dropping the reference with dev_put() when
dsa_register_switch() fails.

Fixes: 98cd1552ea27 ("net: dsa: Mock-up driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/dsa/dsa_loop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/dsa_loop.c b/drivers/net/dsa/dsa_loop.c
index 7058faf23592..b6b6fcffb406 100644
--- a/drivers/net/dsa/dsa_loop.c
+++ b/drivers/net/dsa/dsa_loop.c
@@ -389,6 +389,8 @@ static int dsa_loop_drv_probe(struct mdio_device *mdiodev)
 	if (!ret)
 		dev_info(&mdiodev->dev, "%s: 0x%0x\n",
 			 pdata->name, pdata->enabled_ports);
+	else
+		dev_put(ps->netdev);
 
 	return ret;
 }
-- 
2.34.1

