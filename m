Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE35450413;
	Wed, 16 Sep 2026 07:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544343; cv=none; b=J7NP2PVWrMgX+n/2p4KNuWatiIsNNei+Ma9jrNf/zaEB+I9wl+8qFI4WDp5koLXNwIsRJwHjOWUHPm8k0/4tIpTDQAI3MFrbdT8tULXDKVGUgf95RaUMpkNkrMFMl8nWN6aSTFhnuJgDgGRg2AEj6g3YZzY/kSxs++66MJS3fH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544343; c=relaxed/simple;
	bh=j9ktKFtpbgo4VcDmddQSyAsXK/V4CRdYlVuga/agvto=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ke353KD5XZilFPXJhjY4nDiSc3ZcArPxYe0eKNtE4XPDcErZUd/Ie3hEdbPpnjamcshaJtIvcanbSWIdzkjx51D7jZY/qEgbYYjqUvGUSK5UAC/tVABVTySAgoblrUXNVAnX5bDb1tJHjXA/cPXES1hRCeTVf+DKYo8Gq4LLPDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACXnz2DR6pqrznfBw--.40767S2;
	Wed, 16 Sep 2026 15:38:43 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: alexander.deucher@amd.com
Cc: dri-devel@lists.freedesktop.org,
	javierm@redhat.com,
	linux-kernel@vger.kernel.org,
	tzimmermann@suse.de,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] firmware/sysfb: Fix device reference count leak in sysfb_disable()
Date: Wed, 16 Sep 2026 07:38:15 +0000
Message-Id: <20260916073815.1972045-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXnz2DR6pqrznfBw--.40767S2
X-Coremail-Antispam: 1UD129KBjvJXoWrKryxJF13WFy3Kw4rCw47twb_yoW8JrWDpr
	s3GFWFyrW5XF409ayUJF1jqF1Fqa98tayxG3s3Cas5u3Z8AF109ry8J3W8WF1UArWkGa4S
	qF43tr18uF4UCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUrF
	ApUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwcMA2qqQJUe-gAAs6

In sysfb_disable(), parent is obtained via sysfb_parent_dev(si), which
calls screen_info_pci_dev(si) and returns a pointer to &pdev->dev with
an acquired reference count. However, sysfb_disable() does not release
this reference before returning, leading to a device reference leak.

Fix this by checking if parent is not an ERR_PTR and calling
put_device(parent) before releasing the mutex.

Fixes: b49420d6a1ae ("video/aperture: optionally match the device in sysfb_disable()")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/firmware/sysfb.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
index 8833582c1883..11c5ce128a6c 100644
--- a/drivers/firmware/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -71,9 +71,12 @@ void sysfb_disable(struct device *dev)
 
 	mutex_lock(&disable_lock);
 	parent = sysfb_parent_dev(si);
-	if (!dev || !parent || dev == parent) {
-		sysfb_unregister();
-		disabled = true;
+	if (!IS_ERR(parent)) {
+		if (!dev || !parent || dev == parent) {
+			sysfb_unregister();
+			disabled = true;
+		}
+		put_device(parent);
 	}
 	mutex_unlock(&disable_lock);
 }
-- 
2.34.1

