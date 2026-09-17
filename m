Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66454A689C;
	Thu, 17 Sep 2026 11:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789645906; cv=none; b=IiXuSFxN9lgo8llLUu8T7UZABNJzSstWn9ELQAZ4CLUuypOS9vtjL1iH7FCB701ApMZrt/+cTELGY4TLsVFgvX6otwmyNcBJE2TC7wwQ7LMV9pJIWVLpF+MLs3Zm+FVp+H8wpOH72g33fdR6mDY61dJsgoxA6pWr4ofzO4QL1jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789645906; c=relaxed/simple;
	bh=y0zIWceyARVSC+NIQxIkdL+BIbmRbrf0fef63/sFYe0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gr54RLg/5jK2yBCD4zPnj9Hl/5oyJJsJLVu088myqvScuUgxljMaoLxiGr/YydBLZd93NCe6x1XxZXqKYnuQax8CJqBrVSHqf0LGXy/1rrPfd/xCGlvSa0d9TqlBL29yx1ND6TShCQdGMWWc66BPsE7TY/g9CmMYxkE4fMvaDdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAC36EIz1KtqOet_CA--.2137S2;
	Thu, 17 Sep 2026 19:51:15 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	elder@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: ipa: Fix runtime PM reference leak in ipa_remove()
Date: Thu, 17 Sep 2026 11:51:15 +0000
Message-Id: <20260917115115.2149796-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC36EIz1KtqOet_CA--.2137S2
X-Coremail-Antispam: 1UD129KBjvdXoWrurW7CFyxAw18trWDZryUGFg_yoWfuFb_Kr
	15WrZ7Xr4kCr4vkF4UtFs8urZIvF1DW34IqF4Iv3yfK3yUAw15XryUZr90yw4UurZxAr98
	AFnxGFyxu34fZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbgkYjsxI4VWkCwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0E0s8F02x267IIx4CEVc8vx2IErcIFxwAC
	I402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrw
	CF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuY
	vjxU25EfUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgENA2qrq3Z+vgACsX

ipa_remove() takes a runtime PM reference with pm_runtime_get_sync() and
is supposed to release it at the out_power_put label. If the modem fails
to stop, the function returns early and never drops that reference, so
the device usage counter stays elevated forever. Release the reference
before returning.

Fixes: cdf2e9419dd9 ("soc: qcom: ipa: main code")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ipa/ipa_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 788dd99af2a4..aab38fea91c6 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -975,6 +975,7 @@ static void ipa_remove(struct platform_device *pdev)
 			 */
 			dev_err(dev, "Failed to stop modem (%pe), leaking resources\n",
 				ERR_PTR(ret));
+			pm_runtime_put_noidle(dev);
 			return;
 		}
 
-- 
2.34.1

