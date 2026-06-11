Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283FD22A4E1;
	Thu, 11 Jun 2026 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185613; cv=none; b=SAoJsl/05Bz+7NLuFEHL7Co0ooG5OuG1X6wrgqUSUAmeB5XfBJcqtIwcEE7e1AZx2aIRSMZLeFvB4trKIQKekltCA3S6sJawjm4enQIWhIYY6V3WE+oiUi2s14ErMx4IUIsn9ScE6grcSLOzw6gpmXDen4TAlPP9t5jtOYcL2ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185613; c=relaxed/simple;
	bh=FSGTK0158Q5I2R/ujj63HFCVqCSXUlfbvZo1oONQnVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jRVt+vBq+t/RS6EyFx7Rmmjxxh1Pp+4jdSXb03zJ2b9u+SftAJBacrkMeo1nuExcIHOG8dHns7gw3gmCMLW3zi35r1TvKTUaxrVZYXSfrt0+dc71nhX4ojxLAiKmXOjKj9VYthhv8zRmt0eAIrJF+b4XgG076PrQqjXIzvN+DD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-05 (Coremail) with SMTP id zQCowAB3zhFDvCpq4OEWEw--.736S2;
	Thu, 11 Jun 2026 21:46:45 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: gregkh@linuxfoundation.org
Cc: vulab@iscas.ac.cn,
	oneukum@suse.com,
	kees@kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] usb: misc: fix refcount leak in get_1284_register()
Date: Thu, 11 Jun 2026 21:46:41 +0800
Message-ID: <20260611134641.84658-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3zhFDvCpq4OEWEw--.736S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kry5uF4UWrW3uw4rAFy3twb_yoW8Jw18pr
	42k34jkFW5Xa1Ikw4UJFnYvFW0ya12yrWfGFWIy3s5ur13JayDur1jq34q9F13Cr4kJ3sx
	tr1qqF15XayDXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUf8nOUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAgPA2oqh3ikuQAAsq

In get_1284_register(), submit_async_request() returns an
"rq" object with a caller's reference. If the subsequent
wait_for_completion_timeout() times out, the error path
calls kill_all_async_requests_priv() to cancel pending
URBs, but it fails to drop that caller's reference. All
other paths (early exit on !val and the successful
completion path) correctly call kref_put() to release the
reference. This leak results in the memory allocated for
the request never being freed.

Fix the timeout path by adding the missing kref_put() call
before returning -EIO.

Cc: stable@vger.kernel.org
Fixes: 0f36163d3abe ("[PATCH] usb: fix uss720 schedule with interrupts off")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/usb/misc/uss720.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/misc/uss720.c b/drivers/usb/misc/uss720.c
index e1eba3cbef0a..ca97d77cfe2e 100644
--- a/drivers/usb/misc/uss720.c
+++ b/drivers/usb/misc/uss720.c
@@ -223,6 +223,7 @@ static int get_1284_register(struct parport *pp, unsigned char reg, unsigned cha
 	}
 	printk(KERN_WARNING "get_1284_register timeout\n");
 	kill_all_async_requests_priv(priv);
+	kref_put(&rq->ref_count, destroy_async);
 	return -EIO;
 }
 
-- 
2.50.1 (Apple Git-155)

