Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695053;
	b=W6nego3c1GmsIl8JdMkU2/ogAf1v2FQsqAYt0vp3Sa/iiv7c71WMgeIvvNmrNZSSwVmX
	 xOwxxqPavQM7qYunSsmMlqzoDbWwfIM2Kg5+y0uOzkq+r7emMTe8iqXFuler5GJ8/uSqz
	 uQbKRxlzEFN0JBGGgWqWtgNWydwmf5hHj0H6wxANmk00/vKrZBV1BN9h0daXvhz6uQCWw
	 Rnwyty9oUgPHa8Wmk3fc2/xeHBZZ0Lrk6FYgMbDTglqunnSIKSdca0OC+2jjQ81YbOnYp
	 tssC6Hx6FdOkJqkWabawKR7zXoWjYkZR7O0KJ3PBu9ephvTkpfCdxYag/1LnePavE8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695053;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=I5C/I1Ny4wRL8l6oEnWPJ+zAmm2uMIIbu9aC+PVzetE=;
	b=r4zstrJufP+ucIyLtRkeRSODWR468HpEUx8K4O4DLiR8FMk/U5paHnJe7i2kf2jnpYuP
	 uYoakkdS1RomZM81LgKgycLMQ8wyRlmboHt1xwKllp7f2Q/4vPYZNlVhga27uOi6QKMjV
	 k/BGodx1vNEexnevWttCrJOzniD5NE9vX4OBbpW+3iBOjYC6L8hSqPV8tOV7VpD11V1ew
	 gyIS4usNnuHYRk8g5zLQpGufIlQSRdFPte+5MHv/+TqMK8JXmQ71CI01eczOxxrD5vyez
	 FQxIrp3RceC9cRN5fDQXfH5AB5Sfvnklx40XNR5qFuhaGIYMFS2BEQJncAxMRUm6oMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231A5606EE8C;
	Tue,  3 Nov 2026 08:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 231A5606EE8C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACXoZJJnelq9Io6AA--.1832S2;
	Tue, 03 Nov 2026 16:37:29 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: hverkuil@kernel.org,
	mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: saa7146: hexium_orion: Unwind failed attachment
Date: Tue,  3 Nov 2026 08:37:38 +0000
Message-Id: <20261103083738.1180466-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:rQCowACXoZJJnelq9Io6AA--.1832S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4rZrWkZFyfurWxZw1fZwb_yoW8KF1kpa
	93W3Z5trW8Gw47u3W7XF4UuFyrGrWfKay5Was8J3WavrnrCr1qg3s8ta48tFyDJayDJ3WY
	v34j9w1UWrs5AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUrv
	38UUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAEAA2rpWwr-jQABsv

hexium_probe() registers an I2C adapter and stores the allocated private
data in dev->ext_priv. If hexium_attach() then fails to initialize the VV
layer or register the video device, the core frees its own resources
without calling the extension's detach callback.

Release the I2C adapter and private data on both attachment failures, and
release the VV layer when video registration fails after successful VV
initialization. Clear the private pointer and return the actual video
registration error. This follows the cleanup already used for video
registration failure by the sibling Hexium Gemini driver.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/media/pci/saa7146/hexium_orion.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/media/pci/saa7146/hexium_orion.c b/drivers/media/pci/saa7146/hexium_orion.c
index 8ef2a4e8235d..95b3efee33ac 100644
--- a/drivers/media/pci/saa7146/hexium_orion.c
+++ b/drivers/media/pci/saa7146/hexium_orion.c
@@ -363,15 +363,16 @@ static int hexium_attach(struct saa7146_dev *dev, struct saa7146_pci_extension_d
 	ret = saa7146_vv_init(dev, &vv_data);
 	if (ret) {
 		pr_err("Error in saa7146_vv_init()\n");
-		return ret;
+		goto err_i2c;
 	}
 
 	vv_data.vid_ops.vidioc_enum_input = vidioc_enum_input;
 	vv_data.vid_ops.vidioc_g_input = vidioc_g_input;
 	vv_data.vid_ops.vidioc_s_input = vidioc_s_input;
-	if (0 != saa7146_register_device(&hexium->video_dev, dev, "hexium orion", VFL_TYPE_VIDEO)) {
+	ret = saa7146_register_device(&hexium->video_dev, dev, "hexium orion", VFL_TYPE_VIDEO);
+	if (ret) {
 		pr_err("cannot register capture v4l2 device. skipping.\n");
-		return -1;
+		goto err_vv;
 	}
 
 	pr_err("found 'hexium orion' frame grabber-%d\n", hexium_num);
@@ -383,6 +384,14 @@ static int hexium_attach(struct saa7146_dev *dev, struct saa7146_pci_extension_d
 	hexium_set_input(hexium, 0);
 
 	return 0;
+
+err_vv:
+	saa7146_vv_release(dev);
+err_i2c:
+	i2c_del_adapter(&hexium->i2c_adapter);
+	kfree(hexium);
+	dev->ext_priv = NULL;
+	return ret;
 }
 
 static int hexium_detach(struct saa7146_dev *dev)
-- 
2.34.1

