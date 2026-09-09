Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3472B44A3EC;
	Wed,  9 Sep 2026 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941697; cv=none; b=Cf6DSpn7BqgU8mL8CzjSPSmn4L4ymPZ+4vWrsI8WSh+klDRr3htdBaNPw1ytOY3hgwoeA5qhD4w6MMpXSbouuprjMOvahM5K289efPgeP1jlRruhK/757j20weOQQrKOVaegsZEMJQeQgt+TFx+aJIsj/7sx62VWTiwIbCkkmK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941697; c=relaxed/simple;
	bh=Fa4pUNoSdbQfDXZLUvClkEdaf9jTtFUz9PAiYriOhXM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ahRYypmx7bvKjDmCCr3ZxeSpM0kPfOx1XsApqMVwvMFyaXWc/MsoGH2UnXS3DkRyrRnIGQl54+CORCvL4pbhQurvnMK9+02U7woYIQMhWYgvo7WLZglxiYudFiDx7LXVZhplRValkw0NbJ3pBnKcvggsbz0H8wz/7OCn0XVMCgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wBnIn1tFaFqrYsCAQ--.8187S3;
	Wed, 09 Sep 2026 16:14:38 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgCH9cptFaFqRxhmBA--.32691S2;
	Wed, 09 Sep 2026 16:14:37 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linux-media@vger.kernel.org
Cc: Hans Verkuil <hverkuil@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Dorcas Anono Litunya <anonolitunya@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] media: vivid: cancel svid ctrl work on release
Date: Wed,  9 Sep 2026 08:13:41 +0000
Message-Id: <20260909081341.685686-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgCH9cptFaFqRxhmBA--.32691S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?fuMh6QXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI0K0AVGxL4zBOVAPaWNLeCivAi5QntNhyVtvq7f9umBJhXl
	WO4yOpNiT2sFnfWodlqp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxJryUGFW5uw18AF13Kw47KFX_yoW8Cw4fp3
	98GFy3CFZrXF4YvF4DJry7KFyruw1SyayIgry7Z3Z5Wr93AFy5Cw17KFy0yF4UAr9IyFW2
	yrsIq39xuFWrJrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU86c_DUUUUU==

vivid_dev_release() cancels update_hdmi_ctrl_work but not its sibling
update_svid_ctrl_work, which vivid_vid_cap_s_ctrl() queues on
update_svid_ctrls_workqueue when a VIVID_CID_SVID_IS_CONNECTED_TO_OUTPUT
control is changed. The two work items were added together, but only
one of them is cancelled on release.

If the svid work is still pending or running when the last v4l2_device
reference is dropped, update_svid_ctrls_work_handler() runs after
kfree(dev): the handler iterates the global vivid_devs[] array and
calls v4l2_ctrl_modify_range() on every vivid_dev instance, including
this one after it has been freed.

Add the missing cancel_work_sync() next to the hdmi sibling, before
vivid_free_controls() releases the control handlers the work uses.

This issue was found by an in-house static analysis tool.

Fixes: d7c969f37515 ("media: vivid: Add 'Is Connected To' menu controls")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/media/test-drivers/vivid/vivid-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/test-drivers/vivid/vivid-core.c b/drivers/media/test-drivers/vivid/vivid-core.c
index 62cfb5feb2cf..c042d92db175 100644
--- a/drivers/media/test-drivers/vivid/vivid-core.c
+++ b/drivers/media/test-drivers/vivid/vivid-core.c
@@ -854,6 +854,7 @@ static void vivid_dev_release(struct v4l2_device *v4l2_dev)
 	struct vivid_dev *dev = container_of(v4l2_dev, struct vivid_dev, v4l2_dev);
 
 	cancel_work_sync(&dev->update_hdmi_ctrl_work);
+	cancel_work_sync(&dev->update_svid_ctrl_work);
 	vivid_free_controls(dev);
 	v4l2_device_unregister(&dev->v4l2_dev);
 #ifdef CONFIG_MEDIA_CONTROLLER
-- 
2.39.5

