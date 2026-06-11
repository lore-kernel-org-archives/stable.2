Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F3730F819;
	Thu, 11 Jun 2026 13:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184604; cv=none; b=DH1zCmYsjdRicNmw8970TsxLgSkgCa3xZOm9iG8RKUzFCJvjhBcuS9h4DPV9bnb9OdHFeZZLY3fd5tUMz07og2YujADYU4ro64cLTu24ZzAFU2ghpNdk8P0AMOdHETP5OsuTJC6eNIQYmuF0Rz5/Vd6aqamKwTgwHfYACMmaW14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184604; c=relaxed/simple;
	bh=RHN3ZvGmE/NFe/R3w9D5eZ2rXHHGsjHgmU60jcHXJTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P6Kzxo8XfSegZbbvAGJhKJwk9OzK9zxAx44KP7x6rR1rLzxwSYEKwxXob7WruJdRmqOmgF3g0Wi7jLBE2qfRykBshpkgcUPiQ896ADVsC2TiwONY0I3ipx9yx0XbNEr5Pg4EsfSoBmjVtpt554gmc/F6mNa6zEylouq+3QAxsCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-05 (Coremail) with SMTP id zQCowAC3Gt5SuCpqYpoWEw--.628S2;
	Thu, 11 Jun 2026 21:29:56 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: gregkh@linuxfoundation.org
Cc: kees@kernel.org,
	oneukum@suse.com,
	vulab@iscas.ac.cn,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] USB: misc: uss720: fix refcount leak in submit_async_request()
Date: Thu, 11 Jun 2026 21:29:52 +0800
Message-ID: <20260611132952.83931-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3Gt5SuCpqYpoWEw--.628S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWrWF48Gw47uw4fur1Dtrb_yoW8GFWDpF
	4fG3yjkry5Xa1Sga17Jws5ZayFyanayryfGa9IkwnxZryfXaykC3W5Wayjkr9xAr4kJ347
	tF4DJa13Ja4j9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUvXd8UUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ4PA2oqh4WYdgAAsn

When submit_async_request()'s call to usb_submit_urb() fails, the
error path directly calls destroy_async() on the request structure
instead of kref_put(). This bypasses the reference counting mechanism
because the kref is initialized to 1 and the preceding kref_get()
increments it to 2. The callback function async_complete() will never
run in this case, so the reference acquired by kref_get() is leaked,
and the structure is freed while still holding two references.

Fix by replacing destroy_async() with kref_put() in the failure
branch, properly releasing the extra reference.

Cc: stable@vger.kernel.org
Fixes: adaa3c6342b2 ("USB: uss720 fixup refcount position")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/usb/misc/uss720.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/misc/uss720.c b/drivers/usb/misc/uss720.c
index b7d3c44b970e..e1eba3cbef0a 100644
--- a/drivers/usb/misc/uss720.c
+++ b/drivers/usb/misc/uss720.c
@@ -168,7 +168,7 @@ static struct uss720_async_request *submit_async_request(struct parport_uss720_p
 	ret = usb_submit_urb(rq->urb, mem_flags);
 	if (!ret)
 		return rq;
-	destroy_async(&rq->ref_count);
+	kref_put(&rq->ref_count, destroy_async);
 	dev_err(&usbdev->dev, "submit_async_request submit_urb failed with %d\n", ret);
 	return NULL;
 }
-- 
2.50.1 (Apple Git-155)

