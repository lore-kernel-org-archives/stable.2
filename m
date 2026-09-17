Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1054FDE64;
	Thu, 17 Sep 2026 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649118; cv=none; b=lDS1cdlGNgs5ktitRHYpBIK83r6pASaI3YNcakHtxy4RNADo4jQ764wq0dl/1hinoM1qjOdDw2P8XOuv9d8ZuatCUMKnTJPCxo8WAYR2bXGMsmbYQNvLTZMK0w29QrVDVCdiF+bhJRqflk/oIuu5tllQKzWhHy6LuQMAnO9K2nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649118; c=relaxed/simple;
	bh=I40Tzk0p7smuBh26kyBzbuLG5wZp44quXhtFhQ4vyAE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HnTlwNTIwLO612OgcUeQNHQL/GP1UAmBFYCFGvTEwJo0Y+v66e0JukCLe4+88Ry8F+qyGeeGmzVvC8qZLQpZ//MI/s8QH3sXUFxWrvQP11EHX7fhBbihKdI/3yr7tTiquveM9nwX39rzZhBOLR7/1qs2h6w1Ndb6R2TKZtkNi9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADnVD_J4KtqzceACA--.3029S2;
	Thu, 17 Sep 2026 20:44:57 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: devicetree@vger.kernel.org
Cc: frowand.list@gmail.com,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	saravanak@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] of: unittest: Fix overlay node reference leak in of_notify()
Date: Thu, 17 Sep 2026 12:44:57 +0000
Message-Id: <20260917124457.2151809-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnVD_J4KtqzceACA--.3029S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr1Dur18Zr45XFW3Cw15Arb_yoWDWFcEka
	s29ws3WFW0kF1YkrZ3JryfZFnFv3WUurWxuF1jvanxC3y2vry7Xr1Y9345A3y5Zay3tF9r
	Kr1DuF1YkrnFqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbS8YjsxI4VW3JwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7MxkF
	7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr
	1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6x
	kF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07j5CzZUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwcNA2qrrRmeCgAAsv

of_notify() takes a reference on nd->overlay but only drops it in the
default branch of the action switch. The PRE_APPLY, POST_APPLY,
PRE_REMOVE and POST_REMOVE branches return without dropping it, so the
reference is leaked on every notification. Move the of_node_put() to the
common exit path.

Fixes: 992b0dc5c38a ("of: overlay: unittest: add tests for overlay notifiers")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/of/unittest.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index c4d4c10ceaa2..5259c45e355d 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -3429,11 +3429,12 @@ static int of_notify(struct notifier_block *nb, unsigned long action,
 		break;
 
 	default:			/* should not happen */
-		of_node_put(nd->overlay);
 		ret = -EINVAL;
 		break;
 	}
 
+	of_node_put(nd->overlay);
+
 	if (ret)
 		return notifier_from_errno(ret);
 
-- 
2.34.1

