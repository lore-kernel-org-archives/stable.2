Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E12D49B468;
	Wed, 16 Sep 2026 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573981; cv=none; b=MaKm4N7MiFCyLCGoca8r0IRr2EO50mI89J56NFS1Cvio5WOc8Q9zI6VcpRBCHZ+2tX0AeKnT36P8EHSArWPnofVzJkN9iJnNkA7lL4jlG44AFpYyyaOoO7dO4PpaVVTNr0YlWdk4E6K9p7ahUOnIZxokcNE7I0K99D6hEG3Qm+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573981; c=relaxed/simple;
	bh=BM+h7cppDDvozEPiXX6BYGD/KcFCnuavtNYdswOQxhU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DgU0eLsABzqFyAB9j8KRppRVwjhMfqaG6eEzpzKBnO2X3s5NOkulBet1ZDwUigSUKLcnjgX8IFETqgBitgriyD+jyWUDzbBESe7gR7ItA4H5m3XFNBRLAykq7Kvh73yUkGnVc0QyHFNIpcmw0FkhKptmJQWf66HZbfUp+I7y43I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACH7zlPu6pqqCttCA--.21450S2;
	Wed, 16 Sep 2026 23:52:47 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	mperttunen@nvidia.com,
	simona@ffwll.ch,
	thierry.reding@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] gpu: host1x: Fix of_node reference leak in host1x_device_add()
Date: Wed, 16 Sep 2026 15:52:19 +0000
Message-Id: <20260916155219.2071989-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACH7zlPu6pqqCttCA--.21450S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1UGrWrCr1fCF13uF4fGrg_yoW8XrykpF
	Z8tFyYyrWDWF47Kw4jyF1UuFy3Kw1jk3yfKFyrJw13Kr4fJr9YqrykKFWUA34UWrW7GFnF
	qF4jkr1rA345Cw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j
	6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjfUrr
	WFUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgEMA2qqok9B8gAAsW

When host1x_device_parse_dt() fails, host1x_device_add() only frees the
host1x_device and leaves the subdevs collected by host1x_subdev_add()
on device->subdevs. Each of those subdevs still holds an OF node
reference acquired with of_node_get(), which is normally dropped by
host1x_subdev_del().

Remove all stale subdevs, dropping their device node references, before
freeing the device.

Fixes: 776dc3840367 ("drm/tegra: Move subdevice infrastructure to host1x")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/host1x/bus.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index f814eb4941c0..8dbab96b7f5a 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -455,7 +455,7 @@ static int host1x_device_add(struct host1x *host1x,
 			     struct host1x_driver *driver)
 {
 	struct host1x_client *client, *tmp;
-	struct host1x_subdev *subdev;
+	struct host1x_subdev *subdev, *sd;
 	struct host1x_device *device;
 	int err;
 
@@ -485,6 +485,10 @@ static int host1x_device_add(struct host1x *host1x,
 
 	err = host1x_device_parse_dt(device, driver);
 	if (err < 0) {
+		mutex_lock(&device->subdevs_lock);
+		list_for_each_entry_safe(subdev, sd, &device->subdevs, list)
+			host1x_subdev_del(subdev);
+		mutex_unlock(&device->subdevs_lock);
 		kfree(device);
 		return err;
 	}
-- 
2.34.1

