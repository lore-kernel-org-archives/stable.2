Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F75BA3D;
	Thu, 17 Sep 2026 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643269; cv=none; b=OzAZKpBXjm8b3xWyb2CSEvi5WrqX01ALPAZExhSY3461T9lYpbNorwBk0AuY0GuS7IOJ3TFQJCsJPVeQH4MAu22sjrUtB+ZeXhQfwCEHwQAdGtFvwsFCMvsmDSI0LAVYg8HmVnjEPcfY3hN83SbRYy43YHtaBgNC2J/BcrxBkSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643269; c=relaxed/simple;
	bh=rh5a/xrkjMQ8R9J+gFpOo9G7XPrF9Jo5F2+53VKN1sc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PsBUH4uvfwJwtd2N+YSJNtbyafQ9H8KTaZCxPq4qOzPUEivM/bxEGID/QWogspUmz1YxyiCoZ8wNUZ3VxCqVmA7hppudZfm37YIaSngKOXnlpEYladaAZLF32fDpmP8/h1osmYDu82q18IbFFLAFTnU4LpeQIe6kA8V65iMIek0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADH+ELuyatqfTp_CA--.42284S2;
	Thu, 17 Sep 2026 19:07:27 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linmq006@gmail.com,
	linux-kernel@vger.kernel.org,
	madalin.bucur@nxp.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sean.anderson@linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fsl/fman: Fix fm_pdev reference leak in fman_port_probe()
Date: Thu, 17 Sep 2026 11:07:26 +0000
Message-Id: <20260917110726.2148318-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADH+ELuyatqfTp_CA--.42284S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr4DtrWDJr4kuw45CFWrAFb_yoWDXFgEkw
	1rZ3W7XrWUtr92qw1Ykwsxur9FkF1qqrZ3XanrKa98GasrJrsxWrW7uws3CFnxua1xuF98
	Wr17uayay34YgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbgkYjsxI4VWkCwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
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
	vjxU7WE_DUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgANA2qrq3Zn1AAAsn

of_find_device_by_node() takes a reference on the FMan device. It is
released on the error paths, but the successful path returns without
dropping it, leaking the reference.

Release the reference when it is not needed anymore.

Fixes: bf2b09fedc17 ("fsl/fman: Fix missing put_device() call in fman_port_probe")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/freescale/fman/fman_port.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fman/fman_port.c b/drivers/net/ethernet/freescale/fman/fman_port.c
index 1b8fef69114e..f44a89016512 100644
--- a/drivers/net/ethernet/freescale/fman/fman_port.c
+++ b/drivers/net/ethernet/freescale/fman/fman_port.c
@@ -1868,6 +1868,8 @@ static int fman_port_probe(struct platform_device *of_dev)
 
 	dev_set_drvdata(&of_dev->dev, port);
 
+	put_device(&fm_pdev->dev);
+
 	return 0;
 
 put_device:
-- 
2.34.1

