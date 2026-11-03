Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701749;
	b=qqiO8BcsP8a6ma4l6hY1AQTwknFXB8vCAU/ketQefTMxnrpmcSOrUQl8syaGaEOFzkAJ
	 oVlJkHeJZOy0JiHc6g9GcP2SD9KPjtPvibHH92Ja9O4E4OupNFUej94Zd9Q3i1AskH8JX
	 9/+WAl0YhNV5UCzKz1lJ3wlMgUlWUXGhl935hSfie2IkPg+eMTFNkPiVmE2TSu3PahC8R
	 SjwcRr8l4G8PxRtAVuRQImqswdu86Zcb8K1oXTksdpMhTfjwCDcWkI6PHilWRXSO8RCwt
	 Ls4U5mxeSnEhK3bMAhgWzm4aCtTHxrU07X5zEKr5Zlsw/h3XBWlUWaT236xVjC09E+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701749;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=lS8HPnWp/ZiXusc6VF2DVeURTql02ont/sKJfBhomm8=;
	b=ShsbazpuKHZraVXLIsZ/8iVKDbdwT9504lizvLRrlB0rvsSgP8EmYrVY/vL90lr5FH+g
	 6syk+ITbqd0Cz/hvWgJ1KPLvWUSHPuK+eSrwHkC5GAQkDNhJGZf+cUF+DsGau/FK+02ki
	 543Q4qcm9bYIw6IPI2KXQuDb1AVr5NTwbRzFy38Dw64GbgM5wGPU7u9vrD7G9C04i/ua7
	 vyOPwjbYfcav2NnT3yOP3m9nJ8EpX0sDQR+hTMC3vahUX+Rb5EMlYz5B8mqjqTn4+0GMk
	 JaETgi88+QAaDJppZrDcVM4r4wxnTDqohR2qpHDCRNx1DrslBsuBYh3p7kIYjMgzR1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AE86078499;
	Tue,  3 Nov 2026 10:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0AE86078499
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACXoZJyt+lqWao7AA--.3025S2;
	Tue, 03 Nov 2026 18:29:06 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] wifi: ath11k: release the rproc reference on teardown
Date: Tue,  3 Nov 2026 10:29:15 +0000
Message-Id: <20261103102915.1341148-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowACXoZJyt+lqWao7AA--.3025S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrW8XF43Cw17Xr4rJr45Awb_yoW8trW7pF
	Z7W3yDKFZ8Ca1xtw4kXr48Z3WxZ3W3t3y3WrW3K3s3ZwnxJFyUt3W5XFyjqryYkry8GF1a
	vFWay3yUuFyqy3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWx
	JVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7VU1
	SksDUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwYAA2rpnO5vkQABsM

ath11k_core_get_rproc() looks up the target remoteproc with
rproc_get_by_phandle(), which takes a device reference and a reference on
the remoteproc driver's module.  The resulting pointer is stored in
ab_ahb->tgt_rproc and never released: ath11k_ahb_free_resources() only
tears down the firmware resources, and the probe error paths after the
lookup jump to err_core_free without dropping the reference either.
rproc_shutdown() does not release it, it only drops the power reference.

Release the reference when the AHB resources are freed and on the probe
error path, so that repeated bind/unbind cycles no longer accumulate
remoteproc references and the remoteproc module can be unloaded again.

Fixes: ba929d6fe31a ("ath11k: Remove rproc references from common core layer")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 27d01411b6e9..cc93ca22d3ff 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -852,6 +852,16 @@ static int ath11k_core_get_rproc(struct ath11k_base *ab)
 	return 0;
 }
 
+static void ath11k_core_put_rproc(struct ath11k_base *ab)
+{
+	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
+
+	if (ab_ahb->tgt_rproc) {
+		rproc_put(ab_ahb->tgt_rproc);
+		ab_ahb->tgt_rproc = NULL;
+	}
+}
+
 static int ath11k_ahb_setup_msi_resources(struct ath11k_base *ab)
 {
 	struct platform_device *pdev = ab->pdev;
@@ -1262,6 +1272,7 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 	ath11k_ahb_ce_unmap(ab);
 
 err_core_free:
+	ath11k_core_put_rproc(ab);
 	ath11k_core_free(ab);
 	platform_set_drvdata(pdev, NULL);
 
@@ -1295,6 +1306,7 @@ static void ath11k_ahb_free_resources(struct ath11k_base *ab)
 	ath11k_ce_free_pipes(ab);
 	ath11k_ahb_ce_unmap(ab);
 
+	ath11k_core_put_rproc(ab);
 	ath11k_core_free(ab);
 	platform_set_drvdata(pdev, NULL);
 }
-- 
2.34.1

